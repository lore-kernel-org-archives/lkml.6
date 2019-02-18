Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27315C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00CEB2176F
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 10:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfBRKxS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 05:53:18 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:50899 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730224AbfBRKxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 05:53:18 -0500
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id E2D1024000D;
        Mon, 18 Feb 2019 10:53:15 +0000 (UTC)
Date:   Mon, 18 Feb 2019 11:53:15 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iomap: fix multiple consistency issues, interface cleanup
Message-ID: <cover.1550485787.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch cleans up the iomap interface.

The first patch makes the include/asm-generic/iomap.h header compliant
with the kernel style guidelines by adding missing function args
identifier names.

The second and fourth patches address multiple compilation warnings due
to missing const qualifiers in mmio_ins* and ioread*/iowrite
definitions in include/asm-generic/iomap.h and lib/iomap.c.

The third patch modifies io*_rep definitions from asm-generic/io.h to
take unsigned long count parameter instead of unsigned int which is
inconsistent with other definitions in the kernel.

Hugo Lefeuvre (4):
  iomap: add missing function args identifier names
  iomap: add missing const to ioread*/iowrite addr arg
  io: change io*_rep definitions to take ulong count
  lib/iomap: add missing const to mmio_ins* addr arg

 include/asm-generic/io.h    | 16 ++++++++--------
 include/asm-generic/iomap.h | 38 ++++++++++++++++++-------------------
 lib/iomap.c                 | 22 ++++++++++-----------
 3 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.20.1
