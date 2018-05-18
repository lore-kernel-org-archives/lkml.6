Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeERUX3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:23:29 -0400
Received: from mail-db5eur01hn0207.outbound.protection.outlook.com ([104.47.2.207]:21837
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751446AbeERUXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:23:21 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Fri, 18 May 2018 23:23:08 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] idr: fix invalid ptr dereference on item delete
Message-ID: <20180518202307.GB753@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20180518175025.GD6361@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518175025.GD6361@bombadil.infradead.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0023.eurprd07.prod.outlook.com
 (2603:10a6:7:67::33) To VI1PR0801MB1982.eurprd08.prod.outlook.com
 (2603:10a6:800:8a::15)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0801MB1982;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1982;3:QY0SUMAVjpX4NYvUCse3h2o68maJ6U/k3RS4BOFIH9FtYKRwlYqrTjtGGg+YJDiboZHNgAzoyIhTaQ8v5TUqHZS295bLEe2JPSO5ZTqnTJxZB3Y/umISGhCAnX/WtnbaQfKZZ5eKYWX3rU0oEhXpZFfi4dPuBOvd4J9HvZOvrn9WJXlLvjboJ1bH5VGjLw5Vo28wyxPrrCe2ZMfeZhUSd6ZcSf0EQh6e8EwgxDPuAacfDEGhNhKho0ChXlJpi93p;25:B6Fp1N+OeSP6Eug3amtPn+UDoInf4xQIjnPq2aHIVG1j4GP7mt+XlAUhDXUCbYFSmjVHnuCOdA6tVuQAHiaIpUogQRJwk2A0ocXPvrtsYwbJycIibBzVL4raXI/J7p/kmCkZ/jtPv/1pNXbXrJ4DqnuTtfeTcAPWQZKr6r6b+qx+u2afjcjRUdXJch1Zo2ry6XTVxm+msjlL/QCPzJzmcU3UVnZmzRoRbeAGBCcqnR5HU4ii5dnw7RLRLslwKcDpr9b33lfKcn645GEqXZmFcSulUI8wszmQpoTWnydEneZL4NcDpzD8zzgpbHMNKt4+XmMCVnayi1oI91TVVZxRFQ==;31:IzDBbsqtoSrRmipdiBtERvM7ygMlGkuWd0MFgDSYPcJo3T3nImQtxmCPWlpOpdulssn5NJKWX3J1x/v8JlPl/ao+q4k3yVgy+8Dykb9Xk/DoPlsX2Xgcbvw8GObiT4J9Owe9DsiFY96sgB9T1IWj+1ySfvmimnPY8aSPn7jujSksjiMdSPblcZGlN/iKfIptF2eSK/3xBLd9QoN6bY480LiGDstMs1qqW4DvC4W7ycs=
