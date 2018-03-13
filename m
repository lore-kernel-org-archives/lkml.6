Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-117643-1520985017-5-14653936969288903265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520985017; b=hvGpT9OujOhZ7BLKNMShuC1R4iLBBJBOa2OmaNC6cqCy7XP
    JO/rbq1UMVbMMDprFbRCgNPhTJfx9EmhMvD1gU/DLYrThtTM1wbnxTuf8eH59uIe
    1KKPNw033Fs4SHDf+yoeHKvyjp16TrNSDqRqZ4b1rsU6e2mujuo4LyoHzxnWVq30
    PmHdCNQcOa3g88IEizY8jDn8g1fCMeiFOoB+mPHWKQ3pvTuy20jX4Ptpbi5yVI/I
    BC1rXFwkQDsbutmjwg8w3YM852buSlx1VaUOaBzqzudZzKobz84T2xBmF5LKuD3F
    1uJy+IUrAG4gNrjWRxi9yBSPR0vBVWMmT4vJWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520985017; bh=EID2HEzMxTC/cGaoK25Mr+2wW/MXBSXj4G10NsSHjVc=; b=n
    w5Lb1PuS/+3iOrnOLqm91IBUikcfIFMd8TaSA8qR00yPCkhd0LoLNriJ0Ya8x9j3
    WzJ6jbyPKnpOO8IPNNabcaNsqTrtnCMUwbnylri5FWwAYm59SFixu7sqb/3NmCYk
    E2yrf4lMDXy6qIpaH1ttImCUzgw6qR5NxC4RCK9D2gBk9rq/Kew+1uYsH1Lkff9a
    RlJnnz1m+KoN6bDDflwg3MVau0dFrcf2BjKuN6boHvVZlN+Xj3MuQjZa7pZaqBS6
    ItlTMhAQpUzPgAgj0BR2ydti7YbKn/XbLs+JIcw7yc6SkzSykNQmR4niKwP9vQWf
    4/aOsEU8eYO5rsKZ65dgw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Ir3TYbFy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=NXUpsd9Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Ir3TYbFy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=NXUpsd9Q x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932637AbeCMXuB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 19:50:01 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:41392 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752885AbeCMXt6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Mar 2018 19:49:58 -0400
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Omar Sandoval <osandov@osandov.com>,
        Howard McLauchlan <hmclauchlan@fb.com>
CC: <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>, <kernel-team@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Josef Bacik <jbacik@fb.com>,
        Alexei Starovoitov <ast@kernel.org>, <netdev@vger.kernel.org>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
 <20180313234509.GA4981@vader>
