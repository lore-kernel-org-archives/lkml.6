Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C70C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94AFE2082D
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="guBils2t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94AFE2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeLHLdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 06:33:22 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48242 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbeLHLdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 06:33:22 -0500
Received: from zn.tnic (p200300EC2BDEA700C0511CCA78411630.dip0.t-ipconnect.de [IPv6:2003:ec:2bde:a700:c051:1cca:7841:1630])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 121791EC08EA;
        Sat,  8 Dec 2018 12:33:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1544268801;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=B5CDGzsrX4V2SXTubOP+f8uhJVd6TTji+V4DFVcJN34=;
        b=guBils2tX8g7UeBlevew8xBHYpWMggzF17cKwsrB0DCM0BRU/CiKDvNVApeuhOfeSdj09X
        fJ3Rn0+KM0u7RNMVZVpuDsLvjBYIBlUgevxdj+K5py2eZRASQeEsC5Y3UuXZbeiCW983E6
        gJEtxZZMqeRSaByiSh1zpy5cRuZsKMw=
Date:   Sat, 8 Dec 2018 12:33:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Richard Weinberger <richard@sigma-star.at>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] x86, powerpc: remove -funit-at-a-time compiler
 option entirely
Message-ID: <20181208113313.GD30399@zn.tnic>
References: <1541990120-9643-1-git-send-email-yamada.masahiro@socionext.com>
 <1541990120-9643-3-git-send-email-yamada.masahiro@socionext.com>
 <87k1lia6bd.fsf@concordia.ellerman.id.au>
 <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNARbzF9-ZYvX7U76HqC957Fj=U3rmQfCEYXKqZNV8SFmNg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 08, 2018 at 03:36:52PM +0900, Masahiro Yamada wrote:
> x86 maintainers,
> 
> Ping.

You got the required ACKs. If you want me to carry this one and the
UML one through the tip tree, lemme know. Or you can do what Richard
suggested. Your call.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
