Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELtEkzcHS0XuKZNj50B3IDd9AYcA/Y9DE45Fk3gajfdbgzZpA4KkBpYfniYruOamrwxbtFOQ
ARC-Seal: i=1; a=rsa-sha256; t=1520485335; cv=none;
        d=google.com; s=arc-20160816;
        b=gyK0ZfrmGnNFc8D1wyDnETkpv6huk1QiiAJYYXI1IvLzQpoZsWs1ZxFH7i0JkaQH9V
         k3QxTJuY3aEC8S1N5wcb3Fj/trJyKeRTj2aqrOuDg08UXGGyECpJO/+vvBPxDI2y1ZzB
         Mfb//I6nkOu/yjn1TycLvQhepWfCkiz4sJPM42QUWVuyBIYz41jBf3/KoDeXCo86a9pS
         9qMJajjmkmq4uTwjAmL1y7yYlnM9D3YS+VU9A99Y2qUBw9FhCfQOh5bu1XDZoDQ61tEA
         x0/f9OxNSgGH/UrMKYO9t5sFCqqsDKIw17fVtep9/eMR3ThpKHRrXwa4CoXg57vGvTJs
         TzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=7bmLZhjTQASJLHWc16AskedMrqaVilGgWKeny87CPqY=;
        b=DKT/mhbq3WRaDGfXJ7ZBajSuyvmtF109I60YFtNbNLTSJkokmsR55hm5mw+0thV0Ge
         netCkFcZoPQ2oKRHZoj6g0xYEkkLmYYi+AqFalqbPnZr2TX+Gpk/vqLWRHj3LfJjQpL+
         ewVHE2MqUXeuzWrojBvEXsAoeUYvZ7QWLQbrusQhvbLXaVlVj4u/9hjkIKnyn+015KLe
         M/BlgIPXPdUGQJn7Q+ntraO6LMLlXpC76Kg8fIeFk248Wi8ljlgJ77H9d5InLK/dPLMA
         D7E9ILzIsxXsgD6uIxzF9iM++HTR2x+THN2+kpBMNDRHw6DclOveISeEbWuioEmlISXG
         8AtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YsTNV5Md;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.100 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=YsTNV5Md;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.100 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Pan Bian <bianpan2016@163.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 106/190] staging: wilc1000: fix unchecked
 return value
Thread-Topic: [PATCH AUTOSEL for 4.9 106/190] staging: wilc1000: fix unchecked
 return value
Thread-Index: AQHTtppC6NSeXq/tiEKfcEwt0VhXdw==
Date: Thu, 8 Mar 2018 04:59:38 +0000
Message-ID: <20180308045810.8041-106-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:GATCCFpf9zYZXdtBoV3+drrV5ExCVroI9I+pPBXacFuw6UoXXRKXjH3xpObAXfqw9DZFuy/yg/em0DkbreQiv+k/iZvsF8gq2tfqqLvqqHVly4RRhfw/VrswUz4OMreapSNzKd+AMaWVFB9hz7uNVxDKWSWmtxQ9753ENvsZ7BqUTsIupFhIviIpTSIRDJlP/uKePfrHmexYBNS/Ov5RZUkQs3AOXiktfAmdAFPqfhNS8SDkuJtbmFmDNsMuwT+H;20:LcAIn07v1kt1JpxCvw/r4/b4IXrACG7qnDiThaqe2HGFDKTBZeER+WkmvNTiC37XNrh7aQXitu6qMsm2VG/1lUIU5agPSiWnLSQgDGjGwmlX2oYIfnXH0k8mFwyZCBvM7mL1xvY5JUDXp8Lvxc/8TnhxsCPQ4tovKm1msoEApdY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 500637fb-ba64-4aa9-b054-08d584b1c1b3
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0997BDA7F6BF6A036F953979FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(130843839470238);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: MX0gKxhFPlhOjoOcia02oJDz8DJ5sZIQAMMNH0KAOU17FPGn7G9yXZNR83vM5oeRHk2F4t8PcyoUnZfTgJ+/YhtdngGRrvgeStPQ5LM9SK4c8SB2DpEsP+0y3QB/d+hp2KpAkEf3CO9h08DGZXjK0fwlcCxoM+T7Xc7+cbUG2OC3Ej26Hh1D9op4R+qDKRdzbfgky5cBUgH0TCh4uSDzDNcTNCT07iJ9QgubK5AsGwW5PGEog/a8QpCsmHye4/yNk7IFWwrbkIO0ZJybpmj0jymDV/gNDLK8KfrQ7D9Af2Y8gl4HXSjYAJ1AzWDYimWX9OCK3VgP1PhSIURmsHzHqQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 500637fb-ba64-4aa9-b054-08d584b1c1b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:38.5472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594344431308014013?=
X-GMAIL-MSGID: =?utf-8?q?1594344431308014013?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit 9e96652756ad647b7bcc03cb99ffc9756d7b5f93 ]

Function dev_alloc_skb() will return a NULL pointer if there is no
enough memory. However, in function WILC_WFI_mon_xmit(), its return
value is used without validation. This may result in a bad memory access
bug. This patch fixes the bug.

Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/staging/wilc1000/linux_mon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/wilc1000/linux_mon.c b/drivers/staging/wilc100=
0/linux_mon.c
index 242f82f4d24f..d8ab4cb11289 100644
--- a/drivers/staging/wilc1000/linux_mon.c
+++ b/drivers/staging/wilc1000/linux_mon.c
@@ -197,6 +197,8 @@ static netdev_tx_t WILC_WFI_mon_xmit(struct sk_buff *sk=
b,
=20
 	if (skb->data[0] =3D=3D 0xc0 && (!(memcmp(broadcast, &skb->data[4], 6))))=
 {
 		skb2 =3D dev_alloc_skb(skb->len + sizeof(struct wilc_wfi_radiotap_cb_hdr=
));
+		if (!skb2)
+			return -ENOMEM;
=20
 		memcpy(skb_put(skb2, skb->len), skb->data, skb->len);
=20
--=20
2.14.1
