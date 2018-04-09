Return-Path: <Alexander.Levin@microsoft.com>
X-Google-Smtp-Source: AIpwx49xTsQ1M7vdyr02IaqqfesPgnPmSDZjb28QYzxX3yZEjSgWC75dVV/fZoyW8PDYgGJ2CwUt
ARC-Seal: i=1; a=rsa-sha256; t=1523233876; cv=none;
        d=google.com; s=arc-20160816;
        b=VOwPUTHU8LzCvvGSUFLnbEnwDRvQJrxHYYy+orADiyWw+++yY/hC+BeLNZE6MRW7YT
         1mQjcKqza2Soqx/3p4xFkiVPt5GKx6o4AvJi+Z9n4yrnjWYxJMBa099yHVocNKDRTrO9
         luLePjoQvYAMBozVBtYcY4+5xA9w23KkbIsFgG31vt3WYTVO58X8MRlmrS+6vSBcypNc
         wYJzMjnNQQcZ6EZSwZvzS211dihw5BGfBtcOcmDZu5bwfOWE7ymionkOeeSAeJhNpXmY
         QzlAuYthAHmLZC5VD+NMYwxU5WTjhreBFXieEbhbOVKDxtHN/PmVJZCn/KT06Zob5Pdp
         uyGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=WM4FyS2OOGHYq78FNSGZ07Iu4WrGM8gB2M8MCxGWL08=;
        b=JbFxnBtbUliO6j0HpsltsEzJH63CjKJGDH2a3PYhu+kKPEczqpdpa6U2WS4va6cR1W
         qxglUpQaJZ55JlPMuQCSv/CN5qWyetZLGDZpWG9P58tD56rYYBisdOURqTsag/x/ypCV
         TJXRgj8BcvmOWBhCUzWE9w4bggCz7/Iv6gk+kMXRGb7TOcsxN5AyJcnqgTC09YofiLrv
         CzAppP2cemUfgD9iVFZ0vhxzp13j8TR5pDQMBQ1xVzndtkexkbJFn6za551Y3AFb+khf
         Fd48jbUA24ZYvHgIxLLlLt9nmeIUV3+ch3NTjlyLtEsw9GJcspWgZMsBTUCIP547+JCk
         L61Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SvuVrkhJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@microsoft.com header.s=selector1 header.b=SvuVrkhJ;
       spf=pass (google.com: domain of alexander.levin@microsoft.com designates 104.47.36.103 as permitted sender) smtp.mailfrom=Alexander.Levin@microsoft.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=microsoft.com
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Vladimir Murzin <vladimir.murzin@arm.com>, Michal Nazarewicz
	<mina86@mina86.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Roger
 Quadros <rogerq@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christoph Hellwig <hch@lst.de>, Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 163/293] drivers: dma-coherent: Account
 dma_pfn_offset when used with device tree
Thread-Topic: [PATCH AUTOSEL for 4.9 163/293] drivers: dma-coherent: Account
 dma_pfn_offset when used with device tree
Thread-Index: AQHTz5kyL14wlDxOz0eYsyXQ4+btmA==
Date: Mon, 9 Apr 2018 00:25:01 +0000
Message-ID: <20180409002239.163177-163-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;7:MOGsghO28fpZveDaUtpGvy5db31lE0Ii9j7qH6T+MU6SfGw7AhjAYE9xit7sGsdL5cOlj4uE2qHuh/NX/LlqURwZjjNVGxmG+zzRY8TY0HpB6ZvHuAIFeSRFfjaiEMEAdQT9ZbqKigUMfJZ5MPDO4ixEUEKWxJ/GAO75L9DH3RfGm6ZB5XNMPdjjDfoHXE916TzbctgNtE7Il52Un1KDqtpRf5wGyKsoUgP4iU9MXNQwwwLxPNuHadzz31RteXoG;20:FX70hM50sXSv14x1bwkC91yNwqYApgWrF+9daVxumdqSq2oJtdiApLTBhJ8cISgJZZmSleZ/h73IOpDVGVxz5xTwyvHYSTS7IhKdmdX/gTI6eXerwjmAHd1imYj0k8OWilm3Zb9zyxvGiPikQTJ6eEERo7kwXxixTUoL6y8eLN0=
X-MS-Office365-Filtering-Correlation-Id: 52973564-7c6b-4702-3507-08d59db13302
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917BD340EFC924BAE79C45CFBBF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(180628864354917)(31051911155226)(89211679590171)(7411616537696);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(39380400002)(39860400002)(366004)(396003)(346002)(376002)(189003)(199004)(99286004)(22452003)(106356001)(26005)(110136005)(478600001)(54906003)(10290500003)(316002)(1076002)(72206003)(186003)(4326008)(97736004)(66066001)(11346002)(25786009)(86362001)(575784001)(476003)(446003)(2906002)(6666003)(6486002)(105586002)(86612001)(3280700002)(3660700001)(6512007)(3846002)(6116002)(6436002)(2616005)(486006)(53936002)(7736002)(8676002)(81166006)(81156014)(8936002)(68736007)(305945005)(10090500001)(76176011)(6506007)(102836004)(36756003)(107886003)(59450400001)(2900100001)(2501003)(14454004)(5660300001)(15650500001)(5250100002)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 83BCmPc7RasdyGgV/PxQ1V1zIuk+W9V3eCVmcH6hH2cY/bPvtRHV09FofmWGYpbNdq5Epy2I3GnLiQq7wp5+0JDEXzGc0joLD3S7cpfoH8cbVFNHrOxc8Z9GHIO6upi2a25S+XowKRidQ795qoaAutVp1+26Oh2jTX7K77MoUZhZP83UjTG97v1wMIFajMldi0LcJxdUTL2q9EU4xk4QwDhOotpkGbR1EyoEAPlZT3/onrJYUi2LOyO/mf20nHbW12cjssfkQTV9yFMIh9H6EG3oS5zNStfyClu/q66gtR9NC93SMl7EER9JcZYSQMdnc5APJU8FyX+/vPzkqcv28mTb3pCCeqE5nUp+cikD/unGNqDmoOVr9KJ/+Sms3EnfE2Rs05sEnb3T9EMC0rUmHZH7JFXxwp9ZANd2kFtjy8o=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52973564-7c6b-4702-3507-08d59db13302
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:01.1282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597226485024758237?=
X-GMAIL-MSGID: =?utf-8?q?1597226485024758237?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vladimir Murzin <vladimir.murzin@arm.com>

