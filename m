Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 396D2C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFAC92086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFAC92086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeIZArY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 20:47:24 -0400
Received: from smtprelay0135.hostedemail.com ([216.40.44.135]:51375 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726335AbeIZArY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 20:47:24 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 80E5A837F243;
        Tue, 25 Sep 2018 18:38:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: show64_6794f6ec5d649
X-Filterd-Recvd-Size: 5400
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Tue, 25 Sep 2018 18:38:31 +0000 (UTC)
Message-ID: <61e220e2413a03e140192237892b7a0b71309fd8.camel@perches.com>
Subject: Re: [PATCH net-next v6 17/23] zinc: Curve25519 generic C
 implementations and selftest
From:   Joe Perches <joe@perches.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-crypto@vger.kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     Samuel Neves <sneves@dei.uc.pt>, Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Aumasson <jeanphilippe.aumasson@gmail.com>,
        Karthikeyan Bhargavan <karthik.bhargavan@gmail.com>
Date:   Tue, 25 Sep 2018 11:38:30 -0700
In-Reply-To: <20180925145622.29959-18-Jason@zx2c4.com>
References: <20180925145622.29959-1-Jason@zx2c4.com>
         <20180925145622.29959-18-Jason@zx2c4.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-09-25 at 16:56 +0200, Jason A. Donenfeld wrote:
> This contains two formally verified C implementations of the Curve25519
> scalar multiplication function, one for 32-bit systems, and one for
> 64-bit systems whose compiler supports efficient 128-bit integer types.
> Not only are these implementations formally verified, but they are also
> the fastest available C implementations. They have been modified to be
> friendly to kernel space and to be generally less horrendous looking,
> but still an effort has been made to retain their formally verified
> characteristic, and so the C might look slightly unidiomatic.
[]
> diff --git a/lib/zinc/curve25519/curve25519-fiat32.h b/lib/zinc/curve25519/curve25519-fiat32.h
[]
> +static __always_inline void fe_freeze(u32 out[10], const u32 in1[10])
> +{
> +	{ const u32 x17 = in1[9];
> +	{ const u32 x18 = in1[8];
> +	{ const u32 x16 = in1[7];
> +	{ const u32 x14 = in1[6];
> +	{ const u32 x12 = in1[5];
> +	{ const u32 x10 = in1[4];
> +	{ const u32 x8 = in1[3];
> +	{ const u32 x6 = in1[2];
> +	{ const u32 x4 = in1[1];
> +	{ const u32 x2 = in1[0];
> +	{ u32 x20; u8/*bool*/ x21 = subborrow_u26(0x0, x2, 0x3ffffed, &x20);
> +	{ u32 x23; u8/*bool*/ x24 = subborrow_u25(x21, x4, 0x1ffffff, &x23);
> +	{ u32 x26; u8/*bool*/ x27 = subborrow_u26(x24, x6, 0x3ffffff, &x26);
> +	{ u32 x29; u8/*bool*/ x30 = subborrow_u25(x27, x8, 0x1ffffff, &x29);
> +	{ u32 x32; u8/*bool*/ x33 = subborrow_u26(x30, x10, 0x3ffffff, &x32);
> +	{ u32 x35; u8/*bool*/ x36 = subborrow_u25(x33, x12, 0x1ffffff, &x35);
> +	{ u32 x38; u8/*bool*/ x39 = subborrow_u26(x36, x14, 0x3ffffff, &x38);
> +	{ u32 x41; u8/*bool*/ x42 = subborrow_u25(x39, x16, 0x1ffffff, &x41);
> +	{ u32 x44; u8/*bool*/ x45 = subborrow_u26(x42, x18, 0x3ffffff, &x44);
> +	{ u32 x47; u8/*bool*/ x48 = subborrow_u25(x45, x17, 0x1ffffff, &x47);
> +	{ u32 x49 = cmovznz32(x48, 0x0, 0xffffffff);
> +	{ u32 x50 = (x49 & 0x3ffffed);
> +	{ u32 x52; u8/*bool*/ x53 = addcarryx_u26(0x0, x20, x50, &x52);
> +	{ u32 x54 = (x49 & 0x1ffffff);
> +	{ u32 x56; u8/*bool*/ x57 = addcarryx_u25(x53, x23, x54, &x56);
> +	{ u32 x58 = (x49 & 0x3ffffff);
> +	{ u32 x60; u8/*bool*/ x61 = addcarryx_u26(x57, x26, x58, &x60);
> +	{ u32 x62 = (x49 & 0x1ffffff);
> +	{ u32 x64; u8/*bool*/ x65 = addcarryx_u25(x61, x29, x62, &x64);
> +	{ u32 x66 = (x49 & 0x3ffffff);
> +	{ u32 x68; u8/*bool*/ x69 = addcarryx_u26(x65, x32, x66, &x68);
> +	{ u32 x70 = (x49 & 0x1ffffff);
> +	{ u32 x72; u8/*bool*/ x73 = addcarryx_u25(x69, x35, x70, &x72);
> +	{ u32 x74 = (x49 & 0x3ffffff);
> +	{ u32 x76; u8/*bool*/ x77 = addcarryx_u26(x73, x38, x74, &x76);
> +	{ u32 x78 = (x49 & 0x1ffffff);
> +	{ u32 x80; u8/*bool*/ x81 = addcarryx_u25(x77, x41, x78, &x80);
> +	{ u32 x82 = (x49 & 0x3ffffff);
> +	{ u32 x84; u8/*bool*/ x85 = addcarryx_u26(x81, x44, x82, &x84);
> +	{ u32 x86 = (x49 & 0x1ffffff);
> +	{ u32 x88; addcarryx_u25(x85, x47, x86, &x88);
> +	out[0] = x52;
> +	out[1] = x56;
> +	out[2] = x60;
> +	out[3] = x64;
> +	out[4] = x68;
> +	out[5] = x72;
> +	out[6] = x76;
> +	out[7] = x80;
> +	out[8] = x84;
> +	out[9] = x88;
> +	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
> +}

Unidiomatic might be a stretch here...

[]

and elsewhere...

> +static void fe_add_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
> +{
> +	{ const u32 x20 = in1[9];
> +	{ const u32 x21 = in1[8];
> +	{ const u32 x19 = in1[7];
> +	{ const u32 x17 = in1[6];
> +	{ const u32 x15 = in1[5];
> +	{ const u32 x13 = in1[4];
> +	{ const u32 x11 = in1[3];
> +	{ const u32 x9 = in1[2];
> +	{ const u32 x7 = in1[1];
> +	{ const u32 x5 = in1[0];
> +	{ const u32 x38 = in2[9];
> +	{ const u32 x39 = in2[8];
> +	{ const u32 x37 = in2[7];
> +	{ const u32 x35 = in2[6];
> +	{ const u32 x33 = in2[5];
> +	{ const u32 x31 = in2[4];
> +	{ const u32 x29 = in2[3];
> +	{ const u32 x27 = in2[2];
> +	{ const u32 x25 = in2[1];
> +	{ const u32 x23 = in2[0];
> +	out[0] = (x5 + x23);
> +	out[1] = (x7 + x25);
> +	out[2] = (x9 + x27);
> +	out[3] = (x11 + x29);
> +	out[4] = (x13 + x31);
> +	out[5] = (x15 + x33);
> +	out[6] = (x17 + x35);
> +	out[7] = (x19 + x37);
> +	out[8] = (x21 + x39);
> +	out[9] = (x20 + x38);
> +	}}}}}}}}}}}}}}}}}}}}
> +}

etc...


