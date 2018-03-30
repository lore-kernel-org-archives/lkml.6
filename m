Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeC3J4c (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 05:56:32 -0400
Received: from usflmia-meg1.delphi.com ([69.195.251.241]:11771 "EHLO
        usflmia-meg1.delphi.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750794AbeC3J40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 05:56:26 -0400
Authentication-Results: spf=fail (sender IP is 40.103.34.84)
 smtp.mailfrom=aptiv.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=none action=none header.from=aptiv.com;
From: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
To: <vigneshr@ti.com>, <sourav.poddar@ti.com>, <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Arkadiusz Kwiatkowski" <arkadiusz.kwiatkowski@aptiv.com>
Subject: [PATCH v2 1/2] spi: spi-ti-qspi: Fix parameters order in regmap_update_bits calls
Date: Fri, 30 Mar 2018 11:41:23 +0200
Message-ID: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
In-Reply-To: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [141.251.18.197]
X-ClientProxiedBy: BY2PR6801CA0004.017d.mgd.msft.net (141.251.18.208) To
 DM5PR6802MB0091.017d.mgd.msft.net (129.75.148.88)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR6802MB0091:|DM5P160MB0047:
X-OrganizationHeadersPreserved: DM5PR6802MB0091.017d.mgd.msft.net
X-EOPAttributedMessage: 0
X-CrossPremisesHeadersPromoted: BY2NAM03FT007.eop-NAM03.prod.protection.outlook.com
X-CrossPremisesHeadersFiltered: BY2NAM03FT007.eop-NAM03.prod.protection.outlook.com
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:40.103.34.84;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(366004)(39860400002)(346002)(376002)(39380400002)(396003)(2980300002)(1110001)(1109001)(339900001)(189003)(199004)(50466002)(48376002)(8936002)(8746002)(105606002)(2201001)(53936002)(110136005)(476003)(2616005)(956004)(186003)(16526019)(5660300001)(26005)(156004)(305945005)(81156014)(81166006)(36756003)(7736002)(8676002)(316002)(478600001)(486005)(486005)(126002)(54906003)(446003)(575784001)(85426001)(86362001)(11346002)(69596002)(2906002)(3846002)(336012)(6116002)(6666003)(4326008)(107886003)(97736004)(66066001)(356003)(386003)(68736007)(51416003)(52116002)(104016004)(106466001)(76176011)(47776003)(59450400001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5P160MB0047;H:017-smtp-out.delphi.com;FPR:;SPF:Fail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT007;1:hsuwc9JpoGhKUrlxLGWhnW+x9Wcx4ZHiM1FAVg6fO1fDRLCq3cmlLLqNUJ+s+kSJs6NnK9+HUJd6fTSw64BWr3Cu8OWWTQMsGXspOXK4RD5RW9yfbqXiqss3o9+dkRSi
X-MS-Office365-Filtering-Correlation-Id: bd12b68d-02c9-4d48-d537-08d59622882a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5P160MB0047;
X-Microsoft-Exchange-Diagnostics: 1;DM5P160MB0047;3:O5q3bl/wBebju8QVK1dzM0UPv0GZ1ppjhMCJHBLqvkVfjW5hO0oSVZnRWyiCJMvO+L+2fc4Xhch0k/ZgjaqHQ1F6mGmrip3Dei0vORZdyBTILYoBP+iCYpZ52uWMmnuHFA+ZvvFVNICMY6LzZOnyIFmCauTawB46HQV+BU5d5S32Gxf/cf2bMu2FFJLSdC9jHXF7F7wM6294r47R4RkWaK9V3D44Q2hOcMlS6XuFsyiMgxsIvtLsL+k32sCQ3RJ36+oAy9KRrLXLwbO/sW4K67Bdada+qGmNZe1TtuNSyoi0yhr/CWPAiI2zEQgZycL6Dj9zY1S7csCWPZnB/2sXlQ==;25:fshOab7YX++QTKZGj/RAKyX065StwiA6LikRjEUc2D4G8zMRFMBW+GadPqBp8L81xjFCWuGJnYN9qfHXoeQ1aB1ESi3dEpTtcbb/jtrfxZ7/kBzvBLUNDM5c2yfQGnLeV5oCpeYh4rkbPeRkw26rakXoRJqf7saubtqDPUCfSPHJ+xxMlYUG9XRaDFSBn00RqI3bsSRppEz1DIeTpAYe3ZrJFc8TL8wuqLozKGrDqOi8rBNO1UEpysgCtFjkqysNwaBKkMbvYLp9G//D0e+ykkUmkqMGZBFmLeR+sX1dnuE0jl0FZ8KPc5Q0icdsze6iFO9o2s5Dd8KSaQnL9P1l/g==;31:q4x5e/s+WxmGIqOS+D4Zlnic0BNUo1vHscqQtzgGHMqFWAAexaFA29sii2U4W5SmAyi6s+vY6D300w36bwmopkA/bXKIKkrdg1OjcXN3wtwUlGaPAhX2aXQsCZSXjw+vMZ2bDn+XHZTZf+8iYFBIsMU3+PxZ5OOE6I8nb0JJflGAu+P/YhJXCoTrjU/pVQjY833U7S8fJItxPzlpSMEmksTBOttfdxMcaNG/kdl1fMs=
X-Microsoft-Exchange-Diagnostics: 1;DM5P160MB0047;20:SspKLX6GvGjoALnomh5iRN763ViLowC9xJsIVTN8suKPEELTYogQPgERxTR0NzwYHJlM0tIZlmNnGLshH3gKMfbVuCnuaiVbdbpZ0A4RcvXcbvi7jtPay6HK9QEd/rpOnFRB6KkhpuGtikXXtZVasfmluFpbp87R32v8PI/dmGJfsnEr14fc4/hDsWMGEfWgFDDWVnh7o8ETTQsLQEr/7msuD4Sx75vfZQhE+1WAjPytpvwdkg3Ygto9cQ738a/MSeTpv1ASvgR+Q3H8wYaSvDCKf7PzHQvxh4sNI1aK9Nl3o9572Qy6D9VoXZ9cAttk9Afz2zpwnr6cEBmHPUX3aKIPTcJfbPUSkqA1eGvAK2CMf0RbUMe85hrlzOKYUFoVzxyZZL8PxZIaYhLG4S0QSJmJJB+ILpXXvdRTDAcVqo0GP1qCXKdYbUTWIpvmRDTnvMr7XwKLT7ptgkwgMZc9q4ZMrhnB+pyvWkKL9bXxBkK5Ii8ffDKt/Bn23H7+cPJx;4:Pr4EJCewWNka7igL0ne0Dg21fQMyW46L9svUeapnskcUz9sHOUCFvBmtgtxGtHiGT74fiK7Bqw9+jg+CaU7M1dFBbeKx51xo7DVUZNC3CETST85Nzto06ZsGhF2Coht/UfEIseXRBerRLZjCar613Z3EF1F/sCRLvd9/aFLDeQvMwMpVwM3+lGKzRbSK/1ub4YNQ/1rKfIglwl7kllR9ZesZ69EomzrdbWGHquYKs4j6bdqmMiCTTJBUp3bOnBc/n24xxv8yYvtG8MzPL55X/qoBOfWj3yQkjg0ENDo/bX4+G6HsEgn2XVBAxOZO6nt0
X-Microsoft-Antispam-PRVS: <DM5P160MB0047CC2FBFC56EDD1A17619BEBA10@DM5P160MB0047.NAMP160.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231221)(944501327)(52105095)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM5P160MB0047;BCL:0;PCL:0;RULEID:;SRVR:DM5P160MB0047;
X-Forefront-PRVS: 06274D1C43
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P160MB0047;23:TGGTBoAKUVrr7X1+GvBDutltCKQ4h/AzZKjAtDdEg?=
 =?us-ascii?Q?CWK2oZK6F0dKUbv3VTWR8g2z4EVmueVRL/8U7OeTDNvSvJI/d3YBvI79B7Xd?=
 =?us-ascii?Q?YzjjBN5zfcq6zb26NFQOXD9i0x+SN8nls1LmKSkwQbGaKO+xeuKWDvLoRqLx?=
 =?us-ascii?Q?JJUZFXRYm1xD0HNA1c04wZlRKn+efgubTJwZTfyYVRe0P2orFYw8U0aajZgq?=
 =?us-ascii?Q?b9zJeVDzWMw8j7Qm1NVuuTyhIRjC8E0aDfTxnRpuS12CUuP44Y3nprZAI2m6?=
 =?us-ascii?Q?PpLZwh3mtilCTetRCmw09BukRcVw6svpo4fHOQdH5EGw4L8pJf4/ViKPo59H?=
 =?us-ascii?Q?H3aduiXOxhpkRrtjJm2yR76tbsqLY5aFetEEmJ5HegBPKBQocbwwr88DE07y?=
 =?us-ascii?Q?gI/g0VNnHTZHbT5x4kDfgaB4BKZ+MNPIf0TQVPIvPQZYVQovl4EwMcI0IPmp?=
 =?us-ascii?Q?ZIxkP8j2nqr4E0Ie/X6+0qDI/bD7uurmG76qNbEJXfrSSrzDxP8qh8erbp38?=
 =?us-ascii?Q?RVlxQ/RBMXJ8mDwH7IbsNlkZ/0Ehp8T80dKI83PP2nHcprxtzHpG3EWO+h9a?=
 =?us-ascii?Q?S3qQPZVp873RWEs+W1Iq0/2zU6dfLPMZOMcCx2kycHNXaskybxtj0Cw94tyi?=
 =?us-ascii?Q?TAFlUGdSRGa65Kn9Sekanqp5lk1lSpABdtQOqoTsav+SUFFKRtZMXJCEAEu9?=
 =?us-ascii?Q?z2rTbYI1PwRqRyXmJHecJt0kAuy7VgVsXWnGlPfsRUGkvkFo80mk44T+/fQf?=
 =?us-ascii?Q?XJ6xI7maLN90XrvFz9RayTKTCmLtxeQC18DOPtT4M25bE5zM1vYz56ubD8mX?=
 =?us-ascii?Q?FfcSlIE7844Z0PohMMX8rAlMZLc9DmWIu/poe5S/RSwlADfKxVJKiRpKND5q?=
 =?us-ascii?Q?flHE5Ra2pFBzWFU2RJlhoXBe+yqQBB4YIOllkxKr4duOByy6PXGwgOZwCbzh?=
 =?us-ascii?Q?klwckBp2QLu6XoyjrX1MKKeK+j2YzCa8xTSr2UV7huONvWvCMAAYMm12d3jd?=
 =?us-ascii?Q?cQlK5qSrPenXpGOBd0lzU3DE9ffodplh2F8Xcn/TY0szcAfp6m5iTJ2ahxWv?=
 =?us-ascii?Q?LeevUjBb/3zFtNTHRqNywcB7OwRWXb+ldtzf3JYJke7UpB31TVZaKIB5Erin?=
 =?us-ascii?Q?GNql1H8lrI2UXCTkVCaU5B3+3fdZiQbv5mykhK5jjnBqpsfWrkvdripAQoy1?=
 =?us-ascii?Q?ontX32Dw8D/YuooXTMXrzdBRos40xpPma6rmKDM8UTdcI6ttJRPa2VVCTGLg?=
 =?us-ascii?Q?TgWQDexNnEniu/LFjHxXDInGulBmUwUIn/rhi8vL43us8s0m50Zcrf+sLtcw?=
 =?us-ascii?Q?rBJmWsFQxhAFZUI6WQEYIX5hI9J3jkGTA0K6nnt99n37tA2Ygdn/yn+FGnQ/?=
 =?us-ascii?Q?rU2Pyaw56QhTqaQkW6RSg9LiV/kgZu9n1V+oIAHKk+NL5TXGzPtmezEbaNS3?=
 =?us-ascii?Q?xjQMeA4xQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: IZwwKeySZcWyoasXcC0DXttuChrR96IC/jZteDPlZWNgLbHqkn2VpkoGWBfHZ0VKO3GX1MaT05OBAfKpz76TcXixXXTUyjQtq4EqnDuNMPmK/SeRpJDriDqlmLG5sFYkBDl6lJoXe0N5en2yWJGE1VOz29Gs5xlK5jWLK2hj5bFBKbtrrFNBGNX36H93ic9C
X-Microsoft-Exchange-Diagnostics: 1;DM5P160MB0047;6:mYKJ/C5XGbpZpY7WrPyiyAjPHi7lXP9thJap7LYIWKuDfbr5GRpgiMhR9GyYMOyuCMyjwSmMIkWcspRWNxIp2CdWGrelgK0iEUalECwD2qA0TsDgTsLaKnrjkY2SfU3NIaSJtIEkTxdAskN+MB+6GMCpKvgWSOD+SA5P5TXaJBDLIDcUmEuNsUEK3g8ZLfc4idxD7rVvdjbttWSzlFuJxb3FxL6hYnDX+8jjjTmCD7VPdb+5u219tAqakbRqR2x38rBpHb5H35g7SLVE88yC+RGUUYkLP6L7rcO4L6KIm2Cc8OW6GUyKcoXjgmi2lGhcth3Xt8X+29TTD4VNWTHxk3cmqo2FOKFoIquF0x1nJ4saTXyFIwLodh/T/su2eP/w9Te43yC0gny3pAlX62PefiAX1wZ67Q2syIqeD0Aq7afUeIJbWqjZcPemUlxLbZS6bkNT9k4sR4SUhzmWUOgkOg==;5:8PDs31xhxNIYDwVLq9Gmdn/0WHwbVcwyvE6x7sK3TH/NMRvlQ5iIfWqw825ygRx0PNmQDfXmLNKyZYU/hdfUcTaO834nQ/sXKo3PyJRI2q8WFq6Ziu8fNU/gjaO38RknFT8mifd+R9yGnVwzYBBDkdGhP/YbMUzYr01L7biTmdE=;24:k8ioSUaJ8jEiTb61hoHi8KYZ3BrG5u5OjScdIHosdJSnbblF6xNtSGMOC67l0HiOPMX1lTLClubZzr7OxF/bdiqwhaHz1JJy/TViAouird8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5P160MB0047;7:lTYdQXaXKEMgnEbOEVXeF0j+/EGGWjNSAkWHabMl5ByYXM+1AgSkpDPWuqSMfKqjie5agZfIWWdiblaeegGVxXk2jvYDoqsCXNxhhw9unYUhicrWF4kWOrz+g6V7mC8L33pXb9xWNZmlMc/PDUZJGCw5fK9Hwp92Nh2ofHJ2y0l771iY+Hx62mI74/0d1DQAdeZnLJsw2PC5/8B6724KWQ+9DvObuTKO/V9IF/q4Yd24VOcHPf4hCRbd2U/GjRCj
X-OriginatorOrg: aptiv.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2018 09:42:19.9262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd12b68d-02c9-4d48-d537-08d59622882a
X-MS-Exchange-CrossTenant-Id: 1d57d21b-62d9-4e6a-b97f-39c9a7dcea11
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1d57d21b-62d9-4e6a-b97f-39c9a7dcea11;Ip=[40.103.34.84];Helo=[017-smtp-out.delphi.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P160MB0047
X-RCIS-Action: ALLOW
X-MEG-POLICY: ALLOW
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2U9ubEF025814

This commit fixes the order of parameters passed to regmap_update_bits
function inside spi-ti-qspi driver. Accidentally the code worked
correctly when cs=0, but it is not the case for other values.

Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
---
 drivers/spi/spi-ti-qspi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index c24d9b4..d0ea62d 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
        ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
        if (qspi->ctrl_base) {
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-                                  MEM_CS_EN(spi->chip_select),
-                                  MEM_CS_MASK);
+                                  MEM_CS_MASK,
+                                  MEM_CS_EN(spi->chip_select));
        }
        qspi->mmap_enabled = true;
 }
@@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
        ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
        if (qspi->ctrl_base)
                regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
-                                  0, MEM_CS_MASK);
+                                  MEM_CS_MASK, 0);
        qspi->mmap_enabled = false;
 }

--
2.7.4

**************************************************************************************** Note: If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer. Thank you. ****************************************************************************************
