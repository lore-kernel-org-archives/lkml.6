Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751859AbeBIPbk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 10:31:40 -0500
Received: from mail-eopbgr00101.outbound.protection.outlook.com ([40.107.0.101]:58432
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751145AbeBIPbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 10:31:37 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: INFO: task hung in sync_blockdev
To: Dmitry Vyukov <dvyukov@google.com>
Cc: Jan Kara <jack@suse.cz>, Andi Kleen <ak@linux.intel.com>,
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
 <22e5e2e1-fd64-1a75-a80c-332a34266717@virtuozzo.com>
 <CACT4Y+b8CzoTXTitPX-O83p5zgEjsR37U3TPyQ0=4fGeNJHdiA@mail.gmail.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <b1d86d56-e08f-56ef-f436-f94bc7f9ca61@virtuozzo.com>
Date: Fri, 9 Feb 2018 18:31:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b8CzoTXTitPX-O83p5zgEjsR37U3TPyQ0=4fGeNJHdiA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR08CA0048.eurprd08.prod.outlook.com
 (2603:10a6:7:2a::19) To VI1PR08MB2830.eurprd08.prod.outlook.com
 (2603:10a6:802:19::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2211207d-c4f0-4826-9a99-08d56fd22fb5
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:VI1PR08MB2830;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;3:9ySQAMz6b0V5zxEl/I38Sl3zaLKWitm6aI6dPF826nm4y/d0VcNTTK3Z7TvCiBzaFpNxpy0/H2D8cmvF1cI3dfmkI+0/vz2YJN00uGIkqAJkJ1zw77pUWMRy8lZzbKLb213Nr45gAmcsVUdAS2I5pGDkCJofiivqNVQ8x8++YkdgbY9S6S7sLITRBTAIEuFEr8mSliitHsyVOF0wvbWTw+GsDdpnYWUsDRx3e9ehZrkqngl1SbtM1ilgHUM0T2xD;25:gG+iJOgfAHQQP+fUqv4wupj1TSsOwrCkIG2cIAlk6FKcIG6oyTHaoWBI/q519GE3AYeyqL0qgdzURM29yH1m+5Qid2AoJSRjORcdv0mn6Un9+L5qfZkE8fRNwxU6I9pD6HIk1y+Cg/FbXZ1dO67J7za7XwyMI9fdAkfqtFt2gL49EVaDaiy37b0WG33vXIMobJ0dO4A38TisDGapxSFtn3hnCuaRxKj83z/M40034vpXkzrC44u03dbMO4JZz9GYWdge3/2m+r+OUJVmmAPGUSTuJIQl+HBfkagNDDpWgYCBSlMosLd+8zAh0X09iW6vfTdWz/zaThCwN3zdWe8Y2g==;31:0QyjqP6+V1IBt71b+geLgtXCVguDwyvnBcCuwLk/vULdyllaNb6GA6+gJ4PrEVdKB3BELLrUXmfPxZpVjFf3a3n/qD2Lc9WJFrn5p3XeLuvqyOBDi4tGzpOk5BnsJDPvasGRQV1d5XFkfAR52RQo5g2JdxTtvfaTQ+56EclkGj3xDn32i06Ixiih2lq6zoBFQ6RlKKDD5yy8YRo/VvdsSDcnO+4NWz4VCF36GjliZCQ=
X-MS-TrafficTypeDiagnostic: VI1PR08MB2830:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:t2nSiUbgopdRt8ADfBOlPNAC7cumT/C/cIyCQdAcuiS5hEesAvPoJkAlO0PRA2X92gVzZREKZRdf/4hWX1Ieh7/B+Lc29TU92YQaiyXnLgXiNmxnwzKWGyQuYhzQ3C//MLN/unGp5Z1cmRYkU4anufQQ9aPbheeMuN9pRu6bryrugubpfE34KweLtX5UP//0Iw4JCUlG1WAWlLR1MFEQ+NUvgoJKUTG/LQzMmfZQNxjTXoidhTNnn3Sls28UHXao5ZJkYbQcsNdzUjuwyw0hlFI7ahb+1tnI3F7/JitUTMJ0g5+/TUEXULHCDo6B7ud55YTAjxEuNpUD54z0AMRzBW6hGiCrfFNAfR3CyTefuXWPfchsIK3Hzu8Dz4uHGR5bGjQpFyowB7vYkbQihkVmHvNQ6Z2JituhhXSe6EpTwDY=;4:xc2buqk6RW3I2sWt9/11v9/0tpiD5busOrcP4CTA0ZCpXvJURgB9aQDqe/mQzhLmP8sLEJGm92PBnunIA+dGCdAk2tk+0cXDCHhHe0mxSEQmuRE6ctc0XMKxxxSJvLOiEfOHaw26fcpUCSHzQCpCT4rs3DHetBchz9tpvEErNOAC11d8VImLyq+2eBUR8vd8A3/ezM+L9pODOkf/DwfbtfUWHByOsD5UIvdtG3b8mi5pcigZbSUo4MwK360NL9AwBcXqGRaQoE5vsm+Q2hiikg==
X-Microsoft-Antispam-PRVS: <VI1PR08MB2830753987B374D63042A0F9B0F20@VI1PR08MB2830.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231101)(2400082)(944501161)(3002001)(6041288)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:VI1PR08MB2830;BCL:0;PCL:0;RULEID:;SRVR:VI1PR08MB2830;
X-Forefront-PRVS: 057859F9C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39840400004)(346002)(396003)(39380400002)(376002)(366004)(199004)(189003)(58126008)(31686004)(16576012)(68736007)(316002)(52146003)(6916009)(26005)(2486003)(478600001)(23676004)(77096007)(81166006)(53936002)(76176011)(81156014)(6486002)(8676002)(5660300001)(305945005)(16526019)(186003)(6666003)(7416002)(8936002)(83506002)(31696002)(93886005)(229853002)(2950100002)(7736002)(54906003)(65826007)(106356001)(86362001)(25786009)(230700001)(4326008)(53546011)(36756003)(386003)(55236004)(6246003)(52116002)(66066001)(50466002)(2906002)(65806001)(97736004)(6116002)(47776003)(65956001)(3846002)(105586002)(64126003);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR08MB2830;H:[172.16.25.12];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA4TUIyODMwOzIzOnd6SWtwcUJlb1Zyb1VQbkc4MDdlWHpoUUQ1?=
 =?utf-8?B?WCtzZTJ1RnhkMWZNYkxSU2t5eGlvZ3ZZdUdsYlU5Ny9IZ1M1Um5mTXE4aklk?=
 =?utf-8?B?V1YzaTg2Nk8rWFo5M2ZQajIyR3FFZU5jRklPV0w3d1N1aGNlY1BTY0xnL2pJ?=
 =?utf-8?B?K3VtZ1p3Qzl3UFdVem0wU0w0VDUxZ091STNTRGtOcTVvVGhpZjBvV0R3QVN4?=
 =?utf-8?B?MXVhSlJNNU52Z0xVQVNRUVpjTmJRYjhLcjZKbmZOVWc0RDJYbSszeWJCbVBZ?=
 =?utf-8?B?QTM2OHB3OVpZTkhkL1pLUUV2cXNGYmlWU0RjNFV4R2V1V3lOOUxQNGNRZE1n?=
 =?utf-8?B?MjdRWmluVWltQWJKUm1TT0VRQUlCT2t1bzQ0eGtMdzZKZytaWnNkWXY4NGQ5?=
 =?utf-8?B?MlBXSHJxZTNnbFBjOEd3Q2d1bGpjWGpWTkFEaVBnRjUrTWVwVEJRczlOSjB6?=
 =?utf-8?B?ams3WlA2cjMwQm56K2NmM0xJWXozaW9LRGtaNGdVczZHUnhRRHZVSUVVa3lE?=
 =?utf-8?B?ejNpYk1ndkgrNDhwNk9XYWU3bmw2b2R2Y2IxcnhwSDZUSUxnL0NEWXZTYTdr?=
 =?utf-8?B?eVlIVjdGKzJrcnNxclZGM29oNVJDVmhjUmdKWDN3MGVZaSswb2xpaHhuaDhT?=
 =?utf-8?B?M2l2RklPVEpNYU1yLzF0Rkl1a3F0YnRxSTJKcE00SHhWOTBJZm9taXdFVWZ5?=
 =?utf-8?B?cExyTUxrcHVhQ3laVkZWRE9XUUxueXdTQzlXeFdmNGR3R3ZWQmhKbWozTTBJ?=
 =?utf-8?B?YWREME94MWNOVmZzeTJXMnkxV2N0dWNVS3A0YlU4RGg0a2U3azZWc21nOHZ2?=
 =?utf-8?B?cEF5bFFSWk5Ed3o1eTFXRlROQVRYRHdQN0VMVk9XK085TGtaaUMyNGlVYzNw?=
 =?utf-8?B?WndMSkIybFkyQ2luZ3FBclRyZzh0Zmg1TUtuQTB5eGVKOWwvQUxnekRiZ2RQ?=
 =?utf-8?B?SkJ4ZysxVXVPUVBpQnhGU3UwL2JXaXhUL1JVOWJNcFBmWnA5Q2lrbmg5UWtG?=
 =?utf-8?B?WU9aQ0ZGUkFQdlg2U2JVRnI3MmZHaGpqdVdXQ2cxdkVVSVdqL3RtMmdReUta?=
 =?utf-8?B?UDhoSk1HdnU5MWY0TWFDdTVQYUxvbTY5dWljUnByR054NUk4bXlkVTQwcytY?=
 =?utf-8?B?TWJJM0VwRXU3RkZZY2JMdmpUS0RWaFNXbkx6NTgrQ2RacjVDc2cyWnkyS3Nm?=
 =?utf-8?B?VXRHdkpEVFRXd1NybkxqQ3N4ZGpWUEdqOVZ3amJHQUowWmxhd1h0WWFYaWlM?=
 =?utf-8?B?ZlBIa0YvS2NWYmd1ZmgvVFJyY05ldWJFVjVyaGFzRWtFZ1E3cXFnbGo0R3RS?=
 =?utf-8?B?VGJmR21MZTFaWVY2b3NWM0l1N0ZHTWlVWmVTNmxMZUR2dGdJaWtEM2t4eUUy?=
 =?utf-8?B?NUtSNmw3MnZ2TmhTcHI5RVZaR2xkS3ZLTUVJTUh1RTRqeURCcy9qVUVpNFNp?=
 =?utf-8?B?RHZ0cHRrT29qbWNMeHhuSXN4bHE2eExYS0RkZ0xraG5ySXBQV0VXMDlmclNv?=
 =?utf-8?B?d1lTWjdKcDNXVWRhaEx6VjNOdjBPZ0N6QUxuWDc0T0lqNGVrb2ZDRi90R29Q?=
 =?utf-8?B?aFlUcnFnWlFWbG1kZy9JWDFDRjVMVGJGUGgzdm51d0xVNXZxN0owbHQ4NHNq?=
 =?utf-8?B?eXpDTDlrTTVtR1ZzQWt0czFZOXI1Zk9JbHNXR0g1dE01bThUVmhlNVhvOVpx?=
 =?utf-8?B?aExDc3hrWG5udWlpM1FwREJ6NGIxeUhMT3JNSWlDc3A5d2FiMFZCTjYycElW?=
 =?utf-8?B?Y2VzS0JGMk9vcnUvc2pVMnhrNWxoS1VJWDhFQVM4VlN3ejFRTnVxTndMdEIv?=
 =?utf-8?B?UGxTakZaV3plZEZRSEtsYmNFWGxVUXNWT2VPLzFTOTR1MGF5QUFGU2ZRRXFU?=
 =?utf-8?B?eWRLQ29YRTJ1YWRoTjJnRTFQU3laUDdvZ1BmczhqMU5SbTlGSzdJenpaZXNr?=
 =?utf-8?Q?ddNA4Wh+hP2uzltdPac6lwtCI2B1fU=3D?=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;6:KujBgeT+j/g0TAueFfK22iKURmLNIxxWDLrCSFNEYhiksqap69JqAnJQBo0vgcTDtiaohHDiLBTnnKLOi6RCbhjwS4eZ4xrMtd0zQbiPNx6w5emfX1Eqq9XS0bgm67G9RE9TRSp4JvvFF8IzANUl3zDd9GASwqqVnnOwR4PMMHzxTF/epddsf9sX/ChtgrFBZx52v8OTJP2TP23BOyI0QE7dU3vQlI2wh8OkpyiPsm+PjM0QALn3SN2ZU2XM7vNoMtibrmWKBeo8TY/xXSzBh+7IAf6jeSFV6E3dEhaZc5qizeUg8N5MxEbnO46iAm+SSaGeaYrMEsni1mYfTn4R0fHs+RcRjgWjCZVHBOZCenA=;5:v/2FdnKf1w6AAu1UETCtRObu20YqmvOhtwvbs8wuz+1TQWbT0kpXyjgXXYUB/OOG4RHQOou2e0jArlHGMA6fU4YI5y3JfodIvX+P6RFUqO18LjFwD5EHqx6ht44Xr+Yg6Vf9RFjy2Vz3/B5bP4/iOuNCjFEUv5KjRciB7tEhzVE=;24:Mbd34gNcQ85/9u5wf6H48Sy2T7Fh3MmPr7sacTbrlLLvo+qR/F+4zrnRZVfkQzPmRhNQ8fcATI2754PL7nnm9i4Gm/+ZpZKFWBFU8Sy60Yw=;7:WeS8xu9PeZmaLYZHTHb8+oMySW5Q5mBIX3y4qttyQZUesWkc+qfhl1lHknjAN6rphf5MUkoE1vcYo/8u0duBJ5QO+lVdC5QAR/lmZktf61TgbqDblsUHQGOToEE2Zz10zAx2X+ZSiBsWxaIaNTQ7IgPAk6r5OCti+6zTCY95OJ1NWUPB6B/BGJaLgUvczDAkivVFKRoZynG815EVWIwcK7C/n+EaAy1WBOypkg5VVys6B6Et21Nr5X/tBcwh8gUF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR08MB2830;20:loLprnGksPnuE/8cuML180xc7IUQY4oEYIAEXnO22tcm++yixP7dd73slBhx0pf6DRUVWpDBnyWNpfBaDAH2Z2Z9sPWqbxiNu8lRen32chmgmLEoXWoNSOr95DRHe8xSnSq9+GrQCz18gETBT9xzvJ74h/Bny3qvIy/+Z1Yso88=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2018 15:31:26.7039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2211207d-c4f0-4826-9a99-08d56fd22fb5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2830
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/08/2018 08:17 PM, Dmitry Vyukov wrote:
> On Thu, Feb 8, 2018 at 5:23 PM, Andrey Ryabinin <aryabinin@virtuozzo.com> wrote:
>>
>>
>> On 02/08/2018 07:18 PM, Jan Kara wrote:
>>
>>>> By "full kernel crashdump" you mean kdump thing, or something else?
>>>
>>> Yes, the kdump thing (for KVM guest you can grab the memory dump also from
>>> the host in a simplier way and it should be usable with the crash utility
>>> AFAIK).
>>>
>>
>> In QEMU monitor 'dump-guest-memory' command:
>>
>> (qemu) help dump-guest-memory
>> dump-guest-memory [-p] [-d] [-z|-l|-s] filename [begin length] -- dump guest memory into file 'filename'.
>>                         -p: do paging to get guest's memory mapping.
>>                         -d: return immediately (do not wait for completion).
>>                         -z: dump in kdump-compressed format, with zlib compression.
>>                         -l: dump in kdump-compressed format, with lzo compression.
>>                         -s: dump in kdump-compressed format, with snappy compression.
>>                         begin: the starting physical address.
>>                         length: the memory size, in bytes
> 
> 
> Nice!
> Do you know straight away if it's scriptable/automatable? Or do I just
> send some magic sequence of bytes representing ^A+C,
> dump-guest-memory, \n to stdin pipe?
> 

I wouldn't do it via stdin. You can setup monitor on any chardev you like and send command
there when you know that guest paniced. Look for -mon and -chardev qemu options.

> Unfortunately, syzbot uses GCE VMs for testing, and there does not
> seem to be such feature on GCE...
> 

Well, you still have kdump.
