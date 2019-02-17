Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F79C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 737E021A4A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729085AbfBQNso convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 08:48:44 -0500
Received: from mail-oln040092070100.outbound.protection.outlook.com ([40.92.70.100]:3200
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727442AbfBQNso (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 08:48:44 -0500
Received: from DB5EUR03FT048.eop-EUR03.prod.protection.outlook.com
 (10.152.20.57) by DB5EUR03HT023.eop-EUR03.prod.protection.outlook.com
 (10.152.21.177) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Sun, 17 Feb
 2019 13:48:42 +0000
Received: from HE1PR0702MB3834.eurprd07.prod.outlook.com (10.152.20.52) by
 DB5EUR03FT048.mail.protection.outlook.com (10.152.21.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.11 via Frontend Transport; Sun, 17 Feb 2019 13:48:42 +0000
Received: from HE1PR0702MB3834.eurprd07.prod.outlook.com
 ([fe80::c2e:20b8:445d:e9af]) by HE1PR0702MB3834.eurprd07.prod.outlook.com
 ([fe80::c2e:20b8:445d:e9af%2]) with mapi id 15.20.1622.018; Sun, 17 Feb 2019
 13:48:41 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCHv3] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxp0Npbqs83BkVEynF/QYRVMIGKXkAb6A
Date:   Sun, 17 Feb 2019 13:48:41 +0000
Message-ID: <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5P189CA0030.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::43) To HE1PR0702MB3834.eurprd07.prod.outlook.com
 (2603:10a6:7:8e::30)
x-incomingtopheadermarker: OriginalChecksum:9D4502516549F696AE45C76E194427B1AC033BF453A3EED20D8A19EC03DACB2B;UpperCasedChecksum:D0D4B450A5E4D85A8183FF693A9FB0369D7BD9FDDE01845CDB17E4C11BDABD5E;SizeAsReceived:8778;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [+NW7BeRom402ppoYXaTXmFUjmRfbRIe8]
x-microsoft-original-message-id: <d5d87743-1ff4-0ff1-b1a7-d83ec6c83040@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:DB5EUR03HT023;
x-ms-traffictypediagnostic: DB5EUR03HT023:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:DB5EUR03HT023;BCL:0;PCL:0;RULEID:;SRVR:DB5EUR03HT023;
x-microsoft-antispam-message-info: 1LwlFIvIT7bqXGhVH0Ip5zTs8IbkksZLHqjYjX54pE/YxSvBzbEe//tEQ7c0FAL8
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <0F88F59EDCC3B44DBCCD7C3B59D9789D@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: ed05564d-d9c5-4a1b-1dc3-08d694dea049
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2019 13:48:40.8628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5EUR03HT023
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/19 9:44 AM, Bernd Edlinger wrote:
>  
> +		if (crng_ready() && !blocking_pool.initialized &&

After some more debugging I realize that blocking_pool.initialized
is true after 128 bits of input entropy, but that is only 80 bits
credited, due to the asymptotic 3/4 crediting formula.

I see that will also enable the code path below:

                if (entropy_bits > random_write_wakeup_bits &&
                    r->initialized &&
                    r->entropy_total >= 2*random_read_wakeup_bits) {
                        struct entropy_store *other = &blocking_pool;

                        if (other->entropy_count <=
                            3 * other->poolinfo->poolfracbits / 4) {
                                schedule_work(&other->push_work);
                                r->entropy_total = 0;
                        }

when random_write_wakeup_bits is below 80, and random_read_wakeup_bits
is also smallish.  This depletes the input_pool in favor of the
blocking pool, while we are actually waiting for the input_pool to
reach 128 bits security strength, in order to seed the CRNG.

I am testing a new version and will post it later today.

Sorry for all the back-and forth.


Bernd.
