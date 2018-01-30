Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeA3L7w (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 06:59:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:58216 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751219AbeA3L7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 06:59:49 -0500
Date: Tue, 30 Jan 2018 11:58:51 +0000
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Tejun Heo <tj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        <kernel-team@fb.com>, <cgroups@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [patch -mm v2 2/3] mm, memcg: replace cgroup aware oom killer
 mount option with tunable
Message-ID: <20180130115846.GA4720@castle.DHCP.thefacebook.com>
References: <alpine.DEB.2.10.1801251552320.161808@chino.kir.corp.google.com>
 <alpine.DEB.2.10.1801251553030.161808@chino.kir.corp.google.com>
 <20180125160016.30e019e546125bb13b5b6b4f@linux-foundation.org>
 <alpine.DEB.2.10.1801261415090.15318@chino.kir.corp.google.com>
 <20180126143950.719912507bd993d92188877f@linux-foundation.org>
 <alpine.DEB.2.10.1801261441340.20954@chino.kir.corp.google.com>
 <20180126161735.b999356fbe96c0acd33aaa66@linux-foundation.org>
 <20180129104657.GC21609@dhcp22.suse.cz>
 <20180129191139.GA1121507@devbig577.frc2.facebook.com>
 <20180130085445.GQ21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180130085445.GQ21609@dhcp22.suse.cz>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Originating-IP: [2620:10d:c092:200::1:fdf1]
X-ClientProxiedBy: DB6PR0501CA0002.eurprd05.prod.outlook.com
 (2603:10a6:4:8f::12) To SN2PR15MB1085.namprd15.prod.outlook.com
 (2603:10b6:804:22::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4881f69-43d0-4d80-eeac-08d567d8de9b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN2PR15MB1085;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;3:E7Bzv+iEHcrZqkGs6m8WhMFKHxYNJR7PqxeL/vbERyUymDHuOVrsnaPSU72aGKyxNoqAbGdZrXLMY3R+uY18axN5qRckkg5+HOREmdGFZLBpJyZFXYSG87mpuTu0R8plPdNlrZqcO8xBWnpHm15yXggiUtNzF9nI9WoDY89iGkvw2XIMbgfc7VGV+8W3YORkvuWNIQU/TS8WTYJdCZ9YE4MwUs8po41jH/POOPAW7mMd0gAVfgmfvN+kRaA0kuOW;25:kC7n6iz41gllSP2bVho0m0AWaNCUxV5RkoO6z71YzwBG8Eeh7Yay2p2sDSnZSzRJtYsDWLxU5oI6Fj8ouAox4Xk7SA/owf72XZI/nvIPm4w/PmKXJyvWHL/ZlrFzeKowzJJ2ZmJdX1U9TyvqHfpxjPrnHwcbklMFLs6rFG13z4iUiSA5ICb81y0mxcNggbOIXP3iwuCXnD6j77xLI7+Z8Lr4tsYtMRq9BJ7PxgbDC0TmOQq56wYhZgRqFulUA3fdF0veskZ+p/L5XO2KxFhDTAns6Ob7HsQE96B2HSk4lTEObEnXVgY6ohxFmx6F0cvvW/Fpo9YRK4WqPKJ8ZS1VOw==;31:fvFZr0deXjaNRiiCynhg7HRwSwbAZFRtTBR5oOgWdDw3goPr1522fhcYkDxANgD7+mQNZJ5qsUlLaCl5j0I7ovDhZHdlSh2dJctYIVkXE/hAzywxHQ62DRcOgQs9UmaQBVp6OYejoSAS/E6qcfNrVx/oksFZSMq6X0MRH6DYIvWTSWTU1REb52vk1dpNrAdN+DhpksWB0Jq7/1ndDwkctDQxoXStPwzcM+iPqxub9rw=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1085:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;20:957fT3thofV2k4vPdOrAMKxk1lFTfv8fvQsfGW9IvsXLzBVowsArpXrGAtfq82S8bFsR6PpIYhbmC+uA6xgHwB1dN3XbtF8OhRKmnWK8iFMqoSW4oh/8zUxuegc8TT6ppX7WJd9JljJgHTrfAua4xtBLjRBMgOQ+90oXg23XuMUWlA33DNdaTo2cv83IDuLJ1nTWlYkEcXXi3UzhE1lVdQWMOrxqtwUSKb+h6hyL6i6Lh0FHTvak52+4oP+8KwOgcJCZ/IoH/mgu67ZPVAK6GKdjaaXDReJRUfqtdqt4azd4UKW+ll6dlDJjlPb7i+NM5bOFlkXg1yQHaxO0n1xuAh64CmKUQb+2D5U/8/dpm8f3EnCJJ558vlsYcB83fMiperE9979v87Bau2pDgoP6fvahrl508WuluagLUL5zrTUmhQ1Ig8KWyBW0CeobO0pdVR+plwJKAesAImZllnabWIgvS09UYWvxeKyLYH1OkEMZCQ0UJDPLKURoy8ToGMfC;4:kQyPt8oiPIpk/DSsJWVZgQlx1K+DOjDcrckEvhtq6uFx7cx4G7y/w4mI4dSRCK+TfIp5JphABw8No50Kw7DxN1VjIHYatXG0I/l5ZQucO+1ZPHKdsYin0FTrGZfJMLD/DMcVvFk7p13rgQdSnN2pK54tUVOcyKgw/JL6UBxLAQKprnZnP33EFKNCbCD8VG6JFEAeTo4ohdk88UDEoJ2V0XkG4ix3t3CE7kbmVEdRyGOV5x10MuX3QrWRqti5UxNZiB1uSwrfaUY5IqY/NRFNnNpHID3DDNTc8SW6l31B6W5wGhBOj2ZMHjFKySFV1g+M
X-Microsoft-Antispam-PRVS: <SN2PR15MB108505781A7CA560D077A9BABEE40@SN2PR15MB1085.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231101)(11241501184)(944501161)(10201501046)(3002001)(6041288)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:SN2PR15MB1085;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1085;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39380400002)(346002)(376002)(39860400002)(396003)(377424004)(189003)(199004)(33656002)(52396003)(47776003)(6246003)(7696005)(76176011)(52116002)(4326008)(93886005)(106356001)(386003)(59450400001)(478600001)(50466002)(6506007)(54906003)(58126008)(16586007)(83506002)(316002)(39060400002)(2950100002)(6916009)(81166006)(8676002)(81156014)(105586002)(25786009)(68736007)(8936002)(97736004)(6666003)(5660300001)(2906002)(6116002)(23726003)(1076002)(53936002)(9686003)(229853002)(7736002)(7416002)(186003)(86362001)(16526019)(305945005)(55016002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1085;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1085;23:UaJNssMerxNWao2Pwe1dTH973K1sN5oL3nl9XMr1h?=
 =?us-ascii?Q?rfDxI5QMwbz5Scl412gyGCB5OtDTjqZYrduX+YA+srRr74GUdTLiJ7YXPsOG?=
 =?us-ascii?Q?QWxcwhXUQaUNghx1t5wLtW8pXZuu3Eq/f72Qk7mevt7YjEvNhFqIX37WhXU5?=
 =?us-ascii?Q?Hjn+OYHLnHCT27DKdPPiXQvh9bQMevmaINv5FUZLGhQVnei4f95b+3kFnvi3?=
 =?us-ascii?Q?EbBSXv3AoK8hnqSQqfa8wZJ3+O6yhNpIN5Z4z2/ua1d1ILlS5Vz8118VMND1?=
 =?us-ascii?Q?ar4oi9oJ+4eoAgytPB+vMYQEity5cEACuZiqEl/kkgmSJDLXR3JG9yxp5VWg?=
 =?us-ascii?Q?FJ5nVNTqd8k8bKz3Jw81/Jc/62rP3aKhOiL8plReLzVYeD4kN/qS/xqpl6zA?=
 =?us-ascii?Q?2DdBVxoqAWUBxogUBA8+HEdlMUXDHBRfxnVaHqxwxaf80vLMxUALvKQtXdRU?=
 =?us-ascii?Q?ye+MqVS+hRoyfr7GWc5F4gb1kARxintFtg93HTGXAYrWOVIg4wR0qko6ko1m?=
 =?us-ascii?Q?2AXbq5FTno9OFuvNIGDKsBSl4+Cz6WgTLdiJwlyGq4bZEkbVwQJiwy8bjQbs?=
 =?us-ascii?Q?jwUjDGQBW0ejB9tt6V+kiHv7aw6Vc5rYcsWHPOgmneV3wmvzJYRhflClVcNJ?=
 =?us-ascii?Q?v6E0OwLNSkJhRbOs0c31fqh/6OM6f/n+f41vOnxEyKx8vywghahCZGnY/xGr?=
 =?us-ascii?Q?Y5TfaH+S3fV3kzdTy48TrG5dXGKzJfM/Aw3pIgCTawjDuGlUxjPZonBWOKFU?=
 =?us-ascii?Q?A/N/MQaAqeeRwC+Fic1h6wIy60JXaRmiAyTqk+YfgvBRX1qSDV1GuZJ87nCZ?=
 =?us-ascii?Q?8uHi2yiLBp2mIt/8iJjj3K0VIXkkxEPq2ChR8alc+a9eSslJdbqMsCwI5Drw?=
 =?us-ascii?Q?yaMvIi08EVH2zYjKAtqZqIZ/HQW3RmytkbFprFMj17ddWBc4exnRbyoKP/03?=
 =?us-ascii?Q?zQwKDerme/NxpSWPKnEAaqAdehxzbWHO4iBrl0MhyQNtOjbvOVlzkonytbb7?=
 =?us-ascii?Q?6pcXAYL4Pw8W28S4dQejyNPx/1MUsHW0v5g4K8Peb7ZunWLzR7JlSYH2SgU6?=
 =?us-ascii?Q?IwPjsDM0H34oQ1oyacXB1hJlLpq1seZ3qzBJZuDX+F9qn3Cr3ewZlyBJm7QB?=
 =?us-ascii?Q?QN9iG/3ccTrrs5z1qsbsXWVACmowtqKbDkLXno3vr9fl5YkvaWuzkmnBuVrw?=
 =?us-ascii?Q?58X0XeSQ3X5fKzzQRm5fmLeaKimtTjmrh3yvVMDsO3YHUIkLrtdnV0e/Tcgw?=
 =?us-ascii?Q?paTzW1dnnINSzRBYi7ev4PWQNVbdHoT4LzyKRvbm18CmvHRUQyBOblzUUtXn?=
 =?us-ascii?Q?R8QeA+3LooOmQmAabTRhGTP/siL809ALDg5ySWuxYZd?=
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;6:PCc9kKOkwMSHmspdTXWxDC4m2tVCXO0nVtEbKQpeb2KffrMT3acOq5RDgvPhNWLMIxtumdzAY+kYSdLTghGdhXXfBdetJ9NvtefBOLCyq0QuDVpB0+oB13qvJwVsDXKKoeaMLPgdG12YYW6vI3DXEuyIvtSP2EwXXvpqW2aKtqvirOxEJRxRD9UnBnqTlDuQ9wsHRPQ/Oj0mocF9CdFATcohS5fMUVMadsiHh9YmOo+siWuAwNc/UH9VFgqPFKBN8MiCMgdlRnsFUijhfKrEUWZPmvOwb9i3e6SXQXEhpwY+eXUnJVazi0qdxpeTYm6ReLA5BcXAvNl5cLyEzluumqZlFvKGzOHVrr2gCLCY2/Q=;5:owNRLEnX+Bnd4aBRgRx1dFPZj7qlLqy/znz3A0TDqRVk1tunLB/Oas2nF3mgE7SuU0dOzIyS7Eh5f+adm3iQCD3e12u4nHqkl12Y/Gkb/73nklJEs+DpZx0dBFG4VD6IvhVidRL5wkOL4CSyqqJj2zRM3gLxyaEcm6+cKb2fF6s=;24:M6W8rZoYsQVcxf08dwDSoTdSKQs6zmZH0nJrIxEAcLAHQ9nkURt9n0yjU1lrKEJ1Y2lH3sJEZ9GytN1MER+p6LnK2kYpAHSWeRJl88bz2Cg=;7:Fx0CLKGz79gqnNJ6j0NpAeiIQzU1KwOvS939rR1TTKcGDxHLiV9l/ExNeqg8aZ0ibTAtGrY4wLBgMdO3fD4yCtQr4nMVnlvNuNUdbE+qja85K+d3XiFID+P4ZtOhJLlnBMwyXf3D6wTqw0kXa0OKHB562AgftbkWruU8dW8YvjEONGK6BPth5qPPLsquXKn/7uOPbImd+VITgCQji6PkyR0IvHunyozAJWlLmBXLtUVKdppESamCBgO7l9o3ZzIr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1085;20:8NNmpBFjs79oiF2DtOGbJdG4Ldlp1SC1H2xFHalpFizc1dEby//cAJosHRxQYJtbNyoaZq5SAGimAsZIebfBudCmey5tXGBAfcmW5r34PIGMk6wt2FS3IijzrX0AbtToCUOOOU430P/dWGkmTBSzBJg08YgyQM14erU4Rq46QQs=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 11:59:06.9239 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4881f69-43d0-4d80-eeac-08d567d8de9b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1085
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-01-30_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 30, 2018 at 09:54:45AM +0100, Michal Hocko wrote:
> On Mon 29-01-18 11:11:39, Tejun Heo wrote:

Hello, Michal!

> diff --git a/Documentation/cgroup-v2.txt b/Documentation/cgroup-v2.txt
> index 2eaed1e2243d..67bdf19f8e5b 100644
> --- a/Documentation/cgroup-v2.txt
> +++ b/Documentation/cgroup-v2.txt
> @@ -1291,8 +1291,14 @@ This affects both system- and cgroup-wide OOMs. For a cgroup-wide OOM
>  the memory controller considers only cgroups belonging to the sub-tree
>  of the OOM'ing cgroup.
>  
> -The root cgroup is treated as a leaf memory cgroup, so it's compared
> -with other leaf memory cgroups and cgroups with oom_group option set.
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
IMO, this statement is important. Isn't it?

> +Leaf cgroups are compared based on their cumulative memory usage. The
> +root cgroup is treated as a leaf memory cgroup as well, so it's
> +compared with other leaf memory cgroups. Due to internal implementation
> +restrictions the size of the root cgroup is a cumulative sum of
> +oom_badness of all its tasks (in other words oom_score_adj of each task
> +is obeyed). Relying on oom_score_adj (appart from OOM_SCORE_ADJ_MIN)
> +can lead to overestimating of the root cgroup consumption and it is

Hm, and underestimating too. Also OOM_SCORE_ADJ_MIN isn't any different
in this case. Say, all tasks except a small one have OOM_SCORE_ADJ set to
-999, this means the root croup has extremely low chances to be elected.

> +therefore discouraged. This might change in the future, though.

Other than that looks very good to me.

Thank you!
