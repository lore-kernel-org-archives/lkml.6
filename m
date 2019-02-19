Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3822C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41552086D
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:50:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="LJiGUqFO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729657AbfBSUuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:50:51 -0500
Received: from mail-eopbgr770103.outbound.protection.outlook.com ([40.107.77.103]:63104
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726289AbfBSUuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:50:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R7PFbzxSaVeIe5puauPm6Nt2i+uDF3D8h9sk6cuNc34=;
 b=LJiGUqFOmFoGpY5C/Mwzb0uJPl3O/3GhIrxyisRazXnin9hSYHInbH6HbI2W2dgx0upsLxg4tU9aBydrFYdKOiY+si2IQ68yESBWdoR4BLciQjc3QZLnq+xwOQZeTIjEAUvZ1ld4LKgp5+sm2kXH6JdMIFyo2s5A/k2vf9Q+Trk=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1136.namprd22.prod.outlook.com (10.174.171.38) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1622.16; Tue, 19 Feb 2019 20:50:46 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1622.018; Tue, 19 Feb 2019
 20:50:46 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Liu Xiang <liu.xiang6@zte.com.cn>
CC:     "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "liuxiang_1999@126.com" <liuxiang_1999@126.com>
Subject: Re: [PATCH] MIPS: irq: Allocate accurate order pages for irq stack
Thread-Topic: [PATCH] MIPS: irq: Allocate accurate order pages for irq stack
Thread-Index: AQHUxdfFhYURRkdiAk2PSouFe061m6XnneAA
Date:   Tue, 19 Feb 2019 20:50:46 +0000
Message-ID: <20190219205044.6fmxxlzffi5tcuwz@pburton-laptop>
References: <1550308344-3397-1-git-send-email-liu.xiang6@zte.com.cn>
In-Reply-To: <1550308344-3397-1-git-send-email-liu.xiang6@zte.com.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR02CA0025.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::38) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5a33ca9e-00ca-48fd-1d5d-08d696abeb99
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1136;
x-ms-traffictypediagnostic: MWHPR2201MB1136:
x-microsoft-exchange-diagnostics: =?us-ascii?Q?1;MWHPR2201MB1136;23:Rr5SCuZwpfoIKifGk3Z7mcnozP7Oe1Egl79XNLS?=
 =?us-ascii?Q?pCrZPx/N43OczEIG5KqIFIH00d0jW5csJ9s5Ykkv0LMXMJLK9ivY+ZANJo8T?=
 =?us-ascii?Q?K/tPYT4Og+aX/E6xGFDUTOlAmzl6SLCDgAP/A4UNy0jmu3LAr+cemgS/6E6U?=
 =?us-ascii?Q?sr2RweEj9PdXBxt/QUNTygE6EOT3Aq3bo+jl8Crocc6sHLN55/4XrR81K0RX?=
 =?us-ascii?Q?0VO2qk1YRBoWFdXjM/VTYT94iyUcmEgSd4cCK/wZ0HWmVZzWYwym6AfPPhDv?=
 =?us-ascii?Q?bK6VxFGQaFFeJkdrynk5zeNnRvLvPuhwGH3TzJi59+4wx6EeX/QqTUe1Ugks?=
 =?us-ascii?Q?4z36TNjbJIAAepNq4n2w0NCoDkI7zMGuy6+USHGAQtRQ/6AkcV0beohWx//K?=
 =?us-ascii?Q?qFLfSYyEZ12iZa8+0oLzKnL067wZ4Ve/G1xYKetlp1lcE9vDOVu9HQyPOd9s?=
 =?us-ascii?Q?X1upAG5UHPf0ZWrIJ2s6qp4KpGM4ZWd/Guf/pnen62k6yUUnUFyc+SmoeJOZ?=
 =?us-ascii?Q?daxzF17xWlRmNtKpqq7KgnG8X34B0h4j6yo35msKlxyyaNmPzPe043takaXa?=
 =?us-ascii?Q?p/0DDDElu9swcAxngBWF9+0kG4/QZzYN9ucwIORcy7XyQ51F51OhtxOD5Ogt?=
 =?us-ascii?Q?zJiSS3BVi+w1+u63WAEUo8S4x50YaJM1y1hZ3M0RfYa1NMqMAnw09AF90ZyZ?=
 =?us-ascii?Q?a8FtDa5VjZq9EQFV7zeepAMbM6KvGR7AapVWocZH/5Gt/Lfdlgh0IY+9rL/F?=
 =?us-ascii?Q?rNp9HpTVBRxp0zIyFYllHEUl9dEXGqNnC18NVfO0Vc7jQc5STenep3xDp8L4?=
 =?us-ascii?Q?FKXTBw8Nn79OedngSA784qMAztG7F/JSU36SPrx8sEYB3QhFhXLsPqBnaS92?=
 =?us-ascii?Q?tDQ3o37tmlktFV5RehYCwppgq68kdtLS2IJbVGj2/36CpfxsoL4g6W6pGTvt?=
 =?us-ascii?Q?Qy3RXk+yFTBR7Y56IisO6amvWGO407du2aP6KDURW0rpU1MSDpm2rk0Xo073?=
 =?us-ascii?Q?sM3bH7KwmC75tKDPmCcIxmNslXO4jhZHWVyH8VjCei3/MfhoPSARputl8IFE?=
 =?us-ascii?Q?q6N9kfayGe9red7UU9bn4gwuSD4VyUFQNTn1HLXvXJ038hLFYSmSPQSPllzQ?=
 =?us-ascii?Q?MaPeRHG0EilGVrepDXD7YEU3JT3Yzjr/Dc10wI/ROBbTmR1Gio/dO4dhMyfp?=
 =?us-ascii?Q?eLn++9x2V3GaSg2FQTWOPVxfClsbgASwwQ2q+pTFidU44hwhDtl8WgKO/4Lw?=
 =?us-ascii?Q?HoNAB/Q5QsMIk7Tql/mLMXfMSx/jO3widPL/gghNRdi8LraBSQOVqyzCA8el?=
 =?us-ascii?Q?y6VD2LvTJdPBYsKXZi76L+AU8iMpZZx5/M+yj6IlsITBL?=
