Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2456290-1522922315-2-9135067495688867655
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RU'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522922314; b=eSx8/fv07oRnW+GYuGG8jR1A7q2IC8uANJ19D0RY+yiUfMfFsp
    MC09JE5RbyqnbMZFihrrZ0ZAgF7RP9OZ9VCAC2fkizmYwiNP5jAlltYh+AKeQxLw
    hrOV/OrKP0vqMg74QNuHml2yiGhMo+bM3+duTZiestmhA5fmiL6C+TSUIFgIYod1
    3qWQbS7FWzj2/jxnCiw2bdrcIiBjzqoFcLWxdfCh1ZaSL2MJuIFyLMezeM0Jiisw
    j79xFnHvqCRQEVhlJ5NfMgsoqv/0s7kX/+OIKmjFR2p3mSMV05SWRo0F2HXK3fLu
    +W6/fu2nV4LcIuWt+L12t/H7XdivpRIul+6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522922314;
    bh=xnYzRmvLPgDCW9CUlWMxKDfHtRRPLKTVI3iZtiNQyAs=; b=lnuIDJ8wW4eo
    2oP27uHzzLJyjkDWIEkFaLMX8Uyrm4WLEOlo4WWgTZA8F5mARMY5zDb9tby0HZun
    3ZFgp16pvTqRMqSKi5dM4e2gMQ5XQ0Fpt7gTYYFWMntTUow0+xwi8UR7ZLgpIZ44
    uMvIBSFoEi8lLYp0Pcx7FEfRAh4AmcpFLPM5cY4/HwAm2qHT+oCJQBiSul5+01HF
    GCj10CuURtEHVVeTGaSaUSjl6IhJQR/9SLBXUfZqyhfJO2U/5/iQZickZ3fpc7mX
    yXfW4wXjuZ82kFSpADt/IQq2DRDssmQmOCqPcqjtox5dwXDs9teAlilMTpXWxf1T
    lVzDqmy0hA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iI3SlUva x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iI3SlUva x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=virtuozzo.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=virtuozzo.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAhLz/71p+W2xBvrrdhefhlCScoSkrZFSNSoEtOWC/vseMXmwI1OWr4kTFBII+ypUDL3mBd4r/1x/8PJiQQsI706o/TInadd5hTbmpfnqeF2INd6OJWf
    STALdh/uWDGb9b57ZThKv2COVrlqth+Nbjp0zFIF56UWlrT6w2ds+OfXCruLF4yxAjqThip9h9qRsAgN/u42cQx15I9tI/IIEK6OmaJe/MK7u6+TgYJZm42l
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=dhh_qWxcV0sA:10 a=Tgzm40sRGssA:10 a=BHzdoRfpx9IA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=tpEzL2_AlxEA:10 a=VNvn9RaRkLkVidRGrh8A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeDEJ6S (ORCPT <rfc822;greg@kroah.com>);
        Thu, 5 Apr 2018 05:58:18 -0400
