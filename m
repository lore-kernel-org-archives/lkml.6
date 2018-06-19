Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC8AC5AE5A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EAE820693
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 20:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="Zamc2yx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAE820693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967221AbeFSUc3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 16:32:29 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:51133 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967142AbeFSUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 16:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=z2Qkst2xiExcW131eNlTd5Ks2t0a7C67VBqzCJcrXOI=; b=Zamc2yx2G+cCbzyR7QoA4sl0BI
        QJjFdCz36vclQmaLuyd14K17OJ+/ZPPbMvp+upG1ykst6agu5u2NmX0L1uNe4Sg9kipVhZizt+S9t
        MdbePqSQqfyImVGnsFDLUDZ0GB9iS8stTTtvvMu20jwYGWQJ0Vj23EGk2moXGectVfBzCdqSuCkY7
        QbyJaInl71F4rNjqLz32fURKVqL4o6DGaJthjJtMejPijVMkpU/Q9k7N1qBGH979N0g0x6+36F54Z
        Rq67c0DXcGGMJnZ/ydZpgjxWyLsfTEhH2EsdIos6I3kvwiR5q632TFfSH8VHF8R4yYEfHqfY4wHPJ
        ZbU9R4RQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:46184 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fVNIe-00AfB2-Gs; Tue, 19 Jun 2018 20:32:25 +0000
Date:   Tue, 19 Jun 2018 13:32:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Make badr macro compatible with newer GAS versions
Message-ID: <20180619203223.GA28370@roeck-us.net>
References: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180619192633.21846-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 09:26:31PM +0200, Ard Biesheuvel wrote:
> Work around the mindless and backward incompatible change in GAS that
> prevents us from using a simple addition to set the Thumb bit in local
> symbol references taken using 'adr' instructions (#2)
> 
> As a preparatory step, remove badr occurrences in ARM code sequences
> contained in Thumb2 kernels.
> 
> Ard Biesheuvel (2):
>   ARM: avoid badr macro for switching to Thumb-2 mode
>   ARM: assembler: prevent ADR from setting the Thumb bit twice
> 

This doesn't work for images built with a toolchain based on gcc 7.3.0
and binutils 2.28.1. It _does_ work for images built with gcc 7.3.0/
binutils 2.30.

Guenter
