Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpz+cjbA8EkU+GMLguzkOs1diLS1eVA0ctFnqQ/zTWmc5IQNYdPMB3gsN+ehTfGMSBJAtSY
ARC-Seal: i=1; a=rsa-sha256; t=1524824872; cv=none;
        d=google.com; s=arc-20160816;
        b=nttmXZxnXfD7sPsPjN1NEoT9pYhPNXyRLOSZolYrGff73HlsVEGGhEl4GAMwENJhUw
         yaQJC4PKWZYwrKSM5Jnm/YgUTZN98xVPujrbh5xYmDq/T9HcTWvq04jyk9h1V/t5On8h
         0fSYT5NqRRkx5ZWaIjKSEA03M942EN/ZT7JtBcMsIlvCX8/cjRd59pXd2eQ2K+uKgR0g
         XN+YY3D0TemMRloNgZQefQ3D+lSrfm8bFWfiVfrgWgykFLioVGnrlySBzC7ysxbWnoBM
         XaEz8AS4cTaTKk4X04dcoJxWEZZQei8/0jSVF6CaQs2XrDUeT+Xp9s9VHAkPLNlgpEGc
         1Jqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=u/WFSTb/EACS4rWR0ioTSm2SudUBMIHYgcb6KTmkIRM=;
        b=QiI1Ej9iWVSVwoJ09vSHg9tG4Yv8paEXt+47u0gMTE6FW0asG3c6qLaxQOxyspdkBZ
         Mu5T+Or16YWKkyZKX+5+DCizARJBG/oXWGhxq7l+Xqjk9AIxAsp/hLw0Hm5ncZNEGCtB
         2XxdYPH67bXkrIkVY62KhuvHc3YEVn+2ptw4wGb0Mm5iJ2Xdqo7nQZKRL9z0mBUMViaH
         2cPoi8FN/8BlIst3pKZUBhQ2ejXlF3OgBua0aIzsspmswwbGJyvCmEWVqHzqt+eKPDG+
         jOCT0t1gzdbPh2NvFV6BfdF8WbpX+TTbI5Y2fDdoy/5ajjAgh9YmeHsPfAs93lgC5CJE
         GwMw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=u6macMpA;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.46 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=u6macMpA;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.46 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	mark.rutland@arm.com,
	catalin.marinas@arm.com
Cc: hch@lst.de,
	gregkh@linuxfoundation.org,
	joro@8bytes.org,
	robh+dt@kernel.org,
	m.szyprowski@samsung.com,
	shawnguo@kernel.org,
	frowand.list@gmail.com,
	bhelgaas@google.com,
	iommu@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	bharat.bhushan@nxp.com,
	stuyoder@gmail.com,
	laurentiu.tudor@nxp.com,
	leoyang.li@nxp.com,
	Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/6 v3] Docs: dt: add fsl-mc iommu-map device-tree binding
