Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeBHQX3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 11:23:29 -0500
Received: from mail-eopbgr30132.outbound.protection.outlook.com ([40.107.3.132]:15689
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751974AbeBHQXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 11:23:24 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: INFO: task hung in sync_blockdev
To: Jan Kara <jack@suse.cz>, Dmitry Vyukov <dvyukov@google.com>
Cc: Andi Kleen <ak@linux.intel.com>,
        syzbot <syzbot+283c3c447181741aea28@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, jlayton@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Ingo Molnar <mingo@kernel.org>, rgoldwyn@suse.com,
        syzkaller-bugs@googlegroups.com, linux-fsdevel@vger.kernel.org
References: <001a11447070ac6fcb0564a08cb1@google.com>
 <20180207155229.GC10945@tassilo.jf.intel.com>
 <20180208092839.ebe5rk6mtvkk5da4@quack2.suse.cz>
 <CACT4Y+ZTNDhEhAAP2PYRH5WxEeEM0xHdp4UKqtNaWhU6w4sj_g@mail.gmail.com>
 <20180208140833.lpr4yjn7g3v3cdy3@quack2.suse.cz>
 <CACT4Y+bwnyFmgTNMTa1p8WKecH=OU5Za_hboY7Q=V2Aq+DOsKQ@mail.gmail.com>
 <20180208161821.f7x3gopytdtzgf65@quack2.suse.cz>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <22e5e2e1-fd64-1a75-a80c-332a34266717@virtuozzo.com>
Date: Thu, 8 Feb 2018 19:23:44 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180208161821.f7x3gopytdtzgf65@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR0401CA0079.eurprd04.prod.outlook.com
 (2603:10a6:3:19::47) To DB6PR08MB2823.eurprd08.prod.outlook.com
 (2603:10a6:6:1d::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b21f3a7-78fb-4610-2bca-08d56f10456e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:DB6PR08MB2823;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2823;3:STSwsUWCSxMqqkG1m9HttjUdU0qYEk8x5DO13mbtcQo8SVaVZXXA5NqNzoXXg1b+0AGlRtFxmcmYZrU5Ex1Pv0QQ47nW4NGyDbEBPGlFah/yZV2TjLgPZkV9NgWaC2yUMZb6K2HYfgFLUs29+bsAIjP85x66CKBTSfK9O/IVTqOvlkaeL2t+/o8tpfgBTvWvjvxyb9Eqa0qiZlrT/qxtvdsKgA21U8yLNvdqNJLKbvmGKy9E5vEHNf/DfWcHBxfu;25:5XvhOxpCa0nmkkmnI8k4XksdBq+l7j2q3Ecsq9Dq8eSTn8PyoxXNZR5oDvDxUQg16nR2rJcBXLt8gRkukoSZBN8lQia4aKgPHYIjjx0f4BjjMT1RUNKxuRwqGtU0NsosF+rsYFvlAB+H1C7t7wVtQFxddtbuMO7ZFyzDlnsHyd7EeIniwGbqsmQyDPaXb2PPfc52VVjD6GcVZCf76rbpEJRrxhl/KmMhN0PQLuph7iEFH6kP+tK9QDMcqIcS+1sZjwR+iotck9EOpGifB+ZOVwetUKdFjoJqpEYsmAZHGcc20UoR6bm4lT6WsQiliAGjcL09P5smtHkHTXxKGbZ3Tw==;31:FV5qEZBut2qXfbpyailUXfT32rIst26lorAxLt6WhMP6Oi26zC5E/lh/XZIzvV+x5H4PJGgi5WFM8brDSN6IHUloRezR19c1NtXNee9i2QWFtPHkZ4vA+uNZi7ErViGmAJBL7LUugHd9fCp0jGPYu/vuEzS/Pd3bCsYi+jP4JnfuRnHobfkAK0OWWx5yvZ90Dq6SilzuJmnix8uB024R+Zv2BaMpWzS531nEPoNwSYU=
X-MS-TrafficTypeDiagnostic: DB6PR08MB2823:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2823;20:vRC1Get4oW+VcCnHH4awM417ZG8jT8+ryKVYaBy4CryRnJp6ZP1o12FZLvd/Sj6UR4fGLFXvRz8iPQ0yFMtNSw2nYrHDD8rWVJaOLeIq4NF2w7+TaN6iSHenr+62NoFLVSOXXEyT4BtYHC9V3IQhp28a1pTEhWgIq9uhllaqp31hBegUFz3Kfrw78LnOboBAeiAICQUidbn7CzjBpKj9DlBjzdgURwk25OZITRb6jBO31JKx7vlZO7qMh1FiuW+zo2sdsYlvxaZH4aIcubLY1OogKbNPhhmE/O/bHeNxYGiQcaFVh2DoGZTSUNKlqx6JnEKGa+0drtMVw1MN2uJc4BWXk3bcYB7tpOCB9/xXdTHsqDR5aEGzXvFWn4LC++xe5HvSzdOXv0PF3rIwp+UYR5xtMXljitDMCx7rLvUWAAo=;4:8ItqYmMVbveiYzdYf5aP70U2IVoW1aeVfPchGrStsRTgCFR3jyQSG02SMgMUrKvLrcawmWUltq/RsjSDxd4ONyxLQbDVFhUEwRj84kW0xTdXKp0l9A8h52lIe0QeOG1MnbuLw8NW/1VHsLGITRpO+67uuW93AW0BJWOawrXgf4HgYNvyRUgnU+j61FtwUH5DMwiC/yah6+kuEd8q60vI6upETKI7rxfvQxQz33T6/Y3N9r61eJfYyEf+H1Cmmn6KLKEQ0oV5Tcbn2Y+jmMsACQ==
X-Microsoft-Antispam-PRVS: <DB6PR08MB2823A5F3A20D6A71FF5D9622B0F30@DB6PR08MB2823.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR08MB2823;BCL:0;PCL:0;RULEID:;SRVR:DB6PR08MB2823;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(39380400002)(366004)(376002)(396003)(199004)(189003)(7736002)(186003)(6486002)(68736007)(64126003)(6666003)(5660300001)(47776003)(81156014)(81166006)(65826007)(66066001)(65956001)(65806001)(25786009)(7416002)(86362001)(93886005)(305945005)(4326008)(97736004)(23676004)(230700001)(2486003)(52116002)(52146003)(8676002)(58126008)(53546011)(386003)(229853002)(50466002)(26005)(106356001)(3846002)(6116002)(31696002)(110136005)(16576012)(55236004)(83506002)(6246003)(316002)(54906003)(2906002)(16526019)(36756003)(105586002)(77096007)(8936002)(478600001)(31686004)(2950100002)(76176011)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR08MB2823;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4TUIyODIzOzIzOmNWS1UzZkVoQ2lBb2hCSXVoVy9YZE1hNGZC?=
 =?utf-8?B?RklVTUVwbk81N2Fvd2EzVXduNS9jQWV1eGdyNlVTNnpsOEp4Mkl2UENvSENK?=
 =?utf-8?B?S3pJU2hsMmgyb3N2djFWb2Uzc2NBUUFYbE9wZWExYjFSZHhnN1ZQYmg0Wm1U?=
 =?utf-8?B?Sk9VNFpKdEw3cTFvdzlXNDlnYmxyUytCZ1pML3dSVUVOMWM1N3ZXWTZoUWZ5?=
 =?utf-8?B?czdFUmg5Y2N1SXpROWJrNnp5RDdWVGI2V0UyWDh0MWU1TjQwTVJ4U2ZCRlZM?=
 =?utf-8?B?UHNyUFdnZjljTDZaZVJYblJ2VTcxWHVYYnUvc01IS0hTT2tVdkFxcG5OSEJK?=
 =?utf-8?B?b3paTWhkeXJRUVZXdlBaSitDVVRaTHBVV0d6TlJkSDhpS09lNVh2ZjVQUlVL?=
 =?utf-8?B?S1JVbkZ4a0NCTHJrKysrV3BvVzB1eGRNd1haMVArOHhVZGIxeFhySkpKUkZx?=
 =?utf-8?B?cktxMHhRN21wWFVPYUxZVlQrN2wwODRyVFBuOVVyUFA1VGJUZmZteVNqaDhZ?=
 =?utf-8?B?UmlFVmt0NURpbW9vWStCSmJtcmRDWTAzNHZibmg0bDdIdHUwYVRHd05uV3pq?=
 =?utf-8?B?dnI1d3BSVks5NXpSTHB4NVkvWlNPcCtMSzhEOE5zWHd0Z3ROY2lmdEZJS2w1?=
 =?utf-8?B?R05oSy9kUTlkVC9mQmkvSk0xa0ltQkYwNFJSelpTc1daQW9Zb1AvZzMxQU54?=
 =?utf-8?B?d3laYnRvSGR4MkM5MnU3Znkycys5RlNVSXJ1eTVFZWk5U29mQUN1eFZMZ1lM?=
 =?utf-8?B?TGZ1R3F0SElSZUZIK1E2QlVBQzZHWmlOb1hQTTZZTzlNWnVIaUZqelpXL0My?=
 =?utf-8?B?bEtKTzgvVjhCMkQraVROWUt4dStXdGZkNW1iZ2pNV21vSGJGekptYXF0cm8z?=
 =?utf-8?B?NlhtU09zcDJZZzlpdzVPZXcxTXNyQXBmeUt4T1NuZkFPQXloRWhDNUY3ZkRH?=
 =?utf-8?B?b2E5dEFIWStjK2k5dUpVWFIyeVVpaTJrcGVvVnFHZUhGREFCamhqN1JIbk5p?=
 =?utf-8?B?Ujc4Lys2emRUOVZOcE5SZFhaRVBRZ0puSjVFZzYrZGdDdlF0NWJrR3ZXdEx5?=
 =?utf-8?B?MVFITW1TQzlocjcvazdrbWdtbFhrMXg1MkFqZ1lSSFhyWFlRSXlQOUoyNS9X?=
 =?utf-8?B?NXVqWVp3UzRSQTR1TGpZUDVCYUx0azh3L1pOTzJEWm91VHRZQ2xtQU9iTWJD?=
 =?utf-8?B?bWF5Z3NTUVpqN1F5bjBPSkRwNmUrU1RJbmtkV2JCaFMrM1JaR3YwRzZTRE9m?=
 =?utf-8?B?MFduZUtCQlZuM2NMZXYyTm9YZU1BYUVtUTF6M1pCUlI1M0tNcHU1QytuUGZF?=
 =?utf-8?B?VlJBWTNOcXBMd2RMSkxadW40Y1RtQWRHaGt6NUlyNDZPV1ZZZUI1dTFDYmFj?=
 =?utf-8?B?YWZXcndwQ01kaUtrUFY4Q0tPM1lvd2FNY1BNZHBuQ3JhdVFPMDBmVHExZDhP?=
 =?utf-8?B?c09IWllJRWxIelVXLzBsRW9iZTRXdnExdHhEcTNFdjVWbzk4TSs2aDhkTWRy?=
 =?utf-8?B?cmN2VjNoUnlHR3VZdmd2aE13S1V0RHBFaEx4SDlIY2pzbDc4Y3R6QVdSQlNV?=
 =?utf-8?B?ejJzZHBwUWNoSm9DekFaYitDTm1WZkU5UjBORFJhT1dKbE0vZkt0U2I5Ylpn?=
 =?utf-8?B?OXBzeFJOWWNlU00vbDlFWDJhUytXUnh0NFo3VGxpdk9ZbzJBQ2hOUXFiZ2V0?=
 =?utf-8?B?aEJiNU51TnV3WDBxY0lOUWF5UUZUckFZeG9HNy9mdUYvTHNUZlR4U0tGdmVT?=
 =?utf-8?B?eTBnUXFzcVQ3V0JwMGwrTFlYZlRSeFV2QzBqOThkYkxkOEpmOGhpVUovT3lD?=
 =?utf-8?B?YVVhRHc5a0s5L25CTTI3NHp0emxQVTJlbjBaNEVIeno3ejZRMkhSKzB5UnBN?=
 =?utf-8?B?UExWa1U0UXlCMm9neUkwbzdYdlRhNmNnK3c3MTZZLzEwZGZXc3VmeTlKUlo5?=
 =?utf-8?Q?W2zgr1gJ64suurTg9E9qjsX7kOBO2c=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2823;6:UzyZSZ/x+K6f7CLlp2RpjmLfxtXbESHpz7y12M4cxZcqjk9gnvM4vDAsW+UzqFoc/UEUyoviaFUN10K8qoFnfhsInPpbljbuEuk1wYWixE04Xg2kX3a40coh2hG6J2bYGB+pj3oxa8O79w31Mw9BHdjItwkr7yG0GmuxrnSmVb/v+zfzl0EKpB29lZCEaIP0P4XiVNrksXGG+xD/Df3csmS/wmJ2zQ+oNkBpQscRv2izfFvIBHdk8Cq7XHSlQeWZk8e9VHC8yYDt51TuA/gcG05mCr6pmO6QsdTmRVWNh+7jyhSKuY5uCMrQqpnH/W7ipLuyfIrVcCMms5YvsqH2tOPs/JTS3enRuLi7lKYDa6Y=;5:/bTzVvutouhxtlsbqfeeKo4RaATZWFfcqS8XRtcgfQe1CdIg17+AGHJ/5SA2g5jDo3PUjoJLkpS5OUMkTGGxbn+M5RfT4WoOHQ2nm4H8DP6sy319F6yaoeKppM1vKAMvqAJokmmqsDLfzfZ2InclhEocBPbaj0H2Qj6UWhiGQqA=;24:s4Vt7IuXfK+0uQofNFleZnFeUalMv39ywWWYzsOxMj7rJk9NH2oBKA7FkYAWiPz09nX7KMQaJJ5MGfQx6VxaHLJRvRh2oxg7EMTmJDFkCVI=;7:vrtmhWH7+kwMODEq+wiCpiBvZ3BcxEY5U33iBS63vVnfn0o1aSYzdaPyKW8gaA3AcWtOXBOw/bpKM9hBlBzOZ5+0S8jTAZxnmnPWKJWQ3IWNiZGIUB/z0Bf58TslP44t4j0es5+bUBi6C4WrhpsGI5/KY+n6ptV1bI41B2/VkTewCV2wfSAXcgB3PAgT2QOMlq4XBroFqcNiPrnR5ulJpK89uHVzCBDyxtE2UAS0t2QvdNU5F7uli07oqzNgjlnQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR08MB2823;20:PUcnxZSBi35at33VBzp/JF5Zc3LVAbx2UHVeTKiHcoiaFJ2FYE7S/c/csK7DWx3E0nnsOZd2ouP0ROO1P0OH9sXGy6n8siWSCu625+OG1jZFfkQ7k7OmRnZHMArbomJ5Hja3ovRm77DKN+t3L8Az4LyXSfn5jESEXjx1cmBwYUk=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 16:23:20.6707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b21f3a7-78fb-4610-2bca-08d56f10456e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR08MB2823
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 07:18 PM, Jan Kara wrote:

>> By "full kernel crashdump" you mean kdump thing, or something else?
> 
> Yes, the kdump thing (for KVM guest you can grab the memory dump also from
> the host in a simplier way and it should be usable with the crash utility
> AFAIK).
> 

In QEMU monitor 'dump-guest-memory' command:

(qemu) help dump-guest-memory 
dump-guest-memory [-p] [-d] [-z|-l|-s] filename [begin length] -- dump guest memory into file 'filename'.
                        -p: do paging to get guest's memory mapping.
                        -d: return immediately (do not wait for completion).
                        -z: dump in kdump-compressed format, with zlib compression.
                        -l: dump in kdump-compressed format, with lzo compression.
                        -s: dump in kdump-compressed format, with snappy compression.
                        begin: the starting physical address.
                        length: the memory size, in bytes
