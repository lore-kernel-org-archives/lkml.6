Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D78C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B580421A11
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 04:06:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tmATHwMG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B580421A11
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbeHGGTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 02:19:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41885 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeHGGTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 02:19:15 -0400
Received: by mail-qt0-f193.google.com with SMTP id e19-v6so16407441qtp.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Aug 2018 21:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kQV6zEtGqPr1hm3IA0PBNEcJhm4Pp67CFlGEuRpOYh8=;
        b=tmATHwMGEUs/EcWkpy1rIwOw96bHEXJFv84ZWDsZdW00IEO0IGBkJongUJYnXF8CtK
         XPb2hXSM3fGlaHIJPjKnq7ZF8LUyLbDjQEkIeNRDrIussWAWsnGGKMdvMp2pHXkOcDtq
         oZ4Bv14E7eqyK96Eovz6m/caMPUOnutlWced95CmAN34mQzqmfh5TuYiXy4q++VMIDiD
         XAo+Rb3VMhel12G9JhSCx8BH7DZTriNHqoy4wtX8sWPEpVUzhSieVlnHJeEGvM5P9m7H
         +LgBkVTi06+vEYp3C+tNSiinsx8vHNyiGnY+Ezn4JFoc9oLzpks9CnTyzQxzpXiggcAO
         /ruw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kQV6zEtGqPr1hm3IA0PBNEcJhm4Pp67CFlGEuRpOYh8=;
        b=Jr18uHA7rEGrga5C676Z/i+NsY/1s0NPoHqYgj1YifBtGGDuDtCdC09oBBZlUSuHrt
         IHc6j3lrmyyMYpc75N904ewm7SzILQ/FlEBQW41IUIi9k4OsUlKaHAdnJFbwTKnN4GPJ
         F4TRHDkIoxNpsgChJ5WJzSQFgRXYg0asz6m4HEyBpohqmThObbjQTOuPFTjnvMHmvsX/
         s4i7m8qf+12EO5TPyitM53dgWXvlV9w22JsBZm4feP2/K7HiXTCKIDyXJuNQjvIkLXnt
         mL73XZYbn3zjkiDDt1xAUiiKSXL6JOP+aA4aawCNovvkqa8qjch0oI66d7aequCXmdQJ
         Eqig==
X-Gm-Message-State: AOUpUlG70wW/5545bZKTxYj8MxQp0oos9EavZ5u2f+ddLzYNG4tFeA69
        3dIZ4oLtkjINBJM+NlJ5xxs=
X-Google-Smtp-Source: AAOMgpcNs05t+p+hDxqXi3jrm1gDgXrMOLQCMWOojqtXM7q0/+x0W9IMG2upRj4HgMTtgdgMasKxqw==
X-Received: by 2002:ac8:1970:: with SMTP id g45-v6mr4171961qtk.188.1533614813929;
        Mon, 06 Aug 2018 21:06:53 -0700 (PDT)
Received: from WindFlash ([201.82.148.26])
        by smtp.gmail.com with ESMTPSA id l22-v6sm174681qkh.72.2018.08.06.21.06.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 21:06:53 -0700 (PDT)
Date:   Tue, 7 Aug 2018 01:06:48 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] staging: fbtft: Includes description to mutex and
 spinlock - Style
Message-ID: <dce7690123f0a71e3391e31c30b5c67b076093a2.1533614243.git.leobras.c@gmail.com>
References: <cover.1533614243.git.leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1533614243.git.leobras.c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/staging/fbtft/fbtft.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft.h b/drivers/staging/fbtft/fbtft.h
index d8e7204a8d74..3f3dcd96f9a7 100644
--- a/drivers/staging/fbtft/fbtft.h
+++ b/drivers/staging/fbtft/fbtft.h
@@ -207,7 +207,7 @@ struct fbtft_par {
 	u8 *buf;
 	u8 startbyte;
 	struct fbtft_ops fbtftops;
-	spinlock_t dirty_lock;
+	spinlock_t dirty_lock; /*Protects dirty_lines_{start,end}*/
 	unsigned int dirty_lines_start;
 	unsigned int dirty_lines_end;
 	struct {
@@ -223,7 +223,7 @@ struct fbtft_par {
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

