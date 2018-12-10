Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9B73C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828852084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 23:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="guAAgNJd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828852084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeLJXqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 18:46:33 -0500
Received: from mail-eopbgr740099.outbound.protection.outlook.com ([40.107.74.99]:32566
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726261AbeLJXqc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 18:46:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3682F/KuaafpvnMoJ+2aESN+qtA7R8uIS1Q7YpfD08=;
 b=guAAgNJdFCdUmxEFmAAnfRGJtIoL0K+vDPwGeOKzlvCZMXcsVsAPzN9R9EjQSI60ie5WOJ+4nr6ulO0rVaKu9nB73WKytKah79OsmJQ0fLhc7Z2sY2XvEp7KNFuB4fQgIMvYsxlykEQoLHCVGYY1GRHg+BNock2/wKbIE7HoyiQ=
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com (10.174.162.17) by
 MWHPR2201MB1216.namprd22.prod.outlook.com (10.174.161.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.21; Mon, 10 Dec 2018 23:46:27 +0000
Received: from MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985]) by MWHPR2201MB1277.namprd22.prod.outlook.com
 ([fe80::2d92:328e:af42:2985%4]) with mapi id 15.20.1404.026; Mon, 10 Dec 2018
 23:46:22 +0000
From:   Paul Burton <paul.burton@mips.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     Firoz Khan <firoz.khan@linaro.org>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Subject: Re: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Topic: [PATCH v4 3/7] mips: rename macros and files from '64' to 'n64'
Thread-Index: AQHUjSNJ15+cZub/wUiwPpyZjNjVYqV4aUcAgAA9wQCAAAPLAA==
Date:   Mon, 10 Dec 2018 23:46:21 +0000
Message-ID: <20181210234620.rcmapky2aj7eb2wh@pburton-laptop>
References: <1544073508-13720-1-git-send-email-firoz.khan@linaro.org>
 <1544073508-13720-4-git-send-email-firoz.khan@linaro.org>
 <20181210195144.dvprpyxyddusyb5c@pburton-laptop>
 <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.21.1812102324500.11202@eddie.linux-mips.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MWHPR14CA0042.namprd14.prod.outlook.com
 (2603:10b6:300:12b::28) To MWHPR2201MB1277.namprd22.prod.outlook.com
 (2603:10b6:301:24::17)
