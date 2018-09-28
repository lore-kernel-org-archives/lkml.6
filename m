Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D835AC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 880C721708
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 01:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J+TeraBD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 880C721708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeI1IG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 04:06:59 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37527 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbeI1IG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 04:06:58 -0400
Received: by mail-qt1-f196.google.com with SMTP id n6-v6so5022684qtl.4;
        Thu, 27 Sep 2018 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:user-agent;
        bh=LZGk7PgCdjrbqQG3oM6AhSpqvwyDq4O1Xo1g7NqXKqw=;
        b=J+TeraBDlS01cr0TmhcvWkQE2WY5QJZ7V1FNTBpKHgSCV7BrCHhOoDxhOEg58KZz0C
         r4Z5X3HRDdGLJVxqSFAW5hztLVEZNHZLzCeqk58ON0ZgWBGntUJ4y0pE/pMkP7tDicV7
         16KYxMRh3lr44fATMvVG4Iwss8kTRG2ra+iT6TaNFpruE0H1L/zmzqARMYYW0C61UAVw
         ToC4V6CvEdsbzwmWqSIesWd/La58VRI6u6HKz+G9LN0vLNcyvqVBJKJYVjNtBrDURd4A
         b/GFirX58rRCmXudYYP0x9IK2UO4v7sO1d6Ik76qoBkcEH3Fr0r4DLfU9UXVMWdVC0G5
         4tHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:user-agent;
        bh=LZGk7PgCdjrbqQG3oM6AhSpqvwyDq4O1Xo1g7NqXKqw=;
        b=ncn+OSvNOp1XFsGCdastWrJQG3QOzFi8aXJMRXHdksg4NvvfKWb31IILGTazLWH7PS
         PwFLTVnpJSHVj3rII2+owypMm5k24m2E3Yd1XCXF9MSTTkFa/mAopiiytNgrmWk8rpWp
         TIcgFEgVUC1sUSX5j/IqMLdKrMms2MccqE6wmS+o5mOYf0JPmkmQaeMLyC+gcvj92xLv
         8zfrqVFoAMU/5tHl5ke1i0X8Kp3MO7g/someNysbCAZesfIMoZtaIrJ/iXjePj6QmsyV
         mLGgSe7aCPr3xKIF9JD9Dde8UziJqQiD1xvjax0dqpUshgXa7DShikJNAeoJ5Ovld3Yd
         lq3w==
X-Gm-Message-State: ABuFfojHthtea6rqgtRf7Uetq70IuGvaLiJBsbt1OsJSUypMNnd101bF
        vQzF2L/1btXlkiuya+zoPBg=
X-Google-Smtp-Source: ACcGV60tIAYuO4Cn2QNCQCIwAemNyM2n/+5fgcBZR4J5XYAv6WP0cIGV/2L7UA5GVnbzcQHNXxktTg==
X-Received: by 2002:ac8:1817:: with SMTP id q23-v6mr10589603qtj.223.1538099145346;
        Thu, 27 Sep 2018 18:45:45 -0700 (PDT)
Received: from WindFlash ([179.159.21.48])
        by smtp.gmail.com with ESMTPSA id x76-v6sm2278920qkx.25.2018.09.27.18.45.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 27 Sep 2018 18:45:44 -0700 (PDT)
Date:   Thu, 27 Sep 2018 22:45:36 -0300
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
Subject: [PATCH v3 0/7]  Remove errors building drivers/DRIVERNAME
Message-ID: <20180928014536.GA10369@WindFlash>
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
- Rolf Eike Beer (Was unintentional, thanks for the help!)

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
 drivers/oprofile/Makefile  | 1 +
 drivers/parisc/Makefile    | 2 +-
 drivers/s390/Makefile      | 8 ++++----
 drivers/zorro/Makefile     | 7 ++++---
 8 files changed, 18 insertions(+), 14 deletions(-)
 create mode 100644 drivers/hwtracing/Makefile
 create mode 100644 drivers/oprofile/Makefile

-- 
2.19.0