X-MS-TrafficTypeDiagnostic: VI1PR0801MB1982:|VI1PR0801MB1982:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1982;20:yKWyQCU/OYI7Qs2/BppiObIH71D8Slb/aKbbwVHFaSsBKir58UZ4YYTE/3HJwFSQiTntMOk2ghacQAH+PLiSpd3bCIwsgEdTxUVRgwri7ygD7sW1yiUxdoI7Ry0IVG0OY5SoIJ6jajmGB7Lc/r3dpgmvgUtX/Vn/Vmq26U/mJ6iKSuYQUByqtGP4hzDXx3Yc0CPEQQISS2pkxf2iT5GnxSB4M8RwHqSU0lWfqeWvHfHSStl4gielhg/+7losreOtHqaRK99JDe7BkAM/9DwN/ckjQCVImXa5r1PgEOKJ1dOTFksqFjSNYD62lvSMJIvZMRWwX+tkOjgV2hWdoK7Li3RSq2iyt1YmzJYAtVWvwY59m6VM/rillr35NsqHQO2vqs0Av5uKndGiABXBGvkNxO9ztk8M/yBNmAtTA921H4GkEKisFE3LjlonzMuMN4mpZGoVrKhxAHeHCup7q1bX4PzzsbTZ54VXlYNZARL6oqAEML/LjHZ3GsMZm2aMhCQq;4:dBMG6UPP3Qty4cUTFMOwRHfFHoahDnYJWNEH5it9dA0/GN7Bhvv55e1lCowVqDQ5pnayRbGpKWERPN6vm03QZ9al5BdskOKf+w8RjrD/JR4+tka+IbcPpizpZgb6FJO3sidM2ylrghr4+FP1j0cAW4ZvTTS5z/uzzPgCM9yivmRkc4u0vUhZmuWSqeDlk27cDPyuFR5OPPlg7EU/4t2ryHo/FY1EUezFi95mj0kpCaHUmf16e1tYfIuy91dRrFPsmcCsdrxcWlpv5RN3u+JivcpnfADmqcw67iuoInPdh5hyOjJZLieFhPPLQbhYspNb3xvWlkIm6+qzPOv7llMSoLi69RvWK4K+Qx40FBoX4aE=
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1982DEAD18667EF7D4221065C9900@VI1PR0801MB1982.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR0801MB1982;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0801MB1982;
X-Forefront-PRVS: 0676F530A9
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(396003)(346002)(376002)(39850400004)(39380400002)(366004)(199004)(189003)(316002)(106356001)(23726003)(8936002)(186003)(33656002)(6666003)(81166006)(16526019)(8676002)(66066001)(81156014)(58126008)(50466002)(36756003)(97736004)(1076002)(6116002)(105586002)(47776003)(16586007)(45080400002)(53416004)(478600001)(3846002)(6916009)(229853002)(5660300001)(4326008)(9686003)(53936002)(486006)(7696005)(476003)(25786009)(59450400001)(7736002)(386003)(55236004)(11346002)(6246003)(68736007)(52116002)(69596002)(26005)(6506007)(956004)(2906002)(76176011)(446003)(55016002)(86362001)(305945005)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:VI1PR0801MB1982;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0801MB1982;23:D4LjWkWCH5he0Y8DEAtKuozfwT3PWocMvBHKVsU?=
 =?us-ascii?Q?rkfGN2BaRZZx+rC0uDRxGouFl2phCT7T47qG0aSkay9ljjNTzYW41fXX+5G8?=
 =?us-ascii?Q?hPcDP+C0JmRYMi2pnNSfYph7cd7koUylYz4CVw2hnSDcWn1Ns6lCtWavBq8t?=
 =?us-ascii?Q?GVklAEx7tr8gNJZGJhfJbDHd5h7HBuEVyh3KKKoY+SypFgTlnR93tuiFx214?=
 =?us-ascii?Q?c6kyE6cAgpmUG1CN7efof5gaUhJYUl+Cm4d8nvizdMIPHQolQ0sIOFKP3U0C?=
 =?us-ascii?Q?Rtfr1M6m/8l3uz1cA0a+egeH5Myt2NvdHIg1rA24qcXiOq+6EeldFLZQqfmf?=
 =?us-ascii?Q?1Bj33A5+gn6KiZH4EzWKIfW/iLlYGlka+GmPUuVf8IMHaMdW6Ff4BaSHad0B?=
 =?us-ascii?Q?QfS0X/x2RnekswT0bXwMQAdgxEPoxigtz62hYYiV/Bx55ykBqHySCg+xFkKL?=
 =?us-ascii?Q?IqwFQJljBsdM4mrKG3NVr8Z9ImQqHrGepe/hFTq0KjuLHHQlgL+bMTtTiwHK?=
 =?us-ascii?Q?C/rMcxmft/yofTYzpH8D5F8MtJEXj21T8bggnWDNfyZWt9rjATsAUzkyXltJ?=
 =?us-ascii?Q?iDSsv1Q+Cn6WDg5cf014D48vrA2WBvqf4u3/9ShrlriSwqZd8VEYp/u+zXoP?=
 =?us-ascii?Q?y8d5EXczU2pXLXLqm6xZJkiJOkTofYoH/YydEC2irDVAepCPUDjiA4g3gmjV?=
 =?us-ascii?Q?YHt4V8K0hiI+cT0cVQWHw/s/bsXbs7fycx+OPuteRZMebwnaK/LD6jayTm71?=
 =?us-ascii?Q?2r4bGxlb5MkSNvMWCmkeLuxz5K4ufJYha4kWphkLHX8P32Jc9q9u/cGgrJfW?=
 =?us-ascii?Q?FZBprBP0l8mz/fPnU6DP+QsrLRRr3tdPBv+zF2yxRhsViryfyh1rnHXFPwx8?=
 =?us-ascii?Q?aaYLnom6qZx5TMYdD9ymR25Fdbp/NDHitQQWVhmJLFkjC126M859Ni9gZOoA?=
 =?us-ascii?Q?vXqyFGjvW7Ig3L533D5F4sOnyBZ1pHDpU9pqO1hFsVOPPU0Tvwv99McqicDm?=
 =?us-ascii?Q?WWqGU/dMsKZQiMQj+CYph6HBCDDLhL4VsGbMgvFpGq4J3ni6ACp5UEFjvVS5?=
 =?us-ascii?Q?JovG5MNDwkxhuI7REG0Gv52zpcQE1JTYRMuGVy+5PdvKNhY5UHvtsv6B+CXJ?=
 =?us-ascii?Q?ffjlwe5bIL6yK8dX6q7fzZejucRgl+Q3EgS1GOLJ5qkLUfNHCocj58pAFdXg?=
 =?us-ascii?Q?xLaSVwTgbXyV/0ZfyN+CZ7oZI5sAYF2stqQDSEKYi/hAH1UtLE6U06KfEaA2?=
 =?us-ascii?Q?IY2d5k9lSAtUamWcuQvn/lcwVaX8tQasrnT3OwpBWwLgBH8ST1/BXGuD1/h2?=
 =?us-ascii?Q?5D40x8891AEgfFcSu5BooRmgFA5teGpWGypHJ2BXwaOeWgjlAvC3LQRolfEp?=
 =?us-ascii?Q?Lk9Y6jT0Q3V5+NQ+CLrW6qpU0sb7Us+XM9nbLomskdooYIMZUeWf1r99kiWV?=
 =?us-ascii?Q?zec7e/RlFbA=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1982;23:irJSv/ltLqyyQaWT8QpV3tYp+3ucmNk/xPk55W64epbrLRHGzUpvjkxeSjQH3V7rhd+WVNnJt2keaoPQOLyBjgmLtVedvgq2HZGGydB/pRTMT0VSZ6B10mhcZliDLqthsBlOWLfLnATgmoxdxPRYug==;6:eIFwtjSFjHcCYcmrWGXSuDzMlxLptJJj24toEBhvNfPhXncfGYVJuZKNr1pSwAz/dM6FH1xymQGXBPZ5+gi/3etpZsZqIwKXv3xXlP2b0wiVPZvftVkaey/8xfo90OJbd3u2pkX5HmvV+jH6f3OvltIYVzIdxMNmuL26F0PLYV3+3JiDwkXUu24zLw66g+TENCUOBov04GnhT71vF4B+2nH+Pb1MqlRNPXH7/s0gBUypPNHP64i8G5dFiwOgFU2ow4EJebMMbFD4dS8zHHKMjABG66WctAkFaH8819eLQvo8oO90wD9785t+U26ZkT0qVS5vyMrFn34Q1aw96/LXyHTVCRWb9D13xZfbe0o6pJXuVF0Wf7dtWH14vPL5MSG/f36fL+9LYkKXTGuqK4DwkkjJ6eudeyJZ9o6J8Xb+IBoPvq4SydGhuJEOz8FCyqqYWLr8RSsq4QOB1jvbaINMOlGVEEsX3OSjzY4i+nmMxE24kUU1Ux5dil4YiVE3fO2a;5:Y7UKtAF2qJkQZmb3c6BTeZvM0bKrX3iccSXBmGMSdB+VPCwdJqMy31Uhr4ygVj47iNZBDVY0TRPWIynVndIteKmN2nZngQXNIplA4L6XfzwLQyrUciDkA59y1ER/3Cc6GX6Id7CYweyv0Ryt8Z7oMXtlxEieGmt6KiD3Hxgnjqo=
