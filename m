Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AG47ELvpCpXDlmIOCuCp5zriZctVpWO6TY2zB8KlfDjp3AjOpRwb32VrNfXQDQqYlcCuXK0e2W5a
ARC-Seal: i=1; a=rsa-sha256; t=1521475495; cv=none;
        d=google.com; s=arc-20160816;
        b=b3HO46hhRF5Fo3po3U7PXz/xpwzuL+IHu8KuVkqMi76MK+yBZyqeDE7VPzHeyJB4J7
         xJ4vExcANJ3FaOE62aeCgh3cSKOGfAN5MNyA1FJdcIiRJigsWkjqy0EiUxh9FleWuK3W
         c6u29JO0A2OsHSkOfnYkwikrY26n6KCGlu3voFfGkCMWRhgPvyEdyFDiEedSPaASFII9
         7knwbtcd8NLXnNv+LcUGmW5XWVAYp8Ae9ywyo+PeNhEVyY3ilou+ee3ojPClD5DEs28C
         48wFDmy/ZYp5TJbS6lt/JiZCs9yQmxQ+WWlouEHEFCxKLIu+gbhiFlWdIvckFy9Q2o8Q
         gBnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=bEuKGNK00JeRh8siuYQ+j8k+hxXhvntAvNVh2EfXnKI=;
        b=vEYobbZLA+mjmniiE8CO3XAc2YnT7xK0TcHsVKvAzbeN9s13H7bltSWRYzCgf/LnaN
         orxhTkluYpfOhnRcNFAGZ1zPPsbVWukhPx+1fgUHeVklgZmkzSJ91yoZaSmhO3ecT+g3
         zKPV58b9s6ziFbzplokD/l57dEby5WJNuX0fyJWcasHmMtOMleJQGQJ4h5pAeEc+oGd1
         d0dCZhACSS03LxCk0wrTCDFABIfBxeJCulM0ELBxig98RYAtwyg7NVu0oknxEQPKRl4U
         08u8iYpXgAJd30W3+oGXJEdCGW8pi6QRIKIGgx0d1OA7+HNZmmypIal3EltaTEHuf+7g
         8vLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=czxMEuJu;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=czxMEuJu;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.40.120 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Robin Murphy <robin.murphy@arm.com>, Mathieu Poirier
	<mathieu.poirier@linaro.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 236/281] coresight: tmc: Configure DMA mask
 appropriately
Thread-Topic: [PATCH AUTOSEL for 4.9 236/281] coresight: tmc: Configure DMA
 mask appropriately
Thread-Index: AQHTv5uxJTIdOGMgVEOEtzch1uE/9Q==
Date: Mon, 19 Mar 2018 16:02:33 +0000
Message-ID: <20180319155742.13731-236-alexander.levin@microsoft.com>
References: <20180319155742.13731-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319155742.13731-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:71w6GGhRhHs9BleBuHiGeZshOZI5IbDAG3oRvP3pWzZ4tCSWfQHxKXeGfgWq9YrMJGdixfog7a+xrJzcE+z/9UsmeVGgP1kXnTQqxziyi+Eqm7+jY3LkMIfpdOB4qeZf8UGiT6qP1R79jSRdVOw6ql1CXT2o4Skz4aUedUjjq/2l+LKNMFrW8F7ZEjsXb5XyF4/XE4X/1brhooqe27upogfNnILzW625jsZj78Owgede9PYkoGLF2ow8YfgkcmZl;20:w2ydOnswGKCrsCgODQ+qvwTThX6nnyXPEDZVuMkRTmTXLLX805HaS4i/uCpYg7tiBTDYAtHzmBe9ZFVQ20w0FJBCL4b7cT4UcjISHhw2WLxMSb9dFCcUzVig0Xl3hhdmo0uojt8wTdviqhXU1ebXUOgnB+R3ztOF9ha2jAKccmY=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 49d8c637-77b0-4c92-b850-08d58db32755
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0885159054408A03ACF0C917FBD40@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(39380400002)(39860400002)(396003)(199004)(189003)(6666003)(8936002)(99286004)(3846002)(107886003)(2900100001)(68736007)(14454004)(6512007)(72206003)(81156014)(81166006)(105586002)(4326008)(25786009)(1076002)(22452003)(575784001)(86362001)(110136005)(10090500001)(54906003)(53936002)(316002)(66066001)(6486002)(106356001)(6116002)(6436002)(2950100002)(3660700001)(8676002)(36756003)(97736004)(102836004)(2906002)(305945005)(5250100002)(478600001)(6506007)(7736002)(3280700002)(5660300001)(26005)(86612001)(10290500003)(76176011)(2501003)(186003)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: uk18lZrlUhL3oO6eYb+ObS7C2NDnrJ1bKHFJV/291CAsp94ARIzhKP/ds4rJtA6FE93nMtbjnE9+dfDE1wjdbV+wxIHLwdKn8Wrja+BxYau5VfmxcP2kw9M8h132TuAA0+ZHTwRzpOvRIPwzYi8YwWl87FAP39CFS9vE9YdaQaUuODoYGnNESKCSk8zstUtAlMYgRC2lOXU0oswt6duc+K1EB5FAWN/Jr5epczwgn7FUanoTPd5cPFbFDgwx3qZ9u9AeHgxhRL5kjAMb79oKnU/BjHRFdR9dqllFyTckoHIt5OFt1AIaqRJvhRMwXKImyN3YNuIZ824qvOfOfYvFiA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d8c637-77b0-4c92-b850-08d58db32755
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:02:33.9151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595382689290226408?=
X-GMAIL-MSGID: =?utf-8?q?1595382689290226408?=
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
2.14.1
