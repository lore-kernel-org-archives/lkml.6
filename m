Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3342454-1520557090-2-4906714906885611950
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
    t=1520557089; b=M5s3DpRfBNSa5d9rvQtkvz8myRKQrCSJHfmvjUD3e0S0jgt
    EaWDGxQvvby+2EK0h1rmOayj3iCh8xdpxudUX9KwKQlxxG5ywQU2h9/LSWi/YucI
    32iRYZkUqF8sfA4sw7SZg+o36AB43Sil2gXQY+PqAl9TRG3gPb0xnW8XP7IDcQFY
    +mB5CEdH+zbzWlXZPSyhD5+Uk8y6VCyH8U1a3TgLjX9EIwtMdpJKVEYfKgDeu3cf
    lqsEAc0JSnzNHcpEnZk2s1ERQmiRZizRGkmUApsvsfmd5g+a9q0JaF8zsm0suAVc
    LOJbv2Bh4xpzU7RBcqD1t+Jk3uWppVRSp8TbkiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520557089; bh=ugZBaYSP8fYDYODq+NiNF1Rd5wWEmZmsJB9SBjo3YC8=; b=t
    2u6teZC2KpP8ANNeGT4bNOv8iQC67/MhUrT3MSsMmDhPcSNOW5IchH5tRderXIRX
    5osf5Ea/FUqluYxg87QrUmg7Rd9l+/2I1To2OeRn1mdGcrimut2xzIiHe7/wxLFA
    Cf/AoEoh/WICS5lUu+V/0ExKzRP3P3VjS5A2pRJquc/NZ1UHBvo65AKqY1qAUFJV
    PgjeB/FKQon7kdUsm4G/jkYS+JXUTZj7ltZfcCRWdZYedzkXgRez1bi4TKoeaRCB
    2BmmRoojZeKMPf+XphUwMqJhoiKXcfpH/nmvCyoP89i2WhJBx3w0A5iqfM1Y15aX
    ap1lvfAUA6s1RSZmSvMDQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=N6oBGtAs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=B5aD2csJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=N6oBGtAs x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered; 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=B5aD2csJ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751173AbeCIA6G (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 19:58:06 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43788 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751146AbeCIA6D (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 8 Mar 2018 19:58:03 -0500
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Kees Cook <keescook@chromium.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20180306013457.1955486-1-ast@kernel.org>
 <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, <kernel-team@fb.com>,
        Linux API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <357c330f-0165-b7a4-7ecc-4cd797e61e15@fb.com>
Date: Thu, 8 Mar 2018 16:57:25 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+Q=S5sw9N5avyByxi2ekM6povT5Tajjhdb6D9g9ggKxQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:6b21]
X-ClientProxiedBy: CY4PR22CA0056.namprd22.prod.outlook.com
 (2603:10b6:903:ae::18) To DM6PR15MB2507.namprd15.prod.outlook.com
 (2603:10b6:5:8e::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 511ca2b4-2ec8-4d05-2ba1-08d58558bd07
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2507;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;3:jhQNfUlSeYMysmmUAZeHtnUo7OTpTuN0CbrJlU5UEgY3YZTGMkCuhEuZ6s9vZsoL9DCHnix/QdXpjFLM7ifum+n37vd50g9OvoNHhbSjtuhaRrkKVgDGZv0sPvjVnyW3IJUvTvmSkFhlFxllEBYsB/s0u/dNU6AFZKtd4S1+zNEQLqe3pfcWPtjaz1AQ2bzz/ppNqSJH/aOX4mN+SNqlf/L4Kk9S98Iv1x10VkzeBGYJawdUvUXvBeT4HH7cVuC1;25:4DQmYZgFsOZ/6A5dMuYshnFuQ7MQrzbPn3+iMw82RmHZO4SmLbikIXLZUri9u/3DIko+OtkKJXE/OquX/XTBKF9aNCwpr0RcB96Ua06kFDCLKNPFrpb4nydzFZeax+AJphoIB/k/JHwCm4QcAccQBCF9kJM1xIDtRqchuszT3F8Nbx573KQwDyl0ZBjtqhmfbTnvSq03kyrodcxz1ry6A+nnyYUhlMAEo5PH3cC2K+rAgw/FWrl77dHAtNeNG9Ql20BsqgIQcBvY7xEd4g8dN+l4WwbJ6MOhOKcTuHuleGi5GZmxmQF4HlHUvjHckXydcayZtrkzbyU2TSFYglrMDQ==;31:T7jYnT4tVymUxMNv2U/tUwZB7m0gw9WwsMIFThsaH04a2pZtG8IV6lxA5PNTirE48wI1e5ebFZp4YhKhZ+IvbuRQLXEM+tAP5bL0sJaylaFg/8rPkpqZnX4upBmmLF0/5AEXrg2O95u4apYygqQxF27GPX29eRdE9bKGwCtwyI4IJctd77OzeRoQ7C5g3vvhJWEuTZlbG9Whoh4F8FZO0gCHEYtoy356rDxtpXFv/9Q=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2507:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:yhTNetMsW1hhZvqz629BZwB4KyC+lOS9zhCT+C/rqSiP0wR8JZ4z7JWiQA9VCKSxbQ/5fp/GqbycvvtdvjiTpfxp/8yBdEOl8CR2qIm2y+UEspT0wNdMjEjNyEfDJqXg//T+4+5x9B+2ilLtqqaMxPZLpP2onRzJ0D8e+c7wIAruV8TcV4FMuZFSfv9+A6YcNf8YeelFavBQlhuNR0TMwZn9PXrXpS66zWSmfBetqe+Z0ukpMJFT0YbkmjB/D0rX51GCuRUi7XO3jinmbcpTokg/nJ474wJRIzQijnGQgurGuhJfwJcwGTpIScEtYSN1aR1XjbWik7Dc7hN8mACFY2wQ2EXX2Pp/dN9WZI7l8WQkQOmk+eUqT0z94gJ75mx8jf2Fo4/zPkV0gMuTGxo7fpDUlyQPRkXIzUJNLL+iOUZKOC+mooy9bRFgAOXtrNUOQBPq8y0DEYZCjazD2qqb0TyrznGRlVq28+0KKUFu3Rh96AwYy8fMDKK4fuUB0p0N;4:NgUyKFY+BFewhM0ohH0M79RneuGFZyB+MZ7wcsGYCoCVgv3pRdibHzTEjffZwaMmgxtUCq3BYTngSUXozC1znUkXl3+kgEKRNNIMHqBt9z3Ap+trcOWkM5qTfmTjtaYC4N4OQkBoZVB1bFU1Hu9nPOU2euAh6hlTDTSY9pUjsyq/ezTPCWftsFF7Up1MONfGz1wOgsbmB5Sivc5d7I9gLjMGVECtLj6hOdsXqAylSpZ/R7H/Wy9kFwg4mEZ3aUI/+nvrQOLHfFgaWBXKZDqGKw4nw3Fta78eJgQemDXRZIMMJOG+jOCCMe8UmD02M3oFegv1fguMoJF+pKmHowRESwM9mlUmiiyuEV+VlAs7v8w=
X-Microsoft-Antispam-PRVS: <DM6PR15MB2507C7D5521060E887DBBFF5D7DE0@DM6PR15MB2507.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(10436049006162)(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231220)(11241501184)(944501244)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:DM6PR15MB2507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2507;
X-Forefront-PRVS: 0606BBEB39
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39380400002)(376002)(396003)(366004)(346002)(39860400002)(199004)(189003)(6116002)(67846002)(1706002)(31686004)(7416002)(81156014)(6666003)(81166006)(58126008)(8936002)(97736004)(8676002)(2950100002)(31696002)(230700001)(54906003)(110136005)(68736007)(7736002)(65826007)(16526019)(186003)(5660300001)(106356001)(39060400002)(76176011)(52116002)(53546011)(478600001)(386003)(316002)(4326008)(46003)(59450400001)(65956001)(6246003)(50466002)(64126003)(25786009)(65806001)(105586002)(36756003)(305945005)(86362001)(966005)(47776003)(52396003)(53936002)(6306002)(229853002)(52146003)(23676004)(6486002)(2906002)(575784001)(2486003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2507;H:[IPv6:2620:10d:c081:1131::116e];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjE1TUIyNTA3OzIzOjRBNUgydDlNZ05FcXgzNGJibTNLWGhGVWRS?=
 =?utf-8?B?VjZUekFrYzE0RWY2Rmpoemw0ODluQXJ5VTV5dVBzRlFvdFZ6ZURjOWg0UERq?=
 =?utf-8?B?U1NaOEFCeXQwallCS0I3VE12eVJ3SG96TFRnOGhNUnNRaE42RjIvQ1FHazJ2?=
 =?utf-8?B?NzZPdSs0ZG1qUFp4ajVJUDBxQWk5TTJvd200My9sVlVLcDY2bzk5Tnpmdzln?=
 =?utf-8?B?MHZrY3VYRzN4R1VmMzZGRkNadWFKTVhOSWNnUTdTZVpCU0xaZld2R0YxQmpo?=
 =?utf-8?B?Yk5RVi8rZm9ETXNBWkFTTnhMU0M2K2hEekozSXZmT1I0MkY2MEt2V1RnQXo5?=
 =?utf-8?B?MmxOYVN3K1J1TmJrei9oV0h2QUJINkJ0OWtZbjI4dFNLaEh5eVkyVHljMVRC?=
 =?utf-8?B?NVRzRU9mS0hlZXdxRmVXUjlZclphVUtCc3FPVGJRa3hrSGU0NlJXSm9tVjZ1?=
 =?utf-8?B?VlNYSVExVjcrM2h1TXVlMjBKYmZUY3NPQUREdVRicFpFbERScUJaYktMS1Fl?=
 =?utf-8?B?U2IvQk9jK3ZpcGM0YmFPOUJNanZUSHEydGNObDVReEpoY3RPQ2tMdlRSRW0r?=
 =?utf-8?B?L2FVZ00yRzJGK0lHMnZZMmJXUmZjMDhBcWZ2RFpBSUNYazU3NWwzZ04vekdm?=
 =?utf-8?B?YUZ6b3dLUmV1bUZ1MGJIL24wVFg5aFBXOFZ6ZVgvQ2thbm9NL1dXZXJabHJ2?=
 =?utf-8?B?Si95OGIzQS8vV01uQmpUemQralJ6dXEvU0FSVjljVlF2cFpVSDFpY0Y4aFVB?=
 =?utf-8?B?T0lyRGpWMFNhUjk1QWdINXVSOGc5STZhRmdCWS9JckluNFA4aEVya0dvOWM1?=
 =?utf-8?B?VitFdjNCZC9OZ254cjFabU1jUGwvdllRTFRUVzV6UllSZlJiUm5vYzNJRWI2?=
 =?utf-8?B?Vm90VitieDFNUGlrNEhadzZmQkUwbC9USVI1RVEyZmNGNjUxMkxlcVQ5QXVN?=
 =?utf-8?B?UmUwWTRpcDJQeHNiaGlLYkdTZUgydnNURDFJVDZpcGpjSW1CS2EwSGJ5ZmlU?=
 =?utf-8?B?QmNaaGovR2ppd2lUN01ISEM1RDNlS2Y1V0ZMbXNxckRIUmJJNmh4SWhESmZO?=
 =?utf-8?B?MjFQUGFlV1pHKytMVzRBbmNsYkExRHoyUzhDTU9YZHBPWlFuczJ2RzN5ZkMz?=
 =?utf-8?B?TkkwSGd0cm5vM0lCOGEvY1Axdkl0M2EyNlo2anJoS2RNVjBwQ0orcWpMMjIw?=
 =?utf-8?B?UGM5Yk5jc2V1Z21kS0VRRGo1R1VxTnZUditLMVlpNmM4NVlNOVRJQUFOZVNm?=
 =?utf-8?B?bnVlQlI3bFo3T2hGMWVRSUhOUjhjZXNnS1V3SndOTGJsV1B2RmUwMXhkVWhQ?=
 =?utf-8?B?a3dMZlVEVEJQSVMvOWRCdm5FUDU5VmRhajU2Z2ttV3ZOSkw2cTg4MFdEZDFr?=
 =?utf-8?B?T0xvY0ltcFFUT2h4YkZTYVJOQjlxSDQzNXM2YzA0YmFKVEpxQWZsMnRqaVlF?=
 =?utf-8?B?UG1oNWJvQ0VsemVWUjVsaTVUVkNjUk9YL1N2TXJEdWJCbWwra0FCUjZqZUhj?=
 =?utf-8?B?NHppdGY2cXE0ZWlNWWE5U1ZWMDhQaXdMTEtVY2hVTzQ5bVl0VUI2dHh4TkVP?=
 =?utf-8?B?RGZ2QzdheTVqOHdXMVNXSWxWZlFSNDhZc014RHQ0SDlGVmduLzV1N1U2R0Rt?=
 =?utf-8?B?ZDJDdFQ5aEIzR1ozaE1pdy9LZklLWEVEUkNkYW9tOENYZUova1huT1UzeHlu?=
 =?utf-8?B?d0JFQkx6b29FT013d0tYaGJyRnBNcWphRTliZHlZbHEzd1ZaTnZCb21YM0tP?=
 =?utf-8?B?Q3cwanY4U3BMWU1lM09mb0ZxSURFY1VKMnAweVh4U29ncUdUYmNaMitFZW9o?=
 =?utf-8?B?ZjczNGtHcnlVYnpJU1JpUHEwS204RmE0d3hZeU1UUnl5WW9oc3NjcDYwWUxs?=
 =?utf-8?B?WTErUEVmS2F4aWo2Zi9MT2U4WE1MeTFYNFdPVUhwbUNnTkpoRldZUVZLZnJD?=
 =?utf-8?B?MDR6TlFab3lKak1DMlhxVkdYNGFoRkx6aXN4VDdzNTA5OHQySjNudmZYUHF2?=
 =?utf-8?Q?JeKOHH?=
X-Microsoft-Antispam-Message-Info: 5b2SNooTD37jAaof6cxukLcxJfMVPAzJuLiC8lC/32uy31SsWvN404/Tqv9KUceMFqbVpbOlpVJ49ls3tkHjdrGOvybIO5Z3uj6UPSEh1NfGNi7X6EIkH5vywCcO9AbABcwaaVjbbWzaMyrozKnkzlAchZ/uvsF6cfDgMnqMTaPt5yeDAxvhXrt11Dl5TOxX
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;6:fTnl5icFdgl8lXL3zPHZdperv3yTG/KQYH8J30KGgoJTgJr54stkdZR3KUsq5j5IUjza4wRUQERlKmvn857Wd8GA3tWIuGf+d0gygefRgxpoZdTOOpLnrR6hIguYkMQHNOfsnOsT40y0uugMdJcS/gjSai2saKDQu1QSexKmtFH5puhAx8qoUMrQGLuaG7HDNpj4Q4DQj0zPlFFgqomfYURu/RNKnMf+oDNOSLFID5LWYocf8rCSUANOmINSsxNQ1KU95lEMba8hthM6O1RKREY1ugeb16b0p/luC51xzN4oq6ObfnMmKwkq1bkpV1lJYc+KnX92BjzhRSkjtd7duEk5m6t8ixWWcIO7dOiwujI=;5:3Hy/9zEujgAspIRRKuNzyFqxlSlxvaOJ4fy7nTN5eHTWYky/6GOrnxBBG5awO1LuHr0NJb+qp18V6mGKKdwjfaf7BQSczCU3cdS2qWQE+B0s30meLhAA15ktUGkfSS8Ofkz+1SZBBD4a1hYStcouM7a/Jb6Z1xEonOjA7yKlTDw=;24:Zi2FP3+XN6jP20Nto1FZNtVjiji8Ka6TMeWm0MDILwwk69/NWrEKj60BAF0ifojygF381TXOWyJxuiGeMNrFjdmuI07Y5/9GapK2RRZcM+0=;7:sonJQwlRIjO/Nm2OsEro9m+WvuFk3/Pys5J/MZDS+IJgsyxaJzT9KB7cUv/b7G/GDZhRs61HYxykrKCPdnWH01L5tZAL3ZVn3qg0B4f0qOeku+EHqdtifEBw4qeWe3WykALVZtOE6GO411V98fntccDJK8CxWkMnE2W8eAr54/6bmto0BAB9e6rh/bDnV1oc5uMgQg1yWJiE5bm/5dSnZ3j37UcM86kMJokqpXQC+H0QN6f9bLA7WaY9IIb2LiMx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2507;20:l78U3q6UrQBw1Ujf2W5fM49WFcqiFEPXTSWpbJP6Zeyjx4HA9CezGyuO79b2ex2mNPB7B9f94cq9p54+6UIBk1yJmCoXXx1U6Rj+pMuCC7AXUSfrLc8T2GI+IYhKTteZm6a3hBmr1H+xpuX6QEPNAqtO2kjjgQ8kMFryMbugpwU=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2018 00:57:30.2148 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 511ca2b4-2ec8-4d05-2ba1-08d58558bd07
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2507
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_14:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/8/18 4:24 PM, Kees Cook wrote:
> How is this not marked [RFC]? :)
>
> On Mon, Mar 5, 2018 at 5:34 PM, Alexei Starovoitov <ast@kernel.org> wrote:
>> As the first step in development of bpfilter project [1] the request_module()
>> code is extended to allow user mode helpers to be invoked. Idea is that
>> user mode helpers are built as part of the kernel build and installed as
>> traditional kernel modules with .ko file extension into distro specified
>> location, such that from a distribution point of view, they are no different
>> than regular kernel modules. Thus, allow request_module() logic to load such
>> user mode helper (umh) modules via:
>>
>>   request_module("foo") ->
>>     call_umh("modprobe foo") ->
>>       sys_finit_module(FD of /lib/modules/.../foo.ko) ->
>>         call_umh(struct file)
>
> Yikes. This means autoloaded artbitrary exec() now, instead of
> autoloading just loading arbitrary modules? That seems extremely bad.
> This just extends all the problems we've had with defining security
> boundaries with modules out to umh too. I would need some major
> convincing that this can be made safe.
>
> It's easy for container to trigger arbitrary module loading, so if it
> can find/use a similar one of the bugs we've seen in the past to
> redirect the module loading we don't just get new module-created
> attack surface added to the kernel, but we again get arbitrary ELF
> running in the root ns (not in the container). And in the insane case
> of a container with CAP_SYS_MODULE, this is a trivial escape without
> even needing to build a special kernel module: the root ns, running
> with all privileges runs an arbitrary ELF.
>
> As it stands, I have to NAK this. At the very least, you need to solve
> the execution environment problems here: the ELF should run with no
> greater privileges than what loaded the module, and very importantly,
> must not be allowed to bypass these checks through autoloading. What
> _triggered_ the autoload must be the environment, not the "modprobe",
> since that's running with full privileges. Basically, we need to fix
> module autoloading first, or at least a significant subset of the
> problems: https://lkml.org/lkml/2017/11/27/754

The above are three paragraphs of security paranoia without single
concrete example of a security issue.

>> Such approach enables kernel to delegate functionality traditionally done
>> by kernel modules into user space processes (either root or !root) and
>> reduces security attack surface of such new code, meaning in case of
>> potential bugs only the umh would crash but not the kernel. Another
>> advantage coming with that would be that bpfilter.ko can be debugged and
>> tested out of user space as well (e.g. opening the possibility to run
>> all clang sanitizers, fuzzers or test suites for checking translation).
>> Also, such architecture makes the kernel/user boundary very precise:
>> control plane is done by the user space while data plane stays in the kernel.
>>
>> It's easy to distinguish "umh module" from traditional kernel module:
>>
>> $ readelf -h bld/net/bpfilter/bpfilter.ko|grep Type
>>   Type:                              EXEC (Executable file)
>
> As Andy asked earlier, why not DYN too to catch PIE executables? Seems
> like forcing the userspace helper to be non-PIE would defeat some of
> the userspace defenses in use in most distros.

because we don't add features without concrete users.

>> $ readelf -h bld/net/ipv4/netfilter/iptable_filter.ko |grep Type
>>   Type:                              REL (Relocatable file)
>>
>> Since umh can crash, can be oom-ed by the kernel, killed by admin,
>> the subsystem that uses them (like bpfilter) need to manage life
>> time of umh on its own, so module infra doesn't do any accounting
>> of them. They don't appear in "lsmod" and cannot be "rmmod".
>> Multiple request_module("umh") will load multiple umh.ko processes.
>>
>> Similar to kernel modules the kernel will be tainted if "umh module"
>> has invalid signature.
>>
>> [1] https://urldefense.proofpoint.com/v2/url?u=https-3A__lwn.net_Articles_747551_&d=DwIBaQ&c=5VD0RTtNlTh3ycd41b3MUw&r=i6WobKxbeG3slzHSIOxTVtYIJw7qjCE6S0spDTKL-J4&m=pMlEM-qKOmGljadUKAdwKBpuYHQRXzApvSGkZFIT4Gg&s=0-vP6LH-GxXnL7LuV-KfMl1NbqsVJUINSygoVa9R6nk&e=
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>  fs/exec.c               | 40 +++++++++++++++++++++++++++++++---------
>>  include/linux/binfmts.h |  1 +
>>  include/linux/umh.h     |  3 +++
>>  kernel/module.c         | 43 ++++++++++++++++++++++++++++++++++++++-----
>>  kernel/umh.c            | 24 +++++++++++++++++++++---
>>  5 files changed, 94 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 7eb8d21bcab9..0483c438de7d 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1691,14 +1691,13 @@ static int exec_binprm(struct linux_binprm *bprm)
>>  /*
>>   * sys_execve() executes a new program.
>>   */
>> -static int do_execveat_common(int fd, struct filename *filename,
>> -                             struct user_arg_ptr argv,
>> -                             struct user_arg_ptr envp,
>> -                             int flags)
>> +static int __do_execve_file(int fd, struct filename *filename,
>> +                           struct user_arg_ptr argv,
>> +                           struct user_arg_ptr envp,
>> +                           int flags, struct file *file)
>>  {
>>         char *pathbuf = NULL;
>>         struct linux_binprm *bprm;
>> -       struct file *file;
>>         struct files_struct *displaced;
>>         int retval;
>>
>> @@ -1737,7 +1736,8 @@ static int do_execveat_common(int fd, struct filename *filename,
>>         check_unsafe_exec(bprm);
>>         current->in_execve = 1;
>>
>> -       file = do_open_execat(fd, filename, flags);
>> +       if (!file)
>> +               file = do_open_execat(fd, filename, flags);
>>         retval = PTR_ERR(file);
>>         if (IS_ERR(file))
>>                 goto out_unmark;
>> @@ -1745,7 +1745,9 @@ static int do_execveat_common(int fd, struct filename *filename,
>>         sched_exec();
>>
>>         bprm->file = file;
>> -       if (fd == AT_FDCWD || filename->name[0] == '/') {
>> +       if (!filename) {
>> +               bprm->filename = "/dev/null";
>> +       } else if (fd == AT_FDCWD || filename->name[0] == '/') {
>>                 bprm->filename = filename->name;
>>         } else {
>>                 if (filename->name[0] == '\0')
>> @@ -1811,7 +1813,8 @@ static int do_execveat_common(int fd, struct filename *filename,
>>         task_numa_free(current);
>>         free_bprm(bprm);
>>         kfree(pathbuf);
>> -       putname(filename);
>> +       if (filename)
>> +               putname(filename);
>>         if (displaced)
>>                 put_files_struct(displaced);
>>         return retval;
>> @@ -1834,10 +1837,29 @@ static int do_execveat_common(int fd, struct filename *filename,
>>         if (displaced)
>>                 reset_files_struct(displaced);
>>  out_ret:
>> -       putname(filename);
>> +       if (filename)
>> +               putname(filename);
>>         return retval;
>>  }
>>
>> +static int do_execveat_common(int fd, struct filename *filename,
>> +                             struct user_arg_ptr argv,
>> +                             struct user_arg_ptr envp,
>> +                             int flags)
>> +{
>> +       struct file *file = NULL;
>> +
>> +       return __do_execve_file(fd, filename, argv, envp, flags, file);
>> +}
>> +
>> +int do_execve_file(struct file *file, void *__argv, void *__envp)
>> +{
>> +       struct user_arg_ptr argv = { .ptr.native = __argv };
>> +       struct user_arg_ptr envp = { .ptr.native = __envp };
>> +
>> +       return __do_execve_file(AT_FDCWD, NULL, argv, envp, 0, file);
>> +}
>
> The exec.c changes should be split into a separate patch. Something
> feels incorrectly refactored here, though. Passing all three of fd,
> filename, and file to __do_execve_file() seems wrong; perhaps the fd
> to file handling needs to happen externally in what you have here as
> do_execveat_common()? The resulting __do_execve_file() has repeated
> conditionals on filename... maybe what I object to is being able to
> pass a NULL filename at all. The filename can be (painfully)
> reconstructed from the struct file.

reconstruct the path and instantly introduce the race between execing
something by path vs prior check that it's actual elf of already
opened file ?!
excellent suggestion to improve security.

>> [...]
>> diff --git a/kernel/module.c b/kernel/module.c
>> index ad2d420024f6..6cfa35795741 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> [...]
>> @@ -3870,14 +3896,21 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
>>                       |MODULE_INIT_IGNORE_VERMAGIC))
>>                 return -EINVAL;
>>
>> -       err = kernel_read_file_from_fd(fd, &hdr, &size, INT_MAX,
>> -                                      READING_MODULE);
>> +       f = fdget(fd);
>> +       if (!f.file)
>> +               return -EBADF;
>> +
>> +       err = kernel_read_file(f.file, &hdr, &size, INT_MAX, READING_MODULE);
>
> For the LSM subsystem, I think this should also get it's own enum
> kernel_read_file_id. This is really no longer a kernel module...

at this point it's a _file_. It could have been text file just well.
If lsm is thinking that at this point kernel is processing
kernel module that lsm is badly broken.

>>         if (err)
>> -               return err;
>> +               goto out;
>>         info.hdr = hdr;
>>         info.len = size;
>> +       info.file = f.file;
>>
>> -       return load_module(&info, uargs, flags);
>> +       err = load_module(&info, uargs, flags);
>> +out:
>> +       fdput(f);
>> +       return err;
>>  }
>>
>>  static inline int within(unsigned long addr, void *start, unsigned long size)
>> diff --git a/kernel/umh.c b/kernel/umh.c
>> index 18e5fa4b0e71..4361c694bdb1 100644
>> --- a/kernel/umh.c
>> +++ b/kernel/umh.c
>> @@ -97,9 +97,13 @@ static int call_usermodehelper_exec_async(void *data)
>>
>>         commit_creds(new);
>>
>> -       retval = do_execve(getname_kernel(sub_info->path),
>> -                          (const char __user *const __user *)sub_info->argv,
>> -                          (const char __user *const __user *)sub_info->envp);
>> +       if (sub_info->file)
>> +               retval = do_execve_file(sub_info->file,
>> +                                       sub_info->argv, sub_info->envp);
>> +       else
>> +               retval = do_execve(getname_kernel(sub_info->path),
>> +                                  (const char __user *const __user *)sub_info->argv,
>> +                                  (const char __user *const __user *)sub_info->envp);
>>  out:
>>         sub_info->retval = retval;
>>         /*
>> @@ -393,6 +397,20 @@ struct subprocess_info *call_usermodehelper_setup(const char *path, char **argv,
>>  }
>>  EXPORT_SYMBOL(call_usermodehelper_setup);
>>
>> +struct subprocess_info *call_usermodehelper_setup_file(struct file *file)
>> +{
>> +       struct subprocess_info *sub_info;
>> +
>> +       sub_info = kzalloc(sizeof(struct subprocess_info), GFP_KERNEL);
>> +       if (!sub_info)
>> +               return NULL;
>> +
>> +       INIT_WORK(&sub_info->work, call_usermodehelper_exec_work);
>> +       sub_info->path = "/dev/null";
>> +       sub_info->file = file;
>
> This use of "/dev/null" here and in execve is just wrong. It _does_
> have a path and filename...

already answered that earlier in the thread.

