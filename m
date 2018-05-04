Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-753451-1525472356-2-16706456181760484769
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525472355; b=M0rVKTb9hrmyiyjlTXcBZKsTUSd4zvrwnV7+O7ExpHeyIdTwqB
    WVt6voQioM/dBaZKoQl2bIH5lhEgVN6oUJ5vbAjI/Sdt5VNVrrRU+Y2eJ2UoI3b/
    7dZqq3Gm561q/AEcluTy8/jBY3F32sRrgmPLWmGWNXr9EHuhDgRhRyhKh7vSGF0V
    NaZA3IU/Q3hFgtw3wHDSi+n1VwN/EaaaQf1bBSLWrG3Sj9N1D0GhBrkYizGeiNIq
    ZAoMwSzLhR4Q+2BKJ+4p6zydYHbche2dYnJJmmfscfYqfO2FC7jyYS/emnlJr7Cz
    nkRg5Wd3W4WAUFqKB1GRArivrCd+19GF9z3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525472355; bh=mYcD9nQ7XE
    VHAiSP81SQYSzwNGEuTlnTwW4jMQChuQI=; b=CTKkP1CMdy18GW3RCAHUA1gXK9
    1kqXqZ+vEVzh8Kafnw6Vfj9E+V71nCO+k/sW/syq+yw9bmeNspabda6+I0E7iti1
    CrUbiH1li04Fr63YblHE/n5/wuYYqwEkJoZMfwAIp62MOBmV8HQnRSf3FOGl4+8Y
    5XOKCIbSaV7pAOG8whDw7jDwpn5Qw3hsJCwSRiGcMqkpZWtG7hrKlV60oOe35i/9
    Hcd44PvFFvky7/34ZjXiK4kWe3I9LvScZYFDZt7KfC166ZUtQOEDTXqQM+lyZkn3
    IngkSJNL826/bt35aDaANcC3lpVceVnOMumZHLSSzK5a77rvD3Z/K/Xx7trw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=fb.com header.i=@fb.com header.b=ZI9tuh/d x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com
    header.b=bdtd/89t x-bits=1024 x-keytype=rsa x-algorithm=sha256
    x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=fb.com header.i=@fb.com header.b=ZI9tuh/d x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com
      header.b=bdtd/89t x-bits=1024 x-keytype=rsa x-algorithm=sha256
      x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJt7FfIDrm9S9UhGBsBf5/WYhugdK65rgCFsKZEaJodvq+RRRRzb/BLPlHj62tkHuC0uljQhfwP/htCYRT6vwpUGSqXpaUL46Y6JAGbRTC0sTAtxKSgU
    GmmH1y9GV1jkTHZ8zxD8zBQdx+TOZ6L6E+V7wDZiD+Wm6HV+B5wCXCVAsXq5gBBLd5L2VcSWP3YGJ0jbctXVCnpounyNwe4W5dBTwfGnfMQPteNP5bd9Ld8G
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=A7nYOoY3jUMA:10 a=a9PamwJlf2AA:10
    a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=VUJBJC2UJ8kA:10 a=jF-tZZ44EvIA:10
    a=VwQbUJbxAAAA:8 a=0OiwEhgjtLIEPDtG9t4A:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751747AbeEDWTO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 4 May 2018 18:19:14 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:38516 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751611AbeEDWTM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 4 May 2018 18:19:12 -0400
From: Ben Maurer <bmaurer@fb.com>
To: Joel Fernandes <joelaf@google.com>,
        Daniel Colascione <dancol@google.com>
CC: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Boqun Feng" <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Dave Watson" <davejwatson@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, Andrew Hunter <ahh@google.com>,
        "andi@firstfloor.org" <andi@firstfloor.org>,
        "cl@linux.com" <cl@linux.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "mtk.manpages@gmail.com" <mtk.manpages@gmail.com>,
        "longman@redhat.com" <longman@redhat.com>
Subject: Re: [RFC PATCH for 4.18 00/14] Restartable Sequences
Thread-Topic: [RFC PATCH for 4.18 00/14] Restartable Sequences
Thread-Index: AQHT4NTlyEPvZnNLQUycRSVAXgFaHKQb0K6AgADLxwCAAAFOAIABk5qAgAAKDYCAAAiQAIAAB8+AgAHZX6A=
Date: Fri, 4 May 2018 22:17:38 +0000
Message-ID: <BL0PR1501MB2067A0682D5D74E040ABC9AECF860@BL0PR1501MB2067.namprd15.prod.outlook.com>
References: <20180430224433.17407-1-mathieu.desnoyers@efficios.com>
 <CAKOZuesa338sc_=w6-wvro25idrSN_zx_zrHFyo-bDiORs7FZw@mail.gmail.com>
 <660904075.9201.1525276988842.JavaMail.zimbra@efficios.com>
 <CAKOZueu_7Ha_WXMyxqMEScXo1aHWr9qYRxqyb-Rpd4k1JP3xHA@mail.gmail.com>
 <1718748931.10084.1525363941807.JavaMail.zimbra@efficios.com>
 <CAJWu+opXjYrjrz1=k0TjjCqiYQ0y=6jRMiRWNvb8_dHAtSByug@mail.gmail.com>
 <CAKOZueve1K8bmS0pmeCAAburoJtzRA4DeN=OCyW3kHiNo8WO=A@mail.gmail.com>,<CAJWu+opkzpmwY5jJ0353JKyaOFCqa95AKGhxUdQZ6pZf_omsaQ@mail.gmail.com>
