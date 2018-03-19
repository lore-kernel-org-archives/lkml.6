Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3553123-1521487185-2-11224820562778038559
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
    t=1521487185; b=eacLLOlflM8/lGAHxmAN8Dt3c3kCOof4vXijQ8UbEeh9MTK
    15tRZkOhPtFJe5EBKAx+7P878eoE5f6XkrplbGv3d2+w2zpUYyYa7MfrzP2r6LbB
    EKPBNvLLd8XDYJjzSgenSNU20OJJf9I9EIyv3h9IvOVR/UZ9g98LTmOIY7SXvPWe
    y58zVHDiNtswVeQCooyiil8DulTWQtpCM32xWOxPThC/dy2AZYLcxxOsi8KfDumI
    QWCn1lEibqgnkHZ+XQnL+i55Peg1hcsnzKGoSHO7CNTdTinkL0rOjRGVJ0cqPHY7
    kjO/0WYdZFU4aqLmSTZxeuVjqOweWt3vOQV8UIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:subject:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521487185; bh=Jt2BcYsiSkgtpVMRXr5eMeMPkF5Jn3ZzjDGH8jWHoFI=; b=P
    bD4716a83E368xUOYfpTVAbUplbhWBmEZaZNenSPRMjZeCWiSDPqkpMU3XmvBEd1
    OSTqWVOec2SXs+NUa84uQYgE+bBiCI7bN5LN/fXbGMyupf1Z5ysGOuAJA80SeO0i
    tlY9ixYJMNbvrlkDHveeGPwZOzCyMxjSsm67T8cvQOtuGqYv5XzJkNsIcyUy1HxG
    CTMCFUZGAoPJTXaJZoPMTl8fc1VxdyDpA4DS4bRno1ypNkarzl7PysnrfHJ9MaoE
    bLTIX/DEuZp2opqrLHIuQQ+baAdxQ4nXJTytIimAYkpFnOZg9x7kXEUUWvLxYCxs
    MskSDssLzVc9QUYxN/Gpw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=DlHjwATO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=goJ+U7wO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduvdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffgfgggjtgfgihhsphejsehtjeertddtfeejnecuhfhrohhmpefjohifrghrugcuofgtnfgruhgthhhlrghnuceohhhmtghlrghutghhlhgrnhesfhgsrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvdeivddtmedutdgumegttdeltdemvddttdemmeehmegufeejrgenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudehvdeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=DlHjwATO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=goJ+U7wO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduvdefucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhuffvfhfkffgfgggjtgfgihhsphejsehtjeertddtfeejnecuhfhrohhmpefjohifrghrugcuofgtnfgruhgthhhlrghnuceohhhmtghlrghutghhlhgrnhesfhgsrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpvdeivddtmedutdgumegttdeltdemvddttdemmeehmegufeejrgenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeolhhinhhugidqrghpihdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepudehvdeiieenucevlhhushhtvghrufhiiigvpedt;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932891AbeCSTTl (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 15:19:41 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:59588 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933619AbeCSTTd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 19 Mar 2018 15:19:33 -0400
From: Howard McLauchlan <hmclauchlan@fb.com>
Subject: Re: [PATCH] bpf: whitelist syscalls for error injection
To: Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
CC: Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yonghong Song <yhs@fb.com>,
        "David S . Miller" <davem@davemloft.net>,
        Thomas Garnier <thgarnie@google.com>,
        kernel-team <kernel-team@fb.com>
References: <20180313231627.1247-1-hmclauchlan@fb.com>
 <CALCETrWWAB4FcDe=uUUBiq9YZ-jN1G7kNjdEw=Pwe1SSqyL5LQ@mail.gmail.com>
 <f47e1374-43eb-d7c6-dd0a-5d530ff2b4e2@fb.com>
 <20180318064738.GA22649@light.dominikbrodowski.net>
 <CALCETrWU4KDu+3U2Z6XpLcV5G9-ihesCdREdaGtO76spuHW-mA@mail.gmail.com>
Message-ID: <831eeeae-ecfe-efca-79a2-8edd50adc668@fb.com>
Date: Mon, 19 Mar 2018 12:18:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWU4KDu+3U2Z6XpLcV5G9-ihesCdREdaGtO76spuHW-mA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:200::5:d37a]
X-ClientProxiedBy: CY4PR13CA0037.namprd13.prod.outlook.com (10.173.156.151) To
 BN4PR15MB0532.namprd15.prod.outlook.com (10.164.61.154)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bae6bab0-2a1e-4367-5677-08d58dce42f4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(2017052603328)(7153060)(7193020);SRVR:BN4PR15MB0532;
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;3:kNwmEoBQNMRoXPR9cE7ha5ejD/SNFaEuK+RkKWy7lhfqdaYrYLe1AyZSLGaiU6HsNLrR2yCJL6lqQx9hnQphkzp0Kzv1Wiwhrc08zZKZ+Y1TlvfjRLGrovi+j6UV/eKmumjtNkz2Oe/WxfopxjYAQOiPETG2lGUT5rT3MNWodzQhbeqNsHysnrnlxKYJAtqlhEEKTk+Cwrxn35TvD6NheWi+41axDYL80iY6WCFJERfYnWWdOQ7atDNFJBs//A45;25:kI7aqSa+njIv6gHy3WRbrC0bzhpuJmL3CXp0k4MDy8v+vW3KhQQ6mwF94+LSqIqUGDX8R+h68MAN+KkjaOzAP4pOE4nI87UVuCWKNqxEGdlp5d4bMCkM9bejmpcctQCXJLqWW+BEhd5B0ttLDQ+HMSZ6j1BZ8P2dbu7jn7aWD+rIWU5Ta3EomvfGK4hAfSb2b/13J/JkOvLJV4xuz+JTkjbTrl5N4Pjx4oR2WDdc3Cy304JZkBu0N0/6YTP0Rrff4OVWpteXt+2lKNgS6LRfTI8yojhbRbt51tsMzIOWJTfqAlQCniAw9pgv+qa6S2d1UIzvwje2YtJLogigjbA39A==;31:SlurCc9IHPD0+O4Q7rqfNgfytjw+y+3kQ9tjO4362gGIJkdL8Tk/foQPpjMzSeRnmeCwDv0nibo+Mzx7LYvAqludFbrtQRoMxz9CQmbW8K3tv8jOF573K/lJW+vdbU140VFO14eHOS53Nkb3fLkLMDczbbCSkzFD5kmwTN7ChHIwC8Bh9dGPxzQrc2XeFXMc9+npcKbDC1rPIjJN0ntEnLcTpeGOoYp2BKiLDQGs/fI=
X-MS-TrafficTypeDiagnostic: BN4PR15MB0532:
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;20:nadksW0znbvBE1s1bA7EWY+g/DpDqA5G0lIU5ZTQ1nAEGoG19kZu4BHKsQJxSpnNNQ60giQ30U1rh+POTJuiNe0NmdBl3teqYRUc4UN5p8YS2hD8vXtakZFt9qeQp2Sg883oRlJ7+qpzJ+fsg1GR3SCD0aCL0DSOiGMQQTsisPfG1pHiNMwB2wiUCOX+CaZHGZSyivpDO4IFxwj2iXV0H1isZ2z3bIEvYg23FRME36o50y6NtX2i70ku7t0BQ0p3ShwVBif3+kbbOmu6Cc2gggv2YQOAQgFjamNYBs6Pum0K6s+Qyp4rbTd68gDT/vHnS2B6zIbJHjEYFwrDECxgu1TDyMMm8FxtT+PGq1tjqICxaQ2rqEHxKmDb4Al9rcCejfYbesX1USy/OU3bbSukCn318+e/etpPsX8DWM11XNf02kXCTZMbzk5S5s/BNndwfY+4uGJYVlHkbR+h0aNLUsvWGSZnSO8cWoQje0VO20Kwov+MJT1F4jFrN5mX3KlJ;4:Y7dWK+Eegc4LmRWyjdT2GnYSlkPugpZGlTMksWvhfycy8SGKSwaR7Z/1XE00YYBPyh2BmNtzwCQ0muwAkF3prh3FPx6f2EXY47lo9D7TQH2J1hyacZ7WYSxGuZ4g4zMWpF2MG35GR+e7vFdUmBVLBJDv/3KqwSKUl4AIwOGYz7X0vc6PkxlkiFRE4W9EFDORjUXIRkACzTKzFk/hynhqSjlP/hrr3B3VSEMOKRVNSh6msk9WIZtDpQC7P5fz6lmNmxstaQUaQaRHbX4KF2oXrz8aHdI71bHRIVvgAOth6mpqASWTEMpcPZsxDzsgxBTq
X-Microsoft-Antispam-PRVS: <BN4PR15MB0532F9C639F989DBFBCD7A5CC7D40@BN4PR15MB0532.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(3231221)(11241501184)(944501244)(52105095)(10201501046)(6041310)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BN4PR15MB0532;BCL:0;PCL:0;RULEID:;SRVR:BN4PR15MB0532;
X-Forefront-PRVS: 06167FAD59
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(39380400002)(76104003)(199004)(189003)(305945005)(2486003)(1706002)(4326008)(7736002)(46003)(67846002)(65956001)(76176011)(53546011)(59450400001)(6116002)(52146003)(47776003)(386003)(2906002)(25786009)(36756003)(52116002)(52396003)(16526019)(105586002)(23676004)(316002)(54906003)(53936002)(65826007)(81166006)(97736004)(6486002)(68736007)(229853002)(81156014)(93886005)(86362001)(8936002)(6246003)(8676002)(106356001)(31696002)(478600001)(31686004)(6666003)(5660300001)(65806001)(64126003)(2950100002)(230700001)(110136005)(58126008)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN4PR15MB0532;H:[IPv6:2620:10d:c083:1309::19e];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjRQUjE1TUIwNTMyOzIzOjFSTWNKamdJUTJmbGhnbUJELy8rUXk3Y1RB?=
 =?utf-8?B?ZE0yQVVlTC9JMlo5RzlvNEh6MEQvbWNRUEVUTFRBNENlMTNvTlNObVIzR1lD?=
 =?utf-8?B?QmRhSUNwL2R1SUFnK0VCYzdEenR4OGdXcEpHM2JZRHNBN3kxTDkzZlZtMmhN?=
 =?utf-8?B?UWFadFVDcThiNXlrdkMzN1BrdUF3YUhMbzJySjVidXJXbStjU09SU0VHY3R4?=
 =?utf-8?B?aktqTk14QkpCS0FSY3FEa0VlNElWeXN0bUExR0Z2Skl2dGRmZVo3dmhOYWlp?=
 =?utf-8?B?bzAxQmd0YW9tOWE5SHRUQXFuaHJ0N1NxQWVIOGxrQ3c5ck1zbERzcFN3Rmw4?=
 =?utf-8?B?MXVoTWZIcEJzVDVUc1g3RHZPVGpZYlVZZGZuR3RzUmtFeENXbVNTUDdzblRt?=
 =?utf-8?B?cjZTTGY0OTBlR3prN0FZM3oza1dwdzVXQ0NLUHEvaUlmdGY1enZoZTgyTmN3?=
 =?utf-8?B?NkJJVmlORE9JdXVCNFpuajNoK01ObzVnanNUMDBHZHc0WUl1TU5NSXJaa0Mv?=
 =?utf-8?B?TndhRStPUHdsUmM5dDV0amVYbXFuWEZ6UWsyaGZsb1hHY3JPR3YrMFVxZHpI?=
 =?utf-8?B?WGppWE1uZUxwdXk2akZxNUsrV1d4K0tuYTdWOE1WamlYYlloeGt5bGFZeVR4?=
 =?utf-8?B?NTh0ODkxZ2s2OW0zUGVCY2Vtb2xqWGRoTzZqL2pqOGdYWVFaN3RNOFdmNUR1?=
 =?utf-8?B?M1daMjVlbXBxV0hCaXY3emZsT0UvZFhkaXhyQlVnajlFaFNBZzVEUjRtc1g4?=
 =?utf-8?B?WXV1dWc2ZHg2WVBhSStpQ0U1a1JRYTJsSStGVXFYQk1CQ0RhcVFpWi9HOXI1?=
 =?utf-8?B?aDRsM3NZRW95S0pPWWxuVzFSb0RwSjY2OHBrUVlnN0JLZWlSMGRrVUk2d29v?=
 =?utf-8?B?d0xzM3hwamNDUU80NFZpRUI4czc1M25DYllYSEs3QzRWMEQraVRCS2Urblh5?=
 =?utf-8?B?a2tUZzV1bG5mcUtqYVpQM1N5ckxOdFhjcTVkVFFoSWU5Vng5Nlgwb3Q3S2oy?=
 =?utf-8?B?aXN3MHNRNHZORk9wWGlndEUwb3JPdXQrUGVhV21hTmxDY08zd2F1Rm9IcmpR?=
 =?utf-8?B?aWRsK01ZdFRuQkVJSXgxZkkwRE1LZCtGY1o3cEZYRUpETzNuMlhGemV6a283?=
 =?utf-8?B?NXA2SFNQa1VWaWFjMFMvNkxTM3dJcWtYTklFNlhqM2dCVFV1eGZIRXdFSnoy?=
 =?utf-8?B?dVgxblU1aTBSb0ZmdXY2VlVEZ0d5T2h6TFZhbmtveDVGdElUQkVOMTFCTTNC?=
 =?utf-8?B?TEcrdEJvZitheklybFdMU2Vjc1d4WU1qTklsaXNnbXNCUHFKY0tBdy9nTTVl?=
 =?utf-8?B?Ly9OSkF4elZWVzI4U3JhS2FZUDIyLzlGWFhiNi9yYXZteGxiRlgrMGlnWHZ1?=
 =?utf-8?B?WlNNZ1I4QVFZYWxJZ3cyMEV1MVNYYjBXcVArZTZaM1hFU3VCM1hXYThlZ2hs?=
 =?utf-8?B?SzdyMk9EU0Y1QzM3aUQzSTRoMGRoYnVEU0pWZ0h6TForYWVhRDFiZ1NlTnZk?=
 =?utf-8?B?WXRBMXVNd1M4elJJNW5heEZybEtoZTQvR1JqaDYvdUM1ZXZEY2Nid292NXBa?=
 =?utf-8?B?bU5lNnF1akxpWUVRTDBjUE9MdUh4NVNWQ1BaQzhySnZWR1UxWXp1ZGtRMW91?=
 =?utf-8?B?VTZFNDF4T2poVmh1Tm1PYzJUWmxvY0QybGlaOWc2dkE4YjBJbkxHTUNwSmFT?=
 =?utf-8?B?RUcwSWRyNkh4RXozMGtvTE8rb09FU3FOYm5KeW12dFZCL2ZyOEtCWE1oM0VU?=
 =?utf-8?B?M0JPQzNLNFBlajNFcFljL2VQWVphY2E0ckUzRG82dFFyMDRKSFBHL0VLR2tQ?=
 =?utf-8?B?WnhCS015WjZuZTY4d3c5V0o3VEJDNVBFRDltZ2t6eWZiUmEyK2hTaCt0S01B?=
 =?utf-8?Q?c8Vr1RM34OU=3D?=