Received: from mail-eopbgr50126.outbound.protection.outlook.com ([40.107.5.126]:29181
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751179AbeDEJ6I (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 5 Apr 2018 05:58:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
To: Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, Boqun Feng <boqun.feng@gmail.com>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
 <20180404153534.GI4043@hirez.programming.kicks-ass.net>
 <3c9b507c-c6bb-3e13-2a82-f3504626d016@virtuozzo.com>
 <af5e2a7b-7dec-6bf3-08e5-f6c4ebaf59a5@virtuozzo.com>
 <242ecfc9-34c9-dfc1-bd36-b9073fbcde93@redhat.com>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <e3e7c30c-7e96-e297-7988-80428420897b@virtuozzo.com>
Date: Thu, 5 Apr 2018 12:57:56 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <242ecfc9-34c9-dfc1-bd36-b9073fbcde93@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: DB6PR0301CA0047.eurprd03.prod.outlook.com
 (2603:10a6:4:54::15) To DB6PR0801MB1333.eurprd08.prod.outlook.com
 (2603:10a6:4:a::27)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: aad360d4-6245-4b5e-4d0d-08d59adbba1a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0801MB1333;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;3:tZpDzr+Aw7VwhdZX28CYBKz8vbhIZOpUa7/xVOwtK6NNlgH/8aDTtZwP8l2pkkz7vRo1UX0PlaqzYnuL7aZqc7UKydYQ3xFzh7nQIxcDQqmECj2j50KpsO4AXYgntpFXdFdvE2l2wS+EVIJu6ccblLg2UarJNA+WS7GwzOh52gkLzWv1vXBOluXowYBGlHveNCq4YnXBhPBvdauPzpRT6cfKV2P3ennOxeVbHorKb1JSTgehQLTMpNEDlNScakky;25:w3HA0MhU44q9x/L7VhlzzrsFvDpZsa/962dpmHPgbRaVuZuZCL2ZPeVv7Wh8s5kXavLUuG2k+S/cLOk37wEpzSvydPMxPILQDl8Y+11XY9d1nc+QuJwNtXtzNQgsqDO3+gjfnNFUO/4jslnkeWRl0zmFpoMpwIdQ9lILVodSnS76AUxM9/4UPeCibJysm5quLuBbQai7nFTtQLpCpe62w+YLXeh74LJWwtU/40cTHW+b+02SaOyRT1r4JPsi2pTqzpOwShBi/5lwKO6ugeyGuYs92SwP5+dooNIcZvSQFr3jUtjTzG2BX1+I050ndosjYnlehMGwKlyPKbWSM8V3Ug==;31:T/v8T755UJXubRf1MFkzFPAhi68OtxklfKxmdex3yOrgh1u1ZEC9rvvKTt/+9XVnKeOVQ8fJyynupUs7p0V4jqqvbHyjyjFvICtsbwD4hcTkK0vboAYPoESy6wWdecMIAeF5ceGyAetqK5pYN8LzyhroQ63Y7LfQ/rHke7wo8LNcYClkGFyQeWvZpC0z5B8OV3HV5kqBDuwnxZKtGx99kF8nR00fujUAGQC/9zyQXIU=
X-MS-TrafficTypeDiagnostic: DB6PR0801MB1333:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;20:WrarUdYxQPl3kd8H50HGcElsXCZmh2rLKFUQgroYMcF5cK/hrp2qDwiwJ2Gh/TfFr09qHH9jhQUECN2cL5U4ysvZFWZOUAPylHa88frBvhrXXWHLH+Wes87HqF6oPwTcjzXnJT1WGWNFJxh9XEjesQuDvhMq2owcbdg1jf6EoXORYOlBNyYNQvE/thZyOanyKN7AoYWEGts/MkTl4Y7MywWox/lIUxWxnGL7y1gL93ya1X5sRe+FOs8ZnojB/y2676K628PnRCZl6t5AMmKUv8kfUnnvRwItvrg6aS5PtVppEqGV0ywQ0Q0+guKjESTGSP1Xp8juNWvXvJhBJVWlKL+vaSENGpyAt9V43ObVVgVwmpvO5wCkSxRS0w2jpBoCFGfqNe6BIhnMVsjajpLHZZTYEczUncxrqudCsgxLEt6edK5JCFK8ZrdC/XjXJpQ4DEaj0jIH+pmB50i31qFoDLy7D+ZYYgoRZtuPydL2rId9BTO7O1HODOIu8dvUL6yi;4:stCPYiJSD8UOgmPMx83oHLqSyrTqrnsvQcGBCTtpBqfiEFi/d/yyJnMlj3RyfC3ufGmrMwPpYdi/BWi7sPJcDHwbf6yq0UKqupkNsaq+KoqVox9WSqE/3uw8k5K6fFWzpSVpK96EuZ3O62rKTyorgRn7TlzMVTSM54EFSr9Yw6/lz0qsCUv1TBFgudCaARAJD5aKm2jiMzCZdETvSK2DwEBtvIW5HCOSLzC0EzzE7qsm3lfRSK4NQBJjYFBjU8WEZi/ZslxOR8SHbY70yhydew==
X-Microsoft-Antispam-PRVS: <DB6PR0801MB1333A9F35BF622D33977AB49CDBB0@DB6PR0801MB1333.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501327)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DB6PR0801MB1333;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0801MB1333;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(39850400004)(396003)(366004)(39380400002)(199004)(189003)(8676002)(105586002)(31686004)(50466002)(36756003)(31696002)(97736004)(16526019)(186003)(106356001)(3846002)(64126003)(6116002)(93886005)(77096007)(110136005)(2906002)(26005)(25786009)(230700001)(55236004)(58126008)(16576012)(53546011)(59450400001)(386003)(316002)(478600001)(52116002)(7736002)(76176011)(5660300001)(2616005)(65826007)(305945005)(486006)(11346002)(476003)(956004)(4326008)(446003)(52146003)(23676004)(2486003)(53936002)(6486002)(6246003)(81166006)(39060400002)(8936002)(68736007)(81156014)(229853002)(6666003)(65806001)(65956001)(66066001)(86362001)(47776003);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0801MB1333;H:[172.16.25.196];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA4MDFNQjEzMzM7MjM6UEJHM1Z3MmFLdXB0RmJnQnc3SmRBcXY1?=
 =?utf-8?B?ZVBLVjR2dFBCazNpZDVWU0xiK3JFdEtBbTMwQ2FPNlpBcGttQjBzbmUybito?=
 =?utf-8?B?VVNHbDBna1hid1ZIQStlaDVLeTFoT0xLLzc4NW94WW1GQ3FtUFlaN3c1Rmd0?=
 =?utf-8?B?Q0FPYTlybHlubkJqdnJFeUFISnIzU2FEd2daUXRjR2V4TXdQSzN5aU9DSlht?=
 =?utf-8?B?b3NpMER2cEJnVzJUVVZZVGgyQnF1NXJSVG12V2ZQZFBmYjJ1d01tYlJKMHN0?=
 =?utf-8?B?SzlwOERJS09MTFNDK1k0Z0pLaWV0Z2JiQ0FMUVhoQzJjcWxOb2hCd2NMK0VU?=
 =?utf-8?B?QS9MZzVqVkFJT0N3SURPcmNzTUltazdyaEhUcXpIc2FpWGh3TU51RFZaaEMr?=
 =?utf-8?B?VGZZcWZUWFVWRjQrbGMyWlVOOHRmNG1yYWhaOFN3ZStxTGcvQ2QrK3Q0TGpp?=
 =?utf-8?B?NkZ5Y2pQeVhmUk1MMGxpTjV4eG5STjNjRW1RU083aVFUZ0ZmbWVaTyt1QjFN?=
 =?utf-8?B?UnFjd25mZTBjbFRqUU53bnRuNld6VzlVUjRpbnZpdGJYYThKK2FtWWxIOTdN?=
 =?utf-8?B?bExUUWducFpoMEhMVlByTzZQZjlRKzdyaDIrM1NGL01HWkVFZGhiRVV0MjNq?=
 =?utf-8?B?VysybHdaSVpsRkVmWGJkZE9XbHZjNXVncUpRamRPWmNtYjJwdzlVcklUaWha?=
 =?utf-8?B?TXRpd1RSeXladmdqSytnb3N2UnVyTGhDMWVBdGRqaFpiSUlrTFhqeFErZWFF?=
 =?utf-8?B?TVhzUVRMWDdtaDhCQUdtTm5GL3ZUTWpXZFlxdGlEQ3BzZCs4OVhGUk1sU3JY?=
 =?utf-8?B?MVhXblhNOTZlaXE5MCs1LzNRS2IwRDFQcVNoT0ZENzRaUDMwdUNUWFZnd2Nm?=
 =?utf-8?B?NkhUd0R6VnRJTkJ3OHJsV09IUVcybEg0WkhpLzhYRmVsUXVJMFU4bGtEU1dM?=
 =?utf-8?B?SWtrUnhiZWt2VW9iNHEycnh5akxCeEZDU0NDU0RXQlpuZGJHVTJFTkRjanc1?=
 =?utf-8?B?SVhzbWJLRXBkaG01aDVteVBCT1dXTnVaMjhhSzVMa2JwWkhMR3d4bWsxMG9Q?=
 =?utf-8?B?MktkZ0lYamVSS2dqVUt4WmlqS1A3S2JhRXN6cCttZktrMEdDTWE0QmVnT3JC?=
 =?utf-8?B?RTJ0K0k1V214L2d0cGJLMVN0TGNXbGkrd2dpNkJvdmhpYjgrdm95bWdOVnNM?=
 =?utf-8?B?YjdKd2YvYWhLNlVvNExzTk0yYnRLbEJQNWNjTWFrMlF6ZUYycGJaU2JJVGlO?=
 =?utf-8?B?M2NGbjU5elc4TDJHVHhVZmUwMHZrVTNQQ1BENlY1TXpWTk13ZFNHNi95TDFO?=
 =?utf-8?B?S1NjUFBtRTNCSWZNa3owMmZybW1yTDF3MDE4NG42ZUZpaDh1R0FQbTJTOFNT?=
 =?utf-8?B?UjY1d0ZnaVNxeU9PRGppcGNKbEo4L1k4YUl6eEo0V3MrV3FUaWxEaCs3WUo4?=
 =?utf-8?B?ZlliakIzVG1lZGNiRFZ6djFQNDBYTDVFanVvSk9KTDgwZCtCalA1Q2tqQmhm?=
 =?utf-8?B?SUdWQ1dCaHZBSU5kNFB6MHl3WENwNWhBbUJJMnlHbVErLzFSdEQ0K01reTVC?=
 =?utf-8?B?NWxDckhrdStHTlFIRDJWL0lEZTh6SU41em9pbXNrZWlzL2VjVlo4cFQyZ1hr?=
 =?utf-8?B?NkdTdVZwS3V3SFZoZWJvY3lGeVRYYW5zMEZjcFYySHdCQjBUZFRXMHFZRGxF?=
 =?utf-8?B?d0pTT2FPMVg3cUxNWTBnTFpwdlJ4TDJhUnlOS2JUUDY0RTd5UHpBK0piWFQr?=
 =?utf-8?B?aWdkK2NpKzN5YkdSVGNSQnZFMXVvOWZjQ2RFQnpwV1lRaGJNazZrRTFHZ2Jk?=
 =?utf-8?B?VXVUNlRlRmRrMEdzTFBGTlc4YVV2WWVwRnhad1Q0VEJWSTFVa1VXeWpWaGsr?=
 =?utf-8?B?K01oR29KQld1YjducjdrNWVPMXdTN1E3ZEIrUGJOSTVwSE9QdmlmYndMRXNB?=
 =?utf-8?B?TFpSMVBpbFdYVGJGa0NaT2FZTks2T3ZTTFZBMmdpNnBadFRMSUdMOWJOT3ZY?=
 =?utf-8?B?Y0JUODIwVkZLdEk4SXIxdDIxYjdUdFNsMndtNi9YZ0NaSENNR2thbTZFbVF0?=
 =?utf-8?Q?OhOgY4=3D?=
X-Microsoft-Antispam-Message-Info: CILG4torze/h/MUz04CH5QUPywxvHMUAtZW68WXljE6drP+ifrE0QFmO7YKQZ4HKD6boQvTuvnSpiGQqvxRHktsBZ6nwiOkBH5HTgAylwS54GmWqpLseYD8/El8kSZXc/h1Wqm7HGU/J0AT9DfmBbr0k9fgvPtqyZc0bvfctVBGOsbaoP4NfWwXPns24GoIo
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;6:ZL8pr4cinq+PvLUeyBUXMETtaIv0x1jxGgCAQJz2vQJUwnrzNCdw/s9g96X9aBjjgnXJlviHpd8pkuH2Bpdiah7O4G9G+xt/9lLnTNvLR/y4YFYLHIJGz6v0lDcXp55o13x+AOTFo83LdpaHHOEIKutN98rjmG/jwJCNA9glql3uYJcMVzqjuEKJHLJ1aGCY7OWszv+y7gUIlZc881h1OV+KOFQYH4rOWv1K88pZXvJfncHa9iLY1+lezetF9jCVXo16gyYIjyDelIKsjU+Lmqbw8gAABkmTyxW9xGmHoy+IWCikQ9vqk/cUuWRFwNZzqul5pQ4bifaEwkkLZc6hXl0K8227XBArYNwdNTYFlIP3HPW9705Z3LOB8OuZtDciKVVRx6REITqif8jBR30eAX6M1wtu1Fvyt+1tf0foqqyiOJDqqPJPDaBefHt2kkfwu3VSlGl5bKMNi6+OzjksdQ==;5:ZQr0qPg+fpWqHH+TkJhmd6eXXiJ9AXdowe3Y3h9Thb8lxsnx4VR90KeDfLWws3GTbO3hhzG6NgA2X6EXAUoMjDewj+V57tnfH9+CAinujnMvy0F35/KT940ppNRArOuRPNV4bacgLTl/IjKUOMW/ZkE1AiREamDTbv31plfie24=;24:3x+5DxXjFfHPvHkMwX619qnf0U5foO9fDH4QocH8q949E1TyBxSCI0qSFyEsoshts4Aq3GDrz+pIkW53Sld1U96Q+Srq0lTc6NxDQC+sLZA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0801MB1333;7:KI8ji8Ide+XnZNjjySmtFKA0rRTn8VxX2um30Ys4WcZ2fvWLWpYRiylt/mfHJu+/hh8n0FcVAV4EBxQQehAYyG82ENNeDu55tPihWCTcDN0Wca389Gmv7VzJd7MVB6UXkMH1Gu8H3v+7IO84Vwj14pf/i/K0k+HTve2GRpP4pSCuD7nEaV/m7WbOuxPmlKzKxoKDPxuscfTvuevL9TemDXpyjpzVAYAcZvgUDtT6Hd5tQwA61xVdi9Ib0BBwsBDo;20:pwk6xRJGP9tbd7t5+p8nWlxNGow9klnDwee/5POSAZuMFXsrphl6bYVg3UBmP0WXzJPRGnkK2HEU0pRm5plmiUFOO6picI0gYMNFQNik1TdN45DjU4Oi19vN+fcYuHJr+VQdLkZidrcT3BwsvI8sH4Lx/1d5Bb66rNTKP/cH7ro=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 09:58:04.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aad360d4-6245-4b5e-4d0d-08d59adbba1a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0801MB1333
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 19:25, Waiman Long wrote:
> On 04/04/2018 11:55 AM, Kirill Tkhai wrote:
>> On 04.04.2018 18:51, Kirill Tkhai wrote:
>>> On 04.04.2018 18:35, Peter Zijlstra wrote:
>>>> On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
>>>>> The following situation leads to deadlock:
>>>>>
>>>>> [task 1]                          [task 2]                         [task 3]
>>>>> kill_fasync()                     mm_update_next_owner()           copy_process()
>>>>>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>>>>>   send_sigio()                    <IRQ>                             ...
>>>>>    read_lock(&fown->lock)         kill_fasync()                     ...
>>>>>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
>>>>>
>>>>> Task 1 can't acquire read locked tasklist_lock, since there is
>>>>> already task 3 expressed its wish to take the lock exclusive.
>>>>> Task 2 holds the read locked lock, but it can't take the spin lock.
>>>>>
>>>>> The patch makes queued_read_lock_slowpath() to give task 1 the same
>>>>> priority as it was an interrupt handler, and to take the lock
>>>> That re-introduces starvation scenarios. And the above looks like a
>>>> proper deadlock that should be sorted by fixing the locking order.
>>> We can move tasklist_lock out of send_sigio(), but I'm not sure
>>> it's possible for read_lock(&fown->lock).
>>>
>>> Is there another solution? Is there reliable way to iterate do_each_pid_task()
>>> with rcu_read_lock()?
>> In case of &fown->lock we may always disable irqs for all the places, where it's
>> taken for read, i.e. read_lock_irqsave(&fown->lock). This seems to fix the problem
>> for this lock.
> 
> One possible solution is add a flag in send_sigio() to use a
> read_trylock(&tasklist_lock) instead of read_lock(). If the trylock
> fails, returns an error and have the caller (kill_fasync) release
> fa->fa_lock and retry again. Task 1 has 3 levels of nested locking and
> so it should be the one that does a retry if the innermost locking
> fails. An warning can be printed if the retry count is too large.

send_sigio() is called from several places, and the context, which calls
it, in general is unknown. In case of dnotify_handle_event(), which calls
it under spinlock, trylock will act as busy loop. This may block some
smp/stop machine primitives, and I'm not sure, this can't bring to some
currently unvisible deadlocks.

There is a solution, I'm analysing in the moment, when we can convert
fasync_struct::fa_lock to read/write lock, then we can take it from
interrupt without problems.

Kirill
