Return-Path: <xemul@virtuozzo.com>
X-Google-Smtp-Source: AH8x227EwmZCGMXrvmmGmHq9nK/1cVEw4U0KGzkv2sXk27UkggBs/GVhCoj2muLDaUG8YDMFp2Ip
ARC-Seal: i=1; a=rsa-sha256; t=1519801987; cv=none;
        d=google.com; s=arc-20160816;
        b=SH+O2sdwQ+Dzod7pJIxr4gVMZAPEBPUIbLasbUEzuLtak6snC667RMkcin5wAb/o4U
         so9m7+s+lcz1MHCxw5sqj0VaSJM7MABYvtRmQtDqNfipYWMsbKG07LFEXFVcL+lPDN7F
         zEzgOpxyPMW2uePbXvFCNU379l0Y8wMHeGwA+A3ytlD4RWHV40qHaZtwdnf5S6hSIcH7
         FVWAvpKXTs9y7TGyv0H11qiJet3GCgSD8ug6Jl4vh8WkC1QDKnP1xkFNQumfBKo3TLyf
         Gqg7d1CDN7HvKf88d5ZICB38klEpp3eAaH/K2Bsqf3GACSWUzx7j2VuY9UQKPhXOYNFp
         3Kkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=F3hSaSKD9sQAIQMWi0RD4+alDkfMVUwlI3Leay4DjRk=;
        b=cAiZj0w2hS2EVQCF/gIChd+XklyZfkfesnrwOLd3B2gSSBX2G6h1yaLKbKbCBJKB+g
         bWRCoH2im0DQ94QhBbIObtrpD2LRgTQ3WT0stEW0r5b0o8HsZNhg7BGbQZnflw3wc0NT
         r0kHaf2ny+4TEs0QL7FMHTXEgQdSInfe/FumIsl9IDb6RyuZ9fHyqhtR692BwHhUkvHx
         Q9nPL4cIxMxSEJhggSbbp3U74BmbdYF6FGOwyaqB6ufWcMXm9Auq5jMmGcOEe1PmWZEd
         attd9UU6abNq94X7z9CXyE2PundIyYWxoc6oHg6MmE77f+c9J4pj5kaKfdNX6Vl2Ebwi
         Gmgg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TUH/o2jp;
       spf=pass (google.com: domain of xemul@virtuozzo.com designates 40.107.3.133 as permitted sender) smtp.mailfrom=xemul@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@virtuozzo.com header.s=selector1 header.b=TUH/o2jp;
       spf=pass (google.com: domain of xemul@virtuozzo.com designates 40.107.3.133 as permitted sender) smtp.mailfrom=xemul@virtuozzo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=virtuozzo.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=xemul@virtuozzo.com;
Subject: Re: [PATCH v5 0/4] vm: add a syscall to map a process memory into a
 pipe
To: Andrew Morton <akpm@linux-foundation.org>,
 Mike Rapoport <rppt@linux.vnet.ibm.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, criu@openvz.org, gdb@sourceware.org,
 devel@lists.open-mpi.org, rr-dev@mozilla.org, Arnd Bergmann <arnd@arndb.de>,
 Michael Kerrisk <mtk.manpages@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, Josh Triplett <josh@joshtriplett.org>,
 Jann Horn <jannh@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 Andrei Vagin <avagin@openvz.org>
References: <1515479453-14672-1-git-send-email-rppt@linux.vnet.ibm.com>
 <20180220164406.3ec34509376f16841dc66e34@linux-foundation.org>
 <3122ec5a-7f73-f6b4-33ea-8c10ef32e5b0@virtuozzo.com>
 <20180227021818.GA31386@altlinux.org>
