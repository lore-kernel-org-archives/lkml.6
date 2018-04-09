Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237325-2-4537511804397415875
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237324; b=hDLhIlBz+S9BSa40XggKlHMs4KTwXyuu0DEorf7gUjFeYDW7H8
    yR1GOouR8nmC+6hRF5F11JI5OS5Q7k7aHArMbUbxkW46wasf4Mabveo/G7T1Np0t
    lkGvAZ7yf2iG+ahwZR7xp/wod/mapQzaUCkmRhW0qV8qytTBCLSTDbjYhj7/xn3k
    2eYslKZaVFnrIvMHqhix4Coa6NEB0sn8Q5usVwB6aBefdZMKZ1u6xgQENaFiweH4
    E5prE9Rl4TayPepb/JEjWuOcyByrxVeUjuMWAEYYq2EVnbLM/igYU8Q80HG97YRU
    UX4SA14DIpYblF8Dr1ptOsiUFaG3Tae2V+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237324; bh=H92DH+tCFp
    8wj2EG1gSN812HooRgR8hNQLcsWc98O08=; b=igG8DgWXgDO9ISHQA0QZPCmbcs
    VNm2c3PKcPdblb3+gNK1Hu+Bc27zr/8S5VVhyCXwwy0bVHjcfW1qa3LXMgBwv7kT
    OfqU+cnmDoNpfVqPZTj4quQBRVtRrlVXBQT9DIHUmsZ5upgoFxUg741WPE238Aou
    NH5ykfvtI+v3aohaWVAv21SayTFcY3Xb7WuXx9jfyoBwS40pSoJLL5LJo0ueKhw5
    el2rZDX8bUgVmOaA1g12PoVwjJxB2ceo6HQ/wtotIqJgRydQ8M6LKBN/jQ9BNIvC
    IxYS5kXa3dinvFUxAYTiPTWiW3825kjEojefmOZocsyI62k32UVZI+ZNAd5g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MxGeDhsL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MxGeDhsL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJB7Pm9Pmjd9vdIyVfXwdhY1/6Rttx/X/iO+i6wsDq8yCwin4oKfMzZKbAZg+Nvdd1GvJdK2PhV+xlNjGQgqnGJzAFVnOE81/K9WnwZLBLq4sEQ+0JOG
    l9R7GEhQXJeqKyFy+s5RZLDYlCdHu4Tg+n/vZB0XYPEdSWXy0UhcyH6UAeL/GNzpDuxVzmgyaWNLYWNrtmhYfvbIEBZdi7SqpnNc8RG2TRVaSp8/gCRCT7An
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
    a=yMhMjlubAAAA:8 a=7AkvMd-h696VmKR_8ewA:9 a=wPNLvfGTeEIA:10
    a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757215AbeDIB2L (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:28:11 -0400
Received: from mail-cys01nam02on0106.outbound.protection.outlook.com ([104.47.37.106]:1992
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755698AbeDIAgM (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 054/162] arm64: pass machine size to sparse
Thread-Topic: [PATCH AUTOSEL for 4.4 054/162] arm64: pass machine size to
 sparse
Thread-Index: AQHTz5mq7p7+4O+tv0SXqqyi4pyldA==
Date: Mon, 9 Apr 2018 00:28:21 +0000
Message-ID: <20180409002738.163941-54-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:qdjsZJfp8WndL050CtBO5ndvvxE8/FyV6JeyoJewm9xiJYMAdqqF4/xTnZTIXtkXCaFmIzUTKIWr0sdTBitwOJ0IfmdMES+i/IJfAETCn5qCExaO2JIiEoxpbIVZvTmBwP7jm2drkiZrKcSCG3bQ/CokFWFqrJtmMY+F4F4dha1a9km3RLb/+eKrxqKN4mpRydmJ0h7XVNabORUQcJEvVwOOGvHSZXRvFANMeEnu4v/7voDIwk4d2HVQnerYVxo0;20:63ElV6MaPVpgUnfgCFS3UnwkWENskj/ATquQw3wHzG9HAqipFvGx0JxWEGfHJlwdyEyyR9rKjUTV7zvADOk5OAFAN/qDjWXD4FDCAOKOyQ3arUR8DvRXtpPrp5w/606gyaEI9oBYXexzSAu/TK6OVaCnqRyNJqGg84sZqOME50A=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90629a1e-f9c3-40b2-47e2-08d59db1e387
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015824A03C18482C75DFBF0FBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171)(85827821059158)(258649278758335);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(39060400002)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: RrCPQwGkR+Hl3HnfWSykzZ82FPSjajeSwJy4VFh+l6mQadn9TtMHGxDpgvaHxiD8mEHsAhp3eofVSbuonq9UWlop/xs3OQao3Mm4dDyozEdDKCGZfC35g1rkgfyMR8NrkVi/NYyFnON47h2G09kTjwIV1ZFIVb1uDRzNkFwVl8ttL4K0Acx/CUPpZqnoV7ro37cjMogdwtU+apt90VqmfMOGJhND99auXNGIR7sdf1hnUs91BC0XPs2XBFxb8pUgAixtvq530rIaiD4aBtKadJyQEez59hWt8YH7RkZcid+IvGX5doNs2jX8/FHp+e20X724KffnBnyvoKhdAJkf0UsfLze3Rn/LO218sMkLaETrsq/zUXUPFl847HEH+SZU5XoFqlTFOqTrFSXwTwSHUI1gtnGJW4+EgoDVyc9597w=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90629a1e-f9c3-40b2-47e2-08d59db1e387
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:21.6144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

[ Upstream commit f5d284900c0f960e318a063f4c40826b6e3aa6a8 ]

When using sparse on the arm64 tree we get many thousands of
warnings like 'constant ... is so big it is unsigned long long'
or 'shift too big (32) for type unsigned long'. This happens
because by default sparse considers the machine as 32bit and
defines the size of the types accordingly.

Fix this by passing the '-m64' flag to sparse so that
sparse can correctly define longs as being 64bit.

CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Will Deacon <will.deacon@arm.com>
CC: linux-arm-kernel@lists.infradead.org
Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
index b6c90e5006e4..119d1885a3c0 100644
--- a/arch/arm64/Makefile
+++ b/arch/arm64/Makefile
@@ -40,7 +40,7 @@ AS		+=3D -EL
 LD		+=3D -EL
 endif
=20
-CHECKFLAGS	+=3D -D__aarch64__
+CHECKFLAGS	+=3D -D__aarch64__ -m64
=20
 ifeq ($(CONFIG_ARM64_ERRATUM_843419), y)
 KBUILD_CFLAGS_MODULE	+=3D -mcmodel=3Dlarge
--=20
2.15.1
