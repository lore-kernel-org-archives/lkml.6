Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1193642-1524683820-2-2853477077197378451
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524683820; b=Xf/AzUsOikLm0vKukCbCwTLZtxtLTnyM5Pic20yVQKSY9bxbJT
    MHX/OhGdMaj8C4mcMD8Akd0KJaLHl/8aI5xLY+j3XUrCJJIjMIHjY0CbcvNu+vWY
    jQYUz9M/BjD4bjevdLlGeoabcOI3Z6v7dsdbjMxdLhTXWVzwNEgKGghYZZbD1Qjx
    ajLSPGvT9EVrnW2fT7bwl5jRfVPbPBJW/CxBPYTtTR746z2v3bq0QkDsolfiW3dH
    zHxOWFvAaBhlCBDTuzImxwNRzYCSmUv9yQx/456v552M9+FLg5aWcnbn9+V6rRaR
    FUG4lgELzQb6HonoTRo3JmfRj+EEc6457fiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :mime-version:content-type:sender:list-id; s=fm2; t=1524683820;
    bh=4utuMWyJbB2r/kX/FUxXr0319eQJ+H2wWH20/6IQ5dY=; b=HhzmAFM6+ji3
    VZS0vnsuxClK6Z2EcTS3z96MIB3kvqGQ0Bk4YruG83Hcsz5OBNGwBHSBkmztYTWi
    gw+wG56hR8ZFPl1me1c06d6091d65Jj87dNEwe8sktTOpIPPEhNjSz/gRFkFMlrQ
    Wbh2/7rmKwEyxa1sGr9JDKhkMif25Om8Eyi2ERVlJZA3S6YrZfLMqlxvcbXftBJ0
    PW2Fvp0ue9ioDE2goPZ0xYmajtfpb1AFNCN4/BCuKFUnCUuxwFa+zb0oFUQx8P+n
    6j+0CSfcFzbdQc9m68+MDQ+g01JF0vL0BxuN/e1dZdQ6mQCsDcnf+G1ptEQDh/2F
    JHXOlrhchA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=n+aMeBVy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=BpLt1dhH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=n+aMeBVy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=BpLt1dhH x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEIgYctILLcOYG1cusdg0wKenLorxO/EYB86kJCPPDB1v3s8+h9Chse63NaJteDKmiJmWbhfFI5nEV+LhcU9Du4hdMGr6mWbrZz+dYVNd6viSZyjgC/Z
    sgmm+qoSahT5Nkc8AOfke1px6ByMc0uxnqQoze5OXzMzleCI1mYgmM6YU3fJsBWxq2+ehS3B+uBHRFzD9uvezkSto9Lr6ou2lMTdFMQSswCEXQssRBgK2HWi
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=6PX_JS4CJgQA:10 a=Kd1tUaAdevIA:10
    a=jF-tZZ44EvIA:10 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=JlZ1DG4ZL8MLX1j9PUMA:9 a=hfvRhHhnz3ozeIIZ:21 a=Qq_d0xE4D6alMSo5:21
    a=x8gzFH9gYPwA:10 a=i3VuKzQdj-NEYjvDI-p3:22 a=1CNFftbPRP8L7MoqJWF3:22
    a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756316AbeDYTQZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 15:16:25 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:50142 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751809AbeDYTP6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 15:15:58 -0400
