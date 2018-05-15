Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2568158-1526386270-2-10410175297743674124
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526386269; b=UlrcR/fwU10JYbO5a3XmJFHMK/qVcrG/N8GmsPiuKVh4uITQHU
    XXPy05aSpWH6t7hjTqNDvWkI/FerkIFrwzthi7szeU4S44wmvwHlxrrsFPpyY7c6
    8q+vFeogHIaj+UJikMPpE3YFL+MAnek1fowdxL6/e5u/0jquGTBVaDJ28R0x90e2
    yGq3GbDicALzniKPSUQ9pBmtgbOWX/fZj6TGeGMo6SzVx7CgBuheOrY6SonbkU9S
    xKgy8EBtbCRczpzAGgUBjZ4CGSoKVpBP1OH50r0JmMqpapxiF5OpiZyOrM6iUHxR
    rN9cYPL+M5KnlwebXPrTpwSaTpAvPk5WZDKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526386269;
    bh=4bggHLmLZn3zV3fCzfXvS/4XZkN/mMlTvTZ1cSJzmBM=; b=bdBKuDCSzaaM
    syu3PwVMxh115TNc7hrjva5tGpApyeWARDbPQ2FrxOd9e1Fhmoz7whcXsQvxgfiq
    72qYSBgsTFm9NN/n4SXTpE7Mfp6km5kNUemQIJa9z+0FWHMQ4P4ntCjpVgKHzcaQ
    YVeNnbRWKwlGBu7s2dlMKlQmWoJh1EqZVEFl1vxN5VS+1U7y5zJ4qreYxXKoxjZ/
    JkInyonnuir7BMpwt6oL0+bIn9USfL4Gr0N1kmHGwj2kIF/kmqwBfMkduQ7miJ6c
    +GshxK4YnK22Ep92GWEJcEpV3FUlii5rXlxupvjVFuviq71fprQg0m/aMJdfBNNW
    sPLwccmmtQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=ciD3uUQT x-bits=1024
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
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
      header.i=@netapp.onmicrosoft.com header.b=ciD3uUQT x-bits=1024
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
X-CM-Envelope: MS4wfPwWVby/Nq9Q1uv5qBeDY4IB2ThnVG04VnJilG/lYgUUrpH/i2KbOdGwirtUCHN/eU1UKPzFxQ6zVZEsQVl5KsUeSwUI/Za1HMszmWYcM4i68cdNClwB
    Am771ZBGR2Gu//qcnyMXo/CCq2JGK/x0xZPQ+BNk0fY0Oz1U0cFCNCWraR1/MgwaYuPcvViU9KDKGwP5TkTpe0oRHwdpOiMSk2p/A6ON5NIU/xyI7dK/a5cL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=rxRqjSNLgHgOlKFObWcA:9
    a=303NW6AYAqkE45o9:21 a=SWUzC-LWajAjmQhM:21 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752550AbeEOMLF (ORCPT <rfc822;linux@kroah.com>);
        Tue, 15 May 2018 08:11:05 -0400
