Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB40C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C98C2077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 14:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6/UwqAO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C98C2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeIETQv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 15:16:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38776 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeIETQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 15:16:50 -0400
Received: by mail-lj1-f194.google.com with SMTP id p6-v6so6491445ljc.5;
        Wed, 05 Sep 2018 07:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3sNEmK4usobyWhWY4E+ODRFZIkmI5F5V5ExPiLxOrgQ=;
        b=P6/UwqAO56FknOkIqqw4clYGJZyI+DN9mlKyMnVv/hbDEIsBfkrpr/2Tp72lCGH7Dc
         Z34ciVhjcqHyFfsx1oftrV4qtK99lq7VEmMB6nvOuEi/enpws8XWR4T/7dC/3nRBGHNj
         1cwFLyULXz4/4fy84GAmG3U3TRl72tCbRZZacOw2CSWG5S03qZ+/mdmDKAA9NbKyiiVQ
         ClzVmpfSuXKL/ZWq3XxWxBOdtkK1m8RmjkCeREunuaf/qbCkJjFsO7YEBXRM+xnzm2ox
         wR2q2ygq+2p2XxL1Up+l0hjfYr6t1CMWqTzeiW+PMvvH/ZD64OsuIThOvcdwTYsBdDTx
         rLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3sNEmK4usobyWhWY4E+ODRFZIkmI5F5V5ExPiLxOrgQ=;
        b=WC6wyH1Sr8g7Vyj8JOkZHP26ciA9kluDJPyl/cciZsgpnITGo7N7/4wwXXQTd31ysw
         UR/pHOppDzgkrVTIRDjjtewornbdyf5ETXZIGV2dZl2+ejDkGOJnjA+jQpqrL/XJ6lYu
         qEHA5ktl63ESYNMv59KafnylIPCJ7B8UzFVEGBWDeX1LbB6QeU0mxDfFB4qi+5dK3p8Y
         r58qwIPohSGC4pAEa35xKDE64leB7XK/K3uWosVztnC3g76S00+XnwgqIVcFMV1Hsy2s
         C1UTbuUaghscC8pfuDEZ/rNnVh723fcnhCIfGaK7ob4Wmry5bGSCdbXRmbkDDZ7ntMcv
         Htzg==
X-Gm-Message-State: APzg51CQYqb6ZrLVI8/M3rctGzN+2Q0GUNWPrhs1/Vm/YZikqUvze/Hy
        yrHS/6AhqLtNerx1v2zIi/0=
X-Google-Smtp-Source: ANB0VdZidC7k5nXqcPrng8AXviVHHlHg2tVpNdnYNXX4MJUbDZXmjqUmM2dE5dUyn99WJHXN+3LEoA==
X-Received: by 2002:a2e:93c4:: with SMTP id p4-v6mr23354569ljh.150.1536158778187;
        Wed, 05 Sep 2018 07:46:18 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id n17-v6sm349990ljb.82.2018.09.05.07.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 07:46:17 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxZ4e-0004ft-Ra; Wed, 05 Sep 2018 16:46:28 +0200
Date:   Wed, 5 Sep 2018 16:46:28 +0200
From:   Johan Hovold <johan@kernel.org>
To:     "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Cc:     johan@kernel.org, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter_hong@fintek.com.tw, hpeter+linux_kernel@gmail.com
Subject: Re: [PATCH V2 4/4] USB: serial: f81232: fix bulk_in/out size
Message-ID: <20180905144628.GE1089@localhost>
References: <1535593634-22004-1-git-send-email-hpeter+linux_kernel@gmail.com>
 <1535593634-22004-6-git-send-email-hpeter+linux_kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535593634-22004-6-git-send-email-hpeter+linux_kernel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 09:47:14AM +0800, Ji-Ze Hong (Peter Hong) wrote:
> Fix Fintek F81232 bulk_in/out size to 64/16 according to the spec.
> http://html.alldatasheet.com/html-pdf/406315/FINTEK/F81232/1762/8/F81232.html

I know we've discussed this before, but please explain here in the
commit message why you want to do this.

The bulk_in/out_size fields only set the buffer sizes used by the
driver and using buffers larger than the endpoint size is typically only
more efficient even if there may be hardware reasons for not wanting to
use that.

You said last time, you datasheets were incorrect and that the devices
were in fact using 64 b endpoints, right?

> Signed-off-by: Ji-Ze Hong (Peter Hong) <hpeter+linux_kernel@gmail.com>
> ---
>  drivers/usb/serial/f81232.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
> index 863430d7535f..e3ab1646a693 100644
> --- a/drivers/usb/serial/f81232.c
> +++ b/drivers/usb/serial/f81232.c
> @@ -785,8 +785,7 @@ static struct usb_serial_driver f81232_device = {
>  	},
>  	.id_table =		id_table,
>  	.num_ports =		1,
> -	.bulk_in_size =		256,
> -	.bulk_out_size =	256,
> +	.bulk_out_size =	16,
>  	.open =			f81232_open,
>  	.close =		f81232_close,
>  	.dtr_rts =		f81232_dtr_rts,

Johan
