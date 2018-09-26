Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12459C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A41DD21480
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 01:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOOfxf/v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A41DD21480
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727223AbeIZICT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 04:02:19 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45258 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbeIZICT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 04:02:19 -0400
Received: by mail-qk1-f195.google.com with SMTP id q20-v6so10434883qkc.12;
        Tue, 25 Sep 2018 18:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=ulGHC4QQhwm75pxjmiUmW94PlIRpANSoQl6dsxZBdhA=;
        b=qOOfxf/vw6QuYn6OXzVz966/yociS5RE3D3Mk+TXi54qMJ3f4p6vIPEzZJBNzM8tmK
         Fw+M4ylAMUn4Pa4A082ufxmeaWZvwkylLz06kKV3VYRqtBFCeT6ocby4cFD8v7UCLd6b
         g/13OhJst4m82p4akDicVibISgNvA72iLgyquEDtDs31d+jVVTXgluanz5i0UXb84VRQ
         xc7TuG5njUtKcVO9QV26/yeqKLHVRXPQpRGQcptlzysDVyJiVF2AEFpJZh87knCaMdal
         hELPLc/XU29bWdZNKBy88X3XGsrrTK9FFaQW3u6r1mkAGyx4NM0+lNySI5LHhe/NrK2J
         mEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=ulGHC4QQhwm75pxjmiUmW94PlIRpANSoQl6dsxZBdhA=;
        b=gjXI94jE0LpThaBf7/980zJr9lYJTxNbhNEROl5/7S9Qhds0mQd4Frc30hyes+n34p
         o3oWDZX/CnVpEAOSJUug/6vIlkg3D4uU3bfKo39iySgClYeFXeqBAMUGUs6nLt1K8Sha
         UMFt15O1AimsQwSRusgzy54ViT6LCJbNr3Gy6ts6tv/LFXygbsYI0YXgUKtOSAh1WOOd
         6QOrFcND6sPnGYCoLVqK/Fs5UwyGQIclC0AOqKHJ/bSp1PA0/xEKlhNzNYXbR+SYpW1a
         OPTqH7YNHMKQQrZ9SHGvKXjIeMM0v/XWEMbioHWybJSAo28aKBwTG+m/uPDp1ymMFstu
         a6Vg==
X-Gm-Message-State: ABuFfogg/eNLAgstZpT0/pyaQ3fY0Tog4QNtYHCMxpGuKONY65n3YdKZ
        q9202DDnFFAVjtNoezmkxI0=
X-Google-Smtp-Source: ACcGV628m6ulXx8QTb4LVNUg0s5WKrSZ6AEv6p/7NgUwPQEg0/Li4BaeJ6RutDrsvHZ1PEQ1gFbx4w==
X-Received: by 2002:a37:2b0a:: with SMTP id r10-v6mr2729911qkh.292.1537926715838;
        Tue, 25 Sep 2018 18:51:55 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id y205-v6sm2275060qkb.56.2018.09.25.18.51.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 18:51:55 -0700 (PDT)
Date:   Tue, 25 Sep 2018 22:51:47 -0300
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
Subject: [PATCH 0/7] Remove errors building drivers/DRIVERNAME
Message-ID: <20180926015147.GA14862@WindFlash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This Patchset changes some driver's Makefile to allow them building 
using the command 'make drivers/DRIVERNAME', if compatible.

The changed drivers would return error if the above command was run
on them, after an x86 allyesconfig.

The main reason of this patchset is to allow building lists of
drivers looking for warnings and errors to be fixed.

My main objective is to allow developers with low processing power
to do changes in the kernel and look bugs using free services like
GiltabCI. 

If there is any interest helping/using this, I have a prototype in
https://gitlab.com/LeoBras/linux-next.

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
 drivers/nubus/Makefile     | 6 +++---
 drivers/oprofile/Makefile  | 1 +
 drivers/parisc/Makefile    | 2 +-
 drivers/s390/Makefile      | 8 ++++----
 drivers/zorro/Makefile     | 2 +-
 8 files changed, 15 insertions(+), 13 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile
 create mode 100644 drivers/oprofile/Makefile

-- 
2.19.0

