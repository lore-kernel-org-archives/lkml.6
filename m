Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3205673-1521475184-2-4085358827419406457
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521475184; b=MLSewJqWW3/9WvDkTnUXUb+K2Iqtzr3lUsguuZTmFV7oM7D
    A+pJ0CFVUrc6M9rBXwHWBjQ2VSh0gtRaszfOYbrIvKWsMduM17bdO7J8hporzk3A
    gGLfOMK55qcxYoLrd+S9xD3VTEaa/SjLTNjQfBghwA7vNLE4WdhDA1a4ypNA+sLO
    p3bzcDKUdP7PlzA+dhbAEAmFmWdzyHdLeGDCwJOQJQIA8VDpmGtcrO4r94sWq3Y4
    +KgDvui0zu3s/AE+Cawm36e4KzPIzgbhmqEWOpauELRwaKrBLmzTCuJI6oitNqfe
    UaklLnR0fSE4bKj0/dhJdOj0YiwE5BXT40NdsxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521475184; bh=baoVzq
    HkHKiPHQVSi4rsC5qbvGokiR7XBUOR5KyGkVU=; b=DeTOg6Ln/zOFbbl3cleKch
    ZyYM9MlYk9//AXVyNFPvOJ4r/oiPdkJBRZV5dZzuOsHTD9WIyujW8YeDtaTcdM9w
    E8J5NnIoILsW1B0jL9sV0L3+5oUcmbYETjhpcYmvgyW4C7nTv8aDB0juCGWb8D3f
    DAkFYsLrBFs3c4yA943aBnrpF6LDAPDZLgkYTbRk1YwLGe8sMcuCcxD7aZEN2eiw
    ezdfAbzJ0LT7AKkm54K4ODVDHv4n/p7J2u4U+761A6B5r28JBmQa6SoqWDYqU+wr
    +0oPq2L8rqG0HTW8ylQhiZ40ZbXuSMr5ypd1aW71nLATZAlosiDBLJFT4LjmcBUg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cq1cdL1X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegfeeinecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Cq1cdL1X x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdekvdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepjeegfeeinecuvehluhhsthgvrhfuihiivgepjeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965145AbeCSP7k (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 11:59:40 -0400
Received: from mail-bl2nam02on0101.outbound.protection.outlook.com ([104.47.38.101]:39744
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934782AbeCSP7e (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:59:34 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: James Morse <james.morse@arm.com>,
        Christoffer Dall <cdall@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 057/281] KVM: arm64: Restore host physical
 timer access on hyp_panic()
Thread-Topic: [PATCH AUTOSEL for 4.9 057/281] KVM: arm64: Restore host
 physical timer access on hyp_panic()
Thread-Index: AQHTv5svBzn4Xim3O0S0u5aD8M1vIw==
Date: Mon, 19 Mar 2018 15:58:56 +0000
Message-ID: <20180319155742.13731-57-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1109;7:5cq77B85bFJ6WOPvkbeS1TDnDBrWELg2cCKxzU8xvmO5vySnjyMo4fzhFqKQ/MtB9I6zONC6MIoKrf86/pdqK3e8uuH7IpNomvgu678HT9E4IEIZZXz//SWs8RMzU1QNd6vcsYzM3KgqEr00le53Hscxmy39WAUoLb2z8SuuRfjVadEDQDJJaL4I6INO8I8+GudRoavlVy18hIp99TdJQFRSDoUAqImCW7rzqAI8RLALzM/YAwfUMxiiAuy6sfrs;20:9dJzMqfPyyger42qdt8gtWJSNrltIdSQRHf8JPT7t/8YZllmgOlFwxFXQKtOg0d2ib4DgrbpWYVKmihwebObJpzLHoqF4FiaoiPKGJywieXDhYWi7NJFwV6MgR6HmdSZJBJ/Sid34OhB3l9/xZNWORGrmehttHZ/ZcBiO92xJRs=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 55e37cf7-f870-404c-9759-08d58db2613c
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1109;
x-ms-traffictypediagnostic: DM5PR2101MB1109:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1109FEEEDE741E48953C69FEFBD40@DM5PR2101MB1109.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB1109;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1109;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(26005)(316002)(53936002)(6486002)(6436002)(7736002)(305945005)(22452003)(66066001)(76176011)(6512007)(5250100002)(10090500001)(2501003)(99286004)(105586002)(110136005)(54906003)(186003)(2900100001)(4326008)(25786009)(86612001)(5660300001)(86362001)(8936002)(6116002)(97736004)(3846002)(36756003)(102836004)(1076002)(10290500003)(81166006)(8676002)(6506007)(106356001)(107886003)(81156014)(478600001)(72206003)(59450400001)(14454004)(2906002)(6666003)(2950100002)(3280700002)(68736007)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1109;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 7uuzFwIFTe67jTEMeuASOG7fVFOTddd3+EQXvY++iGTZaE7tHVfyG6Av0HF7MP6IgB91UWfkXXbIea7aCQMfeCgTI86t3/DqcM574GjwRUtYhDs4mZrDTEHfCYrAvOzitu1FYNEAG/5H6QJFKcuHBv7+zyVdsSpUh8FJ6YkwAAp6r68Pb60iQ/Yc5yQO3ECM+/Gom4BmA/ePDHB2C/SpRt/t2yL7AvWzD+0SuKXvjtd+I97M7Mnagji2aLqpzPaM/pzxUo//Rtq00ifCYXCU7TE2ILpF4FvGgCDsqSgtBrZsUl+80+FB0l5dkiHzLsuhHJRTgUpP7U95Jyui1OcBjw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55e37cf7-f870-404c-9759-08d58db2613c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:56.9759
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1109
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: James Morse <james.morse@arm.com>

[ Upstream commit e8ec032b182cd4841605de4fc297a8edffe55972 ]

When KVM panics, it hurridly restores the host context and parachutes
into the host's panic() code. At some point panic() touches the physical
timer/counter. Unless we are an arm64 system with VHE, this traps back
to EL2. If we're lucky, we panic again.

Add a __timer_save_state() call to KVMs hyp_panic() path, this saves the
guest registers and disables the traps for the host.

Fixes: 53fd5b6487e4 ("arm64: KVM: Add panic handling")
Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Christoffer Dall <cdall@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kvm/hyp/switch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 0c848c18ca44..9174ba917d65 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -404,6 +404,7 @@ void __hyp_text __noreturn __hyp_panic(void)
=20
 		vcpu =3D (struct kvm_vcpu *)read_sysreg(tpidr_el2);
 		host_ctxt =3D kern_hyp_va(vcpu->arch.host_cpu_context);
+		__timer_save_state(vcpu);
 		__deactivate_traps(vcpu);
 		__deactivate_vm(vcpu);
 		__sysreg_restore_host_state(host_ctxt);
--=20
2.14.1
