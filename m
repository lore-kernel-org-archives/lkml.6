Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AG47ELtSu1W6gsJwxGF1Ik/GNRJ1pSsNkUtiQpEJWKwn/Qc6CpYd0M0rERxmTaC7o0/tma/j+mmZ
ARC-Seal: i=1; a=rsa-sha256; t=1520260225; cv=none;
        d=google.com; s=arc-20160816;
        b=qMh/NPDwvAseN2RnmdLVv+g1iBHBPzsHcgatLE5dXo21ku35zMHje6kJF62cisIP3t
         akHW/4s1j1vZMcVWq7zoyIABpAjADRHVufBKblRSnx49EJVk3YDwCJ3XlX4nsKYMtJzf
         Y6P0ABYjvoIEaSRkKiAVCtPiy3Cxm8rL5lhhmSyU5fZOYeo08LlfQUxsHIu+zCf2I5rc
         xD34n0Ip233DtC7YQV2Fhddxz5AHT2GygKnfRx6ukjpiefPbcmFikaP6JlGUo3KCAd14
         cKt6wPr9RQedvgHf+ASHtTQMepWhZX46ZNeB3AhHsdi11fBThE3O8dLwJErOWSP/qGcU
         5QKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=1TqDyF1o0R2E3zgyLxQa6tDLlF+BWLisqCAbp3CxqGQ=;
        b=Hx55LfxS5Ws+Ghs5VHFfTTwEjXx3bVW2Gm5NKqm5rhBeY7Ic2AaxKCQW8/CsGgCwD1
         3x4wsjRUrWxzbtL/wUeWmTuAhfa4vjto8DnIRNFVCFa171hzME9eAfxqHG2Vx2a7XEmE
         m6Qfal3X7bfz8ydPuWVLGQfUDU1L0BzwXYo7afcoRA9krdefgE6qtmBLD7rXC8bpn1US
         mR4yTFHxedcmkaF0pRpIdw/kYogXe8IbSx9ROrRDqL9AHSLFIkgZjzHAjv3uENpESRlq
         rBQuPrxScayuOuTls0iraADYI5EcMUhNkJHt1eSpJqKgSLFl5ONQKi8SlDmknwvmSzgu
         e2bA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Ro83ccdf;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.78 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=Ro83ccdf;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 40.107.0.78 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: will.deacon@arm.com,
	robin.murphy@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: iommu@lists.linux-foundation.org,
	robh+dt@kernel.org,
	hch@lst.de,
	m.szyprowski@samsung.com,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	leoyang.li@nxp.com,
	shawnguo@kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 4/6] bus: fsl-mc: remove dma ops setup from driver
