Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3372889-1521480909-2-7820796282168414809
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensv, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521480907; b=S6hQVwc1wdhdmN1UMpADUaCQpxVNpZk9r+hYeV7s0Pn2krn
    TWXrtXXTur6g9x2msfj8mIXiLXlKEGo45v8BcQgQDUsRWT428mhwwTZE54Rk1rqm
    Qj21X77ySNDERY6vN8PzaBEAqPq7a0abEkoQIsv9Hgj761CP+8ucJOvspQZxLrnx
    QDDJmINAFDX6N5S4vpaVbTA+MtIIfg34Tocho2ftPnCa2hRJuN29oOjDafAotY+I
    3SZYfvg35Os/0lV3sV3NA1a5pmNrbchrs4HNe8y0ufCfOiob3nS+W3nj9Wr9uqiT
    8JLweIbqSyf/Wh0PYfCN43eSrjJQ9AZzN1tbZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480907; bh=fSpFtg
    2XItv7LIFnoQBYwkDJqocJ4PF1TBgUFcNeyUY=; b=oMP6DVI1noB2TSRs4uFvo1
    GFAPzFQgbJn0gUY7IW6wEQHvzaHN7xS9vBfFF2uouwgRU2o8UX8K8Qstbnc0ktbl
    Bw16Ob6y2qDwnBRd1sQgfTev8MtyrmMsBwDFFx1QhsG6qPXyyFMwLx251FnjJznk
    XgdEpzmF43djJALcYyBCNZCwWYCXmBr2AHSF4WSD/iH5tWseBAPDHD/52BeRE62W
    jXVJQXHx2mXn5Hpos64HGesS4gjRMBGavXx44PTUk4oAoKdRUPKlI+L611HTXRlb
    q2Qs2H9I+JsGCodL0hvGmZwSeGET/JOMc2hm0yOzqIuaQ4Z/nJLDcQn60ucZEc5w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dtJ83YWr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dtJ83YWr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejudekleenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966043AbeCSRfE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:35:04 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:31931
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966040AbeCSQGs (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:48 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 011/167] ipmi_ssif: unlock on allocation
 failure
Thread-Topic: [PATCH AUTOSEL for 4.4 011/167] ipmi_ssif: unlock on allocation
 failure
Thread-Index: AQHTv5wc0c5C8rHvgE2762CrRsKosA==
Date: Mon, 19 Mar 2018 16:05:33 +0000
Message-ID: <20180319160513.16384-11-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:rex7VTApUcX8FBBPvsY41U19ExIDSOzrVYaYBKWQNcXi9y4ZtjOylFX0rwWYaDIzYtpSxIRZdRNO6Wxw6JVOSK+1FR1UV6H5cR2/GU5RA26zw+yG2tjvrSDjvPfu84Wc65y0ly9OPKPJibAlcrMeANJEkuPb6mkx6hMk5Tr2+GjBmFwNOU5AP/qOkJSg/4UdpSbIK2TDZeXDm6hzkzxvkjYVuSs1iOvApw0Gh/pd7ta+qEKsnxkcYJFF7gkCU6jG;20:ELb6bRw/abMOWTPKqpW5sGqjyjYCWCqg2aBDeEflJ9Gi9i0avVE1WzZ0iqUTLiJjnJR2X2Iy0C40m2e09AEnUyDZvsZCjiZ/nZkRRC1doqOqaaCrXlihvn2yx3CeSrt91+Y5+eul/y0g8cFQb1PO8Qmi7dFNiEXd53WxVp+78vc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 461d07a0-e5df-44fe-5d25-08d58db3694e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920E31786B02681F5027DEAFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(6666003)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: CV38iIEw/RNQR/Vrds/uN1dUbJhbPFKmutt9YOOASC5MmreJ6yXOFrMLJVo5LtawNvUZTwf4VU+OZGv0GIE+k4y5+5Uv48h1MpEV+HSkFLCRj6efKppv8v5CLGOruNO8GP0Omx3eai6/j80fR+ntKhxDcPkNeiQdDU0N/76P/31lRxMKVzhdOIyZYGI2/eEMVMhsiVzKqwLOK+SXX7SbfXnCJ+PYwMEugpTYPC3XBzXA8axcw3gxVKfDIhHWhp+k2MgMyLj3EQj3I4p/vUy6noTP8xS0Lz3ISmoJBadMXf6l0wrdstJH7N91bRKHSueiiEdiFr1ix6PCUe+Zc3qiow==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 461d07a0-e5df-44fe-5d25-08d58db3694e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:33.9767
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
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
index f53e8ba2c718..83c206f0fc98 100644
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
