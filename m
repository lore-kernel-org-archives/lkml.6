Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F00BFC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3F7208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tVQghfqs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3F7208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755312AbeFNN3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:29:20 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:36787 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755252AbeFNN3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:29:17 -0400
Received: by mail-pl0-f67.google.com with SMTP id a7-v6so3563945plp.3;
        Thu, 14 Jun 2018 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gk9vpMA1JXKxTPhEHh5XR6BLUoW/9jt7Va47frd5DNI=;
        b=tVQghfqs/6FWjU4ecjCFSmWb2yLRB44UAm6RsIcCG1fkNSoSwyRbxxtVTJhrC4VMUk
         gqjIgltWtiE20BXlaRVdRaqGwmG0E0dv2RY1ZqXSMA1wUfpTWLlM2GvrvaZmhpM5/sKp
         8qDqRw+Gi7iTx3JHSi/3QhT3x5Ojf+oq3m+gHASRH27Xwp+jMWdTo2byyt3+MqqBsF8b
         LmeueVrwkooXLvEAPbuXtmmrTadK8NppT2elMpygDMi3zPXG5128NrXD7KNeCCyKYTNA
         NEVkyWxBi7qW7J42P086E2HG0SH5guJ3yAz1wc6IltAlycCsXwznZomCseFby9MPjC2t
         4qnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gk9vpMA1JXKxTPhEHh5XR6BLUoW/9jt7Va47frd5DNI=;
        b=h4ySJUrHEtk0Tuitr/KfARJCkIA3Uha5rUpV4giF69bIl0OmNZsbxaUOJv7U0mxiLs
         cu7JvXggwM7V2+Xk5f9pi0SQkkBQ82Rv84DMZYuJvPnnseYGuQXCh5MlSYJosqvY8/85
         O6YaWtzEIH7Ol7Wt6pSh6TEjine/9bE7Bqwp2l1v2gzujUCnUgqAdoZS6acTMvtqEP9A
         MUPkX+0Hdj18lTqVIkF15m/EFplkDl/+oLcxZVMQD9VvuDui56GzJ6k0KVvN0ZwMVBhv
         7LijDkTAJ3EzgOrzzeT3xAbXnUuh8KxFUuuMhGPEEC1FO39FhU4HC7ytphl8fd6KsycW
         lsSw==
X-Gm-Message-State: APt69E3DrZXuqucTMQ2GKh7gfN+sRZtOEhBRHao01oe8uq8rAGW0umIh
        oMN0MJgKjltzgxVSbEtbNkE=
X-Google-Smtp-Source: ADUXVKLjYpOz/gvBEWGlZajh68cGJaCDhmFZ02Is8eVCXK4AgjNesQbNzrP6fP+yQIkadA7i9sQ30g==
X-Received: by 2002:a17:902:784d:: with SMTP id e13-v6mr3005731pln.197.1528982956606;
        Thu, 14 Jun 2018 06:29:16 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id t23-v6sm11041342pfa.86.2018.06.14.06.29.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:29:15 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: storage: add error handling for kcalloc
Date:   Thu, 14 Jun 2018 21:29:11 +0800
Message-Id: <1528982951-52753-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528707147-35623-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528707147-35623-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kcalloc fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kcalloc.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
v1->v2:
- Remove pr_warn statement.
---
 drivers/usb/storage/alauda.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 900591d..4e17609 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -437,6 +437,9 @@ static int alauda_init_media(struct us_data *us)
 		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
 	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
 	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
+	if ((MEDIA_INFO(us).pba_to_lba == NULL)
+		|| (MEDIA_INFO(us).lba_to_pba == NULL))
+		return USB_STOR_TRANSPORT_ERROR;
 
 	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
-- 
2.7.4

