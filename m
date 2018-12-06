Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231DFC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2FE21479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 08:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="cnHpeNDJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA2FE21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=endlessm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeLFIrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 03:47:23 -0500
Received: from mail-pg1-f169.google.com ([209.85.215.169]:45944 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbeLFIrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 03:47:23 -0500
Received: by mail-pg1-f169.google.com with SMTP id y4so10316697pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 00:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PA2wDcwsUB7vaLdVB3Lft56XBYXoK9wATKJi44iVbpc=;
        b=cnHpeNDJXEI6KDZLXqTl3WFMkpV11L2W8Fi2eFwbrbMt6yKMS12u1+GLjbJ2mCzeyI
         XWN7ir68Ko++H+xqW0yZqPDKf04OnFxGdIKysUZ8zNK7umPfyW36oBgTKzFEJiPlgInv
         jp0LZN/83vf1VdN0dfPRtzcRN2hhPN4JIM4upB7hjUGjJjrPIMWMOd4nNCdOLfAGeRl8
         w97LbfHGrqSCL83QLzfhjzE8KglM/CdXJYiVAftiRA+k4aPGsmZEFzSIrBTJKjHhNTSV
         rlSlgCO/fWFBwtfqkQMtX5+bseJOiJYnrQNFJE8QGP/Z4ba8EyXch+nooNbeCh+aKXFX
         rR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PA2wDcwsUB7vaLdVB3Lft56XBYXoK9wATKJi44iVbpc=;
        b=sb1lbRdU+g0XObtSKuOlU1VU/7eWKPi4QsANt+TD5rrS1nniG3b4tukfh1aP2gtXPQ
         nRobbphU2DjdKRRpdQQ+rX/ptIKL7QqjQi5kz0A2DNU5tzvmZ8MGtQeIbHmkyAF9qTWq
         SbRhnHDMiz6VuPd5RRn0PuZzIeS/8m+6JdzodEJuf8AqoS0UFb5oBqfBbqcgj97kTdNX
         +IZFCmQyKiFOAmWT3ZXGgrbXUD06Wwwx4Yfmb3cutHHB+jugrps600TNYNftIFddYBRE
         JEkzUGUnLMOwzmATTrG1yhZSlfjLl7iroBIbNDGMeVXYDrdiR1Usyu0zqMMNgBq79WEI
         ii6A==
X-Gm-Message-State: AA+aEWaSSStFen2brg9VU+yKKD9tJJRLOKN2YMHQCimKXj4gCmTHDTmk
        JDMsfC/hCH705+3G16UnpIGguA==
X-Google-Smtp-Source: AFSGD/WMPd4hrxlMlbGPVxruAPK2+wc/loQgueCGKkTy5avJrkZ5oyDzxl5Q8kZBlqTdQNMtv9jOOg==
X-Received: by 2002:a65:48c4:: with SMTP id o4mr22549144pgs.371.1544086042228;
        Thu, 06 Dec 2018 00:47:22 -0800 (PST)
Received: from localhost.localdomain (125-227-158-176.HINET-IP.hinet.net. [125.227.158.176])
        by smtp.gmail.com with ESMTPSA id u70sm40484836pfa.176.2018.12.06.00.47.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 00:47:21 -0800 (PST)
From:   Jian-Hong Pan <jian-hong@endlessm.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kailang Yang <kailang@realtek.com>
Cc:     Hui Wang <hui.wang@canonical.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jian-hong@endlessm.com>
Subject: [PATCH v2 0/3] Add ALC294 quirks for ASUS laptops
Date:   Thu,  6 Dec 2018 16:45:51 +0800
Message-Id: <20181206084554.4728-1-jian-hong@endlessm.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
References: <CAPpJ_eez=1ie2B8rA=GeW+hx7kQU0wBAhW3XCBX3zGPW+kXDZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Realtek ALC294 quirks for ASUS X542UN, UX533FD, UX433FN and UX333FA laptops.

Chris Chiu (1):
  ALSA: hda/realtek: ALC294 mic and headset-mode fixups for ASUS X542UN

Jian-Hong Pan (2):
  ALSA: hda/realtek: Enable audio jacks of ASUS UX533FD with ALC294
  ALSA: hda/realtek: Enable audio jacks of ASUS UX433FN/UX333FA with
    ALC294

 sound/pci/hda/patch_realtek.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

-- 
2.11.0

