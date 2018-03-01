Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033186AbeCAQoH (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 11:44:07 -0500
Received: from mail-he1eur01on0120.outbound.protection.outlook.com ([104.47.0.120]:8752
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031613AbeCAQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 11:44:05 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v2 0/2] ARM: Implement MODULE_PLT support in FTRACE
Date: Thu,  1 Mar 2018 17:43:41 +0100
Message-Id: <20180301164343.5794-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: VI1PR08CA0129.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::31) To DB5PR07MB1320.eurprd07.prod.outlook.com
 (2a01:111:e400:599b::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eef2211b-bc2e-4017-08d7-08d57f93a36a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603307)(7193020);SRVR:DB5PR07MB1320;
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;3:IFNstO8hppOQJg+sYWfzXH3Rkp+86IZwwt+GOTeFSS0Tc7X4nwfzPDhC0iDDRfasXJyoxtKBl1PxSn7uEQXQ0ibNwu6sGTg9HhiEPqHyl1Dg6drP8ZI8td/s2ZR89dOxfvJhVal46oivp/lXKT0oOmnSYjWDEMkfPjX0IToaQygP7hRJ7Gb1XpkNSmymR9Wk8se/69vvuR2XW6VqNjOStro0F1wR3lY2qljYRuoMMGAImk5W7XYiCJYkmsCdB9Qz;25:H8lEgn2NoeEfrAHCPBgRPa721fCAjH4V+rQdFeivBIKevWY/piITZdvd/FKX50YitCiwkRJD3zuDXKDdRr+YERDzV2JKymLHyuE8vPPHiMyfqx4anqhkx7dUmmz03z+KLJDmHcZG5ScmW/PuZ00Ryx7vxTi29OxjEujHEO+9HzGPn/9UG0SG/clm/7rgX63ntPt3FKkl4aDzibIP9jPASuPAJmuLLb6S340zx9z/RXnbRa5KEwsK1TDqB65FEnsgXVWhKr8HvRb0gXIBLefY9Qgtg91i7h/XZOov1aI1UC4/M4zhrbiscaPHCI+8whacpz6BWkd6t+ABBImD75znDQ==;31:PRxH9goY73HMyulyFIzMns7dKf0n6PI4gQ0mb3d/kHYW8Bn4/gV0uwtVwPWhVQknpglQSfszy3F2JVZZ2fKpUKMdPpCAdcqaXDc/UCF7MQuuBNdd6aa/01tOmCPwiB1BV9I8R0xeWqZNmCoKRLgjQ0tG0y8F+A+40h5LQxzTWNApNLVXw+Zv5u3yc5IN+S/MiAgvCWWlutwC2WSuq3BpXkBkwWIPv35EnoCjrAI2ewY=
X-MS-TrafficTypeDiagnostic: DB5PR07MB1320:
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;20:E6VTppbNSkAvD5bjzq4DMr8m+d4j258XBHK0k0QV9iY2V6hYkmZL2sx8EnNL776X7dYiPH1GBAZMS/BRHnT/JKrJxWgsTctbwQ5BBZczooA7EyHt02AB/eUwuQdcrCDj7VFAU7jdJaWefgTDN//mX59oMDBs/THY+PPwRQEhDvZZSmQzBc2oiHNRKn62a7LKzVzVQ7QHL90jeUXuUHZQXRi/VGSCrFomZRWAMObQwKLoACB7bjKbrnQjNc+LwLPtHgtpZ1D9tAYLmBNaZf2TeOQgFAJptOSZOicx+NllHQQXB3l6D3uWw25/J/gYEuWontAeZOZMOvxIRwAceivWJBBWMkz+oi8lJ8IeqtPaGcKTPmBlIs4KSoxBKd3L+s/9oVvuIr0YcqI7fBG906F2HOg1M6eaot2MdJ7N6xdeXdfef+/8bDXoGHWDFABj9+OQfv2xDjPGOiyLqeRHq9Sfb+7eXsLeTtXlCSzaF+gIK1KQz4vW0Hy/559/1EIWWJyecBmh48YR7+kqC9FToGd4MmlnAzMYsOC4AzolOOuwm22dsqcbBTtowo2Aq45LtDb/D5NNhopRv4dKugj7/xgPCoJ6oBYxzTOXBnvPRYOxMdM=;4:mL+NOCEnBmC2ZaQk8AXRPnggailNzxEzK+ju2HqvMJrEeO3dfenZMYLp2I+2FlsbZERkDUHtOp0SkC2+rXI34ZdCcJBM4G+F9CEQlToe+QdPnJtIyXoP88UadhVJE5vGg9A1RNC8AxX6DB7+76+qszbssXsNlWuDboq6xHCZpt4sywBvdOp01vYGUFNTBYWaKN0VkFGhKaph3i53VSjHfekH36LeTFnUO19u1XQj0UKrTe3iiM2Yoq9KGYi4vux/kECM7t3fgx7OWPJfaFJjPg==
X-Microsoft-Antispam-PRVS: <DB5PR07MB13207E8A92C79C5A645BADF488C60@DB5PR07MB1320.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(11241501184)(806099)(944501229)(52105095)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DB5PR07MB1320;BCL:0;PCL:0;RULEID:;SRVR:DB5PR07MB1320;
X-Forefront-PRVS: 05986C03E0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(396003)(366004)(39860400002)(376002)(189003)(199004)(54534003)(50466002)(68736007)(25786009)(105586002)(6486002)(305945005)(7736002)(6916009)(6666003)(53936002)(16526019)(478600001)(54906003)(52116002)(26005)(16586007)(51416003)(6506007)(36756003)(386003)(5660300001)(47776003)(66066001)(106356001)(59450400001)(186003)(86362001)(316002)(6116002)(1076002)(81156014)(6512007)(8676002)(48376002)(97736004)(8936002)(50226002)(2351001)(2361001)(4326008)(81166006)(3846002)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB5PR07MB1320;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB5PR07MB1320;23:0HRnsOhOFZvhWiUDF2QnLZ9ey4ilWLjJZEs0PDtk7?=
 =?us-ascii?Q?hLfeMdvgKEjmiDGV1rw2aZJho/OF/P+s+ahR0Wo88uAJwyYSZpsLArKkfuyy?=
 =?us-ascii?Q?MleT87n3YeGTBNxSOZllIBC8hG5W4eSn6msQgYDOmf9oTUwvxopiUKwlb/xQ?=
 =?us-ascii?Q?44ndKXfGqyLCFIj5j9IlQNVOq2F5RGQKZ+G6UqtH46EppBNsC12FppWfYcVa?=
 =?us-ascii?Q?ZfiLnSsaxMwrLOnE72lcpxA7vnTayJig8DzVHQYvXBDGWhWec+2YjVh2Aa3K?=
 =?us-ascii?Q?MQKvnX2aICJKjOlznKekyBj1aLoUNi3SIrifibxB4aR6zVxwosiqUcChE44S?=
 =?us-ascii?Q?0trO2/G3qD5fLlYtVCPy8dYckdKtDbpiPVjSZ9mrVGYtUthtyvZwF3DjPvAa?=
 =?us-ascii?Q?qjHSUcYvjLg6G+gC5UpiWtMqum2WQwZqxIIK/uCpw0EqQ2cHZqtYuOc13C/N?=
 =?us-ascii?Q?JZlb3j8archYWZCfRrXBE8xuEAO+L3pyK7m/Gtj1MISwE1MnVvEcc2kATn1Q?=
 =?us-ascii?Q?ErpphQBbkQk59KjTbGiGqLIWZl1PZGZ1hzlzQ0raew0KUEr2U8JMt5QsFX2r?=
 =?us-ascii?Q?ueVf8D0f/wG65ESUpLxN6htI8Tnu+jpAgaSTKmpf+4VGqLVxGXfa4Zg+CxmA?=
 =?us-ascii?Q?Nwpf1mJDNmnzsWHaU/Ga7H/LGi123TL19c9XYtPh50bVbasFzvTlqpWgjDnO?=
 =?us-ascii?Q?3Cv4wn+k6yxA4+fIYFRBnQ2JwBaNHYGpLtqGKBnssNkD1GCfuCSQjrMfMJta?=
 =?us-ascii?Q?L4rMasEdZafgnn3lrM6b+c8DGI0OW4X9lu05WYawgF4T6NNNJPlih5J5gG5Q?=
 =?us-ascii?Q?ITETp5Ug8iQyr/Vxx90xGYaCZFwZoaKB0wgzIIxytYpxo1OqcKeklG6eqkWu?=
 =?us-ascii?Q?kLr88wBL0rw6ABYCCe5rgqtDB/9EyPv1soor0eY4HrvnUEI6xk5I98A56fi0?=
 =?us-ascii?Q?ozQRbaHrlQVHVPMxZJSdA13QD+LkPDWj+bb4L+8YLGJ6I80NYnAx2t980w3m?=
 =?us-ascii?Q?r8W2/Nhbob/9jFgqG56Iamc0+w6O7pyIZcF9w+q/I+SprwHI7gkS6uXeQGlL?=
 =?us-ascii?Q?ERPiqZN66gM+hliGq2xL3AaHiv7SPnri0zEmp8wu/aBMzZgSDiuVjfd7OHpS?=
 =?us-ascii?Q?c/yAvN8aZnPDOlAtwvvE/awuZfmS6A/99Go3UcLmev4/0CeAjXWgxGtzke0C?=
 =?us-ascii?Q?fT8hsck//m8Lyk=3D?=
