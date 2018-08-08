Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A0C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5D5821533
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 00:29:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhYw8loS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5D5821533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbeHHCqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 22:46:33 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42912 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeHHCqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 22:46:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so550694qto.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 17:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=70ZXmBo7ym10J1AIpapJ+scdCcwSKJ3Bnu6UP7Fuj/A=;
        b=nhYw8loSsdSMXozwgHvIxMxSQ8Bl852FQX+AdwmdoYvK/O/dLeOq/X4jjteB5Jg1zw
         3p4VE+7J9UIEzzsbAp09C8xrl5WPI8/yQ8dY3qczDMs+gIqBTATxyfy/Ii8zIVX8Jq36
         h7k6J0DQLMd5wykriwHCN/sehUNzLEmzjTPe/lDVtgfbBsm0BV7JdvAWKOguVW4Vw62O
         5ucojP2JLx/gsWNNq9lTa+RnjIcmdrSjR44qPJPbxeCbsoSVrHi7cM+g3Jec6RT8tgmi
         rYJcYkevtyAuj5gnAgSpRIflnWoGNfs9wWUDXjcZajwOSu5ELHRz/Au6+pmHGEFMq2mD
         PoJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=70ZXmBo7ym10J1AIpapJ+scdCcwSKJ3Bnu6UP7Fuj/A=;
        b=E9dABi6811ik9+qzP3tC34+/zySZaP661B3mWpwDIJIco+qU+aCAjPEuk+bgnvWVCy
         gsvcVtL+Mdqz6Pl1pvKtYWiMnuwicaDl2jGJXC0+kztL32GxmKCkzyAdwTinSJBAltrP
         PMKX0X3XUx6QjJ+uce8CUyY0tVLlT92zSg6GE1cp07sKUWpMRZ3uhjuG44owDwPjhDtv
         61fD1l8Ichlxy1Uvvvnk8fp2OSeunkmcaKFcP/amDkJVhtProQAelCHqYa4s9l6ADX8W
         8hVbDea6kyYKhE5FGpRCMWA2VncX0QAA4lP+O9PmXHvrLWOokmudGHa/WZAqnfQzDkp/
         DLcA==
X-Gm-Message-State: AOUpUlFiy/agox0IP5HTYlCGpvooU2Bi2GML6zMQ2WAQSDI3U4luKtiQ
        nN/ushcA3wB62cICIW8rpnk=
X-Google-Smtp-Source: AA+uWPyKmX8voUxcsEHnwiPlO4zoKhXx+k0VDuLUwF+j/J06MC1zhPS5+zuUkXIKWFkRLwXHpLKkog==
X-Received: by 2002:a0c:f842:: with SMTP id g2-v6mr593418qvo.212.1533688175379;
        Tue, 07 Aug 2018 17:29:35 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id j45-v6sm1824231qta.46.2018.08.07.17.29.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 17:29:34 -0700 (PDT)
Date:   Tue, 7 Aug 2018 21:29:31 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/15] staging: fbtft: Includes description to mutex and
 spinlock - Style
Message-ID: <b7a7e9b7da96d73eddad4553ba1297d9823a61b1.1533686201.git.leobras.c@gmail.com>
References: <cover.1533686201.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533686201.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Includes description to mutex and spinlocks, as recommended by checkpatch.pl.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index 6ee9ff320567..f771271d497a 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -203,7 +203,7 @@ struct fbtft_par {
 	u8 *buf;
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
-	spinlock_t dirty_lock;
+	spinlock_t dirty_lock; /*Protects dirty_lines_{start,end}*/
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
@@ -219,7 +219,7 @@ struct fbtft_par {
 	} gpio;
 	const s16 *init_sequence;
 	struct {
-		struct mutex lock;
+		struct mutex lock; /*Mutex for Gamma curve locking*/
 		u32 *curves;
 		int num_values;
 		int num_curves;
-- 
2.18.0

