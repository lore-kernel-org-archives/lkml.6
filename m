Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A6AFC04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24B902146D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="scF8nEnY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24B902146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeLEWMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:12:49 -0500
Received: from mail-eopbgr140089.outbound.protection.outlook.com ([40.107.14.89]:8869
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727177AbeLEWMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGIWixr5FddhsvUf6x/OnJmn5sS/kDYR3Imd70ITnPU=;
 b=scF8nEnY/9Jg5Yt+t+8M99dtx/NW3xfKdklpxnCPeUAAIj/bbLg+Tf0/Wox1Ea0Jrz7exXE4loU/m8mJstEDmFFUA8BbAm0EQDhR9hiDl1jYCGQ+Kpsuju6HDqSc+PccSCy+GGbqMGBe0XEWEbENKcMKrymI9DCwKlYEDF+N4mI=
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com (52.134.90.16) by
 AM0PR04MB5171.eurprd04.prod.outlook.com (20.177.42.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Wed, 5 Dec 2018 22:12:32 +0000
Received: from AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd]) by AM0PR04MB3971.eurprd04.prod.outlook.com
 ([fe80::f038:ecc0:3ab5:3bbd%4]) with mapi id 15.20.1382.023; Wed, 5 Dec 2018
 22:12:32 +0000
From:   York Sun <york.sun@nxp.com>
To:     Tracy Smith <tlsmith3777@gmail.com>
CC:     "bp@alien8.de" <bp@alien8.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Patrol scrub questions
Thread-Topic: Patrol scrub questions
Thread-Index: AQHUjOXeG80AvMT2PUyh4Y5jZvIPKQ==
Date:   Wed, 5 Dec 2018 22:12:32 +0000
Message-ID: <AM0PR04MB3971DE1C9A0B3D6C938CBADD9AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com>
 <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic>
 <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
 <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNxcpHDOn1Rkxwp8VbuN5-k08JfrgwdbN95uvMWVh1Rwg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [64.157.242.222]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM0PR04MB5171;6:660AuOWNNP+6UtdPtmCvWAmYM090srUoGNmF4uUleHH7yOfOwHu8SSJn9SaLxxw8sM+LQA9+6UpVrgNlHhZ0XmVMwX6jFZk6NaMPVEddzXxYa/One6KAlrBItCySla0KkLR6T/bOQxNVgThAwvUG/BGK6THnh0hFfnXAt7Zs+wBEHRGkfcrgRHjG0kBKhBS0+M2SBLJE+/uznIG03DD0CXmgFuNMizLV3P7XfCWDblLvGqymhshui5epupMp2Q/o7TnO5O6vKCq8f1f5DK7VrBpTsWaz2RFtp+Jl6Jtkd30Lz7k1BPwnxENq5wa/xR0Y3O6aRFV63IaA2YNWIewdjoCflwLdf+9NKGcoF1Zt5irxOYnSl1HGGKS9Ocw+F7hzas/ePkLF/XM7eyVW1kSLcCaM9NNgtgqzAuqLnrS/5N/pOs5HOU2a7fSMo6uMxF3UF1v0rA3Z7HxDtmOwPrfl2w==;5:6v8xg+heI/OLLL3RCqX+Wiew46pxom7WUf7MgZj9mfis1uDOW9wdLYh4+UsHecXTnb5YWbbq7Q3vJdygAdvDe0VSgYI5Fvxtsb6hDuJt7SjIfaXBDmT51QtwRZ8vzB0LxFiKsaTT1XdYaM1L5s5KIXxkSlexDqMVmY2Ox/PwYL4=;7:w3nLgq165RIgAJ3AJ7Nzf8VpqE/h9sWJoF/4yM1W1ZmhHhI6rjUgUMCeKdbp2Ujzm83YgUqOqvszl5VqgGc+UMoPcQfN0xfAXOUbi7zSU0U+IQ9RxfKz3YTKuRrmkR/tNulXp5gMaoEqzrTKAeJ4Wg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 7c951dda-6634-4763-478d-08d65afec0d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB5171;
