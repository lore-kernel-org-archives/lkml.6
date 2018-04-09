Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx4/JWZ/AByZzmJp9f3S4+/JYYAvqGZQowEOvc1gbhrwFjOVW7oNJhKp5LwzfMCcI0XcHOYQr
ARC-Seal: i=1; a=rsa-sha256; t=1523233604; cv=none;
        d=google.com; s=arc-20160816;
        b=bW6Hf3fl9JLTAGM0SK+oTsy02KlvUZnU6H/Ke369wbMgqA2t1DWKVgFbkZ22s0S7Bl
         V6TMgsYVJes1f4xV/rDqJ3ygaI9eBsprNd5cj+EVcVibxQJdlBThXU9f7YLOkwoLF3Fy
         vndcagGHXIrANT2CcQHC8w2w+C+vNMe5bj9Zd72IF+NNSIBZhMn/fei/CFSWJxq7TBFD
         b7y4py4zxXtWPlvlgxBy3plRDzLSNSngSM4Nel/5ZBdx5ABPYX4WVQLekY0iZJSrG+W+
         37wg/k0Hni+241Hq+NQWNvIEZo+LO9lSqFCszVGaDB73YU7euBYyI2PxGJnRT5ss9Xic
         RRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=UmW30/ZGXIYGJ1s5blcJf0EuWFE1nyhSuZgOO+qCxzQ=;
        b=qUSZQzVzSEPiZE9qWjL4Ah7Q0VpzEPlJ3oMq72P1MT153/ubBsDtBG9mm/UAQi5g45
         o5T41kneYI0tBq8P0Wfz9iUQ5TEwI/6Kunz3m3EstoOLRj5QXlbvbLcjUWVeoq2AfwnC
         i6v1EOWZzJaXsvRGchflYR1hiAKwGQyO5vO+8OdU8UnaD2LCBU5vR6ivnnWEEQRdsiQs
         FZSKSNFt8gouewCXf0Q2apSJgT55uwZ2d4gDbeuImLf0StqlXtUb7IRapPG5bkVcY/td
         DaL+I5uHYjnThnmjhKTsoeH5Jck5Qr7esHCnYpctgLxCcLjfzTjyJyLvCTttnOsL5g3p
         7wwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=i+rHOOyw;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=i+rHOOyw;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.42.132 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 022/293] coresight: tmc: Configure DMA mask
 appropriately
Thread-Topic: [PATCH AUTOSEL for 4.9 022/293] coresight: tmc: Configure DMA
 mask appropriately
Thread-Index: AQHTz5jufdwICRLG7UGk4r2MzNFWFA==
Date: Mon, 9 Apr 2018 00:23:07 +0000
Message-ID: <20180409002239.163177-22-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:RSm6haq0zVm3UMtD85ErJZv7nxsa1zGcniBjk+xkKtOsjgy1lVwX9b/1hDvCiQjCjl0FUZqxm6V9FkFbjmjNjFI+A2wRQt4OfYOeYBzkmm+Si0PfprSKxZK6jHoMFU73CDKn076/bQbbWjLmCtMIY/paOYtdaxbuuS821wx5G3o3/PICeE7BLfHop5BzOxmCXmzdIol6MDKbk+0jIoXFlTkjR5jLikeeSh2mp60deoiOauz2/2D/vZjKElD8MU6v;20:ytsYtLU4MazO2E0Z3LdKMa1In9bK7fNpc/YhUcSMKSbquKhysORaekBFioMFkxnbXsYKBAHQpVigI1W0E7Iiqo1f9Uljgr1KOd8lh8cy8+y0hJl43WmiKYfkHDFx0HuEnum9HyMoYAWiexoD9tQdEgNWsK7JkEt0o6tqfvxHUP8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a99cf975-2e55-41fc-52d1-08d59db091d0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885EA31BF935B0BF8D6BB2EFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(66066001)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: P9gLEnoxzEe//eH/LGWkcrK0nQIQUuQOhF6NiBYpfk5i4mrjdOvNxswgbOQQscuOqLrew6/M5wDyQ9seVr7bRM4HjNsy6tBNa2Vf1xxiSwNB1MdF6V9zzgzq9M43ND0DLrF4eqtAD4+BkGO3CHrr67BefAeD06EOW3yYzmfIQUZy+ZZRLhFV/AT2ZfAyCa0mjCrwojL543BqL6kO0ytUXOSIyYKtYpZq/M+u2wpvPxo65JTWerAYwmoJUYjEhRKGNPVbv2G+4meQzBlqr6cZOQZeJ7pK1yetlQax9N1KQi8NxIfexxenzGxNUpKRRRN2Rz0iKgAmU4DewG9w0TSMaFQuh0K9Ufdce23D5qLRmO/RrBwvKSjN8b93JiX0bT399KqalvkVNKUPCF4S/diW5gEu7Nl/kH9nSJBEUxP+6ag=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99cf975-2e55-41fc-52d1-08d59db091d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:07.1435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226200203316417?=
X-GMAIL-MSGID: =?utf-8?q?1597226200203316417?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Robin Murphy <robin.murphy@arm.com>

[ Upstream commit a3959c50b02f57df4c4e4f14f632220f1c0b1f79 ]

Before making any DMA API calls, the ETR driver should really be setting
its masks to ensure that DMA is possible. Especially since it can
address more than the 32-bit default mask set by the AMBA bus code.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
Tested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/hwtracing/coresight/coresight-tmc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracin=
g/coresight/coresight-tmc.c
index d8517d2a968c..864488793f09 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -362,6 +362,13 @@ static int tmc_probe(struct amba_device *adev, const s=
truct amba_id *id)
 		desc.type =3D CORESIGHT_DEV_TYPE_SINK;
 		desc.subtype.sink_subtype =3D CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
 		desc.ops =3D &tmc_etr_cs_ops;
+		/*
+		 * ETR configuration uses a 40-bit AXI master in place of
+		 * the embedded SRAM of ETB/ETF.
+		 */
+		ret =3D dma_set_mask_and_coherent(dev, DMA_BIT_MASK(40));
+		if (ret)
+			goto out;
 	} else {
 		desc.type =3D CORESIGHT_DEV_TYPE_LINKSINK;
 		desc.subtype.link_subtype =3D CORESIGHT_DEV_SUBTYPE_LINK_FIFO;
--=20
2.15.1
