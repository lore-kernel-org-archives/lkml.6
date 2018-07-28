Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34521C6778F
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF35E20893
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 19:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cq9EouqH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF35E20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730645AbeG1VV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:21:26 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:46013 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeG1VVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:21:25 -0400
Received: by mail-oi0-f65.google.com with SMTP id q11-v6so14831493oic.12;
        Sat, 28 Jul 2018 12:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:in-reply-to:references:date:message-id:subject:to;
        bh=KkAbw+Mw09t7cvlydwjLaLcheYiualng8Isu+fZqHhs=;
        b=cq9EouqHSVpxSwdgaHg1rQa2D2/CG0RirA4IWRTZvji7k/FXSY2vCf4oV9qCiVBCqr
         x60OEyKUk2inPREDBA2vqnRfHoqVoG18ldb1HTAV6izPAPXyNKqfhflWEM/J1kOSS1T4
         rnzBm+ivO3ORCsW9Ucpr5L53iFQ9ooXC14K7q4gjjuRc5PW/2a0zKWKKNBFwuW1W008H
         sP4x6hoDPSye7j01VasC1Zi26Al7hCYxLG9k26D/9sURvXvXexAVGaS6Lb6n2IIieSAg
         axHc6HlPw+emvc1f4YjNqIPZH/3MsxEf8+46JAEfBPxNo74bR/o7o+o0L7KnqvTsDVpA
         NQpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:in-reply-to:references:date
         :message-id:subject:to;
        bh=KkAbw+Mw09t7cvlydwjLaLcheYiualng8Isu+fZqHhs=;
        b=ZbvgoYQTerhu+m8YC6TlEa9w3rvkAHH4s1mITmRphWLhIQenhdeuXRoS4xgJ1K9s3P
         rxoOMACO6H9TqdafGnnx6XYjoAsHY/+Ez2jvmv8wZopGZEY2J0G4HMsTjtDtYBgP9Nlg
         ixo7YN4/iLzaXRv8ws+3l1yH2xjCjHysOrih3MaXK8soYWd/Qv4Ix9/QC8R3UaCBLK7i
         Gv4y4iILvY2XKv1DsK5T+s/e/xtYARfmM8lcUkohpB72f4HHx0xlEgUJi6PJjmU5nSnT
         hQCH9/5bmDdDq9dVT0XLqAS2b8Hns+HPf/CwwTPk7kVn+i/DXv2BM6FWSFviHvuf0uo2
         Wm/A==
X-Gm-Message-State: AOUpUlGG0hWxhKCvHhcx+y++SJYlVQpyvgHEa7mvha0VTo1etK6vNnhh
        czwn4g8cUjRzV0Zr74/9WWgDODbPcMOaA/UvVdhHYk2q
X-Google-Smtp-Source: AAOMgpcXgR4Y+10oOZd+eB//CKSTWtfCT88xhojDWQIE/QuoUUSD7LiSdK55dcTHPTm9rUaSgvd1Lw6CmD8BEGv3TQM=
MIME-Version: 1.0
X-Received: by 2002:aca:5c85:: with SMTP id q127-v6mr12518890oib.127.1532807629701;
 Sat, 28 Jul 2018 12:53:49 -0700 (PDT)
Received: from 329980741037 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 28 Jul 2018 15:53:49 -0400
From:   John S Gruber <JohnSGruber@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
References: <CAPotdmQtXmfHJfcgrXZ02NrPgS3Az=SpZnBsRZ_8dGvPfdi+Mw@mail.gmail.com>
 <1532807605-26023-1-git-send-email-JohnSGruber@gmail.com>
Date:   Sat, 28 Jul 2018 15:53:49 -0400
Message-ID: <CAPotdmT-zCVL=hoV0y83bbksTQ3AWsCybzisL8B6n-OB-M645g@mail.gmail.com>
Subject: [PATCH 1/2] HID: redragon: Fix regression in non-Redragon keyboard
 due to this new driver
To:     Jiri Kosina <jikos@kernel.org>,
        Robert Munteanu <rombert@apache.org>,
        linux-input@vger.kernel.org, benjamin.tissoires@redhat.com,
        dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org,
        JohnSGruber@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Redragon keyboard uses the second device being presented, but other
devices with the same vendor_id/device_id pair (0x0c45:760b) use the first.
Don't cause its deletion. Problem introduced in commit 85455dd906d5
("HID: redragon: Fix modifier keys for Redragon Asura Keyboard")

Fixes: 85455dd906d5
Signed-off-by: John S Gruber <JohnSGruber@gmail.com>
---
 drivers/hid/hid-redragon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/hid/hid-redragon.c b/drivers/hid/hid-redragon.c
index daf5957..85a5fbb 100644
--- a/drivers/hid/hid-redragon.c
+++ b/drivers/hid/hid-redragon.c
@@ -55,10 +55,6 @@ static int redragon_probe(struct hid_device *dev,
 		return ret;
 	}

-	/* do not register unused input device */
-	if (dev->maxapplication == 1)
-		return 0;
-
 	ret = hid_hw_start(dev, HID_CONNECT_DEFAULT);
 	if (ret) {
 		hid_err(dev, "hw start failed\n");
-- 
1.9.1
