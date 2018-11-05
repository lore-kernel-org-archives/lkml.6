Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FC0C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F1F620819
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1F620819
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730016AbeKEX4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:56:34 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:49158 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbeKEX4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:56:34 -0500
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
        by vmicros1.altlinux.org (Postfix) with ESMTP id B877572CC68;
        Mon,  5 Nov 2018 17:36:31 +0300 (MSK)
Received: from sole.flsd.net (sole.flsd.net [185.75.180.6])
        by imap.altlinux.org (Postfix) with ESMTPSA id 43D494A4A29;
        Mon,  5 Nov 2018 17:36:31 +0300 (MSK)
Date:   Mon, 5 Nov 2018 17:36:31 +0300
From:   Vitaly Chikunov <vt@altlinux.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] crypto: streebog - add Streebog hash function
Message-ID: <20181105143630.3m5z2kmbtesaqcgc@sole.flsd.net>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181024032356.3388-1-vt@altlinux.org>
 <20181024032356.3388-2-vt@altlinux.org>
 <CAKv+Gu9LSUNwW_3E3QtxV123u=mU-B+p6FFRAkWq8_e9Jsgb2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9LSUNwW_3E3QtxV123u=mU-B+p6FFRAkWq8_e9Jsgb2w@mail.gmail.com>
User-Agent: NeoMutt/20171215-106-ac61c7
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ard,

I will address your suggestions in v4. And below is my comments for a
few of them.

On Mon, Nov 05, 2018 at 02:22:21PM +0100, Ard Biesheuvel wrote:
> > +static const struct streebog_uint512 buffer512 = { {
> > +       cpu_to_le64(0x200ULL),
> 
> Can we keep the memory representation in native endianness, and only
> swab the in/output [where needed]?

Yes. This will slightly affect performance on big-endian architectures,
but, probably this is not a concern.

> Also, did you test this code on a big-endian system?

Yes, on s390x on qemu.

> > +               .cra_name        =      "sb256",
> 
> Please use the full name 'streebog256' (and 512 below)

First, I thought of shortening name like Whirlpool do with wp256, but
now I rethought this and agree.

Thanks!

