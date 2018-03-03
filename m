Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvd+8oxrx9J+NQltXZ8Ct3xbEAYCcBjTM2TqRSSwWnh4YCKoLjXy3EhGa1Du25bataH0lYu
ARC-Seal: i=1; a=rsa-sha256; t=1520116262; cv=none;
        d=google.com; s=arc-20160816;
        b=yLU4TyDG/i+JIawJq1pp3fw6///wRVFZN0XNbQKrFEq7X8TwA3eETH4vuka70zYLAr
         HvKI5PGTRRr0fdgwgkAA5NEkwhe5Es9dLoYUiNaelFnYtvkyPmkeFrAeU8PRNLI5B6FT
         4Bg4Tp4T+/+k+mIwgaqLoxYQZvgNoCn6W4GGrXjKQK4wnDTjqJnfd3sKTj9OUs61Ghol
         zAYVDU7D1O9CbfpoiTJfSXjiCiGwl6sn2/v8L+sh7ixHNQcmhJv9fmRBiscOsE8CEkLM
         7NVdIvvo7v6wZ0pyv63V5+9TbfFLWDczqyVSux+Asyf2/b4bb1URSXTHkGTMNsM2dyn+
         mA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=ierP5iFmA9Sxm/6AejUpvg9Qs2q5n/RtwOF1xvv+Ca8=;
        b=kTfAAyXbUKG0WLGshI9jMcGOWeyjpZXreM6sPJ3EnSeu9QB3aNyk7lf/fKwVKG39wk
         Xhn3xs1OPqbXl15RGROrV1qpGNTsEzjk6tBH1ccQL7mE0m4I20Tvm1n/KX8jTSSDR5xR
         eu4Fl4g6dmrPX6zN2cAeVRVKLP1RRjKkBBsKOUh3bqMpeR0NQvL98ODWW1C6ldkQ+AtF
         h3dJhApko5ZfeXpsfVGx3SnmEpJ2iz5cOvM1YHuvyhRrTYknoFT0uyeTyIeItM3UOzpS
         tRdH02kIk2b06cVreQVYYPosIBDXIUkSrESYeR0a14ayV6Ijq/JLbXw8NFq+30ys5rzm
         bgmQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XjWGNV4P;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.114 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=XjWGNV4P;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.114 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Varsha Rao <rvarsha016@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 006/219] staging: speakup: Replace BUG_ON()
 with WARN_ON().
Thread-Topic: [PATCH AUTOSEL for 4.9 006/219] staging: speakup: Replace
 BUG_ON() with WARN_ON().
Thread-Index: AQHTsz7idrDKzXdOQUWkehwsi5Or0A==
Date: Sat, 3 Mar 2018 22:27:58 +0000
Message-ID: <20180303222716.26640-6-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:kW8ccUjUL7pgb8/GWfvuHalbF9esfIErM/UHg08GuaVFz7zaDK4E2w2lKiDXYYC/+b0HwddUT7UANp8AE8TFCgeQAAZbBJd2hT8zJppf30QH8SuLqWR5m1EkcJNfo17IHtILsPc4d0t7cWpxVsR7P0tYJH8GsUl5d0KoYM/NRJGtHERi/FKEYYqam7x4JiDG/Cc/tgIvw7R7O+pX2kLduUDlI/D2/M6ZQXMkGFF45h2IHuBKdS5eCqhZeQMbr5AP
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8186c851-df6d-4656-c695-08d581567093
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970843EBCB297397529B9D2FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(86362001)(39060400002)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(59450400001)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: fI5lQnLqeiRMbdZgevKuiKrCpL5/3cHIeP59enT0lp8LvPOYHvqZoTNyM/G1FL07GQ0AQ27iLW6mhUyAGjyRd9NgLavwH/0Ac2hE6Cg0FKzMF0YMx2QmBAvgku0Ppvm/Xbeith2sZ5b/om/Dj+Xz4+Q/+VQnfpE3wXUhXXEOPq4=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8186c851-df6d-4656-c695-08d581567093
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:58.8381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957430260228015?=
X-GMAIL-MSGID: =?utf-8?q?1593957430260228015?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Varsha Rao <rvarsha016@gmail.com>

[ Upstream commit d351c2db5420bb17dcd2d9aac7ddb5f64c6d04b3 ]

BUG_ON() is replaced with WARN_ON() and EINVAL is returned, when
WARN_ON() is true. This fixes the following checkpatch issue:

Avoid crashing the kernel - try using WARN_ON & recovery code rather
than BUG() or BUG_ON().

Signed-off-by: Varsha Rao <rvarsha016@gmail.com>
Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/speakup/kobjects.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/speakup/kobjects.c b/drivers/staging/speakup/k=
objects.c
index e744aa9730ff..dea018cba094 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -834,7 +834,9 @@ static ssize_t message_show(struct kobject *kobj,
 	struct msg_group_t *group =3D spk_find_msg_group(attr->attr.name);
 	unsigned long flags;
=20
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	spin_lock_irqsave(&speakup_info.spinlock, flags);
 	retval =3D message_show_helper(buf, group->start, group->end);
 	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
@@ -846,7 +848,9 @@ static ssize_t message_store(struct kobject *kobj, stru=
ct kobj_attribute *attr,
 {
 	struct msg_group_t *group =3D spk_find_msg_group(attr->attr.name);
=20
-	BUG_ON(!group);
+	if (WARN_ON(!group))
+		return -EINVAL;
+
 	return message_store_helper(buf, count, group);
 }
=20
--=20
2.14.1
