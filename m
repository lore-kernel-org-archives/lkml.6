Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA02ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E20F22087C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:31:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E20F22087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeGMPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:46:42 -0400
Received: from nautica.notk.org ([91.121.71.147]:44361 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbeGMPqm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:46:42 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id A6E04C009; Fri, 13 Jul 2018 17:31:34 +0200 (CEST)
Date:   Fri, 13 Jul 2018 17:31:19 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Ed L. Cashin" <ed.cashin@acm.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH 02/18] block/aoenet: change strncpy+truncation to strlcpy
Message-ID: <20180713153119.GC14190@nautica>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445105-18941-1-git-send-email-asmadeus@codewreck.org>
 <41bf49e3-70a5-4362-7389-55752ebc6c02@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <41bf49e3-70a5-4362-7389-55752ebc6c02@kernel.dk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote on Fri, Jul 13, 2018:
> This is a weird combination in terms of a single patch, why is
> it patching aoe and gpiolib in one patch?

I must have failed some git add command, I didn't realize they were
together until you pointed it out just now.

This has been discussed more lengthly on the netdev side but the whole
patch serie has been (quite) a bit too hasty; on one side I've been
given some interesting feedback that I would not have gotten just
sending the coccinelle patch first but I really should have waited for
that to land first and most importantly spend more time on each
individual patch, this was rude of me.

I will make sure they are split in a v2, and send them individually
(well, per big component) as self-explaining patches rather than as a
block, once the coccinelle patch has been accepted. 


Thank you for the review,
-- 
Dominique Martinet
