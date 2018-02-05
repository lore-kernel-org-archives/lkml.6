Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeBEOFx (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 09:05:53 -0500
Received: from mail-edgeDD24.fraunhofer.de ([192.102.167.24]:57903 "EHLO
        mail-edgeDD24.fraunhofer.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752607AbeBEOFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 09:05:45 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2GiAADHYXha/xoBYJlcGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYNRZnAyg1uKJHSNOYICl0iCGAojhRgCGoIuVBgBAQEBAQEBAQI?=
 =?us-ascii?q?DaCiFJQEFIxFFEAIBCBgCAiYCAgIwFRACBAENijkBEL9sgieEFgEBhFqCBgEBA?=
 =?us-ascii?q?QEBAQEDAQEBAQEBAQEBGgWBD4NbgQ6BB4FYgWeDLoUiF4MAgmUFil+JW49lBgK?=
 =?us-ascii?q?BHYZ6jViCHoYmg26IBY1tigmBPB86gVBxgxiCVBwZgTIBOo4fgRcBAQE?=
X-IPAS-Result: =?us-ascii?q?A2GiAADHYXha/xoBYJlcGQEBAQEBAQEBAQEBAQcBAQEBAYN?=
 =?us-ascii?q?RZnAyg1uKJHSNOYICl0iCGAojhRgCGoIuVBgBAQEBAQEBAQIDaCiFJQEFIxFFE?=
 =?us-ascii?q?AIBCBgCAiYCAgIwFRACBAENijkBEL9sgieEFgEBhFqCBgEBAQEBAQEDAQEBAQE?=
 =?us-ascii?q?BAQEBGgWBD4NbgQ6BB4FYgWeDLoUiF4MAgmUFil+JW49lBgKBHYZ6jViCHoYmg?=
 =?us-ascii?q?26IBY1tigmBPB86gVBxgxiCVBwZgTIBOo4fgRcBAQE?=
X-IronPort-AV: E=Sophos;i="5.46,464,1511823600";
   d="scan'208";a="1203385"
X-IronPort-AV: E=Sophos;i="5.46,464,1511823600";
   d="scan'208";a="9560639"
From: "Auer, Lukas" <lukas.auer@aisec.fraunhofer.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aymen.sghaier@nxp.com" <aymen.sghaier@nxp.com>,
        "horia.geanta@nxp.com" <horia.geanta@nxp.com>,
        "pure.logic@nexus-software.ie" <pure.logic@nexus-software.ie>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "ryan.harkin@linaro.org" <ryan.harkin@linaro.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "rui.silva@linaro.org" <rui.silva@linaro.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>
Subject: Re: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Topic: [PATCH v3 2/5] crypto: caam: Fix endless loop when RNG is
 already initialized
Thread-Index: AQHTmjdPDFt5DoJeZkev9KNOEKfDKqOVzIwA
Date: Mon, 5 Feb 2018 13:54:43 +0000
Message-ID: <1517838882.2601.12.camel@aisec.fraunhofer.de>
References: <1517364040-27607-1-git-send-email-pure.logic@nexus-software.ie>
         <1517364040-27607-3-git-send-email-pure.logic@nexus-software.ie>
         <VI1PR0402MB334297558BB1984131546B1D98FA0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
         <78ad6a62-190c-e4fe-dd23-e1d058f9bbb2@nexus-software.ie>
         <1517576063.2002.19.camel@aisec.fraunhofer.de>
         <VI1PR0402MB3342899B009D1A6CC0569CFE98FE0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
In-Reply-To: <VI1PR0402MB3342899B009D1A6CC0569CFE98FE0@VI1PR0402MB3342.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.80.233.51]
x-tm-as-product-ver: SMEX-11.0.0.4179-8.200.1013-23642.006
x-tm-as-result: No--28.683800-8.000000-31
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
Content-Type: text/plain; charset="utf-8"
Content-ID: <77ED0A1B7A0D954C88D393EDE2337E77@xch.fraunhofer.de>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w15E65NC021757

On Mon, 2018-02-05 at 08:45 +0000, Horia Geantă wrote:
> On 2/2/2018 2:54 PM, Auer, Lukas wrote:
> > On Fri, 2018-02-02 at 11:20 +0000, Bryan O'Donoghue wrote:
> > > On 01/02/18 12:16, Horia Geantă wrote:
> > > > If the loop cannot exit based on value of "ret" != -EAGAIN,
> > > > then it
> > > > means
> > > > caam_probe() will eventually fail due to ret == -EAGAIN:
> > > > 	if (ret) {
> > > > 		dev_err(dev, "failed to instantiate RNG");
> > > > 		goto caam_remove;
> > > > 	}
> > > 
> > > For me it's an endless loop applying the first two
> > > 
> > > https://patchwork.ozlabs.org/patch/866460/
> > > https://patchwork.ozlabs.org/patch/866462/
> > > 
> > > but not this one
> > > 
> > > https://patchwork.ozlabs.org/patch/865890/
> > > 
> 
> [snip]
> > 
> > I think the problem lies in the instantiate_rng() function. If the
> > driver is unable to acquire DEC0 it'll return -ENODEV. This should
> > terminate the while loop in the probe function. However, the return
> > value is never checked and is instead overwritten with -EAGAIN,
> > causing
> > the endless loop.
> > 
> > This problem only occurs if u-boot instantiates only one of the
> > state
> > handles (ent_delay doesn't get incremented) and the kernel runs in
> > non-
> > secure mode (DEC0 can't get acquired). Instantiating all state
> > handles
> > in u-boot therefore fixes this problem. In addition, the return
> > value
> > in instantiate_rng() should be handled correctly by including
> > 
> > if (ret)
> > 	break;
> > 
> > right after "ret = run_descriptor_deco0(ctrldev, desc, &status);".
> > 
> 
> Indeed, the error path is incorrect and should be fixed as you
> mentioned.
> I will send a patch replacing this one.
> Note that this fixes only the error path, meaning caam_probe() won't
> go into an
> endless loop and instead will return -ENODEV, due to being unable to
> acquire
> control of DECO0.
> 
> There are still a few hurdles to cross for CAAM to work in a TZ
> environment.
> 
> For e.g. could you please check / confirm whether DECO0MIDR (DECO0
> MID registers
> @0xA0, @0xA4) are set such that Linux kernel is allowed to r/w DECO0-
> related
> registers?
> 
> Thanks,
> Horia

On my board DECO0 MID ms is set to 0x8001, which I believe (going by
the structure of the other MID registers, since some of the bits are
only marked as reserved) is a MID of 1 (A7 cores) in secure mode.
Changing this to 0x9 for a MID of 1 in non-secure mode still fails the
DEC0 acquisition step in the probe call.

So unfortunately I am not sure what / if other steps are required to
use the CAAM in non-secure mode. Running a quick test with openssl
speed (using CAAM with cryptodev), it at least seems to be working.

Thanks,
Lukas
