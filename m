Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABDAC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D0012083A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 22:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RJvQw+yI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D0012083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbeITEbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 00:31:51 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43330 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbeITEbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 00:31:51 -0400
Received: by mail-lf1-f66.google.com with SMTP id x24-v6so6576650lfe.10
        for <linux-kernel@vger.kernel.org>; Wed, 19 Sep 2018 15:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FglfPAmbaYYI7tx799HbMsxACIr7lph3QHYl8iJDGNA=;
        b=RJvQw+yIcLChRLsdfwKs0vl+h868zkMhnwvHrSmq1pPErOppEfUB0t+YH77UARXuFo
         64sNvXKi2/v23gQySLSYC43R4VnhdX1Rjhm1gRCvqiF4YuD4ueDKr1y7LB/4KrDeWzJV
         41OZxse6bLJ+jvuoApO+7GT2pxXytVEQMHEo6USjO4zV8kRtW8bPRsWtUKKMaXMtiNqt
         KkX/q0Fo9AfGLS3cxSuU0Kqqybiu7oCPARGrnxwGXviYX1agsdgl9pgj0IR6jXxLa4pg
         kIkdWzMBfsZn8lxuiJSKNeVzXZgQD+RXLWvMaO3tlIMpaNOj4x2WyQwLgJ0h65TTxdof
         IWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FglfPAmbaYYI7tx799HbMsxACIr7lph3QHYl8iJDGNA=;
        b=YsV+V6NjeL0ZZEEntoL5ew53mzdlKIwvd0wMkPeLrD1JbF1HWk+FcfbThy5BoKXgqZ
         Jq/PaSHrMrFNqKtu5YxkSc7lp9rH8Z0UXDEEOfsENP3x8BViKj5En8pE2snb2Qo3HA2l
         BoxaogGFB6xBgOMvJMiNzW1T6nIdNCNn7FYzH8Pu38kda5LWe6v8IfNjDhcLhtZB/hnI
         Nvzzvoq/H5oqmNkMl7EdpRFVjI+pfL7pPfBfve6iickv5WYSiet8NNJyDSvKmjmnQY5d
         hdTSzKWBETqgvYML8ETKvEUd33mvhX0Lqzy/hA8gDOE492kzXAGy8I25bacG2iVaEC7X
         zk3g==
X-Gm-Message-State: APzg51D7t10TIxqIP4+VxJFjCbgC7NXHG19QMjjalpCV3YFEElhS5n4W
        WLAkpw1Eb2R4SovILsV2bKWFOa3evO4=
X-Google-Smtp-Source: ANB0Vdaof6Dtqv6cC3oNFGopOKt65zewMJePiR8vvLNuwgPAs4TfRVtY82AOJHr1X6vuQIxKpibzwQ==
X-Received: by 2002:a19:1b14:: with SMTP id b20-v6mr10697713lfb.12.1537397500301;
        Wed, 19 Sep 2018 15:51:40 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id q22-v6sm1249211lff.10.2018.09.19.15.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Sep 2018 15:51:39 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] mtd: rawnand: ams-delta: Cleanups and optimizations
Date:   Thu, 20 Sep 2018 00:52:52 +0200
Message-Id: <20180919225255.31175-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180820213904.13475-1-jmkrzyszt@gmail.com>
References: <20180820213904.13475-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This series consist of possibly ready to apply patches extracted from
a former one titled "mtd: rawnand:  ams-delta: Use GPIO API for data I/O".
Remaining patches implementing conversion of data I/O to GPIO have been
postponed until gpiolib is optimized to ensure sufficient performance.


Janusz Krzysztofik (3):
      mtd: rawnand: ams-delta: show parent device in sysfs
      mtd: rawnand: ams-delta: Use private structure
      mtd: rawnand: ams-delta: Set port direction when needed


Changelog:
v5:
- rebased against just resubmitted "[PATCH v5] mtd: rawnand: ams-delta:
  use GPIO lookup table" applied on top of nand/next

v4:
[PATCH v4 1/3] mtd: rawnand: ams-delta: show parent device in sysfs
- no changes.
[PATCH v4 2/3] mtd: rawnand: ams-delta: Use private structure
- no changes.
[PATCH v4 3/3] mtd: rawnand: ams-delta: Set port direction when
- formerly submitted as [PATCH v3 5/7], now rebased on top of 2/3 from
  the top of the postponed "[PATCH v3 4/7] mtd: rawnand: ams-delta:
  request data port GPIO resource",
- refactored as requested by Boris Brezillon, thanks.
Rrmoved from this series:
[PATCH v3 3/7] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND
 data port
