Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BB00C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC1A0208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 21:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="H9PIg75+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1A0208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbeJPFp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 01:45:59 -0400
Received: from mail-by2nam01on0124.outbound.protection.outlook.com ([104.47.34.124]:57769
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726185AbeJPFp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 01:45:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qckKp782HMOPM8YJlG7d/N5HS/S96+aL4dHv7Nb97V4=;
 b=H9PIg75+jdazJKArmu58+UZ4ZTDUu/GSvlJgSUK4ywAMBsZrcyL7pwpTHfaHo9oZZ53DUZTMK+uVP/iKnwJn6u9DvKDcI2biukFEh4t9T6vTMzTMv9bp0afRWtgLQe8UiVi1QLTBavqUGdkEaojg8mHwc97sI7RNzqnqHoyuoqQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1200.namprd22.prod.outlook.com (10.174.169.163) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.23; Mon, 15 Oct 2018 21:58:47 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::781f:63:481a:efdf%10]) with mapi id 15.20.1228.027; Mon, 15 Oct 2018
 21:58:47 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Songjun Wu <songjun.wu@linux.intel.com>
CC:     "yixin.zhu@linux.intel.com" <yixin.zhu@linux.intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "hauke.mehrtens@intel.com" <hauke.mehrtens@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 00/14] serial: langtiq: Add CCF suppport
Thread-Topic: [PATCH 00/14] serial: langtiq: Add CCF suppport
Thread-Index: AQHUU/FUikuoZKBxz0C1X7MQM/f8SaUg/JmA
Date:   Mon, 15 Oct 2018 21:58:47 +0000
Message-ID: <20181015215845.5t7bkyks6hsxqwsb@pburton-laptop>
References: <20180924102803.30263-1-songjun.wu@linux.intel.com>
In-Reply-To: <20180924102803.30263-1-songjun.wu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR12CA0069.namprd12.prod.outlook.com
 (2603:10b6:300:103::31) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1200;6:vIq2qEAJiTBR9/ukXBqM34MPfHGbubeqYvx06e8PZWwkxwgaq3UmNoTX+v5qlrBvyMBov/iUpyPl/mQlCcYBI1bQoCrs8JzKB90Ir9NUXf68PI4kOWgv2RmjLtLmQTP8Jgis+WYxHZsQqtfhFe/HC1VdhLWe4a4yiGA31gIQQZiEb+T/2bojq+qEmttd73cWo5I49DNmVMVMJ+ZmFJ5m6i89sV8miL3XNRPJ7Qib7yQraQ5bn49okJZO7k2h9sHNm+fMxaD8aYwM4uqm0Z0E9aAak2fALgnmRjHMOmkt3q5nUXp8rSIxXHkV5vh7y9EkbhiL84RqgNCacXVdq8JgqgsaJlKNVxdyjZBLfirGW+sXx+gkpOGue6l/OczyPRW0W/MknbeHyEDZfJOtKdRKkICajhqdV5soO+/EWxvyUOu6fzjXFT1fPwt/34OPvAcNsP4I8C5JAlnNzB0nDdGJWw==;5:JsPuKZAblqcgUv0OCQBwtMKQOVKXfxQPbcROusej7SfUJo+U0fhDIyAM1q/d3buCz0Nt1SG9eqd2kVHHCUlGcKrJwKYoT0yMjGcK0zv8M3v49CiCpbefihKymHyyU7wtLbosszVihBCIFN1YZXXmQjA+U1IqtEsBIf7+wsRapkg=;7:7FJNd/PHZBpJ2PgUEo4ovOGIj12GxIN4q0rT+6WlFE50537i+5DVkuc5KBuXdzzAJWI95LLGKP9fPXYFP8fFwY9wj9sUD+8Qya0ibUGbWgXHHGSVwz3OzxgJdd5y/HqXK2AQbhaeu7N5lxHvvlUkr5SOFRQWGAYFuCD64l1kr0kIs7yzIAIRbzOXa7dGZtjDLY22bRZovcE4RMWz7RUURT+OHLTJfSkb2eErYSKgxsMNrJ2u2Rn2R7wOJAULa/Sy
