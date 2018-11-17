Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF59C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2777C20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 11:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="NWSwkeHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2777C20815
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbeKQVe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 16:34:58 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40285 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeKQVe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 16:34:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id p4so18202644wrt.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 03:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=DeOKk2L7bKLXteIWSWMcRk/7avbZnCJV7cFfKOmdHmE=;
        b=NWSwkeHWqvIRMj7qPqrWicJ2ilNlAekfBTHMvUV4dbVEY1ymvv8kJ+JupJP523LDrP
         9TBOoaR/Ko0/DFKTb65EcvbB02EqtQRC9XKkeb4O9z9AKqnP1o75AIVuDbH39w6Tl9fN
         Vl0+UCfwyUXmVLUkwy/CnkkNaRLx4QE1HYvPsNWL01nC1HbkfP9Ad34C+k8uYCxWRlGV
         isTG02T6C1HHuzELyZIn2MPd7/phxRRnw2iNa+PmpjQF3kHKHezkvGC1sxvIG3ZT/m/D
         CSROXxgro8CAEUlno924e1Vfm94hwXyt6Gm4dLLg+1CI9zv8+UFmGd3skBPoycO5730i
         iQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=DeOKk2L7bKLXteIWSWMcRk/7avbZnCJV7cFfKOmdHmE=;
        b=gyRlI8326JrG9kRqigv6QNMes0OAb/EjF802hM9ksVD1NHVNaptI7cgCMh+wtjXZfM
         oerqlYtu3YrR/DNMCfLBInvxoSUclLiPGfsm8io2IyhYFFCoV80HHPjBuWTflTq4s5gk
         Gnk9FrjANl/UJUSF6tN36l8MQU0bmmZ+DbQljfz9xwlBkqKHIANpMtMxtOx/9B8advPn
         NNHAeDVTM9pVuagFurg1AzL0cnQuLP6AG5YX/wfY0TGfOFtnM/sSysbFl9s6r7pTN+AN
         fhBfmsTa2fQw6NdG0QcOX2Cdaoih0V/NXl/6xf4qPwu0kfTdTUhjzlFHQUsFyvTThtBB
         klPQ==
X-Gm-Message-State: AGRZ1gLgbiqS1jd2RSOKZMkaC0jbLJ4sfOjS5KhLk1g+GQt5+qojFSUJ
        jUCcAuAL3DGUM0MuQXmjxO1++A==
X-Google-Smtp-Source: AJdET5cjGLEucg/PiUcdvyBM7iIFDWiSxVru2OnanW/6awMLB7lqTp73Z69mNFIbMPeKRpJi0MBKCw==
X-Received: by 2002:adf:8b0a:: with SMTP id n10-v6mr11791416wra.282.1542453514380;
        Sat, 17 Nov 2018 03:18:34 -0800 (PST)
Received: from localhost.localdomain (176-137-58-115.abo.bbox.fr. [176.137.58.115])
        by smtp.gmail.com with ESMTPSA id k5-v6sm50797646wre.82.2018.11.17.03.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 03:18:33 -0800 (PST)
From:   abailon@baylibre.com
To:     georgi.djakov@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Alexandre Bailon <abailon@abailon.com>
Subject: [RFC PATCH 0/2] iMX7ULP interconnect framework
Date:   Sat, 17 Nov 2018 12:19:03 +0100
Message-Id: <20181117111905.29091-1-abailon@baylibre.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Bailon <abailon@abailon.com>

The goal of this patchset is to use the interconnect framework
for iMX7ULP SoC.
This is sent as a RFC because I think the driver could be more generic,
and, I had some issues with the clocks and I know the way I dealt with
it is probably not the best one.
In addition, this patchset has been written and tested on older kernel
(4.9), and I don't expect it to applies / works on upstream kernel
(the support of SoC itself is still not there).

There are two interconnects, NIC0 and NIC1:

     //==============================\\
     || --------------------          ||
     \\=|m0              s0|=         ||
       =|m1              s1|===\\     ||
       =|m2     NIC0     s2|=   ||    ||
       =|m3                |    ||    ||
       =|m4                |    ||    ||
        --------------------    ||    ||
            //=================//     ||      
            ||  --------------------  ||
            \\==|m0              s0|=//
               =|m1              s1|=
               =|m2    NIC1      s2|=
               =|m3              s4|=
               =|m4              s5|=
               =|m5                |
                --------------------

     -------          -------          
NIC0 | DIV | NIC0 DIV | DIV | NIC1 DIV 
-----|     |----------|     |---------
     -------          -------

Although NIC0 and NIC1 are interconnected, some requests could apply to
only one of them. This could cause some issues with clock.
Basically, scaling the frequency of NIC0 will also scale the frequency of
NIC1, so we have to update both of them.
Simillarly, updating the frequency of NIC1 may also require to change NIC0
frequency.
In order to easily deal with it, the driver create only one device for the
two interconnects, and update clock frequency of both interconnects at same
time, when the last node is reached.

Ideally, we would have two device, which would make the driver more
generic, but currently, I'm not sure how to make sure that the clocks are
always at the expected frequency. Doing that would give us the possiblity to
use the driver for other iMX SoC (would just require to add the bus topology 
for that SoC).

Alexandre Bailon (2):
  Add support of imx7ulp to interconnect framework
  dt-bindings: interconnect: Document imx7ulp interconnect bindings

 .../bindings/interconnect/imx7ulp.txt         |  17 +
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |   9 +
 drivers/interconnect/imx/Makefile             |   1 +
 drivers/interconnect/imx/imx7ulp.c            | 369 ++++++++++++++++++
 6 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx7ulp.txt
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx7ulp.c

-- 
2.18.1

