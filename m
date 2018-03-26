Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751907AbeCZIGS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:06:18 -0400
Received: from mail-bl2nam02on0080.outbound.protection.outlook.com ([104.47.38.80]:49600
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751050AbeCZIGP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:06:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Suravee.Suthikulpanit@amd.com;
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: linux-kernel@vger.kernel.org, x86@kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, bp@suse.de,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] x86/CPU/AMD: Add support for Extended Topology Enumeration
Date: Mon, 26 Mar 2018 03:05:57 -0500
Message-Id: <1522051559-23415-1-git-send-email-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: DM3PR12CA0080.namprd12.prod.outlook.com (10.161.151.152) To
 BY2PR12MB0130.namprd12.prod.outlook.com (10.162.82.156)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: af912fbc-4808-439b-d220-08d592f06fca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR12MB0130;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;3:CD2D9wgWngbVM3Oyks3YC5BIFSUOoTOYjXiISA20qcrgDyCv/bm63Bnoq8Y4WoUAC3dLAemrVtZ/09k/LFTlB89j31W+Q185y7uPmZELwFxMpE9XR+NnsMyYyIUCYn7TZoO+zVZTvFBwaMDwXcQCBMv7dHI/wq6WjccPOK4MQkZInkm3DU3ExmLZy49Rjvx39xlTEg8rgwLU3MRCAUEIhJV44oQYv6pbqlVfkRjo7ieJ5yu5N4Munhrs9tjMCA8J;25:ZhjUGCAHRlEwhWwASSrDpggMLhPziE6qK50WORXJu1XDYgJ3QxC9DcJuvdZGijnNof3FSgI4Z83M96VNILmPAukr0+MJEPWGVvSyYs5BlFaXfzNGBPk7XYhtJgHivemtSB/ZHL4qd4wOCHLaF4h9aa+GKsbCcwZ6NpzoDzfX6u/h63tEkvMDnI2Yx17FhGH/y9my5/sZEn6XFiI8Jv4fDlocASwDzv5v74IYSpj+MsvRsK7tvXt1/DUqczEBQArNv4+C7qYTcXbFT5QlfABYHeHKm0YOo3EdINjAmPJJdjVyr2NVW5kwjEZfrMPYFXEfbwujHP0WAK2pdR4z5kENAg==;31:4YfR24/G+a0md0nUvGQ92lWvxpAIfY+z8wIWFaAOzz7O76t2Ka6lBC6eueK3XtXa/KJD9/Wt4JJW2B0TK9fbo4bSRtaGFshO0Uyr+VtCVj8RPkdPqjrTXq47rvjuntm/SsBxK+hQ7rGn4tIDv8HHhLXbb3pFd81RGt6QBie7mUZ8H53ty8kosEZyEeS8YNPjwrme1fz3FC8YvomZ9E5/tSivldma6bHcTImo0fz53Ck=
