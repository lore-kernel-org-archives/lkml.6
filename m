Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C18FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E555B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIhoCWe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E555B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeLCPsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:48:43 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41977 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbeLCPsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:48:42 -0500
Received: by mail-yw1-f65.google.com with SMTP id f65so5558803ywc.8;
        Mon, 03 Dec 2018 07:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dIOd5pUNYLcF4hj1QE7ayuSvWuFWxXRiDhLUZKjp2z8=;
        b=GIhoCWe2GZy06Te1zmV/a0BuGH92PHB33GHD3d6DYQRKJaLyO77umiwF/ZAm5xRbgl
         aLtSg1eFDJgIxg6M16fl7V2z0duZYF6MmFqsATKxCk7uu+FIhB7YGrT1LuvEAWe4A7iq
         8C2jjehOjeZIDtWb1pw9N7wVAX1np/Fpl4z0F4vvm8vEaeLUGgbOUygcdC3PwVkL5UgP
         Avdo0ROAAySSzyw8KSp4eTBCvvC/vVzlHjQqRgYfQRjtOpgym2UgamxmTolE9sLErwMJ
         mQ7tWwgGSRzrxBTh4T3wCh4gYE9S1+yiDivmWgEmSqZTXRAbyqe01VNwRe7mJKWT8o4G
         8Ypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dIOd5pUNYLcF4hj1QE7ayuSvWuFWxXRiDhLUZKjp2z8=;
        b=cvuoOa6g0rgtRdcbtYcHWb6AGYqSN21funLPieBLP8JKwLTnf5Uypb/qiDi+A2leuC
         KoUCw0ba788jn9pHdV7Ff/mEG4jRbqHv/dOmWRtb6SkMYrfsgU8CW2oyw8KwJXzyn8EW
         WRo2RGge/1WMpzZUzCyEEjDntnfF+McWylSMV8xWjedFrtH7pkf/LGIeoEKI7HAqDM3v
         Y0bqA3wgitoPHGfCMeeGBpkUOl9ACMg4J818pp41yvC62wFf9MH6R120qlqJJTNpY3JP
         c4l69Je4QDkq3c5FE+12xq7P0KzuXO0uDKmKA/rstvUx9M9bz/Lgyh5hoc4aD89F/MMY
         iG6w==
X-Gm-Message-State: AA+aEWakOQs1KrbSwV7bvmLCkvgdmGxllo8n8Vo+64YHqrEpCqvBbVDB
        1NSINJcgcTOD2LnchgcDyA==
X-Google-Smtp-Source: AFSGD/W9qkVPmapGiu0ZqWd/5oi3Dv9PxlHbAVSosfU4EbxdiNC6CgZxoibbUa2ahK7kuwJp6K4yFw==
X-Received: by 2002:a0d:ea8e:: with SMTP id t136mr16693107ywe.376.1543852119693;
        Mon, 03 Dec 2018 07:48:39 -0800 (PST)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id g127sm4558138ywf.38.2018.12.03.07.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 07:48:39 -0800 (PST)
Message-ID: <7e1f03ba033b557feb6e9dd4af4497b39611d54b.camel@gmail.com>
Subject: Re: [PATCH v8 3/3] ALSA: hda: add support for Huawei WMI micmute LED
From:   ayman.bagabas@gmail.com
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, Hui Wang <hui.wang@canonical.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Date:   Mon, 03 Dec 2018 10:48:38 -0500
In-Reply-To: <s5hefayzuod.wl-tiwai@suse.de>
References: <20181129235742.14332-1-ayman.bagabas@gmail.com>
         <20181129235742.14332-4-ayman.bagabas@gmail.com>
         <s5hefayzuod.wl-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-12-03 at 13:00 +0100, Takashi Iwai wrote:
> On Fri, 30 Nov 2018 00:57:38 +0100,
> Ayman Bagabas wrote:
> > Some of Huawei laptops come with a LED in the micmute key. This
> > patch
> > enables the use of micmute LED for these devices:
> > 1. Matebook X (19e5:3200), (19e5:3201)
> > 2. Matebook X Pro (19e5:3204)
> > 
> > Signed-off-by: Ayman Bagabas <ayman.bagabas@gmail.com>
> 
> Feel free to take my ack
>   Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks, i'll include that in next submission.

> 
> 
> thanks,
> 
> Takashi

