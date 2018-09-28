Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CCC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64F8021733
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G6OpdTRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64F8021733
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbeI1IKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:10:31 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:44321 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728123AbeI1IKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:10:30 -0400
Received: by mail-qt1-f195.google.com with SMTP id c56-v6so106896qtd.11;
        Thu, 27 Sep 2018 18:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=G6OpdTRqYZ/ftgzslyT+868KFJ9PQMciXC53c8cCGV7n8Gyx2L11fhInJk/tdxIZTS
         6t57nShbtQPMXYbRIrLRCck+dtU9tjk5wlJE/ozEZ9cTNTpuMO9IqF+lXTcxwBdY+5bb
         eO1SM6Zv6MEFeF583z5l8hqwRIXjLDrsepg+UrhIOfLHhjkK3TeaF9K0qBKaQCgBRknj
         kuPqq1FesfDgvCY1kFMCOJRPPteEFsMxdiwfSldxVc3vuYr2v69BuVG24oh3i7vPzstr
         3VNgDyGOZnDSFGZls0D5goG8Q3ItWRQ8B4OPbkeu9QaOUQezoRQyzFiWwbYnDd3O0ehY
         UyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=uB4LXuhQJi0GseX70IqO7nnihzJXM77bo93Te6F4mxFknFg/qmQNlbLnZJjSO2Hhck
         GZktUNGC9XSE3aEPY5bPY6ZQ7J2UCOE+uUKEIg2UbsZLghI3yYN0KJqT7S8F2mAGHqyh
         OqJN0UUeOqiQLfYC1WKbCR6gXYoxoRddukGrhb6ir6u3OCFkjpwFq0K3od70aHzKN16Y
         Pd520OCuI55lH224uwiuGEXlLzP7M7zY/q1fS8YxYIOJpIiXnYQ8oKbF5q2wG7GHOO55
         ZM1IamyWBU9zpqiVvz69SaBM/eCFZ2AeURpJT8t1U8ajcuvKtGqDNGWwRZz+3pUA8LTG
         9kJA==
X-Gm-Message-State: ABuFfohyAVdzU2hQ4uJH54KhLStjbtQtH3+I4ccsLTKyUvotHjY/kJqv
        mL5lS36xxAkodVDLXf5+nBc=
X-Google-Smtp-Source: ACcGV63JJni5LHR8ay51x9wvZnvcShrM4vrEw2oq/AxjXlSCVKVj7zLMPcLqCqreZ64PyYwhhrR+fQ==
X-Received: by 2002:ac8:ec3:: with SMTP id w3-v6mr6838557qti.138.1538099355961;
        Thu, 27 Sep 2018 18:49:15 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id 128-v6sm2233185qko.7.2018.09.27.18.49.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:49:15 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:49:07 -0300
From:   Leonardo =?utf-8?B?QnLDoXM=?= <leobras.c@gmail.com>
To:     lkcamp@lists.libreplanetbr.org
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Robert Richter <rric@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        oprofile-list@lists.sf.net, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 7/7] drivers: hwtracing: Adds Makefile to enable building
 from directory.
Message-ID: <20180928014907.GA10528@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds Makefile to enable building the driver using
'make drivers/hwtracing/'.
Changes drivers/Makefile to call the new Makefile directly.
It enables user building this driver without building the whole drivers/
subtree.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/Makefile           | 4 +---
 drivers/hwtracing/Makefile | 3 +++
 2 files changed, 4 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile

diff --git a/drivers/Makefile b/drivers/Makefile
index 578f469f72fb..a237be6b602f 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -174,9 +174,7 @@ obj-$(CONFIG_MCB)		+= mcb/
 obj-$(CONFIG_PERF_EVENTS)	+= perf/
 obj-$(CONFIG_RAS)		+= ras/
 obj-$(CONFIG_THUNDERBOLT)	+= thunderbolt/
-obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
-obj-y				+= hwtracing/intel_th/
-obj-$(CONFIG_STM)		+= hwtracing/stm/
+obj-y				+= hwtracing/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
diff --git a/drivers/hwtracing/Makefile b/drivers/hwtracing/Makefile
new file mode 100644
index 000000000000..fe5773caec49
--- /dev/null
+++ b/drivers/hwtracing/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_CORESIGHT)		+= coresight/
+obj-y				+= intel_th/
+obj-$(CONFIG_STM)		+= stm/
-- 
2.19.0

