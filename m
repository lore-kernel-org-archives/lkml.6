Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3553123-1521485586-2-13877413006799592115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521485585; b=YV20GtHbQtU1AnIiPt16G+ysEOka9nJ/oU1gN35Cw2I0TuC
    xWD1UTHPBwkMzG0ToSNyhF7qcMdUm7bk6a35b3QY3NosZutfItqr0hXbaKXpJGMB
    OYxSxHgwAitUw9g21O3sY83APQU0ZpyjPSHdLJ6+4KC1QK6o6VT10oAOMCTmfsEs
    /FVcLEj0VggNMpeSl8thhDV/iMxzfRti5MhPAaJKLzZZg+J2/rqLmC/ANU1k9Yhr
    4vxRWKH9DErZjRjVHBj7kbf4exHbz0IRWIt82n4gimvNtPOgcK55gpKBC1+gWFah
    GuElWOM8kJsf+aLWC/ad7yWyCy2gAkfmw2Zd+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-id
    :content-transfer-encoding:mime-version:sender:list-id; s=
    arctest; t=1521485585; bh=zGO08ZScrCU+1gjWMB19mZl76ocnikghhb1XML
    tbkHE=; b=MfY+Suc6RzGe/uBTE06HuL8AgRuHQ4DOrdt7sr5ENaHcZKUHYN5agD
    iXEuOw3ZemKNvULHXSEtc7TsW7vrn85uwPJWzuImeAVy1lCrP/4LwIw9p/nLfSUe
    3SOFZLemZ4g6DXWy1/mSZuwlnlxszOZ/w2g+HLtnK+HS2BRdgDitmrcmkTeSuAK0
    ZS7OFG8cGhXqrCemMw3cDVFdHyAL2VnNv66NQWTq6VI07TZxy3hoLFpQBDJyzabg
    wrNNuE1uFCFSP/N/XpkO6Ial3e8ta0ozEe8Hxx8SVS8/46eGMwZUf8zU5FP50eXl
    OyCmYRR4ZCudbgzJZpE2KysplEqhknNg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=pwnxMoQU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhhmtddttddvnecuhfhrohhmpefprggurghvucetmhhithcuoehnrghmihhtsehvmhifrghrvgdrtghomheqnecuffhomhgrihhnpegtuhhsthhomhgvrhhsrdhpihhnghenucfkphepvddtledrudefvddrudektddrieejpddviedtudemieegjeemgeehkedtmegsjeduleemjedutgejmegsuggskeemvddvkeeimeekledthedpfhgvkedtmeemjeegtdgrmeekvdguvgemgegvtddtmedvkedutdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=onevmw.onmicrosoft.com header.i=@onevmw.onmicrosoft.com header.b=pwnxMoQU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-vmware-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=vmware.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudelucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhhmtddttddvnecuhfhrohhmpefprggurghvucetmhhithcuoehnrghmihhtsehvmhifrghrvgdrtghomheqnecuffhomhgrihhnpegtuhhsthhomhgvrhhsrdhpihhnghenucfkphepvddtledrudefvddrudektddrieejpddviedtudemieegjeemgeehkedtmegsjeduleemjedutgejmegsuggskeemvddvkeeimeekledthedpfhgvkedtmeemjeegtdgrmeekvdguvgemgegvtddtmedvkedutdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejfedtheenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=vmware.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967640AbeCSSxE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:53:04 -0400
