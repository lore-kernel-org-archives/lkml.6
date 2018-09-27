Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B880C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF602156E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShiyD3Ut"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF602156E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbeI0H5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:57:37 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:40936 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726922AbeI0H5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:57:37 -0400
Received: by mail-qt1-f196.google.com with SMTP id e9-v6so1080432qtp.7;
        Wed, 26 Sep 2018 18:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=CzCnr08q8AXxDBV5AnX5g7J5d+hw/S8rc+cNPIu4E30=;
        b=ShiyD3UtGnwft2HaEDtEh52aOy7+HNXwP5G3zf26dcF+t+0ofNxJsAblVBFGcHC1Zt
         AOkyu4MqymOfg927YMI36Z8l/gtgou1t8ILusRRh+qNosvPwpGLSr48ejYNmseREE4Zr
         PC3alx3s0uR48oWqBqHOnmcJAgTIu/63oIjbMRH8lA8fNLd5vWZhyVFFjOQ7fRG8jqjF
         wEIRISAUAJno26gq3V+ZnrD+clCVPb7kRYA9Ho7cYf9S8FhJKrcUTWiIv2mRwl4YOzdF
         RQsHOGnWRlO1uPDG74ycjViokRMZi3FBowlkT4KUYthxsnCvcrR1A1tRspHURmTEnYlZ
         tqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=CzCnr08q8AXxDBV5AnX5g7J5d+hw/S8rc+cNPIu4E30=;
        b=SZ8no6Iu6ePXTS4VHCz2JncxYCPb8Te25M1bqHhPJHA9JGIFaYg+dFosQUfLXBt6nN
         PnfuWMBfjmHVgmFw244WOYAzWWReHOPtW3QqoL01S3FO4r0VcMk2RPga24vqycQ7tPe7
         ibBUjb3qfUSoWCN1VLAn5HUXmpLFsPaS5UuaEqjPBrXs+waWmGo5fK06oLl5WKs0gc3y
         E3ZzVk4AAN7qFHJEY5bJEPyZbbTbD0FuGGc9yzZ8zVQwnW6IUQsgh8FdBMmjN039L51G
         KqR+AS99TaPpXNpl3DvpL/6ToaisO0pWA9Xw0UR2zc9sl9eE8NyV1wwLf3pubAwNqUJB
         ioXQ==
X-Gm-Message-State: ABuFfohchqQUVVjfEYXt7Q0KCPE9OwoI6I7tmqQchVj31s0vrE7a4xxZ
        tYCllmQnO6llVSGYre9QAok=
X-Google-Smtp-Source: ACcGV61guLxOorFBKyrdykcb/srxmdUkw5Bb8MOLQmA8CejweC/0gxD4XEKssPdEGdo5id1Nhru8/w==
X-Received: by 2002:ac8:3f56:: with SMTP id w22-v6mr6980214qtk.151.1538012510418;
        Wed, 26 Sep 2018 18:41:50 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id o2-v6sm438617qte.16.2018.09.26.18.41.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:41:49 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:41:38 -0300
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
Subject: [PATCH v2 6/7] drivers: oprofile: Avoids building driver from direct
 make command
Message-ID: <20180927014138.GA8988@WindFlash>
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
 drivers/oprofile/Makefile | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 drivers/oprofile/Makefile

diff --git a/drivers/oprofile/Makefile b/drivers/oprofile/Makefile
new file mode 100644
index 000000000000..acaed2ad6eee
--- /dev/null
+++ b/drivers/oprofile/Makefile
@@ -0,0 +1,2 @@
+#Does nothing, since the source is called from arch/$ARCH/ tree.
+
-- 
2.19.0

