Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755522AbeEHQmQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:42:16 -0400
Received: from mail-he1eur01hn0204.outbound.protection.outlook.com ([104.47.0.204]:54213
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755350AbeEHQmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:42:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=rkagan@virtuozzo.com;
Date: Tue, 8 May 2018 19:41:50 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org, Cathy Avery <cavery@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: Re: WARNING in __mutex_unlock_slowpath
Message-ID: <20180508164149.GC2184@rkaganb.sw.ru>
Mail-Followup-To: Roman Kagan <rkagan@virtuozzo.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        syzbot <syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com>,
        hpa@zytor.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, rkrcmar@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org,
        Cathy Avery <cavery@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>
References: <000000000000170595056affab1c@google.com>
 <59d3e273-293d-7597-7d69-b5278318a026@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59d3e273-293d-7597-7d69-b5278318a026@redhat.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::13)
 To HE1PR0801MB1978.eurprd08.prod.outlook.com (2603:10a6:3:4f::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HE1PR0801MB1978;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1978;3:bmPzixrEkJzBonqCANH61m/8dssviVVqqBvdZl1gtpzx/m+ei981KD9+lbOri2I+NmPzV6xlyPzVN/wUlAcnFjGCwhqJhqtFa9nDOpzMq02nUCIBk5IEEq8brdDv3EcGLZsk00VAWZO58PGcO9XxkMf3LvfrvweeqiHPaOlNVWDrrjEQUL3co36dwS7vHxlhA4mqH3cVqonHPLDAnZXoe+KX62BtD7DmV8Tz/8NF28UUo4NlGLTAHDqqngSaHSjm;25:XDOqsaz0P9iM39he3ehHphtpnqBnmOSNbPeqOgk4G2KejadNxUh0ljsZAFEsRE3CmIqxr0o8V/CiYpxMX8GhIuFy9XAoLssPHu7cFuoWVhs1ZeWp6H1snSo4c9IaobHU1soNQPRAkfk//R8SQkCbt6nbAfHNnSigbsa4IKCjAMus8D/NNo3J1D1b7fjnvQnv1cHvHX86/Ce1RZfQCnzfj41A5bhSOeIx/D1VQ5K+SX6Atcf682L1lYAcdfxwoD8Lus2kYSFt4i6nJMb/0dbFFr6fcsJv3guyUuJjlqgtEjiArhz1jSalP5oUgjNslHzIUvK6GKo8de6dw6rv3VBY2A==;31:VmqdyHywVgmgJsMZdGyJ6M1ynSQw6rRnsZcfZwm3DHNmIuKxmMOKjKzFX46IcXqjmhFCLoGBeeC9w/T1GkmIuYKoi+48uuNOLGBoDi+4UyV1TPJA2QM7tfsCfCewjxeKChMCe4VunjKqTDKWROmTNzNV1prWsMr9s5PZW5Ea+k5ztm7qISRVmkCwYOT1GvNkCtwj0A1KUBoQqJBm6N9J0a87qpLtEysvsBHUcCN5s+o=
X-MS-TrafficTypeDiagnostic: HE1PR0801MB1978:|HE1PR0801MB1978:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1978;20:4F4DxHqj972Z3fT4feQa9QUN2tJZy5vVNz/4UL0ciOK4/GP/GYNyL7FxL0MD32YarnY0gEqXy2xeaBOSaIK1eB0bdZiUn1tWj6ez17jg1wQgu1tD1YqeEo022s3HABiMnpXzGF+e6rF8yIspeYnfaYAmbb4NdqEXtB8jHjrfJg+ne8qc4oG+JKO7cpBvuxytRCdtRrc84+tb1oBd0nLBcFoJOf75d4/XBNCd7KLFncrtU+IUeXTONJvgToy9OUKguzA3xvy1OvBME0CfzI7iLj93wyv5HmXNTaLgwjHEMSCVRtyncBK5oApwpayOQcooopOtuCP1GA6XyNns/IuYxx5QTmgPaa8OHZ0x3maGXhv+BbKCnXVqsu44nFt/zIajL3aAkmM/PYdLOlbKCcPIo4XbFxQjykOqzhpwl6l0v7diPcvWlTHbQtwVRCTt2DCezYzfHMRGPNyFK77KA82BaJhbiktsQGjVVoYHENtU38OD9+nB9zo5ChjaUsnlT/qq;4:oPfavQ1qmX23kHX1WiNFolgiR5MHuOGNMO4gVXORYddxg7xZyxy17K62K3fRo64PrXfjKFAGA7l33lLqZvjQOMnX5Tj5Hgu0kfQ+3aaP+tEvf4E/YWznAiTPM6McLuHtix+a4DQxdhmQ8mJlB4fDIwAJNVlfBEm2jsufxEwLUjBJMWoSj0rRYWhZcI2NxjCgTWhhuzrc0bVdwVNrUhAJItkOp8uZYHQU9TybWe7T8Fc6ACYmq/bXnj1iftcQBW+hSHuGDWmN+XRfVGVU/SOU4Q==
X-Microsoft-Antispam-PRVS: <HE1PR0801MB19783EEC94A0D594F9ABE327C99A0@HE1PR0801MB1978.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:HE1PR0801MB1978;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0801MB1978;
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:SPM;SFS:(10019020)(366004)(39850400004)(376002)(396003)(346002)(39380400002)(199004)(189003)(81166006)(229853002)(5660300001)(1076002)(7736002)(4326008)(8676002)(2906002)(33656002)(478600001)(6246003)(53416004)(81156014)(7416002)(25786009)(966005)(53936002)(105586002)(106356001)(6666003)(8936002)(36756003)(6306002)(305945005)(11346002)(8666007)(23726003)(6116002)(9686003)(26005)(316002)(16526019)(186003)(47776003)(68736007)(97736004)(52116002)(59450400001)(50466002)(16586007)(58126008)(54906003)(55016002)(6916009)(53546011)(386003)(66066001)(486006)(86362001)(575784001)(446003)(7696005)(69596002)(956004)(476003)(6506007)(55236004)(76176011)(3846002)(30126002);DIR:OUT;SFP:1501;SCL:5;SRVR:HE1PR0801MB1978;H:rkaganb.sw.ru;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;HE1PR0801MB1978;23:Uhf17Dl3RN/xbMuFZOdl4fECMSWO+Tzom2Jye1l?=
 =?us-ascii?Q?MmwTe1OQdWO8nx+4lki3jB0DUfMUcj1d042sbW/ELcEqP47EOaITar6pOMc4?=
 =?us-ascii?Q?Dz9j+eY+Zv3YPK3EIbiLckpcXyh49s83HM0eKNiXiQMHmFBfvpQELY5CG2fE?=
 =?us-ascii?Q?cP7UZNO5xTrkkwVUBSESnZ7rVYr7Ex8n698KZYVti2YebXZs78+YiIqbtUvs?=
 =?us-ascii?Q?1IkB+iiY+BUGTBuBWtnWzbaXlzxKU+VUDkPQF5lMgW75NXGShOD7Gwi93MUj?=
 =?us-ascii?Q?8CzGkw5OKkOo0xqNPvudLSNaFdce4GdhklRSdy7epz1J4gy7fC5OcbwjncXs?=
 =?us-ascii?Q?AR8XU5c3oQyZeazRiq9Yik4noB2okEg1JEyuQahFG6zvcSQREkzH2qw30LNM?=
 =?us-ascii?Q?Iwa1Sm7u8fV9Zow6OvFvtuc2XgvqiNUl8/xIdvN1fTpHDb7DcjIxMqvVI73f?=
 =?us-ascii?Q?v3zqH36WUkHH+YzJu/dunpF7ebSfTqM4csVcKc33c/02gl0aFLB/H9ZiByT5?=
 =?us-ascii?Q?ZJgn23nR+gB986wJ8UCZ6aQsfkYsKjJnS9FnVQ+ZSI8rpIZtU/Hpgh+YENhe?=
 =?us-ascii?Q?5i+eHulz0kgToHodzcfs9OGokthRx4UM9gbrTHgorGZUpYvrlbxxN+/gtjzN?=
 =?us-ascii?Q?H5AzvCynDlHYZbSCcuI6Lcr5DNCqbpXxczN3c+14MVMxm77m77FYbWF1RyR6?=
 =?us-ascii?Q?smq/dkuVzr+hb6B7p9DDEpb8RFyCxGSvDqD7pEWd8N7cMBlOJNkPAKzIFhZP?=
 =?us-ascii?Q?rcAYQDD+IATirYlPpVH+wzcIAnQf5L6pTadojzGAgLvC0RvZBJYteGZ4oWH2?=
 =?us-ascii?Q?axZ56avBxgulD5Nry/Ljjm1YRQxglHYLfCPpK2UQTOHDwCynSUTPTT/TRUjB?=
 =?us-ascii?Q?swIODx0h/AU8heJKjaC5zEbjZNCjwzRW51f8dCtz5mf40395xCZpC2ZgUad8?=
 =?us-ascii?Q?g8KoK34+I2y+M64oYx8kJNmhlouaTkkjsIDAko4hCVR6tNi5BlO+BMz3J6Sx?=
 =?us-ascii?Q?j1PmG5sG6LEfuNH1t9kt7wg76V1L85cpZmHV2wfNzmw2em6W+hjl9ZSkJ58y?=
 =?us-ascii?Q?FCqMYV2/P/cmcD++YJM6G036WVNf8S4k4FFKe3yNsof4pn/kHavvz+b3DjBT?=
 =?us-ascii?Q?TajrV+SVRJ7qFc4IwWYvpe9Qd1byAEblri5OALUD51cEqz0ZtufX3L06JRxy?=
 =?us-ascii?Q?vX+2SFL07b8r3XTmMpdcLpSBGu4k00GZ2+PKYgWhwp/J7Ia710dLu9Swxidh?=
 =?us-ascii?Q?PMUHHDBVP3cVfnD514FBnHhg59iz+3U7wCEmMNGi7ZrZ8DPc+rsuLyDTmeyv?=
 =?us-ascii?Q?RONUd0gwIc4FptBdTTct/vyeEse2V7rrCZYST2LXyBYMlS/Ap156jYyQYrC6?=
 =?us-ascii?Q?oJVNVpDFJQaul2+FNGbRtqIMh8nRWWLrY3SRS6h23pFh1RaEPg/xG3vX022M?=
 =?us-ascii?Q?MYyOC0zoBJvdBSLxKAOBEjBtdywBEv543D9rPYfmwVWxeWjr9C5AmyBU8mCK?=
 =?us-ascii?Q?UZiDx402mGSRzhwwGkn8tBqMmtwB6NOrvbEEgo9xo93s/9K+OAZBqF9Ad?=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1978;23:uQgmDkwZMnIxC2x6jOXB4JV4MXPAbAlD6kGnspfNi1vxDAExrlnp7j2d6uosBIUJ9ESj+IBmbwm7MCplL2HIjE/1fo37o9S4xwYVgbvydmsDmKTckArozCCktOTkPqbggh6Pv7h2vJeeaok13FeDMA==;6:bMCD1Sb2vVONak2n3hfeJjaOnwMaoJ5q5WWBnNcvwv1ZUhXFcsV9wPRDBlAlCQ+sxKULnzfI5dUUeGYpcgLs+85AMnn2/fnbtdNLO8h8fv34S69yDRzy1U4BIEQEbz6WHpNct5v+OKHgi9pJVO/ncLqG805lMQtmJN4PIRZNVERxSeq8D9yL0QfijJVazM11RMvQjZ0i2XazZhvl76DXzct5tkIRI26vcZ2X5qCiwKP3PGGYSP5i6ewoix+7lEg4IA8DDtKnUHK9Y68qA/O6gCPBUbQitLFKRXKzFtpPjEt+TRMwI0yDQ0cDMp5f1mBYmbjMmq8F1mJ0r2P/i1bXvcc95UMJgr9EPK7F1+Z+S82UA9DyNekBv+gBN1fLmC1ov6VAdEa7nJJ1fIwWi5HHiOa7gqbfMRiwWyJGxW0hAJBvw3egnGdx1BhKL+VjuwE1Apb9WDCHg+EzhAbC64Wrd898igBJpzq2Rcz9IzcRm00WsqGLLqqkW5yl0F8H0vUZ;5:WYZlq2ascRTsUhfrMXQ+M2nz8IbS/AmuiC6S29HLDQubto9Wn50xWGjiUjJS77oNn3PzzEdxEIsccnE7IED0ruCG47KbBZjLFxT+8aXqEzUp2fMV+jf/6Ne+sgCCIqTvIM/x5Cj4zYd+zLzftYpEqnfKsDv5OZPxYoKHRoibyYs=
X-Microsoft-Antispam-Message-Info: KuQ9BOh244HL0x7H9tbQrsNSXebIO7tpdWMDrIWPfa2dTy6rsn2Lc7Ks5CNOKjI4Z950LWuIfaFOp/Axkasx8sgyPCun3gpT8Atg/njTuFPmH+Em2p/OLbKJcpekevVSyY2o902rDy73wmDz73J8hRFKVY+h0ysw7W4v7DNcA4XIEva5/1+BdFENpEkk3P208WrVP5vuF13haryi44DvIntNd6Sr9sKAXn932Zh1SAWBSGxD/qvRc/SjDT+mFtYC1nLMiotmMfSdVPJGX6wm/fD3Q27oCUehYUuTIxYTDtINH45fX7KX5cvdOR0TCGYQ59aaWNvoBwXGMWgDKEOIQsiqO3mXVRr3ms2Ybj1DunyATseV/P/MKfAvJ14B8zHm6vnckWQhdTJ+G7C4M11W8tZHpbkhPZGPSDUy9Ttt+ZQ=
SpamDiagnosticOutput: 1:22
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0801MB1978;7:J4E+w1TRJdsDk39+jWaOTBwvlvPuiQlGAq/fdJ4NMZ2Ms9CX+mZip3wt1eKIf7OLfMNYzIExa4hU23New3ZAc4JVAcU6PgSmVOeDaZFAsxpALQd4zdq+CCTP4HqK8tzxS/gf7lT84YjyNdYkyaIXLatv/ZKrPZ8EjU1F5ObY2EczftFk5VtThcvNPzkD+6Fx7epzINVcWAOuxjeG1Gj9qG64FtHyXVeNmUnP2/hsDSC/1OL+Ciu29k8KBX7e+D3x;20:pmYnf8gmIPcLSYTlehVHsrpxmi6e0jTXw3pM9LKAoy725fDRoR4iSo+kifTPwNnXY7uh8EiUcQ3EtR6a9biIMFq2hgaNV13WI1q2wkyd661W5Wu/Augdt/2unS2Las8dqgiX5L95jyyGtMDt4pUOCqZ0hibUzNaHYQHxUG/Hgyk=
X-MS-Office365-Filtering-Correlation-Id: c1a89448-09f1-4767-d03b-08d5b5029f66
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 16:42:00.7451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1a89448-09f1-4767-d03b-08d5b5029f66
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB1978
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 07:19:04PM +0200, Paolo Bonzini wrote:
> On 29/04/2018 19:00, syzbot wrote:
> > syzbot hit the following crash on upstream commit
> > bf8f5de17442bba5f811e7e724980730e079ee11 (Sat Apr 28 17:05:04 2018 +0000)
> > MAINTAINERS: add myself as maintainer of AFFS
> > syzbot dashboard link:
> > https://syzkaller.appspot.com/bug?extid=35666cba7f0a337e2e79
> > 
> > C reproducer: https://syzkaller.appspot.com/x/repro.c?id=5686569910403072
> > syzkaller reproducer:
> > https://syzkaller.appspot.com/x/repro.syz?id=5767017265102848
> > Raw console output:
> > https://syzkaller.appspot.com/x/log.txt?id=6346308495343616
> > Kernel config:
> > https://syzkaller.appspot.com/x/.config?id=7043958930931867332
> > compiler: gcc (GCC) 8.0.1 20180413 (experimental)
> > 
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+35666cba7f0a337e2e79@syzkaller.appspotmail.com
> > It will help syzbot understand when the bug is fixed. See footer for
> > details.
> > If you forward the report, please keep this part and the footer.
> > 
> > ------------[ cut here ]------------
> > DEBUG_LOCKS_WARN_ON(__owner_task(owner) != current)
> > WARNING: CPU: 0 PID: 4525 at kernel/locking/mutex.c:1032
> > __mutex_unlock_slowpath+0x62e/0x8a0 kernel/locking/mutex.c:1032
> > Kernel panic - not syncing: panic_on_warn set ...
> 
> This doesn't make much sense, unless it's a "generic" memory corruption,
> but at least the reproducer seems to be simple, just (in pseudocode)
> 
>   ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
>         { fd = some_eventfd, conn_id = 0, flags = 0 })
>   ioctl(kvm_vm_fd, KVM_HYPERV_EVENTFD,
>         { fd = -1, conn_id = 5, flags = KVM_HYPERV_EVENTFD_DEASSIGN })
> 
> Roman, Cathy, can you give it a quick look?  (Reproducing the reproducer
> link: https://syzkaller.appspot.com/x/repro.c?id=5686569910403072).

Something seems broken in the IDR machinery: IDR with a single id==0
entry reliably crashes when attempting to idr_remove a non-zero id.
Other combinations look fine: removing the existing id==0 entry;
removing a non-existing entry from an IDR with at least one id!=0 entry.

I still haven't pinpointed the root cause.
Cc-ing Matthew.

Roman.