X-Microsoft-Antispam-Message-Info: zDJ/uG/n/VF+l9eMUIdAEDDLdd/xhsFIPhHh8dvtS7Ijs1BDPGrqdyRO3fkL2xolw3bhTozELS7kPZAmkRNR7Q==
X-Microsoft-Exchange-Diagnostics: 1;DB5PR07MB1320;6:UBe/+D0CPmP2oyemPYQmnkbvrd9r6+3aSthOCRzX1/yzzx7rgIM101a+9IsOsCE2pjdgUM3j5rvIoxA+/B51So68/WvkBReqd4NQ271TAfYn6JRLMAWZLv0ez+cBcNboEe2LlZROcbsTlkXgg8514reYNRBGfQKha5uItXnlDOObAx3TLjwH7Qk8GbgAARb8ooRyEQrHFVhVZOsE5U34Fu0QQj4v2gDbvDaehG1q4HzAQEb9j+6HqqOoTlC5UgPTpDSglifx4l0xwPNILQ3vz62WRS2skzjyxTLisAgLkM+6PYrpS0Vqcs9eRtGkcKagjYrn/3h0GJ0rVgk36lK+F3YCjY7ZTd1niT8ZMWwAcfM=;5:dbudCPyt80znDBYBLdhwnNNaHbOnHdAjDP7aRE2Vw4HU0/QqS3wfg+ef2T7xWfEtvBmsti+RiPDz+QjzNwKwjFpM7/wnG7IqAJS2NdfdZjD6dEOsM/DCwc0+dPxB8pfggqU6DtSobSB2gsGtwZkn0J1eCXEzUhbnfCnmN+opAOo=;24:r2buSxA4lcOjgcXcL+LTDeE+x51QAfsg5xZn43sVWe5T150iT3axP97MtAuFzP6ZQWApJATFXk4/2RmzXXExvJpUKG3KDnrQMfGge4EmMu0=;7:enjbElqRgkGrq9whTYqWU9Ns9Yv4KWoiz4nhlEdwoYmRrItIO3dK1+WFu+vQvB4tqieX4o2kDFvHbNjvKPzLDCH7/Us56LXQDrI1Z/0LdHlTS3qd23lw3f6uWufkZXk00eCtoxbbfmM4QXCd81rHPPkGSQu2HWPP9LIOuFnNR289TtLRkWWoXiAI+fpXn5vm7mijXq+B/NP/ye9Qj42pUGYgiyUz6+dvtlzrHTrwfRpYrpfwYHQFdXnpSk13V/w5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2018 16:44:01.2400 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eef2211b-bc2e-4017-08d7-08d57f93a36a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB5PR07MB1320
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FTRACE's function tracer currently doesn't always work on ARM with
MODULE_PLT option enabled. If the module is loaded too far, FTRACE's
code modifier cannot cope with introduced veneers and turns the
function tracer off globally.

ARM64 already has a solution for the problem, refer to the following
patches:

arm64: ftrace: emit ftrace-mod.o contents through code
arm64: module-plts: factor out PLT generation code for ftrace
arm64: ftrace: fix !CONFIG_ARM64_MODULE_PLTS kernels
arm64: ftrace: fix building without CONFIG_MODULES
arm64: ftrace: add support for far branches to dynamic ftrace
arm64: ftrace: don't validate branch via PLT in ftrace_make_nop()

But the presented ARM variant has just a half of the footprint in terms of
the changed LoCs. It also retains the code validation-before-modification
instead of switching it off.

Changelog:
v2:
* As suggested by Steven Rostedt, refrain from tree-wide API modification,
  save module pointer in dyn ftrace entry struct instead (PowerPC way)

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  1 +
 arch/arm/include/asm/module.h | 10 ++++++++
 arch/arm/kernel/ftrace.c      | 60 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 58 ++++++++++++++++++++++++++---------------
 4 files changed, 100 insertions(+), 29 deletions(-)

-- 
2.4.6
