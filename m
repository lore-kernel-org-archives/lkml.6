Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751886AbeBVXcW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 18:32:22 -0500
Received: from mail-sn1nam02on0053.outbound.protection.outlook.com ([104.47.36.53]:53376
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750916AbeBVXcU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 18:32:20 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=David.Daney@cavium.com;
From: David Daney <david.daney@cavium.com>
To: linux-mips@linux-mips.org, ralf@linux-mips.org,
        James Hogan <james.hogan@mips.com>, netdev@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org,
        "Steven J. Hill" <steven.hill@cavium.com>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH v8 0/3] netdev: octeon-ethernet: Add Cavium Octeon III support.
Date: Thu, 22 Feb 2018 15:32:02 -0800
Message-Id: <20180222233205.28857-1-david.daney@cavium.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [50.233.148.156]
X-ClientProxiedBy: DM5PR07CA0025.namprd07.prod.outlook.com
 (2603:10b6:3:16::11) To CY4PR07MB3176.namprd07.prod.outlook.com
 (2603:10b6:903:cf::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49bebe3a-ecf4-4f95-8137-08d57a4c826a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR07MB3176;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;3:bDc45hbT6IhjpVBjvj6y+vngmSGOtvsb8iaBRSHA3FowgLKWmHtKoxQjT2vYDiZbbaaghw2eB91nQeXH5H3Ln2Lin2h/b+neuPU33+QlcHF731npovGCTIccB46aBTyPwsPBYHgq5Q2oLnWit2ZPYbVjd2GTeZoRJmAYIGIwunnitW+jZ7Fm6ASp6pYaTd8YxpMFK2jOzvfJoTfuMwdtA9R03xGr34zgp+cR4HItv16JazG5cc8Gnh65NlGCgxkY;25:GxsqI+ndlEiXCQniajiOS2PhKfy+R+roW+5bHp0hTDaPqllSEIInA/TMJzfPl8W2uasp8GzrqLhH6EBhd6sPf894hOVCnz3p2XTTsRf1rxyxSpIC6Q6VpenO8RGIH+/QEKs9k2vPGNILYjbiL28COrwiOuOKHGr6k+xuN/SCPvcQF72I6vJmaNrQN28q1Ovc6WPWG2N31GttS3OOOgt29SVB96qDnkrGCw8HInMhUdwn4Zr5OFzkZyWZE2Xq8vgMkcupooMtnuTSuZC9hcZLTe/HzMKPPI2zcp52BjvrImXF4z9OZcMjQYz6EFxm/mUWyaGkkaJD2CVszacUafZLwA==;31:fon3AMkvlVsQ9O1067kjBEigScSpUwlZvKs/uRqHbs+ac5V2GzOCnNHslomFBmfL0tBWEguN7/YHyBznzzu8STXDsX1Je9j9i20i1IS+5awgQWCrjMQLdtUK77tANcqswCYT0NfIjbO37ljPPwbApoLPSqGl+TOgQAxEIF1mDuQYNrMHeQkuXgCaXRi8pvLYZwbmBns9lWzhtYSFRB39hBjony8Yz/eOSyIkYRTtGFo=
X-MS-TrafficTypeDiagnostic: CY4PR07MB3176:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;20:xLqREN/HuuTuvzOqEJ0ee/kQps5wi5TD4T/kS9kpEFNGsTB4vWPGs7ziEbIvQ+qvWUAGu9d9mccRoLnH0NuKw4HIgP2Taw2VbFsmUv4MJCtA7gycsareEArAVRekE82sFQjsRyQrtO5d3M3oENQypQBOok/x/Mew8f+2UWSVV4RuFoiOY6uG48mqW3BO2ddrO7acGc5eHF+pW0e1R+J3JKpf1OKTRdwL7DZyY6LHPs4EeHJO4bfAYhRpM9/3KjVyPh7MTj4of8BhGLwMLekO7r+mnNVy3y17jzqo5RTi8biEHpA7+gM85wkJvWTF3fx3i/xoHv8vWM4cE05DtkqxAt/BL3MwXHP+iE66lJkM2ljFZ4UfQTG60hQp5wscRoBKj1+qLU0HaFbDF2SxRpawLk2JH91/jsqB5QKDMjft75sYxF6WMZ+x5EfWymdVLfHYq91bvI/OSQNhBeCrPHvAWD2YWOvQkWQNqhaHwSlIefGwz6D9c76lXYiIiKa7TNTt;4:TRLedXktiU0wS2fKllS9N5qbB70CvlLL6HiNIjEZS8HquDTtOU0WSwexyUUvzcpZugvz4Hjc+emwR4J2krFOmNVV86OPsH89PJcg0l7a1aI/lHoyBZ5Y2us1TM4YPThF8WnAgmtTLW/hSqVK43UpH7rdSI2wyth4xf6xvl5rvNJiEFE7X9pJhcW/NgZUGRCUjiqCE9WK5vy6jss/Ww5n5dPi4RHD4aNuEUl54R9+7Q5kDYi5R3pa1qR6UChMjWEEhz05gPjI4uGu93l6r+CwNA==
X-Microsoft-Antispam-PRVS: <CY4PR07MB3176B677C9A5B32696EECDC497CD0@CY4PR07MB3176.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001082)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY4PR07MB3176;BCL:0;PCL:0;RULEID:;SRVR:CY4PR07MB3176;
X-Forefront-PRVS: 059185FE08
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(346002)(376002)(396003)(366004)(199004)(189003)(316002)(1076002)(5660300001)(25786009)(478600001)(305945005)(7416002)(97736004)(68736007)(105586002)(66066001)(47776003)(6116002)(3846002)(86362001)(2906002)(53936002)(107886003)(16586007)(54906003)(6666003)(50226002)(39060400002)(16526019)(52116002)(6512007)(110136005)(6486002)(4326008)(106356001)(51416003)(8676002)(7736002)(59450400001)(6506007)(386003)(8936002)(53416004)(72206003)(48376002)(50466002)(81166006)(69596002)(81156014)(186003)(36756003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3176;H:ddl.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR07MB3176;23:AU5w2So9NrdE8aq1WpprDspt25uV/aIazWIalg2FA?=
 =?us-ascii?Q?+B69PorKqu0lq+Yl2fSFzw7y3IpSArp5hEQhbf2+G7f7KCkw0TUi9mM7j+PQ?=
 =?us-ascii?Q?wv4JvmKlXugYB0DNLkMLxhZwIOztStxY/PvHcladPYSn/XowVzGqxEQbra82?=
 =?us-ascii?Q?kAHLORlhPdeLPtNjqfW1EB4yJhw4Dj+Gzcshw2XD+BnO9PO1ttGGuTWMTI/o?=
 =?us-ascii?Q?j2CJuhzsyV2/FbcbmgRKjj7g6ak0fYHLqAOClCQmdcyHHTgdW8Pjd4/v2/qL?=
 =?us-ascii?Q?EZevfE5JuK+g4Tg23j9Un1VYxcEIcHZAK56pzXpk2NYWED49gi/xkwVhW621?=
 =?us-ascii?Q?MH48/igj9r8hwz2ulMkK3R5mY+8lKuw2oT3lSlBGv6Cj2m7RDm26rPdd2yrN?=
 =?us-ascii?Q?PcurkWWhItcihquKnrCuQA7Hy/cF21zlg2VE9wt41DrUAsy7FWMeKX9Kybl6?=
 =?us-ascii?Q?NhPXgOF1jfO8HoYlOK2gFU6CYkU1/q5YDBf/h98wE9liAL0lSzmWUnQI2ShD?=
 =?us-ascii?Q?THshu4yKcQ/IDXIm4x9QXnPqB3cOQdm5hzvTHq285jFJBdwn9ReAUXs0k3Ip?=
 =?us-ascii?Q?HiixWtO4fzZLaAhKX71Y+6F1+5HeQFe5Cxj1vdBUCWADyVEDKD6u5dMutcDY?=
 =?us-ascii?Q?o+UuTt2+hO0qD5bvbgBWQYmm2+K/S4PH6EfJO8HbsuioVHsiT7+1mMySFca0?=
 =?us-ascii?Q?yDmpt3mufwBUHEzpNtAQSso2hIo+atZmBEk93Eh8BlzHF6e8BuZlzqNbxAyn?=
 =?us-ascii?Q?pqy65h6YQedlevnGNbQzkY4mIstSNMDCUIT4dcMgyQ0I8VMz0rqm7cLyZ12i?=
 =?us-ascii?Q?lF6x2DUQvJo22vezzvKZETrvNspCEljWabGI98Tnf1Y+M4EOBiolK4QN/oei?=
 =?us-ascii?Q?Yz7UO2j0L9Ox1kN+FGUpyt6/v5jL4wyDOEcK9AwmoSUx8BrL05BbPhkulS7Y?=
 =?us-ascii?Q?PNPOhucT4C6qwn2qbrns5+djs5amVfkNELD7ZKcuooDkIePPvS2NLaVawYo0?=
 =?us-ascii?Q?J0IFZz4igk93PGrKASEGo2TFWsLg0A93fGVzO2GsZbVALti2ieXc1hpIj+4g?=
 =?us-ascii?Q?P87/3vTbEediuIx94M1A/1bK1O99gVSrWzJtdFZetjk1k1Nb+YcS7UvibrTF?=
 =?us-ascii?Q?BtPYPguGF81mZhf5cMs07xp6FmonkqJBhyuAHfQHrn86UDm+kEyZ7QCHfhXh?=
 =?us-ascii?Q?gPJCi1IaluONILag5plQsQgGGRw7EpQ3Z1AnsCsIZ0IxXEcDz1MFgqCVTjaD?=
 =?us-ascii?Q?ljCD3rMttryE6/1riE=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR07MB3176;6:yvq3k6gwiH/lNG6RPc8RvrQdz3Rk72EyeXV8s8J7jnNja9fFn6KZuMlIGntnWfuGwx3TdIFKR/VRT+rZ6t43UHim8HD57r2khFZzBCza2+vibMTcbB2BjUv8UwAX9PivPtvmV8rru+IyvV/bV7TFrWtol6rS6gPEZAqNwiaSnBzRQh81lA7qIwGPHeyCn7wi3aQnr64E0T7KJtvHJWZ2PoV0p13pymmkZ4aFj8e5Q/dASEB0m6l2OWqHwuzz/Hmg28fSBdHSn9F5ZaZAQ1zoG9p9KF3rAsWkrJt1XSr0qZMenHQV+vvMhSHXpv1t4C+1lTdjOBX6lJ1kbi2GJC2lFNK9ix+dpY1NzA3ggBCAwhQ=;5:lVm9mT57Nk9LWpIqeTIxCtJRSvnLWYsSeSlfkLJbmy6O7IhIS+9iWHin62aBWX+ULF7X9aO+rtWSpM6+0rYKH64FyYgmcE8re3ro7Ts6CKQO3vA+RCizJHvJstcNDvydmVCnYqJlwMd4o5rPvL3yP+EECWJILVnwYRk7yHKPB6s=;24:HiJ0PHu0e8saC9G/Ts+KLL/J7az+mwyQZ4G9+gmfVKgqW5VjzsVwMdj4pC21woANQn1WFe0gC5SAp4/L1NRsTTt8u3GpE4i5Uv4IqKJWPWA=;7:SS9xq7NVg2tggNgpxhIdSLRFxQxUZMb5TwDNvjzfqJ6uzFpn33Oz4ySg7liOVXVTaLiBlI9V4ossVnvKVCmnwpztYLBGJtoTMVZdbtkjbXCQcor0ZhxBeTQ2y1w1cQcCFiZwvxlARAqHpgNJYaVKRvfoBziiSwK72E4YpXsdFVx3DYjIL8/bdHmWlqdo/DbQCEgoSbpy9oNngCG258ieh0ygqei0njMvPZ+WQaOrfKvLCZJTs+iT7yqx2OxyeCGf
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2018 23:32:15.6758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49bebe3a-ecf4-4f95-8137-08d57a4c826a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3176
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are adding the Cavium OCTEON-III network driver.  Since interacting
with the input and output queues is done via special CPU local memory,
we also need to add support to the MIPS/Octeon architecture code.  The
four patch set to add this prerequisite code has been split out to a
seperate patch set sent to the mips-linux list.

A separate pull request was recently done by Steven Hill for the
firmware required by the driver.

Changes in v8:

o Fixed locking in bgx port functions as noted by davem.

o Corrected SPDX-License-Identifier tags.

o Split driver from prerequisite patches.

Changes in v7:

o There was no v7, we go to v8 to synchronize version numbers with
prerequisites.

Changes in v6:

o Added back cleanup patch for previous generation SoC "staging"
  driver, as Greg K-H acked it.

o Moved FPA driver to drivers/net/ethernet/cavium/octeon as it is
  currently only used by the octeon3-ethernet driver.

o Many code formatting fixes as noted by davem.

Changes in v5:

o Removed cleanup patch for previous generation SoC "staging" driver,
  as it will be sent as a follow-on.

o Fixed kernel doc formatting in all patches.

o Removed redundant licensing text boilerplate.

o Reviewed-by: header added to 2/7.

o Rewrote locking code in 3/7 to eliminate inline asm.

Changes in v4:

o Use phy_print_status() instead of open coding the equivalent.

o Print warning on phy mode mismatch.

o Improve dt-bindings and add Acked-by.

Changes in v3:

o Fix PKI (RX path) initialization to work with little endian kernel.

Changes in v2:

o Cleanup and use of standard bindings in the device tree bindings
  document.

o Added (hopefully) clarifying comments about several OCTEON
  architectural peculiarities.

o Removed unused testing code from the driver.

o Removed some module parameters that already default to the proper
  values.

o KConfig cleanup, including testing on x86_64, arm64 and mips.

o Fixed breakage to the driver for previous generation of OCTEON SoCs (in
  the staging directory still).

o Verified bisectability of the patch set.

Carlos Munoz (2):
  dt-bindings: Add Cavium Octeon Common Ethernet Interface.
  netdev: octeon-ethernet: Add Cavium Octeon III support.

David Daney (1):
  MAINTAINERS: Add entry for
    drivers/net/ethernet/cavium/octeon/octeon3-*

 .../devicetree/bindings/net/cavium-bgx.txt         |   61 +
 MAINTAINERS                                        |    6 +
 drivers/net/ethernet/cavium/Kconfig                |   59 +-
 drivers/net/ethernet/cavium/octeon/Makefile        |    7 +
 .../net/ethernet/cavium/octeon/octeon3-bgx-nexus.c |  417 ++++
 .../net/ethernet/cavium/octeon/octeon3-bgx-port.c  | 2003 +++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-core.c  | 2079 ++++++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-fpa.c   |  358 ++++
 drivers/net/ethernet/cavium/octeon/octeon3-pki.c   |  823 ++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-pko.c   | 1688 ++++++++++++++++
 drivers/net/ethernet/cavium/octeon/octeon3-sso.c   |  301 +++
 drivers/net/ethernet/cavium/octeon/octeon3.h       |  430 ++++
 12 files changed, 8222 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/cavium-bgx.txt
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-nexus.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-bgx-port.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-core.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-fpa.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pki.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-pko.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3-sso.c
 create mode 100644 drivers/net/ethernet/cavium/octeon/octeon3.h

-- 
2.14.3
