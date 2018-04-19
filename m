Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeDSKo4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 06:44:56 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:48674 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751840AbeDSKoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 06:44:37 -0400
Date: Thu, 19 Apr 2018 11:43:42 +0100
From: Roman Gushchin <guro@fb.com>
To: ufo19890607 <ufo19890607@gmail.com>
CC: <mhocko@suse.com>, <vdavydov.dev@gmail.com>,
        <penguin-kernel@i-love.sakura.ne.jp>, <rientjes@google.com>,
        <akpm@linux-foundation.org>, <tj@kernel.org>, <kernel-team@fb.com>,
        <cgroups@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, yuzhoujian <yuzhoujian@didichuxing.com>
Subject: Re: Some questions about cgroup aware OOM killer.
Message-ID: <20180419104336.GA20675@castle.DHCP.thefacebook.com>
References: <1524122224-26670-1-git-send-email-ufo19890607@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1524122224-26670-1-git-send-email-ufo19890607@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:543d]
X-ClientProxiedBy: VI1PR07CA0193.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::17) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:96wwq+hkxxHT64ZuftjJfmDL7GukivgzG32/o4iJ6p1YBSa+QTwgYPk6ctGVqxs9ZJPgjnrq4Gk4Pb4MQyoUC5xCK8Kpjk1t3jKVXQ+t1ttxR5ieEjh4JtlKpH9J30rT3TwAr0NY7RsA3gyO4OW7epqhjFPOcJ4VIa3A4HIA38qKAzK1A+ZzRpUNDLEF6Jvh5wvMv1/h9H8ls4wd1S5rk3sH00pHVS8n0YRwpR+unCGZxMIFONTqQ7Age0xcxyLw;25:mqGRpYylqVfJG7kGP7sBYHN6tBQi8LfEaOoAn81oZFAHst3t8GxUweN+cJwIzLl5sDPLNv5s4zjqGqz7Ld8dgVLOd60GWEaiZRZltAR+SEv/KPsltlGfjn6LxSznJrdvVMZzhWAW7Tw30J9pbtAs1vrYgXEtqpQ1yQ0/bILYBO8O6DqiiPyCJu7O4yjp6SovHIblrw4sRYfpOL7GRG4kI6OLC6tfSfyoVkWKrEgGvk7vYhTv9JXlEOo0zmsl27c7WAauHE+g3hnC1srVY9/57iMbpIM8gAkiwCP7c50fxh43k+gumt/iJuAFFz4IEp8Fc8l3OritDpcOyCd9CSWRiQ==;31:rHbil7Gz2kDXo0Nt67qpUfA8M/IPzsnyWKwd3G2phCAgvi+NwaXljQPWleFkiJ804wtRp1CQHjaPg+UkIYrPVnknXGyrLHXltMttxQ/a0vFnCzfEyJlr2b8FTfUZ+/RjtE3rD6t2e5S3NW6bKqJ5gg998XFWHYsLKKyvSWM4oWy1jGSaMsVcVCh7SKqseal0bBvdr9leKCeF+vx3AQVJth6x35OEzzRP+5425wfL464=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:X7o5hO1V5HNPR7j+cm4Hf/3g2HkB8e+bXO3zg4eOReDAdNre6daA2Xd+Bc4SBNXrPE+1Da5Op8KgxURCFm6DvGmZ7hi+nNMRSds4tVlvR/ztpSUCwNmS3EB1It6Qh/jIjfRPGVvE+FLv5E13cLDHAuz+DSasn3hynO+AOLoZ2mUcOwWhRfU5gnR2XEHGZtNCf5PxT8eKv+k3Z+mO8RSrg9aaWahzb5TAQM/CmpLUKHA8GlYDZAxlgWnDftSyyMbaTnGcUdQ6nRBYUcI5jrtamBWIXNHh+NTvfQmM6ohtUTMADKb5wvG9Bm5UE6lzTGB4nbn6w/MM6dGr5glV+x1E43y5UKGErQf+pikEYq36w45NTk+SplBAJgKMlOqAHV26KcTGf0BJ/CGNKS7fDdsFTLV6/O+097yol/D3YEmZDOwTRrXWQGXy6qvXvbfMhmf0pkvLabRE/LUUG9ud71ixhGhFFC4BLuYk4Apip53CBQX5XVqiJEUmL2nops0q/9Fv;4:3COTj4cXYYcUsFmPzv95Zz+41JKaWsJVxCUSKRjsbzaMKgk4J8JYUc4CnbwFlNyfGvrQHvya5Kl3vKw0IG89kDogVaJW+jWUWbzXC3PO94phLzG/6x6bhAgixrI5Siy8HJAHmPKyLrBVbBu2Yb6U6HvOOFGRqCQfTu0x3dkadWgS1Y0h7wswFabkpb+ouJ4xynA+AMSGxHTo2bOjTDOa4y6YNxqSmE1Zw74Do27lKrUeZLH2hoZNc2KhAXtFMbSjGnYwTMshW9sS1OED8DgwHGZXfvq2vtVEcgNs07rCUjUc18eee7wYJ98Py1eVIFDfJlPbZa878AE42Brpz7aIXxA9RU+P9GsAgenJZUOkk4os7hkKbWJbPv2r5cPVNLvP
X-Microsoft-Antispam-PRVS: <DM3PR15MB10837853AE26F7E3840CFAF1BEB50@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484)(84791874153150);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(11241501184)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Forefront-PRVS: 0647963F84
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39860400002)(396003)(39380400002)(366004)(229853002)(7736002)(6306002)(7416002)(5660300001)(50466002)(4326008)(25786009)(47776003)(8676002)(59450400001)(58126008)(386003)(6916009)(81166006)(6666003)(86362001)(8936002)(476003)(7696005)(46003)(446003)(1076002)(16526019)(11346002)(6116002)(52396003)(52116002)(76176011)(2486003)(1411001)(966005)(52146003)(186003)(305945005)(2906002)(33656002)(2870700001)(316002)(55016002)(6246003)(23676004)(53936002)(478600001)(6506007)(9686003)(39060400002)(18370500001)(42262002)(422495003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;MLV:ovrnspm;PTR:InfoNoRecords;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTNQUjE1TUIxMDgzOzIzOnJmVVI1K2RrSWthR014ZVZRWnEzVUJGelc1?=
 =?utf-8?B?aUNhSSsrZVd5Zzk2Uy9lRXFUNDNsVytacWhyUVdtbmFma3pQb0lVb0JSMnRB?=
 =?utf-8?B?VzF5OHVhbXk2NEcrWWtwYjlmTnJNOE1lUGpDNGJkZm85ZkljclZQOHQ5WFBj?=
 =?utf-8?B?N2FaRkpOQ0dMcFBFQU1UeGFrNlVNbXorYUZ4UFNjeS9GUlZLNEI1UjVDQkpx?=
 =?utf-8?B?alN0T082UVdWSWh3Ry95czhPcTY1bk1FazNzOVRwQVZwdGgyZHlSOGdheFhL?=
 =?utf-8?B?V1dHclNrVFV6SFdjbG9BNHNPaXBPdEo2aS9CdDVCVEczVSs3U3VHaFFldCtZ?=
 =?utf-8?B?QlpoU3JpdmNVWmZPbnEvbEgwc3ZSaHphVG5CQzBUMTQ0VnF6ZmNDMHdkL3Rm?=
 =?utf-8?B?ZnJiWTBXdnJGV2NTdDd5eVprSzB4MXNGT1BhZE1ETTNFUUVZUzhzYm1BcXNt?=
 =?utf-8?B?d0pEZGtESUx5Ui9mUUpZVVdmSUdUYUVBbjZKZHVINVp1VTZ3eHZ6d1hHVjV3?=
 =?utf-8?B?Y2E4WE52NGtYMFJQL3FmMTlkOGxWNWV5Sm0zSmJiZWxsQUlxeUpPV1NsQk9t?=
 =?utf-8?B?SHJWL1JCaHkyMXBGcm5IWmtLRGpJN29wS2ZmeEExdDE2VFFxRjJjY2pMRGVw?=
 =?utf-8?B?WVNtZ2swZEpodUo1Yno3ekFod1NQbS8xRXBPSjhybjBQY1NtUmRGOHVLQm5j?=
 =?utf-8?B?OURMNzJqMmlZUzR0ZXF1K0hDTEJxQUZLMHdxd21hY2gvOFRza1ZHUDZibTRi?=
 =?utf-8?B?NFNkMEdlZHpnZkJjd1VGVC83SllGVExnaGJCclo4SEpLR1JyZEdsMmY3dlBB?=
 =?utf-8?B?VXR2c1VmZ21VS2FaMjA0czd4VWszVlN3NlhSU01xemxJMUpGNFBldlFqMGFF?=
 =?utf-8?B?UHpXNTBZS0RZK3RaVG1yVnV6aG5lTHJVdFgvQW1wTE9UMU9Yemt5UVdlbEQr?=
 =?utf-8?B?bWkzb2ZHMVpiUkNoZHNpaFZOdktTeTE1cE91QlRCNjBzbHJ2Zk50Rk9YWU03?=
 =?utf-8?B?YnVsMVFROHZZbGRhMk5BYmpjY3E0L2wxREJsZVRjM1p3YnVZeXI0bm5uZmhQ?=
 =?utf-8?B?clRhME1sOUJyckNUdVVDalQxdzlHN0tOQ3dUYnFDUFN3MVFZU1BsZVR5eGNz?=
 =?utf-8?B?RFlOWnFUTEtKRmFybzZtd0d5QitMMDBWN2pMemVoakdiTXh3WExkOU1DZHY0?=
 =?utf-8?B?cDFLQ29uVndoaitkNDFNSVJyZFhRc2FwelFnZ0dDbzFzbklGS2FFbTRyVFVs?=
 =?utf-8?B?c0l1RGZMeHEzQjFDT045UW1ENitQRzVQT25aZ3YraXZQMnpWZ2pYaWliL0lz?=
 =?utf-8?B?ZVdselBDdzl5V28xWkpqQjVVNlVEaWt3bnVJVnZYcWU0ZEdGM2x0QVhmRWlw?=
 =?utf-8?B?UzBJanpMUytwdVBFVHpKSzlHb3ZPK0h5SjdOT2RWNFN3dmpKUkRIVzBoYlZ1?=
 =?utf-8?B?U2Zsb3Z1cXk1by9NMGtEN21IUnVrc0FUNStsQTBlSGNFdmJHWVBSZDh6Q1gw?=
 =?utf-8?B?NzFHOEM4cjNWK1hEQXY4b3AyZEhwTWxRNVlPZkp2V1RkNlBvRG9ZQW9HRG9w?=
 =?utf-8?B?OXFuMjV3bktlK2N0OTZOb1ZBNmNKY0Z1NFJtV29LenBaK21DM2VPc1cwUGRW?=
 =?utf-8?B?MGM2RWorRTZ6NUNEaEdiaUFlUisycUd3ZDFzL2dDajhqY2w5LzVtdHc4NmN5?=
 =?utf-8?Q?nfr/qgNQydJfbNzN1rCG175MZ6UeBgRF49UB9Ed?=
X-Microsoft-Antispam-Message-Info: 8L2mVEM1TVaOsGYPsT7gbvxPVYP4dvkEYGODTJXMI6fCustIpFzZ3+MyqoGeUTAyn0NIp7Ir4/VA0QVJNAvUaSnruC/aH/nT/uZ3KMq86XfbYdWEY5KOGIeIlQTgbzARWh80aIORgXTRSMoraGT2lg6U6COFX61ekA7IiF3nHdoPVlu9mXkJWmMKu3sb4SFo
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:mDiXh12PtERKLpFdXyxh50G6eoxFjywKKmbxOqu400VOvyh2/3up4ikCEB02ix8ZuPWI32d8rsI+zqC7NG4w1uiUhUGZaswEjPraXh8stN0LkAopL1bxcCM9zVRnRamlF6cM+cD0s/Ut98GTtj9YMepbGIQZ/6xTZZio7zB6bZz5V3aJKdyBediJd8YPkbkbXHqYcDEUuhNnzb6eujljXBG+4uH+sz4ZvhuoFlRlSXEVT6We98aZfOHU81vL7SnokTAE9c8/ChqjBZ+x14z90BdOmdHH3heKNAIqxXieMq0d1AJc7pf8I+3tJMjt4H3wVEGng4QYHtXbvQsQSxslKhVFJAzFUyqEeSSyBElG3ogOs7LFLSOZwWbT84jrf8WlgiGjummWvCkiM5tJlHHCcaZbY3zMPyEiuYtgFwcnn9EgFoRmFNAc9mDZ6fJEs/Gjwv/ea7TxI+YzndbPiq5pNw==;5:6cLL17KTa96A29Jrc0rJKQVMRObxgBno/SyIOqyY/JYPU2fN9RR90pWet9FeGMwhZgpi9QR3GAlFT6Gr5PY6jojtUsjanVMqRt5n5QW8mCZjcqQnCIfERIqF3pMtp4bpY3vpP7uU/CjzYossC87oCU1EQKdnurHfAOcOWjjP1Nk=;24:sBJzhl+wj/hFIWTxCvv5aiv8J7KjzWn8EgWak4tZrPRTfNY8ykfaoBxxN+DtyjsBstJTdbnXxmkRR/irL3TWlaZZHyPjljzE1m5rrW/Mztk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:/NWdzGymZUlhwfX4v7qcu5rcHp7rrbxLBemSt2Dzke3g1b/DihWV/JFnyTLorkoIaLxuHgcG9oTdsFWTAU173sNL/l5V6aBnPb7Z6CFcDfPY1TXVysbzyrOJE9t3iMpomhGfAc4dXg+w1fyYh+Q5kdSDIJdSTqmj6glQU6KkLR/AS6l6bbYiFh4YJazaXM3cO4n3gcXjuqXNf+v2SQPnab6cI1/BvQmg0p7cXQKk1kNBDFASpFecgbsOwZRb/QUv;20:pw8qy3xEJcEHX2cqJF+6HRACbrr5EmDzQ5DFhmmP95FCm6nsDUAcwqMZJxnDM/1UaveFq/jGJJeGg8ERMyxzSMq7cMA8k0bybXXk/RkUnvPUsOFnD4r0NZTaQ8XuOrlAk84CMI1J9Q9Aysu6md0wnK0HusqJFv6PR5C+oL9P6oY=
X-MS-Office365-Filtering-Correlation-Id: 31b2984e-1c00-411d-d1f9-08d5a5e2778b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2018 10:44:00.4636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b2984e-1c00-411d-d1f9-08d5a5e2778b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Please, pull the whole patchset from the next tree:
git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

$ git log next/master --oneline --author=guro@fb.com
1fecc970ac9e cgroup: list groupoom in cgroup features
dff73d397f7f mm-oom-docs-describe-the-cgroup-aware-oom-killer-fix
7cf83086511a mm, oom, docs: describe the cgroup-aware OOM killer
e2194b2869f1 mm, oom: add cgroup v2 mount option for cgroup-aware OOM killer
338fbcc52518 mm, oom: return error on access to memory.oom_group if groupoom is disabled
96fb32250ded mm, oom: introduce memory.oom_group
ed5f99985bf8 mm, oom: cgroup-aware OOM killer
e33eba2c3273 mm: implement mem_cgroup_scan_tasks() for the root memory cgroup
9bd3a4c529d4 mm, oom: refactor oom_kill_process()

Thanks!

On Thu, Apr 19, 2018 at 08:17:04AM +0100, ufo19890607 wrote:
> From: yuzhoujian <yuzhoujian@didichuxing.com>
> 
> Hi Roman
> I've read your patchset about cgroup aware OOM killer, and try
> to merge your patchset to the upstream kernel(v4.17-rc1). But
> I found some functions which in your patch([PATCH v13 3/7] 
> mm, oom: cgroup-aware OOM killer) does not exist in the upstream
> kernel. Which version of the kernel do you patch on? And, do you
> have the latest patchset?
> 
> The faults in PATCH v13 3/7:
> 1. mm/oom_kill.o: In function `out_of_memory':
>    /linux/mm/oom_kill.c:1125: undefined reference to `alloc_pages_before_oomkill'
> 2. mm/oom_kill.c: In function ‘out_of_memory’:
>    mm/oom_kill.c:1125:5: error: ‘struct oom_control’ has no member named ‘page’
>    oc->page = alloc_pages_before_oomkill(oc);
>      ^
> 
> Best wishes
> --
> To unsubscribe from this list: send the line "unsubscribe cgroups" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
