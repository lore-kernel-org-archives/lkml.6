Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C5BC43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3BA2064E
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 16:07:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="de4tER8P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3BA2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbeI2Wft (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 18:35:49 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35992 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbeI2Wft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 18:35:49 -0400
Received: by mail-pg1-f194.google.com with SMTP id f18-v6so3051187pgv.3;
        Sat, 29 Sep 2018 09:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:from:to:subject:mime-version:content-disposition
         :user-agent;
        bh=CzIhWaqzoGZ1kaNjYBIRFvfoy+gCaRmIBt4Dvxqdv7w=;
        b=de4tER8P+GxYLUEPMHFtW13BlVZUJh+0aXHYghJZfqPAqQ+gSywaCBZUaRaJuFZSmR
         OrAaMxCoo6fMLqel8RhYdaIVZpZZTYwzSKZTfZ+w3lp05CS0Fqs6OXPvCfJI9XBu/JFY
         mVE8mUBEmQ7689IgSXSo352j3xBgJKcoAFQu4qtA0jjptkqwM5027IHTz0t7As3zmyVS
         /xEnjyFnfKJ3gAC2jSPiLvY+j41zEeK7SGW5TBKWcIZiW8Z+mwUNBD7jQdBCLtLyZA6E
         egnMkUDPvY4DRZ2kicR6rjIt+eNVd64tGE2YsEjV71BG4A0j7zx/iWqfOuN354DGkjcT
         rMHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:subject:mime-version
         :content-disposition:user-agent;
        bh=CzIhWaqzoGZ1kaNjYBIRFvfoy+gCaRmIBt4Dvxqdv7w=;
        b=KYk+4vFpB1ic6skVP5xfeEzkPvgTIS1aJ1wSI48WL/i4WrnAp/Fd9JnVk+lsXApwEk
         42H2exanylUc+4dGKPfWcO/4H2qtH9OD2SiYoi3EbddikSs8vz6ezYvHvdr9u9syHR+i
         97OcmNwxdGL/YGlDaxYaAylgkk9ogpJ7y8sN92xXdZkEvfJjHSn/oY68jm27NbPqG3D8
         YVy/MnQrWLHJjbvJJJNCo+3H/a7K3U+bciqRufL4+FkOoJQbJCClvEHmkZ5ghxGSQEY1
         FDpOkkVCE6sLEUR/TsSLl2RHCKSTSQsdaRZHNCff1FA6FZSH7r7xpDo1LRdBkFjFh3fT
         M7xw==
X-Gm-Message-State: ABuFfoiLlxAD1AIM11wjpe4KVsGTHazHaDOdMYk+ucRm92bIrC9vamdL
        ofoThDYpaiVe1JrRBNiF1QLAqrk=
X-Google-Smtp-Source: ACcGV62hG3jz0LtNAR83TPKHq5ZM1G7k3CPH0PwJXA2LayRrKaPCCMqnchTD7NFNXX39exCfTVz90A==
X-Received: by 2002:a63:f202:: with SMTP id v2-v6mr1867351pgh.371.1538237211834;
        Sat, 29 Sep 2018 09:06:51 -0700 (PDT)
Received: from localhost ([182.69.157.96])
        by smtp.gmail.com with ESMTPSA id x4-v6sm11023935pfm.119.2018.09.29.09.06.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Sep 2018 09:06:50 -0700 (PDT)
Message-ID: <5bafa31a.1c69fb81.ff018.dc43@mx.google.com>
X-Google-Original-Message-ID: <20180929160646.GA6277@tapaswenipathak@gmail.com>
Date:   Sat, 29 Sep 2018 21:36:46 +0530
From:   Tapasweni Pathak <tapaswenipathak@gmail.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drivers: hid: Remove dead storage
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove storing of return value of ntrig_version_string function
to ret as it is a dead storage and not used afterwards.

Found using Facebook's Infer. Build tested it.

Signed-off-by: Tapasweni Pathak <tapaswenipathak@gmail.com>
---
There is another option to instead check for non zero return
value for ntrig_version_string() as a successful completion
of the function. ntrig_version_string() returns the length
of output printed by sprintf() after converting the raw firmware
code into a 5 comma separated numbers.

 drivers/hid/hid-ntrig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ntrig.c b/drivers/hid/hid-ntrig.c
index 43b1c72..22aebf4 100644
--- a/drivers/hid/hid-ntrig.c
+++ b/drivers/hid/hid-ntrig.c
@@ -159,7 +159,7 @@ static void ntrig_report_version(struct hid_device *hdev)
 			      USB_CTRL_SET_TIMEOUT);

 	if (ret == 8) {
-		ret = ntrig_version_string(&data[2], buf);
+		ntrig_version_string(&data[2], buf);

 		hid_info(hdev, "Firmware version: %s (%02x%02x %02x%02x)\n",
 			 buf, data[2], data[3], data[4], data[5]);
--
2.7.4