Date: Fri, 27 Apr 2018 15:57:01 +0530
Message-Id: <1524824826-29473-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: BM1PR01CA0096.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::12)
 To DB6PR0401MB2422.eurprd04.prod.outlook.com (2603:10a6:4:4a::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2422;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;3:gC+gouymcYT1l25huvU9e3a9RckwoeCwKipFx8ExqDHrW3J6q8vnMBFi01aTFsdO46kfYOdTjqCK3xG2Kzl0D5s/wcq+cfM3L7dDGa/I72OXqRHUD3pOnvprOShMRzMP/ZJfSiMntBzET8Y/HBpBobxoWpv33LwTJ+bVqBJIC8LdFDB3IDvpIeylDvRRNa08F/lz2gZoF/e1Std1J+Of57IEyUYljMkpx91RtP87p39bFfQ/g0/Z5Kp2NglVtBeT;25:VAlNsZJ5299dIo/7zCAtYx+p7iasFg4AzSCKLtulc0LsMWmFzfb4eLUgd5nG3kg3LFubNkspgpJQRHwmSy2XJ8wSH/jfET7lBej1nfwx0ny9QnhRsomLnRM/H0OVvJfSJtYTvBK8HQGpRmHeXwTkWb4ekjBF9fbc0nyziVwxicQeK4j4OLLxiV12/H0hsnM/L6TzL8hYGru6CGTEIlm70h79aWDq/vCcNPA0m2BWmoajnDY1fhq//DTr9fZ/Zl2JyycmcWseKDkHEFp70WqMLog3zzdri+YWSh4MF9bmzUKO+rJ5G1solkXctGPL3y0dJ4djion+ykjn2JkSFSmfog==;31:8n3ZeO6Mh+gQ3dOtyPtWHitT+fXOXAu6oh33TlpNzcjw4IXv6glmSNb5oY+uu1HoT3jztC7gfX2kt1+Rq63MKD9lsCunBmSPhN2I6X63baQ0fr7g6dK7+Gi6k+niCOVkimObgHtfShlGdbzq0gaQXGlDnmiK8Tw6e0idxgYy1eXZT1ZhpA8e5guY4X2E/XNHGOlb4YJ1yRCj8GD8B+lUp6FIPGyW8V5oojvpkztfIS4=
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2422:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;20:s1M6MRHIu7I4xO0gYiRuOkE5NihuOGlMSoIDYaujkN65JMhlbfrw6djIer5sQzSvvke/1Z44NiJyfoWF/VOzfDBJ8JSu0kjQvkuevol6lIcGZg8JyGUUdKypkDYX34r9BBHbszIYeqDBEFlnCXWcjedXhrUk7DsnsW+ZY2ZsMXLK26TzWXNwurb16eDrNTKD1mEBar/INsIAGfekOlGru1i3ESkQRyP7+HbPTUWxaUvKySFmFJCUtDlwiT7rbiQ0pzA0Tf89IXaTxMsTaNawxITHAQZs/NuIjQgTnMjCrHYAn/ypVxC1NTdkGCThVZAmAv/ySIA24ZEthPmcHrHuytQB+UyT+VsPZ+pbBcuaMY4tUPMc7b996Sgk35p7kClBQunlgWAyY9TIsZDsXmfTETYOxlQ6bXd1Bq4wkFwGET9elKrHru7S6Ed6JgkMf1BkgX/s/1BPcpw9bndfpNV7p0l8k3aRBpGT1rdzK+lENU0EKev+EnT1vVCzSG53FYbV;4:aH4da/4/7SRAEPvYX922I9XMHSLMEvHkLyEHdrYMw30ZeQCBlSKj4e4E4/RxnrnrdhblEp+WtandYT8ivA1CKOlpTDFMu9duGCrVdH4itHdb4E+OBz5FHht8GRmBu4mra38u6ECTilzTaq5Sz76IL6FUoG58KJxmcNg8IrGuXHWxgJvxqZ2y3gg68J3AjwMd4l8qrlK6AUSswx4kC5L0DEUACsPyw1EmEsNS3MWhhxygIAI3yIXWiLuLIid6/NGx2oFH1HjnNF+/ueH+OmX/PasTtNBXp0FWIu8X6lTLdy2owsTMlKi7ZRscfjhG5GnR5Y0xRjhsprIAg7HbaH+4HZ31IzIBMAZ/JtLuiLrkvKY=
X-Microsoft-Antispam-PRVS: <DB6PR0401MB2422A2A5641E3A9D6A0DA7A2E68D0@DB6PR0401MB2422.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0401MB2422;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2422;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(979002)(366004)(396003)(346002)(39860400002)(39380400002)(376002)(189003)(199004)(2906002)(86362001)(8936002)(6116002)(3846002)(53936002)(25786009)(5009440100003)(305945005)(48376002)(6512007)(6666003)(6486002)(4326008)(39060400002)(16526019)(186003)(478600001)(76176011)(52116002)(7416002)(44832011)(26005)(105586002)(2616005)(36756003)(8676002)(81156014)(16586007)(486006)(66066001)(11346002)(50466002)(51416003)(446003)(956004)(97736004)(106356001)(386003)(575784001)(68736007)(81166006)(5660300001)(47776003)(55236004)(476003)(50226002)(6506007)(7736002)(316002)(110426005)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2422;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR0401MB2422;23:tDOXjw0Uk9cZ8rS5/VpmkgUlSG4eRVm3Vzp0teF?=
 =?us-ascii?Q?dRfDzIo+b50FFHOXoJUmD67ZwWGJlnQIwQcFty3ySqfs4iAU85Oppsce54wf?=
 =?us-ascii?Q?9Nnw8eKAVyJDexKCaT4Bgvu0cyPjNlOHrXM7ffKzeLRCly1j4heV6gjnk8I3?=
 =?us-ascii?Q?y5bI/MXbU9MkFokP8sQfxMJ/vcyBwqKk1DOgbXyBtzZg0+swKCZeF01lh/B9?=
 =?us-ascii?Q?CXj63q3Rg+rCUHH3bytNTWOnppxGoT30Kk359tl5I8vX0yghAPWZbVKQx/pj?=
 =?us-ascii?Q?5ll0rODJyGCQsGSBDf4mtJiaZuoyzenyzb1dSsSnpW1++9LM47CBkp56MjRW?=
 =?us-ascii?Q?jXs3QtJVZDEVsiODwQprcG52DWLI+C3FQIiSrBe1MYZVm/mwyTKQZCMWP/B/?=
 =?us-ascii?Q?uiqS0bQpW7PlhmnZroYKHYBZIZ19f+S28wjTdw39Fs8nE2FbboPcliiFidYk?=
 =?us-ascii?Q?5833Ukw2mTJpcOOzK1gU0ywlopil4EFy8Wv3vfrJMZpvQj0JKhC/wEZr9eC6?=
 =?us-ascii?Q?Ns0fe32dYWmYyr7ns/5ZzOB65oJbOJgYhU2C2t64y6nQOMIXaQgnropJCrKY?=
 =?us-ascii?Q?xdWkZd2Des9Zw9w4EdRYNaHqM51wuDBgDCPPLGZmTTINZ7NhnGZnZrirBDpK?=
 =?us-ascii?Q?mkjaW2KQyDnVGOnjw14Ss6whzKwrFPbxwF6p8+aKsUJscbOj3p5u3GPWE/HP?=
 =?us-ascii?Q?oFDQ3AGJRJOBkOOzTuXagUkrU2HI9jLECYwZWsNid58ck19qNGA6j7GxZ5jl?=
 =?us-ascii?Q?oSmSQ5ZcQHprAou/2OevGaUu6WNJFAv7v4eMAV/E0thpsOfof8++KtZ5GpJh?=
 =?us-ascii?Q?lR0bUezjOrSGQh0sD14cTztbo+z8FN+0BkCa+JsdmIq6hZYf2sTSQ5GQqgtB?=
 =?us-ascii?Q?B7UfMA4YrIAXlCTbt0I9LX9zVTJbrHT09rNXZ3I9VO4GubniXEcJFRLirJHc?=
 =?us-ascii?Q?XcYpP03tCqFzKROpU3dUUFcYlM+JA57xG4OgqqFWPdk3KtjhPYxMYQQ/zep7?=
 =?us-ascii?Q?ZZ0AaqGujbbfszpz8SIPMxmO+AOuy7aCC5lIjsAkltnOVEcjSAOUfJEN2Iya?=
 =?us-ascii?Q?ikHX2DQXHsiUdRshFY+sVZY8UrIW14+bU3MKJgcxRRiYeAjWYgf1F+jOklf3?=
 =?us-ascii?Q?S+c7KfaPqZYzBGB7BEpjMwfhaoZYc+4SqoFyKqxpMYlIQYjeZacDdq+ryiCm?=
 =?us-ascii?Q?Wo2vyxlF+djoKa9z4fSM6IoLWSnl5toEuNh+Rir90gMFnlWzYO/Y3dpoDCo+?=
 =?us-ascii?Q?uaNmYa2zk98EHoRxBi0FSdx+EfTeHjKtpMNXkaIzzQU9l7abQGhTCt9+ezGf?=
 =?us-ascii?Q?0SVSr0hnXeI3vR49WwbCgRv5lXbs/NBWHPH4mwJhh7XW2o8CpaaA2s+xxBRx?=
 =?us-ascii?Q?veDBFTl3W7soTJSmsli3xOe8lkseTy6KoLosJU8F1ke0xME9nQ20UFMdPFN7?=
 =?us-ascii?Q?gN56NMH4qAQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: zdynGy4cIqn9Jv/ByuqC8LYUFBDUAS1Zv1QjU59SnoGbuRdtCqez1FaKJ9NLX0HBX9iYhNMhjqMRe2lzNKr/VKaNPaFwMQaW3YvArdvpGJoEy09v3crKrf/milegmQ1FYdnHRKj5B80GkNT8Gyn8CX0mXPLoTQ6Wc9VXkCxpWikf+mwW2/EWkWHFzjxlB0Vy
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;6:8Ozqdi/fvXOQcs61kxunqOZiEV49IizlQlLJbr+03FFAdlkoJd17P1rTcVP2b/VNIsK2I1CMkVTb0Jaij+Uux6QurCF1an1EGO43f/Ft3tP4eSwQGCeuMaeve4sU8MIzVFtUgvBATLkAoX7hlSzjtO6ScAiIiVLjp0MTREqJoHkrX8jYF8sOKdbWXgnA/b6Tqgu1dzi3ReP25/ixtpI3JwFb0BYwX6ZJz/4GSzTBXou/hJRCnyagIcBrq+/AY52aAh+FAeS2F9Sm3AyrAUv2aGP5QT6KwZQnH+POObCtnV53WpOFK7N6wWqftmBnmoDrfn3Hk5QQPs1sD35hYpp65TGF5Gj1I9bFPbg+aphBPNusrlKXDSqnCrsj5fOsR6Bx/fTqM4TeggWOeFchu7qXH737F85yI8BCrJtD/NhSbeamcX+36Wdwg7X9MFe5ivvX05rQIFwoAHf0jxHc7YTtrQ==;5:P3msjOo0hdP+YJJcn121qLaoNyPxvMqw4EDzOpWzMWnv67iQ/mbQ1sHfHo+rLjnYh3WxLBGyL00x2II7l6JrGB3zbomRahTAcgJ2eKllfxrHvkyhUSk9N8w4hrRZ8v3j7RRIuk3Laka48FRLtTrwTS1yAJg+hTxN3O/VXzG91K0=;24:7anm6jU+iMqsbM4rKWitbDkMSJWx3oe52I/id0VFax38cGztkB4b+SoT/l1fM7rOdnhwYvuyBL39WNYa/3QAydWIeKZXxTzV5x75W+YNgxY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0401MB2422;7:VPKvpS2w2Qsb56H6sNMWR5RjhJhy1qStZQ7qIYnvN3U7fRLEyOCZqEZ0gq4se76q0k7Kzl6IHao/88QndVsU6FqpsOg7sXBNQfwmiUBh2qtte4/JMo2NPPMBCFXCt8ARuV5fYhMsFB5xlE6kO8jba1JJ4KNzyQDE88cSG2CEbNJSekNdxkmNqjN5hgaxGftTIkgagDL2ArvEMN3J2+ft7nkZI+1Hv60TGNwe+UU16/tLUFQ6FvjrpQC49YyQ/c3z
X-MS-Office365-Filtering-Correlation-Id: d25cbb0f-4cd3-4ab2-587b-08d5ac298634
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:27:45.0350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25cbb0f-4cd3-4ab2-587b-08d5ac298634
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2422
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894765369527254?=
X-GMAIL-MSGID: =?utf-8?q?1598894765369527254?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..8cbed4f 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+drivers/staging/fsl-mc/README.txt
+
+As described in the above overview, all DPAA2 objects in a DPRC share the
+same hardware "isolation context" and a 10-bit value called an ICID
+(isolation context id) is expressed by the hardware to identify
+the requester.
+
+The generic 'iommus' property is insufficient to describe the relationship
+between ICIDs and IOMMUs, so an iommu-map property is used to define
+the set of possible ICIDs under a root DPRC and how they map to
+an IOMMU.
+
+For generic IOMMU bindings, see
+Documentation/devicetree/bindings/iommu/iommu.txt.
+
+For arm-smmu binding, see:
+Documentation/devicetree/bindings/iommu/arm,smmu.txt.
+
 Required properties:
 
     - compatible
@@ -88,14 +107,34 @@ Sub-nodes:
               Value type: <phandle>
               Definition: Specifies the phandle to the PHY device node associated
                           with the this dpmac.
+Optional properties:
+
+- iommu-map: Maps an ICID to an IOMMU and associated iommu-specifier
+  data.
+
+  The property is an arbitrary number of tuples of
+  (icid-base,iommu,iommu-base,length).
+
+  Any ICID i in the interval [icid-base, icid-base + length) is
+  associated with the listed IOMMU, with the iommu-specifier
+  (i - icid-base + iommu-base).
 
 Example:
 
+        smmu: iommu@5000000 {
+               compatible = "arm,mmu-500";
+               #iommu-cells = <2>;
+               stream-match-mask = <0x7C00>;
+               ...
+        };
+
         fsl_mc: fsl-mc@80c000000 {
                 compatible = "fsl,qoriq-mc";
                 reg = <0x00000008 0x0c000000 0 0x40>,    /* MC portal base */
                       <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
                 msi-parent = <&its>;
+                /* define map for ICIDs 23-64 */
+                iommu-map = <23 &smmu 23 41>;
                 #address-cells = <3>;
                 #size-cells = <1>;
 
-- 
1.9.1
