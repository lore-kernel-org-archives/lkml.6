Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbeCVNID (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 09:08:03 -0400
Received: from usflmia-meg1.delphi.com ([69.195.251.241]:11287 "EHLO
        usflmia-meg1.delphi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755341AbeCVNHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 09:07:51 -0400
Authentication-Results: spf=fail (sender IP is 40.103.34.100)
 smtp.mailfrom=aptiv.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=aptiv.com;
From: "Kwiatkowski, Arkadiusz" <arkadiusz.kwiatkowski@aptiv.com>
To: "broonie@kernel.org" <broonie@kernel.org>,
        "sourav.poddar@ti.com" <sourav.poddar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>
CC: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fixes in TI QSPI driver to allow more than one flash chip
Thread-Topic: [PATCH] Fixes in TI QSPI driver to allow more than one flash
 chip
Thread-Index: AQHTwdOka+rgmyzj8E66uVOj1nJv5Q==
Date: Thu, 22 Mar 2018 12:33:56 +0000
Message-ID: <0ece6261f37a424cbde7122907548a9f@CO1PR6802MB0085.017d.mgd.msft.net>
Accept-Language: pl-PL, en-US
Content-Language: pl-PL
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [78.9.179.5]
x-ms-publictraffictype: Email
X-MS-TrafficTypeDiagnostic: CO1PR6802MB0086:|CO1P160MB0021:
Content-Type: text/plain; charset="iso-8859-2"
MIME-Version: 1.0
X-OrganizationHeadersPreserved: CO1PR6802MB0086.017d.mgd.msft.net
X-EOPAttributedMessage: 0
X-CrossPremisesHeadersPromoted: DM3NAM03FT032.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: DM3NAM03FT032.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:40.103.34.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(2980300002)(1110001)(1109001)(339900001)(199004)(189003)(81166006)(8746002)(305945005)(86362001)(2201001)(156004)(2906002)(69596002)(102836004)(26005)(2501003)(5250100002)(110136005)(54906003)(5660300001)(22756006)(105606002)(186003)(8676002)(55016002)(66066001)(1857600001)(50466002)(478600001)(356003)(2900100001)(9686003)(81156014)(97736004)(53936002)(7696005)(106466001)(108616005)(68736007)(14454004)(7736002)(316002)(24736004)(85426001)(4326008)(8936002)(59450400001)(6116002)(3846002)(86146001)(47776003)(336012);DIR:OUT;SFP:1101;SCL:1;SRVR:CO1P160MB0021;H:017-smtp-out.delphi.com;FPR:;SPF:Fail;PTR:InfoDomainNonexistent;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM03FT032;1:q3jChaf7myhBcCZDmKJMyE+1FURWJk9mLFozJm1tW8u0ygQu2OCjr1nGc0MWx9iMXpG+uqr4CGAQVrWSvBBz7wnvz5HZDiojbIrLWCSFvA6+60h1iFVBgP0jpw5ZhFgX
X-MS-Office365-Filtering-Correlation-Id: fb0cfb63-c04f-45e1-ac64-08d58ff12f11
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1P160MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CO1P160MB0021;3:RcQ1jI9LiNyh2IKjnKCGRot/jpV16vGJu6ieL9PwFqUSDCWl7mXO/iSfmPqQm3jgoz3u1LP5mRMqIpxChzdr1IimhQnTwXIGl4ICDgO2VXRxQQ+X6TDQf8rvechT5j2hDC6hEEcQR7+PPZuO6jhplOEM2um14KycFTeL8o+wEm2LJOvY3ebJfmqMJJ62orvyBABiiYNdWjyUpzupGE7YTQTVn96EAdctmnY0TNX6+e3LQ+2YlsBYaMW/3fzFgvr/sVrbZPGiLOvl234LS6kY/257jTsLpiDRxXsqK6LnkEh9lLGrwmc+k7onEwynZOzg8usJyMAwsSBIT9pR+2tO1GKAuv51H3K7PebzDTGQXKs=;25:VJ9AR1Cw/WAB4MNMJrYIj/iwze66YDZDA0WC4D1FaEr90DEsdjCWIF35womfqqPActqkHA4CL+S2QQH6hRK+Emr0gcICdNi054NQPKWywce4cMnI3Xw1QhPOWtHojNj9HyqqngSYy5xRgA6+WLv+P6bN3XfBeNIt1QjfMZofUgdvHCMc4BNG8ZFgfBaiRCCXTcNKxkDNotUpGpoWR7Vkl/+v6NDelM4JCWfIqfsKiw9PxMAqBDlEuwT099tPEdq7nPZqG/I0Rpf33MdIjnccdpLRxbL+R4o+tX9lSDSEHZ00R1009fZlcV63RPTzG53uWgfzLJwnXYoJU6lvFJbIPA==
X-Microsoft-Exchange-Diagnostics: 1;CO1P160MB0021;31:JSwBB5Exf76ax4qw+AtHyy7D2zaL4HkySpJ3zDhbxgilorChSe1XLjKuxm+M0kLG9lnehR+QXzh7Aj3lA6YuF6yLynHzGoKulvzYTc27uHpsNIAgaU51T+o6iBW27jIoT1sT2vSjjL/iX/+9EeG7gr4L4y8Ky8Nr9St0qZ6DA6C0kTMF7cF6Wp/EXaaJ8tfJsMSBGSHRSCFhSR7O2Ml2uevZhTMcGxHWRQax0k7bqV8=;20:RLkd0n7FAGsXYL8cnOV47UvYInTed763vHjklqLHqUdaH22JtrFBg8W1itCWCBcw6VVIg6LEdkF5zV5hoiTVH06Q7GegemBQ4VnyTQd1Z2Egr6RywWM7bDSa6G72/Z6SH/hdoYl/QzMSB1+I0cFPzA9voCUw9H6tlh6Ka7YReEr01IkB73W/MzNw/e0Zg4Hg+DgtcTOfTRKueR7Yr4qn8PCVcZG5xP63JdF2p+ojQ6tgeLPqeL/MVQvtDAaa69/XEm2xk6kKCKUThpE2C+D16Gx+R+p+8yqM4T5PAsPtJ5rMo9GsAVtp6x6vYDlsYw2wN9HKPL8WzKCD+cZMeL1wrJXmXFRbt11QLatJTltkvdMfMJYPJ7rU+RmQV5zsUu3skRL6zjIa6Sa5IsWwJMb42YKsJj8QStjSXCPODgdCDqR6WhASU0/UTGxB0xf/gvUABVPwxCjmCkqk2dPLekGSo27zLOx08CLkiptdn3O34xOZptLZmPibdH6jxMHHe9qZ
X-Microsoft-Antispam-PRVS: <CO1P160MB0021F04F9B10D0F62CC5469AEBA90@CO1P160MB0021.NAMP160.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93003095)(6055026)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CO1P160MB0021;BCL:0;PCL:0;RULEID:;SRVR:CO1P160MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CO1P160MB0021;4:FEqxCPjyukNv9KjB2q4vh03bXkdfoIRAHTiTKYJu44V0Igrxbmh7B0P6yCQcvEuAm6tgqgaCrREqO+xOG5QXK1e2yeBRTs7jDmOtUK/sc+YRPjEDYF7P1S+RdbRtPVzsScaeA7ThiR5CbkrYNqodc/AvTczvMD0P0DB2CLWcW6x8FCGIgoC6XDuvZ3jVXESQHY0WErJT2zek7iig8T8zBFxv6t2qHndARvRbIKUAP4F2TOspGJbjA3Qkl4dcFZ0l3Mp4SpwmexHT4IOxs5iHxA==
X-Forefront-PRVS: 0619D53754
X-Microsoft-Exchange-Diagnostics: =?iso-8859-2?Q?1;CO1P160MB0021;23:vH+NY+kl0uB6nvX1K8KAJiCWDI4UAqVJVWzGL7B?=
 =?iso-8859-2?Q?jUkooNZ3QN2Evd3M6w0h3V9iGY9yYvZ/9rIDrO8b2gafWob3MyZA2ESgRD?=
 =?iso-8859-2?Q?p6eouh4/GzyEUsNTnCabxWyxPrSdYHCaK3ge6WQtRzjqmxk3RMHoIvAvqK?=
 =?iso-8859-2?Q?SS6Tl4DvuhOSY4NM/dvqQYB8Bdt5Nb4vZaJnnIBJPjieGpsO/Xvnd6fiSA?=
 =?iso-8859-2?Q?cK0WYQb5CxLy1/6IuLYUQMqa3mkUfv7YbkrxyMktZ2ZSYPMmRs5p4GLt9s?=
 =?iso-8859-2?Q?44DHXLmPqo7uHxLW2QnzwuIPE45/FDHlT5b8oxQBwX1gQB/jTzx+QC8b3u?=
 =?iso-8859-2?Q?eBreAR/131CI0nXhY/Doul6u6fqEYt9rViOdmWLXUP5RSV3i7b1xiMldAL?=
 =?iso-8859-2?Q?Aj/SIr9ECKBXTbCVWyQ+GpYxRM6z0iIDfE9GEny/LnfWjYj3XiVEuIMczZ?=
 =?iso-8859-2?Q?Mx8hbtU6/T/jo/cPnkVKKPjzg2HO20pZLWPtssOMtfs58KQFSkSdHDAIO/?=
 =?iso-8859-2?Q?F8O4Da4wkPE6C+D1dIK9C0GkgMoThNULRezCdNRIphbVyOuXPMHZn0RlkI?=
 =?iso-8859-2?Q?ArrY+SWdl2T5XcaIx2kL7TAVwCPP4V6p5ZnaUj4f9y/0jg97hdgl63AQBj?=
 =?iso-8859-2?Q?6YsseOCkrOx5AsbekRW7Vfr9SANDFM/YG8GRzYmnbbSZ269okgoPAOikhQ?=
 =?iso-8859-2?Q?s1xb4uwNae/Y3fAJjKmmqK5JgKWW5Oyf+rMm2y9vAwlLcGM3mv7hPcSWZo?=
 =?iso-8859-2?Q?T1tgdfS5QsYO8x0qF8/72RL3+F+XYGzJ8+tncL+eEu/2FY1ZuVQGXxoEVM?=
 =?iso-8859-2?Q?ytaABajx0fISZM+x5jPyxhXMo8kwJEMSJjv4kk27CZ9bh/x1Eva7WLZKXZ?=
 =?iso-8859-2?Q?ewvP99w7aLII8Meb4qYw7MXRqcPU6g9N3h1o/UxML2KafPaemgPyX9veNR?=
 =?iso-8859-2?Q?LNbOy9RWVCeiAsGcOqGtQe1RfPqg9E7y1/PLU/TRFNVzAZPW/4ncE2IapJ?=
 =?iso-8859-2?Q?6FErJisCTJNJSIEWDt4p3bY0P8AyvyAGjbKO0tM1Vn0f4UUMHEIQ6TOpVr?=
 =?iso-8859-2?Q?S3MUe/MTqkXCdZNygM17/vXPUk2F8J2MapnQdQdWOinlvbydrA+DbUBvPh?=
 =?iso-8859-2?Q?fiVuP8XovScbTSBlpAF08Tx+3B+YbttECp9MrZCVDxhytNr8oOUrmco0pS?=
 =?iso-8859-2?Q?wDn6quXE8o6SUmIf+14s1xq622m/QKi0bmqd3SCcSqaOhgzVyXteyl/0SG?=
 =?iso-8859-2?Q?i+s1b6hbT2EQ/9kKoxTMfX2znKjSvp1InaK28UweQmhxzYGbuLnd9dWnx6?=
 =?iso-8859-2?Q?vODT4uyKXwEegH+lr6JvXdW9Vko66+dDApPMAgUOm9zlYHGfJ0s3oMPRmM?=
 =?iso-8859-2?Q?lUpGD4mmElpRTVCnngKKLPOR6nBXs?=
X-Microsoft-Antispam-Message-Info: 8UG4oOaD6QUNwRnd94+zzdRHMxvJBhZ227DZUZA5w/K7yhHsQpdBujF/OjVwARnA80u7GYMYocOvWiRQGqWP2Iy5JiAEwwQVO1+d56uLZDF0Rx16JACUo2NsG+JYp41YsEc/oZxL1uQkgoLZAPZB6ZcP6ukYz1zeWQxkW4SxPB2J76VxY6dSnevi4KXS+aJg1HhHpicP7zvnDwl1fPkijm/xZbaSfSNk8hBidm4PwkLcaR0x8AXdzTVanMnUbPtFZiE54zDfFQEolOfVsRR/nH/w77RWvUzFInMuv6VA5xjb680Ul3inRyE/AwMxJ3Jg4ksAhLhNxgS3YKk4Vfr77g==
X-Microsoft-Exchange-Diagnostics: 1;CO1P160MB0021;6:rYLzfxdowXwIqSdgN5KX4QhblJJNOIw91F1G2n0Fry63Nsi5hi2bDaMrAG/2oo/7a+v/EdzhaHXZQ4E7nHzG1U7E0SQ0blC5/JRqgEJrZYV3mzSK2BF4eZeFFvamjqTAKFwjUIakCpaYHG2/4AfA/72DmMcnpUURzcgbiqWEazcLXWSLGZJUHXHteLNlm9Zd/dBXmsP9jnJ3XVy53ynjTXQJp9IWm6N4ISyhuzSjveqIplueWZUoGzMEwnbpOa+ISKMSx82g0EDy8Np8wB7PbG11TbVPKb9LdS2vsKs41CXaMypx64nQgklx9HUpEbBR9fDltHJpgW8sWEwqEEQbOdFXU135nXsaCEHQ86XYBRESUUHHd6H+nwI4TEDqfAfbAIUINK6DAmGyBKFSXNQENA==;5:dwU6HKUnMBz3HPp+31iM/1AXy28antyp/Qt2XeTSvkD9AAggVdhDzIV+70kqarSdJa2MJQNdguS27s0DzaEK2dsemYMpf7hDvEg9VVYge+cfzbPMdlMR2Ed9ptftHVQ4yd1qJ0ik1Jv+vXmfQewAbeJVNSBjSFZAx6v0UWGgqgs=;24:WxQjY3/R5frQTbkrDfPdH10QG9JylG9/AZGaiU4i3W9RbQbJ3T1Mhw4gnJXxdKWNucL0vfv/W0DmPkR31ET1A/LS+b3avweLlZlxnqukG/4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1P160MB0021;7:Hw4i934msxuxBcbyW56BvdWhvsA3lNoGbga6RQQh+2As+/IyKa+3LB654dkHuH7invC76hvCmG6AnHJQ322zGefdXTyesf+txKno1CUo6ysBPGY9+ujvnICP9ZHEMjDWc87bxFwQ2zUakfOeo4dM29CwrLTjdQbwdo+R3VYRvoPUsCQUJ3FPjYQ0kWqkcs703/kiSNT1XytU/+u5tbvK60BhB/j1U2KeNBLpVXsNBshvk2kYsKerKE3OMjLe0dGy
X-OriginatorOrg: aptiv.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 12:33:57.9558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb0cfb63-c04f-45e1-ac64-08d58ff12f11
X-MS-Exchange-CrossTenant-Id: 1d57d21b-62d9-4e6a-b97f-39c9a7dcea11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1d57d21b-62d9-4e6a-b97f-39c9a7dcea11;Ip=[40.103.34.100];Helo=[017-smtp-out.delphi.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1P160MB0021
X-RCIS-Action: ALLOW
X-MEG-POLICY: ALLOW
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2MD86kS023739

Add checking for which SPI device was memory-mapped to allow more than
one flash device being used on QSPI bus. Fix parameters order in
regmap_update_bits calls.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b4..3d1dc4f 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -66,7 +66,7 @@ struct ti_qspi {
 u32 cmd;
 u32 dc;

-bool mmap_enabled;
+struct spi_device*mmap_spi_device;
 };

 #define QSPI_PID(0x0)
@@ -490,10 +490,10 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
 ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
 if (qspi->ctrl_base) {
 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-   MEM_CS_EN(spi->chip_select),
-   MEM_CS_MASK);
+   MEM_CS_MASK,
+   MEM_CS_EN(spi->chip_select));
 }
