Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543F5C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:46:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A26823F09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 19:46:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A26823F09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeGDTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 15:46:00 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:41450 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDTp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 15:45:59 -0400
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
        (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
        id S23994656AbeGDTp5Fkb55 (ORCPT <rfc822;linux-omap@vger.kernel.org>
        + 2 others); Wed, 4 Jul 2018 21:45:57 +0200
Date:   Wed, 4 Jul 2018 21:45:56 +0200
From:   Ladislav Michl <ladis@linux-mips.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-pm@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: droid 4: connection refused from voltage_now
Message-ID: <20180704194556.GA9189@lenoch>
References: <20180704171156.GA3158@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180704171156.GA3158@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 04, 2018 at 07:11:56PM +0200, Pavel Machek wrote:
> Hi!
> 
> I started to use droid 4 as my primary phone... so I have battery
> monitor running for hours... Once every few days it dies with
> "connection refused" error reading battery's "voltage_now". I restart
> it and it continues working...

Ha! What exactly that "connection refused" means? Is it ECONNREFUSED (111)?
I have custom at91 based board here with few custom power supply drivers
and it sometimes ends with voltage_now of my driver being unreadable.
(I modified userspace code and waiting what's in errno in case reading fails)

> That was with v4.17; in v4.18, I'm getting "red screen" a lot.

Tests are also done v4.17.
Adding linux-pm@vger.kernel.org as it seems to be subsytem, specific.

	ladis
