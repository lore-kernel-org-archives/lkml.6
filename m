Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeA3VlY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 16:41:24 -0500
Received: from mail-cys01nam02on0044.outbound.protection.outlook.com ([104.47.37.44]:15680
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753235AbeA3VlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 16:41:17 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=andrew.cooks@opengear.com;
From: Andrew Cooks <andrew.cooks@opengear.com>
To: Jean Delvare <jdelvare@suse.com>, Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c@vger.kernel.org (open list:I2C/SMBUS CONTROLLER DRIVERS FOR
        PC),
        linux-kernel@vger.kernel.org (open list)
Cc: Andrew Cooks <andrew.cooks@opengear.com>
Subject: [PATCH v4 0/3] Enable ACPI-defined peripherals on i2c-piix4 SMBus
Date: Wed, 31 Jan 2018 07:40:27 +1000
Message-Id: <cover.1517285239.git.andrew.cooks@opengear.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [59.167.150.161]
X-ClientProxiedBy: ME1PR01CA0134.ausprd01.prod.outlook.com (10.171.9.147) To
 BLUPR15MB0018.namprd15.prod.outlook.com (10.161.124.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8f8aea5-07ee-4a21-b102-08d5682a2b97
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BLUPR15MB0018;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;3:oiNp4fCaLo/ImiB2J49itZtfRBwt698afgxpQ1OQaZMa8S2y3FMbITKnSDV2AeN4+JbA3z0jaeDAru5zUCCXfS/QBqFkLIsXjuoVvQhNlg3SNvJ3zyP8vLtqbrCqAEHYysvWL4VCv3YcgUGbWUTGxl1pFnmX7osQ3WaoB37MS8VlCfRBQZwKYszDxoJAa0O+TwTfBvBT+5Qcu5njJj0OnmWeOypaoRSV+lCqiKvan+1MPVVvAYEmedHzyU+bpyEz;25:bNk1cCcpiBxtZn6X+JqAdCNSwvn/t2OXX4FjsJDFwLXkwNLXQySS6gxbTgujkvr6sZmxdM7ryn3R0i+Fs5MhFtBseyWT9VRQJBhA570g5CE833ff7oL0ckD4Qv/+qk/5SV6XYVmAJFhlOlI/tmHH3br4jZA8xS/72gB/TIuWW0PFHWSrs5ucc/JhG/jkamUtkiYIiTwMOdHADFtznX2tyPHMShMOFV37T0R64TSTbw0AsEYKJtQ7+ijTibUYW52rlx2a92J+dApVQYrpU7tvM+rKzD9+GfdLbD60onnCl65/lsJ7ioQGGpDlvc8sZInf5bBpofP7YUYGhqqa5pjoYQ==;31:D/HsGHnJTmIngyPmVkR1rfd1z4I0FhijsCSE/t2f9lVv4nctOd2m+60p5LIrPuvOpJH50W/ijWyass9zCiLBO4Mhmd6kWmbDkHKWt6CMoPxN0cfUiPIQDaJHl0JtDHW2qpnlKampbxQp8p9MCOHE1oeS1DsMIIlHkCK5xqe4GjJ+XtmQkwQKLiubOe4u+SEZ+AMPshC2a/PdzM/oy5XQEbwVw4UYDQpZYz3hx4m//Is=
X-MS-TrafficTypeDiagnostic: BLUPR15MB0018:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;20:0paWj4Go9tV/ofhK6sSg+U68p88fkHayKG+9FylBkXnc4aaodnqHUilxOHZkmQcMbZX8WW4xcRaSzFNn/oxCwMOcOkawlYhcwK6RmZwWvMo/tktKq3NbUmXwgQWUZKb7L4pgqQ3CQ1H4SshbCpd8PtNCfCOcUChzUB38QH9JMyE=;4:H7tTbDJy+TVHbOEVgIJPRy00o8qXp6OL4kLF/dgQypbxkDDFtv0OsRll2sTTq5rXzR/lJglmpUSkSz7XUSra99oUxMw/o0/5NOku5hoZBVdRIlpLfjYwwLmUNO1GcY8bQSVmyjAzOcPQqXTAKKeRoqPLLpFU1jNzDjFyfu6VYkUOUY3feMiVfGT0Wi5Ji67YRIvxmVkC6pzssY54tfKF69OzVe46sX15CDZhoOE5gytJvfadrtnRtkmWXnO1rG+3Cg07fERIo6t7gMoZMOJplg==
X-Microsoft-Antispam-PRVS: <BLUPR15MB00189244EF29FA1CEAA7A0B4EEE40@BLUPR15MB0018.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(944501161)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BLUPR15MB0018;BCL:0;PCL:0;RULEID:;SRVR:BLUPR15MB0018;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39380400002)(39840400004)(376002)(396003)(346002)(189003)(199004)(50466002)(107886003)(97736004)(48376002)(2906002)(16526019)(8936002)(81156014)(8676002)(47776003)(3846002)(86362001)(316002)(50226002)(16586007)(81166006)(53936002)(66066001)(110136005)(105586002)(5890100001)(6116002)(186003)(26005)(36756003)(68736007)(7736002)(4326008)(106356001)(305945005)(6666003)(6486002)(386003)(25786009)(5660300001)(59450400001)(51416003)(52116002)(7696005)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR15MB0018;H:andrewc.bne.opengear.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR15MB0018;23:utsq252tpAa876VfW15Sm8qRCyvrxNw6InNN2WaPS?=
 =?us-ascii?Q?VBYHgFKzSylrWpbK3iYO/10l+i+htH3R9yn8HKm0fsSIVjgDb3nkMwbEMchO?=
 =?us-ascii?Q?eGszMhivPz1ImH9Df36lMvzyJl3xo4RsBXzQpkWRiTAiPMuX/HZXDa/lL7zV?=
 =?us-ascii?Q?SmPsE+L0Ph4R7tgs9fqOLAbWSxg6C8Z9ZilcMiElxTPZ0ezVTmRdI1Ntobdd?=
 =?us-ascii?Q?6nomLzL6PMbzhaaeBiklyKKjAdwxrRdCspYLFCnqcAb/lxurwloRi6R0dCfr?=
 =?us-ascii?Q?RrO4cKAlFwnaKZ6Lvf7wcr1PJOu4+x/34lJSQ2UOaSAByfzUPhLeZcU6TwRZ?=
 =?us-ascii?Q?Wk4LyDQ+Remw/uc9etlQFyIqtAA4vD8ikP4cLAAfPe45eNspKdhUgcSzeXoI?=
 =?us-ascii?Q?GAu2dU+ujR12iaUAAcpz/hmPgadVFMo27wjJ6wLzQzGMx2xTx6tShnZXSmTm?=
 =?us-ascii?Q?bZ2fP3IDPBmY1wQUQgYpKwLnYKW7nq2xBByYlcBc0NADf/XT2uecIJ7D/Hms?=
 =?us-ascii?Q?z1jb+iH+LubNx4ubePDXBT5fV9z3NXm4VgLfSuXo1BhlKh210X0zCo/X4rbs?=
 =?us-ascii?Q?UCjqqa76yynYPFMRAYgLVFT+H3mNStYo2e9vG+UDbMHD7RPKtCpdmsrkRkNo?=
 =?us-ascii?Q?Nld4Kz9IcjGxjmc8ub3CQmkAC7cMqhWG4TT/TBrXkKxGN338lvA65C3Qx6NJ?=
 =?us-ascii?Q?klFZyBA/OWld1TOKTqvfCgLsXfOAC4h+Ggmkk5jZPtHzPEOCJC3UJWcMFnJf?=
 =?us-ascii?Q?gQWeg9Z9PwSWOZKDQG0hyzZrRksX2EA+bsXjKbL8uaFlpEaCtiJkIro9XO06?=
 =?us-ascii?Q?G0B04ZK/+i9Rj1MaqEGSE4atL6n21q0apcLC7TjFGxRjtuSnpoM1HfubrtkM?=
 =?us-ascii?Q?/CXYYSAr8aqR4nmsPGgnXfwxrf3jwSBDaZ04ZOBPSVsiSlO0HQ/gX4/Vdz+T?=
 =?us-ascii?Q?v9oIJIZemfdj8Mz8iUdz8LnIa+a9NJRugO1IygMWtPpYrfAoEkjTWPKHX8hR?=
 =?us-ascii?Q?T2B+ZnRMNifEwVBNviIle4h+ao9imFmz1qemk3eRlKGQD3q+yFg/Ce1BV6Wp?=
 =?us-ascii?Q?GgFa+UWFz+VRu4MFDx642gfVzpMuHEzEXPbtTtSGRJ5TnZGckmHyXtWBctL/?=
 =?us-ascii?Q?ctCMVcb31I=3D?=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR15MB0018;6:yfqZWAobSEce4kBSVvyuAedPjHWRXdRzAELu/s/CalGlteu7HzqIeQ9lkfDQBKuoqUzr0YUO3rt4wnsFzwBfAN2x0xX7P2tKt4HSjSL0UQ7mz8BsBfPUoGoWrx9xwXOW3W+TkSAvdz7ekYmJIW3PiSi3VQhvh3j6fCB+i1v3iHGIdhwxuXPu1UgA3XwVdTQUODgq/xv6QEwM/zggA4BPDi5LMry9LnlvUJ9fVJfydueUtpeW9bDmb75xVvWSfU9YaFM+PMIcgOa3E7dIfACNyBlu+dmx8aZKzwGU70AhUWPE9kcAKXCpoIPv6V+/lWPFRXvF9NzV1pMXmvNVlvhqFW4YZOKbVlx8TP8Hl5WUkLk=;5:Eq+rWYwvvIpOoiTwB8gQV6cdhfw+n0SFZUTGsycT7F75ruEYfmguXRTStZ3AAuARFu3uwZFI01yIf+j3t35EYDBEL2BhPEQfQOuXMuwA+QvKVj0G/saEVH5kl/wrqkq9BPuKlEelB9+avb6ZvkMdJuXiBx58lWzSU8gMs3BguC4=;24:HhYqHVmASVuf/ud7Sj9iajsyY4a38TUuBFx3JSgrFxWCLBF144JPR2tQyACYCqSBG0fesVq3YAKBh00MZQ2CvxBM14gjYXNSKCUyeRs+dck=;7:w2Mj1rE9FEYLyvFUZC/Lk3QOuoV9Z/JSGqD2FV82KG2IDKILHBSuSKVtPQOOygpNm8dOkMv0XP4ssxhL+psw/81T+QGoBLfGi9egAbgI4cIg/Sb7hnUS8rwfzpMhPM3AkGqKAc34NGPbVl/TWFJx2tKr/rPOrKdgU3oeoASm5zr9Sr8hXFMLUNfbW79Me0JaTVbm8PULu3AUPXwyxkX98Ncm5dZOYIRcT/JCsPBHx0ni1r/y/GRjfUcU4CuLE6DE
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: opengear.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 21:41:05.0976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f8aea5-07ee-4a21-b102-08d5682a2b97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a6251c26-d21f-4164-a225-1f4eaebf5f9a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR15MB0018
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches fix a couple of issues with the i2c-piix4 driver on
AMD Family 16h Model 30h SoCs and add ACPI-based enumeration to the
i2c-piix4 driver.

Some I2C peripherals, eg. PCA953x IO expander, are not discovered by the
probe or detect mechanisms when attached to an SMBus controller that uses
the i2c-piix4 SMBus driver.

ACPI provides a mechanism to define these peripherals and the controller
port that they're attached to.

Changes:
v4:
  remove unnecessary SB800_MAIN_PORTS constant
  reduce piix4_remove change
v3:
  take chip revision into account when determining port selection register
v2:
  count the adapters, instead of misusing port numbers

Andrew Cooks (3):
  i2c: piix4: Fix port selection for AMD Family 16h Model 30h
  i2c: piix4: fix probing of reserved ports on AMD
  i2c: piix4: add ACPI support

 drivers/i2c/busses/i2c-piix4.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

-- 
2.7.4
