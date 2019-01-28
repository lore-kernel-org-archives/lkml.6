Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47BEC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84F4B214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 14:19:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZXZr7C8I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbfA1OTv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 09:19:51 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44596 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbfA1OTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 09:19:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id k19-v6so14346988lji.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 06:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+NbtZQYJjeHEcDc9wYzWR+TQ0tJQnl2YUAbHEtNkk/s=;
        b=ZXZr7C8IERXC0OTYYI/a2JrxHfK3Zy5olaUzs7907wZePwp+vFhBpbZQl1G2ebnt06
         bHuHd29P4tziaR26+/krZ/jfsGn5hBhqroFMpcV0AwPaPc9+X5yI+JjJZTDOUVLSN2lG
         zK8mvhZnuF+ArEh+skYSLcB8hWwK4NFbwv+h4Rypur7TE0lmXVGsSivCTVw8CR5v/J9j
         VPkY3Y6bC48VvdwGw7ZApMI/042m0eUCSPD4D2vHoMlp9egFF3ef9DN0XdNeNcXZjr2K
         HWRJUhZk9eMSs20EmyHQZCcqbD5RE88777BScQfp5fngf/JTqSJ/4aRmHNbqiqNe03ci
         Kl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+NbtZQYJjeHEcDc9wYzWR+TQ0tJQnl2YUAbHEtNkk/s=;
        b=sNpS2Qg+cd5P6yX11UuZhBXZpeuTdUxYxAqYOPOMXeXQ2msAz0R++60uYKhJZoNAOK
         CVUFmSrciK5CfZr4AmVB6VvZ57VhXdHsduXk7d8cs0C+eKMrcUl5xXhvkorL9khb305w
         MeOutvaAwyCWPoTFEAPjKfq2ZayM41mHp5axm6Rx/+ueUB2R0kX6RtX4mpjN01d3hgbH
         mtQTgoftw+XJ0XgeAJxofuSdb2nE+q2mH9rrkQMAFezagQyZWup1+QOqQuO4o23HEIvB
         3wwrAT/Of3+FYEU7gAHCyO5EpCdr5tJBzmnjsq0XWdZ0n6OuNokGxq31Ip8syc+XwQZf
         E1yw==
X-Gm-Message-State: AJcUukfdQO6PXYED82D9hhVXxM0cq7m4MN08He1O4JkVcHjRL4zGlexY
        SSmjkgpkc1l8n7uXF4ZG3TE/HecZAeBCjwN5tg36
X-Google-Smtp-Source: ALg8bN5AyKhUSV3OCoiXfwqsw6l4latbLvmWojpoAMTAQurPv+o1AR6afvzYI0sqn2fNC6NS3vJtJsFMSSsQ3/yHmHM=
X-Received: by 2002:a2e:3803:: with SMTP id f3-v6mr17597973lja.169.1548685187990;
 Mon, 28 Jan 2019 06:19:47 -0800 (PST)
MIME-Version: 1.0
References: <20151208164237.15736.42955.stgit@localhost> <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
In-Reply-To: <5490ae28-251b-bfda-38a6-5be201a4a8d8@nokia.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Mon, 28 Jan 2019 09:19:36 -0500
Message-ID: <CAHC9VhQsVFY1LAakAUUCBZw6nmSy0-eoFrhQgVQrkqgAsWVGhQ@mail.gmail.com>
Subject: Re: [PATCH] audit: always enable syscall auditing when supported and
 audit is enabled
To:     "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>
Cc:     Paul Moore <pmoore@redhat.com>,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        Richard Guy Briggs <rbriggs@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 4:04 AM Sverdlin, Alexander (Nokia - DE/Ulm)
<alexander.sverdlin@nokia.com> wrote:
> Hello Paul,
>
> On 08/12/2015 17:42, Paul Moore wrote:
> > To the best of our knowledge, everyone who enables audit at compile
> > time also enables syscall auditing; this patch simplifies the Kconfig
> > menus by removing the option to disable syscall auditing when audit
> > is selected and the target arch supports it.
> >
> > Signed-off-by: Paul Moore <pmoore@redhat.com>
>
> this patch is responsible for massive performance degradation for those
> who used only CONFIG_SECURITY_APPARMOR.
>
> And the numbers are, take the following test for instance:
>
> dd if=/dev/zero of=/dev/null count=2M
>
> ARM64:      500MB/s -> 350MB/s
> ARM:        400MB/s -> 300MB/s

Hi there.

Out of curiosity, what kernel/distribution are you running, or is this
a custom kernel compile?  Can you also share the output of 'auditctl
-l' from your system?  The general approach taken by everyone to
turn-off the per-syscall audit overhead is to add the "-a never,task"
rule to their audit configuration:

 # auditctl -a never,task

If you are using Fedora/CentOS/RHEL, or a similarly configured system,
you can find this configuration in the /etc/audit/audit.rules file (be
warned, that file is automatically generated based on
/etc/audit/rules.d).

-- 
paul moore
www.paul-moore.com
