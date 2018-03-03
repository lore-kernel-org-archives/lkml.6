Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtasWOQLjbaLpLa+39rjFEDVWHtABIvz57pALgKj2GIJHGDt/HyfYfvQsMvWUf1XSHcxUws
ARC-Seal: i=1; a=rsa-sha256; t=1520116675; cv=none;
        d=google.com; s=arc-20160816;
        b=eoGIVyi+7cm1o7XwVJCatCGwhrMVRnBkHWqpc5TivfnPBuiOD3z5Y1aMLuefyTUJCs
         6FpLMHkB7O/Gj0vYNtIluldoB9e3+4Rr7+uG/yGOOegjrq19w26EG8RxeN9cyOHOIEBT
         UkVIdpjneab/ymYqh/wtUUI2jcHLDa6/NbGkiJ0IqFGfSnMfgN27idhr+kna7CFnxtPZ
         dzrdIshaYUW3lq0Eswvuj6c3lRrW1AGPb4uldSrXqHzgM7mrVpQTXZZeXoEOlPW/9zQi
         +fLJGTVzxo9ZCvL9wj7xZLH++hD0Fbut47dNb1IEbtIvdc/tdbji1ypiZqnBLIWhr7VD
         VIEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=sD+qr5cwj4nBUlLVsDnQvkJaHnwRVrdhAhIIRFeu+Fc=;
        b=FisT8/JnygMbN/SE1JrXkMD0Nnl8Ee9NvDJrbh/XIFTHCLbiWYiA49Mb+1g5ylGDIl
         mDT4uRUNNlgQBrn78U0Y88upqXn5LfTXXw9RU2VLJ+5M3e+xQvAbdNlYjzGAcfh/9Ogk
         9+JAOs6oEYhosu9RwZo11KMYBeO9UaZMrZUid6ZlUU9w3AmX0HVPtftAnE73FYy2BKoC
         Uufp82aidXXafMQmBF2s2X4WdhPalb6jm6AeVYeVIDQ3BSisfKT7/vchdBKmSTC59Pn6
         sb9MnTAMCa3GKpsAbcXBn3bhEKil7FaqShzxD+NYjCXVn9OgbaeGd9Vh+XOmfbUjmBkG
         I+9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fd543N18;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fd543N18;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Varsha Rao <rvarsha016@gmail.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 003/115] staging: speakup: Replace BUG_ON()
 with WARN_ON().
Thread-Topic: [PATCH AUTOSEL for 4.4 003/115] staging: speakup: Replace
 BUG_ON() with WARN_ON().
Thread-Index: AQHTsz9H4XkGIrqqaEWyCnDTfRZnSA==
Date: Sat, 3 Mar 2018 22:30:48 +0000
Message-ID: <20180303223010.27106-3-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:rQUQ6bE/pzW6wvX7/B4NpTLOTQePxWbVt4YVU7JwYWnO71gjyvn7DY59qNVyRYM5uefwbsPqZ0lF337fgArlKOtvJCW5YgRVtG2JWgmKqZCnPpmvm6Db7zcw22Qsg1YQwb4NDGbf11HHdd7oP2G5ZDzJd6jlpTXPzNmk5UQOmKfByCUQw2z6HzE/DcEqbbnDWtJXYSfXK+rzxfj4ceRyDF+Sx0OJkH9qLqpj52BTyBt104zCiDzEp9lpzSEw8iIL
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 902fdbf5-af43-4539-dd3b-08d5815766cb
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100B4F4570A5B55D16290A4FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158)(788757137089);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(59450400001)(4326008)(305945005)(10290500003)(186003)(3280700002)(39060400002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: ixj025h8w6HqgbQFtPbHB/GDl2AHmE8Wbju28oqXOO1umjmM8ElM0Qq36pMXaKHdQ4PgVm/BHlcF/0HalKwQiWGMnycBsHu74WQgbrsFBgRBoV7KRiLvmpuRmE1nHKPknqb4xQ+gAwkAmTSDIuvo1foUavMyNajuLg0eVPnxuvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 902fdbf5-af43-4539-dd3b-08d5815766cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:48.8696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957430260228015?=
X-GMAIL-MSGID: =?utf-8?q?1593957862555017098?=
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
index fdfeb42b2b8f..06ef26872462 100644
--- a/drivers/staging/speakup/kobjects.c
+++ b/drivers/staging/speakup/kobjects.c
@@ -831,7 +831,9 @@ static ssize_t message_show(struct kobject *kobj,
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
@@ -843,7 +845,9 @@ static ssize_t message_store(struct kobject *kobj, stru=
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