[ Upstream commit c41f9ea998f3ba61f38fa350eef28ec6caf0a07d ]

dma_declare_coherent_memory() and friends are designed to account
difference in CPU and device addresses. However, when it is used with
reserved memory regions there is assumption that CPU and device have
the same view on address space. This assumption gets invalid when
reserved memory for coherent DMA allocations is referenced by device
with non-empty "dma-range" property.

Simply feeding device address as rmem->base + dev->dma_pfn_offset
would not work due to reserved memory region can be shared, so this
patch turns device address to be expressed with help of CPU address
and device's dma_pfn_offset in case memory reservation has been done
via device tree; non device tree users continue to use the old scheme.

Cc: Michal Nazarewicz <mina86@mina86.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Roger Quadros <rogerq@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Tested-by: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Tested-by: Andras Szemzo <sza@esh.hu>
Tested-by: Alexandre TORGUE <alexandre.torgue@st.com>
Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/base/dma-coherent.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/base/dma-coherent.c b/drivers/base/dma-coherent.c
index 640a7e63c453..99c969520f30 100644
--- a/drivers/base/dma-coherent.c
+++ b/drivers/base/dma-coherent.c
@@ -16,8 +16,18 @@ struct dma_coherent_mem {
 	int		flags;
 	unsigned long	*bitmap;
 	spinlock_t	spinlock;
+	bool		use_dev_dma_pfn_offset;
 };
=20
+static inline dma_addr_t dma_get_device_base(struct device *dev,
+					     struct dma_coherent_mem * mem)
+{
+	if (mem->use_dev_dma_pfn_offset)
+		return (mem->pfn_base - dev->dma_pfn_offset) << PAGE_SHIFT;
+	else
+		return mem->device_base;
+}
+
 static bool dma_init_coherent_memory(
 	phys_addr_t phys_addr, dma_addr_t device_addr, size_t size, int flags,
 	struct dma_coherent_mem **mem)
@@ -133,7 +143,7 @@ void *dma_mark_declared_memory_occupied(struct device *=
dev,
 		return ERR_PTR(-EINVAL);
=20
 	spin_lock_irqsave(&mem->spinlock, flags);
-	pos =3D (device_addr - mem->device_base) >> PAGE_SHIFT;
+	pos =3D PFN_DOWN(device_addr - dma_get_device_base(dev, mem));
 	err =3D bitmap_allocate_region(mem->bitmap, pos, get_order(size));
 	spin_unlock_irqrestore(&mem->spinlock, flags);
=20
@@ -186,7 +196,7 @@ int dma_alloc_from_coherent(struct device *dev, ssize_t=
 size,
 	/*
 	 * Memory was found in the per-device area.
 	 */
-	*dma_handle =3D mem->device_base + (pageno << PAGE_SHIFT);
+	*dma_handle =3D dma_get_device_base(dev, mem) + (pageno << PAGE_SHIFT);
 	*ret =3D mem->virt_base + (pageno << PAGE_SHIFT);
 	dma_memory_map =3D (mem->flags & DMA_MEMORY_MAP);
 	spin_unlock_irqrestore(&mem->spinlock, flags);
@@ -299,6 +309,7 @@ static int rmem_dma_device_init(struct reserved_mem *rm=
em, struct device *dev)
 			&rmem->base, (unsigned long)rmem->size / SZ_1M);
 		return -ENODEV;
 	}
+	mem->use_dev_dma_pfn_offset =3D true;
 	rmem->priv =3D mem;
 	dma_assign_coherent_memory(dev, mem);
 	return 0;
--=20
2.15.1
