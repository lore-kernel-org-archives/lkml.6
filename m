Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F2EECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B8B20856
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 22:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeuVP3Ye"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B8B20856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbeGUXXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 19:23:14 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39447 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727974AbeGUXXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 19:23:13 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so14350764wre.6;
        Sat, 21 Jul 2018 15:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-disposition:user-agent;
        bh=nLLJ7UvuzAOkFI85J3ZRaF0FnXzyG1XcDXFinlq67NY=;
        b=CeuVP3Yev56Xd9kQerRSurjJOG2uvjxaKuPw+/vQYj4xSGB5yT4fZrTsbv0NMXkX2Z
         0OULniPWvzJV6uR/KqplWBxGat+lbvmN4ApifYX3RWQZpFxM8Op5frRR7C85QmZmWvo9
         QvwsHTtfAC9oXgYKNdo85N8PnuTFUniW8WzRIf4zsJxlKicwr0aXM77uQ07Ec5FwafWW
         TalQPnAdpvFAoO0ivAlwl+QC4IKaJpajXtOZPG20xabYmcHNvbpvFtgJ1jO99Mg5cukE
         3YAyiP47X5JGz9mObmpdR/HiEcBonYSqN110IHCfJk8PsIVT5RGWpwFIvBK4basQ44NU
         s1Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mail-followup-to
         :mime-version:content-disposition:user-agent;
        bh=nLLJ7UvuzAOkFI85J3ZRaF0FnXzyG1XcDXFinlq67NY=;
        b=PxwoHrrlWhJEVunLJhPnHGpysxRjQ8zFIlNE7VKP/hmyY+h/BjeqzO/EWAhcaP8a3j
         rty4v1eol4eUXFnGrPfNXDtdpMTzPpDSXbdR+nmqdJrsVMHLUPTgWts8Wpxsbzyo+E/2
         ZfocJqqubRS+lP074AH8OA4IkNDUQXhZzyylwgkwI81Kq22tg4AAb1k3Z0FThCf9e2om
         pkQlFbiVHZzVuru0iDI+Ns5UyQH4us/pXqLUqyi36SkQkwcTmyFyHRNhO0698ELlPLjN
         NyaObpFi9wzpZNF60xZb03icki0fzJ8QOF/04b50L82Jikwy57P3A8lTW91FDUC/T0uS
         rg9Q==
X-Gm-Message-State: AOUpUlFyN9F33Ym/QoP/n+kiIRivTJWYr7rlPzu/DYYENYPAILgy8JJB
        OSsnro9/rhVkuJ+Vx2Kus8bErlvV
X-Google-Smtp-Source: AAOMgpfU0eUjLsMW7UFzqw5guj94CtN2DAi7eDkm39In68tH/j4vvzMYaGiHi1OLtn9wIzZSBLXRbQ==
X-Received: by 2002:adf:f410:: with SMTP id g16-v6mr4716289wro.256.1532212133146;
        Sat, 21 Jul 2018 15:28:53 -0700 (PDT)
Received: from vnote ([95.72.113.226])
        by smtp.gmail.com with ESMTPSA id s16-v6sm4594565wrq.20.2018.07.21.15.28.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 21 Jul 2018 15:28:52 -0700 (PDT)
Date:   Sun, 22 Jul 2018 01:28:49 +0300
From:   Eugene Korenevsky <ekorenevsky@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] genhd: register_disk: inform about dev_set_name() failure
Message-ID: <20180721222849.GA23331@vnote>
Mail-Followup-To: Eugene Korenevsky <ekorenevsky@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although dev_set_name() failure is not fatal, it is better to print
a warning message into dmesg about it.

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1543a45e73b..071f8cbd529a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -577,7 +577,9 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 
 	ddev->parent = parent;
 
-	dev_set_name(ddev, "%s", disk->disk_name);
+	err = dev_set_name(ddev, "%s", disk->disk_name);
+	if (err)
+		pr_warn("%s: cannot set disk name: %d", __func__, err);
 
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
-- 
2.18.0

