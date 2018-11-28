Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 101F0C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA01E2081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 21:49:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAd3e5SJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA01E2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbeK2IwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 03:52:03 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42107 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbeK2IwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 03:52:03 -0500
Received: by mail-pg1-f194.google.com with SMTP id d72so10076310pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 13:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UkOjbKH/8JN/Gdxln81p2qwngSoGyXkHiCnYRBRRjJI=;
        b=aAd3e5SJQA8FE5TCOAbqZF7zhsT/S/m962YuTD+AQAhAlDKTEAuq7C49rcTYfsoVks
         JEr3sQvyKVRUrqHcKIy9QQAajh5O8zb8W6GQzKhMplUq/uSbp4FCw2ktKY6QoFywaLfB
         Nz5Elzz7agURElRSPef54lkZsQsxhpmPGPw7jRC4W8Zs+yKTXeb6MBU9RM7ETROZAnUk
         YBuYdEnI8fm2g3w4t4kf1evefzgfU3n1SIaHmnG3pRsZz/IEzgPL1QRWkzb7p/NVqQEo
         EnViCyUJcASMwUr9rmP0SZJ+vJ5kXwEE2LlnlDkuHBAPFmU8Vaa4Dlu2oOT1WPATlztJ
         aVVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UkOjbKH/8JN/Gdxln81p2qwngSoGyXkHiCnYRBRRjJI=;
        b=cGB7axZrYKB8PCDa8q7vgd8ez9ueULzB+YCv+REMiIImtWSKs19VEPiXG38yHESWBG
         KvLl1NSZ/ezvCeb9Ne2a7hqcHybNehAeqkDaQZcVRLUqFC1Uz32oHigO2Uqs2xiRLd01
         emXQPWOOqtHoPEWS3d69DlrFN/70kZ5arH86Se6+cvnqlJ5MEGaGIcS/vp13kDnV7XoH
         y1Yxxdi+EhHLo7OAlCErmTMWDuGFlmojSKBGEdg9/5QTaxy8iAPaJgJT5aDmS9ge7Q7y
         viQVnQgoUIfdIGZi1ws7zGzC4dLIeFmGaQK7St2Gdy4NV88ecwA+847k2vGYMrjNC/HX
         3K9Q==
X-Gm-Message-State: AGRZ1gLQuUcbbaQ4aRbCNOTG/O9Q/j2POEfK7pw1NbXR52FQhaVo2DYt
        p9Ybg/vEqyVjU8VBUEl4zyI=
X-Google-Smtp-Source: AJdET5fc83zCS11rBUqk61nZH5Bnr+xiLevRZF8AI/4A0wPre0W0Bg1Fq3D1sXBSequwQi9bBcc8tg==
X-Received: by 2002:a62:938f:: with SMTP id r15mr39078616pfk.27.1543441740389;
        Wed, 28 Nov 2018 13:49:00 -0800 (PST)
Received: from [10.0.2.15] ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id x3sm24267578pgt.45.2018.11.28.13.48.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Nov 2018 13:48:59 -0800 (PST)
Subject: Re: [GIT PULL 3/4] bcm2835-drivers-next-2018-11-27
To:     Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com
References: <20181127211301.30296-1-eric@anholt.net>
 <20181127211301.30296-3-eric@anholt.net>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <43207cc2-da5d-863f-babd-9ce89722141e@gmail.com>
Date:   Wed, 28 Nov 2018 13:48:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181127211301.30296-3-eric@anholt.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/18 1:13 PM, Eric Anholt wrote:
> Hi Florian,
> 
> The following changes since commit 651022382c7f8da46cb4872a545ee1da6d097d2a:
> 
>   Linux 4.20-rc1 (2018-11-04 15:37:52 -0800)
> 
> are available in the Git repository at:
> 
>   git://github.com/anholt/linux tags/bcm2835-drivers-next-2018-11-27
> 
> for you to fetch changes up to 502b431cda801645fd73857f7b47a4666de3cb62:
> 
>   firmware: raspberrypi: Switch to SPDX identifier (2018-11-21 14:33:11 +0100)
> 
> ----------------------------------------------------------------
> This pull request adds SPDX to BCM2835 drivers, and fixes some bugs in
> the firmware driver (silently hanging if the VPU doesn't respond to a
> mailbox transaction, and undersized buffers in the firmware property
> transactions for tags that aren't used yet in the upstream).
> 
> ----------------------------------------------------------------

Merged into drivers/next, thanks Eric.
-- 
Florian
