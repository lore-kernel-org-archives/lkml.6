Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526385306-2-3860226862494463933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526385306; b=UkoUfxQj2QyxMMn5lHq2YygJCiPSAd10/U2Dejv10z7UQhBEdB
    JUTdTaradYfm1KLqS9YUqPlYl+3oF5EmnZSf8RVJ/enivBPNAFxbK2qwxaerYnjs
    YJTbo5wT8hmunr2+cVMGsaNoW+51bs5juuD44ey9Pp27FqzsIC/hnCvaPa1jDuEa
    I7atGZtxn/lDjnOiFqzv8CK9yYar0ilOHiYv5IF3ikg0bsRtvFwSHCl1eaVJm5fD
    jtfjMNnwjlvGMjkWAB0fpr0jJVrGIbgj66lB57s7TGLh6WNyZLrxKQ/B9kKvYleh
    DQsUnK05MF8TQwPPs/0phnYp/Jvc7/KGxwtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526385306;
    bh=IpH+czSKLlB3WFjMCwB4fF85yNxT55N+Eo55NCmqN10=; b=mCJwyZEarb98
    9MSzjn4HXGcZIgKxcyY54l0azIFsLabvH03RRdiVhgh6tx+qwlAiG7PbUFWz5MMZ
    KaWm3LSZFeJJQ0AA0Oq0nFWSenIGU5Ndh9MLsMpqGEBSXb3KqWm6hSGVg8oFMIQr
    Tzi/OsjCGQOz4edOPqPTLvBBBwvXoku8tdguwzg8miUbGP66NEPNz0MRa2q8Y+bw
    2d1dH3qKn3EaJMLpFzsTNRMa14VKCLPMJQnCEzlcm4oBdleUzhkL3Fu2B9y8elmk
    0GCjriLWYzvujoXOnQpTv4GCReI0BnqIM36HEdDv8a3zfTce00RJthDWJQ/xx2gB
    cLF3uSGjQA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=mMhc1sSs x-bits=1024
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
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=mMhc1sSs x-bits=1024
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
X-CM-Envelope: MS4wfFEukyjiWLWCUtgePClhLwrgkKNnAyVB6U46bBdQQs4t0NDAnxER1isN0tPQhwCT3C0LLcLtBCMoJ/FwxTiT9gTeWcJ8fRR3nzKiv4cVxEsBNlSMkEOO
    cuPTN17jUCtM9wEMoA8gyhPFWU58I/w2m3/ijc0cXTx9rbf/frnxfPTVfjQ/4UQnedXFV/C+SxWZbl8AAGy+VZj5ukdQWQQ7DasxDmgRdOEnZnIvUWSiSadj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=JDjsHSkAAAAA:8 a=NE520SHd04x4mZQVEpUA:9
    a=QEXdDO2ut3YA:10 a=dseMxAR1CDlncBZeV_se:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbeEOLzC (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 07:55:02 -0400
Received: from mx141.netapp.com ([216.240.21.12]:33126 "EHLO mx141.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752580AbeEOLy7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 07:54:59 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="273825693"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514144901.0fe99d240ff8a53047dd512e@linux-foundation.org>
 <20180515004406.GB5168@bombadil.infradead.org>
CC: Jeff Moyer <jmoyer@redhat.com>,
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
Message-ID: <cff721c3-65e8-c1e8-9f6d-c37ce6e56416@netapp.com>
Date: Tue, 15 May 2018 14:54:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515004406.GB5168@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR04CA0021.eurprd04.prod.outlook.com
 (2603:10a6:206:1::34) To DM5PR06MB3084.namprd06.prod.outlook.com
 (2603:10b6:4:3f::33)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3084;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;3:9wwJJKBa6DjTjKSTscf8YZ/tsMYKSs4zgBbt1TKzwCKFNwZk3qWQOp2we1crLFMh/TZMB+WDK+4zEhepb1rm5eRmVpmzIUN1x0ZxgCBiO80J5LsySKrN/ZSX6JY1bq9vhO6+n9mhDylN2ZhYYjIYLi+8fYhBX4COovTP6FJpTVXNv0WyVHi8k1pTbbthh5GAuGA4Pm9ESWgCqAGwu/n164MeMIeTRfijFIi97+Sk1EqjumRTjATGMBQoOBgUu1xQ;25:AizjQyHO7Nekh3/Wlu+kJ8TsU4gq3vXjlCwKa8ttn1nL0w36u3u81I73ls2+M7wqow+8nTwkBCKCuHgZoMrmqFbxa0ke889sn7g0XM13Z534fbdwitdqAGGPg69gUhQcbt1zLklEw50ztEqfBYhd4z1nAqCmgeL7CzcI4tS1k7VFfg0vMcjjptmHVLzurfo8564pv1fVvImqhaigW3YK5cXpMMGQY7MOaJ34EkYnIEnqzFz8Qz1M5pWVpOu2RXwONIRP7Z4FwXHcqsuXe6yhhzTdIZYBx2HhnIQ52kL2Z7m5g9O/6jNuriBF9yJENUQeQu/mIy9miO55dINLXqekOQ==;31:lHSrz6laN+wlVSo0xM8ryfL4IAOku5boAF69kkrX/HVh8Vc2k/Ai/O6ire0CB+bi74lYhQvZ0EtZ5IdlBD8fyBiVSJr3MrkRVdq8Z7wIhgxE2xURzZPsqz/010yD8Lrr4Q22o4i1IXvMZCC2Exnet5hFyYdzNyDw6rh7YQutk6KwsAdMex7kMRVvFM5xLfGkA1GtZnQeY76Gis9pX8/nCXPMhW5cN5+SsLfXlciWo9A=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3084:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;20:0mVTFcQWqKiwHoaJRKgkciid7VLHOAN4HzEdZZPephGCyr4+lCsOOHF3Rjg2zO6YgmbzgpI1dQsbMoi7PneH9Ao139VK40YL1JNP/Tlk+5cxLdhGZofxyh/7s19rnFQWUEGsQ15UgOs8emnaWebzhjdrW7fmbPeGBToO4wPUaYI5bIR6q7slEvvxRuFSprmFMCKN90cxkfRd/MVEO5R7ARLY/why9KEbpzBScNiC6mCTqMxayc47ZtmoVgmgKQNCeYei7Bt8dURIVIny3hTUHBBvktphUsiAn/C4xzLz4Irl8+FbLl4IHQYyfXd6JJ058YnjR3DVgP5dx+uGXXGhYZDPLTdPz0op6NO6YI2TgPyRbsWdn7seJsPEomGfSq8ff8GNkeyVNOenX7ti/fiBT1r5CZoMMggW87Lc5/O4P5PzfZCD7NHn60QIWDlOo1ayxVxQpzzoaSZd2fR7qUDo0MTTLJ1xWL4QizCTUZsd313Go8MyagNA1cH09S8vM1T1;4:uQ2wEqfnum6qGAyk+/OLvWWPPhIJodyCi9hR6nrPJzpY/eEyAoQ9EDoBRotoBrKvfKTwViVyUIrHf+IOWd9pGz8pLy3idg0LlRLhCSl/UY+vBGBIVUhQJiLodyjap/Yw+0Vcj0qrAX5CVRQDS7WQDTF02O6Mo8fPX/JjY5W7hNUj/WPhPYmJd8+gOjUsRwZZ6C0xOn6qAPwSVgyPSg86Iqs/sLn6PhFnj1r0q3h21SMXRMVzK5mv1/fVQvsh3tXRV06TTBLI4ek9D+a4jWwLWJ3MtjZ7k/m46jBKpB/HO/L3YqZ1gRrS6X1raq2mbm5v
X-Microsoft-Antispam-PRVS: <DM5PR06MB3084F55FF9B8ECC1AE3C6695EE930@DM5PR06MB3084.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR06MB3084;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3084;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(39380400002)(346002)(396003)(376002)(199004)(189003)(11346002)(2616005)(476003)(956004)(6486002)(305945005)(47776003)(446003)(229853002)(7736002)(4326008)(105586002)(8936002)(106356001)(81166006)(81156014)(31696002)(8676002)(64126003)(25786009)(50466002)(68736007)(2906002)(72206003)(16576012)(230700001)(8666007)(6666003)(31686004)(107886003)(478600001)(54906003)(65826007)(36756003)(6246003)(5660300001)(316002)(58126008)(110136005)(53936002)(7416002)(6116002)(3846002)(65806001)(65956001)(486006)(66066001)(53546011)(386003)(59450400001)(26005)(16526019)(77096007)(97736004)(76176011)(52116002)(52146003)(2486003)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3084;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDg0OzIzOkxoZ1M3YUdOVndQd2tORHJQUW9SQmhsZEMx?=
 =?utf-8?B?WGNrVCsvOURNVFR3U3NEL2xJMzIwTzI1aWJ2YlNHWGU5UjNDYW5QQ1JlaXJ2?=
 =?utf-8?B?cUpmb1g5NkVyNUg0RXZia0tuRDNpYlFaZ1NEVHhhdkVmS3paTlFjUndLT3dI?=
 =?utf-8?B?SHRlMmFEaDRPYkNTaGdZaGg3ZGdZNDNpZXVOZjFLb1lnSXZCNnJRb0VPOEtC?=
 =?utf-8?B?NlpseUdlYWlMMCtuZktIVHozNG1CNHpkZzZHem5GU1N3ak1CL2lTSUh3dzl1?=
 =?utf-8?B?cURQcVdvN2M2YWFrYjFCdnpzbGdRMUJFTm8zR2lqRldZM0JDTmQvc3h0RWlu?=
 =?utf-8?B?YnFGUXJOU2NzM1lPSmlQZHNXelljQnpQR3N4SUVlc3RJaTNRcmZKdUNwS2pl?=
 =?utf-8?B?ZFF5VDBDeGZ3QVo5QWd1bFBDZm1IWGw0UzIxRkRXNkRWTnlqR2NOeFpKakpx?=
 =?utf-8?B?R0tJbFZZV3lHeWFVUVZrYTB3eVVNK2h1b1NGRXVtUCs4M2FmMzJyMWNRVlk0?=
 =?utf-8?B?dlU5ZU5UaVIzUzkrcHdpNXdxZlpvNlNqOXBzb05OK3kvVE1lRnczZHZwK2x0?=
 =?utf-8?B?bExvb2xHaUpVMkpDa0RmTW1yRGZDYjJlMENFZHpaT1dTRmxHVWxQcWtNTEh1?=
 =?utf-8?B?OUJSOUVUZnRiZG1COHE0bndmM1p1UVNPTGdKcHN0SXhoLzVjVjRGdTQwZTNX?=
 =?utf-8?B?RERIT0xlR1dPemp1UXkzZ2ZmV2orTXFZQVFXQXRyNjc0QzVLdEdPRWloNXJ5?=
 =?utf-8?B?ZTRtYndGcjFPWHYyTFo3L1NHb2tuWlluT0dWdGVMaTJnRDVMREFVTXNXVHU5?=
 =?utf-8?B?c1BaUHhQU3RpR0w3NXVWdjBvdTFFZ25PY2daVmR0aFhCUFk3dnFjdXY5cnU2?=
 =?utf-8?B?S0xLU25RTHJ4dDE0NGVydEtQNUlkd1UxNXFEaktaOGd3N1BNM3lJelVEdWd6?=
 =?utf-8?B?clZXMlFrL2JCMU9PbC8yYnFyTjlUdjhZb2N6MjJtcVpWcGV3VmlkeUlkcVpz?=
 =?utf-8?B?R3lBR0d5ZndtejAzcjJRaXhlQnZBNmV2U0o4ZnhISnRvMG02cVBLVjFaZTE2?=
 =?utf-8?B?dnZZVDNTdDVvSjNXTTBzVU1uU1BLUXc5RWpTcklFMUUvSEo3elR2WTlOdzFu?=
 =?utf-8?B?U0dPS2xLM3dQdTEzaGpMeFVLQ1JOZW5CU2lUUVdMTjBndUxBbTIvc3l4Rkl2?=
 =?utf-8?B?MUxLMThTMlVaWTJFNm9DdExSQWFpR3E5ZlhiblNSZXpDbnI4aUgzVFNvbmMr?=
 =?utf-8?B?OXVnSTBBV1R6WDA3S3RQeXdnZ0R0UG93OTA2d0h6bGFrckZMUTZCRVJ1UWU5?=
 =?utf-8?B?ZXBaMngyNTVBVTZMbXBuNTB0TTI5OERDT1ZZTW00MmVYRjZsSDV2NmMwZktF?=
 =?utf-8?B?My9KSUhZT2Y2QVBDeEVFam9VVTFaMnJ0cjk3YkJGVHNJdjg4eG9RaHFqc2pp?=
 =?utf-8?B?NnpVTytORDJjQ09FL3lhbkZvK2Jldnc2U1lvRVRlUWtPY2JycjRySmg0ZjFz?=
 =?utf-8?B?TXlld0w2OEVxazJZcU1wbDlxQkxONllwMUlZeWtmcHZ5bks0N21xMG9UbDdy?=
 =?utf-8?B?THhYV0ltOTZyWnlvdHFYa0ZpOGNWOWV0VEJIa2o4RXhWRlh1Yml5djBHMVA1?=
 =?utf-8?B?eFlyeFdhTTErdFpjU2taVTVrUGY3ZkVEcnB2TFJ0OFpRRWJ4S0ZtNkUrMEk3?=
 =?utf-8?B?TEJIV0FmdmNzM0RGbGVNY2hKcmVaUHJKU05JSzBxRTRtNHlmYkxuYVE3WEhr?=
 =?utf-8?B?WGF4Y0FQNFlkQXZMTjVmRG42NUpQV09TOU9ORVNPQ1VQWHM1eWZDMWVpRUI4?=
 =?utf-8?B?NVBXcis5TWNCaWU5ZWN1OGtXZzRiMWxPZHU0U2hxNWNlRXlPYVBDQlZCeVo4?=
 =?utf-8?B?UFFPblNVRGh6TDF3M2hEMHMyUUd3SmxWNENGTU1SRTJZUXlZciszQ0I3U2k5?=
 =?utf-8?B?eEcveDlhNjN6UmxkaXl3SHlOM3AzUzNoMFNVeGk4ZkhsNEo2cVRFd1krV3Uz?=
 =?utf-8?B?bk04NlhqSXFwN0VFQkdGOGJxbzlxQ2ZYcEhZdTZUSURSMysyZCtVMmRvNUVn?=
 =?utf-8?Q?Fq8Y=3D?=
X-Microsoft-Antispam-Message-Info: 027EKJu3XxvCIup4Of5H/cmyhHaRI7sPo4/x2ag3WpsSw5TFQ0yN0xp39aZhmkcpuJO33eDDJWn4WwfXNtMF5rz067csVjqG4jTCrJnnVbLzDTis0w6Nd/JvOlcnpfrc4Dxl8xI47qvGSk6WDuCA3u2nA7eKk+SFfPoz4SFlIrhTZ5yhUl5W/BeqwVASVrC8
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;6:c2ghZ994sYUcu3u60WHPgQ9NGok/eAP1yUmXJlC2VXp+/C/ifEA9nvlR1CPquohCp7Ktgp+Xx0mna2WVAUHp6blCDGT0kceHN6FciRadAmQuLtZZXBtmuVRiPGUrrvBUmM+M4MlOJ3MO0vwuGoPZ1yE6Ql7UWwW2ZdRsPNfDsBcZu3AC9AQNew4LOZoVTQ+9RvZnpti3P6Qq82Tm0X43+mxFU2RjhsIWXGl0cDxUaMRaABZKIMDdZldUTqI4yoWR4FOI4C8u9eskIthyLRjqsnZSH5qP/V+louaYgbtEAV8Q2W1qk/qzBkfv2AB/cMqQTw0atBqAfDHP4lGhN2GQt/Zeraf3V/98pOijcAAgKPB9kOXe/FYskpozF6BHLuS2030PdxdX13WkDtGJSSoDnU3KUupiEH9zx0MwaK3MQyUkDQmAX5GZ6+2LFfQnhXSim2ClnFUXMxBLk43iYXLgXw==;5:5nIYhwPQAItJ6WMGB8cgV2DRiE2ut6WCWSzIz1QonVtoDiVyH57E33/Api/7HnspebkyW5lADkKwVoYs1pUDE1aUfoeFvhGV3xMPZ6DBCQWiWdSuOYN8nKyOz+kcQ0kPXPGyamVmjXI8u2/bMpxIm7XAGDV03od8NUkRdlPfGlo=;24:Q0QEgyj/Z0+yXo8GiSAeuFwmn2uFL83BUhkUCfksKHh3mPXqt3+VcTWVdOxSGuabwFecab+ZzSrCwpKIMwxZ1qVdh7AB4nfiDPG/DMWQlNM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;7:xBJ1nB1IjGNYixAjbQpEabjmvMboX9/c0rDiSgE4K85m7kFrxHEQ8dbxBe33iW1orXR/RIrANMlp7Xbe1bW2YnXa/X7thPPs6TH2LCIyY/iMMsWTJ6U3R/oDnW75PLOj1N15Z5HDyxn5yNwQRe8jPTA3LGdsw4mYNnX03GaDFd+13aw4EfARvGpC6j3sHR3gJQ3+vl1dOiMKClM+2hrVbswL1+VH0K3qIlLm6sMrjgm4NsTyxP1rxUeeEPD7ACGV
X-MS-Office365-Filtering-Correlation-Id: 0e125fb6-f3fe-46ac-8b1b-08d5ba5aad5a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 11:54:51.9289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e125fb6-f3fe-46ac-8b1b-08d5ba5aad5a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3084
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 03:44, Matthew Wilcox wrote:
> On Mon, May 14, 2018 at 02:49:01PM -0700, Andrew Morton wrote:
>> On Mon, 14 May 2018 20:28:01 +0300 Boaz Harrosh <boazh@netapp.com> wrote:
>>> In this project we utilize a per-core server thread so everything
>>> is kept local. If we use the regular zap_ptes() API All CPU's
>>> are scheduled for the unmap, though in our case we know that we
>>> have only used a single core. The regular zap_ptes adds a very big
>>> latency on every operation and mostly kills the concurrency of the
>>> over all system. Because it imposes a serialization between all cores
>>
>> I'd have thought that in this situation, only the local CPU's bit is
>> set in the vma's mm_cpumask() and the remote invalidations are not
>> performed.  Is that a misunderstanding, or is all that stuff not working
>> correctly?
> 
> I think you misunderstand Boaz's architecture.  He has one thread per CPU,
> so every bit will be set in the mm's (not vma's) mm_cpumask.
> 

Hi Andrew, Matthew

Yes I have been trying to investigate and trace this for days.
Please see the code below:

> #define flush_tlb_range(vma, start, end)	\
> 		flush_tlb_mm_range(vma->vm_mm, start, end, vma->vm_flags)

The mm_struct @mm below comes from here vma->vm_mm

> diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
> index e055d1a..1d398a0 100644
> --- a/arch/x86/mm/tlb.c
> +++ b/arch/x86/mm/tlb.c
> @@ -611,39 +611,40 @@ static unsigned long tlb_single_page_flush_ceiling __read_mostly = 33;
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
>  				unsigned long end, unsigned long vmflag)
>  {
>  	int cpu;
>  
>  	struct flush_tlb_info info __aligned(SMP_CACHE_BYTES) = {
>  		.mm = mm,
>  	};
>  
>  	cpu = get_cpu();
>  
>  	/* This is also a barrier that synchronizes with switch_mm(). */
>  	info.new_tlb_gen = inc_mm_tlb_gen(mm);
>  
>  	/* Should we flush just the requested range? */
>  	if ((end != TLB_FLUSH_ALL) &&
>  	    !(vmflag & VM_HUGETLB) &&
>  	    ((end - start) >> PAGE_SHIFT) <= tlb_single_page_flush_ceiling) {
>  		info.start = start;
>  		info.end = end;
>  	} else {
>  		info.start = 0UL;
>  		info.end = TLB_FLUSH_ALL;
>  	}
>  
>  	if (mm == this_cpu_read(cpu_tlbstate.loaded_mm)) {
>  		VM_WARN_ON(irqs_disabled());
>  		local_irq_disable();
>  		flush_tlb_func_local(&info, TLB_LOCAL_MM_SHOOTDOWN);
>  		local_irq_enable();
>  	}
>  
> -	if (cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
> +	if (!(vmflag & VM_LOCAL_CPU) &&
> +	    cpumask_any_but(mm_cpumask(mm), cpu) < nr_cpu_ids)
>  		flush_tlb_others(mm_cpumask(mm), &info);
>  

I have been tracing the mm_cpumask(vma->vm_mm) at my driver at
different points. At vma creation (file_operations->mmap()), 
and before the call to insert_pfn (which calls here).

At the beginning I was wishful thinking that the mm_cpumask(vma->vm_mm)
should have a single bit set just as the affinity of the thread on
creation of that thread. But then I saw that at %80 of the times some
other random bits are also set.

Yes Random. Always the thread affinity (single) bit was set but
then zero one or two more bits were set as well. Never seen more then
two though, which baffles me a lot.

If it was like Matthew said .i.e the cpumask of the all process
then I would expect all the bits to be set. Because I have a thread
on each core. And also I would even expect that all vma->vm_mm
or maybe mm_cpumask(vma->vm_mm) to point to the same global object.
But it was not so. it was pointing to some thread unique object but
still those phantom bits were set all over. (And I am almost sure
same vma had those bits change over time)

So I would love some mm guy to explain where are those bits collected?
But I do not think this is a Kernel bug because as Matthew showed.
that vma above can and is allowed to leak memory addresses to other
threads / cores in the same process. So it appears that the Kernel
has some correct logic behind its madness.

Which brings me to another question. How can I find from
within a thread Say at the file_operations->mmap() call that the thread
is indeed core-pinned. What mm_cpumask should I inspect?

>  	put_cpu();
>  }

Thanks
Boaz
