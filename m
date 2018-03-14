Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751991AbeCNNiW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 09:38:22 -0400
Received: from mail-he1eur01on0069.outbound.protection.outlook.com ([104.47.0.69]:61520
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751408AbeCNNiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 09:38:20 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=madalin.bucur@nxp.com;
From: Madalin Bucur <madalin.bucur@nxp.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        camelia.groza@nxp.com, leoyang.li@nxp.com,
        linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
        Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 0/5] DPAA Ethernet fixes
Date: Wed, 14 Mar 2018 08:37:27 -0500
Message-Id: <20180314133732.24068-1-madalin.bucur@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: madalin.bucur@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.88.168.49]
X-ClientProxiedBy: SN4PR0601CA0024.namprd06.prod.outlook.com
 (2603:10b6:803:2f::34) To AM5PR04MB3267.eurprd04.prod.outlook.com
 (2603:10a6:206:d::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 55bcc9d0-556d-4df4-5fd4-08d589b0d61f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR04MB3267;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;3:YGoZU3FevCaVa4cHVW4fWmPsAx+A9FAB0AaSEDNAoUglqt9FJ27V8IV4i2UHxOf3eDCyeop1OozAm6F5JOG97mPjCQC8on0dyKU5rv+8GfRCeYGv2gyth4HZP+yOD7W/NOYnfnpFQa5nvT/851GcZJhKpUgUsmQKVeXFikb4GxEtFr20d0M+Bifv/C/Lb8d/LkPXiTLSmRCXXFXaClMSwTN2P9Lh5vxoySLyraPdrCbHZxRHxD2pYP76KEJCWzNO;25:44AsUUAcKBlXSZsKFnDciZIOjWdtI+G06do21j5I2wSouzEME4q7mwkFKPKOo1IK8aS7l9L7pMmYrdUiV7W26IXkuB9lINa3as1tqjIqmrvHccRRxcTfz0lErd7tndcsrZkyq+xnFhS04jtEYbp3pbkOH2io8mA81zqPe7csljI3141DJyTIb7UdCOsj9HHT8XspAYw5D0pYytjmuyf1fvDlspgslcibh/r15OYgb5x7J29nTlobZ0kHOHszKU6fudnRgn8kyleGwv9Ypn46nAoJhv/TjPh2xBeHZWB9RubFcZmlzucuT7qjjeTHZwfUSZezjfTQnqZvVDSsnhzmcQ==;31:ezU4MsELH6c3ffpdAnr1Q4r9bQy8CqeBn+cVSOY3ABRAYrPGl4gBZwNG8RCTgboWvUq2FEyXa+PGR3dY53LKrGhtyuhs6bYgIBN9yYZtft7NEVCvhnSrRP6UNHPYmVTqvHfFyOQot3My1nZD42aGS5/C+fmcdPQBpH59VHeTYHqYZL/jYDRWz4b6NTUjKi147YVhbr0fExNmBbIkWqIslhKsCrSyCoAQfyoYVdu8T+E=
X-MS-TrafficTypeDiagnostic: AM5PR04MB3267:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;20:5R+vdBXnYVqljZgtm5z9FpJffJDFdRpEVLTUB0UMbccyPs3FoRjM4wXPo/vG7RzDagJWHkje9QEqhCiipMjdocBY9HEn2ModC3AtmFMqZzfNRPmg+BzOzPaxvcvCGEyj1iJ2RrmhLl15HvAMF5aPBbF2uTIKexFPuy0bH51aKmWcDYKGg4ACyQ7wLHx1xsmpj4DC3ozEJCKF2WLXhD+ibb36N/grfbY7t6qCCELe0Ow7Rw3O6C8zj+9STSqlWtPBq1wfzJ/OAe7at62L/kbCzMl/7wmzpbthmLhz+JGaL1SCU0cIWcmB1zXvdIp31sPcPmMUID1WS9zxQU0aq0qMiEACMIfeqi/qNF/FCD2MORQ52rrxppDYJ0SLRiDaMH3ozQFOErH1Wd+TMu0/bnfbmmvDX5k4Q/c0mEXnjONB5rH3EIuJF4/nO1CO+neMVQ5r+bj9IU9iwIArBxNp0gj4TzJ62orRz2r3ef73knwZKgiAS7ZP/0e8GC+MMpqGAkI8;4:/BsURlnDGSb9WQ1bBSxMHEGeeKXwnAGZJ6A6d+rQZVpKwKvB7B63oFp9EsAH/2WEU3FbJkMOYTcl8MgXz6I52Q/0snoF6FddXIbkOA1gpF1iMNSRvs3mQ3Hl9F6DIBf4vJWuUsIG/MsOpX6ugtcUiCkOjjNh9BnBN3uwTTX2KFznjfuhXtJeKq1R91kK7+rFn5G9zqh9HE3yzcY2mR6h56Rbv5PnRssvFZbPGyxCI3YMGzyAguidK97Ve+lXz3JCQPav/RVxm8YU6nHOCTsV0Q==
X-Microsoft-Antispam-PRVS: <AM5PR04MB3267839A1EDA99985B4AB8F6ECD10@AM5PR04MB3267.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:AM5PR04MB3267;BCL:0;PCL:0;RULEID:;SRVR:AM5PR04MB3267;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(366004)(396003)(199004)(189003)(1076002)(68736007)(7736002)(6916009)(47776003)(4326008)(8676002)(316002)(6666003)(50466002)(81156014)(25786009)(81166006)(66066001)(50226002)(305945005)(3846002)(8936002)(53936002)(6116002)(36756003)(48376002)(2906002)(16526019)(26005)(3450700001)(2361001)(86362001)(186003)(59450400001)(478600001)(51416003)(106356001)(52116002)(16586007)(43066004)(6512007)(2351001)(6486002)(97736004)(5660300001)(386003)(105586002)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3267;H:rhuath.am.freescale.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM5PR04MB3267;23:Y58NjYIK6qPi+kUd5pPX9leWNep4pXzeYJtNuaK8+?=
 =?us-ascii?Q?JVpSLBrLKpGfKN/aiFU8CO704jl6FrOQ3o2XGKMow2klA6wWbqfuCt0hfhDN?=
 =?us-ascii?Q?KcmnyWY55jtsCIvEANkxz0+32lXF3TtUbPQjOfb3Z0nl7o0h/gJ1UfNggm21?=
 =?us-ascii?Q?aIRVK6ZC+KQ+dym1hwcSJOo7GX2Ig/hbCFYg2hIqWD8JPe52QP9PR96LIOi0?=
 =?us-ascii?Q?uZ7/Gdoekuwo0+es1/ThwH9DDfl16TOqT6HyNigvvxO8MDUQLKYnItDUyjgI?=
 =?us-ascii?Q?E+Dzrol/MuaKpEc8UnWEWfkEjHI3qpUP9CEna0n/gKrInTKa2IACSS5eFOHG?=
 =?us-ascii?Q?A90mgr4TBB/z+S8KPwAaXdGQUzSUbaByk8++JX10h/RchpALYBtZQtGW3y/h?=
 =?us-ascii?Q?cBInL9lfeMTF9o5VJpYp+ZKTeVKBt3yNpA+E3sMg4fTKDYH0YryAGXIU854f?=
 =?us-ascii?Q?p3whjSNuNO82w/5sETb+rM+CEpXvVqr/ewxRaaN9XVb3PnvaTZ5XfS9KOWgm?=
 =?us-ascii?Q?wgFZbrZ8+zRZneP0DmJP2mOYamikDa3CM0ZNMFyWH6uqr90ApzxC1juhPaRg?=
 =?us-ascii?Q?dINTY6SxOndgTutUjyfgp8d19yUbF8OVjOF2DcC27AOCZqEj2h2XWgZlPibf?=
 =?us-ascii?Q?Dvd3oCnJQBOOOOhZmY6Tz9FV5z/V2IqnZyeU6I3USP/k4ymJJbTbz3OJWt+N?=
 =?us-ascii?Q?WmgpDD3drbdzzOblkRbtyKhuhB0C+jbW87HAjqr9QWoUq9hPwqd18nEZEhj2?=
 =?us-ascii?Q?+yxoiE6veP3xMa/Zfof76SD8I3jlknUWAg4u0UM6QNje+qhTxiFPXk+iuQs7?=
 =?us-ascii?Q?22BQUvRx7606EK/EneOH2rAa0cNznoUJVePRIJAZUbwdaXM8f9jkQJAQEUEC?=
 =?us-ascii?Q?gA65t79tKOj0Aq8bACQXazfQK0RpfT7u+3fwo3ewB7T498d4HhBZ9bncJAE0?=
 =?us-ascii?Q?6QmPn3T6G8/4+/fcB0h6RyElybg8gx+G7wFmG0CbK8wrJZvS1eB+C66YPO7j?=
 =?us-ascii?Q?65MKEG3OljNO7NTywK2dqXGKHd9UhzGcU+tLiJhl4UfOkco2jLc9Fx2LVaGH?=
 =?us-ascii?Q?UBzraz0bjoBm37FWCRIVEpRfaUapoq30B8/5+c3AI5eydBaUBhvaOujOwP02?=
 =?us-ascii?Q?5OKl73pyRZc6Ib8nqilkb77iYE87TugrkChvZeID9kE9/Bmj4h24wCldKSMm?=
 =?us-ascii?Q?Qa4HoZAn0ZZ1V4=3D?=
X-Microsoft-Antispam-Message-Info: LBTSGBlWyEuVs0x9hk7YqB6Tuu9PaBYAJ+AZlV3Yb1JIR+Q/8vbZY2eLr5JxNUpPbwQFQq39XKDlcEnZqaMS9O9G0IWsFR12fELPbYebuIadoYaFr5S1cnLk36xQz5iYaXK4BoiqP0KxWxYrbRFvMeHPjy4zP8Qhk28qNV+bl4LuDIn84D9hDslshxbc7m/a
X-Microsoft-Exchange-Diagnostics: 1;AM5PR04MB3267;6:2jLzS3rlheS0WUHMuF7IyohrbYkcQFMJAOuiOGB745YZe1JUX5w6ZB88vdHu7Bl7AFdiXYx0reUl1eneC92dfu4H9ZEFjWsvP5ARqlMQ9PLe+UkJkRDExNY8Ug0hDYjH4VIIAJ0DVP2NBqpt+3PGx5Dzvh9LXc/8BuBw2DU/NGcq4taiCsn6VuPpoXRwzAIWW8bHNhxjzO5vyD1AkchOFW59z/+dghYNZfmpDsKwh8+TzdUlm2Bre9DVKyv1bFzx1LKw9cnQVWUfA26+75xPg3hp7xDM2RoB9Z3sVZJ4XVJ0pClrACEEvefkjMobRePpR4ZETu8/XxNEkbLSgLOGak5QWl9F+9XhleJFsB2EPS0=;5:7MHS3NbrhG24yYZPYCUWvz6zk1TzJ2DP1EmvtYI5HQouDulR19KMq4/7KDqbyv3u8Sz1gQZNTPrV0nLsygxXD6Wm3+UFHvr4JaeArEcclO0+KH0HJ3e2FvDGfgd0LbsOammeAAKkuFuUao9wnxYtxoi3A7APslkAw60l54zx4hI=;24:RX3NS3dDQGk+IY1IOjt10tln6tLCH1idJtBPRm1na58sgA9PAimZRGLdJ4IxXE1FXibhqX/y6GsuQD4dcH/+bz6MAupR2q9Plj9ktShtHhM=;7:k5FqY3p76F5HKutZuCLesRNAUAtN4x8/rscwE7KWJ8c0cVg+iiJ2S96ieJartgvg5MTyStY+SvdCDkTAzoKhQ1dOub3I9+f4dL81i1wzGfj2lt9F2Ei5z8hbxb/Wti4BH7gXeoUsNTA9ynqzPUJXBhaeKxmccB467BjYudR9tbfNEmwQZixD/+ujT9cIkTNPqy3tDlzh+sYV3pQvw9oGhRmbCyeQNkcR26szHdUo72lO7X9mI91pPAPOts3+mx29
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 13:38:12.6485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bcc9d0-556d-4df4-5fd4-08d589b0d61f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3267
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch set is addressing several issues in the DPAA Ethernet
driver suite:

 - module unload crash caused by wrong reference to device being left
   in the cleanup code after the DSA related changes
 - scheduling wile atomic bug in QMan code revealed during dpaa_eth
   module unload
 - a couple of error counter fixes, a duplicated init in dpaa_eth.

Madalin

Camelia Groza (3):
  dpaa_eth: remove duplicate initialization
  dpaa_eth: increment the RX dropped counter when needed
  dpaa_eth: remove duplicate increment of the tx_errors counter

Madalin Bucur (2):
  soc/fsl/qbman: fix issue in qman_delete_cgr_safe()
  dpaa_eth: fix error in dpaa_remove()

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  8 ++++----
 drivers/soc/fsl/qbman/qman.c                   | 28 +++++---------------------
 2 files changed, 9 insertions(+), 27 deletions(-)

-- 
2.1.0
