Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DAC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 230B42086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 09:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGBbUluJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 230B42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727126AbeIDN2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 09:28:09 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51980 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726376AbeIDN2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 09:28:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so3553611wma.1;
        Tue, 04 Sep 2018 02:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b7nNDJM2C0D5luuhJdE6BH0RUd7f1NUMKPTN746TzmM=;
        b=CGBbUluJ+EWQU8gkmIMOYH4HLoBbzfv8zucPaP5mHaeXaKYQKO8sCSlavcak/2J+it
         Gl+c5zCOb0WfeK7ad4AxDJgghgmjrNo0udTbcy/aRPv5+UBEn0TcxkWijTNSSxe5AK04
         L2Yd0WiuO8Y380OYEho/DwaA33AOveVCqSg1U9B2fa2zB5HRCekuX1INkZgZytOKfJxm
         mpnSlzV0j6R1Uop6mhfesrSTlhvtQ5nHNA6YcZzAFctZTTPE7MFoYRpCcfdq4h4rLppe
         P3WTgafXCwHiJQCJtvyOckMZ6sH8PDD4+j2B7LCoI+JrfWv1fTlwPLBMgN7+gs6lCYxP
         XZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=b7nNDJM2C0D5luuhJdE6BH0RUd7f1NUMKPTN746TzmM=;
        b=Ercn7+kp9rXNPIuKwIbOer37wzdNsIUa5hSHhiqB/K4Hv5c8yQP340p0ngY/gSazWz
         jujPlI2RkOIXPdtIsjR/Ia3mfyPU6ehre/8AP7gmpeXZMlOdVjAoE6I37oZYVQZzh52V
         VTz2Q4ADgM03uG58e3b2+OnLogRKtgj3e2QoyWjOnPUV23ic/ocUVAzQrn/ZdBWxt0kX
         1TU3DCwhePqWNC+fP/6mHda/4Ym8KyQQDKtKwciFhq8j9nMVypy4JhYBm0MNV8Jb051y
         KSVwFxcF9sHPb/z0THtyea5wGWteS6N0A1+2UKBlfEee65BhTcsyyVvpY6IBrul79CTt
         z3BA==
X-Gm-Message-State: APzg51BaJ2+GS8FLJgV53lIFcsje/fkNHWQPlq8oYSGgrx9h2sFfBumv
        Ksvy5XvYzlmGxdVUlk00YrV8tFMS
X-Google-Smtp-Source: ANB0VdY6Ek5/3oXwoqQw+BFVvkBK4ajfm4Zs2rD8CFCHHZxCSvVwhxMI+HnMiVxJt173+FylN47oPA==
X-Received: by 2002:a7b:c017:: with SMTP id c23-v6mr7567429wmb.136.1536051836450;
        Tue, 04 Sep 2018 02:03:56 -0700 (PDT)
Received: from xux707-tw (host86-148-21-150.range86-148.btcentralplus.com. [86.148.21.150])
        by smtp.gmail.com with ESMTPSA id e133-v6sm26997806wma.33.2018.09.04.02.03.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Sep 2018 02:03:55 -0700 (PDT)
Date:   Tue, 4 Sep 2018 10:04:07 +0100
From:   John Whitmore <johnfwhitmore@gmail.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the staging tree
Message-ID: <20180904090406.GB29158@xux707-tw>
References: <20180903120617.34f4f8cd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903120617.34f4f8cd@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:06:17PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the staging tree, today's linux-next build (powerpc
> allyesconfig) produced this warning:
> 
> WARNING: drivers/staging/rtl8192u/r8192u_usb: 'dot11d_init' exported twice. Previous export was in drivers/staging/rtl8192e/rtllib.ko
> 
> Introduced by commit
> 
>   c01f06b7506f ("staging:rtl8192u: Rename Dot11d_Init - Style")
> 
> -- 
> Cheers,
> Stephen Rothwell

Aragh, sorry my bad, and a newbie mistake. I now know to do more of a
check for exported symbols. If it had occured to me I'd not have touched
it.

I'm not sure what the procedure is, having written my first bug, but I'll
submit a patch to revert that change.

jwhitmore

