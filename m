Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752260AbeESKNG (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:13:06 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:19808
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752103AbeESKNE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:13:04 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vladbu@mellanox.com;
References: <1526658324-6570-1-git-send-email-vladbu@mellanox.com> <CAM_iQpUKjFPKAONSW42_6Mdp-VTTvaOx-GPDH2bJqW7LW1QYBw@mail.gmail.com>
User-agent: mu4e 0.9.16; emacs 25.3.50.2
From: Vlad Buslov <vladbu@mellanox.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Linux Kernel Network Developers <netdev@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: sched: don't disable bh when accessing action idr
In-reply-to: <CAM_iQpUKjFPKAONSW42_6Mdp-VTTvaOx-GPDH2bJqW7LW1QYBw@mail.gmail.com>
Date: Sat, 19 May 2018 13:12:49 +0300
Message-ID: <vbflgcgnece.fsf@reg-r-vrt-018-180.mtr.labs.mlnx>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [37.142.13.130]
X-ClientProxiedBy: VI1PR07CA0175.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::23) To HE1PR05MB4700.eurprd05.prod.outlook.com
 (2603:10a6:7:9a::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR05MB4700;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;3:27HngoUnW1hwP4gCo9rr0vLjC3CcT73CSsPPHrcEPemcvPitc1FfKQR0F4TmaDnX2rK57f0/Quf3yd+2/vKoVoHnC9+Wh+2PTr4mW+aLPq7Nc7cxYpp8tEka9kp1qcOFdaqziVsYj4C4hq2zrYHLIBx6Yi/iqi8H3yG0CC5HU7wW7kkWAiXSMHQOoy/bivM2UaDI+dvZGvns7vcFVI6hW+5ecEZ8kWWmxlvuPFV9dxnodH4ltY13fUALWXwIUHTB;25:Ne66hKjGh9d4iS0tgbAL3PFZLdLvQHVZ98kVoiwla6tr0NtZPk1rzA7ZorCuHdLhfmxefBQimI90H3kw78WFAsLKmrAhF5KHExFh5L/FFGpVlnQRlpyjSXiQ2LuoljrRRdAhhUyTW5mGC0q95ouWfKEOSebUp69RwVOOZjMXVE0UdlZMtKRo80hrkzOD3qUMl+E8zHVmwPPtctnV0OjLqvgC+XBP2HntNhxhO5nIRbMgWJlDkQVgyitns1kKgjnhVsPWNiTuDz7oqgWhvz6SoS4y8XLk8Iy+arvrFRUGI4SH1UGbmkK1AyhFHS/95khDcUdL51pMWBVPfzHx3zBseA==;31:jrecqavWa0cnW1SIWoHksOoEYrUNJ1PV7Rwxna/81R1Xp+JZFDoV287mDU8LxPMyYD7Um/xpx+p62ermVbQxuQ3YIWNZJv7g4x3vtUFwFOyjWaUmV2a2ibeuqGCoFQ+h4rKlCmHtkTh2073tGsGN+8SzaSeXe3OoaYEpMfDMq4Xc4XDfnYTAQsySzBjJD1V+D1bUtIOTYJvwZDzgyeBxDV/UzAposfs++/Fzke6s/jk=
X-MS-TrafficTypeDiagnostic: HE1PR05MB4700:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;20:7mt+lAiKvNX5SNOWMLNBlbdZVIT5b+pRqSgf32aKSd6nVYRC0JNKiMTe6APlfAyEQmcDvxHHHlX6cbCzkTjEukGvLztgjkOgt1uzWi1T+N7TcD7/pllwFOyLQz+sci3C2RHc51wx/vn84jUtAPXBFKwaMT4/IZYIAikJE8ZsCNugFcGVxyVVacDpf2jo2ZNO3LJn5VKFQY+jQd7O9gz/2M2qHB/O2Ct3DJ9YJkcDu8SVHd0OldT/kMv1zaTBEuirR+crlVDvKtGVGyCWd2thCJbhBWoNUolQu9eyRxTyer7XSfQnUZj7zzYUSJxfQMdt5hHKUScGIsWZK+XzbJzTauKLP1vqWWBAdrHH5O2eo8r5LFDPwSx+UtKGT6xegPRddxSX0Zpi8tzZo5t2IbrkV/gmIncNbsvCZtSIDIeeW+qZ3uzrs0U0JRUftw7ZwkMc5AGa9utdrvql/6xPB6WdLvEiPjJfhSQiNF6n2EM/jmNmtK/SmpQ0HxxP/i6V8VBT;4:iR8cspbjigW0Y5tFAh65o3aQ41HrAhPppGrACzUsG7TXBkNhUQAET0yFw3AiNBVqP3nXBu04p1Cx9FQEeO5J74ZZ9u0bhDYk/I0TSCwS+iEmYNxpjD3qbhzlFCk8TH8K+qbg6GhHTV4ihO0guN1DwxVLgA7QhCaIA48NuFqSJi+dC/526jGHMao9S9tdCrsqM8ewMjaAUsirEP3SxoSfe7xV4K4MaIf0XrfsSzlj1LvDYeJy8C+z8UC/hoNtqc/oOY4aIIjO+stMYfiVjEGXyz74rdQLMr6KmQYgICv8p76ZCmZ5/WZQ6KLZzEsAqU9Q42WeWjwBEQFyfEV7w56EjQ==
X-Microsoft-Antispam-PRVS: <HE1PR05MB4700C05DF770ADB8A1B665F5AD970@HE1PR05MB4700.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HE1PR05MB4700;BCL:0;PCL:0;RULEID:;SRVR:HE1PR05MB4700;
X-Forefront-PRVS: 0677FFABBF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39860400002)(39380400002)(376002)(346002)(396003)(366004)(189003)(199004)(48376002)(97736004)(68736007)(16586007)(478600001)(50466002)(8936002)(5660300001)(11346002)(446003)(54906003)(316002)(58126008)(476003)(486006)(86362001)(956004)(25786009)(6666003)(26005)(305945005)(53546011)(6246003)(229853002)(6486002)(386003)(66066001)(7736002)(4326008)(51416003)(106356001)(76176011)(53936002)(39060400002)(52116002)(2906002)(7696005)(16526019)(186003)(81156014)(8676002)(3846002)(81166006)(6116002)(47776003)(6512007)(9686003)(6916009)(105586002)(4226002);DIR:OUT;SFP:1101;SCL:1;SRVR:HE1PR05MB4700;H:reg-r-vrt-018-180.mtr.labs.mlnx.mellanox.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR05MB4700;23:aX56ZF2Ir5iEeUeXDQr0I4fULlXl7470dZrWnPpcF?=
 =?us-ascii?Q?bL5AEjxdccCjKtyCj3QjWqjEHhEE7cgNBelpdxrX1LkCGV1kJ7yP1o5ysU9D?=
 =?us-ascii?Q?ueHZi6oPUTAKp6wnVhR5mujHWBs2HhZABGQym8U9Aah9fovhTcSMRg/NP+Pb?=
 =?us-ascii?Q?exYd11tTuAdSUeu2Oa8qpgp4uguCHXJQJ7u8m42RP6MUQgSJ8sf8dFUfpaR7?=
 =?us-ascii?Q?C700DrhvlJ0fF2797eK1TAQSpiAjAhpR7wjIw+tVNo/aF1K1FHtULN6LA48t?=
 =?us-ascii?Q?oFpbFdbcP5ddiCUgmablANi+FEurkbKKwon5Rb+t9CLFhW1c4Zu2qXsJbyuj?=
 =?us-ascii?Q?pTSmBtf7IeahIpnzJY2uBZuEQ2DhbJY4BcQeqxVwdj7DXwF3tTmK2QIMH1AB?=
 =?us-ascii?Q?HsSLxOLsmpsPDbcQEwNhwgIHsEn2adxU+mCm4Z7eOCP5M4WKSchxPHPPJseF?=
 =?us-ascii?Q?Z+d7L4xZ4xZRKpOMgDflrxATtDc4ku2Go741RoOJGaw8RDBcg3NOcjCnSNyE?=
 =?us-ascii?Q?juYY5lF58UfyvYYsOHarGF64NYQoIgz1PAEeah+Dm2Daf9ydZm3DzmwYHgXm?=
 =?us-ascii?Q?WwKPhjbf5mREmUDou44v9CMO3IGU0WfOoWnQj8Fojj+kBfWKzPt4b1b9D3xy?=
 =?us-ascii?Q?tdlOUIo18bvEDCLaK/1kQXVwcjOdnWW9wGj1hNG3Y3gf7lEXsd/28yzqPMfk?=
 =?us-ascii?Q?A+8xYFw1zC8A032yDibgzKDS1TUPl87iBJx0vGBX5ORbbS/nJwtltwU9Hesf?=
 =?us-ascii?Q?D+2kQWd9We1d4h6E9Xn05Fiacf5RBoO8u49C9vmFnTWY5rnOZKZ6eDPZsgmg?=
 =?us-ascii?Q?F41cOAo7J1yF6vVOPvTQ15l5FtcXzGpl/XvBayOvI2FiXh7di9mLLmxWxSUg?=
 =?us-ascii?Q?MGJj6SZ3FoycHEVImmEi/3GfS8G3n/f7ZiUtORBVHfR7Srm+YPFU0TkjcoGX?=
 =?us-ascii?Q?0Bty1eD1Su/3BweoF0DPYDyPqYfwyKcFSw9ACM1aZL2EFX7cmulwPjNz/eO3?=
 =?us-ascii?Q?RL83LTS7Dh4gNQnToPZOWjFa8Xo3AsWecYlB1Dv8srl2X7DE+YPmzEjt+WSY?=
 =?us-ascii?Q?spKh+KKuZYe3OFuVbd/Cj0JqOcH/POH3fDoVKBL48bf0gcwu17BKznP+Tdlt?=
 =?us-ascii?Q?Au/IfxrqTwLZcTq2dvX4U+57qi4Ok3/zN09B4degfVYU6iS+VyI7MBm3y3iH?=
 =?us-ascii?Q?LoTONfcSCpom9An1ZtGd0mCJpy0G+x7ZzMYhTwTCoBO+mWI1fWctL+jQEZz3?=
 =?us-ascii?Q?eLS/oZWA8PodG+JMadNWTluqhZI75sgrFXi0uZ69ffMTc9V26c7kP5alPyoG?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: zuDDGi3ANd6I4T443Xr0xKc1FPMqWqJQPG/cusYSQfAl4P2g4eAwLLxLWvw46ihUcvdq3xSt4D7WyGVmmOYuPFWLmWI7N67k9EhkfbCA5HIkvGnH6kKEb92C2GVAzky+YSzy+WGWZNJwXPOFFZmgm0/dH3Y4TRbLQzaou+pSmYig15mHOt9rz0qihLV/jxMv
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;6:hFG6cbHbIZmN10sNpRWJIj5x6vKSTazNaDdeI9EBsT/mpNTYRqjhtkdB3FY+KD5I+vD9BGqDC2UlHwc+1PCaA8jJESaYasVzvoTKMlEcyoQouR4xsWwH73SxOxq9Ne1E8dVVbjTIv8Jz0hVEsH1LvZ6KhFMDzT6vTcfoy78ox8iptbZeqRCxJzUj9hr0DzHfkyVaZtfK6YKsLGz2UaGJH5yrsE4PNxyFdmSVpRx7LU5cTHEoWOQR8y+UdrHwcXb0c7TPy7CQn2ZOmJMypAxQyu6QNjk7EHxhVNZEa10KO16/8svs0AG7NnNcclIPXjF7L9xS4wChJcG2EIxhfs4MS27M0Rw+x2QphWScVZzAdJuPa5mSWsOwj8id2eH1ICQK5Trmhv1wN4wzW8GDKG1TdXmsR6v5zRJtO2PypqSveRhXCTV4LpSPVFUhLoNvLOfgZVwnFGh1I+2clqzgdkeUmg==;5:EkrdRP1VKS3DhGvwJ/VFznsgZ5rR1URI0i5rf5nXzLv9budDEtz+sTzH0ZFWLnEVJFpJO7vUhqf8JMESCWpxdjZd977B3SDTMA2RdxRQrJM++0kc9bgu97NY5Dj/2pdBIczwpzoK0wI4RkNR/O3niepUgDquStqN0ojItjam688=;24:Vwa/GTgwHxDBiMmYG1NrkevSsbKlmpR8vFn9ulxz2R67dH7j2MpM8LwRc+d0ACbb1MRqFg9cXKSPzBqsmw0EXwGO7M16gknxKPF5KHiqek4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR05MB4700;7:bcdKxVVVcvSJmPECNnV0Z8Q1RbZR4FGFaWpRbbr5yVoLuKomxuoZhYKOyh6ARhrlaUdE/NaGvnlEwqlQ3HavDHYcGcconp1oxYzSfpSj1sMn6pl8JKQObzLK0of37wkH9Tgn8Pk7MnbTYDi5sjTblNo8Bi2xtp2+OwHzXejHTJCUyOXBbnZ9BiWfxp51dlEoW5mWesoPdkRrLBliIYXacjmloZljG30KAZjea812Sv6GAJkTNnk9vj2ReX+xvmAL
X-MS-Office365-Filtering-Correlation-Id: 9fcc7ca9-21d3-4757-5bd5-08d5bd711833
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2018 10:12:56.4172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fcc7ca9-21d3-4757-5bd5-08d5bd711833
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR05MB4700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat 19 May 2018 at 02:59, Cong Wang <xiyou.wangcong@gmail.com> wrote:
> On Fri, May 18, 2018 at 8:45 AM, Vlad Buslov <vladbu@mellanox.com> wrote:
>> Underlying implementation of action map has changed and doesn't require
>> disabling bh anymore. Replace all action idr spinlock usage with regular
>> calls that do not disable bh.
>
> Please explain explicitly why it is not required, don't let people
> dig, this would save everyone's time.

Underlying implementation of actions lookup has changed from hashtable
to idr. Every current action implementation just calls act_api lookup
function instead of implementing its own lookup. I asked author of idr
change if there is a reason to continue to use _bh versions and he
replied that he just left them as-is.

>
> Also, this should be targeted for net-next, right?

Right.

>
> Thanks.
