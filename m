Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F48C00319
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2989220838
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 23:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="PPORi8Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfBUXHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 18:07:17 -0500
Received: from mail-eopbgr700111.outbound.protection.outlook.com ([40.107.70.111]:32096
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726035AbfBUXHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 18:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WMCol56R9CxEcQqJ7/5YUEktI2gNCPj9cAQi6OjfidQ=;
 b=PPORi8HrnluSTbfDboKqCqqMJb0TGBjc2nTEpRUVSMUX74F4MSAlTsHJtJ/ymxWEAIgDwyy8Zkyz9CMfcfW57rLLrNesUjNuoFpjzGAxRannV1aeCNSBdDDvEBuKEPL4JsKZFx6VwTtDO7o9ZW/xoZsZROPBHRmEvox1xmmWYwo=
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com (10.171.214.23) by
 CY4PR2201MB1109.namprd22.prod.outlook.com (10.171.223.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Thu, 21 Feb 2019 23:07:13 +0000
Received: from CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::1d1:735e:efff:54d6]) by CY4PR2201MB1272.namprd22.prod.outlook.com
 ([fe80::1d1:735e:efff:54d6%7]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 23:07:13 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Jonas Gorski <jonas.gorski@gmail.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH] MIPS: BCM63XX: provide DMA masks for ethernet devices
Thread-Topic: [PATCH] MIPS: BCM63XX: provide DMA masks for ethernet devices
Thread-Index: AQHUycu+tPViWzZUAk+WDQpKzQJPK6Xq4MKA
Date:   Thu, 21 Feb 2019 23:07:13 +0000
Message-ID: <CY4PR2201MB12728E7ACCC21D88FF921C7EC17E0@CY4PR2201MB1272.namprd22.prod.outlook.com>
References: <20190221095642.26962-1-jonas.gorski@gmail.com>
In-Reply-To: <20190221095642.26962-1-jonas.gorski@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To CY4PR2201MB1272.namprd22.prod.outlook.com
 (2603:10b6:910:6e::23)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55de54c4-2fc9-4227-e320-08d69851507b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:CY4PR2201MB1109;
x-ms-traffictypediagnostic: CY4PR2201MB1109:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;CY4PR2201MB1109;23:EcKsS2ExxbchCdXWk1en0zE2j9FYYTMnrjMFE?=
 =?iso-8859-1?Q?GgXXAulLBFFwiPQM9LfScfHUlvbM8q7CmUp34DeSsWDYAt4YcRHmDaH4M4?=
 =?iso-8859-1?Q?F7IqUyNRNapfCPiTYHf9w4+PJoS3KWCKj/vjdbvWxNqQtA4O/VVpXcR5pN?=
 =?iso-8859-1?Q?wnWKotAcHYAzRwH/8mx0ocumTjGeIS1ldWqa8rRZIk3maEU9DQ8hLOuv6X?=
 =?iso-8859-1?Q?9emxqWXSW2PLgFMhV3/J5BreS8Sdj0s6TUVtihxYX/Zr0gHXtgomRFkyAc?=
 =?iso-8859-1?Q?qVHivWoR7ogqP4SZbsOfeOCzIWTAMeVc/JEzCwq10p285js8Psbt16OP+r?=
 =?iso-8859-1?Q?/CxCMbiTsEeIBLIVhSVmLrW5yG/1Oe7VlDtgfOB394JT+YPwUDhYzF23LS?=
 =?iso-8859-1?Q?YQeh8mHSoYopfba8TTpOBUz/G7mahNKCkCFrv8zlVuK4KYtBBUzbWuTsAn?=
 =?iso-8859-1?Q?odqeg1WZJv5ZWDGh4oPfeu/24LRVWYghho9YjFbe/xUWYYxz1d6bozYOAr?=
 =?iso-8859-1?Q?699coke/9V4mUWHw1cuUBdt9WIWsOHhx2J5pfnkrQi6zaCskYW1bAcC7ij?=
 =?iso-8859-1?Q?WyU+viU+Rn5PFwamnl2gLc4MFp1WfmLitjRaLs9ufMcaaDfM67TaLgdoJj?=
 =?iso-8859-1?Q?pZ/Pt4q/GYon/cTwTaVwObkjEZ169GR2IyngnS4LID0y4KbTqpOJxzP2ib?=
 =?iso-8859-1?Q?8ZQEXG6t5B+t1jcL5r916v6clkWPthO0TIpFQe4OTmjyLL/wQLNCXPTN+l?=
 =?iso-8859-1?Q?WUQyuFp4I0pLEJKycgzj4gqIno9KPvIpLEw4KTVmot7DB845wR9Rl4bFy0?=
 =?iso-8859-1?Q?rrQxUsWg6Zz49n1DZDlNLkjbEdgHyfs1vDck5YSUcG2s8VNLaKwjTcjMVm?=
 =?iso-8859-1?Q?HS82JYlHYYW7t8Hma0EEF+L4LkcwIiJ9mvrg8CAo6BlIYfOMrwQcZ4I58k?=
 =?iso-8859-1?Q?hsVx/+t1S/xmwceVV/OMAe/5aboJbRlOPenKFRnH4tVJBLQKoqBTwwQtJQ?=
 =?iso-8859-1?Q?nQiptFcR8akz4V43z2/P7OmJukxYyxa/PSyCVwFAwnYzHhpKjzOszHo+HW?=
 =?iso-8859-1?Q?sxNkewrD6wBQWfyI/yefFycG1dIpetXI0HTFdmzSpJItWeXmXz00U8V6RV?=
 =?iso-8859-1?Q?rShsEw38CUWXHRiJux3Pq8ytEbZe3D4U9ibNwmFRDyq8R9z6c6MB4UmK0Y?=
 =?iso-8859-1?Q?isMeep9OTHumF3T2Pr98sStuF4RFSIYdX2YNbHsy/KbF4d01cfFST0MDXT?=
 =?iso-8859-1?Q?TagNDPJwn7bVA7EvQW/tmyCa5wAH3t95XbDZf7kM8HpBTWv4hnjQNkGPV3?=
 =?iso-8859-1?Q?ryySqDAUu+0nQLvkio9Vx27bAbxHhecOXLmZIUydlbKhMpA=3D=3D?=
