Return-Path: <nipun.gupta@nxp.com>
X-Google-Smtp-Source: AB8JxZpXrTcBt+1ypIOL8lPnmG1wwcIs3ygE5RFNDHy8vNjFzthZ6tQ0Fr+hL4gByFdRv5Cz/QsB
ARC-Seal: i=1; a=rsa-sha256; t=1525069737; cv=none;
        d=google.com; s=arc-20160816;
        b=PfHNcjS7GoLizVcZ3AwpnIRretwPXvHc8XH/p6yuj3R3StUNkLQWoM/jEE76JudxX0
         UlrBWIW1LtashT3MG/ggU3GrMQPknLjvLaQIXqmxb7yMI+1vr+6Rh/NWVfZ4GL22hLnu
         OahRP5Ygprc6dcsZGhQiHyeWZ6jMDSY4WT4Ub8mCTCP23qDrOfJXdPJ1YgX19GqY5DwU
         PgJFO0OOFmvzdZWVJIH3lDSb1deFJCHEX0hoA28Xf/uQDm0bAXLpsfA1YK0VKColU2OL
         0wP6u6pLMAkYmvOdBsrVN9oBtiiYJWrIZIY0Fd9zyTe+ezFXzX4DQqVmsiJ6qdkxGQqu
         GJ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=VzZe9GHE5YOeD6SErvlgjuYTo+SX5eUYyDYJPgPkgO0=;
        b=MnlvUWTXa62T1YtPNLtYoaFWfv5gqQwHirjOeQ5IofAOjCMjqmKN9mRXZjuVzTyGcN
         WCJpKmrFtzg0xqhlnaQlCEDCAZn44grZmGSh1X31jz4yThzTWwiBcn5uPK47go4Ectb9
         l7/pksGEsDZcB9vYhEW7SGFDP2KdmOP0Nfw9RSTdyV/HFjn/BslohL8KFDgnSX+o6cU0
         8wD/eZ5Fg+RbHd8NCkkaRXWFd2BawuiHLle1sshxZwbbkhgqjj5+W6N+a61yFUZnuULY
         2sk43E0owbY/phL4EtjdY6TFEotNJdtShnI8pyw08ib/KPV/j9q5SWuGCDGLGK4/J45X
         1Jqg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OxI2N0et;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.45 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nxp.com header.s=selector1 header.b=OxI2N0et;
       spf=pass (google.com: domain of nipun.gupta@nxp.com designates 104.47.0.45 as permitted sender) smtp.mailfrom=nipun.gupta@nxp.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=nxp.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=nipun.gupta@nxp.com;
From: Nipun Gupta <nipun.gupta@nxp.com>
To: robin.murphy@arm.com,
	will.deacon@arm.com,
	robh+dt@kernel.org,
	robh@kernel.org,
	mark.rutland@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org
Cc: hch@lst.de,
	joro@8bytes.org,
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
Subject: [PATCH v4 6/6] arm64: dts: ls208xa: comply with the iommu map binding for fsl_mc
Date: Mon, 30 Apr 2018 11:57:21 +0530
Message-Id: <1525069641-8523-7-git-send-email-nipun.gupta@nxp.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
References: <1524824826-29473-1-git-send-email-nipun.gupta@nxp.com>
 <1525069641-8523-1-git-send-email-nipun.gupta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [14.142.187.166]
