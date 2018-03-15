Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeCORLS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:11:18 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:36080 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751559AbeCORLN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:11:13 -0400
Date: Thu, 15 Mar 2018 17:10:41 +0000
From: Roman Gushchin <guro@fb.com>
To: David Rientjes <rientjes@google.com>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [patch -mm v3 1/3] mm, memcg: introduce per-memcg oom policy
 tunable
Message-ID: <20180315171039.GB1853@castle.DHCP.thefacebook.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803121757080.192200@chino.kir.corp.google.com>
 <20180314123851.GB20850@castle.DHCP.thefacebook.com>
 <alpine.DEB.2.20.1803141341180.163553@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803141341180.163553@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:b057]
X-ClientProxiedBy: HE1PR0202CA0030.eurprd02.prod.outlook.com
 (2603:10a6:3:e4::16) To CO1PR15MB1080.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dde53080-6ff9-464e-78a3-08d58a97b6d1
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1080;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;3:2byCQ9hEFp2dpck88Qos4fVoKG3bm7YSDGXUR3Gr57tyJv+8YbObenDSy6Pl9Vz70TMpW+rpfYTwVo403FP0KJuXF3xjn0SVUZSD5Ql704OIISbQgL3lFHWnfTOWHwtFiG1PEbAzRF/0N9I2aqVno6yJRoE0ZbPVhGTBELthRwqJM2NnAAJpsEARV6qwSLrZpqyXoXZRSUY/EaC/0fLyLWxROzNfIj1tac/CXCrznB0qKCpR56y2pRUKJX9fCHJX;25:+92MB3tzh3Lq+2BCrSEQdStHcg8Y8l1EzKEpRtOJi3mSqmZiOu88ZTfBcTigF+1vLYybgzjo99a2WAACiXSgfSS/Kq5YUutLBi1VhYFpP0BA2womG836no36aQ8GNanu80Ni9C8P9VD9JIYVu64jhl8Oh4Jti8JloM+ilaSA6y2i3um8Y877TYuylRSrjII6Dth+yhRxoN79+HRCfCDsn+zswcFbWn/Gq175QXkDqnub5vj6UmblXsNSk00apDYVekjlFLpJIPzDgEclOda2OiQGoWt2GY0y9dvE1KdyOP3V2M6zzr34oZvZQr5E2wx6fKw0ZJNKkE6Jk9lcr1XKNA==;31:x0GHQC+WaQd+U5RcyK4hoHBh36bA4zfzLzjMaYZCjYVKdn1KNgDjFcUO6a5GJXnAKI9a33RrBo30+zyR/evHIGmk7+Bq1pxhtgcvSyxru/T4JAaydbe14UXIOEi6KqYL/8ji6PnU67FoTuc83Xdn+PxO8gjtzHmWVCBsVx7HBBARQHZPJh8ybaBXdG+4pn1TeWuVorEH0erXrEOlpD2n6OObGk8eCa4Zzu82m8E6Fxg=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1080:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:tfR5XVdBYaA328J51NHac7q1qEZOzcbzNbFdWfW5OQ38IPA3OJwrgeJjaO1NF0ta4EvgslvVoADdaFQlfZfN06nC5YWHtNu7/OAO/3/V7jtn41HIR5E4RyFjiuAqga7wpj5OWj4bpIF1XRCxBgBRsHFUbPD/fKHEkhBTBNJO+Rqt+uYR9WnoAWArEyXLcddR99T8Y0sRSq6mTyyoXHV3SFqLzqpUQ7/HFQYFjAvmXtgUenNPQvvhjpWHz6FF764a+Nxvnraz9MyTCgKrSkmv3K7lPPdfYg5tXgBsZbpChQm8CD+N78KdbnuW6tVrTNq9bLW5rVXCLD1ZqSsfQ1pI7qVVliPBmG8wilxWil5eKuWZKNV2q//zMsNLjpNC9qS7i8p63VK6Uo4JI+SojIgbpNn1xA1+4lojIvohtlCmY9o+ODJIQB7g77KXoZk9FuUfe8bFZldDihsegC379jMK4pxMS3J7LAFpqrGBLoeOJMsg0mRwDyZU81+Ji+w5Coms;4:7DgL2Y+goofE/xdK6AMb8zoEY76rOuIKY9DOkqZTNM24DZFV9glfe/+yQJBFc2lhF3w6k+h5ZL6QFj8T1g/p/lktaKwDzrI1T+QWpKYazwwpFo3FpHz7PcqRDSrGoMtB1KjVwlVlty4cOpP7KiYBt82eZFdRJLxlN95Fz9xRH/oQBiC9xvG8OJ/B/keD9nWOvdSaqpfIFYWHnY+V6MyOmiuBmKzNi7crM+H+gadjaCpkH0Vj3dmwdfeiXpcR+q6CeZi037Vgvj2Pk7Iy9RJAcc3PyBxxxfkFQGa1QH7cy9NREywUM7FAmak365pSAWIw
X-Microsoft-Antispam-PRVS: <CO1PR15MB1080B121AB81D43155EBA143BED00@CO1PR15MB1080.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501244)(52105095)(10201501046)(3002001)(93006095)(93001095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1080;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1080;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(39380400002)(189003)(199004)(478600001)(7736002)(106356001)(305945005)(5660300001)(9686003)(316002)(86362001)(54906003)(6116002)(58126008)(55016002)(47776003)(33656002)(16586007)(6246003)(23726003)(1076002)(39060400002)(53936002)(2950100002)(7696005)(25786009)(68736007)(6916009)(229853002)(16526019)(4326008)(6666003)(52116002)(97736004)(2906002)(59450400001)(50466002)(6506007)(76176011)(105586002)(186003)(81166006)(93886005)(52396003)(46003)(81156014)(8936002)(386003)(8676002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1080;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1080;23:1WLT7JZG//ZDan+OUayoHws+J0CErzIwwvuxO7Iyf?=
 =?us-ascii?Q?Dl6zKt0GLrw05u0Jx6Ex+FhuKEyuxwpHXnCGX2Ez3kGqCmwuKD0dr3VOXQyo?=
 =?us-ascii?Q?aqiWTkSqenuQX4kngjYomGTKYmZvXcNib1Fd8gYHQOdx/RJvR9h5xtnhfJ5G?=
 =?us-ascii?Q?9CHQ6T7kx+ZjQO397DtottcFwdwjVm776KdWpKgiR6z6K5Uhwcav8m5klJAp?=
 =?us-ascii?Q?3LCA8Fq0sH3Ow1PkweIw4SmgZ6/+FweYruR06Z9cYKzf3NigLWwGUbcmxv0C?=
 =?us-ascii?Q?hs3NqwJFQGaj9tfIb9eKBQcHd8qK3pg/H+r861rEhbajHPPmp7Wo9IjTocIr?=
 =?us-ascii?Q?2VlHoVCm8dzPlbZ8OilsJxCn6LhGrtu3QhP0fVlgoVrtdx9giLK7FZI/Fft0?=
 =?us-ascii?Q?CVlXdAJcgLRYHph0hDfB9+7QqGqDfYY/3d4wIjhiT5s6umy0gvz30CBAXSoZ?=
 =?us-ascii?Q?yU0+mn1pgMm23+tsbJ0w020rWXGfOjS/uFS5CLnHOrF/bWkdGo1ykEFQGdUW?=
 =?us-ascii?Q?zFbvHkTFE603nqhO3vNxcQ7BybjRKGoLPb1Jx2u7ger8BnBLOqeUkIwEOk/t?=
 =?us-ascii?Q?4y0wbyat9r9cc3CLkOFi0CmEpW0ijBb8toAp4QZ/0TScUgTjPKKdR1IApKXh?=
 =?us-ascii?Q?f2VYpH/NE8yjALx6c3STCDFlU26mu/+OD2sxkIqUW7/jytXA36LwCc3XvaPW?=
 =?us-ascii?Q?rq1FDmD7FdvrSvIbUXA6FStIkVloDEgcVgxP1ePvRwh3zPr5l/mg+2ONLYC/?=
 =?us-ascii?Q?XNBkSTEXHuce8DtD+AYlIxIkguvkwZKBPRMMZ6ZH4Ynm31GxTY58nK9x8H8U?=
 =?us-ascii?Q?Z9cbFlAJgbPgyi3+5hO8HdUHi2O/rpy6rxwcx+cWftHKXvQyOdQ7b99Y24hP?=
 =?us-ascii?Q?tjQCK1NUJhCIL2cpEPebwku5VugtPt/Zm9f7R8C6q60KQ3Nr1Y5Vh0XlvqdX?=
 =?us-ascii?Q?Comsxppd/dfJrmfnCcvmn2Ydt2JgVGDVgJdNi434R0lHUi5RZir/JCpP0OyV?=
 =?us-ascii?Q?wHTaL/MqvhGO19mwObc1/K+W6NCdLiP6S8Fb1WaaxV7ptoIzyNAUpq1p3tlm?=
 =?us-ascii?Q?0QxQ/4CKBD+mTKPVtrF3ZJr96Zqh/cTZLsqzPxmQQBx6al9eSX09IHe1mM52?=
 =?us-ascii?Q?SrWPpXkFkq09a8yoj56DUmK7Sh0cUKf2m44R4pMgmDchIX5vixnQjgITkts3?=
 =?us-ascii?Q?u+2uDH2KgaOg+hWDMJfEdKvxdeyyEMkA8IVGMj1Z5Qb1hxH4dwSfZFyPbEej?=
 =?us-ascii?Q?o6xhr8SM6mrjOCdd8wl0yPEpLdUPZ6iukm0m7sq2NnFGGvOLTRl075tZ9Ooe?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: xD0zKWFscEGsPdVvit+bm5E/8tAY/y+uzHyNVNP5XADIkF0qcBhdr23TEgNHCbh60BS2pwxi5jBNZ7lzv8uCX1uBI98XbqlrBBHrGu2l/8WiX6HY719D27L0hTRqYB3vYvcBh2xcCTI4c277zIHvXRFT4U74YxistW5kOTfrAv5RkPAwWVEwx1K4cc5VVLaw
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;6:HdRxLk5zIlFH8TV166THRUFjA2NfUXC4ZAdIvdxO6yzfeZ1RTkIzA/Nxj4JGa0gXb/8kXjMcXHfmgqv0vXo80Oy/E3+Q8VovnBaqh7W/3seqVxOBK+YMU0YFAAukz535v1DA30ZoUhmDjl0EpyoNDU7EHSegwOjYiP0aXQzrIQMn86RP0os8HdwLEeDZ8Fnwva5x2aFMLe+RXupoUn1uKHyOxNDohlcKAimtTs9TiJPKiBbU3HY4zQdflUJf4Afu2boz7MuG4qEZCY6I28jESgYNRbu8a6ZWIYS4ebthyEdpSmh7zL805b2CcgtIS0f4Zy2TCk1eyUg5PfVuohZ/JuBF4xHC0TCT4LvPkyA4CZk=;5:xyY60zMdTcjIqfnfguQpsEgEm9Vzp37eR5quYd8kUwUe/7xWFKcVbO346Nteb4hmqm9L3ur8YrqfYJIxZw/0Lq8Vt1SYJHRQ010h57L+lmlMLMj7+jBc/ZkX4NI4tiJ3m6/iRYwM8+dF/DfFe6mj8iyxE3HgTgUVaj68MvhWgXw=;24:dvH4BCfdQl+oAStMQs7vaJnnWiL4kmn0V8X7+CtKEpgRVvwVyBVLyNQ8aRpGRt/Pk3Z3EE+JgGzVxvHB8DujuS56erOuwMYiiC3GHXUPglo=;7:CoSjpEx+EIjv9akKJfKjvvmLVtzDqo2laJGBLBZIW2+DyszoVguQNrAMkda411ClOvgZY4Nhk4vJ78grgsm+jhzOGu/BsHtzUHlii9zbeiktLJDWA6yEba3vXJR/7y4p3HBMJBClLt1a/tGuR99rTwIxkhwXXo6F9UvqHiHawI7wT7JHwGCh8/xTWbJCi7bKL5sOBOQaL9VgUgx1eewd7Sef08ZzQ+ftw02ACQHTVvDM8pfg7sSi9y8I/w56eJGk
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1080;20:HYfIITvdA6RJlj9FyeIxAWEXX4UaT3kYn2cavFukWx3SsWBY8dApWWltkQzPQAThQiEfzyG5CcM5R95605NqMTET7MOYdVRkaGERQMY7LZ0f+umXsPuE+rzcGaQOS22QZp86RmdK6GNSyIYMbj2pPjGilmrCu/Ap5U+KkhTsYPA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 17:10:52.9668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde53080-6ff9-464e-78a3-08d58a97b6d1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1080
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David!

On Wed, Mar 14, 2018 at 01:58:59PM -0700, David Rientjes wrote:
> On Wed, 14 Mar 2018, Roman Gushchin wrote:
>  - Does not lock the entire system into a single methodology.  Users
>    working in a subtree can default to what they are used to: per-process
>    oom selection even though their subtree might be targeted by a system
>    policy level decision at the root.  This allow them flexibility to
>    organize their subtree intuitively for use with other controllers in a
>    single hierarchy.
> 
>    The real-world example is a user who currently organizes their subtree
>    for this purpose and has defined oom_score_adj appropriately and now
>    regresses if the admin mounts with the needless "groupoom" option.

I find this extremely confusing.

The problem is that OOM policy defines independently how the OOM
of the corresponding scope is handled, not like how it prefers
to handle OOMs from above.

As I've said, if you're inside a container, you can have OOMs
of different types, depending on settings, which you don't even know about.
Sometimes oom_score_adj works, sometimes not.
Sometimes all processes are killed, sometimes not.
IMO, this adds nothing but mess.

The mount option (which I'm not a big fan of too) was added only
to provide a 100% backward compatibility, what was forced by Michal.
But I doubt that mixing per-process and per-cgroup approach
makes any sense.

> 
>  - Allows changing the oom policy at runtime without remounting the entire
>    cgroup fs.  Depending on how cgroups are going to be used, per-process 
>    vs cgroup-aware may be mandated separately.  This is a trait only of
>    the mem cgroup controller, the root level oom policy is no different
>    from the subtree and depends directly on how the subtree is organized.
>    If other controllers are already being used, requiring a remount to
>    change the system-wide oom policy is an unnecessary burden.
> 
>    The real-world example is systems software that either supports user
>    subtrees or strictly subtrees that it maintains itself.  While other
>    controllers are used, the mem cgroup oom policy can be changed at
>    runtime rather than requiring a remount and reorganizing other
>    controllers exactly as before.

Btw, what the problem with remounting? You don't have to re-create cgroups,
or something like this; the operation is as trivial as adding a flag.

> 
>  - Can be extended to cgroup v1 if necessary.  There is no need for a
>    new cgroup v1 mount option and mem cgroup oom selection is not
>    dependant on any functionality provided by cgroup v2.  The policies
>    introduced here work exactly the same if used with cgroup v1.
> 
>    The real-world example is a cgroup configuration that hasn't had
>    the ability to move to cgroup v2 yet and still would like to use
>    cgroup-aware oom selection with a very trivial change to add the
>    memory.oom_policy file to the cgroup v1 filesystem.

I assume that v1 interface is frozen.

Thanks!
