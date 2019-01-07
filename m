Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45E9EC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2198D20859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbfAGJwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:52:35 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:55692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726323AbfAGJwe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:52:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41F931596;
        Mon,  7 Jan 2019 01:52:34 -0800 (PST)
Received: from mbp (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4D36C3F5D4;
        Mon,  7 Jan 2019 01:52:33 -0800 (PST)
Date:   Mon, 7 Jan 2019 09:52:30 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Nathan Royce <nroycea+kernel@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: kmemleak: Cannot allocate a kmemleak_object structure - Kernel
 4.19.13
Message-ID: <20190107095229.uvfuxpglreibxlo4@mbp>
References: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALaQ_hpCKoLxp-0cgxw9TqPGBSzY7RhrnFZ0jGAQ11HbOZkZ3w@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nathan,

On Tue, Jan 01, 2019 at 01:17:06PM -0600, Nathan Royce wrote:
> I had a leak somewhere and I was directed to look into SUnreclaim
> which was 5.5 GB after an uptime of a little over 1 month on an 8 GB
> system. kmalloc-2048 was a problem.
> I just had enough and needed to find out the cause for my lagging system.
> 
> I finally upgraded from 4.18.16 to 4.19.13 and enabled kmemleak to
> hunt for the culprit. I don't think a day had elapsed before kmemleak
> crashed and disabled itself.

Under memory pressure, kmemleak may fail to allocate memory. See this
patch for an attempt to slightly improve things but it's not a proper
solution:

http://lkml.kernel.org/r/20190102180619.12392-1-cai@lca.pw

-- 
Catalin
