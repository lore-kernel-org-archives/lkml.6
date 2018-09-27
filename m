Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4AA4C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FC1D21566
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 01:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByDxL5et"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FC1D21566
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeI0HzR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 03:55:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36601 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeI0HzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 03:55:17 -0400
Received: by mail-qt1-f196.google.com with SMTP id e26-v6so1106470qtq.3;
        Wed, 26 Sep 2018 18:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=5go+oaIqr2Jp5Hbi98ghcAbeh9VmtpnhlU6dDnKN42U=;
        b=ByDxL5etxmnJyTXXTfNAYws/OaZVxOtA8xxLheMa743t2+bnN2m+NOSMAn+uPr9XzW
         iaa/9HsuNZ9Q0vQ2zlU7HSAImsvwF8xLtAfjq/ricu9pku4VOeYhK2a5W3gCbZYqlVKq
         jisZtNmrQ7KNIrr8a9F+cs1YefLkkqdEGWmHkNdC/1JyScom3O/N//EGrp/P3fFKtxNR
         9DtTY1jdpogwA22g29dlaHNcNCRNMDkiMf9zmieb28VGr0qk32LkkV36rTs1h0UvjL3c
         Du9SUzME02Hv7VDj20ldRRhd8eXQozQed5BO4jOcuNUU7cN+wXZTv9FefEbf6brhNcT1
         4enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=5go+oaIqr2Jp5Hbi98ghcAbeh9VmtpnhlU6dDnKN42U=;
        b=S3D3Bb+Ve7OAd/j5KUXDY9sFex3tu+XFBarjLukiGVYlcC+660ths59AN8S/Dj3YlQ
         6hYLRtUL3mfD0Sbhva6j59lf5WiJCLx9YfVJYLCr6Ute3O1n1KlFr9JQH2HJHBWD1Z53
         P+iEUGGB+TPklvQujvmY/F1bCa/lhJuypGQFtGJ464T7+Mr4qbEVWGAMrMTuR1ZaAoaF
         2z5erGWCP0X/vqKOQL5UMg1w2H4apv6pyHJ8sJqY/Vl9xnQea1lIqLTo7oBFdPwFnS6G
         GoctytU6+vdKrf0bC8Aim19zIidr/JwOGotigRTw6xaqgHTkeNUD9Wn66mBOPZvqJlTQ
         anxQ==
X-Gm-Message-State: ABuFfoi2GEy7GrzxnfKQyafCp9evBnOsPbejY/TtWBbrPbR5CjsNTqH+
        9mUbmdMuVkDN75KGoiY+p4w=
X-Google-Smtp-Source: ACcGV60YhnjCUUisYDO0f1a0973E7dD/MX5NAkPGb1zTORvSHOvDWkqIO536iuoK2LiHl8n8Xzl2Vw==
X-Received: by 2002:ac8:1967:: with SMTP id g36-v6mr4955911qtk.193.1538012370754;
        Wed, 26 Sep 2018 18:39:30 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id w5-v6sm454102qkw.69.2018.09.26.18.39.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 18:39:30 -0700 (PDT)
Date:   Wed, 26 Sep 2018 22:39:20 -0300
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
Subject: [PATCH v2 0/7] Remove errors building drivers/DRIVERNAME
Message-ID: <20180927013920.GA8950@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Special thanks for the feedback from:
- Finn Thain (I fixed the build problem) 
- Geert Uytterhoeven (The cross compilers were very useful)
- Rolf Eike Beer (Was unintentional, thanks for noticing)

This Patchset changes some driver's Makefile to allow them building
using the command 'make drivers/DRIVERNAME', if compatible.

The changed drivers would return error if the above command was run
on them, after an x86 allyesconfig.

The main reason of this patchset is to allow building lists of
drivers looking for warnings and errors to be fixed. 

I see this change as a new feature, not a bugfix. I understand 
the default bahavior may be building with a simple 'make', but I
believe adding this new possibility will not be harmful.

My main objective is to allow developers with low processing power
to do changes in the kernel and look bugs using free services like
GiltabCI, before submitting to community.

If there is any interest helping/using this, I have a prototype in:
https://gitlab.com/LeoBras/linux-next

Leonardo Brás (7):
  drivers: dio: Avoids building driver if CONFIG_DIO is disabled
  drivers: nubus: Avoids building driver if CONFIG_NUBUS is disabled
  drivers: parisc: Avoids building driver if CONFIG_PARISC is disabled
  drivers: zorro: Avoids building proc.o if CONFIG_ZORRO is disabled
  drivers: s390: Avoids building drivers if ARCH is not s390.
  drivers: oprofile: Avoids building driver from direct make command
  drivers: hwtracing: Adds Makefile to enable building from directory.

 drivers/Makefile           | 4 +---
 drivers/dio/Makefile       | 2 +-
 drivers/hwtracing/Makefile | 3 +++
 drivers/nubus/Makefile     | 5 +++--
 drivers/oprofile/Makefile  | 2 ++
 drivers/parisc/Makefile    | 2 +-
 drivers/s390/Makefile      | 8 ++++----
 drivers/zorro/Makefile     | 7 ++++---
 8 files changed, 19 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile
 create mode 100644 drivers/oprofile/Makefile

-- 
2.19.0

