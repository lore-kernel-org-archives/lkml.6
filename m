Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E644BC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5C8E21708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDnDEsZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5C8E21708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeI1IJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:09:48 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44251 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbeI1IJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:09:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id c56-v6so105688qtd.11;
        Thu, 27 Sep 2018 18:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=kDnDEsZa7fFmjs2Tk74lWl3fl5P2Nef0SknMvfCe9e49J965GiWsQxosf0mo+zj3kB
         0B39tgyLiAb6YPwF45t/zJShLbiJweqeUKY6+vZp22sdh2oSfT6zpnBEpv9IsbdJAL96
         kjotqyDRWMvvtf8X5A9ldWrAs8LHlSNjDUlsit/SLCTDmzwi6Ja+l39OY5a5E1t6H1V+
         htIjXGC57Gf/sq+gNRwjeQyqZU1sfl09I3MKRFJVEPy5oetgM0/02jwaMqn4MRbpA3z/
         a/Hd5FTtgwuLxUKjWcJ0WHWlar+2iJKhHOKgt/yOG6nRmDGy8qAXnXSMqPBdFTODP/jg
         0ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=az4VG2kDleDEIQbELh7WthCOA8Gd6LhdwtP9/ZvOfHo=;
        b=fucaNnsb2MCrYXicJFQVdBz4tlbbqlWyRpsaWZPaqwdHH2qBublHQ+7G7JmqJKaTgH
         MeceavaGfUuXQxjELFtWlMDuA+RYjRKH8TrhFXLNrkUyeyFdTiua/Mj3YNI7MwwVlfuB
         VP7XY0PmsmEM6Q4DO4rwX2FoaNjQgsHYRgT3stsFiiK+4nl9rMB0SvwLM0UR0cafYneE
         4tf6vkTwq22l11w14/x/FSqW6ok8DvEtsPMYL7I3bk147MXczhoeLnf0TEs8++z5sLZS
         2brj9ZwcUIkpAvDX4VDhx+nF85fgD/uwYmClOwmJ8/tlJ7YM0vq06U3E8bF5hIGSEYrj
         9Lvw==
X-Gm-Message-State: ABuFfogyv9/xhI7AkmKBt0QZ1tTYNz2UKyPss72wi4Ngf5txIZzMfoDi
        kazy+uwNy3nzdFOKKFNkj+E=
X-Google-Smtp-Source: ACcGV61GwrxPTv8Vy9LRQU8saNNx3O3W4U08M1DWAZpwwLzXFcn9KqlruyadY9tbVqyMzvXnocjS2Q==
X-Received: by 2002:a0c:8834:: with SMTP id 49-v6mr10283618qvl.40.1538099313552;
        Thu, 27 Sep 2018 18:48:33 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o2-v6sm2538434qkl.63.2018.09.27.18.48.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:48:33 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:48:24 -0300
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
Subject: [PATCH v3 2/7] drivers: nubus: Avoids building driver if
 CONFIG_NUBUS is disabled
Message-ID: <20180928014824.GA10504@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids building driver if 'make drivers/nubus/' is called and
CONFIG_NUBUS is disabled.
Avoids building proc.o if CONFIG_PROC_FS is enabled but
CONFIG_NUBUS is disabled.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/nubus/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nubus/Makefile b/drivers/nubus/Makefile
index 6d063cde39d1..1daa51217e95 100644
--- a/drivers/nubus/Makefile
+++ b/drivers/nubus/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the nubus specific drivers.
 #
 
-obj-y := nubus.o bus.o
+obj-$(CONFIG_NUBUS) := nubus_all.o
+nubus_all-y += bus.o nubus.o
 
-obj-$(CONFIG_PROC_FS) += proc.o
+nubus_all-$(CONFIG_PROC_FS) += proc.o
-- 
2.19.0

