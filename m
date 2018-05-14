Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1331481-1526326703-2-16264014596420742430
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526326703; b=fjlZof/atccawW2lUrhz8lFSm6agX6uky28LrF14X+9rLcszn4
    ExH3ErExshWvLCBVxrS98Td1JBxs6QgD/NPnXX5bZA9rmtw5ouBBy9X5ksloXriv
    moN1eVaDLRORgxTb2DMxRYrV03sMvmG9wlLhPnLkPsP4pqJlxsbVnkjO2CYQvd7q
    TEBfwKHj0kJqV4vRJs9cog7wrmYqBCoyybs947OvOqa4QvLupT7b7RZgS68/HkZF
    kPqHeuvsioA6cV8Cs8MK80a/CbEDhyWnvn5McHyEDZW81zfdhklijaLvD2ybDd2p
    HHxLVPx/OzBQtljgLUGnBCZn6WSWrLKDqyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526326703;
    bh=3wul99peFZpk96QbnIxh9zaUD2jZsKKpg8jNEBFRWzY=; b=HbpDTd2O7m91
    xzzzuSsUJWPNTLpNdwhwERrf6T/71D4F7HcbM25cKalfG9Ndyev4x7t65KMToOch
    Ozyn/pnXrmPgxQfciS3xO/wGSMrfelufFEiKQS4Bfp4Q0xfZn69fDSymzIEdbTlb
    cSQTxIngz948SXW2XMF7d4/+5SHXDHzNxxHhYBLSOwtsWsBzXtIeAcsqr5QkuzgC
    vt1vgImWUKfE3cJTDGa3wtavK2HpfTvmoVzVRjByVV8NLY35Xkgx83oxkeJwnlNC
    3WYyEnx5rIF7YQ+GpDPjBX9bYv62ex02CNF4G1Whwii6ISOs4dEpWX1lM8LfrGm2
    qXq7CVyKew==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=netapp.onmicrosoft.com
    header.i=@netapp.onmicrosoft.com header.b=TrWBT7jw x-bits=1024
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
      header.i=@netapp.onmicrosoft.com header.b=TrWBT7jw x-bits=1024
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
X-CM-Envelope: MS4wfJSkP9GR3oItDHXOEHUKxOBt3/hqm6slXrBitXE//47S5YM+lrDrXYLmuTPX2psHFgfYaoT7rOB9CyDLGbMCduYFBPYN06lWBEsuiKz5gpmYx3swW6/U
    2s1uNIcuOMnQYWnqXlqxi8Q15nR5wxPdmxoAYTv7AgKHurNJfHt2dHmwu1YqT20plXIvwiDxyx9Y1FBJY8JaAw2XdFfj/ZSez+7sMEIqNbw2MYQkZoBGOV1k
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=cp67nm-S5dEA:10 a=Q8c3SPmTbOAA:10 a=ySm8tqyciYgA:10 a=IkcTkHD0fZMA:10
    a=VUJBJC2UJ8kA:10 a=4MorK5LvdOQA:10 a=ZK4cKV34jHUrOgIYmhoA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752122AbeENTiS (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 15:38:18 -0400
Received: from mx142.netapp.com ([216.240.21.19]:30677 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeENTiN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 May 2018 15:38:13 -0400
X-IronPort-AV: E=Sophos;i="5.49,401,1520924400";
   d="scan'208";a="253741504"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Boaz.Harrosh@netapp.com;
Subject: Re: [PATCH] mm: Add new vma flag VM_LOCAL_CPU
To: Matthew Wilcox <willy@infradead.org>
References: <0efb5547-9250-6b6c-fe8e-cf4f44aaa5eb@netapp.com>
 <20180514191551.GA27939@bombadil.infradead.org>
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
Message-ID: <7ec6fa37-8529-183d-d467-df3642bcbfd2@netapp.com>
Date: Mon, 14 May 2018 22:37:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20180514191551.GA27939@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [207.232.55.62]
X-ClientProxiedBy: AM5PR0202CA0001.eurprd02.prod.outlook.com
 (2603:10a6:203:69::11) To DM5PR06MB3081.namprd06.prod.outlook.com
 (2603:10b6:4:3f::30)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7193020);SRVR:DM5PR06MB3081;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;3:9m7wE454h+/n6UE9/+wi2Ksv3pqZ5gi+oWdQbVu88jTks8TAct8iXFZbO8C/tc56NIPRF/tq9ryspRLDRXeqSjj3LHMUMnChkUK99lMBK+eANFcXrhJZQP+kLvPU4DvoLidLR0v156dndwueupyGrnYEPVJW27YaE6++Jsa5C2DNeeoh4Ym7dz8WCmeoGariNdxepxSaP9J1ZpPtVz9laG1Wrj42hnd/38aerGnfyb/IwUVBAB0pdPZTgVgf7cfy;25:AjvDTsTIc+pZmIIS909tmxuPchLwPDsSUXaAQ8hqQqet4LpTXjSKzw7Yom6reM42L+H++8W9BsPRQWy0e/3HgGl0VOaLPkaj52vdTa9EUeZ9FbC921YNFxr9gZqLkO78JLCKKd+2dx5grYN1ULXJOqlrCn3PJ1qyLuklXgo2dJvOPo1ETOgwtRiVoltiwuFRN0xTa8wfZME0rTPL4BHrD2AmSjnJGXl8CU+Bvp9UkBgm5KTqGqOVQjkHD6MfQwYJSS2KvXIPZV5zb2g5ghW3RUk8qNSgMxsngHuYtrDhF8CeK3TL7/KRgdvgoXyRD8eIMKGaQjgANVljm48ptKh7NA==;31:LdORoptzKbtm/e9dLjWh+Sa93DgM4yjjJzs2pHPeLiuhdRbG+n/U3zYrdEBfJ7a+hh5IPGAKdNjffpNChI/EvOc7aDnZSxFVznFIE3bvIFxVDQ28PLOvvH5NN5IyX7p877m9qZ7tkj3s2b4bRzh/1j+Q6z8baB15nMBiYcD1Q2m+d3vdUSOBue3ouWg305woOLvMeTF9qDexDLYB4/2uNGCzjj7k98OWyuwSAAtKImM=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3081:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;20:m9gA0sSTib5CIV85/eMnf6UD4H92zr4LHjMlegDprSjOw8k6wfoP82iOfASskx6fmHI1+TqWoj5oOE63WzaruRKeP4OYmnijzR9/ImoCgMXzt0V7dcZcYOmSbXfNKMvWwVtb7DV9JeAPMHBGTOkjV6YGUejGu1nYoGSiSvuB11xXOORULVDZ39MelckBDsyjyu92aG8olFj6x+XVH+58cX/OQltJ4sB61o2nm05IvQprAzkxC+7UFuQf+oiSqR0p+3sXm/E2/beP6nIF0KhQav+9nzPDtrU80BFRS9EKLi8h172PZLKJXfhkjNeGHZwcO0C+G/PyGiZOfehSCFHjWdyBdSwpyRFE967np33pkawH9S2IyJ1TSb4cmEevFraK+SYjm8+QfvP6azO9pKg8pt2XXFuX0T6JH161ry+mlFD2ZtbmOsei5V1PquymldDWIii7L7GWrR8bWACYj6Y/JFovAlj8vr3iLbdKWR9uBesCaRgQo2nZV2luU2AD7KFD;4:OsYaVWcP/kZSqUNn12Pu/wUlUTfhBQ6XWxqVWm6Qv2aYlt3aXfX/M2Zp91sOp1VYV1Qi7/4QjaaEBj6+AhCHg0zxXv774mx/MolukrQaIMjMBhvWukPwqrIg2yxnl16HCpVmXl/QuLOXWn/FgM0Fx/GGp4z6M8HI3bXT4Gej2RTajYIq7IGB68MQkERSZ4v0byZhUPLXR0AN8HUWcGlvFMexoXpgkcATRf7VW/7PaUEMmPiBwSWSwouGQoImhWSdVysQ19FDSCr+eEPOsWvMLYu/HJiMGr8HEnox/2gtEqKnbPr/HizC0fxj4YM0SQvq
X-Microsoft-Antispam-PRVS: <DM5PR06MB308177B08CBC6ED803B59409EE9C0@DM5PR06MB3081.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(158342451672863);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR06MB3081;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3081;
X-Forefront-PRVS: 067270ECAF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(366004)(39860400002)(396003)(346002)(39380400002)(189003)(199004)(31686004)(486006)(59450400001)(64126003)(72206003)(446003)(31696002)(16526019)(956004)(25786009)(68736007)(6116002)(3846002)(58126008)(81166006)(81156014)(97736004)(16576012)(8676002)(316002)(2906002)(8936002)(76176011)(11346002)(478600001)(53546011)(230700001)(54906003)(386003)(2616005)(476003)(77096007)(26005)(105586002)(106356001)(52116002)(23676004)(52146003)(36756003)(2486003)(50466002)(107886003)(65826007)(66066001)(65956001)(47776003)(4326008)(5660300001)(6246003)(53936002)(6916009)(6666003)(7416002)(229853002)(7736002)(305945005)(65806001)(8666007)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3081;H:[10.0.0.5];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA2TUIzMDgxOzIzOnZWZzA5Q3BUelBxcVNtMm9KRUI2RytBR3Bz?=
 =?utf-8?B?Z0l0ZGlMRnErQWgwdHhWL1dEQzJ2NnRGS0hCa28wZGpkbnJNWlpRelEzY0lO?=
 =?utf-8?B?UitOSlo5WGxCUnFPdHFIbVB2ZFgzVUovRXcxUXRQaGo1L3o5NWxXa2Q2Rysy?=
 =?utf-8?B?VXQrQ0I3T3hObnFxcmoyV3UxWDlLRTZCb0NKcG9JMXVrTVlaMWtzRWlWc21B?=
 =?utf-8?B?cVJEQmdaVG9Nb3k2dkNpVnJqWFp6bXQ1L3FqaXY3UXV2WTA1TmI0eVFvSlVn?=
 =?utf-8?B?MWV2dTU0TmdzMUh6ZEpRczh3d2w4d1ZGTnFaNmZQdEJIalBzZWRWNTRTTnRU?=
 =?utf-8?B?T1JQbHBsU2I3dzczZm1zVXJGQTJ3M1RONXdFMU80REs2M3MzbndqZWJmWFZQ?=
 =?utf-8?B?RDJTL25JNHpwNGNHbzMrLzc3YUluUFVlVEtUNTVVMXgrazZKcUxEVlFsdGpn?=
 =?utf-8?B?WURrOVozUGx6ZytDNWxnQlBXOCtQU3JVRDNISzhudlphZGN0VXI4MGs5aThV?=
 =?utf-8?B?MkFuVk10S3N2N2JLT0I1UkY4S3R3dnNLQ2cwcUdWWVBwaVRhQm1sYUhVU2J5?=
 =?utf-8?B?YVI3Q0JhdURaQ2lybzJIdi95eGhHejJBSkpGYSt0V21XMVB2WFVoTXlmTWJ4?=
 =?utf-8?B?dXl1SDJaRldGYW1Mem1qMHFtaXlBdXBBT3JlTngxL3hGaVFGS2wrdUl1UEY3?=
 =?utf-8?B?aDdUOHdRSm9iWGkyYmZSTmF5c0JiN0dJd2huWXlQeEFNTVlSSDVkSURoNHg5?=
 =?utf-8?B?NzhVWFBnK0xxWWJPbUdyNFpubUhBNmg4VVJxbE01dTFUM1FndlRWaWlSUXVF?=
 =?utf-8?B?Zlh0bUY3SnRjZ1RCcUFob2dDbm16Vmp3SFE3bUgzR3B0WUNhTUptTFJZalNl?=
 =?utf-8?B?REpPNk44SldZZDhxK1lMTjdWUjhHTnVmaTFkQ05ZWmh5bXY3d0JZd1AzUmxS?=
 =?utf-8?B?Sk5uZnU1V1M1aDZCa20yMnNZSTVsTUZaSU9WVlVHdEhtSGgra0k5akEzV0ZX?=
 =?utf-8?B?S3BxM3JvdFo5WlZaYjJqeUsrWXNBV2M3RG1xbU5ZRzhzVUpTY3dldGhQK2xW?=
 =?utf-8?B?ZWdZWWFzcm9ZbzlBL3E5Zk54SE5NRFdGUVNxVjdzR3dQZUhOelRjVmFjOHAz?=
 =?utf-8?B?R3lOZHVlRU5Hb2ZMeWZFK2tCUkZaUWhGdm9DSTRMTEtqZHpUMm9aaTBkY3Fr?=
 =?utf-8?B?ckFuNG1HOEdaNFBVM0VpMytneEQwcHZHeEwzZE8zOHg5aG1DMCtXbVludytM?=
 =?utf-8?B?Y1dHSWluQTY4cllmYXRyeHozSDFkMU5SSlJQZVcrVTZHWUZJVW9lcThvQTFl?=
 =?utf-8?B?RUJjeFJmNm0wOWtBQURDNEY5ZGpCV1ZrUnZmZHIxSXl4Uk5lN2V6VmtHeDB6?=
 =?utf-8?B?NzhRZmZoNjVJaXVpNk1MdnNOcW5jdmFkV01iMjZZSVp4aGN3RGU5TTdObTY5?=
 =?utf-8?B?b1N4V2lTVno1UHZxMU9Ocnh0VGhoSGhTK29FYUZnb2JzZXNwRmZURWNJQmF4?=
 =?utf-8?B?Vzg2cDBEWDJ3N00rUnBXRmtpMkdQSFpISlFuVFJmZ0N5VFdrN2c1QUpJWGVl?=
 =?utf-8?B?RnpDMTJxd1ZXZlhsZVl6OUNNdWUwY1ppOW9FZ1JTcFkrMHZUalRXOHhJeGto?=
 =?utf-8?B?NlpnZnhhalFmSnBRekEyb0F4SU8rTU04VXlrU04zTnhkZUJYL1N6NS9zV2cv?=
 =?utf-8?B?SklMeU9WelkvKzhKUkR1NzltWlZhSHJtbGl1SmtoKytUYTIwWmJSYTYyL2xx?=
 =?utf-8?B?cStqVU9CQTlyZXI3YW05MzFuTUUrVDRhdDJWRHZEQ2wrOU56d0pvMkhHWjh6?=
 =?utf-8?B?R0JCYTYrbVdGOXhYUXAvNkFubFVmOWFOTjYyRzcyKzk0N2ZGQmdpYks2WThE?=
 =?utf-8?B?Mm5BQ0M3QmhBWlk2YUFObHdibmNxZXRsN2R1WXU2bEVQT0ZscFd2akhUVW9q?=
 =?utf-8?B?MjVndGxWbGU4VEVIR0FoTXkxR2JMa3M5WlNwSmt0YUVWSWlWWDcvTE16bWcv?=
 =?utf-8?B?OTZ5R3FwZjdJWmoydW9BSHF4YkVscCtkUWRvZW9kRkZVMkZubjk5ak8yOGJz?=
 =?utf-8?Q?fr/o=3D?=
X-Microsoft-Antispam-Message-Info: FnVBhdxlKE28rtbPeV4u1ljSq2hCvAf2gjKPySIe2lN5VXLBKkhlPDn4C+XRU/D2Prbw3fCWtLnBtg6uPZYO3HTCplk8sqYk4OINOVlKV7uCfaUfAxvcO3Rspjv0OgVdDbmOK7WPBBbFdpiaIZpoQO5ekiz5VnY+QE2KJ+JuslAqo46Pt4LVsLnpfWAHQsqQ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;6:qkyME0gl6k6MsTUtHoiY5QPNqDuvKEPH0MDA69giew4ohA4xPQT13+ZcizVznpBr9qJotxphVC2na76hXf/oZzGh6Ocqe0+hzSz4NPv7f+0Qe0llDtquBWhCj4MgLjI/qSvuYf6w1kBd+DmUPbTiH75EPbHqmT0gIDbzyxPA3Bg9K8VTl7srKBwG5ZXBlLuvoFd8er2Y62ovFMwtdqObS6Ib8uWRwfRBkUIlhLAbkBby+Csp985mzHi95/50a05n5W0Yxrs/L8512oa4uURlZBJ/q5fLgNsAxDlfmZFgLLz/x+SV5zJxa8pXMeblkkc7YVrOaCR39rjw++Oy6rzCjKCXIBD4zAQvfmJP10tgSGpzt9lgHpfh+REzfefPhfm9QZp5S9gTm5L2lo9AqV1I3VPWFgqzOiHDLEC/HbyzkOx1muMzQJr9FDwbJabwXbHH7IvVjQdLFqOj44LA3S6qKg==;5:hsPKEglJWGR/mePhKY3tSiq/reu/7SeodAAGAH+buqX39SW4Zy4+F0whctNXeTheFru1x5wH1T/bMGNIy8XAq2vCcqkwPE5BVcnbdBJyUByKOcHFu2uiQrtNTXNSsGPWpfEOS6a9W4fZ3IaR3xcRXtox5C5+0fTz+5M+d1s/0Ww=;24:BPvgXzQTmJkP3W/zcropIQc2c+hq6Hf6bsrrnZIE6M1+BXQ+R77OUn1oTMlVmhFgEUNwuW6QhQTgAoscpJOO+IQqJzfobeJQEq+a80lvHEg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3081;7:D8++75EEavT8lL9ofX3S6M8oDOC+gU4mX9fUtY2xfYyD7RTt3R9wzwyRLMc9Kij8jh2NkLSPXt/ucOFi9d/z4xtrvujS7GIge+OYt0DwPrDw44sE+RSmPRg90Eli7/j9CBtd9GbIOUtnKew/rJKFnCUZwcwMhULOSWOgwvnULYJxHrfE+iGb7hl/kVxERGCeO7PWLjLs9M+46vTZWrjYRRWcLDYvlzsHZ+usvtiUM42TQ3drQ0TbvZ8XByzAi9lc
X-MS-Office365-Filtering-Correlation-Id: 6747f35e-f76e-460b-08cf-08d5b9d23926
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 19:38:05.4138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6747f35e-f76e-460b-08cf-08d5b9d23926
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3081
X-OriginatorOrg: netapp.com
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/05/18 22:15, Matthew Wilcox wrote:
> On Mon, May 14, 2018 at 08:28:01PM +0300, Boaz Harrosh wrote:
>> On a call to mmap an mmap provider (like an FS) can put
>> this flag on vma->vm_flags.
>>
>> The VM_LOCAL_CPU flag tells the Kernel that the vma will be used
>> from a single-core only, and therefore invalidation (flush_tlb) of
>> PTE(s) need not be a wide CPU scheduling.
> 
> I still don't get this.  You're opening the kernel up to being exploited
> by any application which can persuade it to set this flag on a VMA.
> 

No No this is not an application accessible flag this can only be set
by the mmap implementor at ->mmap() time (Say same as VM_VM_MIXEDMAP).

Please see the zuf patches for usage (Again apologise for pushing before
a user)

The mmap provider has all the facilities to know that this can not be
abused, not even by a trusted Server.

>> NOTE: This vma (VM_LOCAL_CPU) is never used during a page_fault. It is
>> always used in a synchronous way from a thread pinned to a single core.
> 
> It's not a question of how your app is going to use this flag.  It's a
> question about how another app can abuse this flag (or how your app is
> going to be exploited to abuse this flag) to break into the kernel.
> 

If you look at the zuf user you will see that the faults all return
SIG_BUS. These can never fault. The server has access to this mapping
from a single thread pinned to a core.

Again it is not an app visible flag in anyway

Thanks for looking
Boaz
