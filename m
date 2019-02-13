Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0312CC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:56:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C59FF222E3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392589AbfBMP4I convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 10:56:08 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:57799 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389192AbfBMP4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 10:56:08 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-78-cgJCcBveOA6ngiNPG7z4FA-1; Wed, 13 Feb 2019 15:56:04 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 Feb 2019 15:56:47 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 Feb 2019 15:56:47 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'Tobin C. Harding'" <tobin@kernel.org>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>
CC:     Tycho Andersen <tycho@tycho.ws>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Thread-Topic: [PATCH 3/3] leaking_addresses: Expand tilde in output file name
Thread-Index: AQHUvze0635TNBS/ZEmpDgH2942+BqXd6ssg
Date:   Wed, 13 Feb 2019 15:56:47 +0000
Message-ID: <6aed136f16e8451dbcfa97f90c04438f@AcuMS.aculab.com>
References: <20190207225026.11723-1-tobin@kernel.org>
 <20190207225026.11723-4-tobin@kernel.org>
In-Reply-To: <20190207225026.11723-4-tobin@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: cgJCcBveOA6ngiNPG7z4FA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tobin C. Harding
> Sent: 07 February 2019 22:50
> 
> Currently if user passes an output file to the script via
> --output-raw we do not handle expansion of tilde.
> 
> Use perl function glob() to expand tilde in output file name.

What happens if glob() returns multiple files?
I'm guessing that it can...

	David

> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  scripts/leaking_addresses.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/leaking_addresses.pl b/scripts/leaking_addresses.pl
> index ef9e5b2a1614..ce545ca3fb70 100755
> --- a/scripts/leaking_addresses.pl
> +++ b/scripts/leaking_addresses.pl
> @@ -150,7 +150,7 @@ if (!(is_supported_architecture() or $opt_32bit or $page_offset_32bit)) {
>  }
> 
>  if ($output_raw) {
> -	open my $fh, '>', $output_raw or die "$0: $output_raw: $!\n";
> +	open my $fh, '>', glob($output_raw) or die "$0: $output_raw: $!\n";
>  	select $fh;
>  }
> 
> --
> 2.20.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

