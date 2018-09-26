Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D86C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7288B208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VPf2R/0d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7288B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeIZIDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:03:36 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43613 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbeIZIDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:03:36 -0400
Received: by mail-qk1-f196.google.com with SMTP id v18-v6so5200228qka.10;
        Tue, 25 Sep 2018 18:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=kvn7jntSbpyZYSyKvpa0GLBcuUphn3p989QYl+ADtiA=;
        b=VPf2R/0dkyyhlLnQQbV0H3qOVfJdZllY/vX0Q8Jc8Finp2MhgJyyOfrwJ0FCWXCuM1
         xL/9yQq59mHShtQKK5oJCpgWQ21jaU/m+zqheuiS6bzXNjVcLCqlSzQWy/WpLPJpIoUs
         F9HTIIgd2AT+tiO1VzRegBXRE7hNH/p6o1ORB4zc/UfV2lnW0UvSFySJYTKIheU1CdS+
         l9fGNeyYUHnmWz3FMNOPcD42HrK8kQzYgqwVy8CbNJDsuxAEM/iKtBISxe7ymz4Eldns
         UiwGYhNB+rmD9B0dJql43wcIK0EHC2e6m0ygYYIye05qGn0LnD3dJ4+l41v2Ef9Xanki
         quAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=kvn7jntSbpyZYSyKvpa0GLBcuUphn3p989QYl+ADtiA=;
        b=LOH+E2OIrCMCFLQd/rEB3G4YsGH6sgmhM7oIE1AV7v9CEMtd6A0sjsxChG+WxzuuYJ
         l/5BjZsGBVDtTb2osCy+ZsjXevRlWVFdqMiljXEi5j+T/iLAYBxzEG4Wu60AWmw9ln1c
         zvQ4U9yGA6pljOxRG6mhl8DeIC+iLtMi5n5HQ7lgDVYvedRjtWtYByyx0z+k2tBnn08Y
         lHz01RwXt7ZuNCDc47NnycZ8ndgG5TEqXEa+Gvz0btbYQh3Hl+NB9r4ALdQEEF1Oa5RG
         OoGWq0+oiq/ABCrqgiyrvE3UETVZ1NTKNoWQgTVcaVxIzSojMo5Uo8afBJ/npxSTMNFM
         Eq8Q==
X-Gm-Message-State: ABuFfoiBzGrz4+ur6BKsc0QDcwqpOYahV+5IAeCMMTf0MM0cL8m91UHv
        AkFMExbm4IcNlEEGYm5L6Tw=
X-Google-Smtp-Source: ACcGV63Xe01CTftNrl6zHk5foKXVj+7d8uIiUEiwpBiumC+jIM+F+wFKrVW/7qU5gSvQMLCOYrlLIw==
X-Received: by 2002:ae9:e64b:: with SMTP id x11-v6mr2752267qkl.41.1537926792557;
        Tue, 25 Sep 2018 18:53:12 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id r4-v6sm2067788qtt.92.2018.09.25.18.53.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:53:12 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:53:05 -0300
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
Subject: [PATCH 6/7] drivers: oprofile: Avoids building driver from direct
 make command
Message-ID: <20180926015305.GA14994@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creates new Makefile to avoid building driver if
'make drivers/oprofile/' is called directly.

This driver is usually built from arch/$ARCH and seems to have
no meaning building alone.

Signed-off-by: Leonardo Brás <leobras.c@gmail.com>
---
 drivers/oprofile/Makefile | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 drivers/oprofile/Makefile

diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
new file mode 100644
index 000000000000..6b36c93e9762
--- /dev/null
+++ b/drivers/oprofile/Makefile
@@ -0,0 +1 @@
+#Does nothing, since the source is called from arch/$ARCH/ tree.
\ No newline at end of file
-- 
2.19.0

