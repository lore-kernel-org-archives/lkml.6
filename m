Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A5CEC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 531B920870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 19:45:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="CajUe4DT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfAVTpe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 14:45:34 -0500
Received: from mail-eopbgr750130.outbound.protection.outlook.com ([40.107.75.130]:3072
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725919AbfAVTpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 14:45:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL+tBHVLXnsZYi/CJNrsRYv69C3jE277wvtKCY+gbW4=;
 b=CajUe4DT0xylNOw9Uju5Cj0Fiz3H7GeGosdt7mgekMO5JFw5P/eN4KVKOwrYqA2zVSoXALA1xNPsdHVt4UK4LAnVXLgEccYLaW5mPqnTPsGYrEk6qwOZlRpdeKTlLEMxh3NC2OftsqA3udfNVMlgN7NAzELFkVfHtcKBjKT8rrQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1501.namprd22.prod.outlook.com (10.174.170.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1558.16; Tue, 22 Jan 2019 19:45:29 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::595e:ffcc:435b:9110%4]) with mapi id 15.20.1537.031; Tue, 22 Jan 2019
 19:45:29 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fengguang Wu <fengguang.wu@intel.com>,
        "kbuild@lists.01.org" <kbuild@lists.01.org>
CC:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        John Crispin <john@phrozen.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Subject: Re: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Thread-Topic: [PATCH 1/5] mips: cavium: no need to check return value of
 debugfs_create functions
Thread-Index: AQHUsmLuEra2RuUO8ECdbuG3dcjl1aW7oXsAgAAJf4CAAAHGAIAABIcA
Date:   Tue, 22 Jan 2019 19:45:29 +0000
Message-ID: <20190122194528.ay2ev2azqfvnvbwi@pburton-laptop>
References: <20190122145742.11292-1-gregkh@linuxfoundation.org>
 <20190122145742.11292-2-gregkh@linuxfoundation.org>
 <20190122184855.GB2792@darkstar.musicnaut.iki.fi>
 <20190122192255.tjkmwgx25wvcp6y6@pburton-laptop>
 <20190122192916.GB5676@kroah.com>
