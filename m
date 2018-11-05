Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4787FC46465
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B83922DA8
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 18:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="dSKNErWw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B83922DA8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387850AbeKFDgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 22:36:00 -0500
Received: from mail-sn1nam02on0117.outbound.protection.outlook.com ([104.47.36.117]:6384
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387561AbeKFDf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 22:35:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qNgPdltg4uKM1p7/sVcOF5C83VMGz36AVaqw5HteNCs=;
 b=dSKNErWw/yTQDFG2gsSugOFhW907yDpcAaK8dWiNzuk5RT0slES0B2HIsDXOygfeSxuVBDbGJ6bkNZy7IiCySe9R66uUgHjFDACK7c74pd8ZH1yDovhVQA83zcFH9P5FdR+WTIXp2Ea6OTKFXfnmYvGeXOs/13n/GcXguZNXPPY=
Received: from MWHSPR00MB117.namprd22.prod.outlook.com (10.175.52.23) by
 MWHPR2201MB1150.namprd22.prod.outlook.com (10.174.166.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.26; Mon, 5 Nov 2018 18:15:05 +0000
Received: from MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045]) by MWHSPR00MB117.namprd22.prod.outlook.com
 ([fe80::b95a:a3f9:be06:b045%2]) with mapi id 15.20.1294.032; Mon, 5 Nov 2018
 18:15:05 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Yangtao Li <tiny.windzz@gmail.com>
CC:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "jhogan@kernel.org" <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: math-emu: Change to use DEFINE_SHOW_ATTRIBUTE macro
Thread-Topic: [PATCH] MIPS: math-emu: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
Thread-Index: AQHUdRb2XyecBmejX0O81GDRuHhz4KVBfMOA
Date:   Mon, 5 Nov 2018 18:15:04 +0000
Message-ID: <20181105181503.vcahr7horqqmbzqp@pburton-laptop>
References: <20181105145049.6336-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105145049.6336-1-tiny.windzz@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:300:115::34) To MWHSPR00MB117.namprd22.prod.outlook.com
 (2603:10b6:300:10c::23)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1150;6:XXXU8HWTm1FQjFJTIS0V6qNsXnKcH/Pcm/k9/fg9immzAsCmoUt78QImLZOoVfR6Tp75DOI1fUG8prSVO7pxTsKwP3/ekXEMH3ft69GMbuRO7Vi525SlX/jMZFW7P03DfXoRc7IZ4Fd9xk8XtK+ZCcnhkFSSaZ5x5r3C1Ibc63fQOg9b6zfSMTpRGCBqtGh0326Kh7df6iAGhiNht7rHSXQ+PKXWHWJf4+LSBfqik4xGANktOk/w0jnydzilNEIuixYYeae67ev2vz2ahwCS2QBDP7NxhfQY6zVEBgpGYLL6QSexgylvQCbZzOweIhVs8U06Hf5fmKzr6eWAB6Nr/AqxAmYmtn5j9OV3fcFRxFw7A4ykdOC5wejrcb0+gKjaf5mLssKq1sNrbfXJ3wHYKvIEH/IWOGr45aNm7e/lH3jzhfuZjGQhHlmGdbk1MWJSom4LQa7qEVJeszg+/1Fa6g==;5:29dEdLL+svPJvb1WnYgNrq+m7vHXvYcJ1vkOpunoL3MwUIfAHbrNkJe5tNQ5EJuPPAAD9kQRytKShDyO1+VKtRALswzRCb3hAa+efTIHpbbogvKT6dS+GwLDWd+9Mg4LVWcMxqrrC6ekcDWOOehOwULhQFHeyfRgWC573bFaNoI=;7:VI0Jkv77ob4rxp3D7sIK7lEVRDP7u2gOBHK9ylQXnF7RdAAtftHtWbWqaN7QIccQ3rt4503zjgmo21OLOJVr5uh3cN6Nxt4S/ZTpXr69M5tq6BSI6wdjfhoEpykLcYhZqIBWlK6yD+yAIcCHLpBz9g==
x-ms-office365-filtering-correlation-id: 135c72fc-269f-44b5-09f4-08d6434a9c33
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1150;
x-ms-traffictypediagnostic: MWHPR2201MB1150:
x-microsoft-antispam-prvs: <MWHPR2201MB11509B5EBDB67C4B39170D73C1CA0@MWHPR2201MB1150.namprd22.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(3231382)(944501410)(52105095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1150;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1150;
x-forefront-prvs: 08476BC6EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(396003)(39840400004)(376002)(366004)(189003)(199004)(42882007)(256004)(2900100001)(386003)(6436002)(508600001)(6486002)(9686003)(6512007)(4326008)(11346002)(446003)(53936002)(7736002)(6246003)(44832011)(71190400001)(71200400001)(305945005)(66066001)(102836004)(476003)(486006)(52116002)(76176011)(229853002)(39060400002)(14454004)(316002)(6116002)(3846002)(26005)(6916009)(5660300001)(33716001)(186003)(2906002)(97736004)(68736007)(6506007)(33896004)(54906003)(99286004)(81166006)(8936002)(8676002)(58126008)(106356001)(25786009)(1076002)(81156014)(105586002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1150;H:MWHSPR00MB117.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ZwuywsOcrS3xH0mbLUApMokyMtnOzcKM//yqXOH+L/1xsHYK+G/ru47eLmpbYuPUOIaaaRR7d75D/r45ggMhd0sd70E9E9HbsKjKsVuWaSNYL5Mg/ZRMVUfgZ6I/ip94Q94D65pxlOSKEvOW+0vuHPK3Z18lhmu+r3duJ2JTOmiXtirZiX9sAabW1e7+Kn1XemZ5nwcWSOi9hjJsW9PZUWLbrY7P29MEv1YdX81DS/lwBChfrd2exPN8OHDJ+VxBpImpIfirT2BmEXWzf5uPMvKqNCRCFNTE72vdrpRDXt24/vPfJiCobGL4A+wuOkCY2pRioT4EtAFpfOdAlYTnrCEQhlP+LDsBmkiEcF3d73c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C5D1B97C8219648AA03C57DCC9ADD60@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 135c72fc-269f-44b5-09f4-08d6434a9c33
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2018 18:15:05.0398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1150
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yangtao,

On Mon, Nov 05, 2018 at 09:50:49AM -0500, Yangtao Li wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
>=20
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>  arch/mips/math-emu/me-debugfs.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Thanks - applied to mips-next for v4.21.

Paul