X-MS-TrafficTypeDiagnostic: BY2PR12MB0130:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;20:Nk2x1/lF/JhV8zLdW9oiOGqpM230yXJzwsGK9FuglRTT1MB8ul8S/mxtCDWScksH16P4UEPlF/gdx7x08nj6WBRVz8rtoeauti0C0Wm1uQx+QzeAarDHSbvHsraxvhRABSrFuNHdQN9iO20qhy50PaH7jyWrNwBRTm5eM03BJMkehGVNMvEhSOEDC2lVv9Y2EQg08yl67XG5ePWKWN8xSOwwdE6T7932eBeBnciXrlaPX2cTP4OJYsu18OX+QyBh7cEn6ONLKDUfvI0uhu6rQweJc8pRmje+yvuAogJcONl69TyeCGdtLue6u0VSRdg1lxpdLWhpFYbbK0N0gzrDzIXRdyI05ddrM6Bh4N6fEVe7w5IIWm7uaXOmClk0ElKpTgEybCtRmSHTN4u8pZRKsnWDa3xaLBYpHBV1WX7DXmCQFBsLMZKoM+5fKrqcbNLuEDHIKU01Onso4vCTZF+BXOozmn2B4W5bgxxq86JaBUcOgnYdbIvL4mtvqHFG/Jhi;4:S8WwZw9f++3nS/LdMkvAlsTwyTQujAP0KLuW4IzhQLiT+Bvqwn7EwEqzr+yn0ylSWp4JVBNtJgqUe4arTmLZ+ib7N16Ai1BsCPJpvaPhKSDf52+/Hqs3souSW6ltG9jLT4UbPgqiP2BlpQ5ADx80q6/GPcEmp/ISicQntMWozzaotQgOzVHnYM2knNFW0aT/PMSULbblqWjqZ1QUi7jFuLhb9V0XTt66sqns+6O+t1CJ5Uyn6lHLNacsiEbtTsQL64nuqHhWQ5K2LVErxDLsKg==
X-Microsoft-Antispam-PRVS: <BY2PR12MB01309FF069EDA3C19861BD05F3AD0@BY2PR12MB0130.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BY2PR12MB0130;BCL:0;PCL:0;RULEID:;SRVR:BY2PR12MB0130;
X-Forefront-PRVS: 06237E4555
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(16526019)(26005)(105586002)(53936002)(97736004)(86362001)(575784001)(7736002)(305945005)(3846002)(16586007)(8676002)(478600001)(6116002)(316002)(81166006)(956004)(2616005)(186003)(53416004)(50226002)(106356001)(8936002)(81156014)(36756003)(2906002)(5660300001)(50466002)(6666003)(52116002)(51416003)(72206003)(7696005)(6486002)(48376002)(4326008)(386003)(25786009)(47776003)(59450400001)(68736007)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR12MB0130;H:ssuthiku-ubuntu-b2.amd.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR12MB0130;23:NUPPCSdLFpFYt6UCe5xrlsEwVq109DB/8iej480gC?=
 =?us-ascii?Q?J2v25J3IEt/iQSlq8aZ7+KHjurgYgj/YGE7fitfC1+ktGurh21Xque6Xp4jz?=
 =?us-ascii?Q?njk5LGLnvP5tAwdFPXJpcjOHnptbXjdXpL16bq+89v4eivaXN+uFJD99Xg5w?=
 =?us-ascii?Q?nt7uBMHMkHaPtkyl82NrB1Xpdtq23su+UARUoqqOOHZLAeo4q3CAvru1gv+S?=
 =?us-ascii?Q?RkkrBrGXTK2emulyn8spsLOC5QIMXPtKOJZe7ZrBOET/zx30eKql24o4pSii?=
 =?us-ascii?Q?JuwzarGgLElg+p/QNr6rAej4mhGfz/jIRz2KNmgsVlGcFuWrEkSsNjc8LJ5r?=
 =?us-ascii?Q?V5chg2RaQ1qLO2+X+HvP59YkJnZ9DDMwVW4ZZHom3jBPfkMVpGX59c+t3UAz?=
 =?us-ascii?Q?aUsYOKgGL9Q74YUEY1XaLywz3omnhJH7RdRlntr0ye60bT9Vzr/BLuf33LfJ?=
 =?us-ascii?Q?pGYJd9Ax3p/Y6Zf9J61+gERQhdjQWAzMZSGwcePYGvGj8OTvzN6Sh5zp1Yjq?=
 =?us-ascii?Q?zA2eJ3OKl57EtN5Qt9Cv8YsZy44cPVLalEP2Vi21qVb7Jsx5DdCTP1kZdqLR?=
 =?us-ascii?Q?RmOEkVnmmSuLS7MVJn/ZkjXGdVYjEZ0Mn8TGVynpxPJi97yLOwC8Q/lFH6IL?=
 =?us-ascii?Q?ib/ixYKf2uTIt2YkgzxCaz2mlwoytW6eAPmkDWhFVD4xMSnmjaoYz+rgV6br?=
 =?us-ascii?Q?R0qMioF4XbdCf430fXdSzaf3neFV8Qktmlk/euP4ov3PMj9chgpcifHlMXTX?=
 =?us-ascii?Q?xfVgU/DeOIEVMdjOpmlZ43jOlNBVCocpghADKOT4zsExl0ZQZxHvli+LjYzS?=
 =?us-ascii?Q?/FL/rKMN+89vDymGDyJwW1/UpDZvr3gdzzibKfYVu7y0ev7TSIz0AFAxLfG2?=
 =?us-ascii?Q?guvcInXhBgffLIeE+aP9c7avkSJBB5esiis3MTGpZSl/QCvCa0k+IUVUciub?=
 =?us-ascii?Q?O5Nk1QNnwYAnIDFOsq0oenoHuh1plLHHh8RLEQZj3s/OOstAPgpgxnMIv4cj?=
 =?us-ascii?Q?U4Ux8d8rd87orGZSeSZD0JcsHWDap8bkzCVy4UiJf7L0yNL98oUSBEkkz8aX?=
 =?us-ascii?Q?RWO8SWWhkRroFPO4govqmj/JmnvGVD6Sj0jSIn+98m2MrUiJ4pInYmpfErRt?=
 =?us-ascii?Q?r6hDHghR+0OBGXxL8mEz+d+0niouySW?=