From: Roman Gushchin <guro@fb.com>
To: <linux-mm@kvack.org>
CC: <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <kernel-team@fb.com>, Roman Gushchin <guro@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
Date: Wed, 25 Apr 2018 20:14:22 +0100
Message-ID: <20180425191422.9159-1-guro@fb.com>
X-Mailer: git-send-email 2.14.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2620:10d:c092:180::1:129]
X-ClientProxiedBy: AM5P190CA0008.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::21) To BL2PR15MB1075.namprd15.prod.outlook.com
 (2603:10b6:201:17::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BL2PR15MB1075;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;3:VicIybXSxGiTnHuY1mx3pNtgWqjuRh3C7WA6UArVTJ4Dha0Ee8SDPHa0Wc8aiUKsEyaaUuu/Hv44233YGheZ7x0BF9+udn337ib4VhKZp00yGcW4m0Y/2vVG5uVnVl/LaiuckA2xJzeEAxzLX4z9etxG1lcLahY9HWobxdM9qnzAYxE6VUN9Xv0qk1C081uHRAl44kjMj1iondRdjGOq+jPTjoGN0aElW6J9LkcxGx4I7W3BlrqVEsFvbwH+YSAg;25:4twOvYt/LlCnd/7dX14xab8ZrHy8vNfSRBpNcQ0D74jc/ZrwAoCs6aB/OaDa0afoAL5YwoT+WDKqM+jZdnl4KiuTvS0PcE9aEyZVbb3Eh4Nig576EhyGRrfYp58akxYz1e8F1xkoIGwC8Ud9JsimqAv3XTBjUhFFtanR5dtKOeBv/b8d6lmzxtGE7kV7EC6nxI4m2tHzyk65b1sskxfZLbvgTonUg5U6sMyyzCEU8l7PRh2CIE545S4xXXQe6D+pNQ24wTKgpoqUo3t1CfGKXW419cIqYvUVj0TISLmIRfdwlPDTioOUAjLeWeEBqzZPHkcL0STlx9P8v/OWBH4fPQ==;31:h9AClhXciRGqcqefjAN4jZarCnCe7E0ZuCQr0d+Wipm1Ap+38QM2MvzAcqqWaVPBygdbX+i5Md9UCaIrzQXfPqoUJtibKd09elDmWrfV22HEu2SXwLPctr1iut1WWY4i+CAHzbcKuh4+lHAn7obXuqPFLFILzyx70uCavfmXUHJgX51e0/jWOmvbskGzHJQGAQ8pufvc9UxQhYCcskPRoBeNNZmvksXmoionCB/HH2U=
X-MS-TrafficTypeDiagnostic: BL2PR15MB1075:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;20:rItsxWUk1QKWsVL6zB7KvCFiSCki9w34v623+n+eqQ07JN13Ea2CUGAdo7eMcRADmDiUwS+B3bnRAt3qXKU0t3DjCeeSdg17l60cpkw/Vc2sJ7eFGhpgTkAKKYW7+Np0tb/VQxWuS++81CgrBk9FtlmV68s4DPto8GvUVPHHrEByxbl3ZvnzOTuqmM/sTMEsO582PFOAXDsmPR/ClBBgD3jP9jb5KexUC73KEXKq/MN+ekK96GN5BFa/YNY7TcDTXnWU2lWkfvo4oW1Tsfk22vtV548x8EW+vfIWu7F0ntR5JHQ2dzTQh71CoNDs8FXaXGDc1bWJ+qXhwugYt3D0ej9VKf6CA3S6OknwdqNWVwF1h6hySLCxvzt2K6YNA3G36liU61XEdWNaW+z6Y807GVfR1Y399Bg1vgJiRvtE/RCWUtOCEZCGPGWkcVIXd4iKK/sh9sI4UnFKT0Gh04k/vcVY6zmqn22ikO/lSkrZCAdhVE4sfb142VAwLAVbeh0n;4:O7fc5Dj8mQkJqQIiU66Dlredg6hmOpoI5hpoeLWjq9jcDtee51b6q1gffCrv9nto/riNK+SPcIqwgRunoV/9CvViCavSvJ6JUWZvPc1kazSLqbbAVn0a75AN0Ke9z+2Hm11ziSNtCyoHW2pe1mercf5oZhpOlCiwe2T4q+1T2H8+5rng/w/nU+o+l2KLduFjcFyd71eizWYvOCq2FhV2UATMxB9fXUvlea9onMez42PZ0jEzzscS+9ENdQaJpSBz0e7LmYuU2Oy6P6tW0HsNAWl6qkpRd8KmK+kXFYHmleH/RY0EZWL9mfwRgpivZ4l2
X-Microsoft-Antispam-PRVS: <BL2PR15MB1075C0233BBBCBE680FDA452BE8F0@BL2PR15MB1075.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:BL2PR15MB1075;BCL:0;PCL:0;RULEID:;SRVR:BL2PR15MB1075;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(366004)(39860400002)(346002)(376002)(199004)(189003)(7736002)(305945005)(6486002)(6916009)(69596002)(2351001)(6666003)(4326008)(8676002)(476003)(2616005)(50226002)(81166006)(8936002)(81156014)(486006)(86362001)(2361001)(68736007)(106356001)(6512007)(48376002)(54906003)(316002)(59450400001)(25786009)(105586002)(6506007)(1076002)(386003)(53416004)(16586007)(53936002)(52396003)(52116002)(51416003)(47776003)(46003)(478600001)(186003)(50466002)(1857600001)(97736004)(36756003)(2906002)(5660300001)(6116002)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL2PR15MB1075;H:castle.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR15MB1075;23:8YuIovartQqJt2Wz3wIiIR6sSZbBgpV0kihOgpdFQ?=
 =?us-ascii?Q?R2Rf2HrH3uhBOyU36kB3/nq1z535zrNPaodc+OBlb2BKearXMYEXfszxKHWE?=
 =?us-ascii?Q?8tAPfcWY8k6r+/osOSTpbZigwR4pxwonhlMl5h51dn8LdKnsYOhHG/n02/DQ?=
 =?us-ascii?Q?eRQoPhOi/nPo9hRaRwjvPDk/CFjVZNhUT3aT7a3ZV88y3oNYZo3Xz921YGTj?=
 =?us-ascii?Q?FUqwkM5wcX4r7C5kgXM9tb7zc7osxkbps+Tc14WokP4D/92WjHNsQdiPbbZh?=
 =?us-ascii?Q?u2t/uh47ipGgaB4X5NHUqBBqoFcQSxgcJnaLV9UMG0VF/bGBlYqj2PzkiS5v?=
 =?us-ascii?Q?zLmA/UR0twSMuSUxwilGQoobSTCnJw71lydLPvpgKqPE9SokzwjVLY60Ietl?=
 =?us-ascii?Q?bbPEShKm2wmsR5c8+uBihJAgqVd2GbGthrjP/rla7BjOLjzJR/2V3ABp9wQr?=
 =?us-ascii?Q?10pt39ffyAESOlMFGwvkmeZkky4dPjgBmusi1CjA6fe1X5pT12kREpdVPYfQ?=
 =?us-ascii?Q?rE741ET7BjE69LTOvlLUul5LTTwLYpxl6jZ8TwB6L0CFEb30+tI/14Pc4LTb?=
 =?us-ascii?Q?OVA8KXpQVyXkSm5VG8YOOCvR/BUuUCI8EFkzS6M6vMNxlJ+rzM1s863Enaqh?=
 =?us-ascii?Q?cfBrFwf+4XmHNRaPCivI2QNHqDQwQ0PsKmIyHzBvVTmOckavgOlnuz4r6HL2?=
 =?us-ascii?Q?cXososG49K6z0DevhctAbhXuoWLQh0yGbP4q2Ydwiu6lRlBmRTyslsli65Qw?=
 =?us-ascii?Q?cdtQenotB6pkfSi+0pKyw1vgtXQ+g2uCFYCfPCo1anoXVXhL+SysEhnO3VMH?=
 =?us-ascii?Q?3kSLZ8z2XPG3cyz18gQOU28pistlqw7Dwr2i0bBX8QYoCtbWNvv6S2tYGkZU?=
 =?us-ascii?Q?bAC1lRodMMYGHRQEsG9MAU39M6THwBMxm1N+WvgCr/pL2ImU76WfeldmmbwV?=
 =?us-ascii?Q?gYJddg3IUNK/O0n2eYcaE36A79fqJ9IYLGueil+qH0STS350DeafpJNJw+o+?=
 =?us-ascii?Q?jWp+Ly373O0asdjTICx0cdYzoSA0qDPBESMTzRjivtyqv1FY1yiRkmr/B8wd?=
 =?us-ascii?Q?7rf3H6sP/o+Yw7iv5QdQmLimigwEs9QxhbiLqP+RdF6B1DuIeI/K0DH2TZeQ?=
 =?us-ascii?Q?rTi7WrsaqEmFXCQehdRivwgz66xMULO0cb7eIWi9t7ry8PN0ii8dt9VEGGtV?=
 =?us-ascii?Q?6ebY3IEjyDUk31ltOObrPAuAeDpHvSNIhJzqHpp2BjbGV6J/cTLeqOgp975v?=
 =?us-ascii?Q?4fls3HuwezD1wZSrShmo1TcJrA50JEHWPEGCeJe?=
X-Microsoft-Antispam-Message-Info: QZdY/5esdUAzNJ0mko+9dXbTk4eP55hOnxUn+uZdBmaPxU1BFu8ORreM9STEqQ5FIDEurapjbp61iUG3cL72p0ZhM+kkNQ7IgXTO+9KtQrJUqpV5bQRb4z5cjFSyRQPXYJWcBMO6j1juo+DQLFAuRwu2IDBJ1sAk5nkqj+wABbJFtf7HAJi8JbqRR40YwqtB
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;6:80rG1jnxjbWj26Mo8TmAh3yvoLU/KADw5K6oS/7MTidFUlZ+R4okSJAx2BGhCKrN+a94Hnqnq6v1tDgw+zKMKvAgSjzOZet7a2ZHrATZh0IO8WiNXk1DJt96dlr7i0eybRWwMUnQtEQdty5m70szcn/TDx/DTSvMyeeZrxozoumUuxXHCDpuQ6re/XqBQy5+Eo6NDqXNGws3aoVv+hMSgVPid382ECz1pOh/83GUBp2mbfEhFisILpT93dlQ048Uu0GumQ4sRIPYjsT0o9rteZIjUstcfH6EKKrhskTP9m3BD68ZWIATIriQSjC/oMGyH+RiYbTx1ok3W3n1CeCusPVXo8A1U4CYnw500hVUgmmX0G9oH9qfCzNxhqFt84+qvIfl1SoSTCSb47DwsnuqZtbjciUNhxeUlEB8rGPUaVP7C6sMfzd9+YeszPFF4h8pVXYSXKmcQZ6bqJ8e1koQsQ==;5:PhiWydO8ggp3ZccyIZtf3J5Xdi1O/YXoqCabL/1epH/VYFaC/fGry3g9KVp2oml7yVfkNKYAhqzwWK6abBBbGvOL1REArJujUFFcaY4AQ0eZhqykvUfBvn7h5DNW1EoWyF6lQf6MVEr9/HIRp4x788fzye24hGmwd5s8vs2PEpI=;24:vMIteaDm7iNcY5hPAvCPWgyZ4aROey6il9y2DMZiWxYIo8Ttfc+FD8PKETC6DZfoZPH6x1IR9jjYHQCR0WUA96MJZ0KZw/kbwUuBGdUtd3w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BL2PR15MB1075;7:9S3KUiQCFUM2lRECSTy8BDtHtBO87OSgz8YvzvqpZsS1ZkleKSV+T7CnLdpkG/QQkK//xfqWzJDrPmD61LOmpPhTOCsU1yJZjUCaZraPaYu4hKyLDvglwZ6ijnuY7FNA7DvQsbXeIbZQXqojVUddwWSOe5JuCk5DA9jOfYLWZQA48CDvRBF5S/Oosk6FUqPUSzJ2j1Tl2ZepoxmzyHg4ZScJ5LIHPWIZT2nCt+Je4us3iiNQcjWfkAADZ52XdA/R;20:ykKCCIpxQ0RUTat0JlveCRJfbEr3GjHuuUY6r1tM0rlMNT+BhyIQxqgJwFTxXy5XJNGEupNITXQstvV69XGQO3QkWgNE3tHIlH6akzJ5u8nRSIhXxNKqtqyRAHaRroGUuCOEB95jjsIVkK2VIAxUyb9k0H64LX/4awGfs82Hjk8=
X-MS-Office365-Filtering-Correlation-Id: 48403774-4b38-42e7-bdb7-08d5aae0df87
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 19:15:12.6271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48403774-4b38-42e7-bdb7-08d5aae0df87
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR15MB1075
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Don't show nr_indirectly_reclaimable in /proc/vmstat,
because there is no need in exporting this vm counter
to the userspace, and some changes are expected
in reclaimable object accounting, which can alter
this counter.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmstat.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/vmstat.c b/mm/vmstat.c
index 536332e988b8..a2b9518980ce 100644
--- a/mm/vmstat.c
+++ b/mm/vmstat.c
@@ -1161,7 +1161,7 @@ const char * const vmstat_text[] = {
 	"nr_vmscan_immediate_reclaim",
 	"nr_dirtied",
 	"nr_written",
-	"nr_indirectly_reclaimable",
+	"", /* nr_indirectly_reclaimable */
 
 	/* enum writeback_stat_item counters */
 	"nr_dirty_threshold",
@@ -1740,6 +1740,10 @@ static int vmstat_show(struct seq_file *m, void *arg)
 	unsigned long *l = arg;
 	unsigned long off = l - (unsigned long *)m->private;
 
+	/* Skip hidden vmstat items. */
+	if (*vmstat_text[off] == '\0')
+		return 0;
+
 	seq_puts(m, vmstat_text[off]);
 	seq_put_decimal_ull(m, " ", *l);
 	seq_putc(m, '\n');
-- 
2.14.3

