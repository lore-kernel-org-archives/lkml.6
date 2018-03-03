Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELsJ30R/DWo1oqETrajJZjYwA9Z7yAzgeS3+gjOKpXoELM+3cNV4U4dgOpKeIhaPbksK/9eK
ARC-Seal: i=1; a=rsa-sha256; t=1520115883; cv=none;
        d=google.com; s=arc-20160816;
        b=1Lw3VVRpc5RUqWRATlvRJkdobZw4vMPh+7ZPiV09SP6GeT/OIW7TMuEEjkI3shd7yd
         euBjFkokyAfKUqPzuRmGS/XGXH9a0vqjVr8xA+DCiKV50DBvkRVogp/1U5PSXOAFE93I
         BCx0Narkj3KVBl7Vz40zPpeup9Kuj0am5+bTzLzeIuzJtIGdF5sQPZDK/43IIM69lAzk
         tOS4p+3Z5ErObb8w5/dEISTjbFmIoZ8pDNV3YkHP/YHixRP8z1RFoXCYAD5POi0qvlqx
         H7EcbmPiQ7d4nGoEp/2PpUFU7xDTThnGaDBEY+12tNFELoaOhMs0AYQroMSrxk3y+xkv
         soCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=g9wsQ0iRblWkNex6C2LHJVVvBb8kJB9/rG2IovDjaYQ=;
        b=KAwpe/ypfjlTZC/ev0jW6vCeYyMUMOuYo01yhwxjmBYgw3cFTOfL5CP74kfcAiSCqP
         qfyfUfZs15ftYezJWfHFaWmZ7F9ly/gInfKZ0vRDgUvU9wd1NKx+DvGzkLcCtgZOzahy
         J4N+9zbAFHLuJwX/sXOYubKb0qvMpnDdE0BDH61AVeyv1xIBh3ayYmhdkE1+0P57gtFG
         OStf/cO6sSL9eKX69lTo7tuksaTzhKS9VOSC8LUor1lHgR9c4Nyol5+8UD7oTTxuTBN8
         oVBmIRef6Irc3/G7V56phFFEtK3YCGhAM+REEZwe7hgbI465NRSvSWv00UlNv4G3/ABB
         YkXg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DVOcS4mj;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=DVOcS4mj;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 015/102] staging: rtl8822be: fix missing null
 check on dev_alloc_skb return
Thread-Topic: [PATCH AUTOSEL for 4.15 015/102] staging: rtl8822be: fix missing
 null check on dev_alloc_skb return