x-ms-office365-filtering-correlation-id: ea42ce8e-d0a3-4501-89d6-08d632e961ab
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1200;
x-ms-traffictypediagnostic: MWHPR2201MB1200:
x-microsoft-antispam-prvs: <MWHPR2201MB1200BE554AD7E0EDC0FD95BFC1FD0@MWHPR2201MB1200.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(10201501046)(3231355)(944501410)(52105095)(3002001)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(201708071742011)(7699051);SRVR:MWHPR2201MB1200;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1200;
x-forefront-prvs: 0826B2F01B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(39840400004)(136003)(376002)(366004)(396003)(189003)(199004)(102836004)(1076002)(42882007)(3846002)(6116002)(7416002)(2900100001)(52116002)(6512007)(66066001)(33896004)(9686003)(316002)(76176011)(53936002)(186003)(305945005)(99286004)(2906002)(68736007)(508600001)(54906003)(58126008)(7736002)(26005)(25786009)(4326008)(6246003)(5250100002)(229853002)(6916009)(33716001)(106356001)(105586002)(6486002)(486006)(5660300001)(6436002)(81156014)(81166006)(44832011)(386003)(446003)(6506007)(8676002)(476003)(11346002)(14454004)(14444005)(256004)(97736004)(71190400001)(71200400001)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1200;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: s0lpnQu24D2AZkWXOMMwHuEo5X0Q7lcvvcILHbMfVigImorWPClfGsS99LzvBL0vr7oKBCaL1Cp1H3XKJL5aYaE42rqNIUiKlaeEs3jeOqkUJTZAoBkb2m7pYllOoCyrC/imFhMsBQK42Q2kGbj3D6RP3vNmbCdDyThRnHMKDSOF0fGgPpzBa6QdRZ7Dpzfuk1utBy+/Kmv3US6AA70L4vPjMuJ84UA4FusFHHiOooghf+pwevBuL2fGQbSv2BrNJQxirWPQy1p/1RVzTsrCSIBDYe4bHxV6HGFq/VAqu6joJGXT4KL/aYtHC9hF/I5+ar+rZc5uvmv5aMcstXOnz8jLb6Iy0KMfVbf7s3q/UYE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <65EBC5B044F99A4EA8A4F4D65B6EADD1@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea42ce8e-d0a3-4501-89d6-08d632e961ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2018 21:58:47.5810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1200
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Songjun,

On Mon, Sep 24, 2018 at 06:27:49PM +0800, Songjun Wu wrote:
> This patch series is for adding common clock framework support
> for langtiq serial driver, mainly includes:

s/langtiq/lantiq/ ...

> 1) Add common clock framework support.
> 2) Modify the dts file according to the DT conventions.
> 3) Replace the platform dependent functions with kernel functions
>=20
> Songjun Wu (14):
>   MIPS: dts: Change upper case to lower case
>   MIPS: dts: Add aliases node for lantiq danube serial
>   serial: lantiq: Get serial id from dts
>   serial: lantiq: Change ltq_w32_mask to asc_update_bits
>   MIPS: lantiq: Unselect SWAP_IO_SPACE when LANTIQ is selected
>   serial: lantiq: Use readl/writel instead of ltq_r32/ltq_w32
>   serial: lantiq: Rename fpiclk to freqclk
>   serial: lantiq: Replace clk_enable/clk_disable with clk generic API
>   serial: lantiq: Add CCF support
>   serial: lantiq: Reorder the head files
>   include: Add lantiq.h in include/linux/
>   serial: lantiq: Replace lantiq_soc.h with lantiq.h
>   serial: lantiq: Change init_lqasc to static declaration
>   dt-bindings: serial: lantiq: Add optional properties for CCF

It appears that you only copied me on patches 1, 2 & 5. I've applied
patch 1 to mips-next for 4.20, but I have no clue whether your other
patches were deemed acceptable by serial or DT maintainers & I have no
context for the changes being made, so I can neither apply nor ack
patches 2 & 5. Please copy me on the whole series next time.

Thanks,
    Paul
