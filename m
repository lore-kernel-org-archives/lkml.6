Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750985AbeFDQXz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:23:55 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42178 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750913AbeFDQXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:23:53 -0400
Date: Mon, 4 Jun 2018 17:23:06 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: <linux-mm@kvack.org>, <kernel-team@fb.com>,
        <linux-kernel@vger.kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2] mm: don't skip memory guarantee calculations
Message-ID: <20180604162259.GA3404@castle>
References: <20180522132528.23769-1-guro@fb.com>
 <20180522132528.23769-2-guro@fb.com>
 <20180604122953.GN19202@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180604122953.GN19202@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:cc81]
X-ClientProxiedBy: AM6PR06CA0019.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::32) To BL2PR15MB1073.namprd15.prod.outlook.com
 (2603:10b6:201:17::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1073;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;3:aXhGIYcunJk8C9QtjKOOV0Fy4HTcl4ZwmIlcKRmjM1P/ikBC51lmdL+NIUHv4VHhv4fvhVIWDQGNiJrSZAPS1Az6X4/eBBZB34lZ7vnsCHeNzbSqJ2PPu8ro2Ab2/ShCk864K9q7pcEexQxYecHkeC4yHyMWxlUnYD8Oy1YxrERtn+A1hEg4hH+oearq9KydQuEHJYHaD62zwzramfF/c7D61bNdDpuQzIIPlavPJB5ssEBQhHjblmyK7X0qfrtS;25:LtO+TKQVa/eqj+h4Et5Ef2/3ow7Ej7y0T/35sE61w6kGewuLCxZMIG3AXbaoL1jsxhIKDeGrS8VnYdQLWbTpsyrupwoZkgEA7k8AbrfPj/MJ61Mmoj9HiwNY9OQnsBVzP4tishRL1yflgRPIDe0KK1e5c+Y9Ho8Fkems6ep8ovH4gpsIicrl6OMvNOdvwZNP2tfSvOmwaz6vaxbXquu3ze4FdAq2QFmDfP2+ExcTB6R90jtwxZGoo/4BI/jXLIs/isOZ7VPPBrPJDvbi4CkAoGL/EK5irsFtbwAAJ/wxky85/YBx55CjMzdlrENWdt1PuOr/2DZxIZcJ6kM4G2KG5g==;31:sa3hi7QZx2AKI0Zc55W/2GQW8LvXNw8IAUp3oAedoBJ/SaJzKC1Ba2fkVxidcngWNmR1735BjZz0xKMUq+HpCUYVsf032PLbCInSOppaz2b/ksx6b5k71nhQGKdQz9UrK4X1GU9AoeHDloo998nBbK0j7h1P9ng02c7x4EP6SM4p7OqmCy3Vj98uwuYOz8Pk+2gjll0IKcaGK7hAURZPJJ6hZNlryjU3DMCj9Y1yDBU=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1073:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;20:ZjyE0Z99224oDVVqLfFriqxT1SJVw6g/vPgaFbq47GoBEfP8FGgu02eZ6simP1xGQOL/s182jXQviVUmDoYRqhzZn2PBaSDZDhPKw9z+qdDfbi8rMjoqHPMI4kM/23SsCy55yE4xHMLUHG/C4VAoyw5sHlF7EocymlIky1yW8QQTF2vAuRs3WOVejjGDhItZsYK6yAyDyuIb/UvfhM/5PjwTSTw5fmAHJsKIVgy6f7HmhHsWirz7u5Tz9tGa7acvNvf4zBIsQxg/iI4+q3wjiqXDCzfBjH+ADsuN6HSV+zE2sKjhZUoOVCaXxTxqAj/zGXFAaYgXM88EdZq8kDxB4LJXJTsVqeZJHGYdeJTGoRjHSZ4xi1qrNtXQ0f+OeDnV4jEp0mNdDejwpSTo+EQYAoTPc+wpEVr+exTYba1XQ+PVc5l1yQcFuNqAaqw+6DkjGNMg13/jXhD6dU563IlKCwpTghv7jax8gsoJxCZBOWaP/0dbHMz16P5dcCXSHsql;4:IFoBBwt7cJnTxPlR97mLMceY2Tjbvb+0g8F6s3sjPUHCtA9GUVYQyQX95T5jdL15DuRKZE+LkFT37UfgMKvGku4XIJuOQPK9YvvPSPeI2EdnzuPY+VE48GJG1zPrbIjb0uzHiL1SJF5n5w3AOhMRmM02jj7Gm3hRH0QMonNjg9FXQpl77M+i/V68bvFaXB328H9qwAhhWA/dTNxKv7XjLZP9p9oXHj4gdIm8UbQEwNCbsmRfBbC5zhRHhkDHpPzY6+XUSWJQ4N4SS8I62ouCHA==
X-Microsoft-Antispam-PRVS: <BL2PR15MB1073644EBFA6F325E3AA1075BE670@BL2PR15MB1073.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(11241501184)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL2PR15MB1073;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1073;
X-Forefront-PRVS: 069373DFB6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(39380400002)(366004)(39860400002)(346002)(189003)(199004)(58126008)(476003)(486006)(386003)(52116002)(52396003)(6496006)(33716001)(11346002)(316002)(54906003)(105586002)(9686003)(25786009)(4326008)(186003)(16526019)(33896004)(76176011)(106356001)(478600001)(59450400001)(229853002)(6916009)(6666003)(55016002)(7736002)(97736004)(8676002)(305945005)(5660300001)(8936002)(50466002)(46003)(6116002)(33656002)(446003)(47776003)(1076002)(53936002)(6246003)(39060400002)(86362001)(16586007)(68736007)(2906002)(23726003)(81166006)(81156014)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1073;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1073;23:kNycLoacPR4tjLTNPvURTjzKbeUEyG7eSQW+0Nlfb?=
 =?us-ascii?Q?RcE4ctA6rydvn0amZF3d1745ZRy53FQs3jciJAS9O6YQ83q0zuT83pKZus0V?=
 =?us-ascii?Q?E98tsz0Vr/ZCptAZLYKyWdKGb9D9vlUOpyFDjwFCyA2TyxAKyBR0nEe5Gpty?=
 =?us-ascii?Q?ESWJHX1FsfhoitsgIoplwj0VbrF32q+YNMEYaJ7qwGD2LiyINI4gy0HH/SZg?=
 =?us-ascii?Q?A71Dh7cekrJwNfj+FcbvekOlxYgzlB/DrS3ogyvD5NZZWpAHKZdF4rICk5q5?=
 =?us-ascii?Q?Okj7+9gyv5CldqSxWHoyFpGGPaMZIFMGnEkvOg3FffkWTstbJJnoXbtZDbMM?=
 =?us-ascii?Q?7bUb4RbJ4mkJrLmWq4AAy8slpoXTsbgKY4nfgymSKfAZlcYHbaskBS8oNolh?=
 =?us-ascii?Q?1Ai1dJlY8Z4S6h8Qlyap7k0Fd2X1DK8SdI1P0g7Fxkwvj+We09pOq3NXqx8K?=
 =?us-ascii?Q?XRcLIaA3pRFVbOcfU14lX9EROlfOWU+/48/NWI/q7ucDrT7d8Gz/OE10Q9yl?=
 =?us-ascii?Q?uOKEcWg2nEM++k8SR7JvwJjfwMqDRBFOApb1ttuCeWwQ+PkNHFJOQIWr/F3I?=
 =?us-ascii?Q?1Jq0tQHWAM5x/czf/DBFyjLDfZK48FYY8F9IYVnq33rFRvXclDthPwpunCfG?=
 =?us-ascii?Q?GxTeT/UXM9Q++yiYjPV8yu5HMQleBkgF8v5UiQUM38Ifjc7sVMDUKrOM6JI7?=
 =?us-ascii?Q?o9QDBEMif+7ZrPH/t9+QEGZsMgCM1Xtji4CW1uU5AjOh+YxSj07Y/fVIDNMc?=
 =?us-ascii?Q?5Jgntjg+6LFH9PxTvpFVLhTyEG0G3Vt5y3oT6s4UR7GL5jDMIsr58D8O3JbF?=
 =?us-ascii?Q?noFYzwJeMsb7qVFJMkeHZd8qryOxhafPpu2eNRdvigR5o/5pkR0ANXhtQjeg?=
 =?us-ascii?Q?abjjAoTFMMGJplFxVXnmkOmHNCIQTTwHD+U+cX80+u0IgtMwoHn3nZRDRpVG?=
 =?us-ascii?Q?N8eMEbs9/S9QNECataoxrsiSLJ9F7/pZFDszj9djVyZ084HyWpI5Iw9meZG9?=
 =?us-ascii?Q?lLbu3RFMfq52zEhH+V4BhE6Nb9mC1tYUyBQ1ArKZFpCA7FWrKm2s0fs+xECy?=
 =?us-ascii?Q?dTPorobhPZkDVxjV4gnsQXrWuC3bMCtCM+BiTjF9zm2siTOrtkhewigBrrTj?=
 =?us-ascii?Q?+yMCHiIiHFksVft29HjNYo39GeO45L54bnwfC00wLmCMu++R6tA3PPPTO1UI?=
 =?us-ascii?Q?ITesFNYM4nLbhVzmhg0Pumqe/SnpRCwS2hU5oJM0djjceoKhyFrU0NhpvP9h?=
 =?us-ascii?Q?46D+Z97rqDFYXhLEAoirQW0Sz/5+rZSYW5uKTmv3PMhgMYynKSZNY/uuFSEj?=
 =?us-ascii?Q?Y56eo0wHcbkbSDc5rSVwANXPFyJXPMZ82OlHyA7D9DN?=
X-Microsoft-Antispam-Message-Info: Crz6S7ybmnm3OUr4+Sau5YPjWgqqJbQVVIWAmOJSnz1GCVTjCQnPMVsDr7phsF5pjyVgrUVUWNm1KGhQr6YdBG7rMnEAGwOmNObEhTdgrmooHMFNrXUJ9+gyE9VM6k6YEfTrre20l/Ayn6dMLSbp+AGGeU26yVkE+WIrXtSJ1mI6mNYY0KbMYs9Vc0BCpfl6
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;6:eSytyOAcQHet+USg7rtXO9Y/IfX4Yx9LYjk6ZSfsiaI81RO9AGEoNYlyDEFiA/44eg0WPomEy4cnHfrsWv4dS/Kb9rMysr/bGFs2B0QwDLKLsugD9hwqF40EUMjprc36PiPu0mn+y+okkJSMVOEIvyCAjI64ucf/mfdpkUmBMM2h6UfNtO3tYds+en9P5YwE+xtpBOfeyxofW7dTPWV4rBUp+p/jINqu2HRv7NTIucm7CvHZoK2NGa9yvW2AzUNBD2YGuiuWGCQ/gPiLhCNnN6hx3NLRlDUrux8GNyRsMh2E2BdGZOLmI4m+pfYLoh5aMQYCTvzQdZEfNC4iqeetVt11CTfb4O5TYajSc/VTh+qHz8rb3ItjlWVtWyBz9CJGAYDPDpgvFuFFlP3khVKSpSk8oo6jZ4kFP1AHmcNLXaAIU+aU0U9i/W8nVIz5CF0DyCph4M1y5JdEZH/Q5uj34w==;5:3HOI47ebUMI4UoUjqahQTRjNFUjVzkt5D94MYq6VTgK6einJX0//MPDSwZpasyDWgchjrViU9a7Msh5J+hXKd5XVfTDOp/hGfHQtHgY7M4Vh8OoblzQea5KJu0XODtR3xdwk1SONHfaznUV+5QPi8AfoonAa0y5JVWRQrFdSw5U=;24:RnTfIq/yxrv+syGPUa6EiUorhIlF5JZ+x6HbL4eqz2f9Ocfz9o0Pz6uO9YgkyQJn6MQyNSsae9vJ9WRw3rEkPUKToiaGtCdaT6KFABKXz3I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1073;7:4IhLoJiOJMgLk0fMmlFDqrElahpHQZbGbVXhVde/9q62a10HRUheqy+mH4soc/8UF4gWchR1m/r9qTi6Ar6at91MuY4oM6HMMHfK7w2VIkGwC4U15TJGorqrbwFyx+f/FEEy+AMFFDezODVgzFt0BHtDpNtldPqG97KwaJvqLU94yeNOEba69av0CiIyVCTuEefiIwgyOHjS8GturgnOoWV0bVegb5be9hkjdBSACxveFVX1kgGLWjZPkDBm48S1;20:hrWSAifVokJgWXhRhAiznnvE0htHX9cIiIsk23wQuI2HM2uFoOreacMYHjLYMHv5+mfpxoSMlpmQ0vaNDUY24JVs0JItV6iriUIkz3t9gyuvtR/FNYpvX6tPhLVTXWh2zGazYfW7hxEvBfPdy610KGcQZTsqUFgX/mGotVFbOAs=
X-MS-Office365-Filtering-Correlation-Id: c0af1751-83a0-4a50-1a9c-08d5ca377aac
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2018 16:23:15.9310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0af1751-83a0-4a50-1a9c-08d5ca377aac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1073
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-04_12:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 02:29:53PM +0200, Michal Hocko wrote:
> On Tue 22-05-18 14:25:28, Roman Gushchin wrote:
> > There are two cases when effective memory guarantee calculation
> > is mistakenly skipped:
> > 
> > 1) If memcg is a child of the root cgroup, and the root
> > cgroup is not root_mem_cgroup (in other words, if the reclaim
> > is targeted). Top-level memory cgroups are handled specially
> > in mem_cgroup_protected(), because the root memory cgroup doesn't
> > have memory guarantee and can't limit its children guarantees.
> > So, all effective guarantee calculation is skipped.
> > But in case of targeted reclaim things are different:
> > cgroups, which parent exceeded its memory limit aren't special.
> > 
> > 2) If memcg has no charged memory (memory usage is 0). In this
> > case mem_cgroup_protected() always returns MEMCG_PROT_NONE, which
> > is correct and prevents to generate fake memory low events for
> > empty cgroups. But skipping memory emin/elow calculation is wrong:
> > if there is no global memory pressure there might be no good
> > chance again, so we can end up with effective guarantees set to 0
> > without any reason.
> 
> Roman, so these two patches are on top of the min limit patches, right?
> The fact that they come after just makes me feel this whole thing is not
> completely thought through and I would like to see all 4 patch in one
> series describing the whole design. We are getting really close to the
> merge window and last minute updates makes me really nervouse. Can you
> please repost the whole thing after the merge window, please?

Hi, Michal!

These changes are fixing some edge cases which I've discovered
when I started writing unit tests for the memory controller
(see in tools/testing/selftesting/cgroup/). All these edge cases
are temporarily effects which exist only when there is no
global memory pressure.

We're already using my implementation in production for some time,
and so far had no issues with it.

Please note, that the existing implementation of memory.low has much more
serious problems: it barely works without some significant configuration
tweaks (e.g. set all memory.low in the hierarchy to max, except leaves),
which are painful in production.

I'm happy to discuss any concrete issues/concerns, but I really see
no reasons to drop it from the mm tree now and start the discussion
from scratch.

Thank you!