x-microsoft-antispam-prvs: <MWHPR2201MB1136BD0DDD19FC79B58C8276C17C0@MWHPR2201MB1136.namprd22.prod.outlook.com>
x-forefront-prvs: 09538D3531
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(346002)(396003)(136003)(366004)(39840400004)(189003)(199004)(4744005)(4326008)(25786009)(99286004)(66066001)(6916009)(6246003)(5660300002)(54906003)(386003)(33896004)(486006)(42882007)(44832011)(6506007)(26005)(102836004)(476003)(76176011)(14444005)(256004)(186003)(11346002)(446003)(1076003)(33716001)(52116002)(305945005)(7736002)(229853002)(6436002)(2906002)(6486002)(97736004)(53936002)(68736007)(478600001)(58126008)(14454004)(8676002)(6116002)(316002)(71190400001)(8936002)(6512007)(9686003)(3846002)(71200400001)(81156014)(106356001)(105586002)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1136;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: +g8M+UhWXVGbMQ+eZ/kHVwJiAJpGcS+EewId9GYMa0lgGgeVH+KT4SfneKST/6LksrFu4lce60oAiqCV4uoJZKhPJpRzfhlz3yX2CopsOFlL4xzodJJot/m9zMdo9ecMhp9W4CyBDXqwZ+ljAIADoH8Xxy0Um26IpvsZpfdr276cfBo0BbZL7k+mTOgdrBmwcky4RXOABOErI0iuGvwczNdCkRaHHkMTwDG3dAeusVbmZ/Te6dVqkc5tOzF7R4JFrqUfbAGneqy+7rzv1VR+aVGvNQ1YjvBnFF3djgFdk43UFUtHt91lQyyroyvlupruiwZN6HMXr6An3NdWbdoBpHd+gO9ZMAjsnsQOJQxhh3CCeouGX/aAHRrdNn9QtUSqcOe5TkRdzT5u5oVHXwhcfLkqjpXLsUz5vLZnZCE+D88=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <713873DACED55E4D9CCDE1A0A5C0A9E3@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a33ca9e-00ca-48fd-1d5d-08d696abeb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2019 20:50:45.4617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1136
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liu,

On Sat, Feb 16, 2019 at 05:12:24PM +0800, Liu Xiang wrote:
> The irq_pages is the number of pages for irq stack, but not the
> order which is needed by __get_free_pages().
> We can use get_order() to calculate the accurate order.
>=20
> Signed-off-by: Liu Xiang <liu.xiang6@zte.com.cn>
> ---
>  arch/mips/kernel/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Somehow this didn't make it to patchwork.kernel.org, or the archives at
lore.kernel.org, so my usual "I've applied this" script doesn't know how
to respond to you...

Anyway: I've applied this to mips-next for v5.1, and marked it for
backport to stable branches as far as v4.11.

Thanks,
    Paul
