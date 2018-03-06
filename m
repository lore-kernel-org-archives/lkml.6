Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1575980-1520379803-2-1164438787480696371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520379802; b=reRLMye1TpoqGk4y2wNuLsrCryJ0hlwuMi3tTHkKwVk/Dte
    uU2Ai9RLZqRJscK2YyCAeRvmJ9e/EJA0S3NXGV3s5AlbVs1oRkVnv8GLJZ8iI27y
    EUqUUA+S8OWGPTGmsVmiJ1MVfdYPufvGsr9eSZg74/0SchbTbw8pRxsHUyqxSI4O
    2a+Lol5M/Iv8nsW1oZmgh5eAIx1mi/R1tnH2QxZ3/QHe+mkPhFgVgdQjhKRpIlAy
    Jn73dxL6aK03EqqRrzAQ3Ko/CcmktSLd8piDrIZHs1xsy8Oh0ENK3yGgriVzQUPa
    IOA9ctg5DkPyDncuJZrdkk3T7f+HFSqYN/syVYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520379802; bh=SbrS1M++aC9r/u1mLdfzc2Qct2
    Xuq+34NDHIpFad3HU=; b=og47RK578il1UJC+UZP3SpyNUUqo+5RwJhUHZbKZbC
    E+pxb9ANFovVVJoud8VsWd/VuOmnLqjP0+iL3kEkdX145sXxARWlUxDWo18GSBBG
    Vq3tJz5Ch59++FX9RMTVvDzykZXrTR2Qndjtp651NwQdqmEozX5GChoq6CWun1M9
    UJWuFWuKu4uedi+uRGL4UGSTwAB/1chGh/pp/CQzi0iqYe8s3DrRWNLcFLhEu9IG
    t/DbZQ+Cz/5mCXcxoNcRbnKk3/qlzAXmismKsaXpFoCyChmmkN3LWVYX3lJGIzbq
    ASt3l8ozQwKpAbIblttbTQpP+VoZTPwfWVqjHDfCK44g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=mXBnzZj+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=ZtSJ8stV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=mXBnzZj+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=ZtSJ8stV x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753656AbeCFXnT (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 18:43:19 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:48234 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753525AbeCFXnR (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 6 Mar 2018 18:43:17 -0500
From: Chris Mason <clm@fb.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
CC: Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
Date: Tue, 6 Mar 2018 15:42:41 -0800
X-Mailer: MailMate (1.10r5443)
Message-ID: <EED9C7CB-BC5D-4E2D-B0CC-0003F682C73B@fb.com>
In-Reply-To: <CA+55aFx5Q8D3cmuoXJFV9Ok_vc3fd3rNP-5onqFTPTtfZgi=HQ@mail.gmail.com>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CA+55aFx5Q8D3cmuoXJFV9Ok_vc3fd3rNP-5onqFTPTtfZgi=HQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Originating-IP: [2620:10d:c090:200::4:23fa]
X-ClientProxiedBy: DM5PR19CA0040.namprd19.prod.outlook.com (10.173.167.154) To
 BN6PR15MB1876.namprd15.prod.outlook.com (10.174.239.136)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48d896c6-2101-4b3f-f386-08d583bbf723
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BN6PR15MB1876;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;3:S1HBUf0fAUqi7ctdJxebW0Mqw3XS7DBSeP4Y5/WUju8C5PTCqH1VQItkPGIHLeFpD9f9FSt/vPZItXDkVoQ1B/gkudyQPvMshKz0k3zlO+vFRyTRuKUh0zjF0d/Yyd8Pd5JzPMqKjc3CrBN9LKk+od+YzeOPIORncE9CSPJyIZ2meLNo0CiWu9Jg8Q/Q6Tv9eJLrEa+5BYJhcCwx1imTtm9nzDMKQQidsmi5QvDlmQC3a4crxvhRUlZNdwW6MuDz;25:0jfVbFgYAMq5ao1npA3gIq31pEVO9A453gzADnnv75ngbEhxQKUsSxCg8who2w8P5lQyuqwO1h5S9gKUu+IzuNoW3De9cdgUvelxcharo8F7OqMs93rRjS4yEJ2Fqt/Z92gLC2uq6EECoWr1zLHfiSuYda8/2fLIn7L325e1KkAZBwxynaV4XMJsMsLtRU6A/tO4KFIdvF/lGu0UrhhZoH2UQJjlfZHdsOw02pzDWMXyIa/J4ZsGxdGq/joc5az34Hkne8t8/LgPUEluiejHwpOI01inM0jfUWINSgdUDwiCuhwQ2hya3eTu4k6xfLXVjpHLt5rnAvpH5ueZpHLh4w==;31:RuAl+1CN01kG7dJOnVxA1hvPtlHvnZ73DdCqMmD+ReHoKwyQp0Y3YsNzQOcFuncvPhMh3w/BTyOUr5k9NPid6fY9LVJy71scw1LINVkEYOmfm+osMqJHt5cmOCd14TIugLoVPU+/KG7pxTF33hEZZUgvjKiBTiAEDe+ZDMcp61BqJ8U8su3FuE4ALH/dGTADNMnY6hfxNcPqFxkKXE7VOb3zeJClIRibu6470p0gFWk=
X-MS-TrafficTypeDiagnostic: BN6PR15MB1876:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:BPEwcZ9QZRh2rlJGGSdGFOaN/i012ivZpPItJrJGBf9RcTTN3e2uWp0DSinSwnwKGFGdTzVy7sOCm0dJRKmaItn9TE2GRC10KtR92Hm2c2nfHRXCFO0VMEPcOZDIHFr4UBYkoLWgDfRAz689tof56agKmACzzTOYKhj3S4Bwg2wGZmAtf46zPTrAoqsISuJTNMXsOVOUCMQo+C0/oiHTJ7vZT8sYmIrQMM0JqpOxs09pqsdKdWz3Znri3636PCQACY46nqLpg7T/Tj0in2CKI1hKK00nxxKDyk7pF4ky4LGrSrThJVj2cDJc9JSMbBpd9H0XSnhtju7109GSI13lWKM5urAgYfs8IR//7idVWkU2TjBoZpBOu3w9bjP67MI21PaxDdiNEkLecmYSML2ariahDjhRMEEDBu/Lm51YHs0ZqUFLYXuhx447QxBxnCMoMBRESpLoQ6gEpektnQNRhdt8X2KelqnUur99bo921cAoFKYRf0Jo8ylai3RAnL5j;4:fH7p4+nmiErCDBciuvntCMZ+CeFOYjp5v+Q/36ieRKgguZ/Pp82+5scix5KBGkzJxnYBTv431wTwieMl35X6V8/ltTRR9OTZCoxRtfBJFzoShCYP6c1BlwGPWl7/E1c1cZnrU/8N4sAOPqsjZgBDPfenJsAW9o1CoJePZRk11gMBETsSafg9fVj9F1I7lzdpNvdpLisK5FQoiUw97KBSqhPRi6XKL/KfAiQd1jj+apWwnNvrQhOyKXlzfcmPMTsPEhtQdhfTIehcNmNP9i9Jl7R/gOmFqxpEBE7fUfIfi0bvASwa6lW01sp0Xpef/89i
X-Microsoft-Antispam-PRVS: <BN6PR15MB187641BA1CD7EC1996E3C517D3D90@BN6PR15MB1876.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(10201501046)(3002001)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR15MB1876;BCL:0;PCL:0;RULEID:;SRVR:BN6PR15MB1876;
X-Forefront-PRVS: 06036BD506
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39860400002)(376002)(346002)(396003)(366004)(39380400002)(199004)(189003)(105586002)(5660300001)(50226002)(4326008)(305945005)(7736002)(86362001)(966005)(81156014)(83716003)(36756003)(25786009)(81166006)(8936002)(33656002)(8676002)(16526019)(478600001)(6246003)(77096007)(68736007)(67846002)(2906002)(97736004)(386003)(82746002)(186003)(6666003)(51416003)(50466002)(52396003)(52116002)(229853002)(316002)(76176011)(6916009)(46003)(53546011)(53936002)(90366009)(6116002)(59450400001)(16586007)(106356001)(54906003)(6486002)(6306002)(47776003)(2950100002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6PR15MB1876;H:[172.21.93.225];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR15MB1876;23:2KcsbFoQgoOjD0GpexC+wqjyYsa9Opk2JwDgIe3R/?=
 =?us-ascii?Q?uIRtcDESp1nUoZHgor7JCucLVLXOGVMhH7rlspP0U6xX/CNYiPcul2Kefg6D?=
 =?us-ascii?Q?kdEWhwRH8SFxI9xwFTkbaQpOzZ+1LzhUirDnXS+ttLFzYuSThEPotGAiIm7v?=
 =?us-ascii?Q?czNBfM8xyI4AOSni3S84cUbWrWktAYNLxWh1duXbIvpBEVGm6U5kITUyukbU?=
 =?us-ascii?Q?ksuCGXQhAwX3pna+CDNh8fYCt94cELhZob9SIFlkXHy9YJlMthi9evfby4tr?=
 =?us-ascii?Q?bRsOi5OewLtqFLu024NsTQBYML0DxiBjn7E4qcIywwrx6wmLpTO9x/7YBFRE?=
 =?us-ascii?Q?bmQ/EJytG7FPYvMQzeVIQrYiYIl1nx0P3cKY4tsENkgdeTD6mwzgLryh2RmT?=
 =?us-ascii?Q?pTywum1S/ztT/MCwTyust+HjbdZvFIdwXeI+HeHj1hOVm8K2gfEfI5a71ihJ?=
 =?us-ascii?Q?RegYKvwGicU4yQjIZYuYvHR3z0wMMXDcZJpplPDto5HQjuS+WPY373q4ir9E?=
 =?us-ascii?Q?bObHPwR/lzYvpO/Ti+RjEzqfaQQiGT/hTnWLLqfrBTlJ41Kxr90C4vOUvo8r?=
 =?us-ascii?Q?nxFO8mLmgMBA1tT44XTMx3RHNg2syd61V56csLp3Zuosum8jCZhLgALLeDE4?=
 =?us-ascii?Q?j5i4XuXq3R1SPKWCh+dYl6NJmdYavhZ3tFFdpaQV5Q74SAmdIUdpNaWcAP4g?=
 =?us-ascii?Q?jpjAtagrgeopPOTfCavJCcLYd82UfJxxCtMyESZytepXSjbNgNXVVYl1FMQ7?=
 =?us-ascii?Q?9WSIxti5bTPebzugj5STp8BWJKnl8PnmWm3ZMgdy+YauBmEOgipLFHaCv1ki?=
 =?us-ascii?Q?GMG3BfDkgHycwsa1ZbJ5NfzwEC5aL/w9urZ948u51CT8QMz8NNsY0RjX4gBF?=
 =?us-ascii?Q?Tvk2Ss5xWgS3I9jmq+v+qvQSXJwDLFURjmRyjLzcN0XmvOjAbU2dS6DMp8eO?=
 =?us-ascii?Q?fxZKQQHu3pxGNzvsQFclRpmLjH5HmLsEAE7bW9+NUR5S9BnylAYIVz3lwCqa?=
 =?us-ascii?Q?wGwQhP6HO4jr46dcGedPk2e0kxUqAYOD2/O0Yl5XFXZIDgWj+w/AUY9uASSb?=
 =?us-ascii?Q?L6pZjlq6zjF4C/wOQjr1KDBR7xcv4Sy2ZV2uFsaf80v6V2d7br0pCoHqLMeG?=
 =?us-ascii?Q?benYrAhAtMTp7RyS2WjdLgNGP3wGJPcpcdpiZOahnpchV7k69w/mGEOya2D7?=
 =?us-ascii?Q?y7flUhAGAE0SVjQEH8ATWBr4zypP71RLPYPDsybAn0EhB7zKC4PkAbel1DMZ?=
 =?us-ascii?Q?c+XPKpe+zyqvxTyx1VmRWPcK2xdT8evWNSg5uqnIz1Vyg3LZ1EDBybxrHhTw?=
 =?us-ascii?Q?KxTimLxkCOK5JRMnr/w2u8CdBn1DdR9Xp96kMgoYDNh?=
X-Microsoft-Antispam-Message-Info: EOYTncVFoG7cgzzfEjPKfPp3iSl15CCHAaxHba1ze8c88tTIAwp5PIHEXEV2UUCuTSDIHDGobI5rMO4VX1wHO+Pc2MoJKnWqlEcRf5zEeS86k3ts3IgCOWWXrsAolhak3GK0kSMReQpyG2APb2K5QDCJtN2r4s+MHeuGEFFyrq2C41t83eVBIMHHmd3DipZy
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;6:BddGlA61iX2e1yk0YJU/Sw0vSX7A3Cfg9fQ8NotvZ1ue3O3L2j/lDgOqRTpOoEML83Hrcf+4e2WGK4kKHZ/4toXLcYAWxeEbK3wdfNm2fLLEQNC9kT/g11YLjL96Rc8NOoT7KPQGkBmbf3EBnLma9OrU7IK2hlMhrQeEHVoioAptgRBN5B6uwmFg7M9xdEyDMhYBQnkqF2Ev6iRqaT3U8/KxZWkVVNdcjO6YKdf4pRy2P1smwCTa8dAESQo4N5PiFdQ5vX4XmslFgocgvgszcoQS82wVyqW04pUqpimIgf+NF+v5wre7MqcMAzvjUGF+9EK9ISg0jF3UG5Urtvj1nWu/cboGsmE72zYlOfbVv6U=;5:LnLsiCVtfqD8bpie6SbSvWq1ox39Tqd5xnrPWETqIw1ucB0L/ZsFxjU25jjM49a/unOqAxRECGuhmwap2go34BlZ+ZigoXOcAh46RV6DI1eBRzfYM+GlB1P7bVliBJ+foz/ZfPekXcGdIbSx1q0nE1eZ7K9cFDy7q84m9Kti96w=;24:mUmhF42wxuiWC1ryhr/qR180cuk7jWeH7q5JNr9iYAFQWOXozCAnap+FnqsOAypij1itxpjnIaEtZSJad/HqNrZGxqXLS68fjKJSNFdnvqc=;7:C1GI1CWG6c/IIKNnTKhwxFlwLpkIMAxuMf4lMfcNTtX75HcENTnu4jYvII+qWL8fR2dSN+2RRPWd1DEu06Copj2NIuAcIyeyKqxJS+iErfyYHpWv25q4yy6m41diKuYOHL98YFRDHt5bVskzfl/oh73qSRHX1kQoKt8dLt30fE3YWjg5ToNveif7C/aRCxgFP8/2qF3qT1tpFJoiTIxc3BmbWQ8awtveB6iBbNZ1hjJxQIWxdFzlvnAlvhu/Yikn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR15MB1876;20:QbiKqW9LOBpcuLNcfulsWRowLEyvj3vLunTUdDWRYodmVKBlTMAWIop6dBmJ8+Q95H6ACOC3cPyuOfVmMzhkmKAfScnu8nwY1VLHXdiNxxmbzxZsNBvtYX1NryZb17bl3KHwBRXEKEdhjxZ5YjQgXcHR19NALE4Ayg3aBOMXem4=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2018 23:42:45.8275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d896c6-2101-4b3f-f386-08d583bbf723
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1876
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_13:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 6 Mar 2018, at 11:12, Linus Torvalds wrote:

> On Mon, Mar 5, 2018 at 5:34 PM, Alexei Starovoitov <ast@kernel.org> 
> wrote:
>> As the first step in development of bpfilter project [1] the 
>> request_module()
>> code is extended to allow user mode helpers to be invoked. Idea is 
>> that
>> user mode helpers are built as part of the kernel build and installed 
>> as
>> traditional kernel modules with .ko file extension into distro 
>> specified
>> location, such that from a distribution point of view, they are no 
>> different
>> than regular kernel modules. Thus, allow request_module() logic to 
>> load such
>> user mode helper (umh) modules via:
> [,,]
>
> I like this, but I have one request: can we make sure that this action
> is visible in the system messages?
>
> When we load a regular module, at least it shows in lsmod afterwards,
> although I have a few times wanted to really see module load as an
> event in the logs too.
>
> When we load a module that just executes a user program, and there is
> no sign of it in the module list, I think we *really* need to make
> that event show to the admin some way.
>
> .. and yes, maybe we'll need to rate-limit the messages, and maybe it
> turns out that I'm entirely wrong and people will hate the messages
> after they get used to the concept of these pseudo-modules, but
> particularly for the early implementation when this is a new thing, I
> really want a message like
>
>      executed user process xyz-abc as a pseudo-module
>
> or something in dmesg.
>
> I do *not* want this to be a magical way to hide things.

Especially early on, this makes a lot of sense.  But I wanted to plug 
bps and the hopefully growing set of bpf introspection tools:

https://github.com/iovisor/bcc/blob/master/introspection/bps_example.txt

Long term these are probably a good place to tell the admin what's going 
on.

-chris
