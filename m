Return-Path: <SRS0=OrLK=KG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38DDC6778A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9696A20854
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Jul 2018 22:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="DlB9uFsV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9696A20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387893AbeGVXLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Jul 2018 19:11:32 -0400
Received: from imap.thunk.org ([74.207.234.97]:43686 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730404AbeGVXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jul 2018 19:11:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dZbQoDgPidU7/seDgkgBOBHELwBr2QTJbEHfX6Tkx1c=; b=DlB9uFsV8WEGR4GIrFAh8mp2mF
        4CsgvRl1uq33NmFgyJEtB654kyz+8EVG8yOHKC8VHjy2AfYX/inoI/8qWPTpgaH9TQ2U6KUvGab89
        kM1f7lCN/Am0KD/UN/in+4aqvXNk8Sf4GJGZGqsEuwSZXqmMFmCECCFHc6Tzf0ZPH3Gc=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fhMbP-0005VQ-0y; Sun, 22 Jul 2018 22:13:19 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 5C8DB7A6463; Sun, 22 Jul 2018 18:13:14 -0400 (EDT)
Date:   Sun, 22 Jul 2018 18:13:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     adilger.kernel@dilger.ca, willy@infradead.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: ext4: use new return type vm_fault_t
Message-ID: <20180722221314.GB3358@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>, adilger.kernel@dilger.ca,
        willy@infradead.org, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180707103029.GA13365@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180707103029.GA13365@jordon-HP-15-Notebook-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2018 at 04:00:30PM +0530, Souptick Joarder wrote:
> Use new return type vm_fault_t for fault handler
> ext4_filemap_fault.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Thanks, applied.

					- Ted