X-Microsoft-Antispam-Message-Info: zp2pWv5prDaQ/bF89o+XZxaBVsdD7cXq6aXjLQBmf6pnp5IlSbwjfHhVlTiCtNWHgE1Mxv3BBFdOke3OJ0UwYHVEPYYDXxYvlMr8GZj4td+JaGvntKQfjPA/nkK/vSFd9dfrj29k/Kw69WOayiEk/0XzlGG3BsQM4c4slLx1Ibpx35mNoE3IzroAJqN2QUej
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;6:vQyOK0yPxdLPXecJnmVXV/imWe1cByZfKncB/4uEGWaLdL8ZdkgMsCMNYSbsntLkw/NwtUDB7svsZ+jeC3QNQzF/sxGEf+lZOrLeiYH4VRSfuTsPv5YGzpY6UjPcGbEeaD0/FZtoh2aXcncu6wsHNxTWz3QeV113bwwE5Coy8XkofHq0urGCb3Zc0Og5SqILSWzvvSCrJqtgFaxZlcOHfkT4psCWM5VOoodfn+VD/wLyLqYjl9VQqQLWsPHsLf3I+jPJhyl5ler9aCBh0IvTjncw4eTGPSJw/H90RgYaortQdunVxVyJmgPYVMigujmwju9rqabCnQJtSQR9jIObhsExoULPqOij8Td5Zb5TFjs=;5:czWt+YgBDvSJvE0Yltbauw3bNmxIXiF5IV1naD+z/zXDpzF6t8mUzCCLL2qvqiJvf6manpNbh/T4XGiEVIhlQtZf3NKH4Z5HKms1GBo7fgJANxtoRMZHkUdwlMBeGhpaLfQBLw8gi3wsQoSLj/u9HPXN5L0J23qQrwEcfW5g5Zs=;24:jhDW1cvILLqf27haOVu8pAB/7s0Pl7MVdNRH97rCduIDcNlyD68DJ2EVCDOXUwpdqAuFJKYWM0ZnBLeeqsLhu2vUE5zM4KwKU3WrqVNKbcI=;7:4/DU7M4EK5Pi4uXtP79uceJXw9NJ2WTuhiFsSFj+d6qfkKF5F4FBxSH5HlkcpX1R6+WweaHl7QYXQOMk8ABnoLgbbHwfjifSuN1PGnyAogkeT/OV2uZNctCbHEAC9QQMW/XBgdKUgNog0ufjQz2sHjdI3IgACvylKcBMQkaVG47uSDo2ZcUmUJw8pI5Ac/SMSFCUwc4WGfVVIwgC0gWlfQ0PYz47eSSKq5OdVSbke2TC6xDZJHd4GzbHjLKVE7N5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN4PR15MB0532;20:MlcUf3SRoTv5/xFiDYs+jT1MgnqdOOz1VIpcP7JvuGAM3r7zWK4iVhITc1dfOJevTcbM/qc8621J4Mn8fhNoDZ2bMvauzHQGnPsbWpDVmPsk9k/qxrj2wppfphce/hMij5W4/HTSQgtI1LA5j6kNRv5W4MZLCMzG1sC3l/jVzTA=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2018 19:18:55.0912 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bae6bab0-2a1e-4367-5677-08d58dce42f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN4PR15MB0532
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/18/2018 07:13 PM, Andy Lutomirski wrote:
> On Sun, Mar 18, 2018 at 6:47 AM, Dominik Brodowski
> <linux@dominikbrodowski.net> wrote:
>> On Fri, Mar 16, 2018 at 03:55:04PM -0700, Howard McLauchlan wrote:
>>> On 03/13/2018 04:56 PM, Andy Lutomirski wrote:
>>>> On Tue, Mar 13, 2018 at 11:16 PM, Howard McLauchlan <hmclauchlan@fb.com> wrote:
>>>>> Error injection is a useful mechanism to fail arbitrary kernel
>>>>> functions. However, it is often hard to guarantee an error propagates
>>>>> appropriately to user space programs. By injecting into syscalls, we can
>>>>> return arbitrary values to user space directly; this increases
>>>>> flexibility and robustness in testing, allowing us to test user space
>>>>> error paths effectively.
>>>>
>>>> Temporary NAK IMO.  Specifically:
>>>>
>>>>> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
>>>>> index a78186d826d7..e8c6d63ace78 100644
>>>>> --- a/include/linux/syscalls.h
>>>>> +++ b/include/linux/syscalls.h
>>>>> @@ -191,6 +191,8 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
>>>>>
>>>>>  #define SYSCALL_DEFINE0(sname)                                 \
>>>>>         SYSCALL_METADATA(_##sname, 0);                          \
>>>>> +       asmlinkage long sys_##sname(void);                      \
>>>>> +       ALLOW_ERROR_INJECTION(sys_##sname, ERRNO);              \
>>>>
>>>> sys_xyz() is not just the syscall itself; it's also a helper that's
>>>> used for entirely silly reasons by various bits of kernel code for
>>>> quite a few syscalls.  Fortunately, Dominik has patches to fix that,
>>>> and Linus is even considering pulling them for 4.16.  This patch will
>>>> most likely conflict with the final result of Dominik's series.
>>>>
>>>> Can you and Dominik coordinate a bit to get this patch or its
>>>> equivalent landed on top of Dominik's work?  It might make sense for
>>>> Dominik to just add this patch to his series so it can land with the
>>>> rest of it.  Dominik, Ingo, what do you think?
>>>>
>>>> --Andy
>>>>
>>>
>>> Dominik,
>>>
>>> This patch applies cleanly on top of your patch series. Is there anything you'd need from me to get this in on top of your work?
>>
>> Howard,
>>
>> would this form part of the kernel<->userspace interface and therefore needs
>> to be kept stable? If so, this patch should wait until the arch-specific
>> syscall calling convention is agreed upon.
>>
>> Moreover, the patches I sent out already do not cover all syscalls yet.
>> Until all in-kernel users of sys_*() are gone (or at least outside arch/),
>> I'd prefer to postpone this patch.
>>
> 
> I was assuming that this ALLOW_ERROR_INJECTION thing is *not*
> considered stable ABI.  We should be free to change the way that the
> syscall entry code calls syscalls whenever we like.
> 
> If you want a stable syscall error injection mechanism, make it work
> like seccomp instead, please.
> 

This is not supposed to be considered stable. It's for debug purposes only and 
would normally be configured off.

Howard
