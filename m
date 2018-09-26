Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A3EC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1503208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evfBGTGw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1503208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeIZIDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:03:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:45187 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbeIZIDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:03:48 -0400
Received: by mail-qt1-f196.google.com with SMTP id l2-v6so15636475qtr.12;
        Tue, 25 Sep 2018 18:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=evfBGTGw/kRl+TJ3908uM39VEOlJAQ7WRhEwyFI2xxc6HM+7JUe7VEXal2h/DHJoqf
         bhk+Frv3ONDiT0qwax6pt9hMPDWKWzhqHGlub/cPG/tT3ex/C5alYiMmo6CQJAkNC1Qh
         YBDFofJbK0FaMWoAFmmzeIdDVO6d0fyrooRFlt+3Uu7Wf1JTKSEkOXIkjkaDMH9/Xe7Z
         qKMcatZdT8EWtpf/BQH5rVjTqR/yclReGpkEmEDOVlMBoxG0za+0/rTm80Qfl0Gl+i7s
         nMyQ5c6iJlxMWOOZ2mCDGByPEkrPUyzkhTrH5Ni57LpI6eLEpntMbjC2jsvGclXllN+i
         hKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=UAb82koJUru3xjb0CPohCP8QGMSpSYev3ABFomuLfos=;
        b=jYB5eLR+7vyjeW4uXohapu7aoHSiX3HBjjx0OyAycUatIE7hF5/aYtHt+6IZ8iedx3
         OU+2VYr71eiebphNQj17LQaLwTifv46SMZ5opYtcl10+tQTXCnJwarQEjk0l/sLOoPCL
         A26dJWqCOcE93G4rkik9hVkkfYsZd+wUWNNXgpivJ4KsNiJHbHMVYUOrnrCH1fIEoR5J
         HHHiJ/aF4k26LedtT+DGezTpGSYwoYFaqXZc5USlWE7AwMujtU9vKs+vK3ggbqyoZaNw
         5Zma6+5IDdnI+sNbqh/4UDMZQcbeUHM3GGEZnpCzppdMSeSDwkjvg0tiFHRlf6Esatz8
         mMJg==
X-Gm-Message-State: ABuFfohdp3uLQ9tfoyiwVtpXBov0ubX2e1VT9RHEuUGGUDxP/KD09OTy
        DnjUdrHuIDNQmjTnyD4LiWk=
X-Google-Smtp-Source: ACcGV62NRAo2ZdurZjS3+a13DVRgK9HSYy5phc30qNQqX4o5+6pn0bjwpDSMoWGZlzBycmakFAUK6Q==
X-Received: by 2002:a0c:fb4d:: with SMTP id b13-v6mr2804875qvq.162.1537926804281;
        Tue, 25 Sep 2018 18:53:24 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id c21-v6sm1960712qtj.22.2018.09.25.18.53.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:53:23 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:53:16 -0300
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
Subject: [PATCH 7/7] drivers: hwtracing: Adds Makefile to enable building
 from directory.
Message-ID: <20180926015316.GA14997@WindFlash>
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

