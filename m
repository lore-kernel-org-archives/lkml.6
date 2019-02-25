Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C347C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220C32084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 19:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="bC1VhJuq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbfBYTIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:08:41 -0500
Received: from mail-eopbgr720112.outbound.protection.outlook.com ([40.107.72.112]:2385
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726481AbfBYTIh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 14:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZGRnMkjR9jQ4KmKRKDOebm3PaHKjfv3kVcfYdfZKHo=;
 b=bC1VhJuq3uAz2CkYXOEoVBd4NZpXPZUp5erHIYUyHSQ3VpmIFgVst87zI+3CTa5ehPTTlBXYOoe+qDQYCbWBkefkdHxhxiFBCtw4o4+nyI8JaBwGKKEBQMuLAOW25fXIqwXaZw6gaDNbopay6q+huE6zoApkw6XpZ/8KrhlEm+4=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1343.namprd22.prod.outlook.com (10.174.162.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1643.16; Mon, 25 Feb 2019 19:08:35 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::7d5e:f3b0:4a5:4636%9]) with mapi id 15.20.1643.019; Mon, 25 Feb 2019
 19:08:34 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Thomas Bogendoerfer <tbogendoerfer@suse.de>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH v2 03/10] MIPS: SGI-IP27: use pr_info/pr_emerg and pr_cont
 to  fix output
Thread-Topic: [PATCH v2 03/10] MIPS: SGI-IP27: use pr_info/pr_emerg and
 pr_cont to  fix output
Thread-Index: AQHUzT2BUh4QLsWsskKqXxr0P+G1gQ==
Date:   Mon, 25 Feb 2019 19:08:34 +0000
Message-ID: <MWHPR2201MB1277BEC9144FE73AEEB3E3A4C17A0@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20190219155728.19163-4-tbogendoerfer@suse.de>
In-Reply-To: <20190219155728.19163-4-tbogendoerfer@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c50e501d-458d-42e7-400d-08d69b54a3b9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1343;
x-ms-traffictypediagnostic: MWHPR2201MB1343:
x-microsoft-exchange-diagnostics: =?iso-8859-1?Q?1;MWHPR2201MB1343;23:zjIbnT9QoEazW40V6hiGrUH1oZZF2uBwAwFLs?=
 =?iso-8859-1?Q?NYkvkIqGBRXZFUZS8tl44nkMmOrJ0yxFZRrY04c8aA/dS5YsyV1AyKT3hP?=
 =?iso-8859-1?Q?Yvk3hkh6QnAuuq+aHPbmT/2qy1ROd3yruCE0hTBYv0bMDU9zzNdHaLeMA8?=
 =?iso-8859-1?Q?rN4dfOq1muTuFAI5l85keWLfdK/GCjxrACLpfV8sO/PNrmmUF5tFbZWWd+?=
 =?iso-8859-1?Q?buWka4lfNo+ciIQeC0LU3UXQp1sTczHrSZoPCsbdKYo8InDWq9kHkPSGzl?=
 =?iso-8859-1?Q?5brGWVJYEMruB8f0MdBKJ9x/BTC2wJuUjwdGFuJ1y31f+rZF0n5WwcDR7y?=
 =?iso-8859-1?Q?5WTxLnMPF/6xr58ReNiq0oJ4+KMSCjNQPNBAKA+A/xtRHAPxBNMrXZCjE7?=
 =?iso-8859-1?Q?7x51/DG+doDdLCLfmZaITOoiGDWEeOz93ny+b1sEgR+SZqcpviKWMoEH/E?=
 =?iso-8859-1?Q?RwirHTBGYRr2uVpgSwR1B42LWvh5Dv3yt6Hr3UbhIDH15EJzJbm/Zc6FCL?=
 =?iso-8859-1?Q?BCDWRQP4gjZfS49qpl7YEoVcov2O8z2eHLS5oKUHmdS+2kETvnAUvZzV8R?=
 =?iso-8859-1?Q?nDRT5o18dtESije1PTidLpJ5ZxAqOnKlMTQG4ZjbzB8mwgCs+phGagbCMu?=
 =?iso-8859-1?Q?r1VxZuLBliDfcnOKwzTd3AtZwtJ+A7sTasN6RToFdAgBzLzYJi6ISMQk2o?=
 =?iso-8859-1?Q?exN+1pqlITjSONYkz7Nf9qQY6xYSz3UsdGeK3458/zjwt49dbzUiCZX3qD?=
 =?iso-8859-1?Q?tDoYxD/27Ugzgl2Lgnd1EXSrI6Z0Y7xh6Iv3lccDnXRq7mTlfl+8virV4l?=
 =?iso-8859-1?Q?VHIgqMCSDIItfilZSuH7yzojxCeQlCZ4JrPMudq0aM5LoNcZ6qLmDurFBk?=
 =?iso-8859-1?Q?ga9gdQaotyniLANVxkUf/54HCG8n8HEcW5o47S2HVRcZH6/wcxVooK4mdY?=
 =?iso-8859-1?Q?4xcYBshXo8ZKc/66Bk1OozcAzAotykiuUXLpO8+PPTx4CQSTSiAmYEzaGx?=
 =?iso-8859-1?Q?P7X/bE7cy9ykfEjLfiMq6Wrv98+8+Xdj5Wj5Ceci5+6GhWQfsoGFBVHMSt?=
 =?iso-8859-1?Q?d79FztiAaAvy70TbG3+W+Hwhktyit5xI5c5lp2Z5rsCkWhrM2Qr/cNqLqV?=
 =?iso-8859-1?Q?dnmoFRXXPRoGeEKvNVdAyrPg1BJidMr8QSjBJ/BvIxO5tMl5IBBoFE6D1T?=
 =?iso-8859-1?Q?YvSrWm34LAD4IBldekDild8EneDzuZnjipItJXCOT9C67ftuTNMJisaioA?=
 =?iso-8859-1?Q?rQCGuZJ/QFjqd6S2WsgNUP/2ygZsRbXnhsBSdgwJir3of3OzW0HN35SfG3?=
 =?iso-8859-1?Q?HzPhT4Ep5Gy/2C7mvTYZb8amWFbJ1OvwSUWwauaXQIuaWuQ=3D=3D?=
