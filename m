Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B585ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C692020673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 04:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C692020673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbeGTE4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 00:56:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:42164 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726951AbeGTE4b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 00:56:31 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id RHIgGEwnRX7y; Fri, 20 Jul 2018 06:10:15 +0200 (CEST)
Received: from nazgul.tnic (77-85-109-49.ip.btc-net.bg [77.85.109.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0264A1EC00EE;
        Fri, 20 Jul 2018 06:10:14 +0200 (CEST)
Date:   Fri, 20 Jul 2018 06:10:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tyler Baicar <tbaicar@codeaurora.org>
Cc:     James Morse <james.morse@arm.com>, harba@qti.qualcomm.com,
        mchehab@kernel.org, linux-edac@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] EDAC, ghes: Enable per-layer error reporting for ARM
Message-ID: <20180720041005.GA25433@nazgul.tnic>
References: <1531762009-15112-1-git-send-email-tbaicar@codeaurora.org>
 <20180719140102.GB25185@nazgul.tnic>
 <94e3a0fb-9b7d-045f-733b-9f063dcb39e4@arm.com>
 <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <45fefe7d-c6ea-5791-4477-13ecce39ce48@codeaurora.org>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 02:36:21PM -0400, Tyler Baicar wrote:
> With the current ghes_edac setup, it seems the only way this could
> work would be to have the firmware always report the module value to

My experience with firmware so far is that it is a lost cause,
considering all the bugs, snafus and incompleteness it demonstrates...

> The other obvious but more messy way would be to have notifiers
> register to be called by ghes_edac and have a custom EDAC driver for
> each CPU to properly populate their layer information.

... which is what we do on x86 and whitelist only known-good platforms
in ghes_edac, which claim that their fw info is correct.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
