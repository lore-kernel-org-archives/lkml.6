Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-679374-1521132427-2-4302567996585560335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521132427; b=JbLK8RhN90Vtm4SHmhgveanjvPTcZSp5dizE+lJZ8P4Z/P0
    lNcY9s6H51dkeGzTCHYxbHQlGYnp3fSSdayEDhaioYo07mNgGKk0aaK8KyDcNsbn
    AfaC3XH1tRGyq5CpRH5CLQkQnh/UB3h2f0WJHlL5zZPLgB6RG75hfSnhXWCOABR9
    rhqGrPCwTtIWmR28yWb4UbisKH8GHVFdzX/Btvenhe9CbEeiznda2orGm31RyUzP
    8zBsp372Zr1MTmAeUF+klz7YXjxGzgohtw4/fojH2sCrNSwr2FwpOPobB4Gn58qJ
    IRuHpsOag65JM8FOVjwFWTAa+6GWvCsxP6W+qoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=arctest; t=
    1521132427; bh=maB/f5p/GAAxFLlT7fW8SlKCdV2tRIBcqxnjHtpif1M=; b=U
    WdCX9rLgznjJF+wRzposm/xGr5ub+qf0Ll2VGmM7ShzBnuk7GzVLmpCWFIoR/MCo
    HSfbxxmgHIFaC683wrK7+sLSfuSevkSCgGp+bc80YaYOdFfCKKE4Li7/vc1OGT4V
    HUjKfV1UU90litneFZ6oBYNS+DnxaDsu3wewGQUIJq5o9EV0HsU7DDxcvFWNy7lU
    UCqjMeAHDmK1KAwx7Vq3v9JtDYGMQNMOmVqYa8Czkh+pceCMJ/MuZvWFd7h8GiJL
    WFAYTBR2gZZG+3CZ8tBtgRJQ9MnWroiMUWKUp9c4yRViazoLYvlWo26bX6cNBHq+
    yiQX5YHOEjCYaYI5XSuOw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RKcetwBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=RKcetwBv x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751829AbeCOQpy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 12:45:54 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:63912
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751770AbeCOQpw (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 15 Mar 2018 12:45:52 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>, stable@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Subject: [PATCH 1/6] mm/vmscan: Wake up flushers for legacy cgroups too
Date: Thu, 15 Mar 2018 19:45:48 +0300
Message-Id: <20180315164553.17856-1-aryabinin@virtuozzo.com>
X-Mailer: git-send-email 2.16.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:3:fe::22)
 To DB7PR08MB3257.eurprd08.prod.outlook.com (2603:10a6:5:1f::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66604a19-70d5-4d5c-0a99-08d58a9434fe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB7PR08MB3257;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;3:Yc0maWJSh1CgiEUOiY6JlNqhdSUFI1vEOKu+X7F0T5YThc85FA8taSLScK0CRiMHYHS/GQk5PyEjiqx41qHVso5xB/cAiEUpeBoEJhgD++SUBU+08WKm+9a9SR43Lehd3UbIBy2PTQj2pA0d/8vM/+pvBXNTTllFPyO20L2vKeJ2qD6hsePxZNYKxWylg1A0P8t4jSubiljVwQyJVkacj7evzRFC8Gtpf8qy3aCxePlvtsPXUHpkLUb23Nk4LacQ;25:jOYgxK5ivHGqZpBwxbJfrsrcW0N88JmS4Gg3U20SN1ERMLMXbJVlbArIInwQhY0mfHT48qNTwssReAggTjR5BYDKyxd+sktrO3zyrL8PvZkSD+lzOFgXYBhfl9LluomAM53XXbsFma7JtBHSe0ooGv0CrzmclPsd7qhMGfIMUpSbYIJikImlVBukdiVajUF/cWrGeKR89zZ3pWHShW3dVgMsbm9CcsjyWvWHjUFJMjB/+xQhMRi5pMxp/A8KHmRZ6g9BuLNu7hwq3WVyXvMVaVCeOh0hLL4CRm61Fn0M6GfLR765g4pF1BzFQkisAzESvvHi1sj9AHEl2r3yjcfNeQ==;31:V6a/5sXc4mu3g5SRB9jJpG5iwxRHa117Hze+FEA7iaflQMsmMyvaFv8B6kpAMR91lF+iuW8AAwFeyGr+NRajiUhFAOy45joeRziJxMcoUWylwDxpcbSjYNFgM1eqNc9iofX9tK04xnLCmZ3Fjq2f6eIXDC7AWSRBdNdboj0qEYMZABD/J0Jeoq2AiOLVxYyDwqqIhd5XPOjr1PLRFj0T2q4aR/Z6WdGD+nvvgGX4fS8=
X-MS-TrafficTypeDiagnostic: DB7PR08MB3257:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:a0F/mk3qEKPgEI2KHoi3XljCJBX5i7hI9Tleo4RYOD6Yb7cxyvzO+ELXUJPYFgJq4UDQXDMbVVgDuIGe9K2vx0FLpxDsyzCLPHiHKRwLRCzX6riQaAoUbCFIS6uoH/4or+pVzM4Q/je/+KHweGUTL3yuHPYNWLHnTPk3Nv//pnfx4TglsRAvzSVwdUA+rxl79ktfTulc8pNBRCnfUqmGJywqJlvTP5hlIY7xKxJWBbNak9sD7hsWUgpV6or5qnyGe8FcUQHr58fWzM+x+1RPTcTaSZC1XGNudpvepyCt0lt2F7c2v/spDd2Px4mdcAHUggqL+14f+X+lgzIUmKh1zVKV3XMAV8umL7GyF8fMxAGyx+B2kES188rMnhezJIOJuZp9IAm9xqQ4++1kJxzz/u7KPocOV00gX40MVesXPDgClBlEsESqx/rwur3VdQyextfH8kdtQV49WDqCridlrYbRfi0RmltN+lWSPqxHfx6O7un8fQQvgKebX2U3j0U+;4:AH3757z4ffQ+3d6huE7EVz71fAcyGvp4yLtj1jlUCbKhEYJSD0IYM51hNmVdm2S5nR/ynh0e7GHtTir/uUHM7rV/XD8650vW1BVM+36d9LQSqUJDH6E+fw3gxtNMwugoYNL1GjALlggu2fOyLwGNL48GrehuyEem+8x5m1+ei61ugn6fV+v/nm63Zgq3LcsGuD7bKpEZJF95sNXIr5azLb1bnhrmT9AxV7nfHbmyY+N7Ts9twUNJAHqImNmRkOgO3CHIFhCRorHbOKaq/Ax0c++UYBtE0dkS1GBVUY57La6Wk3sVvUQx8hRvrRU9w2Zj
X-Microsoft-Antispam-PRVS: <DB7PR08MB3257BDA90304A4D7FA0E000CB0D00@DB7PR08MB3257.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501244)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB7PR08MB3257;BCL:0;PCL:0;RULEID:;SRVR:DB7PR08MB3257;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39380400002)(39850400004)(346002)(189003)(199004)(51416003)(106356001)(8936002)(55236004)(59450400001)(36756003)(7736002)(6116002)(1076002)(6506007)(386003)(3846002)(47776003)(6512007)(105586002)(16526019)(186003)(86362001)(54906003)(5660300001)(66066001)(305945005)(53936002)(316002)(81166006)(4326008)(6486002)(50466002)(53416004)(68736007)(16586007)(26005)(52116002)(478600001)(2906002)(81156014)(50226002)(97736004)(25786009)(48376002)(8676002)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3257;H:i7.sw.ru;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DB7PR08MB3257;23:3vOi/RBVRk8IUinaIbnoK3juzMHEFM/IX4uZfg3hl?=
 =?us-ascii?Q?TyB509mKQYM3D9lZT3W1Ao8BuRc+nv7PH89GMxryFmsxjZigljL0L3LYVgR/?=
 =?us-ascii?Q?/v5ZTi7/JqS+eK97kwEMiFgPDJl+51RgTXfcDjXt1/bBTfXe3DynY2qLuAcc?=
 =?us-ascii?Q?DVVRsZ7e3I0WHptUO+4FCJTNzh7rfVrlc1dKTbzSqsFrCY8lTS4on8iF7TM4?=
 =?us-ascii?Q?1lGG+wGZZGUuDhC1XSUdCG634DkDLr2VYyzVsGwbFFMIihK/ejD3Jfw2f8Gg?=
 =?us-ascii?Q?FHiGgNgxjvRTwDgYfMEP2p9rL+tL0bWS+6v8jvYdIV5lyqFnjyeVrHN/J1+1?=
 =?us-ascii?Q?4SpBCRYLBxhRodC2N23n97/LQ24S+FYwHilRIAQmhRIgGvQIP/yIHVPBewwq?=
 =?us-ascii?Q?mnpViGUY0HIO8+GzXG8m8rkG7dssJbxVUhsYYcWBQDMDKOHB8DSKAlRpRsOM?=
 =?us-ascii?Q?lQJO+pddFPqxT2ioM4m0cHPeLEFSzp/phtuoAdI+GnsA/5UboavcmqZb2VY8?=
 =?us-ascii?Q?29R7hCDGhAz4lzgbtP/9jdh6Ie9rk4XbcEOVGKmpAN2PTSFJ5NmKKZi29lZV?=
 =?us-ascii?Q?1CtSY2ZK6bpBkYGPYFebt3zn1tA3inEF0PfCce5Y9xWPTLmx/75cBCopFlLn?=
 =?us-ascii?Q?sA3vH3VLms9I1JLQupzN3yYjYPpYZ3E/S41GBejFvOETwzZyUOw9w6MqNoXs?=
 =?us-ascii?Q?bwRd81h7GvFjLi1u0NSsfnOLbIrI0yzoXbdl5BRG4jgXgni1hUGrXlQETfNA?=
 =?us-ascii?Q?jH4rtbJTTZlJmoN/QJSYzbSLcb3htojXoMKxmDiRPT7ZasOQyY5ijl5mhzVi?=
 =?us-ascii?Q?PBQjLuc3IwL96KHwV3TgM+zH4CCvbBOsyPcZgIkbje3K5zYGTy8qU5JPsacm?=
 =?us-ascii?Q?fPOol9yvGhvB78Yv0p2ekvZuvCl8vJ0/kDs6CVWo4WwEX5uyfonlHimLwogB?=
 =?us-ascii?Q?1UnwoBOgNpQONpsL/fO2DaK4gDAMDaFtW9IvT8cSkNhqthjSKsyipE/qwfWO?=
 =?us-ascii?Q?JnndSj0tsNgOwMujZpvAOYi9eh1SGCyP8VK3/dQPbwu3H4vJ6TIsnA99X45q?=
 =?us-ascii?Q?L9iTAgyJzNXWjejLbLSF4AXSo11J5TKal6EZkiUj+F2QgzNy3jlP+ogoJ0Mx?=
 =?us-ascii?Q?Zv+Rh/t8L8hT+vtQykFxgEMhCNO+M3p?=