From: Yonghong Song <yhs@fb.com>
Message-ID: <67172932-df1d-5585-601d-a7ce70a2c86b@fb.com>
Date: Tue, 13 Mar 2018 16:49:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313234509.GA4981@vader>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:3fb9]
X-ClientProxiedBy: MWHPR06CA0027.namprd06.prod.outlook.com (10.174.172.168) To
 CO2PR15MB0075.namprd15.prod.outlook.com (10.161.86.153)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae348f97-314b-4946-a09b-08d5893d1393
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO2PR15MB0075;
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;3:JTB0GgCiqZEdv03dDnYszhlGjtMJlgYWLLzaPtTncgkTUauPAZfHhDRa97UcGiETB1NNGMJp2HOixy/N3IuFbNDBFXzuU7l+IdrIBpa4QRKX60ummI+1LUgVmMm5zsVbA+GR5sfwvDgHNQXabDOeKeUPrL919DCPlZFbUYkhPHUAnkrBNXnM8D34ST3fnl6LDa3YM66rDlXfssP37Mg4i6Qu/xu1ntO8LudeCZw3HmfqtiJwcaf1o9+m/7dQ58iq;25:7t1343rLvYVFEN6NQ1PNWQrLd2HPKW5sf6biqVeBUW53GB/kcrjgNqYGiNdyJcOkCgkNf1QG/6ZM5/fhmBL5NBT+5V0mWnruIGaJrEo95c2b/lgMqfMDiqXz0WmGbT4UAy+6HEqnMwMtm/meAI03UcFVnadfQcDjfh/f4Pv0a0+UrT6dIjKo51bAU3EQvG49A5yr3XHncfw6O4vhqDDKM6PlpEM+YF734UHMm7+l3sHwrSaVhG+xUqBWWW1epNOxSDx3n2u572/CWFHH2h51O5V/agwtKvWsfqIbvfHCQSOsm5yzLRo2XjW04hvg2RwJzfANUj1lstjLPGvUmNZu4EOT0IVNSxFxtkdC1O1CJsw=;31:Ow92pfzNhdag5JDmeDO5XHJ8SXNGxrtWz9uaQymvtVg2BVBzX5X7Ducg97TpkDtryXeeRJsskbCtktcRZ5/2bjzLCJpyb/zCH0ynXG7PhV7ikiFTmkfBAEm80NWLUlxIU75JSAwneIGhV0Q7+dhaMXN0NUPM44yIF94G18OO0ZqDQ4D1wCq28UKHsIgQncMCGUHTrOHtsmWPuTpt+TQZXeOMH+CCbvCUHSJscCjJ0fc=
X-MS-TrafficTypeDiagnostic: CO2PR15MB0075:
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;20:mMyrk5QhisEdpTiEMHQEVk9SMgYTrikEiJFbvhMuSDJ+dqornKNOKIgypDOYRqPXGK2yahqzIJgAT8d8G9JYjNJSUSHPYfnJ8uAKokmZsDIomDCqcS3WmunEblmN0enn8WYEruIfyGF8p8Awb01iXs4D3d/zoUZdyES02gvWzb/gN3vApxD4ZB55/b2VLx1H029SNR8WRoOJPk9EwnqJOKBe1Nbnj673g4u/4DnCoywNWdX04gVH4GLNxHMOIK6M3RxnKfd7qePjkdWsuS+cONIO+Ynp96aMncYvxE1ZfZTfMvdT9BVPh8rkUzM4a8NmeMuprODhzzLpfXwE61i0FXXtr079hqXmoqxWpFe9YFMpW9cxuHVu79kuRlVYgePZXZ2RxhHvBYjgQpZzaEANowxNsJsYbVzGNGV4DA0ik/yAeccYtUZBgB0s81cpp6HCfMnf31dBUeXasJ+2jqevstjUmYIZ7yeVG4+eSY+Mt+fy8+dtRbpKYrYvHeRHxsU9;4:m96FW3INlVqXUz7k/Dmfl2OzGAPpNIeP7991ggaq4CMCpMiCWjKwp9tYbwPUsTF36LLMXsymzcsH70mdytt8J5j3p90bnlDiuVI2MkQVW1wbdsu9DO0/7XRzw4bIdPMYjz40S2GyASovKwcKKiCIDfazKk6kbzEzM457jyGS6QbTU+0urNBYUXE4c06NDPCaYDgkdvqYbaGHmpyLR+j31gh4dAeB7cVpCm8nIesUg3JEUpfJ9MhVOWgf71LXj6Fek27Ye8w/tvTDUaLnXgttGX8NQIugUb5Ll7ICDidHhgSExERnThld1TJb21pOmckn
X-Microsoft-Antispam-PRVS: <CO2PR15MB007529A7C9A454115F22D034D3D20@CO2PR15MB0075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231221)(11241501184)(944501244)(52105095)(6041310)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:CO2PR15MB0075;BCL:0;PCL:0;RULEID:;SRVR:CO2PR15MB0075;
X-Forefront-PRVS: 0610D16BBE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(199004)(189003)(110136005)(106356001)(305945005)(229853002)(2486003)(86362001)(31696002)(7736002)(54906003)(52396003)(23676004)(8676002)(81156014)(81166006)(46003)(8936002)(53936002)(6666003)(52146003)(6116002)(52116002)(316002)(4326008)(2950100002)(67846002)(6512007)(2906002)(58126008)(76176011)(36756003)(478600001)(6636002)(6246003)(7416002)(31686004)(186003)(65956001)(25786009)(65826007)(65806001)(64126003)(6486002)(16526019)(105586002)(97736004)(50466002)(230700001)(53546011)(68736007)(5660300001)(47776003)(386003)(6506007)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO2PR15MB0075;H:dhcp-172-26-117-37.DHCP.thefacebook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDTzJQUjE1TUIwMDc1OzIzOjZqQitQd0pua0RtQlZGd2pXVWYzRk5xTEZ5?=
 =?utf-8?B?M2VvYmZ0OVVjRkZyQ0VrVXNOaGMxYjBQZU9tdmtVaWJTN1JBd3J1SzArejJ0?=
 =?utf-8?B?aTBPOS9LcUFDaHVyZkF2V0hHRWpiSjQzZWRnMWtDTjBFbE5LdWZzVzZNK21F?=
 =?utf-8?B?ZVZPZXcwd0dtOHhQR1VuYlpnZi9ON1NzQ3F4NElZclFxc2dOUmdzbmhvbXlG?=
 =?utf-8?B?dFVEaHh3SjZKU24vY2FaYzhTZXZMLzVPSFMrZUhDM1E1NHg3NS85eXBBUVZh?=
 =?utf-8?B?NEFhTmlLRFBTd0dmZk1DK1NaNkJTKzROZ0FRbHVVT2VFMWZlRU5TTmFESHUz?=
 =?utf-8?B?OFlYN3BnRGw5eUZmNkRrNERadEw1RGEvT253YWRPODVkWnhwTFdhNHlmUjBL?=
 =?utf-8?B?TnNTZzVmbmhyQnV0TTNWclIxWkJETDJNOVEwdSsrQkZad1pqZDkrMU04VmpD?=
 =?utf-8?B?T2dURGZyWkFtVGFjNXh0U0p0dWhxaXQzQ1B1aWVHS1IwOHlmZEJRQnVEYnZi?=
 =?utf-8?B?TGU1dDBiSDd5dk8zQlp1OERtdElrWFNMTTh0NnZqM2lJdkN2SHNkR01zSjE4?=
 =?utf-8?B?K2x4dzlyVmNzanh2cE9peXIxa0VpSlFFQU0ySkxZMFhWSlhKcEFFaUJzTkdH?=
 =?utf-8?B?clJ6Mm1DT3RVM1VCTmRlZUN3RDRhQ0RqTlJjdlVEa09id0hqRFo5aWsvK0ZQ?=
 =?utf-8?B?QWxTUUZ0aVB0aVpoRkU3VUFzaldHREd6cEk5b3Q3YWluR3Y0am9EMGxRSzY5?=
 =?utf-8?B?QXNMWTBkUzkrVGpHdG1UK1VXSkFqSVVwMFFYd2pKWEU2VzM1amc1MGZFOUR2?=
 =?utf-8?B?OVpPYlArcm5LYlJNYjQ5c2IwdVYvOC83UEJnOFVjSWR0ajQrbDUvTUxjbjZz?=
 =?utf-8?B?RG92VGwvdHRhQSttSzRTTVFHRUVodkJSZmtaVXVqRHg2T2ZxWU1BS0hmcy9a?=
 =?utf-8?B?bHdHZWNXMTVlSisvNnc4UnpTV2I0cXh4QzN2d0wyTnNMVzJ3dGxyUThCWUs0?=
 =?utf-8?B?cHoxZUJzeHZ0YnNscVpWbFBnQkpIY25RMWdPcTk4MzYrQjRyRXM2dk5tcHU5?=
 =?utf-8?B?UDlwcSs5MjBUbVdTam1XZnhPejBXelRWYTRoTnpRRnFUT21NS2JKWk9Xck5T?=
 =?utf-8?B?eUFMWmhBWkx3Mjh5bnFoRGU4U3Q3RGhZcEJucHcvcUlvYjN0K0hPRk5vOXJt?=
 =?utf-8?B?N3BxYnM1ZjhEVkpPOW5PTEFtOE4wWmlFb05iMGp6TDdyWHI5VEo4MTFMZG5G?=
 =?utf-8?B?ZXJYZ2NVanJGWjNWZXpqNGlVY1JGZlFjeEhvUXp0TEw1N2F2QW5INEdxOHFh?=
 =?utf-8?B?MUNmczY2NERZNWxyMmtVRFBCWHZpTG5GcXJDNWdMeERmOE9ZdzVGcVAwZ2E2?=
 =?utf-8?B?a0Q1M3FzS3djYThUcFZwRlFHNDkveXRDaXRia3NvcDJZZGJVVGVCWW5PazBt?=
 =?utf-8?B?TS90RTlsNnlKNUJENWQvaUJwZ3ZBWnFoUk1YVFQzT05VRzRWZTd6YVM4ZUgr?=
 =?utf-8?B?bE13UE9tR2lIdG9ybWR4SnNaTmI1Myt5WmJucktWVURZQjNvd2JZQU5MZUxa?=
 =?utf-8?B?QVZMOURvOXg1VFhYVkdFdzVrMEpuekFJVGdXNFhJaTArUlA5WG1GUFArZVlo?=
 =?utf-8?B?TkNBbHpTWU85YTNVd2tHMzBaaktDSmpiUmNKclR1Mkp1OTlTRy9hRi9KeUkz?=
 =?utf-8?B?dmcva3hXcVZBbWs3alQzUDFJYmFLbnZIWlIwdWxTZmM5ckpTSnJoVmozVW1I?=
 =?utf-8?B?bm5mVVB5aFl6L2hGK3pvdkllNUxIQ1ZCditmN0NyeUoxTFBwNXUwMS9sS1Jk?=
 =?utf-8?B?WHJMN1R2K3BURW9xRGhLMEROU0lrRmkvNWxrRGhPMTdSTWhORXZPUldMdjA5?=
 =?utf-8?Q?u0GjhlI21cjFYxum6pAkQl+SMEVqpGi1?=
