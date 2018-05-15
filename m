Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2582198-1526387494-2-5288284862868612002
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526387494; b=aegE/91I7HAEm/WQYawmjiL+xaZnNg3v8pITUnjLoouxgKA+vc
    alGQ+Ef80e+f0i11iOhezQAYb5PU4a4ONHV9k8EOPnZvmYW1X6WZWc8EATTTKTvQ
    CMkXUUw3TA5voWFXdfM5BwUI201ZGfjWq0n6BDv9qDdRZH+ZG5pYO9Pri4QnC6bc
    9xuR4cPt2MA/QnG3So2OJBCD2OH0c6OCkUkawvmX/eBqeHgbKsv3XhSId6M2i4Sh
    8IaZNX4LI7wtU+DG/xHJpnQNhzHdA60+2eCiVVfAccspVFnkCZNj3AqpL7ymApYd
    OGbD1GaFo7RSBa00/BU7zpczFX/kCn8isPkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526387494;
    bh=iqZN5jTzHl+KSRjTiBN85/yeGO9jBCM7wOY4+kaZNw8=; b=RSAzRnCTWqHp
    sb5KYJAJIH/GmUK5Vg2foIF7aGd0pVZh6n1vbho6wwoJMphrhS97V8JNoY5eq/Yw
    i76Bfc+vz8K91cZrMpHUFnDJFqcdEu1AmqhoF3IgRGxkWl1XBXgZ/4Yjag8QSeMr
    u33M83KwLH1DmyH2VnnHD1mv7IRTqc9bHYpUQ5+iZXhTpKwnf0VYdKQI5UuAe6Ok
    aG/k034HkGqlSXQ4LdH0kuQnOUQ2dPGxN+KVecSrjygfEadTMKwuJ9tr5tHXqFjx
    WSvKXp+bDn/mgsgt8zzAiRXdOnzV7EejtxrSf/7nHeAA85d2eHNsEL0Rc5i/scLu
    WpH58z1jpw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=FaTPTzZG x-bits=1024
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
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=FaTPTzZG x-bits=1024
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
X-CM-Envelope: MS4wfHdp7usFDyY2MBKuG7h6xSRswxIOSY1ULZQ8vSUrdoKd9Wtm/uU+80Hllee/y3fThq5nPxctn5R6zuDY4zfw2Ewei9muzHqocCWSsXB3GoVZefqj7AFl
    dCbavd5J5GS76YbjIWzpD12A7d92LpzhGyFF/3bM7+jnFbcYos2axDWVv5uUNH9xYyUpzgckyRJycI+6cSNS8EkNPtmY7Vy5OP5clQcThRjsLjaMduVV7ZZ3
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=klSspgtuH7TFwNFDn1sA:9
    a=IbL8ETXaAveJpOIY:21 a=cEKPFVXdMuDmBZ7P:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeEOMb3 (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 08:31:29 -0400
Received: from mx142.netapp.com ([216.240.21.19]:63418 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752387AbeEOMb1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 08:31:27 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="253910813"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Peter Zijlstra <peterz@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515111159.GA31599@bombadil.infradead.org>
 <6999e635-e804-99d0-12fc-c13ff3e9ca58@netapp.com>
 <20180515120939.GA12217@hirez.programming.kicks-ass.net>
CC: Matthew Wilcox <willy@infradead.org>,
        Jeff Moyer <jmoyer@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Rik van Riel <riel@redhat.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Amit Golander <Amit.Golander@netapp.com>
From: Boaz Harrosh <boazh@netapp.com>
Message-ID: <de0384c7-23a0-fb92-3672-d89b364c5597@netapp.com>
Date: Tue, 15 May 2018 15:31:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515120939.GA12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5P189CA0026.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::39) To CY4PR06MB3080.namprd06.prod.outlook.com
 (2603:10b6:910:58::34)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:CY4PR06MB3080;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;3:m6rfx8t22FqDvQBMXy9Ph25hVJ1jZlcMuF6O3LqE24kUAybKR9saTw81uZbuQI/iSwVLHhfjieyCE6jE1zpAcVb5AMfdLRl/xEf2jg41i0zhUD8D24yuvgE4dpOFjZCvjZJiKOqnLy9tbrIKrt1Szdf+Gz71ejbdBV5/nOt5020LWk1tPdRgsuv10W9ohUuIHLL2gIR2M9OM+IgLGpoLBHD50gXx9fZ7yxL2m6zUwB+DUeg0Xk1KxEUax5u4H86i;25:FZuDUNHV31Sog7+xDUXl/cSWUyahnkwrqzb55doLePOpQ8QxrjEPnF7EToZMC+ydFfRqPOhGMpsnwBFVynsKGz56YhBctfUumTfX5dSr5iQpxOi4dl//CXHdJpbMwpXpvKYZYQ8+HfQk3uzmtJs2DMwpnLHAG/NG2KutFv6JYA1Qr6IKAGfzOINDbneYQn2mfjxaWLb5NU+jsEtWy4MPgSFuE/ifzPYl7xgC6G4NeyZxHBs3Rsqmr89vprJZ3M3qvziA+oVvd8asF6hle7ELP1d6no1GPgrTQi0ba4xoetz2XYY5alUvzUZ+1ZmnH6rlEoJdqtUpdA1SpDpkPalMbg==;31:iDbIxxeX8rJUPmz66Xvw3T6Wv+wtATuTDxk8aAu0LCoJvG/EZZzBt5PQpO5/rJSjEP+nkXocVSIlGImPWVEe/9Ilh8Zkm3fl+BzLqo0aCC3Kmn0HNYDt6ORJpoaBG/NJBFZb+mGicVHQFqt/6QA8JHvZlaOXjQtNtFMy+ELHKvmJlnzAwDmrE0VUfR1cOaa7YfP8eZ205wNM1Sjmd4YfvutEb5rDew8ViYPDKbxtVSA=
X-MS-TrafficTypeDiagnostic: CY4PR06MB3080:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;20:dG2bG6GeF7TBeVmvZKNaF2X/1VVea78n27grPvQcuHkDvB/BTyRfYuiZtR9B5tmKMqTACuWBIyAUYawo4V+qvUEsvdVpHngU+lKvub49zcLlzeUB4pYzUKU8pvQ+P4fEWERKBlijQu4KQRO37bzqxO7ipPNqgCU9Hj7ujuat4J/YVJPxk7RSZKqDBOsjt/uFjKCDhmpywsZGhOsmqfn7z0C6ijAptxknCnI6kjx6f3bvnPpymFWErM8RmllAvTe0QQslBqZ1gazjeUoF0YTvy0eZOWFMlR/brscLF8cu04NDkCotRn1ljSex8bvY3lhx/PYwRaEG6BKPYIB1Dj/izTsQzhNfnWp3674KaCIMwYYKuXTArSiglI3FqIV8ZowepanMvSB17UC8UERZK7thzne8h54hPyrIOKUlQaWZH5ltfdyCrHuUXuya0tq9NmMJhuMfgwU1IWf+2M+N0GC3cJjLe32PGN8TEHbEMZP4yET/1uxV7GDNSeUuhiE9IVuc;4:yEgJD+S4Laaaqm2CLnuiByE1fohznn/8H0njEVEq0QvkwD6FH6+lPS380Z86GkR/7wdXE093q0KhqSE+CYi8YUjjswLYxZ5EO3Cmg1rvNfhz2FcCn1EZ/jnnWM1xwx7Mxwrgc82wErf8pDEwYuFvS1nVFHFPJsqOtZBiDZzg7FOEM44ZJUlhbn00vc9+2XAD1SWFMzqM9s5FODwOP2swA2nP6L5OCkTRp89pMhIbCSryDOF00l2CgMydIPensxHMi2HoFYBpUeCeGENOje+cehuzxHvUgY5hlVKt3CTioHzmff81VJNwxlZB2u06+lK4
X-Microsoft-Antispam-PRVS: <CY4PR06MB308086CBA26946F66D6E60E6EE930@CY4PR06MB3080.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR06MB3080;BCL:0;PCL:0;RULEID:;SRVR:CY4PR06MB3080;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(39850400004)(366004)(346002)(376002)(189003)(199004)(7416002)(106356001)(105586002)(31686004)(6916009)(65826007)(8666007)(230700001)(5660300001)(446003)(2906002)(81166006)(72206003)(81156014)(47776003)(65806001)(65956001)(478600001)(8676002)(6116002)(6246003)(3846002)(345774005)(50466002)(16576012)(58126008)(64126003)(316002)(54906003)(53936002)(6666003)(4326008)(66066001)(107886003)(68736007)(59450400001)(386003)(53546011)(6486002)(25786009)(76176011)(52146003)(2486003)(229853002)(23676004)(52116002)(93886005)(26005)(16526019)(77096007)(36756003)(97736004)(476003)(31696002)(305945005)(7736002)(8936002)(486006)(2616005)(956004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR06MB3080;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjA2TUIzMDgwOzIzOlhEdEExYjhVdVZsQVZaOVRkUWNiRkY2cVpZ?=
 =?utf-8?B?SGMvK25OUmZ1NEVtcURneHV1VUZ0alUwMlhROHhOaFZ5Q2MyOTZORW9iaXpt?=
 =?utf-8?B?NytGWUF3WEp5SzhrTjNtdVJrRDZ0U29udFlsd0ZVNFIxeGtiUmE5TjNTckhx?=
 =?utf-8?B?ajZhTytjcmtKVzRTZXZpZHFhUTUxYmpkOVNnZzdZWGF4YnNtMnJRdlJCYkJn?=
 =?utf-8?B?cTAwUUxONEFQUWFKNGdKRUVOMkZCR29VOXBSaGdPbTJQYVkvSjk1ZnRHOXZq?=
 =?utf-8?B?MSt3dElFbFViMEVZWXovaVFmUkxaUit4eVBGdTdmM1dyRm5maE51VUJkVm9Z?=
 =?utf-8?B?RThGWWNDUGhONFprcVhZSGYyK3YvWjZhNkp5VUJNY3NwVnBCaWlVQkNDVUNW?=
 =?utf-8?B?ZThQNllpTFZGUDFUazZXUkNpSXkydHFQaDRSOGFaZTV4OTZDVXl3WTIzckJV?=
 =?utf-8?B?VmRtdXZQMERLYW5XYUdGRWVEbjZBc1M5a0NkaXl5ODQyWVo2eGlRNWpRSUJj?=
 =?utf-8?B?MHAvTTQ0bUJobktjczJ4QmZPUjdTZVBhOW8zUVdYWnFvRWltejBOYk16NHlH?=
 =?utf-8?B?S2sxWG9JMW0zWDRBbnVid2VYWVhzeElqcTV6L2toUVgyUGE5NHU1M3RzMnda?=
 =?utf-8?B?Vy81STVWdHdyWFhlSXlKemRkRS9RMGRoWWRRU01KcncrK0REK1ZTWXVnTGQy?=
 =?utf-8?B?R3Fnd20zNVcyTERrY2tBR2gzdEhGZlBWdVdIVDY5ckljdUN5dDR4Yk9nelJD?=
 =?utf-8?B?WEFaWC9MbCtJQzQ0YXdtZ1BVY0trUnJIVnBKeEVLNFgwSHNObkNUZVh5YlZ5?=
 =?utf-8?B?ZXZCcW41K3FaSTFvZnBPYkQ5dnNLR2N6MTVOVzBQa0RoK3d1bFcweWdZcU03?=
 =?utf-8?B?OU1aMG0wam5aOFVEMFlNOWJZLzJoSTdxOWRydklhN2RkNWFzT1FIcVByTU84?=
 =?utf-8?B?Wkc0MEk4citkOGlzYWd3Sk9obk5HRW11UzhpRlc1cUNmeHFtbWhkdnNFVjBy?=
 =?utf-8?B?cHoyM21KY3NCNXNDMWtUYzlrSE9ZalBod25RbnUyWjFPZ2gwQ2pCU29SWFE3?=
 =?utf-8?B?MDEreFFPVWdzNEsrbW5kYklrUTBmM3gyZHhuckF1cjU5UW1wNVpxNHpvd2RM?=
 =?utf-8?B?NkM2SlZSNXFZSjE0Vi9uK0lRZU45UW9sZk5pM3U1ak44MXlvZ3NwcytxMm1H?=
 =?utf-8?B?QlN6QXliQWlNMTdZL1ZaemgrQVBEeXc0RkdiTUVQb0ZHU1JESDFZb2h5QzFt?=
 =?utf-8?B?c3pPVHRDYWt6TlE3alJISjJmZ3M0MTNkb25SVG1SSjhTamcyS3VDN0hqMDRS?=
 =?utf-8?B?VC9vcFhKcDFrL2tldW40UkRqamRpQS9HLzUxdURlMnFpV2pvekVvaVpjTm9t?=
 =?utf-8?B?d2xPSzFGY0Y2d1d5ck8waWMxdXc2L1FQWUxramhwK1VGR1JOZ1U3OFlldlR3?=
 =?utf-8?B?WTNmSndSUXI2UnlkQ2xOalRPSjJTS0JzTlZrNWJwT21jT0NXVzJRR1RuR3Vk?=
 =?utf-8?B?M1pndkZVdzZITk9Db2hTQlk2QmZid05jUm13YnZvcXc5TS9SZzNDT0xISkND?=
 =?utf-8?B?WUtpcStLdVBIV0s0M3ArSTJUTUVqaWt3bU5wdWVud2k4TEo2Q1pycVl4ZXpC?=
 =?utf-8?B?emEvWFNaNDZJZ0tvK1F1dUg1bm54Y20wY1JuQmlaMDd0RUxGMllvcnd6azVU?=
 =?utf-8?B?c2JaWTdZY3h5UFpscG1jYjU3dFZha0k1TXEzWkFFOXJUa2kybHF3Y092WjI0?=
 =?utf-8?B?anZhWEJmZzd1aUFtcTBKcGpuclR6VGVMMDI3Zy95ZDJmKzVUQUxlS1FDa1JQ?=
 =?utf-8?B?bzM1L0FQSGdHRlZwQnFKcTc5amovdjBvNTBFU0dhOGFEbmpYZmNVV0NyMTBk?=
 =?utf-8?B?b1BoemM3c1RXSkw5TmtMYzh1U0doalZ2M2FFdzVramNxbmpPUFFuUnl4RGcy?=
 =?utf-8?B?M3U2SG80a1BxdHNTZVdaVTh6RjErUXZJRGJiN0JGOHEwbjE1NXVkQSt6WlVo?=
 =?utf-8?B?WEo3WU1PR29kV2NuS3FudzZDd2RkWjRnZjlvd0tyQ3l1TlV6OE9oK2JTMy9y?=
 =?utf-8?B?SnpvWGhNNnZmcjVFM0UxZTJHZ24xZE1RVTF4MjQ2U01sNFN6M1lncVQrckx6?=
 =?utf-8?B?Y3c9PQ==?=
X-Microsoft-Antispam-Message-Info: 1ad3IA4o5VkKnlwhT2lCT7T6WmYjJmDRrkr+WgRM7lW3NUA/P4rT95V6x9EUZvIMyFxlWn7HjpHEbPQYzY3CUjzZeEXXPQ7V7zHrCoqzNNGUd3DKYogBdzn1FTkK1DyQjeFQmWf+B69HvYqTeGAJO5nu3AXuKsVhcbwWfPesMXPmKgJXJeqnqE0+CbiZ0T/Q
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;6:Jijb0mPzcz2B06ts+bDwB0IvEysHC8kEQmz0b//xtLXS1g3B0ILJUfms9tmBGFqoEhUuEVUh8XuJdGloONLqC68BIUnwy43RdCyemjhIwtJdrrwH/I2GNUg9WxXMbjly0drcS/tEX8eRTVjgXRWfCBUIEiREeFdXss+a883nEGoep9I9xXrLRfuaoj8p19te3W/4k+Wt9Y5aHdDiHfnof0Ck1mjWHxhdnUpniKcKQT0Ql4jOKBT5XxFY9FFV96dErYlAEEVA0w7eLTDQnUjm9dFl4jzN2o1Ep6ucTSZr/heZn0Cr5udoXCbb5kYkfesN/QucaWUDkPG/5EFNOKaVil9tvNlOMV1HQlmhCfdlo0iVsHrddBFlwjB1humwbPCiK/n10cZDfnDlIl+KtFQ9Qeuyhr8vQJfuFHEOGFFklsPF4bGdZTu3P3aBYG37ML62Cw+fj/ymPNkzd1RM2klANg==;5:kx7rYeEv7dwgojHzPdc1FRndmQCjdpeNpQsmZfs7ObV+Boq/t7G3sPjpsiG8JLPVYWezgNgEyBiFT8Pzr0VGTn57MjT6DoVakqmzdlZ8Qd3AQtr5Zzsxa+D0HtRZwBAVOxwH0VqQCm1thXgx8cPEwM4ln23dE7KiFKLBXE51jYE=;24:N4Bc9XdcO6/c+ohGUovOJvjtw+qNo/9afgtFqs0B8OcPHwOyJl1CDDbH+tWYJedudXQOpI78gRBEvqGIkTe2V1qwYn/LF34IqERMbTyyRdg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR06MB3080;7:yHsIv9p64MS5KjClGpnTH+7pK379E08rJwUoLPB5FzGlVDGAxlgHLUHm4V3ofNAvximTaqKE5TemH90WgTPAKuqQ7ARQWI7yqZOLPJs6PJzKmIOuJVp2Bif3G8lzo8q8iIxI9cURAwiP5vlfuv5MYGgcmS2wRhDYbCG1SwuEZuXqVzQ4e0vwNQeAsppnXtd+3JEaYPXDb0w5jYjWFadEmFZxpHVns6XVxGKC+eXmR/Bbl0REI/zFUdH9/2y+Crma
X-MS-Office365-Filtering-Correlation-Id: 0c0e0c93-f215-4cee-d781-08d5ba5fc55d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 12:31:19.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c0e0c93-f215-4cee-d781-08d5ba5fc55d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR06MB3080
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 15:09, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 02:41:41PM +0300, Boaz Harrosh wrote:
>> On 15/05/18 14:11, Matthew Wilcox wrote:
> 
>>> You're still thinking about this from the wrong perspective.  If you
>>> were writing a program to attack this facility, how would you do it?
>>> It's not exactly hard to leak one pointer's worth of information.
>>>
>>
>> That would be very hard. Because that program would:
>> - need to be root
>> - need to start and pretend it is zus Server with the all mount
>>   thread thing, register new filesystem, grab some pmem devices.
>> - Mount the said filesystem on said pmem. Create core-pinned ZT threads
>>   for all CPUs, start accepting IO.
>> - And only then it can start leaking the pointer and do bad things.
>>   The bad things it can do to the application, not to the Kernel.
> 
> No I think you can do bad things to the kernel at that point. Consider
> it populating the TLBs on the 'wrong' CPU by 'inadvertenly' touching
> 'random' memory.
> 
> Then cause an invalidation and get the page re-used for kernel bits.
> 
> Then access that page through the 'stale' TLB entry we still have on the
> 'wrong' CPU and corrupt kernel data.
> 

Yes a BAD filesystem Server can do bad things I agree. But a filesystem can
do very bad things in any case. through the front door, No? and we trust
it with our data. So there is some trust we already put in a filesystem i think.

I will try to look at this deeper, see if I can actually enforce this policy.
Do you have any ideas? can I force page_faults on the other cores?

Thank you for looking
Boaz
