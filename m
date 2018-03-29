Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752254AbeC2KMp (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 06:12:45 -0400
Received: from mail-bn3nam01on0079.outbound.protection.outlook.com ([104.47.33.79]:34834
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751059AbeC2KMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 06:12:44 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com;
Date: Thu, 29 Mar 2018 18:12:20 +0800
From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To: David Miller <davem@davemloft.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] net: mvneta: improve suspend/resume
Message-ID: <20180329181220.61d63c92@xhacker.debian>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0023.apcprd04.prod.outlook.com (52.133.186.163) To
 BN6PR03MB2626.namprd03.prod.outlook.com (10.173.143.137)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b76c214-5664-4dbe-85f5-08d5955d9bda
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BN6PR03MB2626;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;3:miqDpKyZOMvWuY4Wlw2oMWvto+H2cA7BgjZ5ZifUabmF5cW8p6p6pz3cZUxmFlTZ8jDnCBwnuCX6qPDKNvqFzn4GKjrf9WeOwG0q+DDds0tPLWO5fTCpEN02dctXIBK65cYRZfKgYM+TTfe9kk4D5RgHmWyMSmEOA/vYRyqjeAojYFL2gN6fjHRe6ifGRH6PNVTVkJsaspj16J9VR2SyD5MPc9tjZDWWQzKOP/vLZWqW7WgHeQL/KqVbXqoJjZXd;25:Mpgz339u3gJfbHD98dJ3BWjMfEPdJ95p+az1Xbkz+dYuf7o+W+ZTCdUC0ga2nhp8MBoHQHLzafo7m4OGPrk40nSNaojITsUoNP7fxQog4zmKZMEg4WxFHH/co+r8UPCWJ4weabnCNQZM4OYFU41da7T0+IlyJ5K/aafKADgE3C1ZtESfwbvlFITWhSBAs4u4cVpvs793McgEXMxul/CcYJhqdsNgRTKMKOYRtW32Yo4sU7dpyo8kUiMxR33rLLZYS8DSPgwm92vVzX64y0jCXgFXB6EcaRM04u/1SbRJcGvw1nEIcihjF1mT2GvrJacXNUNIRygxbv63/djdTD+eLw==;31:P8+gOcnVsA79u+jfikq/IE2MHbCFV9VPefh4zJ2cCBYZyQRNI8mx88vbdcMwvvQIQzKYb1oYdzM4wz3xBzF+dN7e/JfBKpzEOWI++kd9u0hz90aCHwlNEf0yGvhHBLQdr/i5pP+tSus4OhIgg9FIvA3sXzJv1jf5S69+uoDmjAY9L+Vskd4L+wgnA5jCJki2vC+SWW107C6SBFi9pLtWL5FG3/IRW2TvBHad/gLcTWg=
X-MS-TrafficTypeDiagnostic: BN6PR03MB2626:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;20:Qu3DZifdJREAnfaaZ6sbN5PxjlGQpvUkyHPiM1Z46NK26vvofLorAf4rmGBPWxB6MZVYAB/hSZngXUJCTdyqRQ6e4wqB67bOZKWjD8pxpO2eacbKE5OmoauVP2KNhXa6VAw32Xs+YSLeiIKHNpqCl4wmXuuF/QlO9STqlhOezo6GCvcfIRgNGsHVRa8hNPp+v5ZrT5R0cZCkmhaLqsO4hOUExOur98NgRvpzKXqj/270e2OMMIf7ngxSPeKueVB8onswvkE4WfghbY0AF7qz1LSn+M1vV1KMWt3ciE0354/ailj3tfRUbO/qxE4wk6+J66iSVIdzZK7mCY9/xQEbgG6rpBX9Mao7zMT3R1yukl7GPmtckgxbMPCiYTn0vJc1DaHWo47qIsCBkbzfltgJlDr/mHF3fVEQDYxSOinPQ8aQIuW1EVsYXwa+dT+9H63Cp9Q8RjdhSgE4R5NKgjo8kYQ6PW7/SnvDzDfCXxi72E0N+J9B3FmgnYWmRbD+5XEH;4:VncKzhkMWiXo28GTMMey/PZyFIuXA6y0H77imBmIDJKKvV6KC+6D0/9YGoOib2G3hBWcnM80FeFA6JpXqOdxUMbHqWRRAIDTjU2bc/rx37UF+ilD3hqB9Ad3pDQXJ3fKxgL+mUv99kudPNCmZe7PFr+eBdt5Oluk2UbK9elN43QChkeVs2hHxdXbEwW/6hZ1Nm1aEX1fAvPPcVyP+bnwnsxFxKjQhmC+Vy0iHru0FJEj6pyeqGoUKmrrydaaILmN26/nyFYGlERN3FgBQiw6Rg==
X-Microsoft-Antispam-PRVS: <BN6PR03MB2626E8A09ED4DE126CD1EBC3EDA20@BN6PR03MB2626.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN6PR03MB2626;BCL:0;PCL:0;RULEID:;SRVR:BN6PR03MB2626;
X-Forefront-PRVS: 0626C21B10
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39850400004)(39380400002)(396003)(376002)(346002)(366004)(199004)(189003)(186003)(26005)(55016002)(230700001)(316002)(106356001)(110136005)(16526019)(50466002)(105586002)(4326008)(305945005)(7736002)(3846002)(5660300001)(2906002)(81166006)(8676002)(1076002)(25786009)(8936002)(53936002)(386003)(6506007)(50226002)(68736007)(81156014)(72206003)(15650500001)(9686003)(486005)(478600001)(7696005)(97736004)(486005)(6666003)(956004)(23726003)(66066001)(6116002)(86362001)(59450400001)(47776003)(52116002)(476003)(33896004)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR03MB2626;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR03MB2626;23:FPatDSe+mKA5X+t4mk5WHuB6XTXPy/D2zIXrZXLF5?=
 =?us-ascii?Q?zEU09XNftSBHjxAuVN+puvyCd+zjoGeKnh2d+vJOkxikfxKussixM/QpiqsX?=
 =?us-ascii?Q?RdvtlduP2b1XlgHkrPpL1CL/P7cuSUo3zZRYXTQG7FLDBLV2X6v1FYq02vz2?=
 =?us-ascii?Q?J/A13IFkzVeRCdMripkNPU7elvs6gg/MxWLBp/VbPTNNy0Qsv3k0oLk+ToL2?=
 =?us-ascii?Q?I9fPEvOpmhYMXKcShtYQUECQ4CtylcCaYnFCfdnd698NAnUtjE3Q9+8i7FGi?=
 =?us-ascii?Q?FqUrqgEc599wwvEMKiIQ1rszQQy0sylQh5d7gYMpdeLMKQIRHX7Vka8SV6uF?=
 =?us-ascii?Q?Pdbmw09z/OLRhFkWMtiM6YmIib+XyZWHwByXPagmV7gQMfrx2ShWsxuBRmzV?=
 =?us-ascii?Q?lwr0uHpQMpMHLZzQYS1cjsu0fFgG3xkRKYka1BfJ4mYzW6XthHnH9vpQIM+g?=
 =?us-ascii?Q?M7SrxYa2WSYzEHthOQu+AbQ1OvImE5KnI7CD/to5ieg303EcYRzHpGJHsz+W?=
 =?us-ascii?Q?Iu1i7vbBLJl7oofJ/39PYcdbPwVmThSxv1Y0nOpQSB4iHGhXF1Bi26Cvp2xI?=
 =?us-ascii?Q?/w7hYlIJ6cotejozHg50rVucWbWNGBWBRd5MMg11AzIKGH64uA55HL3YXeJv?=
 =?us-ascii?Q?NZsD2xaBKL90sGZmJyUU6aYWKolBlNI9DuWxRn4fS4F7KDz5/yHdWwGJBMuV?=
 =?us-ascii?Q?m5Bl7hq68UYjfV/Kdf2DrNHdgqowOvgvupI10FyrkU29BlWrwrfFRltdCgsA?=
 =?us-ascii?Q?Wdxng5zM8iNL+8ljvgLvVOgdIF+3ficDtyKSKSGH7g5Dewa1IOZ71pLG9jX8?=
 =?us-ascii?Q?QESsyh25utY97vfCwHtzxxJdHhRIgjMgLR6ZXVJaiWsnKidP+NGe47k5MpnB?=
 =?us-ascii?Q?Gvu8TLbm7Ii4zq89x0QCcxptFC6s94JAh6Tu6xePgzb1T8NO67wDIfnXkf8+?=
 =?us-ascii?Q?kiu4gk26yTZylbIXam13CmzM/PPNPzDJewWxAbBzvh7Dk8v1Or4BJsjj0lsE?=
 =?us-ascii?Q?YRfGZrZXxlnSJlzzUW3vI8fmNjnxmTpM/XzItYPLwFrhjPrztUe9/m3tN76T?=
 =?us-ascii?Q?a620y7QXGFfdts+tCWVpLweXLBUkCcAbUWFWXxEEEb0dJqDnpQjNnRfQZcoq?=
 =?us-ascii?Q?tE0POgVbBE5LDJOH7Zs1uS/NU9Sw2+GeIjvmgXneeB327qpuvZ3G13V0dkzB?=
 =?us-ascii?Q?g6d2iDZGFBch+NlLg7bdNpVWM3Mqcx6h+lNmygywtK9zLIZcNo4xtRHJyasH?=
 =?us-ascii?Q?wfYQNEXcB5UthZo+B0=3D?=
