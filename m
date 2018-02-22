Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752004AbeBVXHj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:07:39 -0500
Received: from mail-bn3nam01on0071.outbound.protection.outlook.com ([104.47.33.71]:20512
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeBVXHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:07:34 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Carlos Munoz <cmunoz@cavium.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 1/4] MIPS: Octeon: Enable LMTDMA/LMTST operations.
Date: Thu, 22 Feb 2018 15:07:13 -0800
Message-Id: <20180222230716.21442-2-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180222230716.21442-1-david.daney@cavium.com>
References: <20180222230716.21442-1-david.daney@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: CO2PR07CA0064.namprd07.prod.outlook.com (2603:10b6:100::32)
 To DM5PR07MB3180.namprd07.prod.outlook.com (2603:10b6:3:df::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04681320-f26a-4b14-7be8-08d57a490d6c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR07MB3180;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;3:3STlvCiKYATNYQhUYa+qazi8MihDeys/wMmWjYTF2P9wcDvrGr3NgZhIUNXjXdr1B1GBH6A1vpklBsZjogljdMs3SdjTlyya25tA81UYEw/ZfVT2ZFXPL8knymU6fi/lN2SypUKjm9nUeTwK9IhmnawdgEIj8wq1lrDRF79L+XL77+LSAx7VEHMDIOMDv88VRmDm6fesW2BE2BGbMWxrpbiy02VU3aku/hvsH0PLUHA9IhYRv1D/tn2Tc3XQCXQ9;25:T7ZJiL+HbySCPQmk7RPOt5+bD/RT2lSDQK4mb4l0jy9dThaT3Sz/M/ujZ9wv91H1OMjEvxYt3Z8S1LeH1bn+IMqF49jvIKHYwYFR2el5cFxH0CkiVLcJ6JqqzV1PxeLkaqyOsSquBD9KOE0BCrjpc7xhCebZkAqVgauyLRV6lv4k0kg9oHu0+Mm++mbFh5bpWzTY7rYaoiMB7JvVGIbxmkowrnJCWP6kcwnTinK81xhuzqVUtj+okXFzPCfPr2DF8mApbK49xOsDFJmY10LmLXFaiSaz6efuubzdqjskmAoBiErVC5/rQawinwjTKLNjxWSuF3t3NnObS0j95g8CZg==;31:qMA9dxRxatOWmt/2HWaJLEk8+BMZ8lw8OYyRXoSu5z9rzEpx0C0LopcT9i/9/+HTo54GO3AAJDBYYWcavTwEz6cMj1ke0OFkk9jq9nuPXa73dn2pgHiGplrMA/SIJpPVQw9aVyOUDUUwhCzcYbWNXaMS1U+lK6A+/Mt1Upt6sF3x0QbnnH7w7938A5Ss9dV91VvBrl0W0TsD+KWPfDcOoMB+FeWKUj9EtYzm52fPUH4=
X-MS-TrafficTypeDiagnostic: DM5PR07MB3180:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;20:PxBfUFmk9m3xbYXbGfBy75kA8btKqyRF3ndOcKSg9FLSM5APcap3f9HCaplQ6cez5fExLEHXUV/vH8d1nrYiyN0/WNG3gjMn+BEx3BNLLaD/zd7uHCrrq+FnZz/JW8fcFpByysDEqG7/Jp2XxXsPNgi9WuVkTRIkLPVxfZJWgltrIe2zoFhdjcBhBc78n/PK6c7QHUk08U/8jv3rd3n/pEitqmJe0NnWTSaLqzsWHZ1RuQcesLeZ3WNhAtUWKZBYYn604OkEUb+/2T9vpFCQxuv9oO6xhvDrxF8st+4QKDgUq+itbWO9DxR87KF6aw806Yk6NYTi1NBn8sOwjraETpD7DtSrcfcdPoSUvCoDN2CYePKg0YLOCUPUiMdy97o7KdyJg9LnhV2SXUaXGnOu2z5W0grvwIwSac0BeQbOkKKId4L1+mu4KIZiui9MjKs85tZQhibVEEdOOmZKtW7P1wjD6z5a8brDA+ZE/BZyb8iSLuu7HJK7YQ/II7VM+fmS;4:xDYaXd3NFOCnnOlBVnXOOAvgI1JKvAZ8YP5Ac2Xd4vUDmvg7rTINrVF1L2S/lb5ZtBxIWKaxQcQxWdyDqj7nNuYVMFZoe5OsBlz3gvi2Ouer7YdVMvxfbUj4atgdJYtlv82n2lws2C1dpU7HJ3Z5un95LIWNXF+KcVeFS6qD/dVKXHIhlvMROjDdi8nWmpOWzIQn0oF5tTkep16v7cPLY98Ws8deYdgb1Tl3Dtg0oVZh7b3N1lQRtiaVUDIXDLoXLGFFKw9ZrtEkuosNp4rrXA==
X-Microsoft-Antispam-PRVS: <DM5PR07MB3180CFFB282571D967749D9E97CD0@DM5PR07MB3180.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231101)(944501161)(3002001)(6041288)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR07MB3180;BCL:0;PCL:0;RULEID:;SRVR:DM5PR07MB3180;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(376002)(39860400002)(39380400002)(346002)(366004)(189003)(199004)(53936002)(305945005)(53416004)(66066001)(107886003)(6486002)(69596002)(47776003)(6512007)(386003)(6506007)(26005)(5660300001)(50466002)(8676002)(81166006)(16526019)(81156014)(478600001)(316002)(16586007)(54906003)(8936002)(72206003)(48376002)(25786009)(4326008)(105586002)(50226002)(186003)(68736007)(3846002)(6116002)(2950100002)(1076002)(6916009)(6666003)(36756003)(2906002)(7736002)(52116002)(86362001)(76176011)(106356001)(575784001)(97736004)(51416003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR07MB3180;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR07MB3180;23:DaHHWqFqMu5fealSOBGxAIwmjcKxW0gegx5/aXd0e?=
 =?us-ascii?Q?+FIaahveVxwvbWVRqhNhyovymeujgKTwWothgI1P5Rz8qMU2HPOQPhz0mtEy?=
 =?us-ascii?Q?YCn7gIm4Vuk2HWzMIseKWj3W4j2ZlVtU9GYVU2yT43Swym9R6LgzHf9Q3Xp7?=
 =?us-ascii?Q?vENP8SGh0QkkTiscY7NgcUgDyk1ZpgkZLDWYnkGR3suvxTPeGZecibJ+6auC?=
 =?us-ascii?Q?a2yjzLfH/R0BR/c79z2ZgzHAIo+to/p0pbkb7dtqOoWFxn06Qbxpq+Q7C7fO?=
 =?us-ascii?Q?PGhDj1olYfPXNYL9Ui6boXBsaXZW/SaG6czV8E3XA1I6vRCfI/YrpVbKld+s?=
 =?us-ascii?Q?maJ9wml5L1139zKNg+c1E95rafAVuL5onH4yItRkNcxxUzXKcjVwze1kcq+w?=
 =?us-ascii?Q?s1/48e1eyV2ApvZ48ZlN5/CeKLwO1gRTHmC7hR0gjpG2wBnrWZ1y6imRLqxV?=
 =?us-ascii?Q?Z6873zpqb6pPlcP5ZMShIt9xwWTpyPcPJ4qTFX0Iult05DERah7XefBliQ2i?=
 =?us-ascii?Q?YZ1Yjhj4JrsLynCzXtMC9qcgN5XOkyiyiliXfifM1iSY9ytdDcE5B06ZF/o6?=
 =?us-ascii?Q?+kUGiSZXhmDigOIhemWzSz053oRRMuAX+KDVhlTt2YkW2uQEygwYbAIXHx9A?=
 =?us-ascii?Q?xeqE2d95A5ODS8CActXvbuAFI3wI1VgqDxiePLLQLL2pR0ElYhwN1tcY5qQZ?=
 =?us-ascii?Q?FC9fP0XdMDVHtjvZTs4qoHFTAnoVrADHy6t69A/e454fQLqQqI0Pjcbz8l2w?=
 =?us-ascii?Q?WB0BrhbiLI4dEecwnuTo5QlC7Ev0F2pbSnTGtQUOrhrf1yeLUSpl16BIQxg6?=
 =?us-ascii?Q?yon2uJHHN2j2eQ/bYrHYR6LHvfttiQMmfrnC0NTVNN5ypw/0zY5kLKFCd5yU?=
 =?us-ascii?Q?pUskBd3xXhte5xxx2UgY5rUXsLx8sR+XgrlwSWrc0WfUOfrIej7jA8EdDbZM?=
 =?us-ascii?Q?MpNwWWSOXn4hgir1TcyezMeGe9iNFJUvUQylgHhIUhKauwgLVwrFqpWsCq+h?=
 =?us-ascii?Q?8taeQsJtRkPJAShCPV58u9XjzAnBi+JK4kYKH2GUos8R5edjr2g+grCDy0/o?=
 =?us-ascii?Q?qcalbojzGonPUFZBOdhTz3m1mxWhii8JfXIWtTU2Osn6ONtFTCDY4rRVIKXO?=
 =?us-ascii?Q?o7vjfmbMYbSl83WHXJ+7ANIMt7cuZxLg1djggJzjcG5pY5ZD7WFKfHg1CU3k?=
 =?us-ascii?Q?wRdHywv8yQThYHb0mWAcrRnt+RJECHptbOesMoFfBQkUZ7tu22E3oCzVImUI?=
 =?us-ascii?Q?Gvo8/Xh0eKaE2kN75M=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR07MB3180;6:zkUheLppui2fRskZA3YdEXAy+acOdnEXJZNvoB+drL8p6S49ZEImJY25KUtsyjwlbL5ew7CxSftVcSh8pymlrasAk+/BRpdpWqiOpEnEXvtIQ2LiEZRHiQZ2TxbdHH+IPCEmPVX9a5QwladkLWITXoAm2VTvK4D21Rns6oThWAHkM5SWK8h3kH57Tx5gvu+OdRAS4WhYtCwiJlzGR2nZmUPyj/7nMLiwVRbYipxDXGjquyJ9BkekrRoD2ekPXeZ+VaRekM71Ca1GtBge8yy2lA1H2gJWrunGWQNfDYnZEz1EOp4DTvuBrqYZqYdExWlfIZgTqJc1TDeHY4Ll7TeK+ddO8scWhkoZ/6XE9EItP3g=;5:jTwvKczljZZQHg0RZ0M16LstrlssdbjyaQrmB3NpGZW3HUcmqHMFhGB+cpF/7xx3eI3RzP90IUb3GbVQi0seTmKGjwiSKaekuUcIhKl9tdb0BZN6txTJKFlW09dCA+YGBAQk0ku7Jh9Jhcj8mo/ngj6Upi48lPKqGG15TvDfumk=;24:8cjNSWC37gW0VwVfYJhE3OkQvWBH1YZOYtz5Q7LxEjrFjdSyjh3k1VLpySXCilm/yC4Kuol7WlAukSKCBdGvcXmrSYwOqRULP1gisfnmrEs=;7:FvRsA0kbNP8IPD2EQoQuCluAlYOCUuIcyhEFVrSc5C2Zfo/O5j9T/ykVfHBQP/p6pfFbf5D68q1YHAlDfeQsEwuSLaqR9MLBulQ1V3HzY/QNUAfpATBSk+2WLPPcvjguXju/SJgFZKMwgUXhaIxhwfSxAXTOfegP4gj/zM2Du/gN0BHbidN/qIekavZDkFFH5c68/rJU1t0IhCMKe1FTPxmMjNYxGHKXhUagVOMY4Y4YhVRZyJfQWsnGF/HWRPut
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:07:26.1707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04681320-f26a-4b14-7be8-08d57a490d6c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR07MB3180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Carlos Munoz <cmunoz@cavium.com>

LMTDMA/LMTST operations move data between cores and I/O devices:

* LMTST operations can send an address and a variable length
  (up to 128 bytes) of data to an I/O device.
* LMTDMA operations can send an address and a variable length
  (up to 128) of data to the I/O device and then return a
  variable length (up to 128 bytes) response from the I/O device.

For both LMTST and LMTDMA, the data sent to the device is first stored
in the CVMSEG core local memory cache line indexed by
CVMMEMCTL[LMTLINE], the data is then atomically transmitted to the
device with a store to the CVMSEG LMTDMA trigger location.

Reviewed-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Carlos Munoz <cmunoz@cavium.com>
Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/cavium-octeon/setup.c       |  6 ++++++
 arch/mips/include/asm/octeon/octeon.h | 12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index a8034d0dcade..99e6a68bc652 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -609,6 +609,12 @@ void octeon_user_io_init(void)
 #else
 	cvmmemctl.s.cvmsegenak = 0;
 #endif
+	if (OCTEON_IS_OCTEON3()) {
+		/* Enable LMTDMA */
+		cvmmemctl.s.lmtena = 1;
+		/* Scratch line to use for LMT operation */
+		cvmmemctl.s.lmtline = 2;
+	}
 	/* R/W If set, CVMSEG is available for loads/stores in
 	 * supervisor mode. */
 	cvmmemctl.s.cvmsegenas = 0;
diff --git a/arch/mips/include/asm/octeon/octeon.h b/arch/mips/include/asm/octeon/octeon.h
index c99c4b6a79f4..92a17d67c1fa 100644
--- a/arch/mips/include/asm/octeon/octeon.h
+++ b/arch/mips/include/asm/octeon/octeon.h
@@ -179,7 +179,15 @@ union octeon_cvmemctl {
 		/* RO 1 = BIST fail, 0 = BIST pass */
 		__BITFIELD_FIELD(uint64_t wbfbist:1,
 		/* Reserved */
-		__BITFIELD_FIELD(uint64_t reserved:17,
+		__BITFIELD_FIELD(uint64_t reserved_52_57:6,
+		/* When set, LMTDMA/LMTST operations are permitted */
+		__BITFIELD_FIELD(uint64_t lmtena:1,
+		/* Selects the CVMSEG LM cacheline used by LMTDMA
+		 * LMTST and wide atomic store operations.
+		 */
+		__BITFIELD_FIELD(uint64_t lmtline:6,
+		/* Reserved */
+		__BITFIELD_FIELD(uint64_t reserved_41_44:4,
 		/* OCTEON II - TLB replacement policy: 0 = bitmask LRU; 1 = NLU.
 		 * This field selects between the TLB replacement policies:
 		 * bitmask LRU or NLU. Bitmask LRU maintains a mask of
@@ -275,7 +283,7 @@ union octeon_cvmemctl {
 		/* R/W Size of local memory in cache blocks, 54 (6912
 		 * bytes) is max legal value. */
 		__BITFIELD_FIELD(uint64_t lmemsz:6,
-		;)))))))))))))))))))))))))))))))))
+		;))))))))))))))))))))))))))))))))))))
 	} s;
 };
 
-- 
2.14.3
