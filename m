Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6C5C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB827218D4
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:27:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="e1ZD6GQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730748AbfA3M11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:27:27 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39784 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728645AbfA3M10 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:27:26 -0500
Received: from zn.tnic (p200300EC2BCAED00D014CE199A91CB87.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:ed00:d014:ce19:9a91:cb87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9F5971EC04F3;
        Wed, 30 Jan 2019 13:27:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1548851245;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=tj8cGEqdBsxNasz4TBX7lD41QhNQnTH7VP8JM2GYHlI=;
        b=e1ZD6GQo1Z1lxqV9CyTTwU13DpEURzhycTIJr4o6Aw7RtbFmeLe2al6L/9bfy/6r4E2IYn
        3MQznui/Hhpb8Kg9kCfw2ixJ2K00A0knjFrho6n6Uf/6bX7dg3yJeMRU8DSZnU8QB7iRgx
        L//7eZvbaHhkZ8VIuWcnmWR24QJETcI=
Date:   Wed, 30 Jan 2019 13:27:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        kvm@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Rik van Riel <riel@surriel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v6] x86: load FPU registers on return to userland
Message-ID: <20190130122713.GG18383@zn.tnic>
References: <20190109114744.10936-1-bigeasy@linutronix.de>
 <20190130113555.GC18383@zn.tnic>
 <20190130120647.abbf2cbbpguaz356@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190130120647.abbf2cbbpguaz356@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 01:06:47PM +0100, Sebastian Andrzej Siewior wrote:
> I don't know if hackbench would show anything besides noise.

Yeah, if a sensible benchmark (dunno if hackbench is among them :))
shows no difference, is also saying something.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
