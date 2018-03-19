Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493182-2-2060442755868475143
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
    t=1521493182; b=kIq5QapBEXmzZGIuSAijeF3euyWxE+I+Kw9jEBaNs3o4Jdz
    FQ+82e3j/f323WlTbVi1vJaPT5XEmzErEsPUIVBbVwN/EOnSDblDBdPVjZmPa/uF
    4cLWOAz3ugqd5YA37aMJKjo+RscqyeYslfQPwMaz2hqT5EeYvV4W6W0+HtDDuEEl
    kcK52zb7OEoPkq4A3ENxmKsYlrdv1EHdKpASDCgCvUh1XXNQSwEmJe+63wwypKxb
    NqgdXcSzXhEF0g/edNryBLhnqrJxUnZDuMV3IYRWR9QgVE7XiDSkqmbx+ynFFSNI
    MOI7a/GTAJRmE6i9U8a5qMrjTHIi8UQ6EDKCbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493182; bh=hwhQTe
    KyykvtcjLwsND3g3XHHDvIU1QoLUjeFiqXWlc=; b=AEfD0wu2CEb862sqjBsp3F
    SWEeR9vg77GNO/KR4VrvGjeRAwkl9kglJ6hqS3lu4jg2QrZMw7ZzDhXY8jwggjFK
    AKHEo4WKfPJR3cOz7gG1I6qPgYzu/trRpiaVkIH81MtBasWgiz1KTPfHml38jlAD
    ruEg06gzmRjJU0P5+uWxuBOaJs9hQWIeBzqXwNp8oYx5VKanDyPRkbW4juK6aRt/
    DFvj77nvR3amqh+/SJX9njq1PV8u5ddsW7jm8g0ohvF7iaRzV9ziheMoaayQ4maH
    HkFWUnFIPqku7iUebkXzrh8oCeBmoOQmpcOl1iQ47kDvuA63VUOwke1+9IzywfkQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hSW03hEc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieelvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=hSW03hEc x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeegucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekieelvdenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965514AbeCSQDE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:03:04 -0400
Received: from mail-cys01nam02on0122.outbound.protection.outlook.com ([104.47.37.122]:7795
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965506AbeCSQC7 (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:59 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 167/281] rtc: interface: Validate alarm-time
 before handling rollover
Thread-Topic: [PATCH AUTOSEL for 4.9 167/281] rtc: interface: Validate
 alarm-time before handling rollover
Thread-Index: AQHTv5uA1Ehs8iDWeUq7WhFB/7XD9Q==
Date: Mon, 19 Mar 2018 16:01:11 +0000
Message-ID: <20180319155742.13731-167-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:TW2YB/c33ZARIeHydteb4ve25PKHXmNsAlXnq+U1z9fm9odvhAHQRj7PQksXmFnHI1P7Fx0nR1pm3GmdR7X/lqZRZIgsBxXcjPV/AtiDbTw5D7gykgsUKVRb+96wQdAUp0dyjKuKysKSaYRziB4WjVoTqmUGKLvLTBGaHwdfh1x7jjdcwpmAlTahjrr3RfLgMabN/k9du3QEhJIc6jEWmhvROX6V1aBDDUyun75SFx2Zv2zNapa/DVrokKs8x56z;20:rlLpWEXxsESvZSbVofGz52TKmEI9q256YLoXkGQLvpCgzQvKs2P1pEClTbtuLYmGOxCN+fQh3mDWoATCJ/lAEZv/1qjH67TLKI3MQ3+hPHkbG0ou68IKYDt1XC047/klneEKZ0KPLPQBg8O57RE+xUFtWc/gG2jJeaVkouP9rwE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7e8bf992-f224-45be-23ed-08d58db2df90
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB07252234024828417C486D7BFBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(58145275503218)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(377424004)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(15650500001)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: AgHqqG83zl4kiX5cr0SvTjZTXccQvWruxpyPRrkkyel8yXWrXX2gjNBq6G5QqhCjg/RMJCTvXCiwsHTjXPd9k2tMvCi0y/5+B+X/HJEpmRTSyb5DVa+Neij0Mdlug7ryUn/h2zjkgqM1mCUfAXcrJh6uAFoEkc2U0Lx/56ZU4CKSKMskdjAorOwgebJiBRKzwmQ+SuJtQsaD1htDZMR1szE8/uoSG48yg7FFMc30UG5nsHr70ZgXwW3A0nkRFl4q16WNGzcrYIjQzKRGgrXgnuT6xH047hvc3L4X/+JFGtaEtkrGLPrsoLInm1wGZvjeWDuy6h5Sg+JrVYFw9rY+9A==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8bf992-f224-45be-23ed-08d58db2df90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:11.7041
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0725
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
index 6ebd42aad291..25cf3069e2e7 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -227,6 +227,13 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rt=
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
@@ -278,9 +285,9 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc=
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