-qspi->mmap_enabled = true;
+qspi->mmap_spi_device = spi;
 }

 static void ti_qspi_disable_memory_map(struct spi_device *spi)
@@ -503,8 +503,8 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
 ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
 if (qspi->ctrl_base)
 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-   0, MEM_CS_MASK);
-qspi->mmap_enabled = false;
+   MEM_CS_MASK, 0);
+qspi->mmap_spi_device = NULL;
 }

 static void ti_qspi_setup_mmap_read(struct spi_device *spi,
@@ -544,8 +544,12 @@ static int ti_qspi_spi_flash_read(struct spi_device *spi,

 mutex_lock(&qspi->list_lock);

-if (!qspi->mmap_enabled)
+if (qspi->mmap_spi_device != spi) {
+if (qspi->mmap_spi_device != NULL)
+ti_qspi_disable_memory_map(qspi->mmap_spi_device);
 ti_qspi_enable_memory_map(spi);
+}
+
 ti_qspi_setup_mmap_read(spi, msg);

 if (qspi->rx_chan) {
@@ -600,7 +604,7 @@ static int ti_qspi_start_transfer_one(struct spi_master *master,

 mutex_lock(&qspi->list_lock);

-if (qspi->mmap_enabled)
+if (qspi->mmap_spi_device != NULL)
 ti_qspi_disable_memory_map(spi);

 list_for_each_entry(t, &m->transfers, transfer_list) {
@@ -787,7 +791,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 master->spi_flash_read = NULL;
 }
 }
-qspi->mmap_enabled = false;
+qspi->mmap_spi_device = NULL;

 ret = devm_spi_register_master(&pdev->dev, master);
 if (!ret)
--
2.7.4
**************************************************************************************** Note: If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer. Thank you. ****************************************************************************************
