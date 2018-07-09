Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28835C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85B62087F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 09:15:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85B62087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932435AbeGIJPH convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 05:15:07 -0400
Received: from smtp-out4.electric.net ([192.162.216.195]:59097 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754142AbeGIJPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 05:15:06 -0400
Received: from 1fcSG3-000BOb-Uw by out4d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcSG5-000BW2-TP; Mon, 09 Jul 2018 02:15:01 -0700
Received: by emcmailer; Mon, 09 Jul 2018 02:15:01 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out4d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fcSG3-000BOb-Uw; Mon, 09 Jul 2018 02:14:59 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b::d117) by AcuMS.aculab.com
 (fd9f:af1c:a25b::d117) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon,
 9 Jul 2018 10:16:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 9 Jul 2018 10:16:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Brodkin' <Alexey.Brodkin@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        Greg KH <greg@kroah.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Topic: [RESEND PATCH v2] devres: Really align data field to unsigned
 long long
Thread-Index: AQHUFz/Ztg2k3cQGIk2o/MVnG+7l9qSGmpBQ
Date:   Mon, 9 Jul 2018 09:16:38 +0000
Message-ID: <f7499a811ba54c00a11f7525ae216213@AcuMS.aculab.com>
References: <20180709044444.6397-1-abrodkin@synopsys.com>
In-Reply-To: <20180709044444.6397-1-abrodkin@synopsys.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.33]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 156.67.243.126
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuMS.aculab.com
X-TLS:  TLSv1.2:ECDHE-RSA-AES256-SHA384:256
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexey Brodkin
> Sent: 09 July 2018 05:45
> Depending on ABI "long long" type of a particular 32-bit CPU
> might be aligned by either word (32-bits) or double word (64-bits).
> Make sure "data" is really 64-bit aligned for any 32-bit CPU.
> 
> At least for 32-bit ARC cores ABI requires "long long" types
> to be aligned by normal 32-bit word. This makes "data" field aligned to
> 12 bytes. Which is still OK as long as we use 32-bit data only.
> 
> But once we want to use native atomic64_t type (i.e. when we use special
> instructions LLOCKD/SCONDD for accessing 64-bit data) we easily hit
> misaligned access exception.

Shouldn't there be a typedef for the actual type.
Perhaps it is even atomic64_t ?
And have the __aligned(8) applied to that typedef ??

> That's because even on CPUs capable of non-aligned data access LL/SC
> instructions require strict alignment.
...
> --- a/drivers/base/devres.c
> +++ b/drivers/base/devres.c
> @@ -24,8 +24,12 @@ struct devres_node {
> 
>  struct devres {
>  	struct devres_node		node;
> -	/* -- 3 pointers */
> -	unsigned long long		data[];	/* guarantee ull alignment */
> +	/*
> +	 * Depending on ABI "long long" type of a particular 32-bit CPU
> +	 * might be aligned by either word (32-bits) or double word (64-bits).
> +	 * Make sure "data" is really 64-bit aligned for any 32-bit CPU.

Just:
	/* data[] must be 64 bit aligned even on 32 bit architectures
	 * because it might be accessed by instructions that require
	 * aligned memory arguments.

> +	 */
> +	unsigned long long		data[] __aligned(sizeof(unsigned long long));

One day assuming that 'unsigned long long' is exactly 64 bits will bite.
This probably ought to be u64 (or similar).
(If not atomic64_t)

	David



