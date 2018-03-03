Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELs5wx+zOZi4/SNE8Hfgj4W7s8TneKX+JAwGItm6AIRPA8NsXQh88+VfFPPOX//lKpOhPvEP
ARC-Seal: i=1; a=rsa-sha256; t=1520116262; cv=none;
        d=google.com; s=arc-20160816;
        b=QiITwlP/pjZJqPtKvFNPFKPA4pZVSmtvUe3eaUu/ch6rWdYWprPzpVDZmEL54GpO1S
         QP0camMzbVOfXmpdj1Y9C8kMb59YAk4nFcjGPRu9GSjt0phhYUM3Hn5T6W/hHNmUA3Fy
         v7Vb8dBQp3kveaDleRWhFmqKS7fabzHZSLMInTnfLyNNw3hr7ix8zuvmgeC57q4KrCHP
         Dem3J21HYryW0vgc0bgKA81fRhJIahxtfLSlOShlabYdy9Jraqazh9sz0EcAHSoWi+zX
         CwE3UJKGVWVfTHML6fqlezFzmnFMmEMoGKMv289VKr0zayZr2eee2xjSnYZlimNjLIly
         Rjvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=I/mD3AM6RMNl20qJZZuoFB+Jk1p6PiGj8nIhtvcXTBM=;
        b=IE0iV8ga9995/UWwviJJ4XWZ823zjOcnSP7GQcyL9ce7xZYclRE5snKMkhgom3IxET
         CtTw6qDU/DC6ylsvrUzUOuJTvNx8JHLA6/gGP+8Nj2pxpS/G/hu2GHRn3SIYEX8P6Zg4
         KiC3uay2dKtM5EZzQABj94hZ4LNFdCNsltdZcGyjHT6idVcd2Cursp5gr4CGbwO4OzCu
         F4yC0PPhdIM5gLxJFKAdeqn1RTnLYwuuUgWie6MHqQtppgRphZR0JA4xbY+8ReTbI3I4
         lU414zODo/kpuqJE2O+uX8qf8IblYc6tOniWhVKZMDC+tcCKbVw53DYy7dJ0PQzfdQgf
         sjEw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fX1ueEiw;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.114 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=fX1ueEiw;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.33.114 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 007/219] staging: wilc1000: add check for
 kmalloc allocation failure.
Thread-Topic: [PATCH AUTOSEL for 4.9 007/219] staging: wilc1000: add check for
 kmalloc allocation failure.
Thread-Index: AQHTsz7ib5TsNZUMyESz6S1x2U3hbg==
Date: Sat, 3 Mar 2018 22:27:59 +0000
Message-ID: <20180303222716.26640-7-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:YSu4fhN4bLMIglH7JBs2MpWNThG1Ffczq1QjxupNFwIAsbAqwdNm0jPcMf3cGoWBclt8drtnnOdxLekARALW0U34TChH//oloC7ZV91onGu3tcjDNHZGV9VxUf+PbSy6I2yieS8CMtBmVO6RiSaVbvfkwIardNrFOHo8cEckQCVmw8GYWBqfKoxja2mDNMyHCli6GAbF1M3Z41S9vGbp2YyQpjSZ7MAl3P+OXeI3mQ/NoHGYoVkfOtQ1VmaHtv0e
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8da00d94-3e19-48a6-c237-08d5815670f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB09706317926E9E88C741A998FBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(39380400002)(366004)(396003)(39860400002)(346002)(199004)(189003)(575784001)(86362001)(110136005)(4326008)(6506007)(14454004)(99286004)(8936002)(1076002)(36756003)(2906002)(102836004)(76176011)(25786009)(6486002)(316002)(478600001)(3280700002)(107886003)(186003)(54906003)(26005)(81166006)(7736002)(8676002)(6512007)(81156014)(305945005)(72206003)(6436002)(53936002)(6116002)(86612001)(68736007)(3846002)(2950100002)(3660700001)(10290500003)(22452003)(10090500001)(2900100001)(106356001)(2501003)(66066001)(97736004)(5660300001)(5250100002)(105586002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: h/GNtq+vU+Ka9ZPiMjW3j2BlJJZlUaFLtoMcNdzAEmjursZf82iFhhN1o3QfLENJlfn0PaKSNtqe5942vnodbIxbvmqP65u/WWKKx0Ee7D/b2cd8Zkys6XDsAlsGx3plz0weVPEVTsh+njhtC14c46+1KVDbwMdSkwbvaqv/CXg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da00d94-3e19-48a6-c237-08d5815670f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:27:59.3693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593957430830487566?=
X-GMAIL-MSGID: =?utf-8?q?1593957430830487566?=
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
index 6ab7443eabde..6326375b76ab 100644
--- a/drivers/staging/wilc1000/host_interface.c
+++ b/drivers/staging/wilc1000/host_interface.c
@@ -1930,6 +1930,8 @@ static s32 Handle_Get_InActiveTime(struct wilc_vif *v=
if,
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
