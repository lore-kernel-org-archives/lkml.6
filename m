Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA5BC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF6B20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dW1IhKTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF6B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbeIJSov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:44:51 -0400
Received: from mail-db5eur01on0061.outbound.protection.outlook.com ([104.47.2.61]:34336
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728174AbeIJSou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdRUE4YU5k4GAd9F5Z4WTw0gnOdOkOqibyLlcGGJp1A=;
 b=dW1IhKTg6Q1DGK0PIzBrkL6uY0TRDsuOL79s+lmIpjNlJ9ATHPrGlSYXM5KupB6HdTBbnKqMArI3uKAiR0srwqrTKAYJn0NfCCCQEbk8TcZQApsccIlV9PcmJqWUEt9XfUOMgGaKJoNtHXXNsio141fayBJbtokEpJsNKDnSjUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com; 
Received: from b27504-OptiPlex-790.ap.freescale.net (14.143.30.134) by
 DB7PR04MB4476.eurprd04.prod.outlook.com (2603:10a6:5:35::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.17; Mon, 10 Sep 2018 13:50:07 +0000
From:   Nipun Gupta <nipun.gupta@nxp.com>
To:     joro@8bytes.org, robin.murphy@arm.com, will.deacon@arm.com,
        robh+dt@kernel.org, robh@kernel.org, mark.rutland@arm.com,
        catalin.marinas@arm.com, gregkh@linuxfoundation.org,
        laurentiu.tudor@nxp.com, bhelgaas@google.com, hch@lst.de
Cc:     m.szyprowski@samsung.com, shawnguo@kernel.org,
        frowand.list@gmail.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        bharat.bhushan@nxp.com, stuyoder@gmail.com, leoyang.li@nxp.com,
        Nipun Gupta <nipun.gupta@nxp.com>
Subject: [PATCH 1/7 v7] Documentation: fsl-mc: add iommu-map device-tree binding for fsl-mc bus
Date:   Mon, 10 Sep 2018 19:19:15 +0530
Message-Id: <1536587361-11047-2-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
References: <1536587361-11047-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.143.30.134]
X-ClientProxiedBy: PN1PR0101CA0049.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::11) To DB7PR04MB4476.eurprd04.prod.outlook.com
 (2603:10a6:5:35::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e08c51-b0a8-4679-7cfa-08d6172453eb
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4476;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;3:1pxJAvNnFjVTdIz9azs5X0u1Sn/uxZVwW29nifFimK/o48y5JaGN63sqGsrAtLW4hnp2HbMNPu5b4FshtVkF3Sd/N5lu82Uzw86BOlAKNULaeTTlwwI2AVOY0R+a13QQ3hDxcuBFvu49kKba5ARcKttsCNuqfKBssvBKWNg7DRs2GaVT+pirreuSdHaxn4h05cvCRL7SglfBUTOrSjWgPomq6HonP9WZyJ0YYnrgSkubRc6Fn6BSooCtoUZh75M6;25:95cUOj+G6DlAgXk917mj5lfuPwcQ4TiDRiskEISmvMoHzVw8HavJl+Bp6eKffS0jImZoZfa4QyGtvbTrXZtqUYhMYhRJFRP1OeQthomgJt4XOuD0Pt6Dsgw/dQCvw9sC9jcm+X/CiGnEuAnG4P/mY40c4cAxAdP9I4QJbSI96G1SH4vSFsbviNOG4AvxdsZR2GW3bjg7S5vFoiXxBhLYHwHj/NlnOPyTqHaNAJLTmoP306eRbUyOUz5iNq/beZ5KWu1eyK9f+y7AJ0bddShXehUmvmFGkZU2WWw27LgD0zlvzEof5Ny/CU7C1FcxM2Z3oCgHlmvYxN2KKJoQdUcp3g==;31:tfTVXZtEKQdoAbKF6dOdN1ZHW2FyHFA4/7DOEfn8f8NgpTnVMN5kyHpVkTSkk4jQ1AQsKAG8/nkphdHFYUzete2G5qgEeFvLte+T+3diw4lXXGYZiiJshogYjNgtDm0LJy7+EXHqppnuBlGpv/Nitpjd/J4NExT9NXNOf3tIvBSer5o3L1HbnDIZlJUx/eH/Kx7pjt/tpaNVPc6W3/YqoNiR36AVcBjMQtl/cESvb8Y=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4476:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;20:vwAjOjxsAhGolBbGuZZtuikMZrX+DC1XL3TWCaXUKVPONNMx5zN6QSwaCOoEj1ZaA6YLsOCRt6R6mOFKAEwvEBuq1nrNZB36QYJu3jlLOdnrjUBLQiIuCxKCLfGW+4G+VE3qAVi8O1B5qvJ0UFIpn4vqNJdI+Ykb3MS8JVF/GAm6XLzvQ8KlDdM9QQ4Mozfm+HFkuxXF/0IP7YQETTavPAekkA1UX9SRYbhIFmqcE5a/6kjGykB5P6y+jhDfXJga868Vp87j3e035vqe5nH9d+z8DAfUhdV40XaYHquT+nfSPdTZMpQvhMh3PzxnSVrOltu7Ho+7EIyjfLDH8f2DtJ0iH1v/3rnuHYbbNXGZrVpFu5tOxocFy/iLLVW+V4Kv9Aay/05tNTQBJJYqRxPR6LY+GwPH70XY5y1RGq7fo4MNeyyplMgt1aF1rUga1w3xlmJkDx4OjZoGcseN33HZM5+f1OA13gWHDub/r/orBRrO3JdodqOX4aAlvH9Xbafc;4:X+WCI0N4TU1fclD82S2snI6toIYKwMDikaI4txhGRG1cCj/Fz1n+X2iTVJ071BxDatlEaHfP41s38it7XzcTx/UuvAz213hSnDWX2g2/USsZ9IDnQUZYGrrO0wuN/Y7K3HtA7U189OI0jmP0Y17n+Y1wZai8C4Tsm7XAlOlJ3OCpqHIgIPOL7Y/gRcdAtTjIqllsV4qcyLVbi0N7Sywb80PGnUOnB/CrrFmMez7GM+UWlMeAI8pTIAgeP1rda41AUYi7jss1/KhdD+THUrgGSp/nPvaa6w3QbHXL6+nZwUZXL9u8iCa2og3RUbAL1ujzBYgCpRtD3we0Eu3TTNCNaTrJwuCm8l9nVkMSaE07zH3eTq/vIvlis8F6XSOy/mJy
X-Microsoft-Antispam-PRVS: <DB7PR04MB4476CF3C0C057D38F7CDADB6E6050@DB7PR04MB4476.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(185117386973197)(275809806118684);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(823301075)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:DB7PR04MB4476;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4476;
X-Forefront-PRVS: 07915F544A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(136003)(39860400002)(346002)(376002)(199004)(189003)(48376002)(81166006)(8936002)(81156014)(105586002)(106356001)(44832011)(53936002)(47776003)(50466002)(7416002)(316002)(956004)(16586007)(6512007)(2616005)(575784001)(476003)(26005)(186003)(66066001)(486006)(11346002)(25786009)(6506007)(386003)(50226002)(446003)(2906002)(16526019)(86362001)(55236004)(6116002)(3846002)(97736004)(4326008)(68736007)(7736002)(5009440100003)(305945005)(6486002)(8676002)(478600001)(52116002)(51416003)(5660300001)(76176011)(39060400002)(6666003)(36756003)(110426005)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4476;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR04MB4476;23:DsrrW42ZDKgvRIwUkHZzvoliJFOYhYdv4HpemP4Yw?=
 =?us-ascii?Q?drRUYndOO2VcXiYhjdS16r5hEC4cnQ2z8JCAGmBNoVSIqdob8AdxThhvakXk?=
 =?us-ascii?Q?jdDCMwadU0QplF/bf8V4B7GhF3fgQoGwfSlI3pgLdru6f/Bjibi/C6WlzRT/?=
 =?us-ascii?Q?maYMgR9v8smkAH0L32Elgy4dItNkpW/+XJrL3anQ4JwnHj/hF61OPMvaUfHF?=
 =?us-ascii?Q?coRhiYHZvqLpjmjGijPswHCUM9GzfDE7F8hbpiRheDv6rUaNIJIjjWCq2GL+?=
 =?us-ascii?Q?q9k9SaZOl9mkrchJJ0vO3W7x0iqFTXZFKXAyb4SOwWeZGWSbXf9tSSiIbGqn?=
 =?us-ascii?Q?E4vnzfJfpfsWMa3v8iv5nqTDjwducAvJX8RTGBeCdMIh68+igY9v3g/E/36y?=
 =?us-ascii?Q?zF2GFJyYte+frEVKK7d7qMLgEAxTdU7pcygzXy5bk2BD2OiXmORXf5sAaq6y?=
 =?us-ascii?Q?fVKiiifRxrd4FeA9kivIcHuJctpJQaiixY0iOQO6x1HoQbEsvfOjdek8QlBy?=
 =?us-ascii?Q?v8xP1aIiBeQv27EbhyvkdfABlG4UYOaw9vigNFZIOmvdGx6yvkpDI56AhK0J?=
 =?us-ascii?Q?Fy0bsOCdFB2DzBLNI2s12nFwyvBL/Kq4vzNRDAALnEIpD8gm/jc480XLQW4D?=
 =?us-ascii?Q?RjrxsNtZofcT3KUA5sM+X3Cso1eh8TmjsHkIl+mDsMXEue8WA08cbdGHy1z5?=
 =?us-ascii?Q?+yuGqkoy5IRzzLyXc2RHakWNeYE8aGUdshiinonUSMjS1SM2KWkR79lWYl45?=
 =?us-ascii?Q?sQRQjMSkLxxwbxsOuMxkimdXr64JOXfgU3HByp5Dtg8fVzyqSEgx1rQ6fOWz?=
 =?us-ascii?Q?zx+vV9fvFjx3RA7KSba8L3eEFBezV6SkBWTpoDXv3K1qcst+JHqswNfTT23c?=
 =?us-ascii?Q?MpJGgNVGyfsiZGuzPafZrWmTBhXZ3+pA0tIMAitlybBznR1q6r9WMH9km/Sk?=
 =?us-ascii?Q?LLvFqiulPUqvIj3vxDXV868nxZWf55r4Oy7dY1/K56k+bydzAbMMq4nYJOXl?=
 =?us-ascii?Q?JojRVcHcvkJCnYPGGwqvAFQtJlYwlRgz3MHzf9hfofA6UjDrW1gxSSePBAte?=
 =?us-ascii?Q?Wc72WLKR36Zaj/ZvXoXVOJPHMVPyGIOzUYJenkV0UQA5eK/NkZ0x5HhQKOZB?=
 =?us-ascii?Q?/eZf93wmRUn8HIHmYiWQH00oXySObJ0Ibj8mOiXOAdN4MD5Jd8Ra2Azpju6l?=
 =?us-ascii?Q?FHy2fs0GRKYGkAkI+8+wxZJ3XnuDDirsC+rUpOFAYURg6a78HmXo/ObJoVDI?=
 =?us-ascii?Q?RUOpFZZU926Pe29bkB/6z9ucG1uvdi1rBCdTjE+wWXmpM7/sJCk9w0uJVPY+?=
 =?us-ascii?Q?gHrRjykr4dFCIEca/2GvqXxzIjzEve1OHJVqliSzu7qclq7ovpYleOWRWF6D?=
 =?us-ascii?Q?VUKQg=3D=3D?=
X-Microsoft-Antispam-Message-Info: +X/1hPUKjypT1NpmQZzR5nkgj5rgc3JXo9jNvO/PLTRifofCg2u/ZaH5G9Y3tRvHTwbD2oBD/AqlJr85Zon9ZnxKn2pJU/OeDtX4Acs5DOr6Ugh2qVJxykazagtoytMm7vYoqZhtHTUdU/BL+jSfxHSQqeQMSt80Ke5gnZGkAnY35MoXvCi1KD5bkp4fKlpbuFq8p9kEqY+lBVG/wz9yt0cnN6aDKLVnpaTMjDTGyVh3ONsB6KCEyOfWswx966vqyJxqt+BWefFD7c4EneriN8Wby7NSlrkAQNGo8jyoPxHWy57TG22iCsCr0XFhpHx4sMeM+x3LaqaZFbYbYBFCE/JGqUVnL13WF+R9EGQR9lc=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4476;6:nOs7TNa1yhy4CN2I7m3afws7rjhXoUjuHg6ugaQADl4eDVoZ6ZUX8inAyi8q5tZ4R5K/trSyiz+I3SGNGBRf6CFSezinRawHf3U+zz6SiacqEJpqW3ma2zi25fZXfnAeRa8OtDdRXkSsE4KEwfMkDirP3qzOJbbrYjcdnXjrytDzlTWgBejQ+Y3dAEVqTvmTlihrhyJRhv5qCWXTUWjk4VaUpc17hU/YzJjo4U9pDcDWTMUYfXmTOcDje6nxyjZaRnk3jF/vIdUBvVoFMOS2g0ZtpkFaf9fmJYCTHPvnOhLvdhC2LzPCW4pA9vUn0yttPH98FyNdG7RH65/J1H5pucEHEsQJk6s7twr9eTqHjcwvO2hGOESFZtf3TWRg+cUX9SvVMNt5RXXR1MsMtM7jNo6nFiywuOCYmraOW0Du3UyKqb4ijk3HR4bRtep97G6gE3VkIlFM/AdlTW/FNJnIow==;5:2qxxtHiOq7aDrUNfTH8nzn44OprS9GkAvyeT3Z/WfZ0eGxp9ALA+ytik9vw7NLIN0+Dw6b+2cAtp/35fGbzScWhF+3ud9AI2d0QjJkjiH6W+xL3ZN56vSgBlG3vUc7/OCEjzZ1uIqGkAogHngrvoHcBRzF+ca5jn9L/qLAsp0lQ=;7:7LddvOXsAVXhrdoRRg0zmMIpQYUDTgtFBA+7iiGZQFbuVDR5Ph1Egde23e5JWFsOsKVlTJuAUtNlNa8SmkEjElFT0n18Dqyk2YsvUAU7IHIyCVDhylXLJnTAQJxibTOM/m86+Sx4XH1zhjgPKRmNU9EcgSOrxXMABVMK66IFcQNjDyg/rbKaGP54g5rgBDE/7ks85+x9ucVg+fZA4Q4myfTVd+yP1zPIl4p05O3QO74ZkWyhvoSP+Zvw2aLrYJ3A
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2018 13:50:07.1777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e08c51-b0a8-4679-7cfa-08d6172453eb
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4476
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing IOMMU bindings cannot be used to specify the relationship
between fsl-mc devices and IOMMUs. This patch adds a generic binding for
mapping fsl-mc devices to IOMMUs, using iommu-map property.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Robin Murphy <robin.murphy@arm.com>
---
 .../devicetree/bindings/misc/fsl,qoriq-mc.txt      | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
index 6611a7c..01fdc33 100644
--- a/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
+++ b/Documentation/devicetree/bindings/misc/fsl,qoriq-mc.txt
@@ -9,6 +9,25 @@ blocks that can be used to create functional hardware objects/devices
 such as network interfaces, crypto accelerator instances, L2 switches,
 etc.
 
+For an overview of the DPAA2 architecture and fsl-mc bus see:
+Documentation/networking/dpaa2/overview.rst
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
+               #iommu-cells = <1>;
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

