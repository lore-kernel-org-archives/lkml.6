Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031728AbeEZLLa (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 07:11:30 -0400
Received: from mail-db5eur01on0051.outbound.protection.outlook.com ([104.47.2.51]:40208
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031606AbeEZLL2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 07:11:28 -0400
From: Vadim Pasternak <vadimp@mellanox.com>
To: Darren Hart <dvhart@infradead.org>
CC: "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org"
        <platform-driver-x86@vger.kernel.org>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        Michael Shych <michaelsh@mellanox.com>,
        "ivecera@redhat.com" <ivecera@redhat.com>
Subject: RE: [PATCH v2 3/7] platform/mellanox: mlxreg-hotplug: add extra cycle
 for hotplug work queue
Thread-Topic: [PATCH v2 3/7] platform/mellanox: mlxreg-hotplug: add extra
 cycle for hotplug work queue
Thread-Index: AQHT5b9NAE8UvXXsVEewGqe0n+XUzaQ/qPsAgAJNU8A=
Date: Sat, 26 May 2018 11:11:24 +0000
Message-ID: <HE1PR0502MB375373810FB25EE95704FD1CA2680@HE1PR0502MB3753.eurprd05.prod.outlook.com>
References: <1525675735-125547-1-git-send-email-vadimp@mellanox.com>
 <20180524235214.GA10172@fury>
In-Reply-To: <20180524235214.GA10172@fury>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vadimp@mellanox.com;
x-originating-ip: [46.120.54.214]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR0502MB2986;7:r0t3WP0BjOZ1qW5XnY4znHPVWHcafrOgPoxvEvnIo57dtbTK/xC/L1SkEcGaH5FZ68VIfKbKu9znxdqofFa0Hv7aD40+kpwQJ90MDJqggl64e+x3gf8pC0zUv2cfiOYFc1pze24BONRgQJlxWotB/j0nNQI8uuSLQ2pV4J89omsYae6mV2k3QALjvJvIOqoQ5th+zFeRavDowyOFqjX402n8d0wgRXCnWvOYkHm2QNulEgCdr/njuTLHQSoNZ9Bu
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0502MB2986;
x-ms-traffictypediagnostic: HE1PR0502MB2986:
x-microsoft-antispam-prvs: <HE1PR0502MB2986F025825E347952FA5189A2680@HE1PR0502MB2986.eurprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR0502MB2986;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0502MB2986;
x-forefront-prvs: 0684F80A5C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(346002)(39380400002)(376002)(366004)(396003)(13464003)(199004)(189003)(2906002)(74316002)(6916009)(99286004)(105586002)(5250100002)(68736007)(106356001)(446003)(53936002)(6246003)(6506007)(186003)(53546011)(86362001)(102836004)(9686003)(478600001)(25786009)(26005)(55016002)(39060400002)(76176011)(486006)(7696005)(476003)(11346002)(14454004)(4326008)(97736004)(305945005)(7736002)(66066001)(3846002)(6116002)(345774005)(81166006)(81156014)(3280700002)(3660700001)(229853002)(54906003)(33656002)(6436002)(316002)(2900100001)(8676002)(5660300001)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0502MB2986;H:HE1PR0502MB3753.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: fjmMac2QfXEN5gMTviNiqFTJdemP1MgTykcyUOvdiDI0e5wAx7cHyaLUI5aWtzuzQhQcAOQBWsgkEVPSXfd3zYsuYHD55zKK+hamQGcehA9sZmbkwkRjm7p12baTypBQn3ANXed6zai44HuewuoHnJRTX3JiBQRa0K0nfoajzZfDoMEQtSgAT9AjCHuuVRwV
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d040297-a749-49ce-c153-08d5c2f96b9e
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d040297-a749-49ce-c153-08d5c2f96b9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2018 11:11:24.8192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0502MB2986
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4QBBe1I006736



> -----Original Message-----
> From: Darren Hart [mailto:dvhart@infradead.org]
> Sent: Friday, May 25, 2018 2:52 AM
> To: Vadim Pasternak <vadimp@mellanox.com>
> Cc: andy.shevchenko@gmail.com; gregkh@linuxfoundation.org; linux-
> kernel@vger.kernel.org; platform-driver-x86@vger.kernel.org; jiri@resnulli.us;
> Michael Shych <michaelsh@mellanox.com>; ivecera@redhat.com
> Subject: Re: [PATCH v2 3/7] platform/mellanox: mlxreg-hotplug: add extra cycle
> for hotplug work queue
> 
> On Mon, May 07, 2018 at 06:48:51AM +0000, Vadim Pasternak wrote:
> 
> Hi Vadim,
> 
> > Add extra cycle for hotplug work queue to handle the case when a
> > signal is It adds missed logic for signal acknowledge, by adding an
> > extra run for received, but no specific signal assertion is detected.
> > Such case theoretically can happen for example in case several units
> > are removed or inserted at the same time. In this situation
> > acknowledge for some signal can be missed at signal top aggreagation
> > status level. The extra run will allow to handler to acknowledge the missed
> signal.
> >
> 
> ...
> 
> >
> > Fixes: 07b89c2b2a5e ("platform/x86: Introduce support for Mellanox
> > hotplug driver")
> 
> This sha doesn't exist in mainline, I believe you are referring to:
> 
> $ git l | grep "Introduce support for Mellanox hotplug"
> 304887041d95 platform/x86: Introduce support for Mellanox hotplug driver
> 
> While this was introduced in 4.10. There have been many changes since then,
> with significant changes in the 4.17 cycle. I have not added the stable tag, please
> let me know if you think this should be pushed to stable, and which of the
> intervening patches you'd consider dependencies.

Hi Darren,

Thank you for review.

I think it's worth pushing to stable.
It doesn't depend one previous patches from the patchset, but possibly
this one, which just fixes few comments in mlxreg-hotplug:
platform/mellanox: mlxreg-hotplug: Document fixes for hotplug private data
(commit 321089a4da2f6b20bb8af96354f76d260a4ca2c6 in testing branch).

Thanks,
Vadim.

> 
> I've fixed the sha in the commit message, and queued for testing.
> 
> Thanks,
> 
> --
> Darren Hart
> VMware Open Source Technology Center