X-Microsoft-Antispam-Message-Info: oAiYB40WgfN83Y7khEqXKRXH6GtE5YUqp3xP9o3h/xoeKu0WkRXszc23xvIU79IIEWGljFQ6akrcyEoOLJ6ExgJBKnJbflJWODeXxf/6Il0ya4WVEKy+EAGQ4grb/rDoFS0i2hW3xUx9T4LjFoEAHlhWhkTGJz5PEOh3W/TDZNWHGrT1YU1JIVRSXfIHG6Ep
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;6:FdFSMcEWrCufXmh63HEN7p7t8QVZEDlJ3Zc3EwIQmOE+phtnGdLRxpemKNxqObukgghlFz2u3YLilGAXUTLQzmganBRtwUY5bnPGBkeKoskY0Lp4kfmYR9Th+7HQn6G9pQEcUDyivnZ5p9BQvKgn1edgi5GmKHhFe55GpTangyXk64+N6+mhVv5/yYsFOQVta7eJCVAjy7Ci0SOP4wpAdHowGSevHb9+NcwiOeT6rnSqrUbieFuFNO7XxYl/3vo7bqPyPKn/fRHbV6qbfXiKNosTk/0kfMUDkerCIiWUjfD1xfhf1rQtDaTD+SavyYY7s4h4y5X9sKAeuK5BEUuvhnCBega/FDFEG8/SOrVNK8oX1xt8/Du7b22mq2ll7RaO3ocPfHKtphntidacMP48QjMApvGCIBu3G2R6ivMG/mvTePlFFnqxt1ThLnDokGVO6rZpJPVpe/a//oDs6hsCRQ==;5:qCBV5kQ5QHRgLRVWNEDzt0vASBNF1IfpicMk89rED/+vK8Htnp2WIwdzxR9dUHCDfNL41hSeXxxYKYWAKmR4shzV1dohkGMb3X+Vo7I5M3lJnjmA8Wkfvu1W65yBA6k9VG2PTN1IZfDdiZ52aQzb8YtzgFIL9mHa4fvHSUPZ4EE=;24:HYXnzcIDgLmmLgQ+GGf8icZZ1hoVH0KF5wj6zHFsfxMR3tSgpHa2aWrpcSpiuEf2fNhKHOjmOzTGjBLQ9KQCa7ah3FsQx6lHX5k0hHqGouM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR12MB0130;7:L7YgJoFo2qKFNrUU6xf2xFPqM9xPNYnBBfWZ85nNcjXl/Of6hhIqYGu/6ecGlCQjDyqhxQlumCMWToSLGYVxrSdkUISCQPYb0f149ypnS8SeI9uNAzYxvfZx1a0t41okdughBPFs3OswnVQQ0GeEkpbJKaXWkd+wrvX/DyEF1Q/kr4FYRhZxl7vo+bL4/OrBWNPJpTKILNNbLvZXjxfZIh4Nqm8kO2TXrZOWCaDctcR1rfdcwG7jJEeg76TGJ2D5;20:xF5F+/Fuc3bE2gK7xEKc6FmBbNoSil62R3KunhZnHO/IwCmPChiHeQ8AoDqStsJXFihQCaal7Bh8fCIwkot1opO7veDc70p5toTvPt/E9tyzZb+C+8yImVu22BJY20brXUkjJxZ5Glagp9I2DcgOCkiAyb1CBA/4idRquqG2o0O7fZavlz6bh2Herh68CCeFYSAcrSrtNV8v6TLALy7P/C/53PVfZIm1rSyy1QV9P6QEIE5getL/28mEWT5+Mnro
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2018 08:06:10.1337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af912fbc-4808-439b-d220-08d592f06fca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR12MB0130
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux currently provides function detect_extended_topology()
for parsing CPUID Fn0xB and derive CPU topology information.
Therefore, also call this function in AMD code path.

Thanks,
Suravee

Suravee Suthikulpanit (2):
  x86/CPU: Modify detect_extended_topology() to return result
  x86/CPU/AMD: Derive CPU topology from CPUID Fn0xB when available

 arch/x86/include/asm/processor.h |  2 +-
 arch/x86/kernel/cpu/amd.c        | 16 ++++++++++++----
 arch/x86/kernel/cpu/topology.c   |  8 ++++----
 3 files changed, 17 insertions(+), 9 deletions(-)

-- 
2.7.4
