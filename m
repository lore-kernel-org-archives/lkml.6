Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751472AbeBZRYh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 12:24:37 -0500
Received: from mail-db5eur01on0063.outbound.protection.outlook.com ([104.47.2.63]:4820
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751018AbeBZRYf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 12:24:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [net-next v2 0/4] DPAA Ethernet fixes
Date: Mon, 26 Feb 2018 11:24:00 -0600
Message-Id: <20180226172404.25584-1-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: CY4PR03CA0089.namprd03.prod.outlook.com
 (2603:10b6:910:4d::30) To DB6PR04MB3271.eurprd04.prod.outlook.com
 (2603:10a6:6:11::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ff064c59-76b9-4f3c-4043-08d57d3dcce7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR04MB3271;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;3:KC73OLOgN1GjCjUZSD8RweBO0FYqWhUPWTpAdnFFzsSWq6p/aTZN0qJ6UwDcbHQwD2rsXCAOJPMlq1WACVRFnJHlXkieBtesAJZSkwRPjBjsmOZe01s/KWAzvajbVUbl4cknLoY9ZX7F0Fr6bgTL75R3KlxorLUZNUXYaSkiJpDwOHdX3BaQUDV9sTzojXGAtAebr2DPStS5V3tc4+YT1RlXU2jXsZn1jyRasMYL9ZYLUz/WkUdm4vhcH0/UG1hl;25:qeodjGwhGlEODgDnyVbNPv5Ia+vhrEXr1TxHwgQQBwTAxkm3ZE5gkdsA+aB8ghfwNsxKIw1QK5YFpn7Rtpu7EKCyidRT00EuZprjJozU71zk5hhMcsUDCyGOuAP7OGIwwWJrtgtu6BHYx6c77h5GgF58119ikmM1lLoEIRiKUJFAdjNiIn+Gx+H5omxdZQzl9mkEMO/XPeGUe3z5zTl54Z2lhz5SqWk6kns21KC0L3pJ+nufwoZxuheExmMz2eAumSN5YL9aeD/+PjZkOBhJMHZIG336Yl8ye2QAK6Iv2EpWTezdAbRDyZ5qdahdqaogZ5g5D/q+/7AY4RN3yBhprA==;31:fOQCPPZxV4uei1ELYi91dnzfGrnXNnz9HRl9bo34rQYY52LZ2DR5+sWIrEj9UqMnl57bn+8b9QZWH60NPWKIT4XNQCFXxVT8tv8FaSaRk1eOus7IDOoPyzAL05fx2IJbwKvNjZa7Sea+B7qFApJ5RH6fF3upudhlCIM9z2RagDSgyRbklyw7l3ComViYhI34JVourpDOc3EcSpsZT0i9KgUF1DU90jp4S7cXRQ6N3iY=
X-MS-TrafficTypeDiagnostic: DB6PR04MB3271:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;20:4qVHxKQ4J1q/lVeO7G/9wI58rr0KBKjOKFLDpijTdgDxMfeknt672oyMZT4yQwpCHQL4ESUXdXrCBeBZjRuy84nvk4sMMsWMm4MDyOOOHrxZURfBJtSdL6eMn/GUcU4SEv0zjYsjImOGqZLqTOtr/bLgRJpnpBKmBO/kwoq0a506LIsdDViIpjQra4/PFY4ZPsXnq3LDC05hND2Ij1sT6Xl/g3xZwwmD2Q0wBj7yva0oqyjt18moQTmZBZEdsLb5eEkBLeDrTRf9BnD+JIseWT8X22QK5AsLkkFTGm105wvqvbPV7lcU8NZ3EDznZDLqYN2L/LEA4lby6K1Q9qwcqd3biBuqmqN6DhGQ9JLZm4PJIZ0cRIyHEBmAaxGE0iNsql3QYXv9YiSCjluXy9lgOPvAHe6U8i2bs1nr1l1249fT6h+rjzUVMqFxwG3PbXChB2KMOeub8QJJ0PtgakGAUJdG7iW9/AeVSdbmePnQTKFzq2legqCxPNoCsdybYVnl;4:XJ1B81m4VATwXZsAqQNP1jrox5SJuifQnVtLkMs5ZISRNkVm/FNAc8SAhhEUK99NDo2TnodQrbec1rglbufkLBWpdCTbRSuYRjBldJwDp2542BGzSSZ2FO63aPN2y5M5qcKRShfl46jjsq1JvLf+rNH3oPz6dijS66IrOR+Ojm8QUWDZq60vzUEvaNYtGVofmJm2lJFLgPokWuAhmHqB1B0ri1HeM/aTuNUDCQyt4wlcLn3I1glCgr7f7Pte8UVm2zm3oa6kvXTfqyzkeymc2g==
X-Microsoft-Antispam-PRVS: <DB6PR04MB3271E74E3EBF1042B5679897ECC10@DB6PR04MB3271.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(52105095)(3002001)(6055026)(6041288)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DB6PR04MB3271;BCL:0;PCL:0;RULEID:;SRVR:DB6PR04MB3271;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(8676002)(81156014)(66066001)(81166006)(68736007)(7736002)(305945005)(386003)(316002)(2351001)(50226002)(106356001)(16586007)(47776003)(25786009)(26005)(4326008)(51416003)(8936002)(52116002)(6506007)(16526019)(97736004)(43066004)(2361001)(53936002)(6486002)(6116002)(3846002)(6916009)(6666003)(186003)(5660300001)(50466002)(105586002)(2906002)(3450700001)(36756003)(86362001)(1076002)(48376002)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR04MB3271;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB6PR04MB3271;23:/2Hr4XdOI8uUSGD4gx9gbFAamKVL4M1b8wcwFbL5s?=
 =?us-ascii?Q?yiHzOaoccXTxZ1VGYtqf/bezeB4/iWC8O3Qubl8b/0YmmmKjnnrh9cHrHSjw?=
 =?us-ascii?Q?Yga2chdNlxQIz7FMka0iyWIVAoGM2wNp0u1+f1OtfB80vTq6LYLyJybfFqd9?=
 =?us-ascii?Q?5zS0qFYNmRflPSfUmaFUDD+1mMGUQ5yB/mJzN8GLhJ7QfTht5ouS07tyxxJb?=
 =?us-ascii?Q?GEQ3tdXzsnpyed79YIBb1MAUi8Ry7bmubegXqwbh2N3klkqSeqlpkQVGXSLU?=
 =?us-ascii?Q?AUOFYZIU4M1uLBWHH0ckZ3o9TxhkS5Ko82DDNFBH0oHcnLqpYXQSM/mmG0+U?=
 =?us-ascii?Q?hXDfTiVwjHeKiZg87NHOuFe+/i9wLhQwUKsiCSqsdo/fD8/TOpUGpvi8T6cI?=
 =?us-ascii?Q?aTHvQsdUP1xVet2IX+qpmL5W/UQtSZ/40fKfvbsYgSVwfuv5JkVq4kH5WtMq?=
 =?us-ascii?Q?Dsr075nQJ6Acqi2ZCZ/oRsKrMQR1VSpIogl/1L/7yOa6m1jpHHLx7+V4y0+H?=
 =?us-ascii?Q?Nucr2Vyt8fxwR7NAeIPi6WoiJVfHJZFeIRc14kueEALmVlVpCDNHjZ9Ltw6v?=
 =?us-ascii?Q?TYirAJCZ11VTWBsn0cAvGKkwQbft2h3wJWSX9I161aJvAaAXu/barJ8Fu6ak?=
 =?us-ascii?Q?XXosgh5K2OLHkLfOupTEgwa4Ts42uWUL5SoGs4HnkUjTTvSOtQZ5LDdTaaHd?=
 =?us-ascii?Q?haxam37CSKIUXii1TNxpr0SLOSDIHAkeK4uzLXq4Kj91cFV+hnADP4VcJpAh?=
 =?us-ascii?Q?436yzJl6iAn8Q1Q0sHM3oZdI3I+zwuH6g8mKkK2uVuopOGviCVvgm8IlpAnK?=
 =?us-ascii?Q?By6j88bBuM9TBR0/4E++7l3eRkBs4/1XztbwwKAPiRk6C2DKNKCKgSHrbF/d?=
 =?us-ascii?Q?Z3GDuNV5xeVe/L/gSjcl4G9OkTj6S+urK61/J2QV9TSco9rtNzwU8b6f8jpk?=
 =?us-ascii?Q?HaYevoDTYvrdheBK92fbKu0BYu7JDUKcF9rMhkWA8bmmlpSaYPUz381Si0Zo?=
 =?us-ascii?Q?6poNPYyrTUUfjZnKtCpeLweYYBtB+GN6x4hwbeiGCL+hkBE7+VN4IcQLzwA/?=
 =?us-ascii?Q?ry8pb1xdfS/PjBAM7+Cns3RbQCPo2DVoFusRQGSYCumlkYNnyPfVVgJ+P/pu?=
 =?us-ascii?Q?O1F3OfhDXS6AgboYEwvJHP8B8p173Jmebv+GgCJnEyFZ/4fWg/ekw=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR04MB3271;6:+7lyldJq2svjo+1jeN3OLqDKFz3tBl1pYu1ivN9n7DdbyRMkGgWulSj2JHWTwNKha8ew/X1c92qpNzQQ9RPyvJ2ID6X6hmwwezneB7mbUttrtVsISD6U3xPu+muMIEC+vvDt1bp+3GbTgmYHCJswUog6TkRbYUparhw7r01QpshYMKF05jPqzXJNIr8JZfRPWIzQz1co7bGKtQG6xAMLaWf8y4i9z1L3EUA6a2NIQH7jiPFemABsa2mdmMzIIyz3CyX/mRhjMd53XBu+WU7N4woe3VtE6MkcS7LCuC4Fm3sS9j4y7mdpTg5V7VYkS+COinpcmpoEyHupirMtr7mzrL2SJIjngagvHYQwHO8t7rY=;5:HQ+GLU925kTxaZkSk8PYdUZLmtdSawbJBJTRbyYAtDtSToisRdieFG/OyrHpRu3FmFGza0UIDy5JvbBb/s6IbvNFsrCrwy6QloROda1n2Jbwyf5wUPOu5slC71jO9WrFf3pbsbFOTRHl2o1Q1fjMZ7NlcSDnNt7V1hPJXJ7aGq4=;24:r6JP+eSoTFf2UkAdInhFjQeJzZZlO23usa9FKA0m6zQgj4U9XfZrIKdINCDYmWk4lifnRqBd0Now4j+3lxP7il7oYoNloqXYeSQuZetD+34=;7:gLFWHeSOmk7vVKc7xm5gNUQ9gUPxBwlmFh5xbD/sFmFGqwid9swqNEPKDbKhDY/dQJE0PwsCNMTyUG/S9CzUt/92QiAE9z+EGzc76Y+NVZCwKUjBr0C69knlUdQDYMCBDITSXVzGmDXUvenjXZL6sxgnK7dkFe042m8nX1ijcVhbsy2NOT8LzpqtExIA92NDmJmmvuBL//vxnpjPGKKcs/4JkWUK56bTIK6Q+5J6EKQzE2BB7ttDj64NvLsrXDAh
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 17:24:31.6821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff064c59-76b9-4f3c-4043-08d57d3dcce7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR04MB3271
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed an issue on the Tx path that was visible in netperf
TCP_SENDFILE tests. Addressed another issue with Rx errors
not being always counted. Adding control for allmulti.

v2: rephrased commit message, reduced changes in the SG mapping fix

Madalin Bucur (3):
  dpaa_eth: fix SG mapping
  dpaa_eth: make sure all Rx errors are counted
  dpaa_eth: refactor frag count checking

Radu Bulie (1):
  dpaa_eth: Add allmulti option

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c   | 63 ++++++++++++++----------
 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 19 +++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c | 32 +++++++++++-
 drivers/net/ethernet/freescale/fman/fman_memac.h |  1 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c  | 33 +++++++++++--
 drivers/net/ethernet/freescale/fman/fman_tgec.h  |  1 +
 drivers/net/ethernet/freescale/fman/mac.c        |  3 ++
 drivers/net/ethernet/freescale/fman/mac.h        |  2 +
 9 files changed, 124 insertions(+), 31 deletions(-)

-- 
2.1.0