X-Microsoft-Antispam-Message-Info: g3kJRQVf8Ky8O3qxq6tfeuGcolNr2zeCVsHIHpWUvgs/95QCwog7I+P0ltbSC+E+9el/ECjyRnTPJlrgWqmC8en86xBh/WFyMBpDNLWnl8Ci7Q/O9WaQYDmDjGNkd39sOQc7HYm44r8JoW707yuODp2irhmLl+6Stqnr9fP4KKH5xVCLRcMj13i/WuATDK4Z
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;6:LlrZHf1hzlHoAvNlk76c6BWo3kmWIOE/Qu10JmxLV+Nnwqf0zQ31mdO+NkMNC6CPGF2oZs5+hJ/OQCIfM5gmjs2ZujCioJV/LUwdH301/8SeC4Kuptcp4DiwPehArhM8MG+Ksc5puVt/gzzYpD8CRSPiS722PwRQqMy3aoQkGDvgCVoP5dppNBfJk8PFWf9AX1sfAzijlThd61Yf1//qw+kyflMhd1U6Imgle4R9/PWsugfigEQcr1mC+GzhowZ1CHXVpoZ6vG4JwDViv3V22ptZKTahaWANyJR7cFZLrwVGvuzx1eLUQ/G3w1Y6bfaqV4vKn+o1TP2Q8OCvpUtpwOQplXVrMLEkOYTQhx+hWSI=;5:zC4S4n4YGkkV/9qHyffFuMdr/k9CP/TfNDoEnVHc0cwiTHAQbAqjuUL7GXMVe8RLLP7kcgAkuEpwyj8OOTQ1BerGrxYPYQg+0SX0X8zw/8Og9jxXVbzpQXaJ0l4FS+60E5hiDW8J4epJt32OxOs+4B3ryqNL8uh4MrzsaqzomOk=;24:G3k2BE82q7qYZHGH6PowXmhrFrpjOv2J1C4+H2Qa/Cvt+OfXGJEQExnwHEU9f8B1E1l1agC9HR02uruccDi1bnfnY4zZGh6ugeJbcu70UZs=;7:S+jp8WBbtJ6AFNatSUb29V2dreTjO9vgLDU2Stte8+4Lo5Je+kSqOgf49FjPUsnnCFuXoEDxGIxDYqzYSMShLfXgJolu3yrmCSQXFfdT1W+DQxTF8d9ZR2s7uhrEwkrEAriaa8Y5bh3mSAVC/m5aqOQpuW+bWF/ziPI6Tuh4hB7BR/K9HtJ51PDJFuAgu78iW2yNaFmoJeG+H9lIm86xkO405bT0MWTC2z8F1Eh307k8CWSV9TkEDt8C2aNTf3wF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB7PR08MB3257;20:rIn2UlOxL/4YOQvap0MehmfsZFB/3WgJxdK+NxfrXYxZrcR29P68q1bij9sE0pzC0RFMi8Jtvp2w1tip3wC6dmudVjxaMzOHkv5b0hH29GHT69ipEpO38aXhGJvZ8ydRW8+TXUkDSbj3dkkAfIXwmgQyntVt7I2vxdkL9ZXnPHk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 16:45:48.2431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66604a19-70d5-4d5c-0a99-08d58a9434fe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3257
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit 726d061fbd36 ("mm: vmscan: kick flushers when we encounter
dirty pages on the LRU") added flusher invocation to
shrink_inactive_list() when many dirty pages on the LRU are encountered.

However, shrink_inactive_list() doesn't wake up flushers for legacy
cgroup reclaim, so the next commit bbef938429f5 ("mm: vmscan: remove
old flusher wakeup from direct reclaim path") removed the only source
of flusher's wake up in legacy mem cgroup reclaim path.

This leads to premature OOM if there is too many dirty pages in cgroup:
    # mkdir /sys/fs/cgroup/memory/test
    # echo $$ > /sys/fs/cgroup/memory/test/tasks
    # echo 50M > /sys/fs/cgroup/memory/test/memory.limit_in_bytes
    # dd if=/dev/zero of=tmp_file bs=1M count=100
    Killed

    dd invoked oom-killer: gfp_mask=0x14000c0(GFP_KERNEL), nodemask=(null), order=0, oom_score_adj=0

    Call Trace:
     dump_stack+0x46/0x65
     dump_header+0x6b/0x2ac
     oom_kill_process+0x21c/0x4a0
     out_of_memory+0x2a5/0x4b0
     mem_cgroup_out_of_memory+0x3b/0x60
     mem_cgroup_oom_synchronize+0x2ed/0x330
     pagefault_out_of_memory+0x24/0x54
     __do_page_fault+0x521/0x540
     page_fault+0x45/0x50

    Task in /test killed as a result of limit of /test
    memory: usage 51200kB, limit 51200kB, failcnt 73
    memory+swap: usage 51200kB, limit 9007199254740988kB, failcnt 0
    kmem: usage 296kB, limit 9007199254740988kB, failcnt 0
    Memory cgroup stats for /test: cache:49632KB rss:1056KB rss_huge:0KB shmem:0KB
            mapped_file:0KB dirty:49500KB writeback:0KB swap:0KB inactive_anon:0KB
	    active_anon:1168KB inactive_file:24760KB active_file:24960KB unevictable:0KB
    Memory cgroup out of memory: Kill process 3861 (bash) score 88 or sacrifice child
    Killed process 3876 (dd) total-vm:8484kB, anon-rss:1052kB, file-rss:1720kB, shmem-rss:0kB
    oom_reaper: reaped process 3876 (dd), now anon-rss:0kB, file-rss:0kB, shmem-rss:0kB

Wake up flushers in legacy cgroup reclaim too.

Fixes: bbef938429f5 ("mm: vmscan: remove old flusher wakeup from direct reclaim path")
Signed-off-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: <stable@vger.kernel.org>
---
 mm/vmscan.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 8fcd9f8d7390..4390a8d5be41 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1771,6 +1771,20 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 	if (stat.nr_writeback && stat.nr_writeback == nr_taken)
 		set_bit(PGDAT_WRITEBACK, &pgdat->flags);
 
+	/*
+	 * If dirty pages are scanned that are not queued for IO, it
+	 * implies that flushers are not doing their job. This can
+	 * happen when memory pressure pushes dirty pages to the end of
+	 * the LRU before the dirty limits are breached and the dirty
+	 * data has expired. It can also happen when the proportion of
+	 * dirty pages grows not through writes but through memory
+	 * pressure reclaiming all the clean cache. And in some cases,
+	 * the flushers simply cannot keep up with the allocation
+	 * rate. Nudge the flusher threads in case they are asleep.
+	 */
+	if (stat.nr_unqueued_dirty == nr_taken)
+		wakeup_flusher_threads(WB_REASON_VMSCAN);
+
 	/*
 	 * Legacy memcg will stall in page writeback so avoid forcibly
 	 * stalling here.
@@ -1783,22 +1797,9 @@ shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 		if (stat.nr_dirty && stat.nr_dirty == stat.nr_congested)
 			set_bit(PGDAT_CONGESTED, &pgdat->flags);
 
-		/*
-		 * If dirty pages are scanned that are not queued for IO, it
-		 * implies that flushers are not doing their job. This can
-		 * happen when memory pressure pushes dirty pages to the end of
-		 * the LRU before the dirty limits are breached and the dirty
-		 * data has expired. It can also happen when the proportion of
-		 * dirty pages grows not through writes but through memory
-		 * pressure reclaiming all the clean cache. And in some cases,
-		 * the flushers simply cannot keep up with the allocation
-		 * rate. Nudge the flusher threads in case they are asleep, but
-		 * also allow kswapd to start writing pages during reclaim.
-		 */
-		if (stat.nr_unqueued_dirty == nr_taken) {
-			wakeup_flusher_threads(WB_REASON_VMSCAN);
+		/* Allow kswapd to start writing pages during reclaim. */
+		if (stat.nr_unqueued_dirty == nr_taken)
 			set_bit(PGDAT_DIRTY, &pgdat->flags);
-		}
 
 		/*
 		 * If kswapd scans pages marked marked for immediate
-- 
2.16.1
