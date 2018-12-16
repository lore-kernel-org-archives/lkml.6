Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C64DC43444
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:35:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39A6206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="f6N7pYKQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731042AbeLPWfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:35:17 -0500
Received: from mail-eopbgr700114.outbound.protection.outlook.com ([40.107.70.114]:30413
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbeLPWfQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:35:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2OmO7ZPO2Yp4yjNqxO9lyZlft7PpxNWkQCgrCGllNpo=;
 b=f6N7pYKQjWMIesCNoi4JGpQQV8W7DMxuikGmkEbXqeyM3GqOgzryvgvTYZ+/E6OZWEp38yYpookms0JQzVJ5GEYOB8zOt9NuzL0pXu3SXeCqeF2aEDzJKvB1Tf2c2BtWEprOBwEQwzHkRZYFK/nhq8Dv/MHOsNiKlDF3rCY0Sng=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1728.namprd22.prod.outlook.com (10.164.206.158) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 22:35:12 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 22:35:12 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
CC:     Marek Vasut <marex@denx.de>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <pburton@wavecomp.com>,
        Daniel Jedrychowski <avistel@gmail.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: Re: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Topic: [PATCH] Revert "serial: 8250: Fix clearing FIFOs in RS485 mode
 again"
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB0eqAgAAQjYCAAAPdgIAAAhmAgAAIv4CAAAErAIAAAeYA
Date:   Sun, 16 Dec 2018 22:35:12 +0000
Message-ID: <20181216223510.hxsdotf332ousinh@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
 <CAAEAJfAad75bHX39ETCdVv9vP0dF7PLz2vvFLLqgtyikPHqJyA@mail.gmail.com>
 <20181216222411.5jkexuaqxpfudj7b@pburton-laptop>
 <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
In-Reply-To: <CAAEAJfAQ9=B6sm=Ard+YTDN5g5r03o=t9xU3Nu2QaKrXXZ4pGw@mail.gmail.com>
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
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1728;6:nythox7llOxJaj+VQ8Q1USnz+TQIDc2NSXzMmITKhBUu70tOtQALfG2h5NMmceW2Esun6sHklNLvaCigh8lztCp5RVdvtF/sQwpf6oMyMIF8aEVCE1QPhENvc69P0nlp8JRtHS78KbppiiJe6252OfAD9VW8JQdcBS3hzV2L7iqpOSVxOwRaOgusedQjQXU/ysZFe6hnoLvAoJIgi2kTuxaz50IzyoP1OBokiA1qkPDVMtNHPYXtd7RHq+5TznBp+gDDWF6uQ4W1L4D6C9GY+/PbdsaqBBtT0L7ApsBT+R6a8VyiQRCxjAn49FX65pRSGhZXm50XzyalxARsfevfWToZ+crcw/BOHyCYg9IBCk5k6+7hiJYD107byZkDjsd+EMx0FTloXTeI5+0pezJES+X3YUQ+STKqH6E1AsyNy42ihhK3a8djyfKNFC4/gVq6aMhOrsBVu8eAZp+U+TC/Sg==;5:XHSSoaEuqisjKfUUvPNAUgojkbbEzeaCWdROm+x/s63VRJNF9igWnLIwBQYMLVHY4x4kKxBX3ZNlW3wZXmz+C3U/n2Mj+PGpqD5DQocDz6jt/cw9eGRkKX36l8oroR4aNgEhtcCafFudg9xeySwliJEME78/DU76oUs15XoMuOc=;7:yiLHEpKID0YIRrJM1qWQSgBpQo4lDCnmJsN8OEV0SSsLlZ0u5xDs0/QFMg4mg6PRAC6ENYprsghuMkbynemS5ryIIAXwqVbdloa6Pnn/B1rpbJIj3IUwIKQoyVJVLRUmDiMlQC9cCnltTc5MV24eFg==
x-ms-office365-filtering-correlation-id: 305ad8c4-5368-47af-c854-08d663a6bddb
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1728;
x-ms-traffictypediagnostic: MWHPR2201MB1728:
x-microsoft-antispam-prvs: <MWHPR2201MB1728C0EBC4767A1716759AC7C1A30@MWHPR2201MB1728.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(93006095)(3231475)(944501520)(52105112)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1728;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1728;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(346002)(366004)(396003)(376002)(136003)(39830400003)(189003)(199004)(476003)(5660300001)(508600001)(71190400001)(14454004)(11346002)(446003)(54906003)(105586002)(6116002)(966005)(106356001)(316002)(1076002)(42882007)(97736004)(46003)(81166006)(81156014)(58126008)(53936002)(229853002)(9686003)(186003)(6306002)(76176011)(8676002)(6436002)(6916009)(33896004)(6506007)(102836004)(386003)(6512007)(25786009)(99286004)(6246003)(4326008)(39060400002)(52116002)(8936002)(6486002)(93886005)(2906002)(33716001)(305945005)(256004)(486006)(71200400001)(7736002)(68736007)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1728;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: ltgI4Sy0Bpl0xuKIsJr6M210lsSXOEYbM4QivGHALrozYA0bG+91cL+5t9l4p7uw0fQ/NTNu2mdPsQ7rsS7XWP32uEb4TK8ouWQJPEd0O+9B6ObeU9298HaXmWb6iWtBw32K9oMdbU5Z4yGZYLL6eNKi9ix8C+AlaMisUnA8sp9i01vOlOZ91PlvOWxjXMHsVDo2wVCbdiJIRXBhePOhpZhn2UCqNk4MTDUyjVhdc3IGmviFQDSRBpxMxLI6DN23J10DQSee+IUICcr1t5zmxlG5WkN+w/fjifwKHdDp1Oj49mcRXn3srJlAQITVgBiZ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CE4E5AEA69002C469A7FED8C8B44C52B@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305ad8c4-5368-47af-c854-08d663a6bddb
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 22:35:12.4272
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1728
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Sun, Dec 16, 2018 at 07:28:22PM -0300, Ezequiel Garcia wrote:
> On Sun, 16 Dec 2018 at 19:24, Paul Burton <paul.burton@mips.com> wrote:
> > This helps, but it only addresses one part of one of the 4 reasons I
> > listed as motivation for my revert. For example serial8250_do_shutdown(=
)
> > also clearly intends to disable the FIFOs.
> >
>=20
> OK. So, let's fix that :-)

I already did, or at least tried to, on Thursday [1].

> By all means, it would be really nice to push forward and fix the garbage
> issue on JZ4780, as well as the transmission issue on AM335x.
>
> AM335x is a wildly popular platform, and it's not funny to break it.

Well, clearly not if it was broken in v4.10 & only just fixed..? And
from Marek's commit message the patch in v4.10 doesn't break the whole
system just RS485.

> So, let's please stop discussing which board we'll break and just fix bot=
h.

I completely agree that would be ideal and I wrote a patch hoping to do
that on Thursday, but didn't get any response on testing. It's late in
the cycle hence a revert made sense. Simple as that.

Thanks,
    Paul

[1] https://lore.kernel.org/lkml/20181213014805.77u5dzydo23cm6fq@pburton-la=
ptop/
