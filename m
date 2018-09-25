Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997AC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C237220867
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 19:58:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="A7574bBw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C237220867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727192AbeIZCHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:07:13 -0400
Received: from mail-sn1nam01on0101.outbound.protection.outlook.com ([104.47.32.101]:20866
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbeIZCHN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K48w7GP2DcTWXlrVwpO0fXCDGDDHQHJfOd21KWeb+UE=;
 b=A7574bBw64MZX+iT+PTZhs3uadB8EwCGByZZhOeuNLwiZ7fcuEkkJJetanZNjhfKxmVnWfyGbCzVAsYUeb01nEo4uybKcsb1bWfQWrGldMA+G1mvRZCiOtdWCYpGoA4l5zdf/znTalkxQmhit+x5VxpB2iq40LurJMg2Gp/vZUQ=
Received: from BYAPR08MB4934.namprd08.prod.outlook.com (20.176.255.143) by
 BYAPR08MB4373.namprd08.prod.outlook.com (52.135.211.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.22; Tue, 25 Sep 2018 19:57:59 +0000
Received: from BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981]) by BYAPR08MB4934.namprd08.prod.outlook.com
 ([fe80::d9a4:818:86af:8981%5]) with mapi id 15.20.1143.022; Tue, 25 Sep 2018
 19:57:59 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yasha Cherikovsky <yasha.che3@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
Thread-Topic: [PATCH 1/1] MIPS: Add new Kconfig variable to avoid unaligned
 access instructions
Thread-Index: AQHUUQPr1ACo6zXNjUStgfMebG/ND6UBTPoAgAAdiACAAAeRgA==
Date:   Tue, 25 Sep 2018 19:57:59 +0000
Message-ID: <20180925195757.glglc6q3ghn3dhs5@pburton-laptop>
References: <20180920170306.9157-1-yasha.che3@gmail.com>
 <20180920170306.9157-2-yasha.che3@gmail.com>
 <20180925174510.rg3j4lfmwvlecnqt@pburton-laptop>
 <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
