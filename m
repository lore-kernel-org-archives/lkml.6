Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4901EC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057E42147D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWlez8Qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057E42147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391823AbeHPRVc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 13:21:32 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42386 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391810AbeHPRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 13:21:30 -0400
Received: by mail-oi0-f68.google.com with SMTP id b16-v6so8291998oic.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 07:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4pzI73aVQK34I0le6F39OSJR6QjAySQDcjKJqpm/U08=;
        b=lWlez8QaRwPpFqyTYfIrgaGWSM79qZ/D/1bqmwFIvoIv4eRL5xncIdrItKqGJtn4Ry
         hCrORUdCxF32WBdzBJV5R7fRYYNvafmRg4684iagMQiD1ftf4PwHVR/Ywaov0L68p1c0
         kX5NXPdANvgjtp7jt1qYBzKKEKQvSjInlgtvHCufsVfhv3tieLI288Dbd9LTLO/kM20l
         YUwQNpetIHaC0BcJysqK7vNNDg5OFXEW4sHJHJPfNiQdAEDqSs7xanrL2gqxGnxIUbp2
         b11qY37JtDU22/g219XcnoE9bDDN7l8iXqKwM+HVRAMWgMtdoIMLWmgbUmzwRVe4vhhh
         UG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4pzI73aVQK34I0le6F39OSJR6QjAySQDcjKJqpm/U08=;
        b=BqKDlsHCDxFwkYPSAZpAyfFEGokgYUORLBn48jtStnqBq7fOJOepF2qNnXstNkCDGN
         2bj61a2g9u4OJ8FUGT12YgtZTcJjghdJWvTP/UIpjD8OOi3oYByvY7gUH4Pgik6cKhPI
         ddnrMC/ALE74NJvec7jVZH5Kz7723/TytI98M95kVNpzHQ1sPu3vwzjX4SGlAcUO0QbV
         A9VI7392L2O+SO7cb4o5SCL8kKhT2EOBMZMEH6H3VMU3hcqQ/gY8RM9OfKl1zL1yNYan
         frClH3Nz9PrBY8TKilNYr+I0tk7IclB2khhtREPWGlhOHTSexPRdy4eIiXsee8XxE8GB
         NJ7g==
X-Gm-Message-State: AOUpUlFzYtHNCIjp8MSzT/LTUES02LIqhmSSOcBSNLCNNtUOgDkMNgP+
        jlrd0jtyx18tvdmutFhpj0gft7qv4Px9wZaJqtyb8A==
X-Google-Smtp-Source: AA+uWPw0Q7bcReiSfjAPpFKewnu00zixCbI5uAa7b3HlCJlsCBgLw/wQo7gAwN5Zk/N89zULOeB2DdgUwX/BFaXLEI8=
X-Received: by 2002:aca:3882:: with SMTP id f124-v6mr30188934oia.195.1534429354622;
 Thu, 16 Aug 2018 07:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180815235355.14908-1-casey.schaufler@intel.com> <20180815235355.14908-6-casey.schaufler@intel.com>
In-Reply-To: <20180815235355.14908-6-casey.schaufler@intel.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 16 Aug 2018 16:22:08 +0200
Message-ID: <CAG48ez0OAFqzak1=OEF5V8cZR_-dYUiXnUVp=mgnikexjQkELA@mail.gmail.com>
Subject: Re: [PATCH RFC 5/5] SELinux: Support SELinux determination of
 side-channel vulnerability
To:     casey.schaufler@intel.com
Cc:     Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        selinux@tycho.nsa.gov, SMACK-discuss@lists.01.org,
        Dave Hansen <dave.hansen@intel.com>, deneen.t.dock@intel.com,
        kristen@linux.intel.com, Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16, 2018 at 11:52 AM Casey Schaufler
<casey.schaufler@intel.com> wrote:
>
> SELinux considers tasks to be side-channel safe if they
> have PROCESS_SHARE access.
>
> Signed-off-by: Casey Schaufler <casey.schaufler@intel.com>
> ---
>  security/selinux/hooks.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index a8bf324130f5..7fbd7d7ac1cb 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -4219,6 +4219,14 @@ static void selinux_task_to_inode(struct task_struct *p,
>         spin_unlock(&isec->lock);
>  }
>
> +static int selinux_task_safe_sidechannel(struct task_struct *p)
> +{
> +       struct av_decision avd;
> +
> +       return avc_has_perm_noaudit(&selinux_state, current_sid(), task_sid(p),
> +                                   SECCLASS_PROCESS, PROCESS__SHARE, 0, &avd);
> +}

current_sid() -> current_security() -> current_cred_xxx() ->
current_cred() accesses current->cred, the subjective credentials
associated with the current syscall context, affected by
override_creds(). You probably want to look at objective credentials
here, since what you're interested in is not the security context of
the current syscall, but the security context of the userspace code
running in the current address space.

task_sid() does the right thing and looks at the objective creds.