Received: from mail-bl2nam02on0044.outbound.protection.outlook.com ([104.47.38.44]:48907
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967575AbeCSSw4 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 14:52:56 -0400
From: Nadav Amit <namit@vmware.com>
To: Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oleksandr Natalenko <onatalen@redhat.com>
CC: Xavier Deguillard <xdeguillard@vmware.com>,
        pv-drivers <pv-drivers@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Gil Kupfer <gilkup@gmail.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Topic: [PATCH v2] vmw_balloon: fixing double free when batching mode is
 off
Thread-Index: AQHTujhdSIiXJAlj90GNO4oOVtEcZaPPHhoAgAjUbYA=
Date: Mon, 19 Mar 2018 18:52:53 +0000
Message-ID: <BB21DC03-9168-4E5E-B5CA-D446E07BE52F@vmware.com>
References: <20180312191917.21381-1-namit@vmware.com>
 <20180312192848.22104-1-namit@vmware.com>
 <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
In-Reply-To: <E63288C3-BE4F-4D41-A074-1CB86C74414E@vmware.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=namit@vmware.com;
x-originating-ip: [2601:647:4580:b719:71c7:bdb8:2286:8905]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;SN2PR05MB2704;7:8NF25TqahI6gbKnsqDwaD24xsV1xfYoqZBJcpATcwmfur18Mue9ctm01snLyZrhbovHKu1Mi4D+/G9lPSUWpGqgwLIHC6jy2yc+5O+G6CnNV1pleUnk+/9fanE1/AJZO1RkN1MW67Q+TLfGvkU///7PAYVjo8nhheBgie1jj7U2cp+b3gvAuXHwV3HQevQNAr0i//ejy85tr9l7zX57vSv2O/munWhIkFWl47Hmqkn8gaov+vejwf1L0vdH7v+K3;20:LIUiWkVdQRHlLMSyBn9Yb1SdiyKAc7bwEVo9+qYueniFOJ1aSjdx8FD6J6oTYg3yqK259304jezTVCVQof5+7dEnVNbnw6wHSLbCJ3VVMbdq514ARqZpDEZZ8TlRdn3FfqtOuJ8MC4SOnDUoW1IlHe0A1U5ogzjB1XwoHdMElWc=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: d83931c3-dc6c-44d8-14f2-08d58dca9f26
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN2PR05MB2704;
x-ms-traffictypediagnostic: SN2PR05MB2704:
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
x-microsoft-antispam-prvs: <SN2PR05MB270496DEB883CC98BF3DD0BFD0D40@SN2PR05MB2704.namprd05.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(61668805478150)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501244)(52105095)(3002001)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:SN2PR05MB2704;BCL:0;PCL:0;RULEID:;SRVR:SN2PR05MB2704;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(346002)(396003)(376002)(199004)(189003)(6246003)(6512007)(2900100001)(478600001)(14454004)(59450400001)(97736004)(33656002)(46003)(6436002)(68736007)(99286004)(82746002)(39060400002)(53936002)(110136005)(54906003)(5250100002)(6486002)(76176011)(83716003)(316002)(6116002)(6506007)(86362001)(3660700001)(106356001)(4326008)(3280700002)(305945005)(7736002)(229853002)(105586002)(5660300001)(102836004)(186003)(25786009)(8936002)(81156014)(2950100002)(81166006)(2906002)(36756003)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN2PR05MB2704;H:SN2PR05MB2654.namprd05.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jLdQ25iCHj9djp44vd+V1wr9tSQ/p+aLRISjzTRlxIdaERGGrWoFGDVxJWP5hlsLDoQQiUzDtl9su19NNkHAhNZd3bAypKDeg3zCb2o3CBzMVXf6noI/SEdCzEWm/mwvylGMY9SPDYk6mLKpaJluU7srZz2qhCZAIxbRnMVAfP/b2FDqMChr0Rw0Vq6/Hqtij8UjxYQm8tEE3QitMqAhIcbDvkYWwdE//9F+FZ/KFAksHWV9yeF9oQn10FffWDk/D3Sun1ds0X3y55pIuA9nLkL/E/LmyXkNSW51NcfL3lsMWteKl/rj8txIBCZkSDn/LR0MwzC12U8QCiLLyJrp7Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <15F22F7C2823FA42B9B36D431EE77843@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83931c3-dc6c-44d8-14f2-08d58dca9f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 18:52:53.3924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR05MB2704
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Nadav Amit <namit@vmware.com> wrote:

> Nadav Amit <namit@vmware.com> wrote:
>=20
>> From: Gil Kupfer <gilkup@gmail.com>
>>=20
>> The balloon.page field is used for two different purposes if batching is
>> on or off. If batching is on, the field point to the page which is used
>> to communicate with with the hypervisor. If it is off, balloon.page
>> points to the page that is about to be (un)locked.
>>=20
>> Unfortunately, this dual-purpose of the field introduced a bug: when the
>> balloon is popped (e.g., when the machine is reset or the balloon driver
>> is explicitly removed), the balloon driver frees, unconditionally, the
>> page that is held in balloon.page.  As a result, if batching is
>> disabled, this leads to double freeing the last page that is sent to the
>> hypervisor.
>=20
> Oleksandr, if you can confirm that it fixes the bug you encountered, it
> would be great.
>=20
> Greg, Arnd, on your free time, please let me know if there is any issue
> with the patch, and whether you can incorporate it, preferably in 4.16,
> since it is a bug-fix that was encountered by Red-Hat customers.

Ping?