X-Microsoft-Antispam-Message-Info: /TiMN+n9k3Jclo3X/LSZodb0ybkABEzDIyGU7XmEgj5X5llQ5lbe+7oURPgeFme6bvMGLYUFeRkkSCIuEKWwjvbDaA2LUkA4fXe4M+kiYzFOdAYDKGEKNA2Vw2BpLBfU5XYoUHklx/rp1KmmPQ754NCWWPPQhZuZn+fIeoe69WL1ljmB4Zg56Ta+XLErquqCI4s3PmOMXsB1YYxWjRlF6RboS2h17uB5tirvpBVT60QzeJVZC3DCeaKklEVW26fvphFuKmgnYUy5/yjygIVX8JE5VHfQtXR3MqeWMmlB035sTZ8EK+w+Fl/45ueblj4cPyE/tfkOwXZlCFFJNHno/oypHVv644i4zGmWPJ2MlDsFHWrEwP+U3XR7k+3mH6bbVYswm73+Vuxx9fae6f75Qjnjmk+QIvlUwbQnslFC+Gk=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0801MB1982;7:4XgrgJ9sqO0fFAEnspM5fY19oJ4p6myWFowrw6fjz8VU4m0xC78RaJ8bDnAS95lkBira/GID62dk1c69Sml0rC7pvEURwdJuos3VoPx4d4dCE4+pzo7taRs8x9DHAP9XPPZzY29UdZ4boBC+/0+zXqJRqEWGi0tBlIM/MeYzEJV2egbuJtv9ih1ebG1g053g1FKSasN3tBb2uWDtaAS4DZzWI4Fc3ZMrBulgK8mx0pZ0YC7FQY5NwXDiFU/nFiDe;20:FExWEcWFwS87SS4w93qwBQhQhmvHdBPDASohLhsmslfSgvm5On4yDH34n1tfUaDfvWhMmCADt/jvzuTo1H7t6mVk2qMMKaOr3ln/C8tK/tnHj+JbZXfLCgmoKRXAY6I7hT1HnrfRj59HgITx0ZUutyKmOnd7Vfp6CybsKNhMxhs=
X-MS-Office365-Filtering-Correlation-Id: a9b7ca23-b126-4e60-5e56-08d5bcfd2de9
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2018 20:23:12.2059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9b7ca23-b126-4e60-5e56-08d5bcfd2de9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1982
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:50:25AM -0700, Matthew Wilcox wrote:
> It'd be nice if you cc'd the person who wrote the code you're patching.
> You'd get a response a lot quicker than waiting until I happened to
> notice the email in a different forum.

I sent it to someone called "Matthew Wilcox <mawilcox@microsoft.com>".
Also I cc'd that guy when I only started to point the finger at IDR as
the suspected culprit in that syzcaller report.  I thought it was him
who wrote the code...

> Thanks for finding the situation that leads to the bug.  Your fix is
> incorrect; it's legitimate to store a NULL value at offset 0, and
> your patch makes it impossible to delete.  Fortunately, the test-suite
> covers that case ;-)

How do you build it?  I wish I had it when debugging but I got linking
errors due to missing spin_lock_init, so I decided it wasn't up-to-date.

Thanks,
Roman.

P.S. I'll forward your message to all the recepients of my patch, to let
them know it's wrong and you have a better one.