x-microsoft-antispam-prvs: <MWHPR2201MB1343B06B4B6183ABF869EFB8C17A0@MWHPR2201MB1343.namprd22.prod.outlook.com>
x-forefront-prvs: 095972DF2F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(136003)(346002)(39840400004)(199004)(189003)(316002)(33656002)(26005)(6916009)(71190400001)(71200400001)(52116002)(256004)(42882007)(54906003)(55016002)(2906002)(76176011)(99286004)(7696005)(9686003)(6116002)(3846002)(186003)(7736002)(305945005)(102836004)(44832011)(386003)(6506007)(74316002)(486006)(11346002)(476003)(53936002)(446003)(8676002)(106356001)(8936002)(81156014)(81166006)(6246003)(105586002)(66066001)(4744005)(68736007)(25786009)(4326008)(97736004)(229853002)(14454004)(5660300002)(478600001)(52536013)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1343;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 2IOmxA9QcEMg6zCtsm/5vx/I68uuMOjG/TrsTayrkiIFfUNqL21uNV8v/1dKCXV0Fab39FJP0z3ZUHaLg73Z4I/0IlvTPAuHvUXy+XNQPZOKNdz4O/cGIDbppRKfoiUu4SdkmmVlEezMy0h3g4Rv9cWC89gJiioZe3TMDCLgAJ0wm6HJVIVWAVhZE4QGL31qMPl3oja1o+pKIr8PAAAL/B6kGLjfXbJWSZeUtGq9lIXbf6jYnWKNGz1xSA67Xga2JglqajZS4JhAIh2mKCkWcUrvHgsB/Mo9LK2f3urIe87MZtwEYTOlBLF5zhI6AGjoi5SLnW1tpHqsISsJqS/fgEtb1zaRy4acYsYQg6IUk1p1rF3hOgpcQuk4pxCVDCbtCJOHVcOdQuRfjcdsV9u5oz21IjzjEsCpA74f8g4iycE=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50e501d-458d-42e7-400d-08d69b54a3b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2019 19:08:34.4737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1343
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Thomas Bogendoerfer wrote:
> Topology and NMI output needs pr_cont() to look the way it was in the
> old days of printk.
>=20
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>

Applied to mips-next.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
