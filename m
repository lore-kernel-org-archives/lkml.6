Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A345CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 741A420851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 741A420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbeKTCOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:14:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:49642 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729796AbeKTCOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:14:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3BD21AFF6;
        Mon, 19 Nov 2018 15:50:15 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        davem@davemloft.net, f.fainelli@gmail.com,
        allan.nielsen@microchip.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, thomas.petazzoni@bootlin.com,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH net-next v3 1/6] net: phy: mscc: migrate to phy_select/restore_page functions
References: <20181008100728.24959-1-quentin.schulz@bootlin.com>
        <20181008100728.24959-2-quentin.schulz@bootlin.com>
        <mvm8t1pazea.fsf@suse.de> <20181119151057.GC26852@lunn.ch>
        <mvm4lcdaynt.fsf@suse.de> <20181119152830.GE26852@lunn.ch>
        <20181119154005.GA8367@piout.net>
X-Yow:  YOW!!  What should the entire human race DO??  Consume a fifth
 of CHIVAS REGAL, ski NUDE down MT. EVEREST, and have a wild
 SEX WEEKEND!
Date:   Mon, 19 Nov 2018 16:50:14 +0100
In-Reply-To: <20181119154005.GA8367@piout.net> (Alexandre Belloni's message of
        "Mon, 19 Nov 2018 16:40:05 +0100")
Message-ID: <mvmzhu59idl.fsf@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19 2018, Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:

> My first intuition is that he mac driver quentin is using does
> phy_connect when the interface is opened while macb is doing it at probe
> time. I didn't investigate but maybe this can help :)

The phy probing of macb is very unreliable, perhaps it needs to be
rewritten.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
