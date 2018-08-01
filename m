Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0798EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924C420894
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 12:10:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 924C420894
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388978AbeHANzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 09:55:43 -0400
Received: from nautica.notk.org ([91.121.71.147]:46572 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387568AbeHANzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 09:55:43 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 1B8ADC009; Wed,  1 Aug 2018 14:10:13 +0200 (CEST)
Date:   Wed, 1 Aug 2018 14:09:58 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Greg Kurz <groug@kaod.org>
Cc:     piaojun <piaojun@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH] net/9p/trans_virtio.c: add a terminal char for mount tag
Message-ID: <20180801120958.GA571@nautica>
References: <5B6164F6.60004@huawei.com>
 <20180801081157.GA20127@nautica>
 <5B616E3B.4050205@huawei.com>
 <20180801125222.3ba39416@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180801125222.3ba39416@bahia.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kurz wrote on Wed, Aug 01, 2018:
> So this patch basically turns chan->tag into a nul terminated string,
> which is indeed more convenient and robust. Maybe you can update the
> rest of the code accordingly and drop chan->tag_len then ?

If we can use that to simplify some other part of the code, that's
certainly more appealing to me :)


> FWIW, 9P strings received from the client are also converted to
> nul terminated strings:

Oh, good to know; I guess that makes sense when these strings come and
go from/to other components of the kernel that likely expect that.

-- 
Dominique