x-ms-traffictypediagnostic: AM0PR04MB5171:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=york.sun@nxp.com; 
x-microsoft-antispam-prvs: <AM0PR04MB51713209B2F554936C6255B69AA80@AM0PR04MB5171.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(52105112)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:AM0PR04MB5171;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB5171;
x-forefront-prvs: 08770259B4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(136003)(366004)(376002)(199004)(189003)(6116002)(53936002)(446003)(486006)(26005)(229853002)(55016002)(74316002)(7116003)(6246003)(476003)(5660300001)(6436002)(6916009)(39060400002)(9686003)(3846002)(14454004)(25786009)(2906002)(478600001)(44832011)(54906003)(316002)(93886005)(4326008)(99286004)(81166006)(86362001)(66066001)(7696005)(53546011)(6506007)(186003)(97736004)(305945005)(71200400001)(71190400001)(7736002)(8676002)(81156014)(8936002)(76176011)(105586002)(106356001)(33656002)(68736007)(3480700005)(256004)(102836004)(1411001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5171;H:AM0PR04MB3971.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: QO1GksBKgIAUuFLV/c2Vf0sYHCzgWL+o4moW+b3h9oDi4WzeMbEcoJpSUS+GII5UTsxwH673ImenLimBaV8SRYGbgASRTuuc/gFZtTZMHWdiKCJiHV/eN9x9LXxkfiFz9iE9zNsXTQSLzAP6fz93egc1iGHd5mszZuYPW0ayKts4kaJpxtxqh3xdGyVadP/Y1h3FmOkk5o4vBEp4g9UYZ3Ke7DzC18A86U03T3p/+VIeJxqlQ/UezbI9QK7ww85rUrCuwJENtbp+oNifSAKO3hijGA0wmAqp8X5D8+TH4/AGGhRYbc+KM+JeEk55Arizk9pTxbuvh0V6RGDJ5WnVciNOnE1Xyg/D9W5Oqwxq0OQ=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c951dda-6634-4763-478d-08d65afec0d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2018 22:12:32.2201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5171
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 2:00 PM, Tracy Smith wrote:=0A=
>> Single-bit errors are corrected by memory controller without involving s=
oftware.=0A=
> =0A=
> Sorry for being verbose, but I need to explain the reason for the=0A=
> questions below since I need to determine if a memory scrub is=0A=
> required on layerscape and why.  There are multiple layers to the=0A=
> problem of ECC.=0A=
> =0A=
> First layer, there is the immediate 'correction' of a flipped bit.=0A=
> =0A=
> This does not 'fix' the source of the error but corrects the flipped=0A=
> bit for use by the processor.=0A=
> =0A=
> Most bit flips will be due to either a transitory noise problem on the=0A=
> bus, which will not be associated with any given memory cell, OR it=0A=
> will be due to a cosmic-ray induced bit flip in the memory cell which=0A=
> will stay 'flipped' until the location has been written to again.=0A=
> =0A=
> The safe action is to write the ECC corrected data back to the same=0A=
> 'error' location in memory. Does the layerscape memory controller=0A=
> without software intervention do this?=0A=
> =0A=
> Question 1) Does the layerscape memory controller automatically=0A=
> perform a write of the corrected data back to the 'error' location to=0A=
> make a correction?  If not, is a patrol scrub required to do this?=0A=
> =0A=
=0A=
Tracy,=0A=
=0A=
Layerscape SoCs have the feature to fix any detected single-bit errors.=0A=
It is not part of EDAC driver. The error is still counted so EDAC driver=0A=
can "see" this error. You can refer to SoC reference manual.=0A=
=0A=
> Question 3) Because the memory controller or layerscape platform must=0A=
> assume a UE is critical, will a single UE on layersape cause a WDT to=0A=
> be triggered and a reset to occur?=0A=
=0A=
No.=0A=
=0A=
> =0A=
> Question 4) If so, will a panic ever be called if there is a hardware=0A=
> uncorrectable memory failure?=0A=
=0A=
No. It is up to upper layer of EDAC driver. Layerscape driver only=0A=
reports CEs and UEs.=0A=
=0A=
York=0A=
