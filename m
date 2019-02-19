Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1244C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C78C021904
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbfBSHQc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:16:32 -0500
Received: from mail-oln040092069108.outbound.protection.outlook.com ([40.92.69.108]:6164
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725536AbfBSHQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:16:32 -0500
Received: from AM5EUR02FT003.eop-EUR02.prod.protection.outlook.com
 (10.152.8.58) by AM5EUR02HT095.eop-EUR02.prod.protection.outlook.com
 (10.152.9.203) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Tue, 19 Feb
 2019 07:16:28 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.8.56) by
 AM5EUR02FT003.mail.protection.outlook.com (10.152.8.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Tue, 19 Feb 2019 07:16:28 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.008; Tue, 19 Feb 2019
 07:16:28 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4] random: Make /dev/random wait for input_pool
 initialized
Thread-Topic: [PATCHv4] random: Make /dev/random wait for input_pool
 initialized
Thread-Index: AQHUxwMldu7JSGDWkkyAZcNCWFdW+6XmrAqK
Date:   Tue, 19 Feb 2019 07:16:28 +0000
Message-ID: <VI1PR0702MB38409DE458C09B046CDED5DEE47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>,<VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
In-Reply-To: <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:0BAE49BC10391D817B65117266A4495998BF3A81972E6A3D348D562EEB9C6924;UpperCasedChecksum:12E718EDF0BD48AAD3FD33B38A79654C6ED9F605894B7FC926467AA7E1A143F1;SizeAsReceived:7473;Count:44
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qGc7881LEF23rqR+g2ZY+TyW+p9cOAWW]
x-ms-publictraffictype: Email
x-incomingheadercount: 44
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:AM5EUR02HT095;
x-ms-traffictypediagnostic: AM5EUR02HT095:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:AM5EUR02HT095;BCL:0;PCL:0;RULEID:;SRVR:AM5EUR02HT095;
x-microsoft-antispam-message-info: kFt7wxjPPwITkXaPWXHBuVS27zLUC68oISmkbK2EaZ9XE2wsG8YaLZD/ItXxY/Hs
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: a63959fb-e918-425b-f402-08d6963a2a55
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 07:16:28.0888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5EUR02HT095
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> @@ -1826,7 +1830,9 @@ _random_read(int nonblock, char __user *buf, size_t nbytes)
> 
>         nbytes = min_t(size_t, nbytes, SEC_XFER_SIZE);
>         while (1) {
> -               n = extract_entropy_user(&blocking_pool, buf, nbytes);
> +               n = input_pool.initialized
> +                       ? extract_entropy_user(&blocking_pool, buf, nbytes)

Aehm, sorry, now I see this creates a race condition with this code here, since
this the crng_reseed here also tries to read from the input_pool,
but input_pool.initialized is already true:

                if (crng_init < 2 && entropy_bits >= 128) {
                        crng_reseed(&primary_crng, r);
                        entropy_bits = r->entropy_count >> ENTROPY_SHIFT;


I was able to get a system in this behavior by running 3 instances of
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
  int f = open("/dev/random", O_NDELAY);
  if (f<0) return 1;
  for(;;)
  {
    unsigned char buf[16];
    int x = read(f, buf, sizeof(buf));
    if (x>=0)
    {
      int i;

      printf("read %d bytes: ", x);
      for (i=0; i<x; i++) printf("%02x ", buf[i]);
      printf("\n");
    }
  }
}

and it managed to steal the entropy away,
before the crng_reseed was able to run.

So I think I will have to change this condition to:
> +               n = input_pool.initialized && crng_ready()
> +                       ? extract_entropy_user(&blocking_pool, buf, nbytes)


Thanks (for your patience :-)
Bernd.
