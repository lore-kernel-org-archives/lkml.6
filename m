Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3650C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DC22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:53:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DC22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbeIKSwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:52:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:43876 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbeIKSwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:52:54 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o2vLaCbP6y2M; Tue, 11 Sep 2018 15:53:27 +0200 (CEST)
Received: from zn.tnic (p200300EC2BC6F600329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc6:f600:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2527B1EC0181;
        Tue, 11 Sep 2018 15:53:27 +0200 (CEST)
Date:   Tue, 11 Sep 2018 15:53:25 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     linux-crypto@vger.kernel.org, thomas.lendacky@amd.com,
        Gary Hook <Gary.Hook@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH crypto-2.6] crypto: ccp: add timeout support in the SEV
 command
Message-ID: <20180911135325.GI12094@zn.tnic>
References: <1534367485-4386-1-git-send-email-brijesh.singh@amd.com>
 <1534367485-4386-2-git-send-email-brijesh.singh@amd.com>
 <20180904081151.GC32615@zn.tnic>
 <e327fa7f-2d4d-2181-c3f4-607faf16c9b5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e327fa7f-2d4d-2181-c3f4-607faf16c9b5@amd.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 02:06:57PM -0500, Brijesh Singh wrote:
> Nothing prevent user from supplying a bogus number. The main question
> is, clamp with what number ?

So you definitely want to forbid too large timeouts - that wouldn't make
any sense anyway. And too small either, because a too small timeout
would make a potentially functioning fw broken.

> IMO, if user is overriding the default timeout number then its possible
> that user is dealing with a buggy firmware which does not work with
> default timeout and silently clamping the value will not help them.

No one said "silently" - you simply say:

	"Correcting PSP	"Correcting PSP probe timeout to X seconds."

when loading the driver so that the user is aware that the value she
entered might not be an optimal one.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