In-Reply-To: <fc0016b8c3d08fc139356c39668c6ab5d8c297fd.camel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR07CA0018.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::31) To BYAPR08MB4934.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::15)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR08MB4373;6:T8LuSYveAfhCEt1d6Y6LMqAjaanhWFsTStkCPSqM6PX1nmN1xoMB99l8OTPl0mwTSYl/KIbEyb98EnVNpQINYtfFqf3STMvsoY2tq//aO4NkSFbCYpluvFUmySqea3zP8bO34I1fEzQcTlRUmIyLf2LvLzDNar42C1/e97tJfyxW23/6wP5rJWx+hheBDskcPt/vhUiDrKp/kf5m5P3VIbHwxGcam9Zn1YjYm+fX7RMzNAYtzFTehSMeM1mUkW2C/8OMnhIReRabrpQOIFcKMXlpgUT8gMi6lM4c/ZqD+WFvLT7ZereelVsM0svRTUpzkbihyMEZ66jRRqETWktkl8+vBuBcExQdRjJoX2w+3lkuUzH6T3Fd+4gYydWvlRXJg8fhR1geo19I+MRF1Ga+yrEL7gyypNPJzd+8EVQ/pAdXZ2z5lkWkOSz2CVZHksVRIwX0EtQCH/nhLwxeHVl1fw==;5:rxqH8a/et1CbccXNccXF3Ogq9XlugIupV0SP+ybC5HlRo+L7ae+B+uee6GHUg007Q4fz+f5e9kLz0xa3R8ieQRXyOekwCiGq0AfjUkvEotTYFlvQTGw1mfuuVlrabIDPRxq1Wm8wAfceRaK+e2avaX4i1ezohRLSly9V++hSo38=;7:+jTWO8IreMW0WcPS8GxM2n6+PN1+8/LOl++0yloBuqJO/jCRZmh5FM0MkXQgIbMH6qMENqwZwcwVIuiha3yXg3cQtjkjW3yhvmnCmvIjqZveEKBT9L/8HTbypTuMGpNmdJ8WCM5ufSl+Wviome1H0ek/vAco57SLGAJR3dAfUmFqWghRMS+OF9COAfj5ESTDqO8BWisU3cEZJdkKrfb50luR1K4F2D1A5jT1Pc/GEW9Rg0G/Tj93b1s8hoprESm1
x-ms-office365-filtering-correlation-id: 17f7d68f-4ef8-4864-3f9d-08d623213145
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4373;
x-ms-traffictypediagnostic: BYAPR08MB4373:
x-microsoft-antispam-prvs: <BYAPR08MB437312C22299E9D87DF4F7B1C1160@BYAPR08MB4373.namprd08.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(3002001)(10201501046)(149066)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(2016111802025)(6043046)(201708071742011)(7699051);SRVR:BYAPR08MB4373;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4373;
x-forefront-prvs: 08062C429B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(376002)(396003)(39840400004)(366004)(346002)(136003)(199004)(189003)(66066001)(6916009)(25786009)(105586002)(97736004)(305945005)(106356001)(2906002)(71190400001)(14454004)(256004)(53936002)(5660300001)(39060400002)(8676002)(34290500001)(81156014)(8936002)(7736002)(68736007)(508600001)(71200400001)(6246003)(2900100001)(81166006)(99286004)(1076002)(54906003)(58126008)(76176011)(33896004)(44832011)(229853002)(6436002)(386003)(6116002)(486006)(6486002)(52116002)(6506007)(33716001)(93886005)(26005)(102836004)(42882007)(9686003)(6512007)(3846002)(446003)(5250100002)(186003)(4326008)(11346002)(476003)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4373;H:BYAPR08MB4934.namprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TYkI1hQ3bawm56tJua470oaoXeAhxTGuJmw81pKPOeMf9koSiKb+k91nuhlhoXCPMF70ZZ3pj5EKWZSMNslA4/MRXc5Xdv4scM+NAd+kkS3GiMXJRaZZpT9ZWjNwsYRXlPVYQ4ZMwCGIRog2SGLJx0vQO9ANYRutJmeLrhrhyhcqeVByM30GjnAeqtdT4CfJG6yX1LFiTgS91yl4WTqiwbXVvxQbTAh7iEt8RPw6jaHT1wfMYnbNEG/DvOWK4BPP6b3aXc1YnCY0W8CzFQPMOdmtVwYlkv9poDmgllTpu+q0WTpEXDnW23j/luRh9FWOJ3M5u43TxOY1s7Cm+cHVZEB7MiK+gqybukN/WBNy5Sg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B71A8E97ABDADD479D680C9C56B18ECD@namprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f7d68f-4ef8-4864-3f9d-08d623213145
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2018 19:57:59.1611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4373
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yasha,

On Tue, Sep 25, 2018 at 10:30:52PM +0300, Yasha Cherikovsky wrote:
> On Tue, 2018-09-25 at 17:45 +0000, Paul Burton wrote:
> > How about we:
> >=20
> >   - Add a Kconfig option CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and
> > select
> >     it for all existing pre-r6 targets (probably from CONFIG_CPU_*).
> >=20
> >   - Change CONFIG_GENERIC_CSUM to default y if
> >     !CONFIG_CPU_SUPPORTS_LOAD_STORE_LR, and drop the selects of it.
> >=20
> > That would avoid the double-negative ("if we don't not support this")
> > that the #ifndef's currently represent. It would also mean any future
> > architecture/ISA targets beyond MIPSr6 automatically avoid the
> > instructions.
>=20
> Thanks for your feedback, I'll start preparing v2.
>=20
> Looking in arch/mips/Kconfig, some CPU options start
> with CPU_SUPPORTS_ and some with CPU_HAS_.
> Which perfix should we use here?

That's a good question :)

To be honest I don't think either of them is perfect, since what we're
really describing is what's supported by the ISA that the kernel build
is targeting - and in theory the CPU we actually run on could support
extra things.

But considering it I think CPU_HAS_ is probably the best choice for
this, since it's already used similarly to indicate support for pref &
sync instructions.

Thanks,
    Paul
