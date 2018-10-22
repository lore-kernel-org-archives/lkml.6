Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9BA9ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9875820869
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 00:09:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9875820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atrad.com.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeJVIZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 04:25:22 -0400
Received: from server.atrad.com.au ([150.101.241.2]:46106 "EHLO
        server.atrad.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJVIZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 04:25:22 -0400
Received: from marvin.atrad.com.au (IDENT:1008@marvin.atrad.com.au [192.168.0.2])
        by server.atrad.com.au (8.15.2/8.14.9) with ESMTPS id w9M01WTl010222
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 22 Oct 2018 10:31:34 +1030
Date:   Mon, 22 Oct 2018 10:31:32 +1030
From:   Jonathan Woithe <jwoithe@atrad.com.au>
To:     netdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: r8169 regression: UDP packets dropped intermittantly
Message-ID: <20181022000132.GD27585@marvin.atrad.com.au>
References: <20171218054951.GJ17747@marvin.atrad.com.au>
 <c47cfb79-afb9-e39b-4861-7c534c55bb70@applied-asynchrony.com>
 <20171218223224.GA13172@marvin.atrad.com.au>
 <20171219054532.GA13685@marvin.atrad.com.au>
 <20171219122523.lhavmoxo3ippftyn@unicorn.suse.cz>
 <20171220052011.GN8641@marvin.atrad.com.au>
 <20180115065658.GI16419@marvin.atrad.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115065658.GI16419@marvin.atrad.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.79 on 192.168.0.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2018 at 05:26:59PM +1030, Jonathan Woithe wrote:
> Is there any more information that can be provided (or tests done) to assist
> in tracking this problem down?  Based on the tests done in December it seems
> that the problem only affects specific RTL-8169 variants, with most being
> ok.  Is it a case that we simply need to accept that for the greater good
> commit da78dbff2e05630921c551dbbc70a4b7981a8fff has permanently broken
> Netgear GA311 [1] network cards with respect to these UDP packets and that
> nothing can be done?

For future reference, commit 6b839b6cf9eada30b086effb51e5d6076bafc761
("r8169: fix NAPI handling under high load") appears to have fixed the
regression documented by this thread.  Thanks to Heiner Kallweit for the
work which lead to this solution.

Regards
  jonathan

> [1] Or perhaps any using the RTL8110s variant.
