Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DC2C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F051120851
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:55:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbfAQOzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:55:33 -0500
Received: from verein.lst.de ([213.95.11.211]:37862 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbfAQOzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:55:33 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id DDD3A68CEB; Thu, 17 Jan 2019 15:55:31 +0100 (CET)
Date:   Thu, 17 Jan 2019 15:55:31 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: SUBDIRS= replacement
Message-ID: <20190117145531.GA21429@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro, hi Michal,

I just got this beatiful warning:

hch@carbon:~/work/xfs$ make -j4 SUBDIRS=fs/xfs
Makefile:189: ================= WARNING ================
Makefile:190: 'SUBDIRS' will be removed after Linux 5.3
Makefile:191: Please use 'M=' or 'KBUILD_EXTMOD' instead
Makefile:192: ==========================================

Both the replacement seem to be geared towards building externals
modules.  But what is the replacement for just building a directory
of the normal kernel tree?

E.g. what hit this is that I rebased an XFS series, and wanted to
compile test just the xfs code for each step using

make -j4 SUBDIRS=fs/xfs