user-agent: NeoMutt/20180716
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [4.16.204.77]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MWHPR2201MB1216;6:rfDXA5RDt7ygcW+KnMJq5YGCq8IDp3Pn6WAc40PJ2FwtGFplhpB6Pm9CGlEFKzDR9q7ZPPHJoOc3Ij9XfnVSA8ochel6ldKYRi/mafSaVqQfogsHFAiUX7N5TRwKF0jJ7NQiZx51Gtht4ieg5aDaNxG43Dq7VyDQTKRSn8mszA0KdUjuBqT0+1S/Aou8v4DhVmxkdRWsDOWR3qKhPyjybOuMv3+aBeLtVAB78MR1H+BBy1b2+jbTGB4HptSZvyEkyhxu+y/ZxXGUT47fAMmksw3NmrDxa1qLN6mowIOuVj3aSOojPti0d6XkQwc5v+dTGbKC6jUqBB/zvj2VYVbxMp/4nlH25krJste7aSr4zfKk5dWFAAStcs/3IVeSk1yU/34PCRqJH8Oll7UdxN6RZMl57xyRPkdjZ08Yweqz7axZKCxXKLMpfMs0t2lWfUHinfY7MVxbl7F2Fm4XtRPS2A==;5:2vb8qLG8sOaKbh0QN6Xy6z3Q+HdDi4YRCktf11IiB2kLMQm0A2iYeznVWL/PKV5k87Hpu6IwyQo0qOH+VfkDoQmkv22zpDHVHCOxwrGLbQqdRVAZycrbL7cL19X12eKt9FIa+PkCmR0FW8GnSIvTNprKPTAslUy96oxTsdi4YoI=;7:4yMyvxlemIE/Znig6QcqLzUWcyTnB69yACPnfPcTykjD+hSsnyWWtjOqUYflEmXrQOkkisv87BgyxnCHXRn0AeWsmm95vqdpAv7WuNz6MnYbI6+DIXTJYIZ4RkeAvf60GDXad3IZ/LcNWq0ydNnfwg==
x-ms-office365-filtering-correlation-id: 27de1de9-ed7e-443f-0f44-08d65ef9b02b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(7021145)(8989299)(4534185)(7022145)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:MWHPR2201MB1216;
x-ms-traffictypediagnostic: MWHPR2201MB1216:
x-microsoft-antispam-prvs: <MWHPR2201MB1216EA32B7618B645D6E2D67C1A50@MWHPR2201MB1216.namprd22.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231455)(999002)(944501520)(52105112)(3002001)(93006095)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123558120)(2016111802025)(20161123562045)(6043046)(201708071742011)(7699051)(76991095);SRVR:MWHPR2201MB1216;BCL:0;PCL:0;RULEID:;SRVR:MWHPR2201MB1216;
x-forefront-prvs: 08828D20BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39840400004)(366004)(136003)(376002)(346002)(396003)(199004)(189003)(7736002)(54906003)(1076002)(7416002)(508600001)(6116002)(53936002)(6506007)(3846002)(186003)(58126008)(52116002)(305945005)(25786009)(229853002)(4326008)(102836004)(386003)(6436002)(99286004)(476003)(33896004)(486006)(9686003)(11346002)(446003)(44832011)(33716001)(6246003)(68736007)(6512007)(76176011)(6916009)(5660300001)(316002)(2906002)(71200400001)(71190400001)(6486002)(26005)(42882007)(256004)(14454004)(81166006)(93886005)(8676002)(106356001)(81156014)(8936002)(39060400002)(97736004)(105586002)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR2201MB1216;H:MWHPR2201MB1277.namprd22.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: MNczU/O2npwH4y8Y5oL80Qz4QnVbXwBkgGckl2c6PakxeZMVImcZabpCjqjY2LI40AQx4o8vzkVHd4lrgwQN4KEQdI+Cn+dMZ5A/V9v1EMUcgKA105rf8PnwfveH4ecXDdR2F07+Hc4vHv/ZduyhwO3rZS9Q+1AWCePwEL84oRZR6dRXbJVccuwBPqPDBYEzB5FOWshyZ8gp2n8Vep6Q5Ru0o62I+FpLaoxy3EsKZ11GYiq9Qakio7sk89n3sz7NE2jv0VqUesUuxhsXNAPWPAicJMy4uHynVO+oWn9M5S4TO5Pex+kvBcSxSAKAm1ka
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5FAF10F29AFEAA4094E3BA4773787464@namprd22.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27de1de9-ed7e-443f-0f44-08d65ef9b02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2018 23:46:21.8756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2201MB1216
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

On Mon, Dec 10, 2018 at 11:32:46PM +0000, Maciej W. Rozycki wrote:
> On Mon, 10 Dec 2018, Paul Burton wrote:
>=20
> > And I realise that undoing that but keeping n64 in our own filenames &
> > macros is another type of inconsistency, but something imperfect is
> > unavoidable at this point given that the engineers way back when decide=
d
> > to use "ABI64" for n64.
>=20
>  My feeling has been n32 was invented at SGI as an afterthought, hence th=
e=20
> choice of having ABI32 or ABI64 defined for the 32-bit (now o32) and the=
=20
> 64-bit (now n64) ABI respectively was reasonable.

I'd agree if _MIPS_SIM were defined as _ABI32 for o32, but:

  $ mips-linux-gcc -mabi=3D32 -dM -E - </dev/null | grep ABIO32
  #define _ABIO32 1
  #define _MIPS_SIM _ABIO32

...so _MIPS_SIM is:

  _ABIO32 for o32
  _ABIN32 for n32
  _ABI64 for n64

That doesn't seem very consistent to me, and means that there inevitably
has to be some ugliness once there are multiple 64-bit ABIs.

To me it feels like the result of someone thinking "one 64-bit MIPS ABI
ought to be enough for anybody". I'm undecided whether that person was
shortsighted or a genius whose vision was simply incomprehensible to
those of us that followed.

Thanks,
    Paul
