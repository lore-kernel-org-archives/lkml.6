Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtV48IH3hEEV3Tr98cLqoK35H8C+6zZ3lrCbp81vI8xgThCmcP4BYrYq4HSnHnZOjBrDvmQ
ARC-Seal: i=1; a=rsa-sha256; t=1521475914; cv=none;
        d=google.com; s=arc-20160816;
        b=ahSTk0BjO7I8nOUgMaa4sY4vDMd7iWxGn1twwSQPLlJTNT9kYVJEmwmTSUZ2/nHabA
         zeNp0kM/WPRElVQlzaqRXSr62wNJw8N44InsGKpDzwI6oIiEEUvLZ8URTqgmBQTS7tJQ
         g25lhUASlqhBY3Hg3eE3g/Qjfu9x6SsQ2PCtZw4pyBbKdsqx0vllrsnKdM96jAZnSWVk
         sGGObmQadWcwggOCfMn5FjerJNCvTaB0tS6DLiTq8YDDf2Nt1ryQREEqwyNqZNsQPYJI
         MOGw40cwqpvlOZbMgaYLyaHV8cVsyAedQXnQTikXAeAI4R80GlWc7grOvC9DgrjhbPrs
         6ZCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=O/VQbZ3H5hn0JmaWuxE3/1UmLXr6MXajHUeJ0yqMOZA=;
        b=KcevBhWUNGwsi7gCk5jSHVUaSv386/1VnsCs2furxCgfyyDDIwHifGKWyuQ3vo9PXf
         04+O0UwdZSaginhU/8r0BOeTnw6+AkGhvFo64Hv8sAk1y3u29NtbchXvLfouEvclXfhQ
         MQzh4iKIbV99JdQXYRRvOV8NKuOPmZ8TkByKU9B++Hc0DUveQl/fHtUvggArpwzz9UzX
         EdSAYbSsjulysFd8EcC28SJQG1KjZB6fWE4+GZstOv8QXJyyhPLZIAnum9JIVnjOsDrL
         RVqidcPNWsEZ6WwiveXvztXRW6ij8n/s/fhAfvPKG7h4fkMlO1tYWgge8kwHgbsRr2YE
         PCfg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=hJ3raq/S;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=hJ3raq/S;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.91 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrea della Porta <sfaragnaus@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 020/102] staging: wlan-ng: prism2mgmt.c:
 fixed a double endian conversion before calling hfa384x_drvr_setconfig16,
 also fixes relative sparse warning
Thread-Topic: [PATCH AUTOSEL for 3.18 020/102] staging: wlan-ng: prism2mgmt.c:
 fixed a double endian conversion before calling hfa384x_drvr_setconfig16,
 also fixes relative sparse warning
Thread-Index: AQHTv5z+AlwTZMRpV0S6S41U3G+ViA==
Date: Mon, 19 Mar 2018 16:11:52 +0000
Message-ID: <20180319161117.17833-20-alexander.levin@microsoft.com>
References: <20180319161117.17833-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319161117.17833-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:kP83QcuHvFFPFtEfsQ2h6QdaJpKvH0OMlUptUCoF/KWpJrpa2mkAKwgVSqUlLdRQnmNmbZYiCAj257baB4yd3QaVY+trKW4iexFojfZWbqLe6bZoNGjBB9IOQsMw/nW1k52SqsPYAUjQHK6/n/bmfZI+vyZlZLpS5wXpyeYUqWI/3L/V2DDaBTniYrnx/9dgpmi9mJbAvilmsuh/tEoWsdF78GuPSTkzl0S/me4554f/bqdoYCQIwSJRrHv/ms5E;20:gZ/F7x43lTUIASgkNihfD5FwItCwCAOvnHgSY/0zkwiqY1VMg0sgoht0+hOxfTt5GBCGR5iYMEyzAjehksEzGQa396Z+0ovOXYmV348TEnG6dg8d7ahjHgZEwFiEq7MIokqJldzSJyBznnn1VICVoBWW461iTsD2bNu4juq3bqg=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5a9026d2-151a-42ab-5153-08d58db420c4
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920742D1B522BF45FB787DDFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(17755550239193);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(575784001)(107886003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(15760500003)(99286004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 4eVgYP/Zl88vgT4XstXzw9+0BIGNLnLUP0n78sNervtf1s906h/EKu0e33SpFqyALHyTP4hAZxjrKs1MhPe0kN+ezLJKQtUfBd4PGGPJlpVH2FJhG/2w/eqeqzTcY4aiC4WKUEyqVFP0QNVkH+6LNSDWcHYMnMv0n7k/TRq1Ukkr8IHcsDchvTiZzIcFhyqWLSBCVGLA+4UU0lLnYMfuT0GNIvCxEUwpVHeWGZpmVZ1qiJiEgZldvzQDJx6L9y60WeLWzVqzey2WOcV1TyurJpfq5YDh71kde6jbPeLX8CBx7Ic8afKRXj1+Ocpx4C4MpJRL9/Jbi81tILqPpwtsFA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9026d2-151a-42ab-5153-08d58db420c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:11:52.5048
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382333706519430?=
X-GMAIL-MSGID: =?utf-8?q?1595383127737965523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrea della Porta <sfaragnaus@gmail.com>

[ Upstream commit dea20579a69ab68cdca6adf79bb7c0c162eb9b72 ]

staging: wlan-ng: prism2mgmt.c: This patches fixes a double endian conversi=
on.
cpu_to_le16() was called twice first in prism2mgmt_scan and again inside
hfa384x_drvr_setconfig16() for the same variable, hence it was swapped
twice. Incidentally, it also fixed the following sparse warning:

drivers/staging/wlan-ng/prism2mgmt.c:173:30: warning: incorrect type in ass=
ignment (different base types)
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    expected unsigned short [un=
signed] [usertype] word
drivers/staging/wlan-ng/prism2mgmt.c:173:30:    got restricted __le16 [user=
type] <noident>

Unfortunately, only compile tested.

Signed-off-by: Andrea della Porta <sfaragnaus@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wlan-ng/prism2mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/prism2mgmt.c b/drivers/staging/wlan-ng=
/prism2mgmt.c
index 013a6240f193..c1ad0aea23b9 100644
--- a/drivers/staging/wlan-ng/prism2mgmt.c
+++ b/drivers/staging/wlan-ng/prism2mgmt.c
@@ -169,7 +169,7 @@ int prism2mgmt_scan(wlandevice_t *wlandev, void *msgp)
 				     hw->ident_sta_fw.variant) >
 	    HFA384x_FIRMWARE_VERSION(1, 5, 0)) {
 		if (msg->scantype.data !=3D P80211ENUM_scantype_active)
-			word =3D cpu_to_le16(msg->maxchanneltime.data);
+			word =3D msg->maxchanneltime.data;
 		else
 			word =3D 0;
=20
--=20
2.14.1
