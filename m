Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvaiZYDhMzKg2I8TxQKEu5EYtGW8ZywacJL3DJmymk9DEjXoJDcts6H/CkGf3mkIvKHdJS2
ARC-Seal: i=1; a=rsa-sha256; t=1520116089; cv=none;
        d=google.com; s=arc-20160816;
        b=EgEiAQRHJJvuJ5CG+aFG4pl6Mocl6eACufgIrvkdXiWAZUDg7o3v3RP82gdMZmXhUJ
         rlezOXoNkWWqV02aSxah13lN7S005LRwHSs0Ns6Chqvl3z23yPoUysWNiZEUp0lO1muH
         xVT6I2bErwZcQUcyB+zQjMotyWEL38wQ6jpdKvRneeLipwb3j4+9HCa3hYrq9Ad2iQJD
         /iOeb0BOuJtb/sx743JkQpKrJtSyOg6G5KNPQ0cUt9dMWGXYfvJd4UipS2HldLUU4aKK
         Ivuv5frGuzaIDGzOVtC2ZsZlyXxcXSrui6xEKAJJiQghSCDBbRnsu9qWW8Qsj1pM5LKX
         rLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=WX4HiqPGTBkubu+5fXlSuB3AcbzfdaAdeEtxbTB4r8k=;
        b=vddFFnCXV9maYl55Sm8kOJAUi9bDH4XKYROvmhUn4aBvu9dgetkHXtn73pxmhNvs0t
         uPPDktgaUX80M/IktqXBd23/Q/ODWKfx4yNSImWsuWMpWGl852+gknFGSbfWiH7unSpX
         v+Vh3zpAb8sRc6ss/zK17R/eOWNUSNryPdLtoppIseIqFBZsLObXhW81lFxUsoInHUUJ
         qGm4IJ03Q/f8UWAvdoNB4rJqnC+QxCJOaX5BuObZlkGmL0/rwRK8UnFv1dabUo6N6ueQ
         izzGYPBhAL4JdHk3IRLJWaqembxJTvIlEiUphQHMk+5ERPuppMsPRVuhdh9KiB+Dm9j4
         7fVw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=dX1OYn+H;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=dX1OYn+H;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.108 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 11/84] staging: rtl8822be: fix missing null
 check on dev_alloc_skb return
Thread-Topic: [PATCH AUTOSEL for 4.14 11/84] staging: rtl8822be: fix missing
 null check on dev_alloc_skb return
Thread-Index: AQHTsz6f3wEllRfQY0eRytv18pZdYQ==
Date: Sat, 3 Mar 2018 22:26:06 +0000
Message-ID: <20180303222518.26271-11-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1067;6:6+RruL7R6mRHOealLAaqxO0v3HlUWWmMmMj/9Zb2PbkXWxi7z6htGDZ/gv1+8EqCbYsTtWHTbANri+tjuUX2OmyN5W0vGlSbm9jMoDx4gZorjtzW731BsRAeVKFAodmwlroo57HLTdZUVL1aKG+z5odqAJtIOxVe/If4sqgzveCzufhbSJVz2/JLFhNWDDTf79VMRU58SnFr1uA5YFdsMQJ1a+eka9JOBQ6YasxvJ/revuIhGCYPH5B5w/Wzm5TGwMGOJcfo8vxqMtouoFYD56yYOutNydNgNt3iLNuWfIMhRBM9yeQK+AUJMEM0c9wgPPizISYVeMf1EfS8wIlhD9paDZO9c4MzEd1KBM2dV14HatIIQzyaRFmy8G5O1t6z;5:kxztXAGVEzOlEXgT7cnoVIZM3eBTZOQkLEaW2cYcq8qK26uTsUE2qbOYDeFOEOMys0vBjnD8HF0EnboS4PB3mP1GGQ/7vPcHmmR/Q/dlXtdbqLL+d/u47Tvpc9YDtLiQk0Oo+tdWZBcWZcI9iV2rxMqM6QtlqlfOpSWE6TaIHFE=;24:xzUhIgGve68bmkvLw9ubqyHbo8FYunsdiG0Tgy8YxwFmYrloZeWLBHO2IwvrNXrcl5YPSpoVsI/wT55QtaeeUqtnY1Ir1oScRNNP/kADi9w=;7:NXO3NlhzjjCABQ/M7gh2nc84q7BsDFR8p4/nv9aiU+Gq03NQJj1K5meWFkRd8X8dXzrpKxcSr0K/vGgh9HHmNKCXzSGhSA6c9lT7wuet0rPmsgIawNQkJ3Vw7006ONvZpKrA3wzrhLHfqSCDXHnqC5X58mijEqiUQO52AwqEtLSVfDSJp5ucqREFju2aWnlOBS/ze+Al04Jq8Q2B2EVL4y+hBbDIfAMI65hNNNOKGioOgei2H3jLVEp9aBKyxAGy
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 791109e4-26b7-4f74-7715-08d581560a07
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1067;
x-ms-traffictypediagnostic: MW2PR2101MB1067:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106748AE740E22A15E73D220FBC40@MW2PR2101MB1067.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3231220)(944501244)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR2101MB1067;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1067;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(199004)(189003)(6512007)(99286004)(10090500001)(86612001)(106356001)(53936002)(66066001)(316002)(97736004)(6436002)(68736007)(22452003)(105586002)(14454004)(54906003)(36756003)(6486002)(110136005)(8936002)(305945005)(81166006)(2950100002)(81156014)(2906002)(5250100002)(4326008)(2501003)(1076002)(86362001)(76176011)(3846002)(6116002)(25786009)(6506007)(5660300001)(102836004)(478600001)(107886003)(72206003)(10290500003)(7736002)(26005)(186003)(3660700001)(2900100001)(3280700002)(8676002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1067;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: sqT19cdoegauWMHlyf3PaEo6RurQmui1q/EupJ80yJnN/2sUCO0ANmCmUkyVMoldumuASUjXCc+R+ZChVo265/u/KaovzLKDTwbebQKAQwHnz7T8rJolYYB2xc4p79VSurzChWykFn4M7EiXfXt1e330ey/xbDrr0KXGaU6M0ho=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 791109e4-26b7-4f74-7715-08d581560a07
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:06.2754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1067
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957033208948384?=
X-GMAIL-MSGID: =?utf-8?q?1593957248601932219?=
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
index a2cc54866e79..acabb2470d55 100644
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
