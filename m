Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2422075-1526381029-2-1175417789983073181
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526381029; b=UcmprnlwuhiFyYDs0ogk/vtW7B2KO9YG6QSMt+5+3C8uWuZWKD
    gbbUmt9rLD7PsSBPUgyyhhVY989skFRi0XmarE4lXLUE0DnkdXrLc2+JS16LYKok
    7NKQywVwxsC+ObeAJAOZkW46ueVYDeW5I2acRAXO1Si7OFETPtUwydKkDnPxMQJ8
    r/cAgY5bMzh1LTgPORopVnn8hmYR96Og79IvQiBr7ct4EpThvsDmxfmYGbbMckM1
    Jr9L1/ADwGQ65JPzW//+TA25R3rzZNf31PiERRHWj8koMS87z3E6eAivwblFbSIm
    CZk7PsFW07NcULaQd9WRi+LTmN9zDdRSvHUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526381029;
    bh=nIqMGtWpXxrHL75SSzJLQCv89zcd3V/BJb/WV6+Vdao=; b=aoUgzxllGwsQ
    kRoEsIoziiioZW5gr/gD9I5uvcGsiBIugcLwjXnaE4q7Kf5YJ4DH2/ToFfJIfxZx
    TbWzff5Oi0bjEWR7E3BR8YgPKSHDxf4eCu0133MUCo57/zdKFfPPTUtVo9ULq5gb
    bVAjK7UIHVdWYyz2yzLYvmrwJhosgpmhX2sKXx/bLdq3LwwUIzsY2j/oMkzeDjup
    cvRNym1dwYiW7J9XdcpMspopEk4Sbpb7pOpOXu6ZN7w4qBNKvXfRiNj8qPw+XEA2
    MM6aKzGp65QLiVqnNN4KgJv4GUTko7Rf8XREP/D9y8CpTxsGcX2KEO6qnC6B4GOe
    CCv7LzcdWA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=TWbRWMGc x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=TWbRWMGc x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=selector1-netapp-com;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=netapp.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=netapp.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDPYyrF+4OCzuVrV35nJ0WMVN5D1r2mFpxrFbo89PWj77YCfg1YiC0mVrq7EsA/g5RYvPD5MhOGKx66+EZgYFxlQgeg2C5BzgE5Ke8uuATjRpDvzK4gC
    5NS40KEZ8QmjeqP1EsKcsBYLdiJFNBRwQTb2aL+79EUcYaIjfbvdIMgm/ZQJYCYXC69+FNt3NWeWUYsY606OSEJt64iG/l5tnr2wPn+aaS5osOY/ldx+ySTz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=1L1qMMCNjnjm9yh_qRQA:9
    a=KznwSbzTHbZB773c:21 a=CBTmU4RZAXlBD_V6:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeEOKnp (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 06:43:45 -0400
Received: from mx143.netapp.com ([216.240.21.24]:8593 "EHLO mx143.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752357AbeEOKnn (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 06:43:43 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="259058521"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
Date: Tue, 15 May 2018 13:43:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515004137.GA5168@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM0PR06CA0068.eurprd06.prod.outlook.com
 (2603:10a6:208:aa::45) To MWHPR06MB3086.namprd06.prod.outlook.com
 (2603:10b6:301:3f::31)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:MWHPR06MB3086;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;3:mLFgTyfsOzgk0O4PSO+g8NiBM4Qo/6gFE9Bn/TjGc03354kNSlxOUKo+oZjUi4+9JL4AaxINrBOaz5w6JArElD5DlkB41rg7i7AZEcZT8EAheOrOlZSJRVsU3wS7q5JoNCwNt1vb/EKfBcsvUkBtSwNXjZIXzrNqUgNRuKbdNW0pG1sJ1o5dkvY+BF1d1K/IcZ1P2qggg88SG7n1x/ozK8n3zDxTpK1Y0Fwy9V69Hb8if9NGblZudX1WxfQtmrxG;25:4/g85lTiEvpWWIoxbmWs56Pe+vKBiNqyfW3C2l6Zio9Hq2h8sqs0bPrKvGLt0WzU1YYRtvnPjdXv6qnNTVaEUl13aaWpz1I9Zo138W9surIvONpiyTlOwqnJRQ1MtfbI8sTprguGiI7KH/gEbGPTWwwpSScR0717Hq74RTe6YR3ZWETzXi9p57T9Cf6VIsf0HlnqzGdszYFvmQ+D2UMw0VFLvW1lyvUAGQpwNMF+7Z6PjNGwxJ6W39khThpBpsy+LAbtdA+PcjekqEDRD7F3bzIF9Yxb47+yYjollIQd7oXVXehdMV/Gi4c02lY6xSpIYYWRCVrQHWRP0SsO9z4svg==;31:KIe+ZbLPMaPMaQZBsdEIPOXal9whoroOskTgWGUv+z6MVH14DKwTpG5eOZvf83608UfRaJjTqe3OV9XowTH73mNbN7G0L/qzHnpsh/yG9czx453Senh2a31FBldPfQgSMVEZQ1qsSyiqcx5Ubw8qPLziOAKKgz5MhxStwYeVS34FNZwTbNpNpnpcxOfR3ioShcrQ+z62+DBdHsu7kNwGztPptWVWpQD5fuyb7P1M7uA=
X-MS-TrafficTypeDiagnostic: MWHPR06MB3086:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;20:yDz3P83CHun1oq7P4gcjJsP1vwTN4v30EnHWs6mkWVqxa2aBhxJlWtVJqY9I1oTkW4fRuZnfyE8DQpwnC1QZEuatPLW/V4pKXTYQwxEWYPt1rSNlHbXUoZA5M+EMaEORW9yw49s2zHGENvSjpXwyaXDgTrzBFiud9pNsYyl/rjVg/V5mpbLslJj60d6okJFQUbhNcarII3uavMF+Q2TEh0uQl574K66Pyx/fN21RIfw9VNgdmyljPiM/A8LobRayy/xvrO4pL0C2zJNWvBlS0mhunw3LyynRxfiJw/rM5XHTqDg0iZ2ASI5BxJHfPB4/Y5OKHl2ArQDU4mLJQ4C0hp8lgexPwLSw453MiwUqYRZNk6Z+nIxS8ANRwYGJ7Ht5Wm3ub51D9rkcE9n3XbbgscW9CRF3zRDwOSZ/SCgzcrKq2/IvQf3CYXdeINtEq0Ul+z1FdSe1SUfvQMNXFeRRmONyS55OK8uLZRWjlwqVEHBTHaDS5Cu5ieFWi6+6FOtH;4:YeH9mciOGL1D2gOgkpQbMmn9I2SRjexMD+ZJvzcXyPl+aLzR+xRIxtc9P2O14RsQqrO5NddPxk6x02htjNGxZkJEgN6zehw78GGdV588DuNNX4ueC8Jlice2nWd8emHol1/KLzC3aZA/3CE4MqbHIraOk9pOIr8NyoKt71BZVslkL/2Nr1L5+oqloDE06PoMkdKBLv6jS0+dxwSYTEIgd4g03wSmZgq+/1bRe7M1fJi+cifzaZ3UuvoyhyNSWp8i1zSS9b4KuHswI5n9zwpMjA==
X-Microsoft-Antispam-PRVS: <MWHPR06MB308600D27D5C49306502E262EE930@MWHPR06MB3086.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR06MB3086;BCL:0;PCL:0;RULEID:;SRVR:MWHPR06MB3086;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(39380400002)(396003)(346002)(376002)(366004)(189003)(199004)(72206003)(386003)(106356001)(316002)(486006)(7416002)(8676002)(478600001)(16576012)(97736004)(230700001)(6666003)(6916009)(64126003)(53546011)(93886005)(81156014)(81166006)(31686004)(4326008)(68736007)(956004)(6116002)(54906003)(3846002)(5660300001)(107886003)(476003)(58126008)(77096007)(31696002)(76176011)(2616005)(26005)(229853002)(6246003)(2486003)(6486002)(7736002)(50466002)(25786009)(59450400001)(8666007)(11346002)(65806001)(36756003)(446003)(65956001)(47776003)(305945005)(16526019)(8936002)(65826007)(105586002)(52116002)(52146003)(23676004)(2906002)(53936002)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR06MB3086;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjA2TUIzMDg2OzIzOkswUFQ4NmJaYjVoejhuc0VDRWZxTXJEeURI?=
 =?utf-8?B?RE1ibVRMWERyTitISVg2QklxZFhuZ2tPZlduRjFrWUJzTnZtTEthamdZckxt?=
 =?utf-8?B?SkpHa3BWcURHc0dXVlZ2ZENyUzlGR1FTVmgvSWM2NjFtRnFaRXFueFdSeWRM?=
 =?utf-8?B?ZFREUU9YckU2Sll0R3BUZ01WdmJRQTdvRS9kWGF2K0VDTnZHRlZnckwrSlEz?=
 =?utf-8?B?dXREaVN0ZGJoZG16MlhTdWFScDFka0grdWVKaUdVa1M1RjhZUHlNaVpnaTZ6?=
 =?utf-8?B?aUM2TWoyYlJKbW1WZVJEMU50L0RnVWJHWVhOSkkvdDYvd0NMM1BpWU5UVzcr?=
 =?utf-8?B?VEZiYktib1E2TkRzOGxuUndOM251WS9vMko5TE9pQ2dkL3BhcHR5WHdOQzhR?=
 =?utf-8?B?VUd4ZnA5dGxyRytSNURHVFIyWW5zbEVpaFZQYWsyY1prczQ0d2JpOUNpVFhC?=
 =?utf-8?B?T0VGeXdEenFYQmMvcW9YRnlZS05ZdFdJNlVlRmhxTVk3cURJY2pDNG15K0gy?=
 =?utf-8?B?cmRybFJ3akN5QllXa2diTjlQbVVUUzV3QTY4Z1RHMGNpenhMTUlacWVTMU1x?=
 =?utf-8?B?VEVwblNsUkJnUldYbGhsY0s3UFBES2MvK1FiaUpxZnJEUHkySURjUEY4UnVK?=
 =?utf-8?B?MUtSYlI2YU9uVDJDZEd0ajFZOXRaQ0dzYzZDYjdZSElqcUR6TG15dFdQN2tD?=
 =?utf-8?B?S2k2Umt5K1ZrTXRmSHhYb1FIZFRFUElPVnFyZ3RMdFF0bXQ5WGFaTTJ6RFFT?=
 =?utf-8?B?MGFKNUJNRHM0c0ZDMk1lZ214ZmQrNFhNY2NTbmo4dHBNUWdoS3Q2d0pJTTNN?=
 =?utf-8?B?S0xKTVRGWWw1VmpVZlRkOWJUdDdoZStYcTlKUEJ5NE1TdWJKVzNvdXp2TlJo?=
 =?utf-8?B?dENoSW5Kait0dEs2U1UxbG9QQjhScmUydHc0ODg2K2pIVlpxUUcyaWVIbzZ1?=
 =?utf-8?B?dTNFL1RLQzM5ZUl0dDRhQUc1MXUxb0xEdk10YU5xOGRqellzSW53ems2Uzg1?=
 =?utf-8?B?WWtoSy93STBnc2tWNS8vSXV1anpMeldzenhzSWM0L3J1YXRKWHBpNHArazVx?=
 =?utf-8?B?aTdtdEV4MzRuWS9oRmFHMzIwY3pDSHVHUEM2WkFPTHpjeEc2YklBL2F5V1E5?=
 =?utf-8?B?VFVmUXdPOU81TEZGUm1vbzVlZDZ0K1hDWkNkY2lvSUtBWmMrbzRXbmhzSzdH?=
 =?utf-8?B?Y0o4S21uZnVrNXVaS0hXeS85ZFczcTd1Y1ZzY0xlMG9BTW9tdWkyMjJzQ0po?=
 =?utf-8?B?c2k0OUFWRWcxd2ROeFBtNjBLcVNiemtpTkpZRm9lR1VrMjNzTS9sRTlZaE9j?=
 =?utf-8?B?OW5RVk1nYXZuQlRCREpXRDU5RDVPV0tYYUsyeU1kNGpmU2poSGtNVzlEcnlw?=
 =?utf-8?B?bFRnMDBWOStOZkhwdXA2SjlVeWFsOGVBZkRzVk5jaVFMcUJLQ1liYWlyditz?=
 =?utf-8?B?Sk5rdmo5aUFyZnNYbUpMWTQ5VjJpN3pORWtmVURBUkpJZXFPWUF3Z2ZMbHlL?=
 =?utf-8?B?djBiRklMNU9lRWZwdnNGSWhBbVUyN2xuaGpLY1ZraXZEZEhaRFp3anBPUUwv?=
 =?utf-8?B?ZFZaODRmVEtvalZOc0RwL0gvV09UQ3JkZUg2bHZ0U0NVdDlwaGxtRVFtQmUx?=
 =?utf-8?B?cFhEU1h1am93TWhWZ2w3ZElyTVE5aEFZTlB1c1FCWnpRMzdNdnJWeE92dUJK?=
 =?utf-8?B?R1lHK0lha3hpOHJKWWlnN2hqd01qZWg0WHYyT1NYMXZlTk9Wd2F3Ny9MT3lF?=
 =?utf-8?B?Vk1CbjdIbHF0RmVPdEdGL2s5VGJjd3FFVEFneHJoeFdXSmd6UmNtc29DYmp2?=
 =?utf-8?B?Qk5OSEVUM2JlY2tHcXd1Sng0dlNIbTVtN0d6eFMrbTNKZUlLTW9SN3J0ekRO?=
 =?utf-8?B?QnBUVTV3YXlweGVsSE5pT2l1VDRjd2p0OFJHRCt6RFc5QnZmZ1hNdjQxWmV4?=
 =?utf-8?B?TmNwZ29iQjEyWnhmRlJqRTk0MGY2N2lwc1M0bTZwTzQ5eitySU5PcjZ6eFov?=
 =?utf-8?B?OGxNNkNnNkk5aXhnK3N4SzlqbWVyaXpNbW5UTnRWNXhWWm53WmZ4b0FCK3VU?=
 =?utf-8?Q?ZehuKNpAwicWfzb94FnjBr1Bu?=
X-Microsoft-Antispam-Message-Info: r6hig0hq4zaVN+LF7ZP+Dr+fbKa7+GGNJonqyj2vnL4Ag9Vy2Fuqz9jNSwVACag0HDZX7cYrZuT7A/GQ3m44F+AWFZPRK9H6CSXBvccfv1qDvy2FtsCmsiwNrEcxo0GMsNexE4qL+wGF42I844q2kI3D7CRQjP1bBwrsuGwwmUtitObGxjIXgnOkFnMCmFVM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;6:NhquavTUtDqvsncpGPIZejbyPXoocMKIVPwlkS90xs3wRZ1syyTZQ2HAH1hlL4d+uMdV+6+K9Wr+HU3nSNUYJWUkuv8ba5izvp6xQRS3bnspRVJYi1GaMr46orooYU9IBwH9S8rTMcNcq4+g4+ZtvXLT3TnDz+anSOCMI9J/jZJqmZLPP/ymasFAJ+x0VbyHndG1FLXVNpy5pjjHJsaSeYeRoKqfuHSYiYeGgbM3/+zeib+Ntx/cWfv20TYRrY4+d6xzHe1/Z81ADNfviI4Ao+mJb2Zmqt8XrDq0TBOgOxHCSuzupaTzBiWzC9ArgsXhIjsDTnLUaoZSyg9u3eUYixUdaWipO8DS1ntnDawlAW+ljJvfLeuMz20ujat/t6TxUlE0XNBUbdm4ZTsUfKhY03AuCC69maGyOPijmnYk7KQiyk9DOpQNS+dPeSQloyPTOzeWvSCUdD04Ejzo3h9Vlg==;5:0GeHe+inZobNKR4aCP0W5bdjeA/ZoX4kuSL8n7O03x7Rqz88aFfRDnbs3dDB6MO5eHYZJNdD7QBZNRrdkaEDPWcH2FwRPMZ37Q2GjwcCa85HZYfyzOKSDiJxOQdyrLaYnAKEfRNmJaMjtRAH0ha6GBAs4gzhn0JyA7y69Wzs+iA=;24:yAoV2zUGXSfxXQ6K9lyhv3mjw9aPWc4fQ12pUKlz7vodJXLeIKcFPfJ3WwvlwxCGxLQlkrNcBOAjopaMEMxc12/VUWa0PdQZ0e0cgv+ba/g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR06MB3086;7:t4GUj8R9jfhezNcwo6aizgiaOqHMXDNnAI6NI8B+aflsN86pHBzuqq/F+3i2dL3LncFv+uE8aBtyRgiEE79OeQVSDt5w9A/7uwRUdP4k7BovQ56PiT8k2a5DRlRQ8ckmeV3ZfJEUhQ0LLzOvxw/3VXvOOJzjemnn1a2zHSTEsPp2ERFU0/6FaZ4GLXtOxxf/TT9WRmsz0JMT/6GR7uuMVXS0mupjcm6Jr4+6ieehKqFpcjduaF+/u4HEAGRRlMiE
X-MS-Office365-Filtering-Correlation-Id: f1974c49-c9e7-44ae-649c-08d5ba50b86c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 10:43:34.7991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1974c49-c9e7-44ae-649c-08d5ba50b86c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR06MB3086
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 03:41, Matthew Wilcox wrote:
> On Mon, May 14, 2018 at 10:37:38PM +0300, Boaz Harrosh wrote:
>> On 14/05/18 22:15, Matthew Wilcox wrote:
>>> On Mon, May 14, 2018 at 08:28:01PM +0300, Boaz Harrosh wrote:
>>>> On a call to mmap an mmap provider (like an FS) can put
>>>> this flag on vma->vm_flags.
>>>>
>>>> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
>>>> from a single-core only, and therefore invalidation (flush_tlb) of
>>>> PTE(s) need not be a wide CPU scheduling.
>>>
>>> I still don't get this.  You're opening the kernel up to being exploited
>>> by any application which can persuade it to set this flag on a VMA.
>>>
>>
>> No No this is not an application accessible flag this can only be set
>> by the mmap implementor at ->mmap() time (Say same as VM_VM_MIXEDMAP).
>>
>> Please see the zuf patches for usage (Again apologise for pushing before
>> a user)
>>
>> The mmap provider has all the facilities to know that this can not be
>> abused, not even by a trusted Server.
> 
> I don't think page tables work the way you think they work.
> 
> +               err = vm_insert_pfn_prot(zt->vma, zt_addr, pfn, prot);
> 
> That doesn't just insert it into the local CPU's page table.  Any CPU
> which directly accesses or even prefetches that address will also get
> the translation into its cache.
> 

Yes I know, but that is exactly the point of this flag. I know that this
address is only ever accessed from a single core. Because it is an mmap (vma)
of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
only that thread any kind of access to this vma. Both the filehandle and the
mmaped pointer are kept on the thread stack and have no access from outside.

So the all point of this flag is the kernel driver telling mm that this
address is enforced to only be accessed from one core-pinned thread.

Thanks
Boaz
