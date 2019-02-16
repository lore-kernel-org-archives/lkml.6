Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CF7C10F06
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DBEF21B69
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 20:13:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733088AbfBPUM0 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 15:12:26 -0500
Received: from mail-oln040092071042.outbound.protection.outlook.com ([40.92.71.42]:18153
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727270AbfBPUM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 15:12:26 -0500
Received: from AM5EUR03FT003.eop-EUR03.prod.protection.outlook.com
 (10.152.16.59) by AM5EUR03HT170.eop-EUR03.prod.protection.outlook.com
 (10.152.17.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1580.17; Sat, 16 Feb
 2019 20:12:22 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.16.59) by
 AM5EUR03FT003.mail.protection.outlook.com (10.152.16.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.17 via Frontend Transport; Sat, 16 Feb 2019 20:12:22 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.008; Sat, 16 Feb 2019
 20:12:22 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] random: Make /dev/random wait for crng_ready
Thread-Topic: [PATCHv2] random: Make /dev/random wait for crng_ready
Thread-Index: AQHUxTaCraRKyzzTqEeNDzUOb6MJSKXivx+AgAAeTIA=
Date:   Sat, 16 Feb 2019 20:12:22 +0000
Message-ID: <VI1PR0702MB38404F3D4D54432E3F8F0048E4610@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
In-Reply-To: <20190216182355.GE23000@mit.edu>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM6PR07CA0033.eurprd07.prod.outlook.com
 (2603:10a6:209:2a::46) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:339E9F3F5D42DCEBD653D585D7924D19B009C2EA10C4A85955EA168BF5EE861D;UpperCasedChecksum:ADB8F8B4D0509FFCCB19686A91372D0CB2CD6F4F8AF180A6C2530009421459BB;SizeAsReceived:8659;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [JX1xZg+Hzkqsfkx1wlcINy/4fx7+pox0]
x-microsoft-original-message-id: <deb07c24-5a12-5400-bacc-77e4c414f88b@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1603101475)(1601125500)(1701031045);SRVR:AM5EUR03HT170;
x-ms-traffictypediagnostic: AM5EUR03HT170:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR03HT170;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR03HT170;
x-microsoft-antispam-message-info: cGNs7ztfnWbP4rZ1kcv+eMdFrBBd0Adi6X5rfMy2xCQSLhkYEHaGdUyKplxjr7xs
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <4802362507702C40B17069E64B0C0209@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f41d252-03b1-4a9f-3217-08d6944b0f64
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2019 20:12:21.7684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR03HT170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/19 7:23 PM, Theodore Y. Ts'o wrote:
> 
> This really isn't a correct way to fix things; since the blocking_pool
> used for /dev/random and the CRNG state are different things, and are
> fed by different sources of entropy.
> 

It is interesting that random_poll does only look at input_pool.
Could it be that the existing entropy in blocking_pool also matters?

My observation is that _random_read extracts always the requested
number of bytes from the input_pool by calling extract_entropy_user.
By not calling extract_entropy_user it is straight forward to ensure
that the entropy in the input_pool can accumulate until the primary_crng
is being initialized.

> What we should do is to have a separate flag which indicates that the
> blocking_pool has been adequately initialized, and set it only when
> the entropy count in the blocking pool is at least 128 bits.  When get
> woken up by the reader lock, we would transfer entropy from the input
> pool to the blocking pool, and if the pool is not yet initializedm,
> and the entropy count is less than 128 bits, we wait until it is.
> 

What happens for me, is that single byte reads out of /dev/random are able
to pull so much entropy out of the input_pool that the input_pool
never reaches 128 bit and therefore crng_ready will never be true.

Therefore I want to delay the blocking_pool until the CRNG is fully
initialized.  I hope you agree about that.

When that is done, there are two ways how entropy is transferred
from the input_pool to the blocking_pool, just to confirm I have
not overlooked something:

                /* If the input pool is getting full, send some
                 * entropy to the blocking pool until it is 75% full.
                 */
                if (entropy_bits > random_write_wakeup_bits &&
                    r->initialized &&
                    r->entropy_total >= 2*random_read_wakeup_bits) {
                        struct entropy_store *other = &blocking_pool;

                        if (other->entropy_count <=
                            3 * other->poolinfo->poolfracbits / 4) {
                                schedule_work(&other->push_work);
                                r->entropy_total = 0;
                        }
                }

this rarely happens, before crng_ready because it requires more than
128 bits of entropy, at least in my setup.

The other path is:
_random_read->extract_entropy_user->xfer_secondary_pool

which pulls at least to random_read_wakeup_bits / 8
from the input_pool to the blocking_pool, 
and the same amount of entropy is extracted again
from the blocking_pool so the blocking_pool's entropy_count
effectively stays at zero, when this path is taken.

That you don't like, right?

You propose to disable the second path until the first path
has pulled 128 bits into the blocking_pool, right?


Thanks
Bernd.
