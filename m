Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE78C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DAC020836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="jh8weIUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DAC020836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030394AbeFSRoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:44:24 -0400
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36884 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030323AbeFSRoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:44:22 -0400
Received: by mail-lf0-f43.google.com with SMTP id g21-v6so785845lfb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVD3elAZ/NJLIqc1EwsGwLUXQ5h946VLlebpdv8Py0M=;
        b=jh8weIUCM4ditSTJCvlRDPEoiWMJSFKm9m7/eYJUsJ2iDslN1nG2vTb5Ik+GyRf/yT
         WRBpFip+EFy4+AOSRqdHd4RWNJ056TSF+Kzx0VqiuHLYAUYcrmLUzZ3zkGORjEP4qFUT
         G5WYUMJLgfaZLJj/WuR6XOiHLkfck/wySaaS6LJ2le4HbcNi9i0dQzS5ZzR7TKEi51fj
         dXo9QqSIxvA8/qNihERcr1Jp0kPHaVmQlKJowNhxD0X5du+NUtZBlnhQ7NWymnkx3EkB
         rKGZijGujzkTCSkQiOhfpgu+ScVEG5dQDD0Mdu7JxcwTvULr6NIMJSv29C92t+9KG+NX
         6BFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVD3elAZ/NJLIqc1EwsGwLUXQ5h946VLlebpdv8Py0M=;
        b=BOUd7iVkhw30G39ApJD7fw4OgAYmY0BrMGAMc+OfAJI6YtJn3owWavt5K11aHhSpmi
         8uKUHSIsA3Bh71qi46cvbfeZgXX77lXS20TM5xrlRv1pb04Fc9xKGVoTBlvwJ4twEOh5
         sU9x1ZH8WAAPSc2qpnzk8JAfD4spPWD0NLWt7eudbrxPvhowv7gMB504e7+5gTTL7fXm
         KyJelTiqfg+gTyI/Zi/6Wk5e2ovyw2osZHwveuDM254K9Gk0oy/wGvA0AyCRWXWL3Arr
         wefoUE2Ke2Nhq8nlCYJAc/NRI5ZacK2QguYQ2jo7SBNKHfLLeaLJiJBCzi/BSwT6x+3G
         +R2Q==
X-Gm-Message-State: APt69E0s1XMd0jsZpJdGZHzufZCCueycPsclJJnkRJ0nwn00Y4eT+9fe
        RKfac9TxNlUIQ6FREIuO0E82EKZowfFIZZ+hJs/u
X-Google-Smtp-Source: ADUXVKJYx8qhXU3g5jfFZZhRSlFbMQ4Tf2iuyh1TR5Wl48bntZInbMGcJGexSnjR2Q4f/ORZUm59YlCvo2aTkigUijo=
X-Received: by 2002:a19:5c12:: with SMTP id q18-v6mr9107197lfb.145.1529430260907;
 Tue, 19 Jun 2018 10:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180612080912.7827-1-peter.enderborg@sony.com> <20180612080912.7827-11-peter.enderborg@sony.com>
In-Reply-To: <20180612080912.7827-11-peter.enderborg@sony.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 19 Jun 2018 13:44:10 -0400
Message-ID: <CAHC9VhQXk4tMZ_fp=rbygEs2ZyT2O07PJB4jdKKY7+eO3wSC5g@mail.gmail.com>
Subject: Re: [PATCH 10/13] selinux: Cleanup printk logging in netport
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
>  security/selinux/netport.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Merged, thanks.

> diff --git a/security/selinux/netport.c b/security/selinux/netport.c
> index 9ed4c5064a5e..7a141cadbffc 100644
> --- a/security/selinux/netport.c
> +++ b/security/selinux/netport.c
> @@ -173,9 +173,8 @@ static int sel_netport_sid_slow(u8 protocol, u16 pnum, u32 *sid)
>  out:
>         spin_unlock_bh(&sel_netport_lock);
>         if (unlikely(ret)) {
> -               printk(KERN_WARNING
> -                      "SELinux: failure in sel_netport_sid_slow(),"
> -                      " unable to determine network port label\n");
> +               pr_warn("SELinux: failure in %s(), unable to determine network port label\n",
> +                       __func__);
>                 kfree(new);
>         }
>         return ret;
> --
> 2.15.1

-- 
paul moore
www.paul-moore.com
