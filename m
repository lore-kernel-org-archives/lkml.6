Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521479813-2-6819799352006254285
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
    t=1521479812; b=CYt2iVuQkae56OAG/Ag3sjew083lDYlCgmC/GrjHxEHlpXf
    cMSXtC7spIfHcjsFQG6NvtWjcxcTj82dkDKSN4ZP6b7zHJc9L77+S9L2tbLcDnVS
    O8TmunaV/ZYE6FqM1wXXpGsoMDP5R3GfuyF4o8w6dQwFdBMST/6ANZKlmjUG6RJB
    svPr84TKVe1zlJgnJvdRZcHS8f+xAC65I7xhIbkqmvjJZDjLKqOw94CTUsQmESn/
    o2Nspl9Dn378fpawfGdm4ND6pEI+vVSlbFY2g1siltpKpt+PCPSx6DX+82b7IcNl
    Nh4pjj0cW9mB8vYKWV53jBNffdQV1s1/3PNmWlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521479812; bh=c5tpB+
    KV/lHRBHxUIsXGhiRsbhIIE5oaX0lFaGuoj34=; b=YqcgeI3qI14nw0CcPX1flm
    q2NKHF6OvyvP6A84EflUcnnGXG+aNZvaOUILMGbj4NPB+kGd78qsdOs7P4MqerGL
    n6eU4sF/fWKZMijpy8dRhLO49Ny3EJqhpvKXQuxg9Pa3JwtqOF7m2oSf7TlpUQwq
    vfX0I14WZKVr34G657lua54bRvC6fhCjksPrCxs9owvfewj79x9Q6/zYMgxzSFOB
    3C9EVdtew7/pTp/F25qF4k74jAJWUaLCGY66FhpQn28FYghbidU+EEe3QsBcUm9Y
    YPlxDydGwczTntJkPr6hAA2Q5oiDrzUCxQis4gBi0DOZ72AL7JH2L0erLnn6+AYw
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dqsZKdTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeiledunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=dqsZKdTl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdelkeculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeiledunecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935125AbeCSRQg (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:16:36 -0400
Received: from mail-by2nam03on0106.outbound.protection.outlook.com ([104.47.42.106]:22396
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966543AbeCSQKA (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:10:00 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 106/167] rtc: interface: Validate alarm-time
 before handling rollover
Thread-Topic: [PATCH AUTOSEL for 4.4 106/167] rtc: interface: Validate
 alarm-time before handling rollover
Thread-Index: AQHTv5xklC2/db7GVk+SroYSM0eI9g==
Date: Mon, 19 Mar 2018 16:07:34 +0000
Message-ID: <20180319160513.16384-106-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0919;7:fTezmwy9CZD+t7/1UbIg0DX38Q//gZSRL9QIsmWf+Xnq+eDwPB0uUpCt8l9NJLIsafHtG6QF/YrjDq8Gq2ENWUUJJN1OzdBR9vXPvzgzoXw9G3NDnJjzRRvRqSANmNsGdapSmvI/GYqrovPseya7TbpbwSpi00mSOsVlHzp+B3olxk1ldE16G4agM/6WCD4IbQelT7A1OKjEklCHIMrrTBmSh9HEOkKh58nhp9tmBkfBZc/pQjv5jeJZVBT3tpou;20:Up+vbuEbkm0MRDxdc5t7nHdw5oEV5fULxBrToVuCOSpzGUm723C9y8qxwtJcZP2YZoU2/RJQyf9O+ZUcNUvOdE9Y8o9l0DI/JqrT2NXOOY6kr2dX83dxDZsY6uBNsLSsIRt7jfmFLQqUE1STKreq0SUm46zijqR2zNC09142PF0=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 99705bbb-ecf7-4662-11b1-08d58db3db66
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0919;
x-ms-traffictypediagnostic: DM5PR2101MB0919:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0919E69359CB52A6EE655B7AFBD40@DM5PR2101MB0919.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(58145275503218)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0919;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0919;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(39860400002)(376002)(366004)(199004)(189003)(377424004)(66066001)(575784001)(2906002)(86362001)(10290500003)(105586002)(8676002)(305945005)(110136005)(478600001)(4326008)(7736002)(81166006)(3280700002)(6506007)(97736004)(107886003)(5660300001)(36756003)(8936002)(53936002)(86612001)(14454004)(59450400001)(1076002)(2501003)(6116002)(10090500001)(76176011)(186003)(3846002)(5250100002)(6512007)(15650500001)(99286004)(102836004)(106356001)(72206003)(81156014)(2950100002)(6666003)(54906003)(3660700001)(22452003)(68736007)(6486002)(25786009)(26005)(316002)(2900100001)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0919;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: KReLlMAJwBNA02FILID1rj1PpxB2VXGXwfM9EWT4J1vKKklHqvqk+TzcueTt8s9NPvH8O/QosnadDEm+haP+fh3w6nnVawniMyJoXTzHR6NNngxy7wIyg5a45IvKgyfweqkgYStVAYWjgNvKpGWaPwg717w74zIQWjlz/iLq4DM1dmFJpNv5qooZF4XbEigee8lF9pCh50Zl5j3zOGxsSACIKgQj/GiDuMMWHsx1Gb9Okhz+KiH+KwUISzUpzLrU8tNE/WIIMcvW+zviSl4sgDPYDHC/bIrC3CVMT0iOVRlZ8N37kBNLUktgdMuY+Ix2iZwdns3444K+ZX9ES20m9Q==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99705bbb-ecf7-4662-11b1-08d58db3db66
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:07:34.9694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0919
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>

[ Upstream commit da96aea0ed177105cb13ee83b328f6c61e061d3f ]

In function __rtc_read_alarm() its possible for an alarm time-stamp to
be invalid even after replacing missing components with current
time-stamp. The condition 'alarm->time.tm_year < 70' will trigger this
case and will cause the call to 'rtc_tm_to_time64(&alarm->time)'
return a negative value for variable t_alm.

While handling alarm rollover this negative t_alm (assumed to seconds
offset from '1970-01-01 00:00:00') is converted back to rtc_time via
rtc_time64_to_tm() which results in this error log with seemingly
garbage values:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

This error was generated when the rtc driver (rtc-opal in this case)
returned an alarm time-stamp of '00-00-00 00:00:00' to indicate that
the alarm is disabled. Though I have submitted a separate fix for the
rtc-opal driver, this issue may potentially impact other
existing/future rtc drivers.

To fix this issue the patch validates the alarm time-stamp just after
filling up the missing datetime components and if rtc_valid_tm() still
reports it to be invalid then bails out of the function without
handling the rollover.

Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/interface.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index dcfd3655ef0a..c2cf9485fe32 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -217,6 +217,13 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rt=
c_wkalrm *alarm)
 			missing =3D year;
 	}
=20
+	/* Can't proceed if alarm is still invalid after replacing
+	 * missing fields.
+	 */
+	err =3D rtc_valid_tm(&alarm->time);
+	if (err)
+		goto done;
+
 	/* with luck, no rollover is needed */
 	t_now =3D rtc_tm_to_time64(&now);
 	t_alm =3D rtc_tm_to_time64(&alarm->time);
@@ -268,9 +275,9 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc=
_wkalrm *alarm)
 		dev_warn(&rtc->dev, "alarm rollover not handled\n");
 	}
=20
-done:
 	err =3D rtc_valid_tm(&alarm->time);
=20
+done:
 	if (err) {
 		dev_warn(&rtc->dev, "invalid alarm value: %d-%d-%d %d:%d:%d\n",
 			alarm->time.tm_year + 1900, alarm->time.tm_mon + 1,
--=20
2.14.1
