Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3764808-1521493285-2-10240732773506946785
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
    t=1521493283; b=J1rs2rAzD8pomRyAZfNhZZAhT3dQm0fQxLJ/PJnJnCTa0fg
    KFtpd13dlRcaOwTIl5qV2zmITO5A/UwwXfqAodUe2enp4ubuDQwae/QIXelmjo/H
    tIAfqOsSujExQcO2OqtsG8R6aGJSgE6fOS+WppngMK/ClvA7kRm1cS7Djl5wTVe7
    skiZ7iB/xs5JiY8ORPJtesdVfjUkBFRovu7d4eU6NoAHGkmDzDgnQc5qLYXDBtvo
    zMogHhlyhjHY/LW7GMCfR3tXPIot0g7FbtHyZHvX2Azy5zhsHXFpiCJ6Gz7p+qif
    qqFpglZKAy0aA1oqs4k6cBZyGsB3Fd2DuHIFfGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521493283; bh=gL/vuB
    L2i5wx/elN8DGiChw7CtjI/kaG6O77qYT3Xws=; b=MYnNFaFP2+F1m1+yI/p3/V
    K/wJsKH3FXIVY8RiFhmKMHXHgm5H1raoF9+FoxlJrsMrjMELTiFb6WrfXDTOsikN
    IazBB3ufUq4Cyzj60JwG0p4HlAwZu6fmNxaRzP3VX0glVe4sKAx+p94SZWlxNF2U
    Pq09CCG2nQxjx2CS8/tTscTT+M+nJup9xoWCsYLwAe4jfAnQxjKDptp8Zm+pDUqO
    TawS3YtcYcys+DajeAsVakq5CFOaua26Y2yKjlYJK5rUi5q3GQM8LJUMFk3LrpbE
    QYyxH2AkG/1wfVGW1FxVWWCfBu0Kob1xfgYm47CJNvKH1gdwMK4Fm289Nu8xNgag
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KVzU2lYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddugeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=KVzU2lYW x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddugeehucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeekuddugeenucevlhhushhtvghrufhiiigvpeduud;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032281AbeCSVA2 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 17:00:28 -0400
Received: from mail-sn1nam01on0099.outbound.protection.outlook.com ([104.47.32.99]:27264
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S934836AbeCSQCz (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:02:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 166/281] rtc: opal: Handle disabled TPO in
 opal_get_tpo_time()
Thread-Topic: [PATCH AUTOSEL for 4.9 166/281] rtc: opal: Handle disabled TPO
 in opal_get_tpo_time()
Thread-Index: AQHTv5t/N6FJf1TwO0uPeGAAykZ1xg==
Date: Mon, 19 Mar 2018 16:01:10 +0000
Message-ID: <20180319155742.13731-166-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0725;7:DSWf9o42TXLxkIIwOe0UCMru+xi1xjXGJc40Ss6gex++EKsqwjAXjA/05yWUEoQkF5WRqDYo5dbn6xKXPwzksyJ09yg5Qj3SvyEne6LdZWz6JhKAhWrT0WINfEAPWspuvWmSDgLPHZMajstUD6djg2hWUa0Yo0cRPc71eShlht8rk7aN2nTb+9PZ7rQtdtbVx5ZZaw3voFbXvrTSIBSxuYOydwe00ZNhbB00KoKova6v0qtxhyRoBwFWonZCxxG3;20:/NxuLX4VOs9lS2AnI0Lq1Tmb0a3ttLNxFNtuH1a0xFS58D9d7kkkBnY1/8jd96yb9T183XGBuD5Hezxthyv6Qtt0kvx58nYleGSwYek+LEsSNGwz+TgbfEVqQzdCPWXbdeLbMzGpGLZ5i2zGyv7bitzsKhtLupBbu9q/+AUpDtI=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aaa61ba4-18e5-4e02-8a06-08d58db2df13
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0725;
x-ms-traffictypediagnostic: DM5PR2101MB0725:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0725CD3BA4C9E1D0527A1B41FBD40@DM5PR2101MB0725.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(58145275503218)(104084551191319)(211171220733660)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0725;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0725;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(376002)(346002)(366004)(39380400002)(377424004)(199004)(189003)(2900100001)(4326008)(54906003)(10090500001)(81166006)(316002)(2906002)(14454004)(110136005)(107886003)(6506007)(186003)(81156014)(22452003)(68736007)(53936002)(59450400001)(3660700001)(478600001)(5250100002)(2501003)(99286004)(36756003)(105586002)(6116002)(3846002)(5660300001)(72206003)(1076002)(2950100002)(6666003)(305945005)(6436002)(86612001)(66066001)(10290500003)(76176011)(97736004)(8676002)(7736002)(8936002)(6512007)(102836004)(106356001)(3280700002)(6486002)(86362001)(25786009)(575784001)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0725;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 9+RvBjfdN0+agvKntRKXIaahi64zL+ATbUYY/YHVLzPokrHedi9bag0uYqHQqs7Q4sBBsKx46REkCmrg8+Yv3otMHMOTCs9PBiXzdeRU08q9S0HFaKGqStJKrjNNes/HbDezB4WAwfQq95RokjhdyDIVXxNwMOxcdrCW2W90bxBEtR47TqPe4452bglnWFRmJYGd65W6RZaOSqm6oAvBJ0/ObPa+tiIZp8rTnQzdyJYi5BGpIRuoYutM5hzB/oBkmLvfnmNhjl/ynd7fUPIqwKu4YZglynAaW6ev3CZZeE1p9EhEXmrfJX0ajIEg8eMXEZMWU+6F7vEcqtPFet+yUg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa61ba4-18e5-4e02-8a06-08d58db2df13
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:01:10.1190
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

[ Upstream commit 6dc1cf6f932bb0ea4d8f5e913a0a401ecacd2f03 ]

On PowerNV platform when Timed-Power-On(TPO) is disabled, read of
stored TPO yields value with all date components set to '0' inside
opal_get_tpo_time(). The function opal_to_tm() then converts it to an
offset from year 1900 yielding alarm-time =3D=3D "1900-00-01
00:00:00". This causes problems with __rtc_read_alarm() that
expecting an offset from "1970-00-01 00:00:00" and returned alarm-time
results in a -ve value for time64_t. Which ultimately results in this
error reported in kernel logs with a seemingly garbage value:

"rtc rtc0: invalid alarm value: -2-1--1041528741
2005511117:71582844:32"

We fix this by explicitly handling the case of all alarm date-time
components being '0' inside opal_get_tpo_time() and returning -ENOENT
in such a case. This signals generic rtc that no alarm is set and it
bails out from the alarm initialization flow without reporting the
above error.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Reported-by: Steve Best <sbest@redhat.com>
Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/rtc/rtc-opal.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/rtc/rtc-opal.c b/drivers/rtc/rtc-opal.c
index e4324dcf9508..aa53fceaa5e0 100644
--- a/drivers/rtc/rtc-opal.c
+++ b/drivers/rtc/rtc-opal.c
@@ -150,6 +150,16 @@ static int opal_get_tpo_time(struct device *dev, struc=
t rtc_wkalrm *alarm)
=20
 	y_m_d =3D be32_to_cpu(__y_m_d);
 	h_m_s_ms =3D ((u64)be32_to_cpu(__h_m) << 32);
+
+	/* check if no alarm is set */
+	if (y_m_d =3D=3D 0 && h_m_s_ms =3D=3D 0) {
+		pr_debug("No alarm is set\n");
+		rc =3D -ENOENT;
+		goto exit;
+	} else {
+		pr_debug("Alarm set to %x %llx\n", y_m_d, h_m_s_ms);
+	}
+
 	opal_to_tm(y_m_d, h_m_s_ms, &alarm->time);
=20
 exit:
--=20
2.14.1
