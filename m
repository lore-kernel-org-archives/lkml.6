Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF43AC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BDF520693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ofAL0wno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BDF520693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030355AbeFSRsy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:48:54 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37215 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030337AbeFSRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:48:51 -0400
Received: by mail-lf0-f68.google.com with SMTP id g21-v6so805169lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h+hKevTHETXYk22A8wPEf9GLUIRyLp/nzE2fEylcbXI=;
        b=ofAL0wnoS0KW2A18TXOiEd0AMD5rXpwld81R3vOetnRZrlSMqqNNr5S5dnnW+WHI+i
         FlBi0C8Z//JhWkciGpT5F8i1L0ku6nLE/bCVD9u40HU99sagSg1BrmUNbWNywmYP6KAa
         o++7pKeJGgctV71dwVDScZpuKe8AQnFiZ211hmow/OUC91wG4+GwnO37tkLHa9kMs6/D
         dCsVk6JzCMiZdud9eczxgRgcjpeuW6Y14GPuPSxKgXuKh9bfv4YztrWvCXEnXvrU9inH
         PhoIhwF5E3HmftddRCoO2vXC6hX3rvp12SSy1jbmuvBZ6CtQmUbsCj66FxUNx4Q9ZKC2
         5YTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h+hKevTHETXYk22A8wPEf9GLUIRyLp/nzE2fEylcbXI=;
        b=H5PuidTzZDVd20YDBxQk4XF40u/IO1STadlj4JH9odGi+CKB2DFketxJ6Q/draEaTa
         1mIgoty5my6aeNc/DwXAkNKRzUG6+6A1hk5PUxmDEqUlwyAT8QFfJqpcBHI7xw6hM+y9
         EEVfO2Ago1YGEH68zdPKZNWCMYezbt6u3BEcU79eU+G/huyWB6LOG08cCEfjh511tQvg
         61jCGsVaGlRMmHlNLUBOTCLUn+xKWysJD2MgSupJa5AC3yc++8tmrNUlMcFGewMkY3gz
         pVL7MoBTGK9qcPR38McdZ8yCHFqiB5xneNN7TS9D6x2T+HN14C6+5n0nupq4Sl92tUUf
         5boA==
X-Gm-Message-State: APt69E3FcE9NDbRY8QfUoLjTsaNAjDcKTbnAnMddRKstKYLV1JtwDCMZ
        xISb+sT5C7qVPcQphGuvfgyWlWSr3I+rO0kShZ+Y
X-Google-Smtp-Source: ADUXVKKslVMwGCRiHrlaiKS0BWTnBvSz80H3pQK75ALYr144DgNA8gnBfaIUmUB8LtEg4uZJQ1PaP/mq+EMwvjSu8yM=
X-Received: by 2002:a19:d5c7:: with SMTP id m190-v6mr1297203lfg.12.1529430529773;
 Tue, 19 Jun 2018 10:48:49 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-13-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-13-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:48:38 -0400
Message-ID: <CAHC9VhQ3xrVfGo0T-HdHbdM3p1k38NwfEP7qmNZDO_b_8a++UA@mail.gmail.com>
Subject: Re: [PATCH 12/13] selinux: Cleanup printk logging in avc
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
>  security/selinux/avc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged, thanks.

> diff --git a/security/selinux/avc.c b/security/selinux/avc.c
> index f3aedf077509..635e5c1e3e48 100644
> --- a/security/selinux/avc.c
> +++ b/security/selinux/avc.c
> @@ -650,7 +650,7 @@ static int avc_latest_notif_update(struct selinux_avc *avc,
>         spin_lock_irqsave(&notif_lock, flag);
>         if (is_insert) {
>                 if (seqno < avc->avc_cache.latest_notif) {
> -                       printk(KERN_WARNING "SELinux: avc:  seqno %d < latest_notif %d\n",
> +                       pr_warn("SELinux: avc:  seqno %d < latest_notif %d\n",
>                                seqno, avc->avc_cache.latest_notif);
>                         ret = -EAGAIN;
>                 }
> --
> 2.15.1
>


-- 
paul moore
www.paul-moore.com