X-Microsoft-Antispam-Message-Info: 1HZzMyfvQTAfEDeZ9rTFBYlP2PUYEvunVJZ5VDyaJe5eTuanHm4eOQ3/aBIY92VRMIB95gHu3ewow8UMF8FcJSoG9XBnlCN80kXcxbqoN7SZp+2HEdsu+h44Wsew2f06oeAi7K6QMKaF+zLL9WQbN2iPhq5dZDcyFOOZUSvV+fOrLa8rKRAum0FtjEZbhiDm
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;6:CgM7ZRxxxOLGXCBrBL1wvR26vZNwdaS9+Me8CP9l7EvbQAoRxz7tm4+jjCksCxPORsGhXvD4LfA4ipDITIebeV/vsrLNjMC7Ucphl9ac+hdsi79y2g+kidp2YWWe0WLoRzA9BggUaYd+HsPx8VFyRCyj/iDOyONSpNoHDVhkpX4dYvop3uwx7mlJm5n07yDaOH0PTFYlJx87Twn3DN+xWNUYXpgHhae7Xv5mFqSQQ9sZgtzUsIY9mBLXncH/+mZE3elXqgthMVdha7nnlIZCc3TkNgfzyFDFeHSh6JGFLYqmwPbA+KMNq+S+/QvTvuTuI492vdIbVSoe5onRUYxwGbsg1kgB1UzId4cK1i5YtG4=;5:TxqL+tkR6kh6qBgAv2/fuTPfg3bo0jOeBgwMwV+Aof4G+cVZw3/nVzLZrBYntlVo9xFj9hIBvuRdSf7MEmSAoi7PnQsMfadW+MJss+TxzaTxiGaHi70mJu/KP9TZE6s6vDOiVW/7XlG1GYcsThTqj8HcBr9D1LoBPNn+iEfATkM=;24:xtishVqNhLT9p76dOCr0a0pwKXvRXWESpDEP9jIKVlJQ1vJs0OmRYdAiE7dUP191LR9a7giSiUaraf0iTNQnCr608JGSZPKgMBs9HawLnnQ=;7:wixs+mrQfayV1dqVb/MRE0aRtT1RYY9/s2mvYFYUxKYmDqML/vlCkRvdI8DyUpdeLnl1O2xFr0L/Q1XEDU0H25q1Alk3UnlELjAHWEY7VSq5GzIaEc0MoYno/q3TPI5avFy5vKjoTnwMwdj8DASUmn5766zXZyY/81eYazwp5fA9eMXTAGItEKbwJDZUW+4zRI4ocL8QAVJqdTaBiZYgejw1KzjgpZobu+AXiL4rnq58YWPx1RZnQvaljKa6ipfO
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO2PR15MB0075;20:NVLKu9rJeIPd9cp/rd/TrzJcleSPDM6CNpFKqPXCpzn69GeHsLWDKoXoQC7HXeSnLF80b3gZKXhMfjQcfy72+hpM+4NwqKoX3dAVV0+VrfLmpyp4/MyGPGHsLPctW1j3R493mGm76JEXwDP/g6rCzsKSpPDWqv9cRCVIXpmPwZc=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2018 23:49:34.7714 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae348f97-314b-4946-a09b-08d5893d1393
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR15MB0075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/13/18 4:45 PM, Omar Sandoval wrote:
> On Tue, Mar 13, 2018 at 04:16:27PM -0700, Howard McLauchlan wrote:
>> Error injection is a useful mechanism to fail arbitrary kernel
>> functions. However, it is often hard to guarantee an error propagates
>> appropriately to user space programs. By injecting into syscalls, we can
>> return arbitrary values to user space directly; this increases
>> flexibility and robustness in testing, allowing us to test user space
>> error paths effectively.
>>
>> The following script, for example, fails calls to sys_open() from a
>> given pid:
>>
>> from bcc import BPF
>> from sys import argv
>>
>> pid = argv[1]
>>
>> prog = r"""
>>
>> int kprobe__SyS_open(struct pt_regs *ctx, const char *pathname, int flags)
>> {
>>      u32 pid = bpf_get_current_pid_tgid();
>>      if (pid == %s)
>>          bpf_override_return(ctx, -ENOENT);
>>      return 0;
>> }
>> """ % pid
>>
>> b = BPF(text = prog)
>> while 1:
>>      b.perf_buffer_poll()
>>
>> This patch whitelists all syscalls defined with SYSCALL_DEFINE for error
>> injection.
>>
>> Signed-off-by: Howard McLauchlan <hmclauchlan@fb.com>
>> ---
>> based on 4.16-rc5
>>   include/linux/syscalls.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>> index a78186d826d7..e8c6d63ace78 100644
>> --- a/include/linux/syscalls.h
>> +++ b/include/linux/syscalls.h
>> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>   
>>   #define SYSCALL_DEFINE0(sname)					\
>>   	SYSCALL_METADATA(_##sname, 0);				\
>> +	asmlinkage long sys_##sname(void);			\
>> +	ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);		\
>>   	asmlinkage long sys_##sname(void)

duplication of asmlinkage in the above?

>>   
>>   #define SYSCALL_DEFINE1(name, ...) SYSCALL_DEFINEx(1, _##name, __VA_ARGS__)
>> @@ -210,6 +212,7 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>   #define __SYSCALL_DEFINEx(x, name, ...)					\
>>   	asmlinkage long sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))	\
>>   		__attribute__((alias(__stringify(SyS##name))));		\
>> +	ALLOW_ERROR_INJECTION(sys##name, ERRNO);			\
>>   	static inline long SYSC##name(__MAP(x,__SC_DECL,__VA_ARGS__));	\
>>   	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__));	\
>>   	asmlinkage long SyS##name(__MAP(x,__SC_LONG,__VA_ARGS__))	\
>> -- 
>> 2.14.1
>>
> 
> Adding a few more people to Cc
> 