- postponed, will be resubmitted when gpiolib optimizations are ready.
[PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO resource
- postponed, will be resubmitted when gpiolib optimizations are ready.
[PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution
- no longer needed, the idea has been implemented in the refactored 3/3.
[RFC PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data I/O
- postponed, will be resubmitted when gpiolib optimizations are ready.

v3:
[PATCH v3 1/7] mtd: rawnand: ams-delta: show parent device in sysfs
- renamed and an explanation added based on other similar patches on
 Marek Vasut request, thanks.
[PATCH v3 2/7] mtd: rawnand: ams-delta: Use private structure
- no changes.
[PATCH v3 3/7] ARM: OMAP1: ams-delta: Provide GPIO lookup table for NAND
 data port
- no changes.
[PATCH v3 4/7] mtd: rawnand: ams-delta: request data port GPIO resource
- no changes.
[PATCH v3 5/7] mtd: rawnand: ams-delta: Set port direction when needed
- modified to set port direction only when needed instead of on each
 transfer as suggested by Boris, thanks, though I kept separate 
 *_next_byte() functions to maximize performance as much as possible,
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data
 I/O" with a comment added referring to the planned switch to GPIO API.
[PATCH v3 6/7] mtd: rawnand: ams-delta: Simplify pointer resolution
- moved back in front of "mtd: rawnand: ams-delta: use GPIO API for data 
 I/O" on Boris request, thanks.
[RFC PATCH v3 7/7] mtd: rawnand: ams-delta: use GPIO API for data I/O
- rebased back on top of the two mentioned above,
- not intended to apply it yet due to performance issues on Amstrad Delta.
Removed from the series:
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
 mapping
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- intended to be still iterated in a follow up series until performance
 issues are resolved.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- postponed until acceptable performance on Amstrad Delta is achieved.

v2:
[RFC PATCH v2 00/12] mtd: rawnand: ams-delta: Use GPIO API for data I/O
- renamed from former [RFC PATCH 0/8] mtd: rawnand: ams-delta: Use
  gpio-omap accessors for data I/O
[RFC PATCH v2 01/12] mtd: rawnand: ams-delta: Assign mtd->dev.parent,
                        not mtd->owner
- split out from former [RFC PATCH 1/8] on Boris request, thanks.
[RFC PATCH v2 02/12] mtd: rawnand: ams-delta: Use private structure
- remaining part of the former [RFC PATCH 1/8].
[RFC PATCH v2 03/12] ARM: OMAP1: ams-delta: Provide GPIO lookup table
                        for NAND data port
- split out from former [RFC PATCH 5/8] on Boris requesst, thanks,
[RFC PATCH v2 04/12] mtd: rawnand: ams-delta: request data port GPIO resource
- remaining part of the former [RFC PATCH 5/8],
[RFC PATCH v2 05/12] mtd: rawnand: ams-delta: use GPIO API for data read/write
- reworked from former [RFC PATCH 8/8] on Boris requesst to use pure
  GPIO API, thanks,
- moved up in front of former [RFC PATCH 3/8] on Boris request, thanks.
[RFC PATCH v2 06/12] ARM: OMAP1: ams-delta: drop obsolete NAND resources
- split out from former [RFC PATCH 8/8].
[RFC PATCH v2 07/12] mtd: rawnand: ams-delta: Set port direction once per
                        transfer
- reworked from former [RFC PATCH 3/8] on top of [RFC PATCH v2 05/12].
[RFC PATCH v2 08/12] mtd: rawnand: ams-delta: Simplify pointer resolution
                        on read/write
- reworked from former [RFC PATCH 4/8] on top of [RFC PATCH v2 08/12],
- renamed from 'Optimize' to 'Simplify' on Boris request, thanks.
[RFC PATCH v2 09/12] gpiolib: Identify GPIO descriptor arrays with direct
                        mapping
- new patch.
[RFC PATCH v2 10/12] gpiolib: Introduce bitmap get/set array API extension
- new patch.
[RFC PATCH v2 11/12] mtd: rawnand: ams-delta: Use GPIO API bitmap extension
- new patch.
[RFC PATCH v2 12/12] gpiolib: Add fast processing path to bitmap API functions
- new patch.
Removed from the series:
[RFC PATCH 2/8] mtd: rawnand: ams-delta: Write protect device during probe
- postponed on Boris request, thanks.
[RFC PATCH 6/8] gpio: omap: Add get/set_multiple() callbacks
- already applied by Linux in linux-gpio tree, thanks.
[RFC PATCH 7/8] mtd: rawnand: ams-delta: Check sanity of data GPIO resource
- most controversial one, no longer needed after switching to GPIO API.


diffstat:
 ams-delta.c |  181 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 107 insertions(+), 74 deletions(-)

