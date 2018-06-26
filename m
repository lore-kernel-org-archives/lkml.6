Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34F6C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9639B21533
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 08:15:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESoTgQ7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9639B21533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752953AbeFZIO7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 04:14:59 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:40183 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752729AbeFZIOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 04:14:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id q11-v6so16645505lfc.7;
        Tue, 26 Jun 2018 01:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NLUENMCP+YGnFekmvRWbrqOHzMNMhFZNAfuFGGxCKok=;
        b=ESoTgQ7NPmrRMVEKzvArxChKkAoemWz7Rq8jNRPLREuKiazpCPR51L4oHhEhGXjgs0
         zr2SVCv8s+gVMzTPZiw3/4bxseN1kYkQCptTLxiLp03n7Ue9+NC1348BWoHWBDnFtdpJ
         Odp4/2RNWEW8BrVSHdd14erihHYhSQcvN5+hFZoAEph494zXtqdcBX3R5qCkZMFF7rVb
         XqDjUFYtDbOBZCGzYBu4lVAnqCn837LB9gvMX1sIrfnsrUIc5pG3YHa7t2ej6SftuEYi
         r38sB/D5+APMAgVzGUitc0oBNqabygAvqVdYAi/XefBB7pccvVFsNHs07/uF/9TkZHoO
         jpSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NLUENMCP+YGnFekmvRWbrqOHzMNMhFZNAfuFGGxCKok=;
        b=YAdoQsHftCkgEfM5wUBXc2qRfoKUIZrhTkNvcMjVaWWLSnGhPczTBIGIFhkY1/QYaT
         gZgYv38cjdlY0exs3qnS3TADVvp8YSHGrbHM/f9DPVVFYvOHjRIMc7EA2YtlJRgiM8/6
         U4vE872oBu1X+UyktcpBVz7HIDb9jkMZ4bwVk9Z6j7ImzuSrM6aBJu5tVolswprsxV13
         LdVqMyJxvER9FTijPOzT/6yg1XFwEIIz5SE4pUMhFt9dkMxECw45AMYUpQAORDNGVJw2
         s0X54O6WuAMhHQAXGby8O3jiDi/BT6zxpWvjMrhbzr4vbb7ivNap91dU3LqS+xkvmEOa
         Dp8A==
X-Gm-Message-State: APt69E1YMoj5GNIKH+E+aQkmewVBEEQUQxkfu6dvxHSXCuAkZFqMgNf2
        24k2V5+7wWY2VXySm9BSi7T6tzge
X-Google-Smtp-Source: AAOMgpdomXWyE8mnEyEeJ2rOKwRjQ+XDsE4mUtRuD6erhUhivvOdMUUgZ/66F8Bh80hyiWqAlYMoFA==
X-Received: by 2002:a19:1a52:: with SMTP id a79-v6mr492004lfa.43.1530000882814;
        Tue, 26 Jun 2018 01:14:42 -0700 (PDT)
Received: from localhost.localdomain (c-2ec26030-74736162.cust.telenor.se. [46.194.96.48])
        by smtp.gmail.com with ESMTPSA id p28-v6sm149783lja.13.2018.06.26.01.14.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jun 2018 01:14:41 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Felipe Balbi <balbi@kernel.org>, davem@davemloft.net,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH v4 3/3] MAINTAINERS: add USB CCID Gadget Device
Date:   Tue, 26 Jun 2018 10:14:22 +0200
Message-Id: <20180626081422.19237-3-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180626081422.19237-1-marcus.folkesson@gmail.com>
References: <20180626081422.19237-1-marcus.folkesson@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MAINTAINERS entry for USB CCID Gadget Device

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---

Notes:
    v4:
    	- No changes
    v3:
    	- No changes
    v2:
    	- No changes

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 078fd80f664f..e77c3d2bec89 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14541,6 +14541,14 @@ L:	linux-scsi@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/storage/uas.c
 
+USB CCID GADGET
+M:	Marcus Folkesson <marcus.folkesson@gmail.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/gadget/function/f_ccid.*
+F:	include/uapi/linux/usb/ccid.h
+F:	Documentation/usb/gadget_ccid.rst
+
 USB CDC ETHERNET DRIVER
 M:	Oliver Neukum <oliver@neukum.org>
 L:	linux-usb@vger.kernel.org
-- 
2.18.0