From: Pavel Emelyanov <xemul@virtuozzo.com>
Message-ID: <627ac4f8-a52d-0582-0c9e-e70ea667fa7e@virtuozzo.com>
Date: Wed, 28 Feb 2018 10:12:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180227021818.GA31386@altlinux.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [83.220.239.180]
X-ClientProxiedBy: HE1PR0902CA0006.eurprd09.prod.outlook.com
 (2603:10a6:3:e5::16) To DB6PR0802MB2135.eurprd08.prod.outlook.com
 (2603:10a6:4:83::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd6b2271-f820-4919-73e3-08d57e7ab405
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0802MB2135;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2135;3:dAcqgVu3/SRSuZ+ogSlli5WudBVLxukstJ/uBwTyFSFOpDgT7roNu3iGSysBwFeLIWHzeq2eSkqUzBvDV22Txo/I1O7RUWLW3w1eaGloXN/2ZHZTY1+0yDFjTsg8qeH2dTvp+HWcg5nAY6V+64Nx719OEcMy5jR/fbz7jwS1l3hHmatojAw1n2AMpxPdshNuFif8UyiMn36V4rjwUNUK3mv7X+vP+rdze4MP5r4cMYrjfBouOaht07vFr55ZFA0Y;25:ByNsu5UlwsF4A9ccnoSu1+oUl9xlhcflhjzBfT5VhGcoynQe0rCzXWSNs96vqTv00cO1GLOIPl7cyGyNPMFlh5AQ43M7O2Bdv5gv85EFMI+AUFyeoGVdUap12cycKEMnfSlARt14e5Z4e2GRS6mX62BdzeWRLZqcQjCHJ5YnxuUYRD4gwdFo906+ksOcfCjJxObTzpYLw7ut9VTq59gHZ7ueJAwkAEejfPKKubLTmnO6G8udn/COxV3Wxn33i+IMoTtA3zJyWe1IkgtuHNj8hLaIYubFlf4rwR+DydSZuxG7whW0BU6/BYh+cqgrWljm6N6dPTwQoZUhWS/ospAugA==;31:VzpI34+qEQPqLoVSX+GnZ7rS1xN+RRgInyUHVo90fAy1UNgDkIcxBXT+KWfd05BwTxTbapqcXJI5x9TNFTjQgyFBGml9cCViQbTBuA9xSEHKdO/s/xIxKoBt142y1B1NBmXbI7UUSswKxMmRsx8U37Bj3slY3aQE8YrZftqx+mYJulAM1xhHzAfTJOuBQfGe+mai3SFCMQ0SJ6Xdc/Lc/iteldkEiCC/bqxnhe3Reog=
X-MS-TrafficTypeDiagnostic: DB6PR0802MB2135:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2135;20:Ah+/PrNFDtXrMjYwxPA/UdeDZ0yjNDvcazgiUSeQKItr488BMOGzYCROVmSD7awOijg561vmE/o+gVQwBbFdy377xsFRvvpACYosLQKQML1EnO4NqamfHr8VQOa4TzXMiIhUWlwN0NxjcLjs2HoYedaJJEjpF+e+spOJomw/GZcMlYJaJZesm226zwuSIIwDtnpufapbN2l6H/lSqd0aqHhMWDC5I42Vb8xC6dvHqzs9TvnsekCMHow2M3Bx1nURzqQtIbStn6pkaAGud+qW+xKn/cCfQ2Nnt7u1szU7tMJu3XF1/sTchtkUT0zkgKlJ0XyE+ac+ib/gcYC1FhgPfKbeudjH3mpOH6c/hOvsRr8gPm0g6fDeobAVdI0w0hf9vYtDuCZIMEhdSB+ysmw4AhzXaWqBqvlTU2P5hSKRuoz0uQ6QA5OTK0WDvZOmUTs70vyjLQqdyh2ReYSROleRJjhzcO+mQadU+4RBw6mtQP2Ox+/mNgk8h43EB6z24nJH;4:MdzGO6NNgngiHvbqof8LjPqMgcyfROeUujEBgQ8D2ImPPWL6Sm5J8DELkWfM1f+BGGkDOAtrW8DAKtcAS8J0JTt25BNGKgyTOHsgEw92PX4e4PuATz8ppcsBm7APNpiWbVw7ByD9VdB13G+xItZwhU5J79ytm8N2eHfJ+wVhvThXFNglWZevLD1FKnOPPia/vagrjSFwPRSNdk/ep9p2Yi/l8f+iMEgzjK71UhTSqmL2wIZsQvDsOkYZ5tM16bKdaPsqQcYVLJ+DpSE9iUjaUrcXmWJfY450+NyYKw15gjYZf7uTxycK9gqQ7vgLBexO
X-Microsoft-Antispam-PRVS: <DB6PR0802MB2135E9EE417600B5DC7610B2B0C70@DB6PR0802MB2135.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(104084551191319);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3231220)(944501161)(52105095)(93006095)(93001095)(3002001)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DB6PR0802MB2135;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0802MB2135;
X-Forefront-PRVS: 0597911EE1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(366004)(396003)(39840400004)(346002)(376002)(189003)(199004)(64126003)(52116002)(23676004)(2486003)(53546011)(47776003)(52146003)(36756003)(110136005)(5660300001)(117156002)(39060400002)(65826007)(6116002)(53936002)(6246003)(3846002)(105586002)(478600001)(77096007)(65806001)(16526019)(86362001)(26005)(386003)(66066001)(76176011)(5890100001)(230700001)(305945005)(7736002)(65956001)(229853002)(68736007)(31696002)(50466002)(93886005)(8676002)(81166006)(81156014)(31686004)(6666003)(106356001)(2950100002)(316002)(16576012)(97736004)(8936002)(2906002)(6486002)(58126008)(25786009)(7416002)(921003)(1121003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0802MB2135;H:[192.168.43.229];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDJNQjIxMzU7MjM6VndLOHpsY0wxZnRScGJVcnpoajk2bFpS?=
 =?utf-8?B?RHltUHNDTGtqTEkrYUhacE92WFdmT3RSR21FcXNlYUF4aXNZaHQrNXpURmdl?=
 =?utf-8?B?dmJIWlpzN3Q1VHRyamZwWkpXT3FRVm5ZMDIxNENicWZ4WURxYkJVN3FlbnZs?=
 =?utf-8?B?d2NWekFOOG1nU1RtNFpDbkJ3WEh0dDI3bnZrcURPd213bTFsSWtrTGJ4ODJO?=
 =?utf-8?B?a3Y3c3J1cVV4UVM2dlNTVWtHRmNVb1JBekxlZThqU3Naa28ySml0UHY4d2hY?=
 =?utf-8?B?ajJHajBvMWtsRUNKbllWYVNuRmF1dlFYMDZxeHJuVld6bEdRaXdmMG5sa0p1?=
 =?utf-8?B?MGo5TVRjY0xpUmZSZ1Z4YU4vaWpJTHhOMlFsajNFZkV3THhLUUpGRTBaL2xr?=
 =?utf-8?B?QzhROHhLektUWjY3L1VPQngyUDdlVW8rY21PT3ZTa2RrQUVKdG95VThLenpq?=
 =?utf-8?B?Qm5TOWJUakgzYjRreldGUGtkR0NNSVdjb2RBenNxSnlBeE9vc3ZrYlJmVWxl?=
 =?utf-8?B?N2h5NURmMUJ0Q2xGR2V1NkcwTDQvSXd0a0Joa3RHRElrbnYwdzRJbEZPREhW?=
 =?utf-8?B?UDVGU0Fhcm5uajJ5c3BiTEMwN2ZSN3BEYWVhd1Z2UWFsdkVhMGV0OTU0QXNa?=
 =?utf-8?B?UUgzUUZNUmRNbTVvWDBPTDhnVDBPdUlwM0NuZ1BtQ1F0N2I4T0NHVjFyQ2g3?=
 =?utf-8?B?NXp4dmRxQjdhZEY2aFIrY1FNelZJcllrMFZXUXdxRFc0RW5KTzEwTExLNzFJ?=
 =?utf-8?B?emFvR0FYWFp2Sm9PRzByVEtxaFR2enhydUp3dmRhOWZxcU5JREZKaXN5M0xv?=
 =?utf-8?B?SnhtWVpnZVBjYnBHQ2libGZ6c0NxRGM0OW1GeDVFQXNkVGxjdVdvajZCRjVC?=
 =?utf-8?B?R0pYMnJBWVl4eVcwRTBGK3hMaVk5UXlDWStnRlZrWkRwNWxDdzQ0OHdOaDh1?=
 =?utf-8?B?UHVwZGRjcll0VkN4aHlUSldZaHBwdEJUWXRSdVZwODVVcFhFcEo1S3h0OEo0?=
 =?utf-8?B?cHE0YnhlK0lmVEN5enFKNmtrSzVQQWFXemFVcDFiTGtMUVNoWmxTd2lsUWpZ?=
 =?utf-8?B?SmhXRkFmUnZnaVdTOE51SlU2TFRqWFpYZk1SVS9OOS9UVTdiWWlJc2dLbTRX?=
 =?utf-8?B?WGs4dHJQYkg1STdXK2NVVGVEeGJ3c2dlbXhXWUJ6NHlDYzd5SDVUVlFaQUs5?=
 =?utf-8?B?NkdmUmVJbTZONG90dHU5TzBGN0FUQWJSYVplbFlvei9NdG9vU0hKOE5FRmx4?=
 =?utf-8?B?WWhhRFgyMXVJNk81MGhnTllHSXR4djQvMHAwTnNyeUY5TEYzN1QycHo4TUcy?=
 =?utf-8?B?ZWg2MU0yZ0ZMVkNuaGpGbU0wb2NSdk9CMlVydUFqZ2pRNGh0aDlQZFdSUjVa?=
 =?utf-8?B?ZjVvNWZScUp5dWVzcXNuNDdaam05WXhaY1VzYkpJaTFocjVmdFJtT0p6L3cv?=
 =?utf-8?B?S3J3TWpKYmRKVGZSRmJGMlBtSEl5dTlnakUrTmpybitESW96b1pjVlo4d0dE?=
 =?utf-8?B?b0p1UzJvY3dXaFBGbzFxQWExOVJYMWkyWGVxVTdhd1Q0aURCN2gxUmxTNkpj?=
 =?utf-8?B?em1oZHU4RnFDS3M0RzFET1BDMUpVNVRGMFdMRTc1MDlySXJLRmxOMW5LL0Np?=
 =?utf-8?B?Y1Nrbm82S0FvdGQzTGJZR1JtQlhBd09vY25Od0REK0YxSnY5b0V3T2tVUytI?=
 =?utf-8?B?U0dDeGRCdWhoZy9TNHRJMW5IOUpGQkRRVjBoRDFaY3FrSkpsNyt2MGpmNlR1?=
 =?utf-8?B?U25aU0VIZ05LUEVoc2RnRzZwUENJSGt5cGNDMzRtZFdBbENQWWFyZ2RaTmJ2?=
 =?utf-8?B?NkxLU2c2eEd4R2tvU0JzSlZXYk0yV01LS01BWDRkTlNXVnlmV1BoanBxYzl3?=
 =?utf-8?B?N0Nqa2FKQlV3SGxjUDZjcUNZL2c0aFdsNTVMVTBIU0lEejdhdXFuR3MwOEdF?=
 =?utf-8?B?MjVRQVJXT0xPSEkrOVJHdmpNenhMaVJMVFpINmhDR2phZ2FqWG5Uc2I4U09s?=
 =?utf-8?Q?cYoTRjvy?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2135;6:WnhxKGLzi7WkerTX7vdaZW6yWBnd/2HrMBEDl9zIDiwI25OGZGNm0AkI3VT5AlxJdWAWdaRMdanJT1UJFI/DdrQLyq9jUW36NSf/9xsg9vXLg20es6OAeWkEnzCgCmRdrkiUI+TcdkwWbwNtW/H5YBSc/MzSCAb5+RCXpGBl5pKCBrYyGKocerfSVuRyfsCPS7kd1ThMUeGdovoA6lgcPeSFdcu+GGCz9rrMuUrMum+6BpMVQ6Yc6ynOd1VPol5/lQAjDE4hldaILNvRCl+5soku2mB3CLcGVS5uiwBk7G4Xn4fHxSE4lDMwI6DXi8CN2846IrP4JD27mB1/Bx8ZhqwecGLuTlg/GePu7IccW5w=;5:wpB70/pd2iCZqa0dcSfu+U2Cfd/xuDa+/pV2wg2LfPmhVvHteFrXDnHSnD0pPluiwaXzHbMQ398ljcvUV/Fa8ucQKxzLt23/o9leEB7p079Q55TI4CSZs057+1ZanvWm0dXKRg7X24UfkVu8ohfWSPO5qgSkZixE7ZPXqNQib7g=;24:5FCbZhZgBlhGAhfxt79LPh6d+aEJ4w6id6h78Hgwkad1S/CE6TnhOnY0MC2vysJ0XdTML6F0gx+2J75s26ZzxUmMNY5e8wrY7TV/E5cKcYQ=;7:lVzAtPE+sZdzoAiguqWhcidHzjAdgWlKTy8+17B2RKFw0HvrIh7uszp6yDgfsEP/kmSMeMF4taCBEGIuc//m7zr9JPedriRSb4l3hbziaLsVfVSjQndM91GQploZKH9SnQeTRqUkWgyZ2jISBTQUE0Ok08m7GHDHMZH3p0y5Ug278SNGTUTC1YPQIIQEGAJ38O/437RnISWQZcp7yvUFVqOhV9E9JUkUmbNa4Uk1fFXdtvWTa1f8dT8gqwzmw2cl
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0802MB2135;20:xhMmcCvPQr4A17kT6L2mXVfxyp/QjEjXVJ5DByq7mF4wSrKyvLzLxr8rtgtwZi8ACbWeDYN5bVKda51zYB8dheCjIwkHrNl/KCbXqVyHEYwZdNZeu8ui6qWkftZN5B1JGIm7eYpKrvV/KUD7uh9WXbsunO4k5IzIFLP5aXS3Tzc=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2018 07:12:58.7284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6b2271-f820-4919-73e3-08d57e7ab405
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0802MB2135
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589095397169234429?=
X-GMAIL-MSGID: =?utf-8?q?1593627888004468931?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/27/2018 05:18 AM, Dmitry V. Levin wrote:
> On Mon, Feb 26, 2018 at 12:02:25PM +0300, Pavel Emelyanov wrote:
>> On 02/21/2018 03:44 AM, Andrew Morton wrote:
>>> On Tue,  9 Jan 2018 08:30:49 +0200 Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>>>
>>>> This patches introduces new process_vmsplice system call that combines
>>>> functionality of process_vm_read and vmsplice.
>>>
>>> All seems fairly strightforward.  The big question is: do we know that
>>> people will actually use this, and get sufficient value from it to
>>> justify its addition?
>>
>> Yes, that's what bothers us a lot too :) I've tried to start with finding out if anyone 
>> used the sys_read/write_process_vm() calls, but failed :( Does anybody know how popular
>> these syscalls are?
> 
> Well, process_vm_readv itself is quite popular, it's used by debuggers nowadays,
> see e.g.
> $ strace -qq -esignal=none -eprocess_vm_readv strace -qq -o/dev/null cat /dev/null

I see. Well, yes, this use-case will not benefit much from remote splice. How about more
interactive debug by, say, gdb? It may attach, then splice all the memory, then analyze
the victim code/data w/o copying it to its address space?

-- Pavel
