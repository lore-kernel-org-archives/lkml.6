Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeDQJDS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:03:18 -0400
Received: from mail-ve1eur01on0064.outbound.protection.outlook.com ([104.47.1.64]:26474
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751232AbeDQJDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:03:15 -0400
From: Vicentiu Galanopulo <vicentiu.galanopulo@nxp.com>
To: andrew@lunn.ch, robh@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, marcel@holtmann.org, devicetree@vger.kernel.org
Cc: alexandru.marginean@nxp.com, madalin.bucur@nxp.com,
        vicentiu.galanopulo@nxp.com
Subject: [PATCH net-next 0/3] net: phy: Enable C45 vendor specific MDIO register addr space
Date: Tue, 17 Apr 2018 04:02:30 -0500
Message-Id: <20180417090233.21548-1-vicentiu.galanopulo@nxp.com>
X-Mailer: git-send-email 2.8.3
Reply-to: vicentiu.galanopulo@nxp.com
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [64.157.242.222]
X-ClientProxiedBy: MWHPR12CA0056.namprd12.prod.outlook.com
 (2603:10b6:300:103::18) To AM0PR04MB4116.eurprd04.prod.outlook.com
 (2603:10a6:208:65::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4116;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;3:5VNG5f45WnsFvcTUWXuw55b8ZR5tdKVfvuJgkL4oD20n1MS4TSSisPCwMy6AaJiokBOYzUUGiQHohjb8IcbDBdCevHlGdHiUhLRA3yJ7SfBbrF+/ky8IrvjRHDVY4kujaaIWDKeP1um2HtBqvepxVbMhWgndAy85HZkqRYUSe6uDbHeLLNBQ1uyLjrKtaEY5VUHBUk1CozT1Clut+cZ24bOYy+Vq42vGOK2Wp2wwOXmwUjqbM1V5gHYcO6EnGWH0;25:oul5NVkykayRCqqC3i73bX2JmnzzvmAnXuPoKZaDpu3Hj80SBWNPvntS9Y4C5P6asWoi2YQOy7SrVCmR5ixm4nHvIcH7aX3Mrs1dlGnoE6S9nyH1yZyVf4cj0L5BFlV5I0G6M51hDDuYL5xTlr73bTWwIyC4N1KgFqyDMV5tCgsy9n3iR86ZRM5HQ6w8OXlO+9puA/gIJzpcfm1aclcSlwDFsV2v3Ph2tfymf+ou7u96bIBXGWKdRMj8GbGZD20OLimslv0X9gJCJ37k0cE51ePUv9qCEgKw3XmaLISY/aH2o3Soq4bxSbvly/R5jA6hveQgtDbrvZZY7F3BTzis2g==;31:EGAebmHzPMbQeAYL/dNtYwKjnfXNY/8EXu0CUm8Nke91qIsknG76OYW8jWba/pgIGi2bjHSZpu5+n8WmEKyU/uJN/1ai5coTY6CuM16CvFL9+8Hne1TudC2sBIT5YJPx8IsIVKkj5L5OuAk707kl6yh5m8ONBzk1hvmAaNTkV7mQPYlofFQKliTpgrez3ZNvi5IFQNFkvPmvWlfHYFLtKqq1GfT8HDwEulmZqIIS0iM=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4116:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vicentiu.galanopulo@nxp.com;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;20:X5FgaU0TldWH/k1eV45UMgRuHTDNHArNTLCXhIzPBQJzllds1tNNun/qZhINbhMSwPv46PeYJ1mAhtyMJD1boofcUAbcvuEPRP9DSkkNmlSSZ4s29aYH5o6lyJKe7c2Bm7JX+siOvmYsQhiw1kmj5EXdyI0LOadtyFMK9ETscnwftgAfkrKZ6r7sIVwuhM69pQfjrMpGsW1eYjJPG3WN2ukmId6hciwIlFjVw3IrApQDEkzcUtAhBqhZLo2FzVeyF4++Xr6rUSFWDAauIKMujPlGjSn8VQyCm1fdXAFVBm1jJJLIYkAJvxxcp56nz9asxbRZ4PDn1A0Z5ZFgxEFDStsTbLq0SJelHW3bYCMOdlVIbwe8xY02B/mpJ2Azio4rf6d/2G97iC7QdxSQdUHpiCRWu9Avxy8JDavXF7cV+Nqa7piWTxhnOV5oiynWiEr0qFbe25uWjfwhsMCnYhEOXipnYV02aHuKfb4BH4r32yrY572v87deo7XUG1y5Bl5K;4:c8428rUF7wHxmGCD8w/SX6qakmLJmp1ogJ+sqrL5sX5y6Vm2AYLQ77JcC6N9FVA+CFcLSEPmBsDU8njanWQFGwc7RYwf2FC/Q9TWh9JaSvfAsWbyjadfJBLkGqmbgpx72Necktf+J4Yp2yf012brp6jxcv/XtGgN6lYEPbWEAoAsmEC8VU9Q/WygCIZsnAi7TqFeMuWMfTlv6WM93aLHrIN7JMMaj2fS4AKQ9Glky9aySScmnGIY8eTM3CXdy3eiP0ehD4becHJM7bRyJ+JEWw==
X-Microsoft-Antispam-PRVS: <AM0PR04MB41161F3BCBC23E6A12AB5CC7EEB70@AM0PR04MB4116.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(944501359)(52105095)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:AM0PR04MB4116;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4116;
X-Forefront-PRVS: 0645BEB7AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(376002)(366004)(39860400002)(346002)(396003)(189003)(199004)(956004)(6506007)(47776003)(105586002)(50226002)(305945005)(16526019)(8676002)(81166006)(81156014)(8936002)(2906002)(48376002)(68736007)(25786009)(50466002)(478600001)(386003)(97736004)(66066001)(6116002)(106356001)(316002)(16586007)(52116002)(3846002)(53936002)(36756003)(51416003)(1076002)(186003)(6512007)(4326008)(44832011)(2616005)(486006)(476003)(7736002)(5660300001)(43066004)(3450700001)(86362001)(6666003)(6486002)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4116;H:rhuath.am.freescale.net;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR04MB4116;23:IjnnbKjkQUmVL48Z1twZYMPVdWT3XIXqeCJiwxUJW?=
 =?us-ascii?Q?gkDS4bkRsjRYhetUup3+NthgjvEU1yLtIgBCZe6U5Ko0UNq/7ouZoT7MzHaw?=
 =?us-ascii?Q?RerUUj1S/WBVjoNIQuRKJxNV0gRmdTtkBNkAoFUiEaiNUC06MmgUnve1/cBh?=
 =?us-ascii?Q?+Vwpn13y0OYFZlkh6h8xZp2pnXTlH7hmwqSzSBCHXeVyYyU1niJ+hbZ4jVF9?=
 =?us-ascii?Q?YTrbs4CO8b+hUegBwCvdSVTQOi/BaFFTAZhQnAVPXM5hlpQlnCag/VMYQmBX?=
 =?us-ascii?Q?MIfgmkboAs34v9Q9wLYDKL/yYJKNkMFm4zcl2IXwsRTi8Rc4JKovu/cPapGl?=
 =?us-ascii?Q?1oXjk5zc4MbR/xDNX5TqR5aNAUEvL2RWhmIXnOujYkmGM+Pux5LWVaUfSRff?=
 =?us-ascii?Q?Eq90SNJkNqaDXbe7wzb5ziFSfrf+SXxc6Y+FyBoGMeh9p+mcy5mzOzz317sd?=
 =?us-ascii?Q?dZWJYWIQxVl5RY4RU1jhnu/V6BchtmvscGDdQ1KqUEXMx/zXLaRfERYLYVav?=
 =?us-ascii?Q?3E+jIgCpIjvOuyGkZFmYS5VWFsn1RIzXyWVFMHj6aUUVBL4cF91QGxqNT65a?=
 =?us-ascii?Q?qkgQXTwvOsSBe5kVzlc8T6iKXGTuvQNeIAR5LntZcQ5EZ1slhcCc2Jh2Vygf?=
 =?us-ascii?Q?D5UIolbcVkFFIaTtlKxhj3QH5uSBY30R26cjGZcLBNaSoepenJRmHqLgn680?=
 =?us-ascii?Q?7ilzWToq0pFyKMGDG+lGy5K7VSNfJNpu7qpoFgDkpO85Wt0rZDXwAba8lEBZ?=
 =?us-ascii?Q?kfKWAFWW1N8q8BqA2vAOeHmEKdCwzryz3MyoduqltQwBM72UX/+NOHmDBW8T?=
 =?us-ascii?Q?5saDb5Sr47WEU9Mj49bROZ7kRxJ9nXUWhP/aEXkboBMs4oJeVpgq6bY6FM+/?=
 =?us-ascii?Q?yHltt70wociGpUZz/1TUvk6Q7b3nN0p0lA+LKMHUydMkJJILputPX0+6YsK+?=
 =?us-ascii?Q?KS6Uk2EUPPZhdt5hJIdY/kE90xVq3pMMh/H9/pJXtefqgZUWimkMdkm4Ayfn?=
 =?us-ascii?Q?fZwADcr20znErp6OSA7GYDos0N5Q4OoIYtgMqm3Jy6AavzqwQpAoWgaN6ifI?=
 =?us-ascii?Q?GH8iILqt1Fe1aX9qDor7LdFzk6pMK/ZpOz8Fqfdb0+Ept0KjusfOimq/Vca4?=
 =?us-ascii?Q?a4moGePGur8pt9TcGxHTS0s/nyLMmyM83TDOWWWkkStOppCtbJpfEhWNt/Ka?=
 =?us-ascii?Q?VmNP+Oarz2xcP0=3D?=
X-Microsoft-Antispam-Message-Info: sVxJRlD/wxmw/zaWCh9RA1URtCab60bgT5dcEiWAsyljKZ3XK8pEaNtbwIHeaVHR4I0LNEW+UPTrGtyv66yypCj/1YEazdEDddsGYcS73/UxoDdQ7Ol8vDBFP6vGeo8Cc3AKv5SGtuLh5QATh8uTIkAOBk20ebwgeI7MQ3cUkQ0AXGcqRQxPx1HI6/ofOxpx
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;6:UU5XwhprRR5+1aqzT8G4VswF2tz7WThAWm+OuKLJ6StZaNT31YH7jUsBlsSle4kP+V5l9Iew6SNN4hMVoGeFRyorU2kKUmWpQlSXYUyllJbBb35CLrJEbnWmOGl9dm4KjNrQZ/wdeHzW5hnAhW6exF/j/VRU026ys9I41TRNX8P1hgG5wWIR7BpH+F0BNYZLzDwxOB1SgCeElttyhanAEMBu93btC9UPHcHxiAyJSAcNXYaKIu2ij5oM1+taLmnVwqwLGvTQayNyQefD6/6VhZRLL6MEs7QcgYLtVuPYkVONWwWb8UfFnnhdn+xx54GPky5WkpWk7KZcbl9zZVCaqACoV6v5vsZwho5uHoPOjAWvkBD7jGRQ/UMS9eLVMRM50XoJ06+uuEkAJULTHMFRRcWFDq+Y8AXYMn9fjQtYhctSwsHwGg6FPywP93v/mrsgoUdO4HP/nUSSpuclqGkkHw==;5:nDwioNKD6Cro8Widmmi0X99+PIYDdmqLxRmJlbBY3SLw3UCyYoBUBSOagbhqDcqt+m3eyzy2SDYBqgD4eDCJbHMfqKgu9Qi3sGsQmwsoapFzNyKRG6siYHMBSVU2Sivf/BqlhDPNQJB0+qhNkXlLIXMJDx0Nh/LsU5gHVSiCPP0=;24:EFGjO+EhRKbaYSJ2xOzUPNi+aWQtNhTwKvSvXjfxQHr7algOoEqPW3TJEQ9CXRvc7jxS7QkH8vZ8X7w1uKqwkXIip0qHHp9S52Sw8L9mnBY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4116;7:u9RaYuneAM/s6zO8NDpRDtgtw7Sj8iTn3ReliwDvhwVLZsxYmnBUHI7fb/Jg3obisl8IUOUfqjeBZnnVf9kteusirlvqM13f+6LdgfTwoKaWSDExKjDob7jXZYdASaaIzxRbGlCTcxO0PtsRdykCCnBs8JJnvT5L1IzwenQEUtDJ+0/qRc43lrpBbFt/UZmb4E9ATYyzWEZaeHbmHIGzlKcBvUfUbPMV9FxlRwEFuIU6KFfOXk1UzoDrZv3gKXuM
X-MS-Office365-Filtering-Correlation-Id: a479c73f-2945-4f35-37f7-08d5a4420c78
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2018 09:03:10.0076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a479c73f-2945-4f35-37f7-08d5a4420c78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4116
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enabling the discovery on the MDIO bus of PHYs which
have a vendor specific address space for accessing the C45 MDIO registers.

Vicentiu Galanopulo (3):
  net: phy: Add binding for vendor specific C45 MDIO address space
  net: phy: Change the array size to 32 for device_ids
  net: phy: Enable C45 PHYs with vendor specific address space

 Documentation/devicetree/bindings/net/phy.txt |   6 ++
 drivers/net/phy/phy_device.c                  |  49 ++++++++++-
 drivers/of/of_mdio.c                          | 113 +++++++++++++++++++++++++-
 include/linux/phy.h                           |  16 +++-
 4 files changed, 176 insertions(+), 8 deletions(-)

-- 
2.7.4
