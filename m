Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D19C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33DAD20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="2S36X+cV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33DAD20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030423AbeFSRuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:50:51 -0400
Received: from mail-lf0-f54.google.com ([209.85.215.54]:34836 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966999AbeFSRut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:50:49 -0400
Received: by mail-lf0-f54.google.com with SMTP id i15-v6so824788lfc.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=duBr1fF5dRuIY8Do80OvQcjMuxCD9C9/ZfuS0JRYR7c=;
        b=2S36X+cVMBukT7/prjt+of3fmJ2NCZiSS7YOJhgwQ0CaCqvOMp6AjvM8OmBJWj5LwJ
         zITZsYFoWuvhUyjkpE18B60Gd03CcsuRvmZE070vwsYuphZpGyC56JJqNQpcGbuO4iRj
         Gi+RbdUZRgd8/ziBqVJCN5S/yuKvFkbuLZz57kH//qGeF1WNTth+1NBX3KGccUf6oLof
         xCfIZHEEvXyHEptlRZPDSvYyLgY6PtnSc+bdn/irLYYXOSwgjW8ZrFxKig+eCGPdB7i/
         ZjH8N0ZcYI/HNs107edWPx/M1rcXCvE/SGgmT8SW6LiVQE5Zaq3sMoQz9odYP57Fxi8U
         737g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=duBr1fF5dRuIY8Do80OvQcjMuxCD9C9/ZfuS0JRYR7c=;
        b=NrCXi4ftvjHem7M4FLhLSx1gIz4rtniycUkCIa65QKtsUcfFm8Uh+7dEKsvuNXxYv/
         mABFnAHgRe/yLifhaq44VWIhmUr10yn67VC5Y0JNLFXWMdNkWNLOI1xAaxycbbsyfodj
         orhZZ1e0sOulk0Vh9Pc+pH3mpLIhYRWeR6Kk5Y7ydc2NZ97aSvOHthrtHELQH86aCMzp
         rsrr7CrXRZcK4siTV7CfjdjwNxwQVUbhIoN11mRvhOcCK/LwiPjaNZCS3mgt3Fkt5tOm
         ihQSpRe+5NvjjKgmkL4YPuSbvVSVzHKqm7jep/SFXelwso1d+wrhjkbKBSXQoDT6Jnu3
         Y3fA==
X-Gm-Message-State: APt69E3puT1aVcRYFfhBdzJ7+E6V0tb0VXtp07A7b/O06MMYQLY2PRG9
        7X2s6V5fZ3lywl7ciGnTGWR1qbbKA0NqhTVZACoU
X-Google-Smtp-Source: ADUXVKJUGy+GvDN08sy/6kwQojaMkdgtTjAMUtbNlsEAF5gYsZAEdja/4+MWJj2JoIB1cOJHHfnEE254ba6IeG69qGk=
X-Received: by 2002:a2e:29cf:: with SMTP id p76-v6mr12635230ljp.12.1529430647826;
 Tue, 19 Jun 2018 10:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-14-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-14-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:50:36 -0400
Message-ID: <CAHC9VhROjW4r7Ls35aX8M+j1BMn13OuUsN8prg9JnKWyHS1wzg@mail.gmail.com>
Subject: Re: [PATCH 13/13] selinux: Cleanup printk logging in netnode
To:     peter.enderborg@sony.com
Cc:     Stephen Smalley <sds@tycho.nsa.gov>,
        Eric Paris <eparis@parisplace.org>,
        James Morris <jmorris@namei.org>, danielj@mellanox.com,
        dledford@redhat.com, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 4:09 AM Peter Enderborg
<peter.enderborg@sony.com> wrote:
>
> Replace printk with pr_* to avoid checkpatch warnings.
>
> Signed-off-by: Peter Enderborg <peter.enderborg@sony.com>
> ---
>  security/selinux/netnode.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netnode.c b/security/selinux/netnode.c
> index 6dd89b89bc1f..afa0d432436b 100644
> --- a/security/selinux/netnode.c
> +++ b/security/selinux/netnode.c
> @@ -238,9 +238,8 @@ static int sel_netnode_sid_slow(void *addr, u16 family, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netnode_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netnode_sid_slow(),"
> -                      " unable to determine network node label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network node label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
