Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeCNMjY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 08:39:24 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:35586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750905AbeCNMjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 08:39:22 -0400
Date: Wed, 14 Mar 2018 12:38:52 +0000
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
Message-ID: <20180314123851.GB20850@castle.DHCP.thefacebook.com>
References: <alpine.DEB.2.20.1803121755590.192200@chino.kir.corp.google.com>
 <alpine.DEB.2.20.1803121757080.192200@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1803121757080.192200@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:aa00]
X-ClientProxiedBy: VI1PR0902CA0038.eurprd09.prod.outlook.com
 (2603:10a6:802:1::27) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 39f3eb8e-a465-4910-263e-08d589a893d9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:nDzPawswvMSBbpIp1cP7G8EjiCDjz5WjpscFlepMSaqc33DCSJsTkT1aNPzVaEH2WmK8cdsef0ruqMHK1ayL7Tkri2yeHin3LbdAbvSFfzAdorg6TFDWatOcmqcvuksF9YVOgHMF6dxVg60+k7t6b8E+xQT2SoNTt4Z4xIbWVHhEBRm0GWZRg2obb9hYsExokQBzPr5teutMdIhZU+cVSf2c9Lv2we9iKQ53yIFpgsLxCXpkpFxIb4UDrJxdZDn3;25:h916w7/e5n2uC9AiriCKHRp+n5RUvyFxaY0tRvtuxuAsk1UTRgnvX8VpX4t/pqt5OqQV6To/t5IyXTZqPugH/WeYZuUK63eZ1c6cSOx/YhZcH12lwhCI0LEzYUSB3r01IbetXFoAhLLLlq/Ck+UCko3qtBjPE4IpF8sqAOY7RaVzhvzYhJK8gihjLRbxUiBVDAUIeH0DYjzAuenPMho5GbWslA4ZFOPWU2heWvkn0yLNwYfFPsdaJGoyAd3rh9kb21kd+Ii2RtCu6an/RheO0comm5o7wE2WtBtFPKubNBu5LVrYqWO0/Dauq5D8miBZRJlk8cAMDEdtw8MhMQ4joQ==;31:zBStBBbrrcRzEkuCtNvPLtna6k/IzazmdKUSbFH9Voll3Wrb3ySOexsUk0RVgLaOytrYHvM+3WOaGlA3m+mzC6iXH5geOxJ8O39eCOy8y2D217qWhLiDHZn95fwKK8EFlnjboeNvbY69AGVoaX4YLnxnTNBtbuCmUur0vMMr3VapewuDbtpn4ln+t1g7es43pcLU2+coKKuBSAQG4HDpPUZx2niwhVcEVVpDkO8HYyg=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:BPnuU/0YNipRTCTPHI1W+JTHNodgJjSGX0ahdECSVk7UdVLELhMkXUwe5IaAGNjUe8obPlb3kAa8G4GbPtmo3chpQp4tWNJQkxnN/9RtaTyVocIbm8Ll6k8+vQiorcPpxlTBF3GjBDomk6bonngaNpAFoewccbT/QSsfTVOmDo5Wswl684hraNUG9NeWnhlNxMclqtlvM+I4gK8G9RAITbTvjfpgjqJf5Ic+o8/QUFxnQgJiDhbqjGB6tDV6MRIwJeb1iIgkRLfPlM9u3e/ZSdp6AmnlmbK3DVcI5MSCikOwM0ra4AJiT68nmsSTn4gxpY/UyY+NOn1a4xSRxaOgqa51ezgN8UB3CayS4vCmDWhIOraoQIAK/LyLWXBg6wCrvn6GNfGvnguTnr7D5SfJ1e+a6d2hOujUERg3uUHAT7Nd0pUAAFUvI8fPwfW4+A6muQyHWINLcB+nWAUDud8rok5ITTncnSzbby6l53wt9n5Lg43UgebkYNajnmPiv379;4:4h8V+f6xWUIryH/C9timLGZXetMJKH7/0SE3q4N/njK6QyMoczkee+/z5Ni4I9vZ6DeegNdvoDDhmlv5SpzeMFY+q9NZvzeBGtNCbH92svKwd4xeMKoE0GkCwZkAJh6rnJbtWfZ/fDqlvb+dc3apR9Jg7HckPDdKO7QgnFGXhhZHQvXTtn12WZ0qIyOM6LnGBMuM/21eJ7B3nKAuE5wr41VkGoMZzs9pBQYIlyojjSZzNpnv3rABqhsixC9/Y31mKp6hUMMxcRasYViYXtRmsapvOAr52r13Jh0dSHWoAI5SLQTGlqzQP+/UFwOOFBPy
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077DF9F83F9815BA4B5CD6EBED10@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 0611A21987
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(189003)(199004)(9686003)(53936002)(478600001)(47776003)(55016002)(106356001)(2906002)(25786009)(4326008)(68736007)(305945005)(39060400002)(33656002)(7736002)(6246003)(46003)(6916009)(23726003)(86362001)(1076002)(105586002)(2950100002)(54906003)(58126008)(97736004)(186003)(316002)(5660300001)(16586007)(229853002)(16526019)(8676002)(386003)(50466002)(81166006)(7696005)(76176011)(8936002)(6116002)(6666003)(52396003)(52116002)(6506007)(81156014)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:86DRFsOCJ84PxZe8hWPXAxH2IAFf4Q7wZxkherRdn?=
 =?us-ascii?Q?Gy3o5+U7fr8uUOrjnXBP3IzKM7ROOdqApWZAm2I99vHGsYmUSjNcS05ltTQB?=
 =?us-ascii?Q?svBosACnUmoXaD3jJFe0Bj59oLLv7epuvX9dhBVqzr+XR9DIOj7ui06znFQg?=
 =?us-ascii?Q?3WOkurdwo7uoxDMqKPfMgT0vyqq7dxmMtnQ0hfr8WVm46LoXgtwnhsMip0Vn?=
 =?us-ascii?Q?UmI02Z/o0ys1uhn8sSaL0OuqlCrp8W8HHIbqHEiRhHAQwNsnoWx+wLpoVxxF?=
 =?us-ascii?Q?woAP6Tt1u+iuwSYbUA6CdNXZbJhJTPR8CKmETYZqi0pFsh7ws6lwBCtYckOM?=
 =?us-ascii?Q?PFvEw0fLVjxpD5DW7s29bC28g3H6xBjTRl5XGmRosSOlbM3ruE7ck5uTs/RN?=
 =?us-ascii?Q?YkF1vEbV6TXKijZFBHwE/ZmNpyIluTH3SLMVsapCgHPT1P3+goPycVFh8MRM?=
 =?us-ascii?Q?3g59CCY1IlNb3NXeyuTRsJl1G99xtDgCHfqJW3klkDDwr6kT2mOy6D70QnRH?=
 =?us-ascii?Q?bd+/pMZq9LsAAdGwDEGH+96Ey1cnmzriescU+cPGvEVRIBcEsE+57pn22jVJ?=
 =?us-ascii?Q?ETwV2dWu0h7487pwlpuEkPKWcU6xd1vWgKYaH9q5aj91ruPpNSMZL/tuZenH?=
 =?us-ascii?Q?QUYjnM27aBo5CCni/v0KyKzlusmmY5yMVTHimuSnljuZazOl3McDpSYY3dhv?=
 =?us-ascii?Q?d7dI+U6HED9Zf/TwBAUGrrMMckEho9pRKHneOab9e1TPff3M2OfmpewmbD7D?=
 =?us-ascii?Q?17Kw2J9GiCcVOoycH5insoGSV9HDVpYHNZ6SbFycTExGMs1xfHe/njvazxv9?=
 =?us-ascii?Q?FOE7D1I8+CChYl4xsDI/DMfHGJj1AEwV+yNuD7VKz2jAioCvqHlwohFp+wRM?=
 =?us-ascii?Q?cEN3Eg0cEmAgmMlHP9DHRBjtS+m4MGT1dMgZK+Ten01EbUvwY5aGx7bE1ZK+?=
 =?us-ascii?Q?J2WA5coHYBSHKOE8HvWRXFDlQUIhBCIUagnsdB3VOk/+WIUHlZpcOWccGkau?=
 =?us-ascii?Q?4IgKM9IXaD/lkYwk3EiXKQsZpHWDw26P7J5uCixwYIMyOmx4V59IBVgcTu+I?=
 =?us-ascii?Q?PD3tZYVl3ZrOiw0+YOI9ptSSp6tuvvWzSHPfEdOefndmM2+W6ebHNd7mrXdi?=
 =?us-ascii?Q?hYIbI9OOokhXhdceNJof7geKyjGzbyM4a8+rHcnCduCm25uvrZY7RkLN7eot?=
 =?us-ascii?Q?MCbcVNZoYl710h2j25NJObSDrc6FE5bi86pwRF3HZ4lg1J3JmI7FZSKOA=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: +MzEjrfE4CuMHOsIB13dpCLSCsuQ+KMYjTAlsUr6coUdWoznGcEKt+YuksGvrf6+R9gG1kbdwgoR2Y0uVc/I0iYqbNQsVs0C8colZOt6sB56jvcpn7lDWb/Bgk7R98WZV4Oqzc39jM4YnwIjtiAAYZw/RS4D2Fdezrwy4DusFgU/8h3msM48tUKbStBw9V7b
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:kZBBytN4S3jU1o5dtTXVNGjgMQOeKt6OgoFZ0i8HDJs9BCAzFxwVNp/mp3pvA3xOcevqjYYQ32ll9Z2XigA9ULLXizKVuvGVwQYO13Lry6CSP5IbaVop/qSJS0nNbbBoHbexY9Z8vf79w9iYp/+GF3Mj05oSN9fX1MGqJ30mcirYx1U8SxLZM3tLTxBzKZPRlajqf1JN2p1iscfw6HP5pcCCKhvTWTqV4mkV5ZOg6evizsVKObRsqIusnR2fPwOzb4L/VPlQO2rMmopoq3OSqxNAppIgI2Aom5m81nUuXM5nnpXy4npWIBu6R9uw0LRIW9/t3vAhZ+zkcLIuALHMMGz7I5YfR/gSQiRkRHr+L5Q=;5:SDo2XyA2ESlHp62QAn+r3Ie0qGrpMU2/9WKrI7onVS37oKyzKVHRzcFig5i/FmbVTa+xDfoiz6uRE2O7S1OCDkSUWrzc68lt3Zppbgx24uEpghNsPrRff4iMF9E/CyeZKC5xzzsO93gIU3+W+RH4uQBUwxMoJfNMim/GI42jPs0=;24:mIqpK2YH7EIKpb4cTl0BxwcnlGgPHh2S7IDlDGh3cPGPuW09qQQwCyUs3Eh0GcZtWWWMs70l0kkqMy55gaZpSP2U4iV+fAPc23i9Gn06Js4=;7:hk3bBHWv+3d0y/XP9eUGzNjYMB3weDpR/DuCT/ods5uRIMI9Ep10tcslPJVnLUbjZGNNO0gL2oYcqKAxbCpkuUEuNw8SGuVu5hPuivE+JYmKKYwDcC2sycbOOeBzDlHNRUQCRt3nvwzMjolMUa2tXYolyELWZnMsnA2xni6wFiyhlxw9FyF3V2XjF0MU4a+KehX4IhmwXAg86+KfXAgOg7WG1XAiztIB4PTPlUR9hBW+IKEdZVdvXO2eRGI7dTlg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:9zBVDDDQlAizESkmZvD0wOJU0ozANfFng47jzd7+aWyd41dki1KjsdneXZcUhD0mUZPe+JxmrFw8AioTRCkrdr1DCIqi1UDNWpKDntocpHKolrfMS/nLyDONLTchRpTwCgApNnvi1MCvkjNryDXokp45X5dG/AENyP+Js083aD8=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2018 12:39:04.8441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f3eb8e-a465-4910-263e-08d589a893d9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 12, 2018 at 05:57:53PM -0700, David Rientjes wrote:
> The cgroup aware oom killer is needlessly enforced for the entire system
> by a mount option.  It's unnecessary to force the system into a single
> oom policy: either cgroup aware, or the traditional process aware.

Can you, please, provide a real-life example, when using per-process
and cgroup-aware OOM killer depending on OOM scope is beneficial?

It might be quite confusing, depending on configuration.
>From inside a container you can have different types of OOMs,
depending on parent's cgroup configuration, which is not even
accessible for reading from inside.

Also, it's probably good to have an interface to show which policies
are available.

Thanks!