Received: from mx144.netapp.com ([216.240.21.25]:23339 "EHLO mx144.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752490AbeEOMLE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 May 2018 08:11:04 -0400
X-IronPort-AV: E=Sophos;i="5.49,403,1520924400";
   d="scan'208";a="257415290"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Peter Zijlstra <peterz@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
 <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
 <20180515004137.GA5168@bombadil.infradead.org>
 <f3a66d8b-b9dc-b110-08aa-a63f0c309fb2@netapp.com>
 <20180515114755.GY12217@hirez.programming.kicks-ass.net>
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
Message-ID: <030fb555-017c-298a-823c-3b9dfd346461@netapp.com>
Date: Tue, 15 May 2018 15:01:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180515114755.GY12217@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR04CA0030.eurprd04.prod.outlook.com
 (2603:10a6:206:1::43) To DM5PR06MB3084.namprd06.prod.outlook.com
 (2603:10b6:4:3f::33)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3084;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;3:eFyuiBB7nbmliksFV/yinXcEDXw46TJu4mdqBTnMTfgkbcyGUxCQAfXYg3coe/KvkaxlBkN6AAVFj6aMK/wYYJ9BfE1O5OR/nQodER6n2mRhTimJvl0ZaZJC6kN35xQDt69xryZ36lFfc1VsGXmf/0NO4kuqFISB8b8T3y2NHgerVwrDzHAQptoYDUzgbjx+SwzRe/UsM0qwKrz7U3to/J8mOnrZ1/Rdozt+dbD0rk6IcKZSYowHKoNmQsr4zDnx;25:16Ex/oPKF+41YklMjFy6sPHJ1jCCLUw8MWDp0MkwsnIEtKnO8aniv646g7uiFVaFqmvE+YC1Z+GS8mw55Jk9/CzzWr62Sz10tvFov1uamprATzkRiBC2UGOrguCtUIGsWncN6RdNxvuTa18VHhUhzIfFctufYEgDDc7Os5WyBmzjhebfYhfVFntQ+ilOunJVwgnGAiwbt9RucOa2B/syzReOHKbyz9Ycjb6Gu8s1grvZZsCmEQG4/JVFjbe4NgSfRMAQPgUsMb3XQ+N1cxHrGmiBFtOhXKOE2yv15YrxjU4ONbOkn0/VA7R3TDmijYIeICZBLB8vx9NfFWspsaW7Zg==;31:6fqeIxbfnUN7gSrAMxBKGn353nZQTIbXVpEIQNwZaAHBIjxhWm0fAQyBd/poG5WZmiDzeZPOfMX7lc/KLQcwqVz1tU4OHo6J4WlGbAsgO/Z6nHfIKmUH2e60w5crpzX9q6Zj92z/9d5gC8HSXar5A9VpFqvR8PgTP2YnCWdi/OSYioCsugSuXud4GzN1mO3NbazBr88DWPMZ0MiqACvMMwYYPMDm/yfeoMhK+BWoKNo=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3084:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;20:267lXmijVIhXWm4ew/Km5dBWnMWrGDjmqlev7mJJHdfOKTzNJv8DnukGc1Svjc85IeWxLKELkL4dcSVt9eMOEwQCimwMHOvEPbRCTRQdf4ebsQKRF2q57Mqz/lmc8cnQ4HkX+F3cHf89QUkA0zoFYpl8LGLiTlCx+Mh+WJcPpdddJaWMwdhGVeNxAD1mN1cBpk/NdVXO2XZbpF2ZrAF1CLKas5dF/Owj6V6cIHguOTixYU23ImjB+1OZYtROphgCFQ+ZQUiu6DxSLoAt26eAHpE8UtH3GsJeggs2Zyh3ztS2YJ3fk9X8Iq7Ul6SUuvA0RpE2+gaQUWG+UgcMcciaVK6aJ2whzI7bXJo7TE00mBafHuILgnM1e0w0JtO8cKNelSuM69PKsS5ccKw5appPOOSGocuQ6gnH2el1/UQj4tWr23t5XkrzwsK8Z5+uFPMmK7nWAX5JMlV9VITcQiWHG6SvJoEKalaV/rE4HUS0ZqvbQBgkLgEljkhox7vACToh;4:Uw5jT25rqS4kymzYaP0wlWYaeJxl9Cucnqom0FlTqDAB+Ud8J0oFJYf2N9t4cJDJ1iAQaGiKOtO1ZLsS+vOKiU5uyxj78wdEazgR0/sDVFOL7wJYhhqokabrLV9DRCGog3F6rjAFPQzdAstJM2MaFXizQSK2eCVhsmOfIZsSGLowuXeYuwx0GcvfWuNdwYXePl+LUtPdsA3MWLJWJZxVxPKPEc6GmtiwSRCcWC7GXKTB7y+0qzXuVN/OkXw8QEQxpehNI0RB2NPQ46mJc35RjA==
X-Microsoft-Antispam-PRVS: <DM5PR06MB3084DE82BB6D9B5CBC6B2522EE930@DM5PR06MB3084.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR06MB3084;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3084;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(39380400002)(346002)(396003)(376002)(54534003)(199004)(189003)(11346002)(2616005)(476003)(956004)(6486002)(305945005)(47776003)(446003)(229853002)(7736002)(4326008)(105586002)(8936002)(106356001)(81166006)(81156014)(31696002)(8676002)(64126003)(25786009)(50466002)(93886005)(68736007)(2906002)(72206003)(16576012)(6916009)(345774005)(230700001)(8666007)(6666003)(31686004)(107886003)(478600001)(54906003)(65826007)(36756003)(6246003)(5660300001)(316002)(58126008)(53936002)(7416002)(6116002)(3846002)(65806001)(65956001)(486006)(66066001)(53546011)(386003)(59450400001)(26005)(16526019)(77096007)(97736004)(76176011)(52116002)(52146003)(2486003)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3084;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDg0OzIzOmxCQnNXbzFPZm8yZ0ovV3hZMkI2eU9oQ2M0?=
 =?utf-8?B?NFdYOWdpaVh3M1IzRVRybnc4Wk13YUpXaUFEcDRtNjBCV0RNMTNMZ1JPcG41?=
 =?utf-8?B?ajVWOXRRUmxlL3k3NjJ6YlRlMzZJQkJJaG5QTkUwRkJkYmJJOW55YThDTG4w?=
 =?utf-8?B?V1pMRUxsUGJJTDJrYnlLcmlBSGU0bElBYzl6Q0tWQ1Y3NU9oU2UwbUNhalZt?=
 =?utf-8?B?VzVIcWlrR3hBbXgwTkpac0ZFVUlRNWtnZytSamNYeGFnNjVYSEQ1djRGeFoz?=
 =?utf-8?B?cG4yUmVZcjQ4ZGxpOC9GY3N0ODZEajEzU0tZWnNySFdKNVN1MDFaRWtQTkdR?=
 =?utf-8?B?VkI0blBTWUY5bEF6eEJvREp4MEVBMms0VHNaQ3B2K05rbnVhU3cwZU05cnVS?=
 =?utf-8?B?ODVLa2N0RnV4Z2kyNThOdVYxK0NtT0t0MEJYS3VQQ0pRWHQzSnRpOHJJRU1U?=
 =?utf-8?B?RFBMLzlEZUdqK0p6Yk1GdTY4LzJvemRRcEJJR092QldFTHA4RUU4M21wUWNO?=
 =?utf-8?B?VktLbWFVZy9vV2FDS01Vb05uQktKckVReDFFYzhCeFJFUFlWN3hudFpvUURw?=
 =?utf-8?B?NDBlN2RQZ2JxSHFuTU5EUk96ZVZyUDQ3MkhEcmk0emp0TXdQeHF1WlcvYmMx?=
 =?utf-8?B?b1c0UDRiZzBVOWppc0NzbTBoaXlWdnNrUllNV085eEFKcjY5eC9sL0hHb2tt?=
 =?utf-8?B?Uit2d3ZZa2JJV3E2UkdEclIzMjlsWGQ5eHkzTmxabTl4SExqS3QxdEJyb3Rh?=
 =?utf-8?B?OHJLVlcyUlRZbGhtQ1I3NFBjNmZIOGpBRUxDbUNIZUJ5VmJ5OGxFVEtoV3Rl?=
 =?utf-8?B?UG9jekZ2SUx0WjNFWk1RcGs0YzU2eVpuV1BQOUhwUjZYbXA2UkM4Z0hiYzkx?=
 =?utf-8?B?NVZpMDhwU2JkVTA4MjdmTkt5WGVMcnFUZExQbVFkMURpS21ESHZOQW9JV1Rs?=
 =?utf-8?B?WWRCOGtoMUtlUE1WQWhENm1uQUo4R0xsRUtVeUJ4M2tFdE1FY25Ic1EzdzVx?=
 =?utf-8?B?akpINzVVaEhnZnoybDZvRVJsVy9TNHBrYytNMWs5ZHlsUUdmdzRQU2ZNRFFh?=
 =?utf-8?B?TFEyb1NDS0JsR0JybTl2MU1lUlo3SmJLNXNrcWppbVJwbzVSVFFxQm1SbU02?=
 =?utf-8?B?ZEViSTZhV3gxeWdjOGk4K21qZlMrZEZXLy9mYytTTXlhd3BsNXUxZ2Qzbk9u?=
 =?utf-8?B?ak5DNEllSlhEODFXcitvMnJDc3g3KzFENU9Dd2VBS1d1VHg4bGRCeFprUzBt?=
 =?utf-8?B?VnJPOHR0UkhZM2dTYWpBN1B5K3BYUkFvV2FaaGU1Wi85aWZXWjBVRjJrcUU2?=
 =?utf-8?B?L3hoWXQ2UnBvcytCMjJNZVJkN1VmYTlrNTVWSGY3c25hb2UxMG14Vjd3Yk8z?=
 =?utf-8?B?TlUzZkcwOElVRTNhMng4ci9EWUZhczYxd2x3ck1BdGtQazNPQWd5SURrRlhM?=
 =?utf-8?B?ZFkvSEpKYVNSTXJieHc1N2lESnZvcDZHb2dscWk4VEZRTGNtd2kySHV0Y2h2?=
 =?utf-8?B?RG5pYXg1R0p6WlpESnpIWmNMb0w3TzBLNWZnc09SNm91Yk51ZWRTUzQzenhR?=
 =?utf-8?B?OXJXallualRNaXN0Nlg2VGp1ZERaVUlBRy9JN0xMYlpqQ3FkcUI1Y240SE5D?=
 =?utf-8?B?UEtFZ0xDZUFyMng3VW1BWDdCVGgwb3hxbjh5TE9iVThERkNFaEJWdnBrR2xQ?=
 =?utf-8?B?ZFF0aDRRM3M4OHMvc1RDbjB3Nk9lN2FEMXF5cjFGMkNSdHJ2MTc4QjUyMWRW?=
 =?utf-8?B?ajYxQjd5b1VYSXd5cVkvODBlM2VQTDRRMER5TVZEK01XNXhIQUNjR0tkQjU2?=
 =?utf-8?B?TGNhVnE4SEI3cTFpK0JMVkNBcExwUEw0OEZUQjBJaWtkRnB1Z3J1U1RMNzJF?=
 =?utf-8?B?ZlJhbTlRU3dvUk9YbmI2alZOTUdwV1NoaVdMc1Nsc1dsUzhtZTNWdUVUcE42?=
 =?utf-8?B?MXFPMUc0bkR4NTN1VWVuV3JScWlubCs2Ykt0alltTkc3T05VMjdMbFZPOHhU?=
 =?utf-8?B?Y2pHdTE5bzlGcWFvU1dubGpRUHo3SS9VdTZkRlVTTFNETU56dTNsajNobzR2?=
 =?utf-8?B?Yk8yL3Z3cXBIR25mSDRHRVNSNUF3R0dLeFFWQmxZMktpWjB5VU1WeG8wWHVV?=
 =?utf-8?Q?zf3noIeV5IyRtGl6ZguZClE=3D?=
X-Microsoft-Antispam-Message-Info: QEKZlf3e8H0vXzJ4nQXNti1kF4dwRLGfX7ajBh0gR+GWwOO7MCwEQMJUrXLxiO9QZ1L006xU8x569NFc97yep4ttfsxEdbaiL3bPDyTw92bD3qEsjbhEhdPl72+76PPwkln/3xUCrmRRY8tzUH5GvAbY4u96F+XsZPCvq8yOj7FYrHE0HDvH5sYmLr8mZsUj
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;6:z20S+EExJ00zFabruk3eOUqnXdzi3Y30nOv6ByetsOhyqF8ynUZr8kpyozaPZD6NaoiUaQAna1TUTN7Uwud3G9Uzjen+IaoOhrgiMdkQoCO8ymeARpUPe37T+kYv/UyHS6dHuhhx63IwCo07pgEGGHFN8eN+sb4S7PgcH/vOLKIFB2TW9B7Ip85bYuYO29KgahSb9t1+vtPOE7a3xeutx8T/KhOT487zzm6YgSLQyJXAN4tg01LDOTL9AXwn8/CAwfsmAlvI1oQZyIbsfTBuh6pze0KzArnQnlLIuxvbwXKCtil+FcbujnXZKN6TtVtBaElqSwKbCSZVdEYZaHrI+b76yd8C32FV2FbdV+vUBnPgkI2tiwRWrryM8VsHrp9XkKTJFSb3IK/Yv3sH/su/cR7jUDPAGRBdmt2tW/dM0grNsCIQOgrl6wj0YFOOsYaz7icm/LBCXZuBoyw+V1frMA==;5:M0GQQn8DCAaYN4RiBZs+G12MY+P5AA2GUEcTQatPewXtT/9qjBzjKFHzgqUj0eO0G74DJhM63wXIQEIImE7hzVYLmYJD16Kwc7MiftgOnFeU7lBmuPhPpdTcAk1p2OHD95HpuI3N44jR77HZ9wUVJ5M+1/d49pZzwVF4udHB/lA=;24:KggJfqqGhj8RdnY7FvXgcPKYnu3uZtmMCqyL5xvo5OXk4qFWRN+D3R7+L/vJ5op/k7ntDutc+LTAoqmKP8JWy6AajhhMdJOkUrH415BkG7Q=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3084;7:x/CHo+JiW5IEfgx4Vd+GvmpDQRGGZB4e76k9+rvI5ASdkkTS/SgHRl7Yjr8mg/G2wrTAGCI2UNLh+023ZYeZXJC/j1TA4Eg8GYe7GrRgGCVhM7tAY8hC2B0z/xXgv1tlrDnEJoj0r9bpIE3OaeBMoB6LsvzWALxKv9Sz8P5fEIqxOWkBW7Rvg/OUsMk9E9imYwiNRamTK4jPIlvKtrBL45Ekz/avFZXcPcnv9neU+lhVKlGGxCi0vS7wPXEIu3VY
X-MS-Office365-Filtering-Correlation-Id: 96a00f54-9028-4522-b0d5-08d5ba5b9323
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 12:01:17.7266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96a00f54-9028-4522-b0d5-08d5ba5b9323
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3084
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 15/05/18 14:47, Peter Zijlstra wrote:
> On Tue, May 15, 2018 at 01:43:23PM +0300, Boaz Harrosh wrote:
>> Yes I know, but that is exactly the point of this flag. I know that this
>> address is only ever accessed from a single core. Because it is an mmap (vma)
>> of an O_TMPFILE-exclusive file created in a core-pinned thread and I allow
>> only that thread any kind of access to this vma. Both the filehandle and the
>> mmaped pointer are kept on the thread stack and have no access from outside.
>>
>> So the all point of this flag is the kernel driver telling mm that this
>> address is enforced to only be accessed from one core-pinned thread.
> 
> What happens when the userspace part -- there is one, right, how else do
> you get an mm to stick a vma in -- simply does a full address range
> probe scan?
> 
> Something like this really needs a far more detailed Changelog that
> explains how its to be used and how it is impossible to abuse. Esp. that
> latter is _very_ important.
> 

Thank you yes. I will try and capture all this thread in the commit message
and as Christoph demanded supply a user code to demonstrate usage.

Thank you for looking
Boaz