Date: Mon,  5 Mar 2018 19:59:24 +0530
Message-Id: <1520260166-29387-5-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR0101CA0060.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:19::22) To HE1PR0401MB2425.eurprd04.prod.outlook.com
 (2603:10a6:3:25::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4dedd1ac-dfb6-415d-0235-08d582a5a0ad
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:HE1PR0401MB2425;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;3:UNmtj6OHjiDaeeD8sixR1BsDydx24x/JxN/W+1Qzvm2uh0omGmiXb6fiijdcioFelMfLK9IZMSiDpBmU73SzY+21wEtv2j1IflFalZIm0Mp9z3Hsw8LdY3+x1f9G9kcqvmD1FXeBpOhbMtATU97NkFGBsjsNlXPr8iPPyFkvyoh/mtVcjGsTpKhrg5U1nC7YUs1eNUpook/8tUfrGZsPfdH1DgljBxkbEvhU99Ynqgoi78TRPoGpNt3xK9XWCQXw;25:9iIfGKvbPV9aC9JfidDrzO6cSq7e7BX0/bXwKxoD2TH1S9bUyOGAXBwXSPYpiO2I183NqfzK7MTLVpu34XL0LdL2Rnsp7nmCbEh1vUhIInIuns+AWuBMpXU8AAsHf4zae9JqKfHtpBHyG78G3JN+eqJIUdC7NajB2vdCprFN2jzMWnHxw0IjahBTTLflRkETKTVk+QZ0IBeSKo4VppRSwIJpfL1lysP/QU3B3YDjowkh86XF73OIq6z/qtIVe9sxZonf+KTjNTtpzSVAqq4+Lk1lI7u/rltXPTsAARE5LCNxZWoI36QKxGdOk3qx1j1XZqmMM1+Am0wDcBpREpNm7A==;31:xUpbhIwhM0CMz0l3JMBHdvV6aZxlUYbXnCTEBJUkGLOnbMzeFcc+GDAKFvInAnCnDD1tupmEBhr1lcbTfDqQGRJnM15e+t2et0k1RaPUN1QnbUcRgjTQRQb+iPj8Tq5Xa+wsciRM+lqE1+p3dbqHtGpJDeYCnnFZg7AhtvsqtY6epT9vbi6fHdsvFUY8ln4/R6kiIQKHUlnie9yYS8S4zEdQdRH/wQbxNbvzw631QFQ=
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2425:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;20:IHaB2UzxIApSxaoImC8z3MIUwOViGAllDZ7qovrEsOQ90p5pzDv0/EL9X/qOFpB32/bu8BqqS8VBwGOFBLUf1LSswfJURzGzEYzpSiG8/rrCdjNsStm/pe3wIIE1w//CkiHyRTe9axR81zLLqkZ7Ffo3rAY0pwurJ1dPXHVY4FKptkOv+DAUYEYoMqxomp9JfWuwNmhiAcBFQU0vkuHhWnzJ6Gl9dqDoOMdAdp8bUPuMLIFHF1yrCxSNvZ65+UNndvZfVDGCiSCYr2gIxhlT3T/GapdTHX3n36hIgW7I/VEWRyCgiJNZHsUauukjOYGHuH6alcjnd2l5QWkDBl862e5GRxViCo4mEOlwRDo1DNwuk9Ljf8LTPx0cokXA3BarPXcg6o1fgRYkpFJxJPtyCBNdj4NEy0ehzp/PcFVb5Uur4qJnajNyBNCE535i5DObgB3E+NMA5eXfn+7b2JbBHyoQ7Szmf3d4uak9d3YJytQ/7eY9eija4Yc2BNbE2P9y;4:kwH8wRg+gsJDY8FdY2XlrckQWDtS0TRPVw9zQgIK/qigVkpakXieagTZWjjhLSa4EpoRqW/U3ZiQG+QCo+VxYanDafpgzd0gQ+wwlyGenrFXy9sdTc1r2i7mA5n6XdbBboqwf+GTkdBkz71QWXi99aesYndok2kzoAyILDRYr0o/5VrzIhBX2XmNIs+QCaBI+iuVZxK5yru9j3iq/kyUPjK5k+LupRixL8r17rANxYUndD8Ue3UO67XYUB2Vny1aSBIWfSWk2WVPSjx0g+ALTXIic1CPhyCdCDwt0oxVdwxJmar6R6wt4NwSWgNkaSJj
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2425C3DCDF47DB4663CC2A7CE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231220)(944501244)(52105095)(3002001)(93006095)(93001095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:HE1PR0401MB2425;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0401MB2425;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(39860400002)(376002)(39380400002)(189003)(199004)(2906002)(47776003)(106356001)(6486002)(3846002)(4326008)(316002)(39060400002)(25786009)(5660300001)(6116002)(6512007)(53936002)(2950100002)(6666003)(97736004)(8676002)(81166006)(50226002)(76176011)(8936002)(81156014)(5009440100003)(386003)(51416003)(6506007)(26005)(16586007)(48376002)(52116002)(478600001)(86362001)(50466002)(66066001)(7416002)(16526019)(36756003)(55236004)(186003)(7736002)(305945005)(105586002)(68736007)(110426004);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR0401MB2425;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0401MB2425;23:kmfJRzfYpOmjn0gC8kSjFvb6GUMG4teUfgJtvA3?=
 =?us-ascii?Q?xqK1tc6ZPnBFonnJ000SZQYrYSaYtTU1TqU5IV4/t3eXhVqxVT1o0dV96VpP?=
 =?us-ascii?Q?LxqicrA0Vx0oMfrtkBXOSCXufzlfFgKEclwtuaAvt/ksWEZgJYcWE2QqGPae?=
 =?us-ascii?Q?zDMU8g1IN2dViz+35L6MHlZEsqRKl279+kW68ruGiKbrtnJp1hn7YCdyfGmZ?=
 =?us-ascii?Q?aE5z0s0dXyOu9ZmyqJIR7uGlk8u0Ob/cnlr5QoE8cgOW0WOjqh6o1Prquxnl?=
 =?us-ascii?Q?vbjmyB/UE6Yb43uh8OyAm9uoKx10SLfBmV/gxAlc8gstX1I2hIkJDUiK5D6Z?=
 =?us-ascii?Q?u0H+86Yk0JqP42JhvRhf3mZhdCMCNV7tPCtUpcaO7FbSSkVuA5fxRX/a2cic?=
 =?us-ascii?Q?1o1Y01RIMGoN59+VymqK2vh9v5OpwAGVcSmLA6Apf8PRJsevFV2ilFGC2LHz?=
 =?us-ascii?Q?LObO11N3O/E8gH901KckVLR+38cxkK7/RofdUJyXQQCUoft2GR5BVtDnkAqH?=
 =?us-ascii?Q?hydUl/mMpfxPhkjFyhVSYABr8fGNzHDIDYfp9Ll3y+hbF4PHUdRE3Tlr/Uu2?=
 =?us-ascii?Q?DnM6qJJxLjCdVcnVE+T2iYk9lMKX8PeDWUm3NeYNXnapr50qk7GqBy1Z0z6b?=
 =?us-ascii?Q?s21+hYRIJEcrCzAtj3fByriUVmE3UFWXFyZYc95Ry1lUbkNEwcMqzlU3OzTw?=
 =?us-ascii?Q?CNk7b7UOnuZjndVglChUyo4MoHEk+HNQcesXR2pUjQt53+vI1cVNeViiImy6?=
 =?us-ascii?Q?+bdsGeIk2EZnF6h8MIf1VdFK9fz5Ah85wNaYOSsY6o95a3GGjeRjYQyo6SRK?=
 =?us-ascii?Q?x055zZcwCmC7gL+W/d4bfE/0iNRGTpYZAfTm6wM/0rnlZgktq7ycBAShb4rW?=
 =?us-ascii?Q?yAxhvQWZV3gx9Nh6qlnIam2ykZHUnmsUl/LhOdFbbVU5nDtP1APTLyVXoEki?=
 =?us-ascii?Q?0kv+uYR6RU/EW3WhLhkyIOQvs0mQB4YFFX2gM3Yv8lT5bIJa9E+ANZOeE0IT?=
 =?us-ascii?Q?s8+vC9NuCATXQ2O9wIjQi0mmhDsRWLxdcBUUVZT4QMoGeOg3McWEHD5XqGsE?=
 =?us-ascii?Q?gKXEK/52zvCn97qg81mi1ha9YPvLJHCROAE5lPuLfZEiFRuNswMavzSDRI/2?=
 =?us-ascii?Q?rZmDCj5KklB4QNHlt3hfxtqKiEN65/xa71DJj23hLVXV9H3TfU2+1VLKdo+U?=
 =?us-ascii?Q?3mkGMOIFbVY0omnSiQKvKCf18ICVTwXhkr9Ji?=
X-Microsoft-Antispam-Message-Info: DMUm67Z486Gm86NfVCDKwv98uwKNGpfpC8fq7tVwseJbXHnw64RpqG5Ub9QIXbXAM0Q6xd8AonrIW1D8fkjKIo7zg8/NWofPs1IH1fe043ptvQI7uXhj/o878X6SImmO18JLpMepf5dMStBQxrU6+gRjf2FZlmvUwPmkF/hmNzyWzafJh0PlKYcri+EY22GS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0401MB2425;6:H3RwXbjsl3U7RgtzkUC5+4YB2VIVEdez1aiR8h7FIK/1hwUfz3+nWJnRGK4GHfegwPbR0/X/qQacI7U9RPVaqUT9MBy9xUQMN2oGoIs8V8Haf/GPZ2+Lvy2JhQrxLmETIrV5Gd8J2esB0hiOq0DD677n89IBXkPF+D19jaNTk88bdLVoCROsq3XhK8LUg4tvIoJ6Wr0JX9X6HKlCt7cmIRqFmQD4zKVOD3DJTMPK0YW2HBsz1KCNrjvJS+iR3HB8RsRndqUP/D/7jdrmUoTeLyD9pDxsnafz88BD62+6p98yC0EP5xh18opJr25SWvIHqbjukBjvTD9J1UGWbAWjzxFG22oT0mnaXGwdtKMT7qM=;5:CJc+DLvJcHVR/uItepUBS1GOoSXoGaRs6yPc1NTVSrOaCkLdEHjOpZ7IXnQObPxGH1RntWAIFUrHOjyRB2V/cLKvgBd50EX8W5BZ3L9fS2LjmkQj5kjd8183XYi14f0+Cz7MoH66uYMHXD0Pna8o8atNiDLgzkM4VJxvWQz95ok=;24:FQCs4mZaT0vJU4pvTsqCBLP5Y2ITIb9U82WJmRlB3cOE4i3VL8QYfKyEkmFzn4+JxrhZT4z2lQKaQW3bJ6w9N6EEBy2C80Ob8tXykM9nUko=;7:dkCx8o222nORPGcACRVk5FX+ypObyLmKW05FFiDVXUWxENo8Zu7MUGLK0LWNVDX046fP5QGt3YLT7bdNM8K7Bb1/J3tFZsI9iOTMt+W7U8ciaAsaa5gJBNIHWkOad+JrWDgzPfbXVitjSD9zlYQPgY6lLJkJi6vwAbcVwWNb0Ag67t9GcHgyqVpFaYlxKviSrY00dSuOPu/1m1978el928u3pWG7CLw/aBToE1X8AD2NAPIYPzlkVaFuV6tAfTc6
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 14:30:18.3294
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dedd1ac-dfb6-415d-0235-08d582a5a0ad
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2425
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108386596483478?=
X-GMAIL-MSGID: =?utf-8?q?1594108386596483478?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The dma setup for fsl-mc devices is being done from device_add()
function. So, no need to call in mc bus driver.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 drivers/bus/fsl-mc/fsl-mc-bus.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
index 1b333c4..c9a239a 100644
--- a/drivers/bus/fsl-mc/fsl-mc-bus.c
+++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
@@ -616,6 +616,7 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 		mc_dev->icid = parent_mc_dev->icid;
 		mc_dev->dma_mask = FSL_MC_DEFAULT_DMA_MASK;
 		mc_dev->dev.dma_mask = &mc_dev->dma_mask;
+		mc_dev->dev.coherent_dma_mask = mc_dev->dma_mask;
 		dev_set_msi_domain(&mc_dev->dev,
 				   dev_get_msi_domain(&parent_mc_dev->dev));
 	}
@@ -633,10 +634,6 @@ int fsl_mc_device_add(struct fsl_mc_obj_desc *obj_desc,
 			goto error_cleanup_dev;
 	}
 
-	/* Objects are coherent, unless 'no shareability' flag set. */
-	if (!(obj_desc->flags & FSL_MC_OBJ_FLAG_NO_MEM_SHAREABILITY))
-		arch_setup_dma_ops(&mc_dev->dev, 0, 0, NULL, true);
-
 	/*
 	 * The device-specific probe callback will get invoked by device_add()
 	 */
-- 
1.9.1
