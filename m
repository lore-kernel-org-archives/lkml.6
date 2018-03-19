Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3274576-1521477498-2-899852791897631235
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
    t=1521477497; b=TzBq1NcQWwxxWh95AMLh1Tngi+FBZBY0BCQT7bFPgV0v9li
    kskRr6HBoiI7VKWRR7SBMqYPe9TOwU+K1xMvGsFp0A4SMlAvkOZlR2Hl49I4JmFW
    gg8t6DJSNUhKMAS+KlXM6MBG+djj5RZZ3YJHYlAWk5u9f2Ljxr5vnNl/A+7qQj7l
    raGWW8mUgGr2IL6VOyXi5K0mzdraTHbB+bcdb76GX2JxU2RnmmSw3vpaKNo4GqlL
    bRKP8b+hNIRdfa/AOTa32btd3cqjXD7qil9ae9qb5QRFVXlf91+kSqTPuwiLhSo6
    OARg/ZBthJ9tVUmFHVREhQ2vf3v5eK32JgSdb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521477497; bh=n3yZD0
    T6Khi+4wb9yamjdk7TNRkx3Kg4sziPIqkJiyE=; b=D5bznXLvLy5XcEHp3Z411Y
    +bBkE08twFI9jArtz/lOOGFmakAjNiOBOhV83nUXDZGdr4m/PCOvQBcr32DCilwZ
    zpq0wvhoSLd3xNw/dCNIyapK8X7r4n2VYIcD/H0WfkRbnF5joW0fY2QphBm4M94w
    g8Hvg6r/7Xo/kkmn5MxKZbDE80vIDLEwZ2eoVx4dvKuAPc9xjm51i3o3HdyM3gsu
    mq+pbfOmA4cr2mMNyPu7XzwdP+kG1AT26JLnxk33LgjN3JY8rU/UkqJSwQayef/h
    VGJGZWpIMyuEzilsATEc76zas0CmLoEjukdaKlN40IIP5CK858FWOiMOXokG0Iww
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nEb5s8nn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeikedunecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nEb5s8nn x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdeltdculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufhtfffkfhgjihgtgfggshhpjeesthhqredttddtudenucfhrhhomhepufgrshhhrgcunfgvvhhinhcuoeetlhgvgigrnhguvghrrdfnvghvihhnsehmihgtrhhoshhofhhtrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdehvddrudeikedrheegrddvhedvpdhfvgektdemmeefugelsgemjeelvgejmeelgegvsgemheguiedvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepkeeikedunecuvehluhhsthgvrhfuihiivgepgeel;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935642AbeCSQgp (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 12:36:45 -0400
Received: from mail-dm3nam03on0123.outbound.protection.outlook.com ([104.47.41.123]:2048
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935281AbeCSQNU (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:13:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 059/102] rtc: interface: Validate alarm-time
 before handling rollover
Thread-Topic: [PATCH AUTOSEL for 3.18 059/102] rtc: interface: Validate
 alarm-time before handling rollover
Thread-Index: AQHTv50cOe/IVEVlcEuChEDrmsCFKg==
Date: Mon, 19 Mar 2018 16:12:43 +0000
Message-ID: <20180319161117.17833-59-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1032;7:6e1SRviulxRWt/BQzGnqL/omMYJLRwqvNW34+mVAKv2CJz6fJL6tK+X/o24McohtNRM3k1fzdGYLYuasnE9zW6c3ldBRrX0YXtLkQ4Fq5nWU1bHPrQMoapHlc/QEdIwvFAxymrosb/95PhCZSipHuFQY57aaf8k4Jdq2DBoJ7gehooT+F1115wckkX/MIO1zmuGKPT0guTQOKvaTV7T/guNxadooyKuFbi6vmk7SRipHa6GsJtQ1jVuj72QTfZy2;20:oDL/JDTfvOdrF38CSNc2Md0D/aU27630fzinU4KVy5+0Vobi7FZBsPOZq+S6J4mWlBs+B0DW7dyg+fL/UpHT6KkaMoEpr/9qiWhopdPOsW9tNgFM5cTX4OOJMckzAs4E0hCE3rk6XyCoicTdS/a7Gl2ZiioJAxwG6mNaJ2J2xMc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cd2b4701-1da9-4f47-e9ef-08d58db4529e
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1032;
x-ms-traffictypediagnostic: DM5PR2101MB1032:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB10322784D18AC0DF6B12034AFBD40@DM5PR2101MB1032.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(20558992708506)(89211679590171)(58145275503218)(104084551191319);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231221)(944501300)(52105095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1032;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1032;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(39860400002)(346002)(376002)(366004)(396003)(199004)(189003)(377424004)(3660700001)(5250100002)(3280700002)(8936002)(3846002)(6116002)(1076002)(10090500001)(105586002)(72206003)(81156014)(8676002)(81166006)(2906002)(5660300001)(97736004)(2501003)(36756003)(15650500001)(6666003)(2900100001)(14454004)(6512007)(6436002)(2950100002)(53936002)(4326008)(54906003)(305945005)(6486002)(25786009)(68736007)(22452003)(316002)(59450400001)(6506007)(86612001)(66066001)(76176011)(102836004)(7736002)(10290500003)(110136005)(106356001)(99286004)(107886003)(26005)(186003)(575784001)(86362001)(478600001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1032;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Sau25JYvAPr43+a4HJEeRKOelfAX5QQn0Np8/ewolF6EqVWPZaKsiUKWD9S4/P1eXNGB25FoEVAlORPHsnzxwPx9uVV1qiV3uY85MTHAHwAEmzA6MqRhqx6iO0OeNSLzKzIf5T0nyRFFrY1dypyRXEkk3dt9HhVhD2WA0UqwNbxxpxLsNop8B99cJ72/M/UVqYAGPoluJNmpciEm/IK9kVuF1Tfn+6rKC0TGQ9mF/v6dnqVflo2UsI0HapGxYgIYKvUSoJKV1eUUArA/1j95Nw+7gU0ce8al96acKvW2KVh89BpS8GayxIqudtKf8ZtvZwj/LBKpVAHuNNpSlbgM5g==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd2b4701-1da9-4f47-e9ef-08d58db4529e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:12:43.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1032
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
index 5b2717f5dafa..d4153892c120 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -249,6 +249,13 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rt=
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
 	rtc_tm_to_time(&now, &t_now);
 	rtc_tm_to_time(&alarm->time, &t_alm);
@@ -300,9 +307,9 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc=
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