X-Microsoft-Antispam-Message-Info: D7OddsGtspTq5e7sxo6tnBiZ9D+kIyexRc4BPpO5xCqLmLBm6RQo/G6llp00HM0s01KdJ/HDD1+zQJ3p5jbirTpO/SoA/1Ux1Rq2t7X/DuV4Q2xHZ9arKlKKyqHC9pIumyekoopDXW0D7AHH1vc1hwRzJkrI8XCUl3wJJ+33is3TQhFpzPSXDuAIVHY5fMha
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;6:d2NQeiZ1cp0XZsbIKqqYuqUNL0+8OScpfIDjFoiU43IkB2hQWIetJpebFlKOLYBfZExVaSVu4eAHWBZk1xI0QH/KYGCKG7mgVeZijiIOxVeVKUjaZrBtxgwox6RV63/ZtmIGNNAi2uwu6NpNgL5WGI7c3kg7hfn2YlcbyDZvaZZcALq98LVrNQhFmDz+LPxo1dQ/AqzgUokJwKsA9N+xOnnEDm1ZtGqyl5LbQ16O4LTgepx06qI/chjnuKDyOW9PbpdGCJUBHA0aq7pxF3dw7ozNr0RSSSJhT8C6VV5WLt0PDuRqm5KDTi2KM0cIUleibvlO7C9FBdo3S056CawdaAB37wh/XdM0qQ3pjyJ+kIiaelI6ryySDajQtEyPAyqQXt7DHS0L9u61n95svqQDtEV0vwWKZCJzYC5JMdaUFnb8E/+HaMJT9/gnJ+u2tp5pYdg8X4hp/lI/5+gDrl2fZA==;5:y/fjY/px9wHCxs2Ef3HY40kMgTuD5C+XYrQ6o/nbesJVySgBZtjIt/6RD8KqovBK4241resPI5iQztOOYkMpmNogNzG8BdfXkQSISZ3fPnS3Md1zEQdXQg0TQctzGfBamin+BCqVyHVpucmc+dkCwpXRBg5tst3DGu3HRY7BPoI=;24:vq0ieWjdxD+NmI4j/tqzlaG8auH1m5gW+krx8xSIFyynMJhbFNeacXH4Av/VogUTSinFpbLR06d5VWjR0W7y/IcM3urwtC4s8N3q6+ZPwOs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR03MB2626;7:3OrrTzbtaJUxcz5xubLYzS8bvDXqHGJ7j/sBy3kPutiNzmgDpZl9x1BZOGQg0VimeBh4h+3uFLromCBtIbE9EMWezLjp34KebITW30v/icxNbh3Q0s3LfthfcX6qQz96ExYx53KrMsFDyZeogUwN45YibPCqH1oPV80C84n/iBdQSEqoHw189e552CTdf+9yLXmFeveHrVMv6R3qWj55jvRxc3Tz5qO/R8dCC5ChsrFH1NgZelWJXhJbxQ8SyCbe
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2018 10:12:40.6096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b76c214-5664-4dbe-85f5-08d5955d9bda
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2626
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to optimize the mvneta's suspend/resume
implementation by only taking necessary actions.

Jisheng Zhang (2):
  net: mvneta: split rxq/txq init into SW and HW parts
  net: mvneta: improve suspend/resume

 drivers/net/ethernet/marvell/mvneta.c | 146 +++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 27 deletions(-)

-- 
2.16.3
