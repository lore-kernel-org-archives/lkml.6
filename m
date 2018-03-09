Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751005AbeCIIn0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 03:43:26 -0500
Received: from mail-eopbgr10123.outbound.protection.outlook.com ([40.107.1.123]:19872
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751193AbeCIImP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 03:42:15 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=alexander.sverdlin@nokia.com;
From: Alexander Sverdlin <alexander.sverdlin@nokia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v3 0/2] ARM: Implement MODULE_PLT support in FTRACE
Date: Fri,  9 Mar 2018 09:41:49 +0100
Message-Id: <20180309084151.2379-1-alexander.sverdlin@nokia.com>
X-Mailer: git-send-email 2.13.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [131.228.2.20]
X-ClientProxiedBy: HE1P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::28)
 To VI1PR07MB1328.eurprd07.prod.outlook.com (2a01:111:e400:5a03::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70e5ef52-dfe3-4342-1c5d-08d58599a5a0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:VI1PR07MB1328;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;3:eqna2jwdfVltcR05Sn5LO0OBMgiLDQBxx8ibith6pCmxGCHERzYyL0A49vvMykJePxSofeHdboCa0zChFnz9Oaz9raBHYmOvUJBSBLU/O2PW+qF2P63nciEHBMAHkJNb5oI5w8YPX9SYg5kni1T+8bRJeWon1lj/DZH1Jiq4+/nfCoWv9i2Lask9tpsOPjDidUjsB55CR5/ZT0CyFps/r0VSDwmPzJ6RxRq3UxC1TCPy+ADaVhy0Tv1I99t3OIta;25:LVVDf3LE5o4CGtozP4OZDAxgS0eKRNbKfiEejeLWA9NKsYJQq4QpOqQoCVxXRf+eFNbr6+INyu/3FueyB/EO51/7u1oQjO4e4yF8KjgKzm1ANnyPqmjEspMi/YBC5ZXL0X11KC4F7wY02ViP214JLlM7UGwB1KYiS09yLYq+NHV84poS/w8ln8JirWh0WHN12s+184jTju7INzIp/3OX+/LOk8iBXGioaYpZlYr3RZ3IuGvGbvGUMhmXomhWtruYumgET3mOcz+V8u4z1W/+MSVzPgWwUcmWyDKjvGe12XrL6+SjPs8x31Dc/AdBDqtpo1QE8nKjg0kaQthH+v9OeQ==;31:ETo35kxOaqyLsOAMxDCytwSAslHhDWoYsLsz5lywLsJGQ2LQP7yeAiHOJbxCWGSVcW8HvEhkcssZEtg0bhtP9Lk4xDxdOw23d1pKdkmRGWZEIGfEEr4j8YwjF01A8Qe9XtPkzKumkMpLNyOKKiDEGv0j1VaiXd7Mqfwei8Pv3mOa4PVFmV1MlUv+h5AcnK6dFCC1I2iOfT392/M28XvH4NuGioFEVZaBWv5nZPIRn9s=
X-MS-TrafficTypeDiagnostic: VI1PR07MB1328:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;20:HrfUL06eLgn0Bm73NvZ4NM61l8j58yDDu2hew5hSFL3cckT4SRl6AKxJr1rEc60qy4h7SxW9pgix5aJRGpRy3pg2U1iPL/iYP0H85UKoCFv2vrkESVQO04sWZu73CvUmgDqGAanS1GEBCREB8Wt0VDOysmgMPf4L6+4fasjadl5GEIlgGV+gFcaUkDFftnvdAh9LZSGlwCmEneS/PncOtvF/y8VI9dP9wQcpEVrLO6JYotwFVNqVcmZHxjG2t5SCkuT0SKu+jk8syRpfUvS5PeqlZCwPrKlu9/3frkb/wtkbFR76+WWs1Gc4t/E06xHxY8jvg40whUokAwHXX4JaY3/UL0crI+6HbyoBywuik7Zlggwth5IK6dndR/imn/ZwHIpDDHSO2V3MdZud0SUBeih8ogqgLUea0lzCmMsUJepSdZ1W4pVUNbHnt757pkZUoryfD5LwKxvbJ2bWatckz7sGeow/OJWLGSFevZmdLwYD6dwD2ybqFk4Nudi6Ls6lSYr9EgO5lPbWMQyRzXu0LajAZTh8Rgv+VbFXCUoeMGozqPtJTiaA5vWfu87zh+HR8v1ouZamgtEvzmOZJR3OQKQBBT3LSzUhT/aRcQ5CgeE=;4:rS8DbYDKKsbNef2vM98ykmN2UfEsdn51v63wv3KOu6pb2hMNp/w8vonTbhp468UlUTjJCUh71sWWnNKje9Fuod12wzs5D6BqTII0pDv+ui+7aB7/cHgDFPy4zzFcf0GOzI3ceJkJYRf46GWqt6r7cOuL2TaGfXLyhlyW7/zfWcYa6INOZv/pDTL+BM3JUYA5AIz7+5rShihuH2ih5wYpERHs38Sl/CD1d1r8sWh1z965O/ECj5I9QAGE1rg2IFm43zVA1BTEcDiQvJVSsm1Xtw==
X-Microsoft-Antispam-PRVS: <VI1PR07MB1328E4CB5B197EF604583ADC88DE0@VI1PR07MB1328.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231220)(11241501184)(806099)(944501244)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:VI1PR07MB1328;BCL:0;PCL:0;RULEID:;SRVR:VI1PR07MB1328;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(54534003)(199004)(189003)(48376002)(4326008)(36756003)(86362001)(106356001)(6486002)(25786009)(97736004)(105586002)(51416003)(16526019)(50466002)(59450400001)(50226002)(52116002)(386003)(26005)(7736002)(305945005)(186003)(6506007)(8936002)(54906003)(3846002)(6116002)(6666003)(8676002)(16586007)(68736007)(316002)(66066001)(1076002)(2361001)(5660300001)(81166006)(6512007)(2351001)(478600001)(47776003)(81156014)(6916009)(2906002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR07MB1328;H:ulegcpsvdell.emea.nsn-net.net;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR07MB1328;23:eboNiPDlXkIkTx+iJdG4Ha/PYr121XnwsV4KVse7+?=
 =?us-ascii?Q?Mp9hz5PZDVW+8u/rCLVH1IN/lUU65iK9Nkr55f0EZ/SE6k7nMwitsJnqNtKC?=
 =?us-ascii?Q?9w6NWCXjBL5BA5fFMzFxVnKtrCD8Sd/i6SysWwDIoxMFcEKUcjjN2eN+Z2lt?=
 =?us-ascii?Q?EcePaI/7e62oUmZtmJVAqOwDmHul9qGFCQSOdWpJH9vW5F5VfSG/Ij8VM5sv?=
 =?us-ascii?Q?oA1GdsUOnAc50PeEo0ptofeRsh/64qf9pLtTNFRXfZJwUZ50t8Z5HI9xAFQP?=
 =?us-ascii?Q?K7rTcoUf+KUqM0kKsmIjXaIfxanBTPfm5Syh1sN2LR9kWVhPfZf6OevXQs1p?=
 =?us-ascii?Q?9saYzU1AFT4BXXQrhEKQRAgrgLpC6eCl88UlHNz6dPTOrknZHmOizUI9dA4+?=
 =?us-ascii?Q?RUq6ozFdd/giVnStEXPtT8meKLL0b8saBvY8NZfLR08aKUUtCZecPrug1zmw?=
 =?us-ascii?Q?k+EIeeOOyRjrCK1YFJwF4QuB+DDMIvV0G2ZnMlAVa6oMslmRQuLwcqj1xKeq?=
 =?us-ascii?Q?yxBME3UIWCpLUmwM2LDeZh2UzgQMHjAx9TgwOai9LCmgRpncS6BqWsCdYypp?=
 =?us-ascii?Q?KeHxZrlXL2SYtS2Xcv2LBdxndBUgsIspMP45kiD42/b0nIfw0kNY3ZRXTwjD?=
 =?us-ascii?Q?/5lZb3zClxB4c4LhafnUGovpFevYSx89JWy+wMkQ2Pfo8E7KPeTFgiUNMMtq?=
 =?us-ascii?Q?Yu8THeHQTctpqu8226EF3/dGi2k+PT3U4PzEBzt57VgYGB1Kfz7lOy90txxw?=
 =?us-ascii?Q?vB2NcFSYAfO4nXumUWca6L9fx1xJYINHlGimpMF4C4QAfZhyxA5V8g/45FM0?=
 =?us-ascii?Q?A+pyj/BXZy0Mg2ofqCMrpwSMnX/E7ygOMtDZWtliKZInKaROyXNdxQz8Ko8m?=
 =?us-ascii?Q?uiSXtc58JLSPC7AY9nYNR70xug4kqzK6AJT/+PvmZ6QIUvotPBqTaLX4OKx5?=
 =?us-ascii?Q?lt0CIjOTbRAREGSu4tHM6pIyZPpKUGkj5mikiztFH+VMaZPEPqc5hgnhZK6D?=
 =?us-ascii?Q?O4/2lCPaaSSctTv/fNeo9yG7FxzmZPqmNHUQbcjthMn9yzQMXFC30UpP5qOx?=
 =?us-ascii?Q?1ZWDVji3MLpdVsBmTddmTTTFPlLEzPyThIbbbelT6STqLSKRCU1ze+llP1Gr?=
 =?us-ascii?Q?mk8OMWvty+/GLd/vo3AN13MFAojNW35aM2F/+Xcy6ApjdOBWgEtatx0NlwDl?=
 =?us-ascii?Q?o6xUpGiqVK2eb0=3D?=
X-Microsoft-Antispam-Message-Info: JApUBS7BP6QHmcPMWF+rUZF+mAVWhLz/OYqF/Bh2UPfD7Tvi83DHVb4HvQFDCWDJr7Pye1EbHP7qMMYvaxoLuBGaH5hQRC+YMUzLTiFU8m0brjVApyG4ZAi/FNnC4yzZxKkKu5Mv0Lfe7C+w8U1+qPwICvVzF6vlk6+79a45KAGWjDVop/edpvqVlXSkeEy9w+JG3u814UW2oI6PaVxpiaFS/2S7SByVo1CdgMC6IjZk7gpk/od0grODrLjfoHjE
X-Microsoft-Exchange-Diagnostics: 1;VI1PR07MB1328;6:epGvgtiAhK0f8C6tXzEzm0J4qBsCR1FE0qrMJp+QMW+XRWgEtesO8Mo3ysNcQc8lS9JAOoT54Dz2EBYGtzsfjnw5LRLAy+EU6iO9o1ZpDZtxUI+os39epIrKuCflw2TrdihiCh9fq3RsKGfBd5U0PToqICeqdcrgTDPjekQQEpBSpyEMfAwjzTVfhlLqUEz7hOBvISzhLLNu/HrTsOAb+QH1FyLdbRY5oMhmgSls+4xuasLqcyxGt7iZMUG+oUYsr8vk8Y7WMjdQFXCpXo6mO3zwj8hpKGQDbjQFHPB4y1kqhlS4g2prYiaw+MG3JmbgY2OC05lAA2wBBIhPBjFOTyXfC1NrBePpeNjssyzQE5o=;5:otiJn0BtXTVjErmyBLC1JShCeMR6mpecofPeySmX9/MdLxq45b/6anHCMvVYqvI082K+kCyCv6N6aTD6ndnZ4DgH+VEjpzWfqOHMqV0ybYkmcbP8yJ40WmP46BIf4ji3D/Azy8Gp8Ib8kxQUNitu1OYi36p8u5GrzoZ32SMpCNA=;24:kntfXMaBhBwrmvKdVF25MkpijB9mcoKJ0PSjbXNhKDCkRMqLGvbuswcDMqEqVzfn7rrWUziCX4ZqNTMyzC3/MRPnCCU+HIo0CE2heewmOSg=;7:7a9jEtVWXWtm1jnKF059FHGye2SetBwISyjC0qCm14nMl+1uQIHHZqW7g5dx6nm5vxv/ujNSANRRmzzDjJAN8EIFz6arhES/oN5VeBqNGHH6KpGKbK9sT95MjHtoMjBm4+pECDeuDQdGeyC+96tw80pr5vJB8alqJHTfGuSA4Jy7zpscwvJzBSS8piPmX2H/igcZy5tNqyqDvCCDGiUANALkb6qBNTM7tL4eKkwg16+DpLXQ5LqSuOqa2mFnLLjb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 08:42:09.2132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e5ef52-dfe3-4342-1c5d-08d58599a5a0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR07MB1328
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
v3:
* Only extend struct dyn_arch_ftrace when ARM_MODULE_PLTS is enabled
v2:
* As suggested by Steven Rostedt, refrain from tree-wide API modification,
  save module pointer in struct dyn_arch_ftrace instead (PowerPC way)

Alexander Sverdlin (2):
  ARM: PLT: Move struct plt_entries definition to header
  ARM: ftrace: Add MODULE_PLTS support

 arch/arm/include/asm/ftrace.h |  3 +++
 arch/arm/include/asm/module.h | 10 +++++++
 arch/arm/kernel/ftrace.c      | 62 ++++++++++++++++++++++++++++++++++++-------
 arch/arm/kernel/module-plts.c | 58 ++++++++++++++++++++++++++--------------
 4 files changed, 104 insertions(+), 29 deletions(-)

-- 
2.4.6
