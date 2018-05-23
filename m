Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754191AbeEWHAH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:00:07 -0400
Received: from mail-eopbgr40061.outbound.protection.outlook.com ([40.107.4.61]:61440
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754005AbeEWHAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:00:01 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <20180519.230258.1374885458106197707.davem@davemloft.net> <1526932984-11544-1-git-send-email-vladbu@mellanox.com> <CAM_iQpVMFSxnN6dEi0U4=aw7s7TcJ88ShiNTDXcoRUVL82jTZw@mail.gmail.com>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] net: sched: don't disable bh when accessing action idr
In-reply-to: <CAM_iQpVMFSxnN6dEi0U4=aw7s7TcJ88ShiNTDXcoRUVL82jTZw@mail.gmail.com>
Date: Wed, 23 May 2018 09:57:34 +0300
Message-ID: <vbfy3gaj1up.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR0102CA0073.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::14) To HE1PR05MB4700.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;3:4n7UYmDxIhQ82DJcnhIg3PdxaN2O3XPIFXL7MDbgYg4eSP5wHMP0iMeHV8y3nFiVgMLJHaLisgiLnI9PYRw3cs4H+69RiioxX2tzUDFkDMFzY1I7Rx3MO5P5VB8m/c1B5+0RoJAyYLH9kR34PR5oMq9qao0eXZa+3V7QYF5o9EtBHXrGKDO542hyCWauf3fh6L5IiTa/EPi4GejORwV1bjmJbbHIcCY79U+Y3anpn5C6wQjx/bRTqHWj7wBcyxDw;25:LY4maJIssWbk6Tk2fndklmWvUthQfIEdym7DeHq0Fzbk2lJIWq34HaxksRJcNjzTjrVAzQ3YLns9QMR/XpNsNetPDEdBNkq7jZMsnsCMO9I1M81Q20G2NykUwkBKCrqFvf3hmNHPt6ZHtZ8+SzaUK3fExEJSVFeWrGiJZlWbVqbiSGBtrtg3TWpADESbKv7ihPKMOc50SaJ+rY2AhroucqxVfn6uyxuTnc0XpUR2TDsGrk6tzSV5WjUVYvIJaltrrBJ97mQSG6aBTdgaDuZVhW0sdH9ZUGVtVq8Hpy1kJ/9YJRWfRkYIWnC5NA3zZCBfSVxUadXgtQjyK33WGg0P0w==;31:rCiLjb9PdhUtElHhP9iTUXZepLoZJCFefJONDXF9Zyrvx3urce/sLXTpD42PW3OC694vORrR0IWOa9fh9pgXp38+OEr/6KKhfPVitmAeb9dGdOkpX/4GVxrqN1oz85t3527gCpYKmsbRF+QDiqTvi6ZbWRXwJrDLmwhvyN3T4zy14sEidWhuDISywcxfevqseJq3gd/MSZ6dyk3yo5IB/EdHl5p50SmxcXWydt/C18o=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;20:S5OEMPkEbzf53DZi8AwsTOMOD9dwHbOEjG8Pv0aUXmaWxTJNKgIY7TTqInc5HqAqJ+f8BH66pJSaBMFFoBQpYHmF/dU1YyPoEaWulcP6iVB3cJq7628OeiAoN9tvtLLTCJ49y0fecdbUo7ZjlqnIh1vnU5vzHMByEgbj2WAYjHgYlrUfpW822F3zph1DxrYQU3bS7/FpJ0SikKhneCbC0Ixda2s9qVLVrvvgpgYzdmBrWD+R/wVkIb7pXODyUMOYrW8lrmrppGk9uiFkJTmeLJ1WKCWn4X4hltIU/EQg5sZHDzNyEiffAl36VhXzb00VwhlqJkdQih8ayyUot9NZumZQlz8Nk5zNF980bCm6igmor08mRWmktDk5Sb6wzxHLc3W9V2jSCpwvcu0zHDdmLJaV7oPAZHhQvJdM6ugR0gO6dunxHxNtPCUeLyjYCkmJbAfRdBkQUrMhbJIkuL/iENPLax9bAsPzEUviY0y2i4A1fgYqDKY4M7XPiDqN3I04;4:MBiKFFtGAA0BYPAR2ke4i9OVIPEdFeGTUjmhazRLN90vsF7e4xtTMD32hxOYFDV4F79h4L//BfiqOcY4mh9xw6zaokh6a6s/xbQRPBnEa+2pVFacXsZc1GyMQaALtpE76BDMAMhl3jtHo0vom+qOX+j6wwuJGcxLuwKOWLJ7AgL8ZUtpTCcQ3fNi0pXPIGQFj6rzDdBrLzUzlx5OnO8HeHeFoVlf3xS/1eCi0tOiGQppZ665YJims3jUVd764MQwL/O0Z56D3G9PWkXZQR0/CZ92NfKuVLUN8sODg4KP0FBQSu9QxYaXN1fPEIFcs4gmxm4gzuFTo2IfdgDdUHuE8/ZX3ylPLJChPdGoeEVXd10=
X-Microsoft-Antispam-PRVS: <HE1PR05MB4700D271D3A5DFB200FDFC5AAD6B0@HE1PR05MB4700.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4700;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(396003)(346002)(376002)(39380400002)(39860400002)(199004)(189003)(76176011)(3846002)(53936002)(52116002)(2906002)(39060400002)(7696005)(6666003)(305945005)(229853002)(6246003)(59450400001)(66066001)(6486002)(53546011)(7736002)(386003)(4326008)(26005)(51416003)(6116002)(106356001)(81156014)(105586002)(9686003)(81166006)(186003)(47776003)(6916009)(16526019)(6512007)(8676002)(8936002)(50466002)(5660300001)(956004)(486006)(478600001)(16586007)(68736007)(97736004)(476003)(58126008)(316002)(446003)(86362001)(25786009)(54906003)(11346002)(48376002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4700;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4700;23:ok4ymQDBQPUFNGaSsF72zF3W3a/BV7vtytQs4NoD1?=
 =?us-ascii?Q?NPzqdkqg7qoiwJzZ5TP2LadR9SSlOEj4RUXkqW9qtT5J8XBK+preC+OIiq9x?=
 =?us-ascii?Q?8gMkOJNO7R6HKTfQFxeNaPNlCkQ8528jYsLPCXUD6k8eaWz0csbxGJt01AtY?=
 =?us-ascii?Q?pEz39rfx1CeYU5OMGyjZRKrRr6Y6wkf9zbUO25ResC0Qlx9U/GoCgQkUDn73?=
 =?us-ascii?Q?pCDq+Er1o3oqRWi3yAc748+gEWim1LI0qMsGQ6jHvCQPMuh7KWYgH3AK223w?=
 =?us-ascii?Q?zPopLiSyz+zX82N5+odMqnLeEFx2B3fXb0kGMPcCbeiFHF67jAFhkgYI4OoE?=
 =?us-ascii?Q?fEr+6Kq2egg0s0YIzfzJTBiHQqkJqbHuzO2CD7LNai9TFsfXg1biAlSTLwJC?=
 =?us-ascii?Q?KqqUQtzxmj2ig1eLVMDXat3Nmsg0o8sv1e5hYiGz7HXTzzyrFo5NK+6l+bfU?=
 =?us-ascii?Q?8nKTe8tpZZJ/6YEX0lMzA/mozEJTaAFtqP+KrigXrGsQ2BlAJjgvF4u/lDHa?=
 =?us-ascii?Q?SkpboK1tVAyjlmLj6SPub715bnimMTmhvSPttqrRHYbdJh6PZz7M3mH0+VFF?=
 =?us-ascii?Q?mLFEYJdVcQ4R7TtPSprVR+QyZfc816g8J2mq/cxn44bJeEuMv7UnSvSaiPJE?=
 =?us-ascii?Q?1iE44aTamp5zPeX70CbBW633CbRT9hmOZzf6ObfuxnlLt9qkHz1GsU+AFprm?=
 =?us-ascii?Q?kjuoKdWiInoPAqnkBwl12+55xvjefgUsiwRMZ323TjirprKlnJqTNxn0aUQU?=
 =?us-ascii?Q?PQtZNOXhWX+yPq9cd5CBaT6FRn7G4MaehKbu+ZDfpMA+gx2TgwsfJ7j4JQ6x?=
 =?us-ascii?Q?FeyH1KfKvMRRvdIrtXJGkuebU3ck/KZ38SMRFXXf5VF867WF+QlWZ48hFCBf?=
 =?us-ascii?Q?sKtgP8SoxAqmhoz3gWr6nrBbLAebespAipEAZa9ktxdXp6U0eLRaI9yP7jJb?=
 =?us-ascii?Q?/wlxKMaM7FtgUtSytPyBvbW2jBBAIFcYSutyDYNb7MWDC8Sv9NFbL5G/gSsx?=
 =?us-ascii?Q?majce3U6NDzfpKzuF4Oyjiyc2Cbv77j1shmvk4umYQQ/v2RF2YSZIlLV3pWH?=
 =?us-ascii?Q?PtUEPQaq98yaKM7noV8xCZSNTXpscCK5nMuS5XgmRGeK9yGuMnhTW8vsv26z?=
 =?us-ascii?Q?1FgUEC6XNJqsobDWqTE1dKF5M0SJkV3yEqRvT+mywRvVEmebWO8Ig+UzBp2I?=
 =?us-ascii?Q?s0O9HswB+xUjKxB2xl5xTAshHkcTL2AIwZ5K+oZZFkpuOeJxtEmvr1qOzcG3?=
 =?us-ascii?Q?DADSrOxHI/T4FN2q61sTpjf1agKvApYNtUwHNcvjk9dIwgg0SpXP+XimKphe?=
 =?us-ascii?B?UT09?=
X-Microsoft-Antispam-Message-Info: CWDZZsObZbL/grsPbeFosdWG3U+jxuW8Ih/wsjpMM4BSLy46GmfHEbh8ACqQ0FPYahUzlXv2VMEWXgHOqznaHi9iQVgiPCChVeILcGBRzMNaRvvJ2C83Ns572bvYIHZOidts+4lSH7o0XlcZqw2HSfSW4KcEudDduZjqRFBI9iSIpMh0fMpVG5drMqIFCTMM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;6:36gm8V2pVW3znIGlF9/m8nMxH6RDy8KKnMclj43p3SVEUD0GbeB+IFjLAG5saYe9V+lu3UK+Yq8XZPhyTEJcNiFptj92aKTSvmz+USYHNqalz8HwztRmRDHmbk7W917+y8gJ7FhPUm0uyUblPyfwCv5ZiSuVkf4so4QV/If3LefaqBNqx+N5GU+vjAKNCrh0G5XgG71TY/vaSXtfpaVIf9hGG0pd3mqpEoLzpgjHedYGbtP8n9awPMCSu9sweBGpraz7SGDNK2nCIjd7tB7LTaMSvTrB/1XsGe+B14yq2RK/RjcBcbeE/UZ4qAkWDClqvtKuShnT8PbD2g4iJKiwT5t/+KbaP9kiPH6zQuha20tLIcQADUI2FMuJGDWrxN+CSen/wf+h9q+SUrq6mg3BKgfEfAR0ujD5HVwcmgBebYgoUJOLOo8ViSqZLgl2FLg+NOIIgwfycWNLdnYlaXgiWQ==;5:puDdzAstX7r9y0WrY5pE/Ptc3KNlZoAgxymiJY8Yccd3N+wH38ofW5kvE4kDi3EIEjvikEro/8jExb48buSxDUjk3jWzm9fR/l+YbWc0uQQwyWGLve6GwzTRjWPlE/6GSt18KFAxeV8MF0dz3VBBr4mFu/r7tVcCH3whrds3f98=;24:NU5XYJMP7xGGHTFj1Po13z21Fx5YcmL96tCQmB1zn0aNQx2fHmAmHDauBCaKSO4lpsQ1MfDtylHtcRpe5c7FkPrswCgOIKVAbImexj+e/HA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;7:yPmipzpsWu4bqs4x2uAab4SCpcqVjM3bOj91LrBtwuCbmJN9+xP5rhHP+piRRALqsp+3c9fFOwbysxfZ1eHm86KMzADRp455JR2JVjRzOtYZ/KKKAHQDLfE1dSeC6cz1Hyf1lg3d8jthUmX5yZsbSIyqZWDAE/1q5IoUP/NxhBDsYybXYLtiqFNrX5gvEHpRF/ZbfWN69cbVvgLAt00CkStcr0qJyV0aLSAvvm+TBgRlrvzMCNKWkGmh8+S1mHSR
X-MS-Office365-Filtering-Correlation-Id: cc65ce38-ff59-4885-ea37-08d5c07acb62
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 06:59:56.0780 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc65ce38-ff59-4885-ea37-08d5c07acb62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed 23 May 2018 at 01:10, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Mon, May 21, 2018 at 1:03 PM, Vlad Buslov <vladbu@mellanox.com> wrote:
>> Initial net_device implementation used ingress_lock spinlock to synchronize
>> ingress path of device. This lock was used in both process and bh context.
>> In some code paths action map lock was obtained while holding ingress_lock.
>> Commit e1e992e52faa ("[NET_SCHED] protect action config/dump from irqs")
>> modified actions to always disable bh, while using action map lock, in
>> order to prevent deadlock on ingress_lock in softirq. This lock was removed
>> from net_device, so disabling bh, while accessing action map, is no longer
>> necessary.
>>
>> Replace all action idr spinlock usage with regular calls that do not
>> disable bh.
>
> While your patch is probably fine, the above justification seems not.

Sorry if I missed something. My justification is based on commit
description that added bh disable in subject code.

>
> In the past, tc actions could be released in BH context because tc
> filters use call_rcu(). However, I moved them to a workqueue recently.
> So before my change I don't think you can remove the BH protection,
> otherwise race with idr_remove()...

Found commit series that you described. Will modify commit message
accordingly.

Thanks,
Vlad
