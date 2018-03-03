Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELuwJnln5R4rycmwQ42Aonunyk9OqUDhwv3YBESG1nbSu/Jbl4QrjTyFCs2qRvAYVempptUN
ARC-Seal: i=1; a=rsa-sha256; t=1520116675; cv=none;
        d=google.com; s=arc-20160816;
        b=D9k7RvO7nAEgDpHWCHuPp/CCl5cfTY8cNlurdUASEDtIYOSxUQpVWUXXLU2zHIp6fk
         1V9eUQWh690iK7t9ksQyJsoTH6xVeGHkYV7W8IfXckkjoWNXFmuzlz/HqHtSDwkkUfx7
         4T/cT21RXk/7D1tmvz7F/OanHhx7Czrr9fAIx/4UHiQlIgrPLK4c8cpudq+8M96BrBhZ
         Zoc6GbYDIo5ctDYbcxFlHhcP+oD3ZVmXsadxUroBdecU65lxOhOxkr6sJ5e02GjmnIMQ
         3G0pVxRMFU8fBguBPuXNWeIM3th+/JTclJLuZ1gMo8sKMH67+CZXnPZdAKPnUAFIpJi5
         6pRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=3MBTZ/PKZuCrpe5DCWeK0vOLLyCvdne6Z3mgA2EHOiI=;
        b=f53163jtBqoK217DckH0quUe7SZYAn5UgtJuhlDLCq10BLGqycFjYor613o5hVvFcn
         LWZRnzm5gDCZQUNOViIpACMucS1eP6b9DyqHCtSAxX6mFVgdAbli9O/tKM7DPUPRmBFi
         mwc1IVeI1reCfce2V26pyOdk6pyAbNzsdJd+pvSmDu9iwJ38M2orHrcnniWy+4SaZQvd
         2xr6Q5fwKm5y39xtsFZ4n5gUTLHmPjxmzA/mDCxBUn1Mo8T4hrF2kVlR2oCTzU9DfRvv
         RTc+Zp1lg5SaqVG8hds48jlysmfpj24cL3qZIrziJi53axNHV7Ynlhrt93yb+TdfPQDT
         7RGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=QHU77PFq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=QHU77PFq;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.37.112 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 004/115] staging: wilc1000: add check for
 kmalloc allocation failure.
Thread-Topic: [PATCH AUTOSEL for 4.4 004/115] staging: wilc1000: add check for
 kmalloc allocation failure.
Thread-Index: AQHTsz9HyWfSz3MsRUGKr54uHQwqvw==
Date: Sat, 3 Mar 2018 22:30:49 +0000
Message-ID: <20180303223010.27106-4-alexander.levin@microsoft.com>
References: <20180303223010.27106-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303223010.27106-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1100;7:hr9+1fr1R2sn1ads1pnVij2/lV6OIvn2rwFQNAGyISL0r26kh34VrR72oNO6A/6WsA+ywQxoW5kKwYl+jgeartGPjnPmZO7kEJM2DWRS43Q6IXTKMMxe8VloqMFjAxtq97DZVC5ZVwKyuBztxOMqWthP4n4JfrtXHOPT6TQj2hJYzZ5xMxxLm607qrnX4/Kl3QDBN1Ltw5BHc4Ktp7ZjIsM+W3S8IvfHYaIY9yiNduOf6Ym8gmNh1IIAlDdkS3Ey
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b4a61a03-a054-402b-4fcf-08d58157671f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1100;
x-ms-traffictypediagnostic: MW2PR2101MB1100:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB1100ECBFC5E581736CA96529FBC40@MW2PR2101MB1100.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2PR2101MB1100;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1100;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(39860400002)(396003)(366004)(346002)(199004)(189003)(22452003)(97736004)(7736002)(5250100002)(105586002)(2906002)(6506007)(72206003)(66066001)(4326008)(305945005)(10290500003)(186003)(3280700002)(102836004)(2950100002)(6666003)(2501003)(478600001)(26005)(2900100001)(10090500001)(53936002)(8676002)(25786009)(81166006)(81156014)(575784001)(54906003)(86362001)(6436002)(106356001)(110136005)(68736007)(36756003)(316002)(6512007)(5660300001)(107886003)(8936002)(1076002)(6486002)(3660700001)(99286004)(76176011)(3846002)(86612001)(14454004)(6116002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1100;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: KR9P59yfoUxwpCfTyknJ5rHKkmHc31rBUPK2CBHGAolk5qGFrT3pwZOaNEcmjYpJ3dlfjQQVZmnG4UhKbDMMCTb4GpjXjaNYu1wklXDdpHC+MTg0Nuz6+1wTR9nLz8N4xJgJ3c47/TLIe+eFBhyb/mAvlW0cG65HvG8Op4r+7rA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a61a03-a054-402b-4fcf-08d58157671f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:30:49.4008
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1100
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957430830487566?=
X-GMAIL-MSGID: =?utf-8?q?1593957862800839763?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 6cc0c259d034c6ab48f4e12f505213988e73d380 ]

Add a sanity check that wid.val has been allocated, fixes a null
pointer deference on stamac when calling ether_add_copy.

Detected by CoverityScan, CID#1369537 ("Dereference null return value")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wilc1000/host_interface.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wi=
lc1000/host_interface.c
index dbbe72c7e255..f78353ddeea5 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -2179,6 +2179,8 @@ static s32 Handle_Get_InActiveTime(struct host_if_drv=
 *hif_drv,
 	wid.type =3D WID_STR;
 	wid.size =3D ETH_ALEN;
 	wid.val =3D kmalloc(wid.size, GFP_KERNEL);
+	if (!wid.val)
+		return -ENOMEM;
=20
 	stamac =3D wid.val;
 	memcpy(stamac, strHostIfStaInactiveT->mac, ETH_ALEN);
--=20
2.14.1