In-Reply-To: <CAJWu+opkzpmwY5jJ0353JKyaOFCqa95AKGhxUdQZ6pZf_omsaQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2620:10d:c090:180::1:6354]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR1501MB2163;7:37KJJqPDQywiKH0jlFmFPL+uI+r5/xOE8gfsSnxL/rrQefKPiQdrnvIEkzcpsqDhm1N8HfVKV6KdOL3PUzpfRUaSMN1iErHT+H8IkHL1PL9l05pkQL6h3PvzqhhhvhCrS3gjgUIuLdoPS/gPKrVG5nQGsYwdTXQ8lB7w+7asjLI7H3dMmBqARUm/2/4ygNJZ1SUQwf8At6Ba5ci2dADAsSMdtSyYwnW1yF14vQG98pjZMrsIpgXPY6870e0ob+OO;20:yjj25hEVCkijRWvwEkXreCB3GxSrPfUX6rqq/nWrnjPv4XO/408hxvogGMAjIDNTk+eCgtdDh9KnRC1W/jn0YI4x+3OMFCJxmE8+sQaWkji+CoMR/Zz6xu0KIPhvpqQ6/Eqf00w6WYMMsPa20Yf12tXMQXPLXr+hlNhVgyNMrls=
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL0PR1501MB2163;
x-ms-traffictypediagnostic: BL0PR1501MB2163:
x-microsoft-antispam-prvs: <BL0PR1501MB216307EB1A6EBE587D2178D9CF860@BL0PR1501MB2163.namprd15.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231254)(11241501184)(944501410)(52105095)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:BL0PR1501MB2163;BCL:0;PCL:0;RULEID:;SRVR:BL0PR1501MB2163;
x-forefront-prvs: 06628F7CA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(346002)(366004)(376002)(199004)(189003)(93886005)(46003)(97736004)(5250100002)(33656002)(9686003)(229853002)(53936002)(86362001)(81166006)(81156014)(2906002)(3280700002)(305945005)(8676002)(6116002)(6436002)(3660700001)(316002)(6246003)(74316002)(8936002)(7736002)(7416002)(54906003)(39060400002)(6506007)(110136005)(76176011)(7696005)(59450400001)(68736007)(2900100001)(4326008)(6346003)(5660300001)(446003)(25786009)(186003)(14454004)(476003)(102836004)(478600001)(99286004)(486006)(106356001)(55016002)(11346002)(105586002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR1501MB2163;H:BL0PR1501MB2067.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: zLkdwqQQZM7WGdt/5/bffcncEn1pTCUvbDx1JerA0J1C7hVzkFpo7j5670hY3CepiWwxvwRjmHKCNOGrhuwdUq4AJANGlBI8LZzJe0BzxGED+AsTMW9X6kv9fZBwhXQeKTFYFV7+JKuf/vKm5vbYddR66Fqos8QpOUCm2En1OxxT1mIHJZ/ZhJNSPYeoOSkk
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 0344dcfd-b213-403c-3772-08d5b20cd8ed
X-MS-Exchange-CrossTenant-Network-Message-Id: 0344dcfd-b213-403c-3772-08d5b20cd8ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2018 22:17:38.9538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR1501MB2163
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-04_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hey -

I think the ideas Daniel brings up here are interesting -- specifically the=
 notion that a thread could set a "pre-sleep wish" to signal it's sleeping.=
 As this conversation shows I think there's a fair bit of depth to that. Fo=
r example, the FUTEX_LOCK is an alternative approach. Another idea might be=
 using the "currently running cpu" area of rseq to tell if the process in q=
uestion was sleeping (assuming that the kernel would be modified to set thi=
s to -1 every time a process was unscheduled)

The idea discussed here seems orthogonal to the core thesis of rseq. I'm wo=
ndering if we can focus on getting rseq in, maybe with a eye for making sur=
e this use case could be handled long term. My sense is that this is possib=
le. We could use the flags setting in the per-thread rseq area, or maybe ex=
tend the meaning of the structure rseq_cs points to to signal that there wa=
s information about how to signal the sleeping of the current process. It s=
eems to me this would be a natural way to add the functionality Daniel talk=
s about if desired in the future.

Daniel - do you think there's anything we should do in the patch set today =
that would make it easier to implement your idea in the future without expa=
nding the scope of the patch today. i.e. is there anything else we need to =
do to lay the framework for your idea.

I'd really love to see us get this patch in. There's a whole host of primit=
ives this unlocks (more efficient RCU, better malloc implementations, fast =
reader-writer locks). I'm sure we'll have more ideas about APIs to provide =
once we've explored these use cases, but to me this patch is the MVP we nee=
d to ship to get that feedback. It's a solid framework that we can build up=
on, eg with the "opv" syscall or the idea in this thread if user feedback s=
hows those things are necessary.

-b=
