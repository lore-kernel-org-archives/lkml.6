Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1329C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52021217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 15:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52021217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dotat.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbeHUS50 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 14:57:26 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:52698 "EHLO
        ppsw-32.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbeHUS5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 14:57:25 -0400
X-Greylist: delayed 1421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2018 14:57:25 EDT
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from grey.csi.cam.ac.uk ([131.111.57.57]:60384)
        by ppsw-32.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
        with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        id 1fs8LG-0011bm-2T (Exim 4.91)
        (return-path <dot@dotat.at>); Tue, 21 Aug 2018 16:13:10 +0100
Date:   Tue, 21 Aug 2018 16:13:10 +0100
From:   Tony Finch <dot@dotat.at>
To:     Harshit Jain <harshitjain6751@gmail.com>
cc:     linux-kernel@vger.kernel.org, Tony Finch <dot@dotat.at>
Subject: Re: [PATCH] scripts: unifdef: fix stringop-truncation warning
In-Reply-To: <20180817202038.27257-1-harshitjain6751@gmail.com>
Message-ID: <alpine.DEB.2.20.1808211611110.3596@grey.csi.cam.ac.uk>
References: <20180817202038.27257-1-harshitjain6751@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harshit Jain <harshitjain6751@gmail.com> wrote:

>  /* modify this line */
> -static void Mpass (void) { strncpy(keyword, "if  ", 4); Pelif(); }
> +static void Mpass (void) { memcpy(keyword, "if  ", 4); Pelif(); }

Yes, this is a good improvement, but you also need to update the comment
to match the code.

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
Wight, Portland, Plymouth: Westerly 3 or 4, occasionally 5 in north. Slight,
occasionally moderate. Drizzle, fog banks. Moderate, occasionally very poor.
