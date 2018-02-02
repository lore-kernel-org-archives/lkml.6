Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeBBHBU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 02:01:20 -0500
Received: from mail-cys01nam02on0071.outbound.protection.outlook.com ([104.47.37.71]:43744
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751732AbeBBHBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 02:01:06 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
From: George Cherian <george.cherian@cavium.com>
To: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, Jayachandran.Nair@cavium.com,
        Robert.Richter@cavium.com, George Cherian <george.cherian@cavium.com>
Subject: [PATCH] PCI: Add quirk for Cavium Thunder-X2 PCIe erratum #173
Date: Fri,  2 Feb 2018 07:00:46 +0000
Message-Id: <1517554846-16703-1-git-send-email-george.cherian@cavium.com>
X-Mailer: git-send-email 2.1.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: BM1PR01CA0089.INDPRD01.PROD.OUTLOOK.COM (10.174.208.157) To
 CY1PR07MB2332.namprd07.prod.outlook.com (10.166.194.143)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c3d00d7-68f3-49b5-b220-08d56a0ab9a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY1PR07MB2332;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2332;3:wJaYCK4qKL4JHwtFNjMm7HoxkZCTOyUd9JvnrfA7RI3Vk6XF/jqxIR6GpU02MPJFsiDXLwEqZyDgIElPlRD7RvOb9XQFXwnf5Xe0wi8R+5BdBD+3BTvasbMmnF8c7WdXf28Dme8J5uUWrUuUzJPeukrr39XfEHuf6i7hgCW7UwvuXI75Qlzg5DQq9xTPE/n9HwrpxgixafcwhgBG4TRsii7YFSMaSRsxn+pYMkUixbqdsJ20kE59CqmwxIwYi8AN;25:q4ZmxzwvK42CSgVNOfR25gO6YOZkLUQ52StTfJJtLiivn2IFm3TK/36meoZekSJCAxiGhn9lUFDUpmdd5jSMD7IeItgmtHQzw+rhgrFtKiPSqF8PNrlI+8n41ykZ1tq3tlXfDjTpuVr8uommiNCquP/uoayt1Ahe9fdAPUmVl7Fukwya6W9FndoAx3GLglJgp7jN4ejff7nTrftNaVS6Hz52LHH3kq+XF9Pm1id9NdOVrFzHikszyuY9LXt44NFkBkeBfn3UkDz6QyG5ak6DEIir6LmPtXMgkFpqhnMbCH+YXLZOCz/J6TApkrfUf5tHBY35RdYYBGo24g/cx5T6ow==;31:N2CeLV4xjWTFUQUkBO6ANukNDeZ28vidLegSmtU8m/A2/VXXQSHo8XBGOFNnQLp77u5UkGwKdrGY8xCh0xXrWy++AGRdx4R+a0RQ3DwpguwAcC3d2yJdNftk0RqUGB3QKdXgDU6kPtGk+nYlONM+cJHWHHY/Q1Gq4mGhOPjeboarL+YBrmw6XH1mf9VdvGOqiH3yqaOQe44c8H3E1HSUK9RnCm/ceF4QHbsxn0MZIvA=
X-MS-TrafficTypeDiagnostic: CY1PR07MB2332:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2332;20:EWcqDn1Ytqd1n8ZUonbulNVtuC/MUPag0eeTXMcPcyUNBSi7Gm560foZMmtpMj8MPwVBC3DjglDJQqj0N6Lg96+INDKUi2HNGzyRfNzuPaG/0xeNKY+VRgn1DDC8rBcI38vVGmfQVouJCyoPPjXzFuPyssGKeb/yfV6HgQWVBg8icFLyOJPmMOqUv2CtiDjZfnHOqobIsAQh4sPxs3qR/oVZbRKptjL67r/I7M5AMdtD6oIp95VzgCOk5kdp9068DWpPsxkirw3eP2YdpP7OMxEfrdpPweG7povA5eTyugAvX/qOFtiLrEvrm+OkxYA0h1R/lILqNsphTknlzNpTavyEKtFiYeTICZ2ETZnCDE6m1ePoidCQrOKM2jEAL9bcugnPbyP02/x/87QmZg1F/AMas41qqF5CwVgEtq5Y5h5X7yFKAzlJwd2ULWt6BsMkTOk07Hzusrq5g4wf4ig5GQjbiRtu72VhpAyaGgVtpAmDlzzn9vo6HdN+x8qgSpzR;4:ud1P/LvX7ujqkzf0ztwMkVS0Fk3Ii6Ksf93O1Lp8L2j3QIWdhM4oX5N2gHqqNrgI0KJyvoUUTugt0h0FqbtR0TNxvifJgH/b/oLyHqoXFj2iLCrKLzO+2kznj9ssSB/UYSrF2Kc87Tssqfv6zpbWSA2WWo+WjdG/qhOTC3vQ5HLadn1GS5ARRAX4avhgmaAZuZaUvxHHw7M8c9etYk7UgfljktFnD0CrP+UizCd4O2MYdq160CoZcbShEUXNEDpKzRK2yB1V0/HhbvbImizY1w==
X-Microsoft-Antispam-PRVS: <CY1PR07MB2332F4A2F0126EC17A59F0CCF9F90@CY1PR07MB2332.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR07MB2332;BCL:0;PCL:0;RULEID:;SRVR:CY1PR07MB2332;
X-Forefront-PRVS: 05715BE7FD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(39380400002)(39860400002)(366004)(189003)(199004)(69596002)(59450400001)(386003)(7736002)(51416003)(6506007)(2906002)(52116002)(3846002)(6116002)(53416004)(5660300001)(36756003)(26005)(106356001)(105586002)(5009440100003)(186003)(16526019)(4326008)(68736007)(48376002)(6512007)(316002)(8936002)(66066001)(81156014)(8676002)(16586007)(50466002)(86362001)(575784001)(25786009)(6666003)(53936002)(81166006)(6486002)(305945005)(45080400002)(107886003)(72206003)(50226002)(47776003)(97736004)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR07MB2332;H:ubuntu.caveonetworks.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR07MB2332;23:DmnFXRLWjFwoirhV0KAYzQKvjeV/a+qhL4tm4eK8A?=
 =?us-ascii?Q?bjboZFfpSs+zshaeFi5PFejKb7Q1LpZN3BN+68z8k6AvTqpO80a98VJa3mgv?=
 =?us-ascii?Q?t4pC431YqVyjNgTEez8b3Qynq/0lNEh3G9IQhYzlCCVDrj1WMU8QFbUx0zAZ?=
 =?us-ascii?Q?vVsaOGrE4kUvBA5bhAQuzrS7efYcilTkgZk7AahjiwWx8IZ/iqcMw7DJQ8MK?=
 =?us-ascii?Q?gZe1wu13XlwZfKHNex1ALEbfP1HXP+06sBlzUwQ/ceO0GW0HPKegRXxOog5U?=
 =?us-ascii?Q?Qoul2tFhCjKeK6LaGm2uoz/6G9Im4X2fIudo4iDqmq5VA8tecKWfkYmoNHzc?=
 =?us-ascii?Q?uSnHLQJFxqtZJclGUQ5XP/IxGYXYN1bYjcd8irzvZTh61O9oYtZ46aXUSp4U?=
 =?us-ascii?Q?CVlwR40YeIjR1YRhtebavfBB3jwsNKm/Sq5t63NChPt7uIaNCKtTET6S3l5Y?=
 =?us-ascii?Q?r1W2+W1hZsnImRGczDg4HW0/YG5Eh9z1gYtTCNQ0wDMLAon2WBNXKkiBlr/l?=
 =?us-ascii?Q?KQlZgkvDBHyj+q7/NZlx20oedPmFYLcrdbQEDJNkwPDyp63dNRffRAxXN53n?=
 =?us-ascii?Q?RCnyI2/6Ke+Dz8RNA0Nv7xxuRTyKtDp5G20ISX+geMcNoVgMLV6EI41adE8j?=
 =?us-ascii?Q?8gy9b8fFbCovu9FbRdqV/mq85wpLHXxLNLMXnkLc0IViI4oe0lDLfRUw1Mzg?=
 =?us-ascii?Q?GmZ9r16YLhd+udZi9r/y/6M1ZoipMWrLMrnku//ApAPNQR8sYUQIT2Z2yM60?=
 =?us-ascii?Q?mcJ2jTqSB7BW1ukC/TP+B67SnBUsiRpLSrMeyHOUP1rnIxLtJxx/bIAESgFw?=
 =?us-ascii?Q?uQuWTrDmmRDBfUaMO9HlZxX/8aztqmMvR4mHFK3DrKRP0ZXjQ7rk/uHMDQnx?=
 =?us-ascii?Q?NTWo/n6yWeI0qiPHtPBsAJks8AOUKgq/sdfe0aUiPkmreEYas+CcUEB1hHkJ?=
 =?us-ascii?Q?VuIpWZ5A3yi5SpbCPHDo9cvE+F66ogkw+FGiHyNFjrHGMZA2I+K7NRfB/Qv+?=
 =?us-ascii?Q?uJB+E7rWDvpxuR+b1YQFFNjO460rpxaiU4D2umTBZNngDb/TpBtbtP/wH8sw?=
 =?us-ascii?Q?BL+ZyuBnEQjgy2dKHy6ehvHuPkxnh5ixWBZYBKOj7dSBFHhn8qKXVeirI/Yi?=
 =?us-ascii?Q?2nPFWKcUX8XenghdBW5L53RprV3v7MpSTPmUJDKcFq8jMv+skyUeuaKQBA0R?=
 =?us-ascii?Q?EkKxW2vEcQlap9OMajSvVVYHmWcVvDnu7ixhfTynvbFI9WM5Q0OLn9tlA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR07MB2332;6:YAniLg5eEVfqQrdIIEq0rHrEMoeteP53RYuuqV2rXYW0yl+zIMQA0fOFVbTqwYEy9Q9NTYRKs7rKkN4oY/QdqeC5t6QJsehmHaLtB5tX8/UBk1aaOQBQtVk3Qy3R9TuaJrveIEufPEG1sfwkHl64IMp2+8KFbe86DSVW+/fZMC90Knp7SKB2ugsYRuIo0NUEFOp2lHcEwraSOnWz0FZt12OBN8nEkpcfjkQNAQszWDVMapPPVo56xf2Y750D7qy9Ux00NjxZsAKcSBXF/C9htcw/HpOpxEVgPS8v7lRO/ugtmVepBJg6h2rdeNKtjnb0ncPqlJYsVWC0WG/fSffRzDss1FP1OAXjmX1qa7Qwus4=;5:1poDwAjEs3CrN+OgFaqKxa5O3tcZagkgT5aBOKMzc4lhaqvzKOFui9rB1ld5CR6tTIto78Fplce3AbcexlyeGxA8cBBtnYai9wqQv66AkBkS19VUrLNcfcpWM6NsdAAFe9b4IlvI4IdN68he15hVG9iYS8pWlW5BzBAHV70vJzo=;24:KJJIbTo71CFqpTMxutRqtHzMDi0s5jGgnjOOcmVtL+XJCs7Qc4K4yMnUCgPgfPpYiawKWpbtI+irpOxfzosWlJVQPWi8U6WbifNIDosevFs=;7:o+oOzgx6dI0dqxums0++9U1DgW3LXQAZ4hrHj9+cCitgp1FYrMR++lZwG55kkqf7J7482novlbJ5LyWJIaOo1mmCKVwyMIfy3VM+WXDKSUmHfwMXBdAq2QsOYyz/Cpglrjv+itLmUhk762Ob754hUodTax/qfLcAaNyeUDn7Lmf5DK1EVXoJn/swcv7TmYxgwuNS5/ZVqmg53qHd7/AX7MPYo2S5iI8+B0ekwFSh72Mpi/hEcx/csx5v0vgJ+FWt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cavium.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2018 07:01:01.6972 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3d00d7-68f3-49b5-b220-08d56a0ab9a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR07MB2332
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PCIe Controller on Cavium ThunderX2 processors does not
respond to downstream CFG/ECFG cycles when root port is
in power management D3-hot state.

In our tests the above mentioned errata causes the following crash when
the downstream endpoint config space is accessed, while root port is in
D3 state.

[   12.775202] Unhandled fault: synchronous external abort (0x96000610) at 0x0000000000000000
[   12.783453] Internal error: : 96000610 [#1] SMP
[   12.787971] Modules linked in: aes_neon_blk ablk_helper cryptd
[   12.793799] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 4.8.0-32-generic #34
[   12.800659] Hardware name: Cavium Inc. Unknown/Unknown, BIOS 1.0 01/01/2018
[   12.807607] task: ffff808f346b8d80 task.stack: ffff808f346b4000
[   12.813518] PC is at pci_generic_config_read+0x5c/0xf0
[   12.818643] LR is at pci_generic_config_read+0x48/0xf0
[   12.823767] pc : [<ffff000008506f34>] lr : [<ffff000008506f20>] pstate: 204000c9
[   12.831148] sp : ffff808f346b7bf0
[   12.834449] x29: ffff808f346b7bf0 x28: ffff000008e2b848
[   12.839750] x27: ffff000008dc3070 x26: ffff000008d516c0
[   12.845050] x25: 0000000000000040 x24: ffff00000937a480
[   12.850351] x23: 000000000000006c x22: 0000000000000000
[   12.855651] x21: ffff808f346b7c84 x20: 0000000000000004
[   12.860951] x19: ffff808f31076000 x18: 0000000000000000
[   12.866251] x17: 000000001b3613e6 x16: 000000007f330457
[   12.871551] x15: 0000000067268ad7 x14: 000000005c6254ac
[   12.876851] x13: 00000000f1e100cb x12: 0000000000000030
[   12.882151] x11: 0101010101010101 x10: 7f7f7f7f7f7f7f7f
[   12.887452] x9 : ff656d6e626d686f x8 : 7f7f7f7f7f7f7f7f
[   12.892752] x7 : ffff808f310da108 x6 : 0000000000000000
[   12.898052] x5 : 0000000000000003 x4 : ffff808f3107a800
[   12.903352] x3 : 000000000030006c x2 : 0000000000000014
[   12.908652] x1 : ffff000020000000 x0 : ffff00002030006c
[   12.913952]
[   12.915431] Process swapper/0 (pid: 1, stack limit = 0xffff808f346b4020)
[   12.922118] Stack: (0xffff808f346b7bf0 to 0xffff808f346b8000)
[   12.927850] 7be0:                                   ffff808f346b7c30 ffff000008506e2c
[   12.935665] 7c00: ffff000009185000 000000000000006c ffff808f31076000 ffff808f346b7d14
[   12.943481] 7c20: 0000000000000000 ffff000008309488 ffff808f346b7c90 ffff0000085089f4
[   12.951296] 7c40: 0000000000000004 ffff808f310d4000 0000000000000000 ffff808f346b7d14
[   12.959111] 7c60: 0000000000000068 ffff000008dc3078 ffff000008d604c8 ffff0000085089d8
[   12.966927] 7c80: 0000000000000004 000000000004080b ffff808f346b7cd0 ffff000008513d28
[   12.974742] 7ca0: ffff000009185000 00000000ffffffe7 0000000000000001 ffff808f310d4000
[   12.982557] 7cc0: ffff0000092ae000 ffff808f310d4000 ffff808f346b7d20 ffff0000085142d4
[   12.990372] 7ce0: ffff808f310d4000 ffff808f310d4000 ffff000009214000 ffff808f310d40b0
[   12.998188] 7d00: ffff0000092ae000 ffff808f310d40b0 00000000092ae000 000000000004080b
[   13.006003] 7d20: ffff808f346b7d40 ffff000008518754 0000000000000000 ffff808f310d4000
[   13.013818] 7d40: ffff808f346b7d80 ffff000008d9a974 0000000000000000 ffff808f310d4000
[   13.021634] 7d60: ffff000008d9a93c 0000000000000000 ffff0000092ae000 000000000004080b
[   13.029449] 7d80: ffff808f346b7da0 ffff000008083b4c ffff000009185000 ffff808f346b4000
[   13.037264] 7da0: ffff808f346b7e30 ffff000008d60dfc 00000000000000f5 ffff000009185000
[   13.045079] 7dc0: ffff0000092ae000 0000000000000007 ffff0000092ae000 ffff000008dc3078
[   13.052895] 7de0: ffff000008d604c8 ffff000008d51600 ffff000008dc3070 ffff000008e2b720
[   13.060710] 7e00: ffff0000091a68d8 ffff000008c09678 0000000000000000 0000000700000007
[   13.068526] 7e20: 0000000000000000 000000000004080b ffff808f346b7ea0 ffff000008980d90
[   13.076342] 7e40: ffff000008980d78 0000000000000000 0000000000000000 0000000000000000
[   13.084157] 7e60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.091972] 7e80: 0000000000000000 0000000000000000 0000000000000000 000000000004080b
[   13.099788] 7ea0: 0000000000000000 ffff000008083690 ffff000008980d78 0000000000000000
[   13.107603] 7ec0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.115418] 7ee0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.123233] 7f00: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.131048] 7f20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.138864] 7f40: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.146679] 7f60: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.154494] 7f80: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.162309] 7fa0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.170125] 7fc0: 0000000000000000 0000000000000005 0000000000000000 0000000000000000
[   13.177940] 7fe0: 0000000000000000 0000000000000000 0000000000000000 0000000000000000
[   13.185755] Call trace:
[   13.188190] Exception stack(0xffff808f346b7a00 to 0xffff808f346b7b30)
[   13.194616] 7a00: ffff808f31076000 0001000000000000 ffff808f346b7bf0 ffff000008506f34
[   13.202432] 7a20: 00000000204000c9 0000000000000003 ffff000009660000 0000000000000007
[   13.210247] 7a40: ffff000000000000 0000000000000000 ffff0000092c2d3b 414d48203a6d7665
[   13.218062] 7a60: 3a73727474612043 0000000000000024 0000000005f5e0ff 0000000000000006
[   13.225878] 7a80: 0000000000000007 ffff0000092c2d25 ffff808f346b7aa0 ffff00000849bc1c
[   13.233693] 7aa0: ffff808f346b7b20 ffff00000849c100 0000000000000000 000000000004080b
[   13.241508] 7ac0: ffff00002030006c ffff000020000000 0000000000000014 000000000030006c
[   13.249323] 7ae0: ffff808f3107a800 0000000000000003 0000000000000000 ffff808f310da108
[   13.257139] 7b00: 7f7f7f7f7f7f7f7f ff656d6e626d686f 7f7f7f7f7f7f7f7f 0101010101010101
[   13.264953] 7b20: 0000000000000030 00000000f1e100cb
[   13.269819] [<ffff000008506f34>] pci_generic_config_read+0x5c/0xf0
[   13.275987] [<ffff000008506e2c>] pci_bus_read_config_dword+0xb4/0xd8
[   13.282328] [<ffff0000085089f4>] pcie_capability_read_dword+0x64/0xb8
[   13.288757] [<ffff000008513d28>] __pci_dev_reset+0x90/0x328
[   13.294317] [<ffff0000085142d4>] pci_probe_reset_function+0x24/0x30
[   13.300571] [<ffff000008518754>] pci_create_sysfs_dev_files+0x18c/0x2a0
[   13.307173] [<ffff000008d9a974>] pci_sysfs_init+0x38/0x60
[   13.312560] [<ffff000008083b4c>] do_one_initcall+0x5c/0x170
[   13.318122] [<ffff000008d60dfc>] kernel_init_freeable+0x1c0/0x27c
[   13.324205] [<ffff000008980d90>] kernel_init+0x18/0x110
[   13.329416] [<ffff000008083690>] ret_from_fork+0x10/0x40
[   13.334716] Code: 7100069f 540003c0 71000a9f 54000240 (b9400001)
[   13.340805] ---[ end trace fc992038acd29ec3 ]---

Fix this by adding a quirk that prevents the root port from 
entering D3 state. This is seen on both Ax/Bx variants of the processor.

Signed-off-by: George Cherian <george.cherian@cavium.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 10684b1..2eb08a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1154,6 +1154,18 @@ static void quirk_ide_samemode(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801CA_10, quirk_ide_samemode);
 
 /*
+ * Cavium's Thunder-X2 Processors root port doesnot handle cfg/ecfg access to
+ * downstream properly if root port is put into D3
+ */
+
+static void quirk_no_rootport_d3(struct pci_dev *pdev)
+{
+	pdev->dev_flags |= PCI_DEV_FLAGS_NO_D3;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_BROADCOM, 0x9084, quirk_no_rootport_d3);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_CAVIUM, 0xaf84, quirk_no_rootport_d3);
+
+/*
  * Some ATA devices break if put into D3
  */
 
-- 
2.1.4