In-Reply-To: <20190122192916.GB5676@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::41) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [67.207.99.198]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1501;6:To3L87Z5K26My/3jxB7W4J4y91f4Ep6zcAptcpp4FZJz0Z16xZCuUd1QRQQkRa7sqsb0KaLqcAtHXLJfrelWnNvFHDnmVmjUDXj9BPdIyDfGrd1p5V4kyzFox/R4+0TYQo0CTsUuAkAC128slYuo6kI+A/xmjUXcmFJZKi1CfBKkJWefj5jxUGpwU9k6uuS16wMnLoRdQg8PrzmxkyNEB/aqQrmjoYg76VvGD/rLlNcxid3T0jF9jk0k7xOGDPEaOo2hB/abc+wxTtj6TY29TWpdyIROXpSi0oTQdL4C/IYSH6a8VYvklBSq0xsLT49D3NUlIHBCWfYlJvGtLHlAIipryy2njC8fgn70ZxuR5DLQO2RpilCTU6jxeqk1OOf0WcZwxEvJAnPNUj7Dx9KosBOWnxZEAMsk8W+zYPi/ZCBOcFrDN+uGSL/BS/mwREWOmGfLsjLWUYXr6/YIOHBR/w==;5:fsKnVOUo04ZYGR5T8xyQr3nUl9cIVLYAosphmpq3L5iXWRKuHnRPFfce1eYVpygGQXxGQVnJrYfQTiOEOdjYAxqIQ8WBsUH4fs12i6oBNdmnpKeZIq876z01ptAItaKZxj9qCWFixQ/JfxBSWxCRyoSYUcebIQOxX7jiCRmfT8FLLRJTdFtkSoaW8Fp8SozSAgM3LWTuVTJzTsApj6MZvg==;7:V5uwjxcrYs1bS1hLMcXXDpZFFjofuQZUUR6XA4E3KknTAvxD2RaOxILGOL3l48LsjZjIHPLPjGQzKvuDFm3C1W1907I7+YP9IlOBZcU4aPykapMHa+aYnqsjjTPiPN6eTezbFKUIbPHjsyDgL0naQg==
x-ms-office365-filtering-correlation-id: d6c190b5-b012-467e-d020-08d680a229af
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600109)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1501;
x-ms-traffictypediagnostic: MWHPR2201MB1501:
x-microsoft-antispam-prvs: <MWHPR2201MB1501E31B01BCA0C9D92EF8A4C1980@MWHPR2201MB1501.namprd22.prod.outlook.com>
x-forefront-prvs: 0925081676
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(366004)(396003)(39840400004)(346002)(136003)(199004)(189003)(1076003)(486006)(66066001)(25786009)(68736007)(386003)(6506007)(6436002)(4326008)(476003)(305945005)(11346002)(53936002)(7736002)(6246003)(3846002)(106356001)(81166006)(446003)(81156014)(8676002)(8936002)(44832011)(6512007)(105586002)(99286004)(9686003)(229853002)(33716001)(6116002)(14454004)(478600001)(42882007)(186003)(26005)(316002)(2906002)(2501003)(102836004)(6486002)(97736004)(52116002)(110136005)(54906003)(256004)(71190400001)(58126008)(76176011)(71200400001)(33896004)(93886005);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1501;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ekEu7O+pdJiYFxrCy2fXKFOToDH3hwLpdxeCInkAs2HlfPno3D2oZB5s4xY8rC91Qy/miT9zQLAdlgsZqwSGD6OqKBwRgo60MHakq2scMyU2r4qK22nrdPUfHRC4BuPDcSLCADSMXXOpEZ1wtYLoFnFCdpNAWQV/Jvb+JzExIQADC6y3xRoPp+UDqTCkDF/AXXc4cQ1i7bBfbV6L9cBdxqb/mjwi/wBAWDwCzCnu4nKMFSPn2lUIeMOfdrRo+NawgaAX/+Z0nGw8jflwhbm+IyGHXb/5N6LBcfu//evWgurB6KN92AWDc/YB7ggf8wGrYp3mFi34+zkVRDNHdJNapEuWZewAtuPVLj62uLf6PeyGxCaYQcjRuKqmejahw3Xi/HDe9QgBOzqDJzsPhK1AKaDKpg1zxlvt3SEka5FcUj0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0E7BABE2647BA469574FE717AFDC3C9@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6c190b5-b012-467e-d020-08d680a229af
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2019 19:45:29.1398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1501
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Tue, Jan 22, 2019 at 08:29:16PM +0100, Greg Kroah-Hartman wrote:
> On Tue, Jan 22, 2019 at 07:22:57PM +0000, Paul Burton wrote:
> > On Tue, Jan 22, 2019 at 08:48:56PM +0200, Aaro Koskinen wrote:
> > > On Tue, Jan 22, 2019 at 03:57:38PM +0100, Greg Kroah-Hartman wrote:
> > > > -static int init_debufs(void)
> > > > +static void init_debugfs(void)
> > > >  {
> > > > -	struct dentry *show_dentry;
> > > >  	dir =3D debugfs_create_dir("oct_ilm", 0);
> > > > -	if (!dir) {
> > > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm\n");
> > > > -		return -1;
> > > > -	}
> > > > -
> > > > -	show_dentry =3D debugfs_create_file("statistics", 0222, dir, NULL=
,
> > > > -					  &oct_ilm_ops);
> > > > -	if (!show_dentry) {
> > > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/statisti=
cs\n");
> > > > -		return -1;
> > > > -	}
> > > > -
> > > > -	show_dentry =3D debugfs_create_file("reset", 0222, dir, NULL,
> > > > -					  &reset_statistics_ops);
> > > > -	if (!show_dentry) {
> > > > -		pr_err("oct_ilm: failed to create debugfs entry oct_ilm/reset\n"=
);
> > > > -		return -1;
> > > > -	}
> > > > -
> > > > +	debugfs_create_file("statistics", 0222, dir, NULL, &oct_ilm_ops);
> > > > +	debugfs_create_file("reset", 0222, dir, NULL, &reset_statistics_o=
ps);
> > > >  	return 0;
> > >=20
> > > The return needs to be deleted now that the function is void.
> >=20
> > Well spotted - I'm happy to fix this up whilst applying the patch.
>=20
> The fact that 0-day didn't catch this makes me worried, is this
> platform/driver not being built there?

It looks like this code ought to be built as a module for
cavium_octeon_defconfig:

  $ grep oct_ilm arch/mips/cavium-octeon/Makefile
  obj-$(CONFIG_OCTEON_ILM)              +=3D oct_ilm.o

  $ grep OCTEON_ILM arch/mips/configs/cavium_octeon_defconfig
  CONFIG_OCTEON_ILM=3Dm

Fengguang or others - does 0-day build cavium_octeon_defconfig? If so,
does it build modules?

Thanks,
    Paul
