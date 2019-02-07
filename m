Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F66DC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C923E21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549534176;
	bh=Pwrqc8aL7mN1SAGDFpG8Z53TIfsyK3gjJGPSZX/NV9Q=;
	h=Date:From:To:cc:Subject:List-ID:From;
	b=kBRBC+b/p4GdJ5pFVQYqyvyTzxc6nnM/Po/6n5cMykWdYW/YjIEcGHyUuGNLLqwvO
	 +ecdyCCRL79bdciKW84NgMlZE9hloHCPQDOofnnvjB3xwpVXF4pCaAjOOPkvJxzcmG
	 YTjjGe74PE5zPaPUk6doz7MswkXsmSfcymUuDhwc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbfBGKJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:09:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:36848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbfBGKJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:09:34 -0500
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CEA621872;
        Thu,  7 Feb 2019 10:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549534174;
        bh=Pwrqc8aL7mN1SAGDFpG8Z53TIfsyK3gjJGPSZX/NV9Q=;
        h=Date:From:To:cc:Subject:From;
        b=mViarKKkHKW6yovLSZF5N86UPXl00cnTyWIdCL5VcTqRHmkU4uLLO+44aZvCwa9RV
         mxrJpW6oJJfb/qktm3MRrDA6Qlt39AErDMw26gyWlAEU9CLjZXPcGRH1Zo7LcdLgNr
         czVuE69Iu5XsVqMFxj+Il/PzLtqB67YI9HBinm2c=
Date:   Thu, 7 Feb 2019 11:09:31 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fix
Message-ID: <nycvar.YFH.7.76.1902071106510.11598@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive fix for a bug in hid-debug that can lock up the kernel in 
infinite loop (CVE-2019-3819), from Vladis Dronov.

Thanks.

----------------------------------------------------------------
Vladis Dronov (1):
      HID: debug: fix the ring buffer implementation

 drivers/hid/hid-debug.c   | 120 ++++++++++++++++++----------------------------
 include/linux/hid-debug.h |   9 ++--
 2 files changed, 51 insertions(+), 78 deletions(-)

-- 
Jiri Kosina
SUSE Labs