X-ClientProxiedBy: PN1PR0101CA0006.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:e::16) To AM4PR0401MB2418.eurprd04.prod.outlook.com
 (2603:10a6:200:51::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM4PR0401MB2418;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;3:xG2it4oyOflCfsx14HtId/CLnu6ISJGynS2d5ADzK56F4wav9wrdRIT2P3JfSZQz46M4RVaVXaLGymZpkZKwUvO7yzMnhJPnMAr8TZHRkHZGyGBtGFgXzezDmJp3PwD0R+dyaxdH7VpczHj1nrsB3UiBWpWHZQLVqD5Ktm4/KpuZJxEGLSG8JaPXNYowZpKJqP02VVUCF8GBeBiOqB5nrf0dyODd2bkVGtqgMxAzvOTx7rJdJYeJ1t6wqlGS3/mk;25:1pEt8drEYbaZhMuHV+Al/bPDLpYm7z5knB9tw/r/cjwhAousIlgF9FeKRR9efVRYQo6TvHZSEteNk1BaBeSy+2kTO1AF0IC+SrwwoqZgtRqCSW4Au/fw0AkUoI0aGLjkd6icr4bEJ61Mnb4O/uk7t0onYL5gcvBplk6c2wLE9hz8VT2+NvzL5CMuoNhQYadlUrkzvXfBGZaHnBfahjy3eKVta7Pi19x0+XJUTRqUL2+/Q7/V5nbCxWhVQKuCiiWyAvJlo5gzPSgR3U3fHX8GV4K5qFsVfVlnT/zZrsQXkoa0xmNFRGnwKaIL5QHKnqgnWs+nn4x+QnFXcoDspfDRFQ==;31:A1/9pPeZQuHxp6sawlscKyB/z+biiFQKVEvC8ZbMpDAza6L0c21/zAZPmV7P52jqvVbUZq2VnZ37qNtnFDS2F0shjR6u0Exag1DP1lPg8bzuo/G9D7InZwZTn8OzTBBR+cVZqaXQKM3mxYVWWyCFrKzcbS3bSLgqkRgOwscL28kgI2MG3tm1bQU2T9PzLNqGRRaj4P5T8387icNKIesstc7cQgzSQpyJe9i+pZHnUM4=
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2418:
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;20:Lwg1zCMTAWUiMbu2aGomNlPO2kKtkWe++quCRgRx7MtzNRQneAvsg/zazeQZ4eQp6mNH7jiA5wYoNMy7XyTBydQ+41z6ySExbo9V1hfItbcp1N17Hu23jM5GS5kY2xk6rNMrvN4rN2uinukceRpk08ASa2lcaTKRjhoascYqHWXa4lBttQfoFT/3HlFcJKEgGryJXeTX36yWa2qin956zRnVR3IOsY/TUANRmRSScQs2K77icj2f1lhSRouIwn09Pp8HTIAClAY9z9v4G0lbib89kRKsBhyABobb45JPiOfcYrGJ5t8b9kLS+H3UXW4Fcg+I+pd/wtnKNMNUXNB8fibaMeXmNQIm2Meu9PifiWN7OSKkcL2RSPHPq+5Z18KFJ8m/9cKx+tbgaLVEdNKzHwySiSVPs8uFnEG5inKpjpR0tej+NFb/nEiGVhBh7nTCln7AvTyXIXZIfWS85CnA8X3b2294zZoMWGL697sxoMn94XN5CPZZ5MyDYrbChvgv;4:+MysqL8FImSQaKXv/OIZOJw/tQ8TIQrcHPjRrNfBV94XDSPvOZusIqnZLyxSQQ/fQM46QNuqNKu8qfB1MPgRKzPxFmmitB9URt05C336YuQ9kwCzxRh/yvqTbfSyigSjBHZLI7JG5fKmMeadeVuRz0k+JEzA70lAdoqmz46vCigMt7vtJq6v1UY34xbYhya4IYQdyHjKFoOYWjmU5Q3cW6hNlXnhb2RTM8eFI5CMdCEbsnISzfxrT5odltUupBZtJ0AMFMQrpTvMPHjBhHufbHnclxSQBZR9hcJ0D20Lmg/C5o19ZCMTUxg/qJR3G+n9p7m7LyYsaBPXtSl/2MOt7q7jXUuq1KTdolFNn4siZ9Y=
X-Microsoft-Antispam-PRVS: <AM4PR0401MB24187CA1695261637B92A16FE6820@AM4PR0401MB2418.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(185117386973197)(275809806118684);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(10201501046)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:AM4PR0401MB2418;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0401MB2418;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(36756003)(7736002)(52116002)(5660300001)(105586002)(106356001)(486006)(48376002)(50466002)(316002)(2616005)(55236004)(956004)(11346002)(446003)(476003)(51416003)(16526019)(186003)(6486002)(76176011)(44832011)(47776003)(26005)(97736004)(5009440100003)(66066001)(86362001)(575784001)(68736007)(81156014)(81166006)(53936002)(16586007)(50226002)(2906002)(7416002)(25786009)(59450400001)(6506007)(8676002)(8936002)(478600001)(39060400002)(6666003)(386003)(6116002)(6512007)(3846002)(305945005)(4326008)(110426005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM4PR0401MB2418;H:b27504-OptiPlex-790.ap.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM4PR0401MB2418;23:E0LWfcWGdIjdPXuxECY+1uD9p7uHl1Z2tBAo5Fb?=
 =?us-ascii?Q?M21l0tSwnUMJWhgMdaYnFR9np78g5RREZfcuyeY535R5jg+VcXcBYpu9Vbvl?=
 =?us-ascii?Q?4Kg7SlPpypCM5Tuk4Eo6iY5gSa6iC4FhMHr57rFT3d6+r+WCukMYvDho/0vW?=
 =?us-ascii?Q?Bwbxh6rMSwoARbXtJC2VGcAqTKwaCp1EdFeB29pe+eBFdtIEwRx+gqdqkxGP?=
 =?us-ascii?Q?Wek/tbTGIzjRC2c16e/J/+rhG7i82EpqR8FrZtt9fgXQpDVKwHXaeHr1nrtV?=
 =?us-ascii?Q?U1BRXnTk7Po1fShsUQ6jg0xCZHVwTkd8kEYBkntXxQ15r3jB1cDTQ+nEfsA1?=
 =?us-ascii?Q?stNYqeIn5kDVv09TKMWf25aJUhes//00awn4Clp5Ffr9aC5+My0TqlpqKyN7?=
 =?us-ascii?Q?9kM9Ngu/sD3YzKGhOJE/V4RGLBVaihmbS6ci2JJTC5RpukyxFeD6l1rTsZGc?=
 =?us-ascii?Q?zK3ZCEUNd0QGgSn4OT71o1WLvMoDrDh6eZSbl6GPI6ynsjPdKwu68Tyj18Ek?=
 =?us-ascii?Q?x9W46T4EAJYivZJICOuiLVZAVgKyPzNXs6XLsb0y8HMGa9yPB0V0cACeQWIF?=
 =?us-ascii?Q?coLX9dNcGMBzvRH676rTRHUy7sdRWAZaLFemRIBKP5iIHi2xJRls8G2sOAw1?=
 =?us-ascii?Q?uRWhtgORBLQ8LqNGmmMh+i2V4rtQ9Ufu3qcypeOkjwJ3P/D2lZG4m2MaG60i?=
 =?us-ascii?Q?NpKO5wgMPLb6PkBIAOLW6V5MOLhze04BHGdGC6es3HWGjy8djn9eWLR8BdRp?=
 =?us-ascii?Q?Y1gumox7pxyGpLaiZTrboOGnSDUmodnFC7jRX4TcIiQ4SMKnM3MYWZA6FH1s?=
 =?us-ascii?Q?zCvDuGcOu4jafafSKO87iMlQbGwZrGf316nrbAmH+Ee9zog1Tkza5DisYLvE?=
 =?us-ascii?Q?VcIsCQFZQ/oAfI4ETNaf9pEaxAV7ihH/0Gc2X2AjsjfjeUh7vJfYHYxrsINS?=
 =?us-ascii?Q?Mbl6pga3ZzZGTFiM6grpR1yKR1KlJB/MoufpUzqonVpYt7KGMFubZ9XJdkou?=
 =?us-ascii?Q?BsqX3rEYuyxekMpEJsjOcR/gIH3mI4b1pvN/T9RHvsT8ttwhALlnpttq6QfK?=
 =?us-ascii?Q?+nZUnymI7UnwlnYR0ybYoSlLb1EcKA4vjs89lTTi9zX9HH1f8EN7FkHMf6b0?=
 =?us-ascii?Q?mVuj2c894m+sxljsbUJow4rDXge4eHH8ex54UA9ZpCRNtK2fMEL/e1/JlZOH?=
 =?us-ascii?Q?RIKwZXgmsrmSinEWcX9RDLfNF890I2UANEX0pRpkTHHOZSBY1mf3/hp9FXJB?=
 =?us-ascii?Q?mviJebyeb75VLGEpx3UuuSjXapWd2tARMuW/k4KtEx6TnD5RI1brbXxSA0Pk?=
 =?us-ascii?Q?GA/Zqpe9UkTMrlfXB0BerseBE0mzVzs+QXvjc/pa5UpE0tCIo/es3IAerjiE?=
 =?us-ascii?Q?ySd3hgQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: Mq08eFUxFpCdSyqoflFyk1iHoN8aKFSNoc0J+Lygk6PPMo4295SLScXJl3yIPt1bIrFSHtJ+9pqKcD9517jfaLJ0aPYtaoIU8NQToLwo+6pRpbHlrOLkx6AvC7yFZH+Hau223xKyyQez+4EIcFkwJnoEzxQ3q+8R8mLbuMiidPbpGjA4IXyFgEqT3vjymH42
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;6:mAUlM1yyH20LeiEQdwDGtQcrk/z2bkj40mjnwcbUA/Lu40uQLGWCN5IKeYtJli9qSFLVF22TJnq6gZufuGaFoKOj+iS/3Z9FsqCCM25sbCuslKKP9gCXSl8ekEfKa3gBUgv7bpzoznMmXVqricgR8VKFNtHpkAH5NpWQvd4V1SA1FkwpsNdYgFxXLXOFLfNxjT1QwX05bbd+9BdObhxbLyiYdip1VidJgroODeO7QxbwmWawpQJ3hvOX6bmcq6/19wQd8zXa8iCnNRwjJqfLDE1QdGxXBXbIjC2Cqh03ucRKCFeOzJqysOKFL4SaNz2ANUYLzxwh61/SLuBYKHqeDIhZ67DrXhQIRsrYxuoUHwJgTULAa5uKunR7endAlW0kTh8qIiUOnJDhjpv7iKxeiocXfXELHYYJjHb5TmCIercj6d8+qVQn4vf92cGP6NaCXL/siX1hbMLYet8wH3rM2g==;5:CfDnN35LMuVCXslZset2zDxo/zUe65x0VzM9Qz+DLUnRUPTEczdKMbUJ+xpq8U+d7ADDCU6946AyJuK/EGOf+4aCXdgpWbofvaLriwMQRDpayCZ6e1xmr4SCozCyODwMuDcCXcryqdRggB3go//E7sndrt1HfYA3+9sWQEy83Ss=;24:iTPZ/V1VYG+hzh3mbdK2D+c5jsJArHsCRJWFaHvICjyHy/lDpGmeWfng/NElYzv8vsGEgDNxqrH0O0cccWSfc10EB6WaXhl5/q4QK3S6+oE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0401MB2418;7:u7ZPfAnvzrH8m9Rz9smny0FLbOZB07FT8f5BWcTrKrQ+qU/6YWQdXX7wd7rkLWFIzVYjm1gCSUrmpYmSL+Y6sfxb3KDc1b4OA9+EHBqFB8nkF5ypOicSryc0RFP0pJpP/JqgXYkUJGkfESVOmXUOdop/7dbdhyj1p0RP5H3H6+AUk6vpycmrvguwpcAy8QirSAQdLtJzvyobASfrYDK/PaBojZdyC6FpPVoJYxCVufwqHsLNzBMjMkp67O9PG89Z
X-MS-Office365-Filtering-Correlation-Id: 48b0c76b-6834-4f2e-9a40-08d5ae63a502
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 06:28:49.3313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b0c76b-6834-4f2e-9a40-08d5ae63a502
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2418
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598894790375923530?=
X-GMAIL-MSGID: =?utf-8?q?1599151524864760225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

fsl-mc bus support the new iommu-map property. Comply to this binding
for fsl_mc bus.

Signed-off-by: Nipun Gupta <nipun.gupta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 137ef4d..6010505 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -184,6 +184,7 @@
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
+		dma-ranges = <0x0 0x0 0x0 0x0 0x10000 0x00000000>;
 
 		clockgen: clocking@1300000 {
 			compatible = "fsl,ls2080a-clockgen";
@@ -357,6 +358,8 @@
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
 			      <0x00000000 0x08340000 0 0x40000>; /* MC control reg */
 			msi-parent = <&its>;
+			iommu-map = <0 &smmu 0 0>;	/* This is fixed-up by u-boot */
+			dma-coherent;
 			#address-cells = <3>;
 			#size-cells = <1>;
 
@@ -460,6 +463,8 @@
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
 			#global-interrupts = <12>;
+			#iommu-cells = <1>;
+			stream-match-mask = <0x7C00>;
 			interrupts = <0 13 4>, /* global secure fault */
 				     <0 14 4>, /* combined secure interrupt */
 				     <0 15 4>, /* global non-secure fault */
@@ -502,7 +507,6 @@
 				     <0 204 4>, <0 205 4>,
 				     <0 206 4>, <0 207 4>,
 				     <0 208 4>, <0 209 4>;
-			mmu-masters = <&fsl_mc 0x300 0>;
 		};
 
 		dspi: dspi@2100000 {
-- 
1.9.1