Thread-Index: AQHTsz5e15thpOuHeUuqzhj4F8jwWQ==
Date: Sat, 3 Mar 2018 22:24:17 +0000
Message-ID: <20180303222318.26006-15-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0890;6:1RZVOro1IT2UOzmCDSVGlUQ14cyLnLblo6n7FjgUOFut8MSbsF3pM0RPr6z0mblofmlhRfr1SYXiS6ge4HZQ8ty0eyub84j1jY9VzCCpGgEqQSbE+cMfNQlenhOKLEAmgJGWQGhYogHxBqeOJtoFYf56qYIioTNODiImgHiD3QCB9wUf1VcnnRFfaXDzh703ixkK7L81plJxRiEjqqKOLd8o0/XQmgb00J/EHqEK+cXvmKd20DxrvAmt1qyKGYJ0SbiA8E236YsVCeSNXLIgzXTtP73am5Pm0ob21pnYBaxFhqj0mLmt0O3s5LtBaH8jsIp5euR5Eb0mosSffSOmis2oK6h+ob5M5WfBY2jXqyOsxvG3OIe200HOYD9oGFGQ;5:bItbSYYJ1WF1s7Ot8fcuDzfxzv10mrkbw6JC/mOOAnPCNCKIXsU4iwvzwVpPAl4VMV8IDWUgtzxOHnr7JMDZNrSi2umXTl1i+2NRKPII5JRaKcWWW2unn1WctF0nmxjFd4bnRcVHDTXILHRA8hyrwpmeDjC5C0YunadC1ys/XFg=;24:zVKL4TbUj6a3ICwFUu7WztAPYkTJlbysy2Irdb/B9SAC59xhVh0jI1BUa13vqNMhrXH4Bat8NoCyB2q+xPW2uC5tIF1+Xhfa9RZteyp+tOo=;7:gOSASxH7KTwV1fm5HVcPNebcUG/xxtuWLGm+Xccq9XPji/efwGLMUYOh73reom8YxgE6rB1QvgmqjwQOkerS1dvTRiXrS4S8XPAzJe2yBrVeQBMfelrHzV+UGQEWDn5+TW+TTeoaQ81rJEptBXuzSCzJYYGQZp/dklflKkepoOQsRfsmKJ9OpI1T3vf5Z3vvt2Fp47jn1xPob9ZdDLU8C4Hqk+94l2G6dkxN0bvNQ/6JPZMr4nST9+UUqB+HiRiU
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 90ae93ca-1ac2-4dc6-01e0-08d581558f30
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0890;
x-ms-traffictypediagnostic: MW2PR2101MB0890:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB08903B437BFECA13580584C2FBC40@MW2PR2101MB0890.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB0890;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0890;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(366004)(346002)(376002)(396003)(39860400002)(199004)(189003)(86362001)(105586002)(1076002)(14454004)(8936002)(6436002)(66066001)(6506007)(2906002)(99286004)(53936002)(6512007)(25786009)(97736004)(76176011)(6116002)(6486002)(3846002)(4326008)(86612001)(186003)(3280700002)(2501003)(316002)(22452003)(72206003)(5660300001)(2950100002)(8676002)(81156014)(102836004)(81166006)(6666003)(68736007)(107886003)(305945005)(478600001)(54906003)(10090500001)(7736002)(10290500003)(106356001)(110136005)(36756003)(2900100001)(3660700001)(5250100002)(26005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0890;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: BP5ibCh3OMo+EZeXAVkYS6EhcJAUDZkH8YoILxO2Tz1T1E7HBp+CIm6bBskmzPDjdYZF9iK6Hsk3xtjb+yeZLy6plz2FH1tV2P3X5NitVjSf2m7qm+oU5Wm2LpXZyh4OY2Orsw7Onj1wT+qwsbGJMy783jvq9C1wiNhQ26yBy2c=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ae93ca-1ac2-4dc6-01e0-08d581558f30
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:17.8377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0890
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957033208948384?=
X-GMAIL-MSGID: =?utf-8?q?1593957033208948384?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 3eb23426e1749a0483bc4c9b18e51f657569e3ed ]

dev_alloc_skb can potentially return NULL, so add a null check to
avoid a null pointer dereference on skb

Detected by CoverityScan, CID#1454558 ("Dereference on null return")

Fixes: 7e5b796cde7e ("staging: r8822be: Add the driver code")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/rtlwifi/rtl8822be/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/rtlwifi/rtl8822be/fw.c b/drivers/staging/rtlwi=
fi/rtl8822be/fw.c
index f45487122517..483ea85943c3 100644
--- a/drivers/staging/rtlwifi/rtl8822be/fw.c
+++ b/drivers/staging/rtlwifi/rtl8822be/fw.c
@@ -464,6 +464,8 @@ bool rtl8822b_halmac_cb_write_data_rsvd_page(struct rtl=
_priv *rtlpriv, u8 *buf,
 	int count;
=20
 	skb =3D dev_alloc_skb(size);
+	if (!skb)
+		return false;
 	memcpy((u8 *)skb_put(skb, size), buf, size);
=20
 	if (!_rtl8822be_send_bcn_or_cmd_packet(rtlpriv->hw, skb, BEACON_QUEUE))
--=20
2.14.1
