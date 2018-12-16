Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6278CC43612
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 235252082F
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 22:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="F3REE+at"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731055AbeLPWQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 17:16:29 -0500
Received: from mail-eopbgr780130.outbound.protection.outlook.com ([40.107.78.130]:61616
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730758AbeLPWQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 17:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YZMMh/XkeizDraAaP+DTEFwVGfCZ2q97B3XOtzx/tEs=;
 b=F3REE+atqMheZxRgHPLnOEf6wSW8mSl6tuTXI7YxmshtRqK1Szb6E9Fj/jZUmdQz/xNWUkwyicN9dpbLAOTU2aSxlxFNNz9nwCENLrG5FibOUMp9SyxWlKb6/AlHer+mWPuXfJGGkngzHUPs+lChAc9tL5xSOJ94czbhrBKBJLI=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1069.namprd22.prod.outlook.com (10.174.169.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Sun, 16 Dec 2018 22:16:24 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::c07a:a95:8ba9:8435%7]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 22:16:24 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     Marek Vasut <marex@denx.de>
CC:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
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
Thread-Index: AQHUlXtT5YTLq052+E6wpTcC1lM1kqWB0eqAgAAQjYCAAAPdgIAACKqA
Date:   Sun, 16 Dec 2018 22:16:24 +0000
Message-ID: <20181216221622.fi3q475zlhquv4ph@pburton-laptop>
References: <20181213174834.kxdy6fphaeoivqgh@pburton-laptop>
 <20181216200833.27928-1-paul.burton@mips.com>
 <f5a76d73-862f-3ebc-cd07-effc5c432103@denx.de>
 <20181216213133.kwe24pif3v4wcgwp@pburton-laptop>
 <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
In-Reply-To: <949fdd3d-535e-d235-f406-d5bde4658c5e@denx.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::42) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2601:647:4100:4687:84d1:277a:c6e5:ae34]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1069;6:Lbio5Surgv5LL+JyQ1olOZ7SIrr5oK+CjpkMIwFk52nzSVQ7hGEXAzz24kzkdWeogY5SUgnS2X+f2H9g9Ek6l9qm7lT8PTa5ObHfP++ifSigPvufxFe72LNKbaOl+kVKnpp+ySGDdKhUBGhiniSmwApHiBwf+zOiwWVCOumXmYA5IUssjRm0v4OD6sg7HbJST8yvx8zsiFTYehopmzymSQBYIuMLk68IcvrdsM9sLgkfI0veQQarfAovMbGaA3DqRGlq8p628P5XrzbYDakzkp9DAGmCGxNIyR9Ss8+m7+/5FxrsmrW4av8kfk65b9Olb2S9KcEOfHw4Q9vti49H35nJq28FzR2pxxubaune0CH03PkizUALGEh1Np6kB7OFlHGptw7xww6UI4bOj6+28B3NmbJTypEmbixh/anHOl5FJxLbf2TcMxCubUpmUkw4fGVzqTzpMD+psusXe5m6TA==;5:ODkMljlFx+FEj7z5PuMmMCObIlWhWCWrowLkXl30rQTa6R+X50JdyRmuFvh0F3mI7WX0R3g+J/QNDdua+Z8sWu0ZWcbCbUcM/2xU+l38cTrLW5HqC6QABZG0ifZgIOpf6uvD6QR82x/0P7PXM7uZa2yI70ush7nIsykJsXtubx4=;7:QiIWPYjkaWaCPlBB/Dyj4EiIfhfW0kt+MqO4lGZYz7DOCnAGC86q6coTbPAP99rlJ0JJxcUWF+DTBEmVoQLEHeufHS+cUQGG4XhVAOmn+31Gi6+P4DwLeNf7np55y/xCUTEjKulOonuURaCIvG62fg==
x-ms-office365-filtering-correlation-id: d31d7913-4dce-4632-e94a-08d663a41d9f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1069;
x-ms-traffictypediagnostic: MWHPR2201MB1069:
x-microsoft-antispam-prvs: <MWHPR2201MB10691EE45A1FD891442952FBC1A30@MWHPR2201MB1069.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(3231475)(944501520)(52105112)(10201501046)(148016)(149066)(150057)(6041310)(2016111802025)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1069;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1069;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(136003)(346002)(376002)(39830400003)(366004)(396003)(52314003)(189003)(199004)(14444005)(76176011)(186003)(256004)(316002)(97736004)(71200400001)(1076002)(9686003)(53936002)(5660300001)(2906002)(71190400001)(6116002)(6246003)(6512007)(39060400002)(99286004)(6916009)(14454004)(305945005)(508600001)(4326008)(25786009)(33716001)(54906003)(42882007)(6436002)(8936002)(229853002)(105586002)(106356001)(486006)(8676002)(81156014)(81166006)(44832011)(58126008)(46003)(102836004)(386003)(68736007)(93886005)(6506007)(33896004)(6486002)(52116002)(7736002)(11346002)(476003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1069;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: InY3tKqXsCN7hUWha7PYNs7KSMgazs2zeA7qL9rJ3hKlWfFELNUmNYnQeQIIVoVxsj77pQD5sVWGsg2LrI0fAA4S7EmfSibPyz/C8ACM30RefKPyHmVqGWUtPy8mra58eS7i24kv6+GOWSQ7ZjWeDQJhjwECqAh5EpIapTRyDoUujSIsx8XfQZfbtMQZYj5sO6XgtkTNuz817cZFuSwMDSjHZYTlZyt834N7E8yTtlLVw6f2LOyjEvIt300DNZK9qQhfv/lZcCCNvscLB2hqJ+GGwA/ro7v23QhVotpjbPFUOOiO3s7AJ6aNmrrI3q24
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D30D33DAA29A9B468D3A323B8ECE97C0@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31d7913-4dce-4632-e94a-08d663a41d9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 22:16:24.4653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:45:23PM +0100, Marek Vasut wrote:
> >> I am unable to test it on such a short notice as I'm currently ill, so=
 I
> >> cannot tell if your change breaks the OMAP3/AM335x boards or not. Give=
n
> >> that there are very few CI20 boards in use, I'd like to ask you for so=
me
> >> extra time to investigate this on the OMAP3 too.
> >=20
> > I'm sorry to hear that you're ill, but your patch is getting awfully
> > close to becoming part of a stable kernel release & it causes
> > regressions. Even if it didn't break a board I use, I think the patch
> > would be broken & risky for the reasons I outlined in my revert's commi=
t
> > message.
>=20
> That's what the incremental releases are for, so that minor problems can
> get fixed there. Sure, it's great to have things perfect in the first
> release, but if that breaks other systems, too bad.

I don't think the purpose of stable kernels is to intentionally break
systems in a stable release & backport fixes later...

> > Ultimately it's Greg's decision but it sounds like you're asking me to
> > say it's OK to break the JZ4780 in a stable kernel with a patch that I
> > think would be risky anyway, and I won't do that.
>=20
> I am saying this revert breaks AM335x, so this is a stalemate. I had a
> discussion with Ezequiel (on CC) and he seems to have a different
> smaller patch coming for this problem.

Well, no. Your patch says commit 2bed8a8e7072 ("Clearing FIFOs in RS485
emulation mode causes subsequent transmits to break") broke RS485 on
AM33x in v4.10, and it took 10 release cycles for someone to notice &
fix it. You're asking to break a system that is used & working in order
to fix a problem that seemingly wasn't even noticed for nearly 2 years.

Your fix breaks my system, but I outlined 4 reasons that I believe your
patch to be wrong anyway - breaking my system is just one part of that.

I'll rely to Ezequiel's patch now, but it again addresses just one part
of one of the 4 points I listed in the reasoning for my revert.

Thanks,
    Paul
