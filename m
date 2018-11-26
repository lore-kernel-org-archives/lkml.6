Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AFBC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:22:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF54520660
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 18:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="O3ThtgcL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF54520660
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbeK0FRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 00:17:37 -0500
Received: from mail-eopbgr780128.outbound.protection.outlook.com ([40.107.78.128]:36171
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725723AbeK0FRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 00:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hoWtzb28BwGytOIm3qmha0iTROGEOkKXn1JzxHOAunI=;
 b=O3ThtgcL5NrjJ5fb33OuXteiBo/G9hmoOac9f0et1/qTSLkw2oAkUhYbmQ2vG47GYFN5zvvul9gnVd+BAfxG7o4T7O2B5eBBdF8Fcd1TN4/l9wwFVJ92X9lKYwHlMWWFQx4pBPSv63BSEQCxo9DJ9g7LRbjP6HMyMhHbve++LWQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1344.namprd22.prod.outlook.com (10.174.162.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1361.15; Mon, 26 Nov 2018 18:22:39 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%3]) with mapi id 15.20.1361.019; Mon, 26 Nov 2018
 18:22:39 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Mathias Kresin <dev@kresin.me>
CC:     John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <pburton@wavecomp.com>,
        James Hogan <jhogan@kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: ralink: Fix mt7620 nd_sd pinmux
Thread-Topic: [PATCH] MIPS: ralink: Fix mt7620 nd_sd pinmux
Thread-Index: AQHUhXJnOeDss1ppKEWXi5kmzQdw5KViXyAA
Date:   Mon, 26 Nov 2018 18:22:39 +0000
Message-ID: <MWHPR2201MB12777328641375E40D6F11BFC1D70@MWHPR2201MB1277.namprd22.prod.outlook.com>
References: <20181126102540.5304-1-dev@kresin.me>
In-Reply-To: <20181126102540.5304-1-dev@kresin.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: CO1PR15CA0071.namprd15.prod.outlook.com
 (2603:10b6:101:20::15) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1344;6:Fma9mlbTfZkREtA8bEGnXcK+cPnrTQFc1TjsEMzC3N0509k5A0Ckpj11D3ICgsQAQqT9ZLA7j0/eRUwUIK0mbtDgKXLrjx1wcPVlsMM/IXZkyaOecOaxSJYxZuTv4u1w+D/gKaxZyLk1gqSek5z8/+oPO2m8tJAa1/dfvAlYqLaGM3fJGN4uSmvPwQssc00Jmg5V8+eVtu0PyEamoTVc/dvl7rly0njoLUYOv5tEzmHBLlWilj6CvHBWxGFWzJwAhh8P8NUhtvEbmp3y+FlW0o3912oYeZP/lHKuyG8lp6Sgr4LvFzrzLj2tTS54NNFigL7vJlq6EblTVcJRyKBoCTG+bwjY9XON/6z4uH17sRyeRuXKRXDMXTAqff9E3wiWHX9GaHSRE7oMl/F3sQLR/LCNxfDs42juYcXiRRPJuOKgFZ1ueocnT3FSKLAhxHq+L+rLx5afpqIkwCMdBpnx0A==;5:YsCHHVeSLXiwX70a39SFdqBsEY3i5SidRi8ewxAvrtW84AZom2ax93nzStAovdRUwcxeBDG+qV8+LfQMTaO7avBmmHxhJ1Rctld6/3Xsejl1ZR2bmVK5Rtk5n02mV+hKnVdUcnAA3HiVYJHayHsmHsGSX0krlDCIaiiVhRbacv8=;7:FrM+2l1us0MxYnVKq6I+6o2hdjQT3ofmQB2RmFKpR9/IfdVCxC/V9ZIzCH0qKCYMjciB21THvkQZGxSCmASh0t3rZ8FPbK+veFtpOE1S9ph7FZ5StClc49s6MPCGNScJ1+m+5BSvjTh//dQWFMruEA==
x-ms-office365-filtering-correlation-id: bc4debb3-c0e7-4277-8952-08d653cc25a1
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(5600074)(711020)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1344;
x-ms-traffictypediagnostic: MWHPR2201MB1344:
x-microsoft-antispam-prvs: <MWHPR2201MB134413FF05C63E11A319B426C1D70@MWHPR2201MB1344.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(3002001)(3231443)(944501410)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1344;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1344;
x-forefront-prvs: 086831DFB4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(376002)(366004)(396003)(39840400004)(189003)(199004)(8936002)(6436002)(66066001)(71200400001)(25786009)(68736007)(71190400001)(81166006)(8676002)(81156014)(229853002)(256004)(14444005)(508600001)(446003)(44832011)(55016002)(6506007)(33656002)(316002)(386003)(11346002)(42882007)(97736004)(105586002)(186003)(6116002)(3846002)(5660300001)(102836004)(476003)(486006)(74316002)(106356001)(54906003)(7736002)(305945005)(6246003)(76176011)(26005)(2906002)(99286004)(9686003)(6916009)(4326008)(7696005)(52116002)(14454004)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1344;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: sGr0NUIhPWUYp+eTTXKudr9UVAi+TOJMXwudLwhjeWcAcXIk0TbPd7AMZWnSJ5VBZDa11QHmHErvSCrKcMEWW65l6ZMZ0/eWveVtYCpuquOf07W5Ds63AtmVhut2nzs1/cIx8XwXtOpFCfZjg77kCM5DhLTyGkIp0t220sCf6gHVxiSVO9lN8RAA2MEBJPs7/DwoCajtyZs6yRtcqEGhgIEYt4bFSYly4G+2OXP558upChJPNC2JFDpbt+/ie/KrSdKXqYU/V+/1g2ZTSb6AwjB18jeJPLIjLMYGpy0JnkDqolJsqEqWM9M/d7USn4/bYcejHkNrkaZvKC1I2Th7SyzRY3SYd8Ye9wWX1dqqIGw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc4debb3-c0e7-4277-8952-08d653cc25a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2018 18:22:39.2249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1344
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Mathias Kresin wrote:
> In case the nd_sd group is set to the sd-card function, Pins 45 + 46 are
> configured as GPIOs. If they are blocked by the sd function, they can't
> be used as GPIOs.
>=20
> Signed-off-by: Mathias Kresin <dev@kresin.me>
> Reported-by: Kristian Evensen <kristian.evensen@gmail.com>
> Fixes: f576fb6a0700 ("MIPS: ralink: cleanup the soc specific pinmux
> data")
> Cc: stable@vger.kernel.org # v3.18+

Applied to mips-fixes.

Thanks,
    Paul

[ This message was auto-generated; if you believe anything is incorrect
  then please email paul.burton@mips.com to report it. ]
