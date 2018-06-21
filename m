Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C610C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E01A520846
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 12:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E01A520846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933438AbeFUMVN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 08:21:13 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:49540 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933149AbeFUMVM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 08:21:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E23D71435;
        Thu, 21 Jun 2018 05:21:11 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09803F578;
        Thu, 21 Jun 2018 05:21:10 -0700 (PDT)
Date:   Thu, 21 Jun 2018 13:21:03 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     mingo@kernel.org, will.deacon@arm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Boqun Feng <boqun.feng@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCHv4 08/18] atomics/generic: define
 atomic64_fetch_add_unless()
Message-ID: <20180621122103.7k2ozjyc64b4zdjc@lakrids.cambridge.arm.com>
References: <20180621121321.4761-1-mark.rutland@arm.com>
 <20180621121321.4761-9-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180621121321.4761-9-mark.rutland@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 01:13:11PM +0100, Mark Rutland wrote:
> -	if (v->counter != u) {
> +	val = v->counter;
> +	if (val != u)
>  		v->counter += a;
> -		ret = true;
>  	}

Ugh, I thought I had fixed this up and removed the trailing brace.

This will break some 32-bit arches as-is.

Ingo, would you be hapyp to fix this up, or would you prefer that I fix
and resend?

Sorry about this.

Mark.
