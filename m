Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751483AbeETK4S (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 06:56:18 -0400
Received: from mail-he1eur01on0053.outbound.protection.outlook.com ([104.47.0.53]:51333
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751030AbeETK4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 06:56:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526308035-12484-1-git-send-email-vladbu@mellanox.com> <1526308035-12484-3-git-send-email-vladbu@mellanox.com> <20180519210442.GA5488@localhost.localdomain>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, jhs@mojatatu.com,
        xiyou.wangcong@gmail.com, jiri@resnulli.us, pablo@netfilter.org,
        kadlec@blackhole.kfki.hu, fw@strlen.de, ast@kernel.org,
        daniel@iogearbox.net, edumazet@google.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org, netfilter-devel@vger.kernel.org,
        coreteam@netfilter.org, kliteyn@mellanox.com
Subject: Re: [PATCH 02/14] net: sched: change type of reference and bind counters
In-reply-to: <20180519210442.GA5488@localhost.localdomain>
Date: Sun, 20 May 2018 13:55:59 +0300
Message-ID: <vbfsh6ma94w.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::28) To VI1PR05MB4701.eurprd05.prod.outlook.com
 (2603:10a6:802:60::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(2017052603328)(7153060)(7193020);SRVR:VI1PR05MB4701;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;3:pyBqUP2HjmbVubTscOqQm7uRC29AXovjbpZwYvMq3EmDYiyRWp6Ewo+ujPonK28fc2OHf5NDyNRxBcazFjLlTnSYcft44ogCnE9oGATS4cANMCU6x61YWuXW+WoSyU4PxU7L6orYMWPIxTpiNJQ0zSsBGns64JEKOZFOd6ftJ9Fj/KqC8gu38jitJILlLQ6JpMfIecxVTnn6nTadlwovk84UWRy3vFP2LgztEkY7rlKvjkvpWd43eRfRIAxiF6/U;25:xCUY8g5V0QIN/B6oFwXN8/Z5/0jxqOaoSH0pfnakmWeIjpJv8upSRst3rMXNke5VDbaU01xVpIhBKx4rGaYwEM19zjoJspTFyXFkCFWPi7O8K0jPtk1ce/rP7WV2fXa9x/JOExY+6LgnjRg752PjQ1CvlflgvnquSuKBOUZIqFEyCSdwWlZqPyrsWxbgkFWb1fAoe4jVdX7AIlRIc73wXEn2BhFxEz7cR8MCYJ21Mc8YVm77pZmoehJUrZETf4qvdn7h+8Z5DLc6QQYr54e304errlr9beuIGxxqbXws4CgdI0SCfUmDemCFRy+CLTbMOLE4DP3qrt76f0iemBUcfw==;31:5IvXTEl38GKQvlB7/hXD2PFG8seBlHN0CJBkP9PCkBqQflhhsSK9e+g493qf7rvjEE+lWe0tIb+tBv8gFBqY7kS7pzIxJ96fA/tHSxPeQYWfuc6gzQV3rzPaMEHcE2LQttYq/e2krpCs2psYyPZEiJWkdahBNShyHmd/DEIZlffbUC0eYYWvSSmjpCrzQz4UIuNpco3goZcDz4OiqJBvKlDU1B7ULth3mPksmCt485c=
X-MS-TrafficTypeDiagnostic: VI1PR05MB4701:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;20:xB0gwD0x2bOaWCfMbsyyA7X5WeZiVMndbdGVHRQrxgO25llzvBaQNagdiNsHdpzEBwb99Nq93PWw0l73GHZ4nJAKnk3qiKSZFhQoxhe9Bdv9od178GKi5fo+8sGK44PAMHe+EK6Wx5HQZAnhOp0pBhfxUVRK+vbvRL6+4inV0zsGNhioHpUqSyXY7vMIvq6RuhyZQvh3U02SHYX6xey3ynJiUJtVPaRGb91joftUt+ek8wiFjXQ+zbO6cBt38eUno7K2wZwQLTdlgwhUeQ4w5C0lrGETSET+8F3ScTS3Hl2crxfcUTkVxPKIjfyFmBlJn3ICbDxNQqpRZBzQ5QvIl1xR6qr0tPMRricjNe3oR4BkWCgqvD9esnw0dA4AjaXnbi2tHOHm6YMwbALIuWOuutH5b7r1qLAaVmZ0v7jbPl0X0D7n+h6vNDp/ZtKf6zhXTyvpIXV+uv47uenjnV45n4T0o5rFeuK84OsBxOKXHNyuow3ZcjMihg9wVIT7szrX;4:EHrECNAAiDJBVKmbmwzK0lB2uB98FJwu2wB3k6Y+F9fSV2QlxzHydm8m2b5VPWTfwC4yYvH8Pzu4EjWXROUAkLGX5UdBwkEC7pQAx5rKJ7a1go08lwUHlhS9vpNHOdg3nDzuUTzpq5XfS0k0urpljZQnbZeAWI0DR6Jtk4K62NHrhJD/idFN06L3G/gy0zRFSrzh0nMnKNpS0p9FsRxZrMB5OVYUR/tOraJBSkAP9il7D5WNnRLLaPc5lIaz0MG3PkHWiYh0dyIGL3s0qEekbqBwxZ1kn3gpA9aIiuiy2P2JAzxUIG3m8tKG2UzOM+5V
X-Microsoft-Antispam-PRVS: <VI1PR05MB47019563D3EC6C41317EB385AD960@VI1PR05MB4701.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:VI1PR05MB4701;BCL:0;PCL:0;RULEID:;SRVR:VI1PR05MB4701;
X-Forefront-PRVS: 06780E24F8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(396003)(366004)(39380400002)(39860400002)(376002)(346002)(189003)(199004)(25786009)(386003)(26005)(2906002)(478600001)(105586002)(8676002)(81156014)(76176011)(52116002)(81166006)(7696005)(68736007)(86362001)(6916009)(51416003)(8936002)(7736002)(16526019)(305945005)(6666003)(7416002)(106356001)(107886003)(476003)(66066001)(3846002)(486006)(446003)(6116002)(97736004)(229853002)(316002)(39060400002)(9686003)(6512007)(53936002)(48376002)(50466002)(4326008)(6246003)(956004)(11346002)(47776003)(6486002)(5660300001)(58126008)(16586007);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR05MB4701;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR05MB4701;23:mzEzFEwE7liBune+N5sVLB55eHRSYs6cAzVuGPzop?=
 =?us-ascii?Q?JNxvNnst5UHftMkFOLD9AP5wn0v/F8LrU4QO5V4TLMXgFwiGdzYBH6KgzF/7?=
 =?us-ascii?Q?YVaTb5k/ebAAUBLCo9DOlrg+ksIxzXVskLXZ59ECZ/A/syz45avvgZYNomuU?=
 =?us-ascii?Q?1vgTv6zSSR+MVnlDQsAvvUgfsVW0P752TBB9tkq9qcA9SzW027dBylPAdSWT?=
 =?us-ascii?Q?1JIZApK0BqqOx1VNsaD6aFwvz1eeQEYn73g0zXsIaVQv13UwUCcfxJIB8bgr?=
 =?us-ascii?Q?wopGxYg+8L1ZYDuRCptTEX/rXEGLSy1CtlKRvpH5MXcqrWvVAK0SXQLeAAyz?=
 =?us-ascii?Q?cwU+pT9yf6VXIeIfw0/Z0oI0uhy3bXB98Wkldh4KW/awMwQ3q9JhebWEguud?=
 =?us-ascii?Q?n024ezPlm7gS+Z6nJyqtq3sSbM45U5OywHr8dOvTUgiDWEA8s/UMaUbycI8P?=
 =?us-ascii?Q?5FWWlEL5v6dBgK5uyH2IfRfLdUw5/gjsbUvXOf4UwXfzaJ4SqgAMnWNM2yTD?=
 =?us-ascii?Q?zZ+LiM23sgWo4bp0co+A+ELaGHrxKWxJqKsG8ao8cZ95iYU857o1STBnryON?=
 =?us-ascii?Q?MyrNwsT4buigGMjIms5lyiEPhsUFpZoYBczxL07puPXiMdpginWrFt8CBvjB?=
 =?us-ascii?Q?1cjv74Q0juX87maukIUJoi1o5N9H5upE/THz49++2fs5OyC7PNywI7lmAOVL?=
 =?us-ascii?Q?CRjFVnGks75Z/yNatSthN25HyZ5wYs3lwquVD8wlhLlqTCSAFWGzU9D2J20u?=
 =?us-ascii?Q?K9EG3qmlyE1i2X+iHB2nV2wyq89eoqMkXA68D9Ux07/vK3wUjy/xFbhAVVlO?=
 =?us-ascii?Q?oUzEabpff/au7OIPxY2Bnh9eWa66LtNMlbKFcX8yS69tOH7kai+vdzgQLTYu?=
 =?us-ascii?Q?7UmS276FF5VpBSQtWPzQaLqBEXA37hhWn57kZllYIi5aGz1otGm1OlqIk8VT?=
 =?us-ascii?Q?tptselzu9ep1uLvJWKF7YYIiWUCx+vOxeBkgWA/fCpZoM2J6AAdF9jXr9Iyu?=
 =?us-ascii?Q?/eIjG/Jr4H3WR9NZ2XhsiTlYSTloXgSCgT6zLE/AcNiT/wrfCogzBV91J1RO?=
 =?us-ascii?Q?7eX+sbRAkWlOQ20cwfdtrIM4RFzpg6lT4lpfkzOVcNfhDGIGsikreckYjfnp?=
 =?us-ascii?Q?pszQu4UBKRROkdpjv77wsBNBwidbGTFx1fepWbWiHTlBDylHDCZCZeCP8crE?=
 =?us-ascii?Q?9MQteWQppK3u0bsqDSc1czmsTjFU+dY0pXk4C41WRf0E7E4aiH1tk/GNU0/m?=
 =?us-ascii?Q?F4cAoJTaJTEBKp5UzE=3D?=
X-Microsoft-Antispam-Message-Info: nZZUZD38vjzR/YEKuSuwEmc2pAHLZYcW+9K6EajnqTRYd35uN7efXK1MRkWdB0nlThSWHtGVr5TV5g5o/Suu3VB7MHi0Oryqid+t9DQN5ELiNn/7q3HX03SpPtEKTQcL32HudEsXj1pKq4+i2F1uiKfCTO3dLjq+BjOKm7CN9zWQL2pfsnwX+FJC87qOjict
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;6:I7pKNBdwvkDI5AeUWWIvrzH3917Qxo+g455V5CmQ9wlVbQ/QC+cRZX6rQD2adBVuGi85iK9N53oNoNmdygFOFTy1IKeY9T6KGfOQUY+QjdtltKHrdwwzY2hBnK2lKpEVjcD+AUXRJ+X45SZG5ygFZnD6Upza3JKnlxSRkQMQy9cK60+jkCTSXj+tmfB4eeHe4fKfQjvg2R/Ph1I7dGGwuDMqE486jpbQPgzQt134LYNk/U2HbUyS7Ta+1HyDwTa8Gz3TXhzXTU5fjiLYHGBxkRv2qzLAvJcWnC+FdJeOGeNFlF1bfUg5BMft2dbcixsHqUe5SMBVHMh9rf8pHOyPmXM/jNE3rsry5VsaUV/FBx2KzaUBUbErWYMNmrpINd3i5LIOZK28Pf7cXv1FS1fUYJdRO/fVf6yXd8COmYiY3GJCC3DVk+HMqgbYXjaDR07k/iClTWVd/gFNqPn7m4joag==;5:pfZBLZppfZXMOWmIldK4J3dGjXrYnXUP799u+0q4W6G405/G1dJhvtuUFKAXZoZMQgaEUTuaynjP2Wxkc+oDM20BSN/Oiy/Jtbth/L2MM7UcHWVHVolplUmhU5Q3z42ergFiKE+FEnJ5u+oH3jMl2dOKO5Md+6yap7oXXjigwZ4=;24:Nt6jKIMikNNwhCuk2BWz2a8xpEozAzUIaRDBKfNChThmEisuEinmAHD6rZBp9TvJ6AIiNAuEv94SJMQ7qHCOLdWeIw9v0GqxuYFL1AI9OWw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR05MB4701;7:UOIC4j2yzrkVZuf8wRJzRHx9oT1gte/uYlb+fX66sOdgWSMj6fN+3scrqkx/73wfiZGWxZpID9o2pd2OFxpJcPLVSfnM3AC2JSS+fCIbTuGknNUVFOT/ZJttx9rKUec2kBqG21y4is2zGTIUtIqW198w006WsQ1bih26rpNzuOaTQtGgbGulavM1GinzfPz0j/KSBJR8F49/HDSQmK5f3c8qrDBeJfqzeviSbX+WHw9Hd48cPRPdBxZbfnN6bNPJ
X-MS-Office365-Filtering-Correlation-Id: 8f34f775-85dc-4764-176f-08d5be404b04
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2018 10:56:06.7911
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f34f775-85dc-4764-176f-08d5be404b04
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB4701
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 19 May 2018 at 21:04, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com> wrote:
> On Mon, May 14, 2018 at 05:27:03PM +0300, Vlad Buslov wrote:
>> Change type of action reference counter to refcount_t.
>>
>> Change type of action bind counter to atomic_t.
>> This type is used to allow decrementing bind counter without testing
>> for 0 result.
>
> ... and in what does not testing for 0 result helps?
>
>   Marcelo

Atomic operations don't WARN in this case.
