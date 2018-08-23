Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3671C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 771372152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:42:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771372152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dotat.at
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731997AbeHWPL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 11:11:59 -0400
Received: from ppsw-33.csi.cam.ac.uk ([131.111.8.133]:40776 "EHLO
        ppsw-33.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730672AbeHWPL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 11:11:59 -0400
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from grey.csi.cam.ac.uk ([131.111.57.57]:54094)
        by ppsw-33.csi.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.139]:25)
        with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        id 1fso0c-0003X9-gB (Exim 4.91)
        (return-path <dot@dotat.at>); Thu, 23 Aug 2018 12:42:38 +0100
Date:   Thu, 23 Aug 2018 12:42:38 +0100
From:   Tony Finch <dot@dotat.at>
To:     Harshit Jain <harshitjain6751@gmail.com>
cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts: unifdef: fix stringop-truncation warning
In-Reply-To: <CAA47fTLj32cf=p5LUwZDrtKvXebHDNxz9ozEz9YCoCFP0NRgng@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1808231239470.3596@grey.csi.cam.ac.uk>
References: <20180817202038.27257-1-harshitjain6751@gmail.com> <alpine.DEB.2.20.1808211611110.3596@grey.csi.cam.ac.uk> <CAA47fTLj32cf=p5LUwZDrtKvXebHDNxz9ozEz9YCoCFP0NRgng@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Harshit Jain <harshitjain6751@gmail.com> wrote:

> Hey! tony thanks for reviewing, pardon me i wasn't able to get your context
> can you please elaborate a little what you are trying to say?

There's a big block comment above the state machine code which tries to
explain what the blazes is going on. The comment includes an explanation
of the weird strncpy() call, which you need to update to talk about
memcpy() instead.

(The code is heavily compactified because I wrote it on a laptop with a
small screen and I needed to be able to see it all to understand it!)

Tony.
-- 
f.anthony.n.finch  <dot@dotat.at>  http://dotat.at/
South Fitzroy: Northerly or northeasterly 5 or 6. Slight or moderate.
Occasional drizzle. Good, occasionally poor at first.
