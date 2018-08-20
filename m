Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B30C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C67B52174D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnoG7O1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C67B52174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeHUAz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 20:55:28 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40108 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbeHUAz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 20:55:28 -0400
Received: by mail-lj1-f196.google.com with SMTP id j19-v6so12756481ljc.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 14:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qRqfyG5f5DKou1lc0NCUmC+t6/95sbNE111arloIUZM=;
        b=AnoG7O1Q44OJg5dJkmexwwQZFvJoR/4JbWr7V0fM2Wd0qUBrtP/S3822vlOtkPleYf
         0f7+FHLleRaD5M+OSiXuWsjK5wQIil3VfviNWiSPpwC9KGr5qU5+aiPJRpP9dwB7zhqQ
         siKaSiwxGQjUEdXUPGxOxQ88vzIbP+l6ui58ucDNFfKMGOUQstCkk92RY77yyVg55q+r
         lT6i7k188g4cDWmWuKBCKW+2UR/nZHOxjV0MrfhKqzaAXKAIMikyg2GJgRuCRvWvru4T
         IECZsl5H6uBXnIR5Pg1z0mwL45vYac4sRj0qaw2PpgFQhk6bWjFlLOR7rJshHpEAAIyg
         da9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qRqfyG5f5DKou1lc0NCUmC+t6/95sbNE111arloIUZM=;
        b=GO6eBJui73jN3GyJFgkTBsaOiPntWS/2jIaNAXCq4KoQYcm+qR10ihkdGAwCjiShV0
         2RfKMkW1JhmoSFUvhyrl+iKMkQNalXXaDDWoUqj4eb6wxubeRphGUj0qasACfjNuNHCO
         9w8vX+z05CNDFYOJId4NmOqhzY0jTihJnI97/irro45VikNJUlujMirQ3S6JLg2fhKCd
         EkChylxSpqlqYvXrHp8NtbM4vCbTLycaw4ZwYHYpVXevnNBHEyY4lYPETDxXRcM1Zo72
         kFajCXqQ2ooMOX7VNUrJzvbktWdrmDk06YgcgOmbfmaA8Vij62H+G24AgnSlWE0e8NvG
         /qbw==
X-Gm-Message-State: AOUpUlGznYdC/lVOULtrwwJ9QJamsgG1PT/L5JFvSdvhr3mEUqLV0aun
        m1NKphUHuvWGIo8nnlSQoEQ=
X-Google-Smtp-Source: AA+uWPxLuOqXHXXnTT3pFnKDlQjUyqAh4TrVcG53ISn5/aW/EdUPe65uLhUkl741X07JO1Ue8PGxNw==
X-Received: by 2002:a2e:800e:: with SMTP id j14-v6mr29471613ljg.114.1534801089072;
        Mon, 20 Aug 2018 14:38:09 -0700 (PDT)
Received: from z50.lan (93-181-165-181.internetia.net.pl. [93.181.165.181])
        by smtp.gmail.com with ESMTPSA id o72-v6sm1417868lfg.31.2018.08.20.14.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Aug 2018 14:38:08 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v4 0/3] mtd: rawnand: ams-delta: Cleanups and optimizations
Date:   Mon, 20 Aug 2018 23:39:01 +0200
Message-Id: <20180820213904.13475-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180813223448.21316-1-jmkrzyszt@gmail.com>
References: <20180813223448.21316-1-jmkrzyszt@gmail.com>
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
 ams-delta.c |  196 +++++++++++++++++++++++++++++++++++-------------------------
 1 file changed, 115 insertions(+), 81 deletions(-)