x-microsoft-antispam-prvs: <CY4PR2201MB1109052A2D114A487A8658E6C17E0@CY4PR2201MB1109.namprd22.prod.outlook.com>
x-forefront-prvs: 09555FB1AD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39840400004)(136003)(346002)(376002)(366004)(199004)(189003)(305945005)(6916009)(99286004)(81166006)(8676002)(81156014)(478600001)(186003)(7736002)(9686003)(11346002)(71200400001)(71190400001)(6246003)(53936002)(2906002)(5660300002)(54906003)(6506007)(74316002)(8936002)(55016002)(102836004)(33656002)(4326008)(45080400002)(26005)(316002)(386003)(14454004)(44832011)(7696005)(476003)(256004)(42882007)(6436002)(486006)(25786009)(52116002)(68736007)(105586002)(66066001)(97736004)(229853002)(76176011)(3846002)(6116002)(106356001)(446003)(14444005);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR2201MB1109;H:CY4PR2201MB1272.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bV3wlCdTVtSDIeS6v68e8J+1+YSqQfZjcDRai7ob8laiquOFnmpnpWrgI8EdYZY7emGv8BVImmgzT9shec0Sva6ClcmDQeH7Y1lTzWGMjnHKIrVHp/HGOXm/YBThrGdq+dEks1jujTv9x34LRCoBzlFywwQj4cDVTbsVWhjhEz2hfIVQH/2N6QHhq1paZ9tnFXexGCIEUK+Jkpt3a7irYJ0PMU5/i8ru0hzjmqBt6Vh3uhHqaaykjwBb5BX7XoFLDFmAJZeg8n8Z7b74uoPvBV20gJVpeTXGo2qhRZ+jVsTWkT3NSMnimfL6HSPlbOUInOEkNcU2IpkxA+hWvZHtnyhRyEls/QHTkd7N15Y9sA8BoGPD81INsuAr1kpepGcPsEXxFGtU4R7mCw90/6mREMV9+JYV3RXinRRJObGM41k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55de54c4-2fc9-4227-e320-08d69851507b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 23:07:12.8882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR2201MB1109
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Jonas Gorski wrote:
> The switch to the generic dma ops made dma masks mandatory, breaking
> devices having them not set. In case of bcm63xx, it broke ethernet with
> the following warning when trying to up the device:
>=20
> [    2.633123] ------------[ cut here ]------------
> [    2.637949] WARNING: CPU: 0 PID: 325 at ./include/linux/dma-mapping.h:=
516 bcm_enetsw_open+0x160/0xbbc
> [    2.647423] Modules linked in: gpio_button_hotplug
> [    2.652361] CPU: 0 PID: 325 Comm: ip Not tainted 4.19.16 #0
> [    2.658080] Stack : 80520000 804cd3ec 00000000 00000000 804ccc00 87085=
bdc 87d3f9d4 804f9a17
> [    2.666707]         8049cf18 00000145 80a942a0 00000204 80ac0000 10008=
400 87085b90 eb3d5ab7
> [    2.675325]         00000000 00000000 80ac0000 000022b0 00000000 00000=
000 00000007 00000000
> [    2.683954]         0000007a 80500000 0013b381 00000000 80000000 00000=
000 804a1664 80289878
> [    2.692572]         00000009 00000204 80ac0000 00000200 00000002 00000=
000 00000000 80a90000
> [    2.701191]         ...
> [    2.703701] Call Trace:
> [    2.706244] [<8001f3c8>] show_stack+0x58/0x100
> [    2.710840] [<800336e4>] __warn+0xe4/0x118
> [    2.715049] [<800337d4>] warn_slowpath_null+0x48/0x64
> [    2.720237] [<80289878>] bcm_enetsw_open+0x160/0xbbc
> [    2.725347] [<802d1d4c>] __dev_open+0xf8/0x16c
> [    2.729913] [<802d20cc>] __dev_change_flags+0x100/0x1c4
> [    2.735290] [<802d21b8>] dev_change_flags+0x28/0x70
> [    2.740326] [<803539e0>] devinet_ioctl+0x310/0x7b0
> [    2.745250] [<80355fd8>] inet_ioctl+0x1f8/0x224
> [    2.749939] [<802af290>] sock_ioctl+0x30c/0x488
> [    2.754632] [<80112b34>] do_vfs_ioctl+0x740/0x7dc
> [    2.759459] [<80112c20>] ksys_ioctl+0x50/0x94
> [    2.763955] [<800240b8>] syscall_common+0x34/0x58
> [    2.768782] ---[ end trace fb1a6b14d74e28b6 ]---
> [    2.773544] bcm63xx_enetsw bcm63xx_enetsw.0: cannot allocate rx ring 5=
12
>=20
> Fix this by adding appropriate DMA masks for the platform devices.
>=20
> Fixes: f8c55dc6e828 ("MIPS: use generic dma noncoherent ops for simple no=
ncoherent platforms")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
