Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1207910-1523545063-2-15992406614738360878
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523545063; b=Se+/dgkePgvQdjRzUzvp7EsGqix0wNMIBjkUyBap5/ojEk9/tl
    zftSWTnxYUqgUQ8OSw9Vn5hP6MYDG9vgfDfNshq2/oiDfoiOazSH4iZcDGf9ZFwI
    V74Yd1jxq4g3IYTZz38WYA1v4k5HSwt5ZcVHZ+MV7efVpRXNOGDrB6MhgInbrfxc
    nxRHYxHKyAyX2L8TaJZ7+EckHk037fFkBPPkJ0OR4ofGc8ColobltUC2zZ1FM2MO
    jdDwCr9MHd9ZqhtxxVd0knT5gvIkVp21R9YlT4UgWHRj8T9KHu+lx3APKzt6RBkX
    vhvsIsTyMeLjPoleyFCP0ao877UC8gvhjDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523545063; bh=5tZgE9z/fiTx0xR/7DJhRlg1RED9GX
    76WT0014ZuXX0=; b=PBDjftDa2ZwwKR48sQaXFrKpCZJA7NrxwUnxhq6PpXhLcH
    EDrI4PQ1ATinRw5YJ9S5bc49T2q3VH1jLOAptltGEaK1gZVcNFAuoAreP2kdvbAS
    8leeNAhpwbApYvtznocvQsU963lRrSbFBwXJE7A6E1ZvpTeda0rivioVirdjPb/4
    wbmfu/7TZsWLOR35Ijwa2gFPEqJUno98jQdFtyBBau5hBkjkNVgPh5kZL2YhXr7c
    m9AatZBuVqFMNs16ihg92oMVhp64SYqSG1re9jBvHXffbBdA+CYlvzKzhO4GWkbZ
    GPcpzSOPwzzk3lSvbvxivVpzO05pR1FSPILeMpmw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=a+R+Ii98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KBHl6Yx6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=a+R+Ii98 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=KBHl6Yx6 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfF5mx0dFWNWVsFtpK70miXm4+l1yLaKts4SXjROmbvbXeFxD/yWb+K2m2e/w7TUxoLuoI+0Ql4CgXTpt2Hl2uhCZbNwemrlahyAienCMtjx/xx6IDWSk
    FX9UgSrYXoaVTeZv1FE9n3gbU+n17OabWql5IBRfNa3OU/PQFBkZAZbLRHytonkFiB6eRR0q67FcV/GL7L1LvFMy7x8vYX2WEe/eQXMGdUqO3OmUNnUWD/Y0
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=FOH2dFAWAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=37rDS-QxAAAA:8 a=3qBih6mwe9oNQD_dgKoA:9 a=DweWrRlQ3LLOBRXL:21
    a=gRCXbfZS4UZiUYEM:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752870AbeDLO5k (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:57:40 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35696 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752824AbeDLO5i (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 10:57:38 -0400
Date: Thu, 12 Apr 2018 15:57:03 +0100
From: Roman Gushchin <guro@fb.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180412145702.GB30714@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:978a]
X-ClientProxiedBy: DB6PR04CA0019.eurprd04.prod.outlook.com (2603:10a6:6::32)
 To CO1PR15MB1077.namprd15.prod.outlook.com (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:ImpfKmDQt/2WhCnPYUDUXbsfZe7hn1OdOEIc0bfLsDNFUglnxRBxks/fD34piW7nnQppzQQ53YkT54Ut/PyxldOFb6I4xHpC+Wsz77Yy2VzJVmUX3fu2+t9vOIjgRb/YEhKlPmGxNMig5WC/Ox274F6wy1RtOlR29MtDfeiWr+6k7hcEso+TEKIB1+XdOBVhlAALNDT+F8s0O6ABkndQ4rsy+GExXZIrf705Lt1Uy0117IdYQn6qCCf+8nVQb0OQ;25:UR8G4ewYxm+CriIXpahocO1Q2E5chTzfySM67G7wSgTYYjh6wwRzl0gN7dIkQdQggAtj1oLRofqkxZW5iBRdVDE1BQ/xqwYSPWTbeDGeFarMPfDmAVUk8piUZ/7xibfdBj3XAbfK9ciHunre4zN7bptokQEBCCx08WG/99KucDlwgY/r4KHAk3axjiYpzxfkUMcwheosvdu53HV/xqGa3lFtchz8qe2LE4twhNoLoSUzpLp22RRcH3/P3j+Jgr1q4bD2HhIplAEyBDIkKsq4YN/kv+bgm6BeAsTqx/eCdKvhr/4fBgdgwL3SlHTcEBrvGfVBwYlf+dukarbFhVLUmQ==;31:9onyd0/QfR0+VxXK/CXTqWtwrZDEVEex2hk1gh0+2mUYdQTxqYIQAukyIwcn8tbW/a3McIUzzdie92iUQOREz/4RgoMTbJEFOIukVdYt15Al6qGY+X89rmTV6D5FpkI0N+uQCx5Patkw7ZbctWF7QpvSPdPGfLCPdJNb3GGbBvhp3EYdNAOCMu/IXw6HtGeAdPXiRFxmy2EXYnS3ZaDI3CZMqWvc9DuGi3rmjxr1ccE=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:xrLu2oBi1z2PfYJRLQoAT4lTugXCZOC49uY17O/UQj5wWoxbh1GMFLqznZFQQJlljD7XG9NpLqLfjWoEIXcIJxFeNzg3MlqjRZd+VapWti4563/KBB8veenXFeh1HugC8uy2rW6FWfovw3dl+rLxRONFRyjjjLZnYbp870V464u4CHQyPi2E4tjRoyxAabDZG3c5j17W2N9P7uppluUvjq+hs+b53/iLRzzXPRH4rouzYRCNG8DkKMtKTS3T2lS5bKxNv6gXUqYnl75GfuNKEkapAgSjBHfkgDnue00rIl2N2l5ERI0gmCUkjWaRrEVfm+sI274w15uZYc1gJUsQYzF6+QZsGbw0TTog8KONpHK+nHtYAdJsmlqdalJfSlhHMlgMAQXMG5oZPvwfi5zBeKSUbPRMlJjKozo/DZH19bbdlw2EpYzh9UCjAZugITMAVi4weVPmhCN4yfjZ+ULg7FK/nq77MCP72F7bD9t5nNALKlofJE5KUWzQcywjCYYJ;4:zzO1muHtgme7WhtJid1sAkGPfg56GhKz48x91QV5holW2ipWpAf1jbGeaXkjGFuh74Dlb5RKZlUPLhnF6of1kISmLLZntX9ZzZEgD01TcKIF1duDILPkf8R+rrK3aZXKrFKx+V8NabKkNsi4Rv9IYmDBa7nRmFViqksX1a8X6LmFZhmLyXmnyDX8dSVjyPkBIbijMfXEw9Cj0uc/oZwflkVus8LI8n6bCPylYx4tQ87kwAAjzeECjnVBHprzSZVUmpHkLdsawGHw/xsF+brUyz9qbhVkj4PM19Qfmue1STvGWEyOTWvEUgzcMnMZ8YnEG5RSQh5J0diIGlbVH4yWdmGz3BYr3TxqyvZqW2T29gU=
X-Microsoft-Antispam-PRVS: <CO1PR15MB1077DDEE2024F349DAD0DDA8BEBC0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(39380400002)(396003)(51444003)(199004)(189003)(316002)(59450400001)(97736004)(186003)(16526019)(478600001)(81156014)(81166006)(93886005)(52116002)(386003)(52396003)(86362001)(7696005)(25786009)(8936002)(6506007)(6666003)(6916009)(8676002)(23726003)(1076002)(229853002)(16586007)(476003)(7736002)(6116002)(58126008)(4326008)(76176011)(47776003)(53546011)(2906002)(11346002)(68736007)(106356001)(105586002)(446003)(6246003)(5660300001)(33656002)(55016002)(9686003)(305945005)(53936002)(54906003)(46003)(486006)(50466002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:NnRCmiQC3eHcjNZI7f7MlTyG6o3/NuHXUDTx6c5Uv?=
 =?us-ascii?Q?r6Ig0RnQ11VxLmDP5VSX1GdMF0vL78xCx0aQKdbM0Ctyc3ph76OFoEpOCfWh?=
 =?us-ascii?Q?it32fyMjH4GTNKI0VDuOyvF2zuxllPrSd+Q6x1pYYVIlGNMmUk57NSwhr8Yy?=
 =?us-ascii?Q?yJA8R4zlnUe/l3RYn22ftwpRxmiywp6kn2ZOp3Ea3jWNMi2eDNaRlzGhKpYN?=
 =?us-ascii?Q?UZFpAqA+uFetqnv/ilpJ4HdK0tSE0F8Y2dtbgiif/HK6orLQ4fH1VMXlOZxG?=
 =?us-ascii?Q?LgWMHbfTMPaQjWMBXMM2YGb3LjjWKuwSsO8BHcgFlyFh5OXXno/58ThcoW7R?=
 =?us-ascii?Q?r4ENbl1Ba1QJV2zxJYEl/Ok1RfU7LbPMd3Xsi0+aQbdvj6vG55yqzqWC/2HR?=
 =?us-ascii?Q?U+uEx2Kjw9ICszOq94GJAWJbM8N87haoDEoB+LS0+14vPllBkotIXtkFbh6Q?=
 =?us-ascii?Q?xUAlwnqK8fCd07la6jc9ZUo4HyxDYaTPqp3/pzljccRWc5boj3Yoo/tT4H6O?=
 =?us-ascii?Q?fbx3RtDfwQe9ffOhVgFtQCgGFuS+UcljsEBsMJaY6tBbCornS1p6mB0xQAWY?=
 =?us-ascii?Q?xLfv3sqWHK/DfgDS6Wr/nNF0rFy6V8FBCOeF9kqP806CNLNxDcSlxfV36xvD?=
 =?us-ascii?Q?w8LFTFCJOcbpvf+Gxl/n4PMw3HBneAxUza3k+oV8cmEPdWjV+bP3ExZydDa3?=
 =?us-ascii?Q?KD/kDpS2xQoFPGXEsXXN8D27hgT2Lc3MnktWrwT70Rl+DDCkIWsKQeM/+es/?=
 =?us-ascii?Q?H5SWDU1WPhTex3NR1zjmLc5OveJ/7BeZ2NWi5jqFeNdp1JjjU5cwcEUzzAN6?=
 =?us-ascii?Q?P8L3Sw+0oubKJRGdqrgBJD/j7z7+t/8m0jqd43u/JpXD7i50IH9+lCl7Y6IB?=
 =?us-ascii?Q?IaVWlYkz2+60yupFIrlssjmicv2brCns6JgJWCe8tmFl06m/sRmc/85BTFxS?=
 =?us-ascii?Q?8xXXqQOksfKCl0AsTEujozFO56Hb1HQ6bVL6p8IfUUlLGHUa9D9xjJwkp2vq?=
 =?us-ascii?Q?jUapdXCL4aukEHLDt0htVu+TgFmFZ+QMQk0cyRALBk/IxokuUCT3n9w9n2jY?=
 =?us-ascii?Q?Y+jkwgrlCgdNttnEjYwFiqcdKldgs4DAZcnEov1cobAS+q1y+RPzriQBHKYR?=
 =?us-ascii?Q?IzQZbFTqOV+xrPZ2Niv+HlDe3HYYO1jIO3XfjbMFPcCHwm6UA66pZcv7zEF8?=
 =?us-ascii?Q?kLSlKqIUjb8pP7BFyxFbAcOkCl2r8H6cTO1JdmnjahuZi62MIfHEZUN9xfaQ?=
 =?us-ascii?Q?gAf6XWPKnFm8LVSJpMziT3pChK1E+LcZU9pfooPW5qOLTpw2o/W4TVWTLrzH?=
 =?us-ascii?Q?vwcEo5O9Stu1i2D7m+BODn6q2itZ1T8X02+NePdR7I0?=
X-Microsoft-Antispam-Message-Info: qrFNNjqOAa4TTSQ4iiyDhKG6VNh+eYSfsuKxZxI3C6T+c8PZoeOy55ZSuXO4dliVPRSSGiUSHpLNHEMpBzZnbP1EK5XLJhw0/upz1f7AJjAFgMX1JMFZnqufNSq6QOSgvGqR1OtyBzTpbEjGWcMgNVgrsRTqITLv63UWouYf3Ajqrd+lX+ZhLIWzFPjaSpgb
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:wGjst1tnyv+dGVK0IAY78AykaelYqfwZcOS4smcEmoZTr0bzQmuw/Ei9egmMtp+SAOilLkrMw8NQ7q6XyUp5xitIo0WMzSWc7Psk+EwxaNdtMGkbI03YxxW1rufVoJP55+QMh/vWxR+BKfrsE5i0hChPz0EqLQivxPLhCYTdGWLxc6tiOHsQ2zYQyP7EQQk4f847eTA9urjo73VeE5zWs1Cnk8Bejiu4pNN9+s1SrHWCihn2vY/1b85Fk1UsZ1zIV39hJvnW8R0zx/9nPD1q0uuuitDIbkahfQPJjktGjKGYIn9o+3sghlhl6iNBSDiF3wAz7co7wMm2mCg5+BCbJ/Meoe6jLK0VUlpuUVo86VwsSErD9aA93PU4A0cgcR6ebgJ95lsuAcB4hvUl9DOdtPUrS8XtdDOFcjw3dJfs43Psde//hJx5g8a8C/xDx+mitNccx7nTGwOPNWbil5wrlw==;5:GUpp/iSTmd54mO0VrHvjQ3cLU075qMh55/YjdVw3coW91NndLw0ZrKFe2jdtw2jOItBu5ZIj8sqNK4Y9lg/XkB9bFUmE+LM63LirTj2fSBD5ih4agEuQVq5C2kJNjDKyAYrAiCrdgPSqHJSfhVO0X6NtE3FXKo1KM5cGS+j4i0Y=;24:eLTKhf9ARAysq8PNfcrmbpKBRw7M/bn+nFWGsWfXs28vnIhqQYkK70Lj++KsGJt5S2iAK9Dv/DXS2DQb90uxGkCKS7jcj7SDJ0KLpG9vojo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:QEIOTiJf+jndt7CJTz6NVbpS16iTKNnxdneTupSswjeZD6YLtS316ARuADZmScZzfhSsB6UYfbuYMTe4I8pTOh7cb/nQZnG4f424kDk8DTj7otd+v34lzKMWiGu+Bh/smkxHt5QliyIxjw5z9UhTkqZik2HtSETDVBTCVo1oC85vElEni14jdzZCfTSJwHs+OgmGrRF5iaTnj63X84nS6PjhbDjMnuaDvBBaS3liS5mH4ZqT10yYaWz0OGuxqew4;20:JO0T7ylRvZ3qRy9oCYftft5ehBclcM8rZZ6Dsfr4ERKIc9By57Nrz1z34nBLlAOD9IAvqMm32nB0OAsLyeo5fea7OyNVBbAJHXEY9bFNnwyZeSjiBL5yOxPxyiaCP+p5V9twCbINRCfUfqzgThxFXq16LyY2okuRZ2TbPrr9JeY=
X-MS-Office365-Filtering-Correlation-Id: 020f1d60-3c7c-4e17-afe8-08d5a085af1b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:57:15.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020f1d60-3c7c-4e17-afe8-08d5a085af1b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-12_08:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 08:52:52AM +0200, Vlastimil Babka wrote:
> On 04/11/2018 03:56 PM, Roman Gushchin wrote:
> > On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
> >> [+CC linux-api]
> >>
> >> On 03/05/2018 02:37 PM, Roman Gushchin wrote:
> >>> This patch introduces a concept of indirectly reclaimable memory
> >>> and adds the corresponding memory counter and /proc/vmstat item.
> >>>
> >>> Indirectly reclaimable memory is any sort of memory, used by
> >>> the kernel (except of reclaimable slabs), which is actually
> >>> reclaimable, i.e. will be released under memory pressure.
> >>>
> >>> The counter is in bytes, as it's not always possible to
> >>> count such objects in pages. The name contains BYTES
> >>> by analogy to NR_KERNEL_STACK_KB.
> >>>
> >>> Signed-off-by: Roman Gushchin <guro@fb.com>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >>> Cc: linux-fsdevel@vger.kernel.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Cc: linux-mm@kvack.org
> >>> Cc: kernel-team@fb.com
> >>
> >> Hmm, looks like I'm late and this user-visible API change was just
> >> merged. But it's for rc1, so we can still change it, hopefully?
> >>
> >> One problem I see with the counter is that it's in bytes, but among
> >> counters that use pages, and the name doesn't indicate it.
> > 
> > Here I just followed "nr_kernel_stack" path, which is measured in kB,
> > but this is not mentioned in the field name.
> 
> Oh, didn't know. Bad example to follow :P
> 
> >> Then, I don't
> >> see why users should care about the "indirectly" part, as that's just an
> >> implementation detail. It is reclaimable and that's what matters, right?
> >> (I also wanted to complain about lack of Documentation/... update, but
> >> looks like there's no general file about vmstat, ugh)
> > 
> > I agree, that it's a bit weird, and it's probably better to not expose
> > it at all; but this is how all vm counters work. We do expose them all
> > in /proc/vmstat. A good number of them is useless until you are not a
> > mm developer, so it's arguable more "debug info" rather than "api".
> 
> Yeah the problem is that once tools start rely on them, they fall under
> the "do not break userspace" rule, however we call them. So being
> cautious and conservative can't hurt.
> 
> > It's definitely not a reason to make them messy.
> > Does "nr_indirectly_reclaimable_bytes" look better to you?
> 
> It still has has the "indirecly" part and feels arbitrary :/
> 
> >>
> >> I also kind of liked the idea from v1 rfc posting that there would be a
> >> separate set of reclaimable kmalloc-X caches for these kind of
> >> allocations. Besides accounting, it should also help reduce memory
> >> fragmentation. The right variant of cache would be detected via
> >> __GFP_RECLAIMABLE.
> > 
> > Well, the downside is that we have to introduce X new caches
> > just for this particular problem. I'm not strictly against the idea,
> > but not convinced that it's much better.
> 
> Maybe we can find more cases that would benefit from it. Heck, even slab
> itself allocates some management structures from the generic kmalloc
> caches, and if they are used for reclaimable caches, they could be
> tracked as reclaimable as well.

This is a good catch!

> 
> >>
> >> With that in mind, can we at least for now put the (manually maintained)
> >> byte counter in a variable that's not directly exposed via /proc/vmstat,
> >> and then when printing nr_slab_reclaimable, simply add the value
> >> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
> >> subtract the same value. This way we would be simply making the existing
> >> counters more precise, in line with their semantics.
> > 
> > Idk, I don't like the idea of adding a counter outside of the vm counters
> > infrastructure, and I definitely wouldn't touch the exposed
> > nr_slab_reclaimable and nr_slab_unreclaimable fields.
> 
> We would be just making the reported values more precise wrt reality.

It depends on if we believe that only slab memory can be reclaimable
or not. If yes, this is true, otherwise not.

My guess is that some drivers (e.g. networking) might have buffers,
which are reclaimable under mempressure, and are allocated using
the page allocator. But I have to look closer...

> > We do have some stats in /proc/slabinfo, /proc/meminfo and /sys/kernel/slab
> > and I think that we should keep it consistent.
> 
> Right, meminfo would be adjusted the same. slabinfo doesn't indicate
> which caches are reclaimable, so there will be no change.
> /sys/kernel/slab/cache/reclaim_account does, but I doubt anything will
> break.

It also can be found out of the corresponding directory name in sysfs:
$ ls -la /sys/kernel/slab/dentr*
lrwxrwxrwx. 1 root root 0 Apr 11 14:45 /sys/kernel/slab/dentry -> :aA-0000192
                                                                   ^
						this is the "reclaimable" flag
Not saying that something will break.

Thanks!
