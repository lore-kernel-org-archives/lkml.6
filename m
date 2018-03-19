Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3827928-1521496082-2-442871824786611412
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
    t=1521496082; b=gWmrHc0gUibHppRKezVog+hh8i7XRsyR2j8+IzzsVw2dtVZ
    IEJYLoPYlBMr7+ZhsgQKuinSG4TQhs9hkpP1+svxhIf/d1Qte/gzDdZHr6ssAlvE
    PIp7/Yv8qc1psYC5coBHumuj55Kaw2Nlnj39s2LQK78Oq33h1YNTXtNdJq3zBb96
    hL/cmOPLupF+YsQkdmwfjQRH3Q8DZ2lnlDdGHrwkheP11QVkPOI9Lb0YSnC8C01B
    31uiqCby74Jok4qEDdxJydudh52mPCILS8jIITIQqxx+TfMufn/S+Ci9WzdejxK9
    /J/OV8USjoer5hqEibn4jWi7MiYAFBgHUrF6k+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521496082; bh=qPV7S/
    LuHhLi2DLFkkFso6HPcQ4cWKR5dt/ztJowHkQ=; b=ZN68qTFhusLoxbAkLVCseZ
    3uQWnUO65g6Yz9jkII2PqjqKWdwbalR4PoyUfPTCf8hIn+3jjEwSf0iwIlPGdwW9
    cZTzzHXbEKB5lcIlMANP+q4zfVsbezRSb2vw5stM45eEgrPNRVhVMuRed3uo27HO
    3hOmL1Y8LlgoQSricxkPyxqEnseLhB1LRBHMxz5y0iXpoTdy8GseEYkiP8zn/gyI
    LeKAyGgZg2QCpjJ8pFvv44ZLphgs29XAg6L5f7Sf47NZohbeXVTGsunAt9DylYki
    Wj8GEPUMG1s5fVJhadqBEhmPfP/f5t3XfEmm0DTIZglxMIfR07d5GpJv1wG4cOhw
    ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ybdza2zW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ybdza2zW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduheegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudejleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934807AbeCSVrQ (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:47:16 -0400
Received: from mail-bn3nam01on0122.outbound.protection.outlook.com ([104.47.33.122]:16414
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934756AbeCSP6T (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 11:58:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 017/281] ipmi_ssif: unlock on allocation
 failure
Thread-Topic: [PATCH AUTOSEL for 4.9 017/281] ipmi_ssif: unlock on allocation
 failure
Thread-Index: AQHTv5sTyNRb/lM8HECXuLSSs11MPg==
Date: Mon, 19 Mar 2018 15:58:09 +0000
Message-ID: <20180319155742.13731-17-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0726;7:+03hupvM5KL/j3otqZMNSER884Y0FZdMowSZr0WUhRmG17xVfd6NJHt+UH+5lhqdBPyPfTFjc2scaR3ScVv6UbpjA2EhHvwvQk/45r16IIEf2cH0hvDOxKAhwoqgnYFlhDgTvdhEvX/QpBV332VBmULDLvrJJe2GlglL1UpSDbL7aqgzCQ4dOhF4Muz1+Te1VcTl+DiXt/JkWP6l052WuhjbtvlWyHtjRhLvIZ7h9MQx/oUeKszt51EUEGYC+/qX;20:M52uDItl2vB6cyTF6Omyd7InEUaTn6YXp+k4MZElavKWP8jg5YMP6EWieESRwin/b68GBW7RnJ781//UkZN9U81e39qBMypBicygPK2DchQ5K/6IyxUkq8berxyJXW3fRjorCd5g5q8Sljf5lH2hn1VAU3cr7rq40NMi0mFpUyA=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9a8951a7-6c12-4614-45b0-08d58db23756
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0726;
x-ms-traffictypediagnostic: DM5PR2101MB0726:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0726CB6E96AC5B82C6C3465AFBD40@DM5PR2101MB0726.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0726;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0726;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(396003)(366004)(376002)(199004)(189003)(81166006)(22452003)(2906002)(3660700001)(10090500001)(102836004)(53936002)(26005)(316002)(14454004)(2950100002)(97736004)(54906003)(86362001)(575784001)(76176011)(110136005)(99286004)(105586002)(7736002)(10290500003)(66066001)(478600001)(5660300001)(86612001)(6512007)(81156014)(36756003)(305945005)(6506007)(6486002)(6436002)(72206003)(2900100001)(2501003)(5250100002)(186003)(1076002)(3846002)(25786009)(106356001)(8676002)(4326008)(8936002)(6116002)(3280700002)(68736007)(107886003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0726;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: DC1pYROrq8CV4OzBB0CIbPe4tHjzpgUrtXhplnKTK/pOArFXNPh+06OVEtHGnyxAdldmuSQTNFtH0V6guhzBU8InCbfwj3js7EtNU8KXclc+GQNnq4SRjASDQJmXHISGMTjf9mVsznaKdYqYUij6VWWte5Xfsk+cEhstLIYJHSeYE4hnyg1j+83BlsYpdL9L7GrQ8KePfFF6fIXiZ7YxZk3F6tv9+MDSW2OSIIkb8cZGHfdDhgprC7UDreU/gVjr5mRPOIM4XV2aroAz3dUXSdPriK5V+w8pUhW8qYeV2iAMTDuQ4E57DSDaDAaPTgxth5mWYf7XdJrMKlL8W9k2CA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a8951a7-6c12-4614-45b0-08d58db23756
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 15:58:09.9077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0726
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit cf9806f32ef63b745f2486e0dbb2ac21f4ca44f0 ]

We should unlock and re-enable IRQs if this allocation fails.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF) ")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index 510fc104bcdc..f11c1c7e84c6 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -409,6 +409,7 @@ static void start_event_fetch(struct ssif_info *ssif_in=
fo, unsigned long *flags)
 	msg =3D ipmi_alloc_smi_msg();
 	if (!msg) {
 		ssif_info->ssif_state =3D SSIF_NORMAL;
+		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
=20
@@ -431,6 +432,7 @@ static void start_recv_msg_fetch(struct ssif_info *ssif=
_info,
 	msg =3D ipmi_alloc_smi_msg();
 	if (!msg) {
 		ssif_info->ssif_state =3D SSIF_NORMAL;
+		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
=20
--=20
2.14.1
