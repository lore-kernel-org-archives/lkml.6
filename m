Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784A3C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30DED208CC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:04:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30DED208CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeHUQYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:24:42 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49074 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbeHUQYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:24:42 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Lp5v6F3qKgUW; Tue, 21 Aug 2018 15:04:19 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 66D7D1EC044B;
        Tue, 21 Aug 2018 15:04:19 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:04:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Pu Wen <puwen@hygon.cn>, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, thomas.lendacky@amd.com,
        mchehab@kernel.org, mikhail.jin@gmail.com,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 15/16] driver/edac: enable Hygon support to AMD64 EDAC
 driver
Message-ID: <20180821130430.GB30528@nazgul.tnic>
References: <cover.1534599097.git.puwen@hygon.cn>
 <6275a5a0a0cfbd2c1abc09a5bb41caabecd02e27.1534599097.git.puwen@hygon.cn>
 <20180821081331.GC24940@nazgul.tnic>
 <ccbc6572-c16f-7a9b-ab27-54fffac1ba0d@hygon.cn>
 <20180821112020.GB29972@nazgul.tnic>
 <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e17958a-6cd8-4c6c-c890-f5f48b084d6f@redhat.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 21, 2018 at 01:26:13PM +0200, Paolo Bonzini wrote:
> But then I don't see the point of adding the Hygon vendor, since any
> check can be simplified:

I think Hygon wanted to superficially show it is not really an AMD. For
example, the Hygon thing doesn't do SME/SEV. AFAIK.

So we can just as well check only family but I'd say the vendor thing is
laying the grounds for the future where reportedly it will differ more
from an AMD. And then we can start splitting code more based on vendor
and not look at family at all.

But for right now I think we should strive to keep the changes as small
as possible and only do real splitting when they start adding new
functionality. Which would mean having a hygon_edac.c too, for example.

All, IMHO, of course. Sharing code between vendors is always yucky.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
