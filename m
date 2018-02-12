Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751023AbeBLTbw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 14:31:52 -0500
Received: from mail-by2nam01on0105.outbound.protection.outlook.com ([104.47.34.105]:45032
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750933AbeBLTbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 14:31:48 -0500
From: Trent Piepho <tpiepho@impinj.com>
To: "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "bcm-kernel-feedback-list@broadcom.com"
        <bcm-kernel-feedback-list@broadcom.com>,
        "stefan.wahren@i2se.com" <stefan.wahren@i2se.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "eric@anholt.net" <eric@anholt.net>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-rpi-kernel@lists.infradead.org"
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "garsilva@embeddedor.com" <garsilva@embeddedor.com>
Subject: Re: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
Thread-Topic: [PATCH] spi: bcm2835aux: use 64-bit arithmetic instead of 32-bit
Thread-Index: AQHToDA3uMaM2jOqzEGd7HoTdzdONKOhL9uA
Date: Mon, 12 Feb 2018 19:31:46 +0000
Message-ID: <1518463905.25398.281.camel@impinj.com>
References: <20180207160002.GA9292@embeddedgus>
In-Reply-To: <20180207160002.GA9292@embeddedgus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3786;7:PR+mZBB74rYGZgd2xbTOoAIjrAkQLLXnaqEGJ++2VVJb2oSf75/Ysm0vei53qz8+sFStIYPiootNx/uOtmIXWbEDZwNn7hmWo8P6Gas5BiSz3oGs9mm4Fh2owxAL4UXAwSJhcYzwmFSXuTyxiOgitBeNYwS/p8sJqA5Q2C/1jUA9M1cTARSw3JV1SzSQMVthSfw3pGstOvmhH4FH9cMZ2br3BefEfr5GnlygD68jJ/GI1Mcxal9uANm41cWQsNSM
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-correlation-id: 3a1eb6c6-e644-44d5-24b3-08d5724f4101
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7153060)(7193020);SRVR:MWHPR0601MB3786;
x-ms-traffictypediagnostic: MWHPR0601MB3786:
x-microsoft-antispam-prvs: <MWHPR0601MB3786465548DC69DE1A7BC986D3F70@MWHPR0601MB3786.namprd06.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(3002001)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR0601MB3786;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0601MB3786;
x-forefront-prvs: 0581B5AB35
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(366004)(39840400004)(346002)(189003)(199004)(377424004)(66066001)(53936002)(4326008)(105586002)(2201001)(5660300001)(103116003)(6436002)(39060400002)(3660700001)(6486002)(86362001)(305945005)(2900100001)(7736002)(6512007)(99286004)(3280700002)(14454004)(7416002)(229853002)(6246003)(2501003)(68736007)(5250100002)(36756003)(25786009)(59450400001)(102836004)(2950100002)(3846002)(2906002)(6506007)(81156014)(81166006)(26005)(8676002)(316002)(6116002)(76176011)(6346003)(110136005)(97736004)(106356001)(186003)(478600001)(54906003)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3786;H:MWHPR0601MB3753.namprd06.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com;
x-microsoft-antispam-message-info: 7auNn61vxGbC9fEB8peIrgcXdYpKacosLvJMtN+D2gRvZxCKTRn2+l+32sb8QO0isTB+yGFSdM7FnMdB7V+OAw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <86ADEA02724F604596EAF6370778382E@namprd06.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a1eb6c6-e644-44d5-24b3-08d5724f4101
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2018 19:31:46.0901
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3786
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1CJVvEJ010090

On Wed, 2018-02-07 at 10:00 -0600, Gustavo A. R. Silva wrote:
> Add suffix ULL to constant 9 in order to give the compiler complete
> information about the proper arithmetic to use. Notice that this
> constant is used in a context that expects an expression of type
> unsigned long long (64 bits, unsigned).
> 
> The expression tfr->len * 9 * 1000000 is currently being evaluated
> using 32-bit arithmetic.
> 
> Addresses-Coverity-ID: 1339619
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/spi/spi-bcm2835aux.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-bcm2835aux.c b/drivers/spi/spi-bcm2835aux.c
> index 7428091..a768c23 100644
> --- a/drivers/spi/spi-bcm2835aux.c
> +++ b/drivers/spi/spi-bcm2835aux.c
> @@ -363,7 +363,7 @@ static int bcm2835aux_spi_transfer_one(struct spi_master *master,
>  	 * chunk getting transferred - in our case the chunk size
>  	 * is 3 bytes, so we approximate this by 9 bits/byte
>  	 */
> -	xfer_time_us = tfr->len * 9 * 1000000;
> +	xfer_time_us = tfr->len * 9ULL * 1000000;
>  	do_div(xfer_time_us, spi_used_hz);
>  
>  	/* run in polling mode for short transfers */
	if (xfer_time_us < BCM2835_AUX_SPI_POLLING_LIMIT_US)

If one looks at the logic as a whole...

tfr->len * 9ULL * 100000 / spi_used_hz < 30

A little algebra can change that into:

tfr->len < spi_used_hz / 300000

So rather than add more 64-bit math, it can be removed entirely.  Both
the length and speed are 32 bits and there's no need to multiply them
into something larger than might need 64 bits.
