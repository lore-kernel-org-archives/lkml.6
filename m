Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id ACBF5C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D977208B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 10:52:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D977208B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935003AbeFMKwF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 06:52:05 -0400
Received: from smtp-out6.electric.net ([192.162.217.195]:65284 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754096AbeFMKwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 06:52:03 -0400
Received: from 1fT3Nc-0001aX-VP by out6d.electric.net with emc1-ok (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fT3Nf-0001vA-U1; Wed, 13 Jun 2018 03:51:59 -0700
Received: by emcmailer; Wed, 13 Jun 2018 03:51:59 -0700
Received: from [156.67.243.126] (helo=AcuMS.aculab.com)
        by out6d.electric.net with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1fT3Nc-0001aX-VP; Wed, 13 Jun 2018 03:51:56 -0700
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 Jun 2018 11:53:07 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Jun 2018 11:53:07 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Zhouyang Jia' <jiazhouyang09@gmail.com>
CC:     Oleg Drokin <oleg.drokin@intel.com>,
        Andreas Dilger <andreas.dilger@intel.com>,
        James Simmons <jsimmons@infradead.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        NeilBrown <neilb@suse.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        "lustre-devel@lists.lustre.org" <lustre-devel@lists.lustre.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] staging: lustre: add error handling for try_module_get
Thread-Topic: [PATCH] staging: lustre: add error handling for try_module_get
Thread-Index: AQHUAgjuv8cfdxrCkEmiAy/zv5sqdqReAu6Q
Date:   Wed, 13 Jun 2018 10:53:07 +0000
Message-ID: <ed5d91f54b5a4776a66df87b645b0ee9@AcuMS.aculab.com>
References: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
In-Reply-To: <1528778968-42225-1-git-send-email-jiazhouyang09@gmail.com>
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

From: Zhouyang Jia
> Sent: 12 June 2018 05:49
> 
> When try_module_get fails, the lack of error-handling code may
> cause unexpected results.
> 
> This patch adds error-handling code after calling try_module_get.
...
> +++ b/drivers/staging/lustre/lnet/klnds/socklnd/socklnd.c
> @@ -2422,7 +2422,10 @@ ksocknal_base_startup(void)
> 
>  	/* flag lists/ptrs/locks initialised */
>  	ksocknal_data.ksnd_init = SOCKNAL_INIT_DATA;
> -	try_module_get(THIS_MODULE);
> +	if (!try_module_get(THIS_MODULE)) {
> +		CERROR("%s: cannot get module\n", __func__);
> +		goto failed;
> +	}


Can try_module_get(THIS_MODULE) ever fail?
Since you are running code in 'THIS_MODULE' the caller must have a
reference that can't go away.
So try_module_get() just increments the count that is already greater
than zero.

Similarly module_put(THIS_MODULE) must never be able to release the
last reference.
Any such calls that aren't in error paths after try_module_get() are
probably buggy.

	David

