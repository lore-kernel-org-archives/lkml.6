Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2499229-1523455049-2-14683369093919351337
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
    1523455048; b=fOpvN6jPBCNqpquUUrpWLuOW9ZQCbbNoAc4Rt1qWPOL1pUDr4T
    BLoKgcLS97x4zdf9qsOgfk5I3AbrVBvzdkO9DNB8mWFT5BD2YZishLa8oM1AMjgp
    LScrNEb9S37ZkE10f5eecUlv9ulpvc4y8g+R8ppoPe/ijJT6xz0397cZpqVkVgcL
    3PucnkkyX3K/wIgBRPtASEtnRq8RCmAhZmNmMsujxoYNgHgovZUCyPOkeC69ctw4
    wBEvDFpRvzXcxXgSAmX1q9oJvVfvuXgL1p7P+t/ndlBnIZD7vLHx32JvSGCU78hm
    aI2FrAX5D5WvT3asCvzRAVKzEDdazVklDNJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523455048; bh=55MUdk+Wr7OxpsE1EBmz1/l7LU5irM
    guCwacJjnMldI=; b=TJXo8LPn0kwxQC5hKZ4GcB6yoHx5FKwizmK4liXv3TcQRv
    vVy0POWheBVGnn+CxDHMbUWsNDyDWaU2bn7by9rrhNQ9OPb7jZMfHrMu7kq152MU
    3BdrNT1C2wnvuWFcJH6gZiX2NjHhldebhGvn0ReAztOz4CKmWRX+UoNsHiDwTjZX
    jTHRpALweS0TXcf44OAH77QUpK0XU0OMW18wacJZaUDjht5MRHcC3moCdVJzx1pn
    aTH1P13X6tyeWE8VrHy7USSW1v6Ul+wZ+Nd75lX2m0B58bbRnLjiB2hW8BIzjjMY
    PvCGEFrKE7HQCTAaNX62IP0yjZOLDVMAolnn2FAw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Z9j+Gg5B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=cMy6sHYh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=Z9j+Gg5B x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=cMy6sHYh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCc8OFtULQ4ebATbfVCRVxw8OpNPNnja4a2OdJkqyWKB8nToqu4mToqisj/AVewsXLJR5kaqYOTn98xquXV0StaosoUbE0hW7ChEbbDmQP2Nc8RWXV+E
    R1daZvlwsmxrIi03cdq38zpsz6403hpmwMjAsG4zA31H4jTSFigbGT0aqa46EgupYHDVdvSqO2Ppb17xqMXq8+x9SKUX++t3g9dCfRwugeu/ll4P49/E66dc
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=FOH2dFAWAAAA:8 a=Z4Rwk6OoAAAA:8
    a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8 a=VwQbUJbxAAAA:8
    a=37rDS-QxAAAA:8 a=0hcSIuwgXuPHanp_yDUA:9 a=C_2UkUszjC9POmyz:21
    a=8E7KBQn273Do6oDt:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=HkZW87K1Qel5hWWM3VKY:22 a=RMMjzBEyIzXRtoq5n5K6:22
    a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22 a=AjGcO6oz07-iQ99wixmX:22
    a=k1Nq6YrhK2t884LQW06G:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeDKN5K (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 09:57:10 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:37808 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752664AbeDKN5H (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Apr 2018 09:57:07 -0400
Date: Wed, 11 Apr 2018 14:56:31 +0100
From: Roman Gushchin <guro@fb.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180411135624.GA24260@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:afb]
X-ClientProxiedBy: HE1PR05CA0348.eurprd05.prod.outlook.com
 (2603:10a6:7:92::43) To DM3PR15MB1083.namprd15.prod.outlook.com
 (2603:10b6:0:12::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1083;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;3:HLTcSAXCgR1Py2GXQhlgpxbkm0mV3Hz3UJHTLUk69jNJH2dmFXw76c+Rd3GmRRH1Ui/Wu3+1lC548BmvhPwbGF98NSui14sSMO8AjqqW1jDstiB1zaJSXrnUreuAcgAApcyPF0UMTRF+YxPoXVIlVEL4P8GZPLb6C+SKHCI8fvuJRWwzdq7ipPT3ZEOv/+VwBfLIW9V7hfEJUjaJmQ1ca7dbSTSG+2OCAGIqyvVWADndzH/pWnJ8uoJtjEZ0FF0t;25:MXCS8UdjKEeukPkaHeBNliXCD27jRtm7VU8FeoHany27bT1dOO27fHJeU2GOXqb1XHgLyqqYWzBRX+UwDUGqvXwvL117iM/AoQJTdpfRrNxRzI2qiMH5NqSGy/yEPSVzQqpzioIKq/i70O09ay3U5pRyw2EKwdtwpcEb7jKqNbJcFYGc+9ucKUeSYBOEmhQHfcUZrkS6LPPUX1tbbm+BIJsOiRcTbYMsuWppR6/I2EXbQWrwg5evSA3K2LdjzpquMCt0UcWw6cgQVRizgREC8JXySpnNFF/YlhMQON7A8cMx3eZ2o2jX2XgLX6zKO0cs0WulGGowWhEBFLUQRUIO7Q==;31:w1aH5+tM5PGsq+6HyUwB6Lr0eAePQvu2RTrvRwjlFBkruFmYDV6MPbnVx1ktHj/sFZTlMEQ+PGiZs5rh+j6JmE0EIeugwNnw5yWrM9QpQCSfNcv8yJnbcrcfs/g2hi4loIJ5CINzMZce8sbHnwISo6QJ6YSFsO/zsMMo/gpxAsMkLgEOmy4PaaE1hvBgxhtvXnBWeWtfFrh1R8wNNdgJJTAlIOmonCGiQJ+CZcRpqbY=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1083:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;20:LFCctqbZJWl0zdoaN46903MYhD+hNvHywWvKqZ7aObM65MpOz4UVglYCyX3gYDhVy7Yk3C+0sSYQXfJuV4d61/ALcRcZiYaCdtW6rCYiN2x7t8xttExXGc5JRW88grr3U2mHESIEoN93FcqqFLA8utdhdykGIpEcFhnqQ7t6zEUcUkAvuvrxWBSP1ql5DecLsiM5BZvY1dblHhMZOTYoptnlqQLn7uzAXBNTwuUfHIq0hraLv2A4TeePie17Bz6vBHAImw3mQI7MKklwLuMJMKsNuG4cJWEKFRcp9ZeVVb4CPU1kGkHHP0vzriQJqwhL+VgA8naMOyLOf34SkhcczDt0EByJJppRA+UTBsSn0bBRDJ39CgoMeW7NSyNcUg2Q7J8L8kkivBLPN59hfpE67MwxiqoePQj7gR22xBcawp2WYmkgTNRCbM2Ff25KwX50Z+UorIZrC868RDnpfBr3obfMUTnkZCmI4px5mPpsxZ95w6ClHCfvV9gOh2NJWUgK;4:wSnaZ5fsd1sNCQBtWG3Xn4Z5mSBFAfo28yRsW6Tw+uqyVnywquMjMjG+vBAa3i2pyAZKagIC2IoggyeEibYRFhlgfDhDEcapxhWVpyYYboE8XEl21vftMdvEmJh35gyDVC45iaz4lcxZ1dlv5Fpc78ls16XyRmG6j7/FQ1sYqA1g2DuUwbmEFxQuDQQXjnqP4jq17buzWzpBh3CeY0z36XyS91VVEbH/9o4MvgcbJ5dIP7UTV69SzzvC8Z6ldMWDvkkYl6n6J8ojCHQhiKBubfxhgvMXlaMKS8Ypwox7bSx6Yj6CrSBrDJDckBO8o+khrYJprQqnYP5dl9PR5xHPMf1W0mpZ4t+MeukSkgaTS+U=
X-Microsoft-Antispam-PRVS: <DM3PR15MB10833A62063114231CAFA773BEBD0@DM3PR15MB1083.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231221)(11241501184)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:DM3PR15MB1083;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1083;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(39850400004)(396003)(366004)(39380400002)(346002)(189003)(51444003)(199004)(52396003)(81166006)(106356001)(446003)(486006)(33656002)(50466002)(8936002)(4326008)(53936002)(6246003)(1076002)(23726003)(6916009)(2906002)(105586002)(16526019)(229853002)(305945005)(25786009)(97736004)(81156014)(7736002)(186003)(6116002)(5660300001)(68736007)(86362001)(58126008)(54906003)(16586007)(55016002)(9686003)(6666003)(316002)(47776003)(11346002)(46003)(52116002)(59450400001)(478600001)(476003)(76176011)(6506007)(7696005)(386003)(53546011)(8676002)(18370500001)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1083;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1083;23:eN9xE6scjtHJw2iCA87TqxFmvLdZspWhrxcKdd6Kv?=
 =?us-ascii?Q?igVmbPIfJHN/x8uxh3ckj5QlcT4LkAc9DE5oiGTGY6FE+9ZJtGYSA5CINtZr?=
 =?us-ascii?Q?aK4eSMzIj19h1SvVp2mIsrwgCv208BQrpxhEcyHbxhdXgJTYDlNQDBzab4ks?=
 =?us-ascii?Q?hq2Y4XjlIfELQfsh90xInMwkEqpQzfodHpukDlhj6weUpbAhFX553iIiiCK1?=
 =?us-ascii?Q?xWtmNpVrCLeCr/iMD4aEvchIwqDqLTdEG96+EX4D/3NFnbL7uuke/aUnUc6K?=
 =?us-ascii?Q?Nsmcv7R1xJGKdEjQAIXqQyrHI4HYcTLyoeGo7FLpeddR2Ea84KrGAXZImXU7?=
 =?us-ascii?Q?zGkbLNeKX1uDf8ICXlk2dC5VM5hgghYghMKJUrBgldKpi4mE4XH85xeE1ONX?=
 =?us-ascii?Q?xMM2LTGPi4jOW47L7iz7QP5ERotYfP1kjFCIPaMBhlDp9uycTVXzArzPu8QS?=
 =?us-ascii?Q?IcMijNlzaPMRfeVZoRkmoXrZ4wVxf64BERcBPWFsYkw+Y77kwABe3yT6R3H1?=
 =?us-ascii?Q?8kICbl6DRqSqhAjdpneo0NQrgsOfYXTfX7z2eFvLbaUbnhwdUq7dhNwhUqFD?=
 =?us-ascii?Q?rTa+hzADS0mlIpl7cIWXqo1SG+WBWggvcaus/lmQwchOoIfWjut2zdqj5IGK?=
 =?us-ascii?Q?4OaZ2sOpaLKuBPcvpQrIC8YZBAreY5QKXorJ553j7gLi5omcHmmofg9HUSWb?=
 =?us-ascii?Q?k3yvPzvrU/ktC7XUu9DXVwBqpnNnpeiANgWP7r50bnJqs//Ojt+03jFn7wKx?=
 =?us-ascii?Q?jLniyp1aclTVl20VDS+IeIPUUV+4Nkv1YDi3wIer2uNlLyA2UKtR2kxXNev7?=
 =?us-ascii?Q?Ukmgi50//vhHr/IZ3yAUkab1EzDbbEmMKs5VklVLoPohMpdH9S/vISurIwrc?=
 =?us-ascii?Q?uyidXMLQBzp/aFqhs1fDeuq8BgyxYZvh+FHeOAY6Jxjgy53dbYLZoe7y+2/5?=
 =?us-ascii?Q?7umLAfkdHjD5wfW/1MH6znTp9xWcTxL3jxdWhxrI6rIOMUwTUdE1Z0JRSd1N?=
 =?us-ascii?Q?vBP57+MGRJsGs2BnzF9J05dW5kEG6SCB/VFHMXgBFbqMCxTU81mPG0Jlc4h2?=
 =?us-ascii?Q?t4oWJrMFw+b9pJoGeNqFueo5V8c+/OPzcAUISjSF5vnYGqveqaD6q7anx+GI?=
 =?us-ascii?Q?o6bEN3DVZQVAZZkBEmz6eTYnW4RxqgUPvtPiRg6IO+GT9xfpf2J/ti3pA6rw?=
 =?us-ascii?Q?GJiGveq7+0E0LazaOprGpr+JvCyDVwGIrIvsi1mfHalol2oAnlSYKAyoVHfZ?=
 =?us-ascii?Q?Zyt3TBzEWVh4uHxF2ygAowGlVcDkSryfP7NbtQDBRm29Fow5M76rP46zIJ01?=
 =?us-ascii?Q?uZGTRdlQcoKLnLPMtQYRgXJOQMFX26eZPAruFdAUW5tCekzTptY23NUG3okG?=
 =?us-ascii?Q?FOHmMikwcNDIq5h+gUKyJbt5eU1TtXmvuvubcSTHwhRLAx3MOC8LJFaqcBsS?=
 =?us-ascii?Q?vfadPAClA=3D=3D?=
X-Microsoft-Antispam-Message-Info: zCqC6QekyTKtWsKvorxdZvciJ18Q7bzXjTdrvJaftdEaMcBl5FchfA4q8TFQACXmD9kq6q9JoxEruWaUrDwJw5NXj8QLQgANWe2pQurmali1URC/0y1U0bgKVKTpL86yFtT0GVQlsyArsRKwt5A8vTtmpilFGnryzEnczc++bQ484Pk+iaJ6lZcu/p79jYS9
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;6:edaQq47hK3O7ycjUQ+HeXkp0CtEQIBHl2LFtu+/3lHBbY4xgigSk5OrldibiVM6fQNXrJY1RpP9Kmb8cRvNq4xSp9/mEdn67jYymWAtnrLmHKPsdx9TIAQnz1pGI0JJwfW0e09iiaUFyotqN+paAPJYhac9EVwfaMJVUgnvtCdBcTZAEnpbrzcuRD+Y1IuoKiHMwetEkCisL4C30XEi0bHW7iZB4Fd78EKHQIIoLm55fGchzuo8tpvzwl/io0fCrYXLZl4jts+6EMbjy4fN87OfxJo1cXf+FcEBphBfH2o217SPe4PK6iIUBCViMfRG13wWntvKMxM6UuYs9PLjNzLazPapQ0t0LPNivddMXx7Onzh+73nl25DQ7qoOaegoZctdWNPVBFwZXIKgFgBsH9SRRH8H0VtI34y9MRBL2hB47eIYbzIM3WJTUp6dJvDt/1ZhtU4BQ1ERvYBdGIDKH1Q==;5:M875hVFAXktTJGdAswxIGAsiah7pcslEBqXYaI5IduYHAGXrE+gJ3ZZLc9gn7MsI6av1cBX/Lo4PAB4LSUNxV/+cJ+U2y2BGkpGedHW60FlN+CI0GoT0dw2UBiu26xkITVqfxuTMQWkx0KD7RB68246uQxgeDCH3kxnGzz3nLZE=;24:cb07ky/QeGYjSoNHxMhoW7vI5i0sDY5U0FN60CyBDMdKl+Upm9wmCUGdByNc4eJAWM2f8COsKY7foVbh5PgnU28tIDaHT9gb/F4H1bQ+gfc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1083;7:iUIaAlwXeDJfn2TeBwGR9aLQHJtVt4QlKENTUTZXwuUAm5T5PxSlMF4z1AfqEKhWwUrginZX5E31oqxDY1nFIh6ULNwtERy461Zi+dgw6aHhbxb5q1uHq/GExq1dHSPrUobKp4aYJ3CzTu2Bltp3NtykZQhDeo+IzmhG3DYiursoxAKE2MRMyKI4Cs+cvTMSkWAOfZLR92kgWhTP3rSNnBgHSz8nisx1qommNZiXnm/FDjDgeUKiMpDEM0tY9Eb7;20:ozv9Q0V07gQZBPQ5/5gF3zJsHByKEjspHRUjOfZZKm3dz/Hrf9AVL9V/ysz0LD92tKGZkCvSoB2IjQCsXPuNPlLZUCzJjmDVIuGXCk5DTxYONKc+wevA68Ne3qBZ3b3BPkPHB5sMCQwYV7Opron9uyUZGPNaa6cnZda9izXERzc=
X-MS-Office365-Filtering-Correlation-Id: 57dc62e9-39ae-4e3a-3e6e-08d59fb4119e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 13:56:45.7554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57dc62e9-39ae-4e3a-3e6e-08d59fb4119e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1083
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
> [+CC linux-api]
> 
> On 03/05/2018 02:37 PM, Roman Gushchin wrote:
> > This patch introduces a concept of indirectly reclaimable memory
> > and adds the corresponding memory counter and /proc/vmstat item.
> > 
> > Indirectly reclaimable memory is any sort of memory, used by
> > the kernel (except of reclaimable slabs), which is actually
> > reclaimable, i.e. will be released under memory pressure.
> > 
> > The counter is in bytes, as it's not always possible to
> > count such objects in pages. The name contains BYTES
> > by analogy to NR_KERNEL_STACK_KB.
> > 
> > Signed-off-by: Roman Gushchin <guro@fb.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> > Cc: Michal Hocko <mhocko@suse.com>
> > Cc: Johannes Weiner <hannes@cmpxchg.org>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: linux-mm@kvack.org
> > Cc: kernel-team@fb.com
> 
> Hmm, looks like I'm late and this user-visible API change was just
> merged. But it's for rc1, so we can still change it, hopefully?
> 
> One problem I see with the counter is that it's in bytes, but among
> counters that use pages, and the name doesn't indicate it.

Here I just followed "nr_kernel_stack" path, which is measured in kB,
but this is not mentioned in the field name.

> Then, I don't
> see why users should care about the "indirectly" part, as that's just an
> implementation detail. It is reclaimable and that's what matters, right?
> (I also wanted to complain about lack of Documentation/... update, but
> looks like there's no general file about vmstat, ugh)

I agree, that it's a bit weird, and it's probably better to not expose
it at all; but this is how all vm counters work. We do expose them all
in /proc/vmstat. A good number of them is useless until you are not a
mm developer, so it's arguable more "debug info" rather than "api".
It's definitely not a reason to make them messy.
Does "nr_indirectly_reclaimable_bytes" look better to you?

> 
> I also kind of liked the idea from v1 rfc posting that there would be a
> separate set of reclaimable kmalloc-X caches for these kind of
> allocations. Besides accounting, it should also help reduce memory
> fragmentation. The right variant of cache would be detected via
> __GFP_RECLAIMABLE.

Well, the downside is that we have to introduce X new caches
just for this particular problem. I'm not strictly against the idea,
but not convinced that it's much better.

> 
> With that in mind, can we at least for now put the (manually maintained)
> byte counter in a variable that's not directly exposed via /proc/vmstat,
> and then when printing nr_slab_reclaimable, simply add the value
> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
> subtract the same value. This way we would be simply making the existing
> counters more precise, in line with their semantics.

Idk, I don't like the idea of adding a counter outside of the vm counters
infrastructure, and I definitely wouldn't touch the exposed
nr_slab_reclaimable and nr_slab_unreclaimable fields.
We do have some stats in /proc/slabinfo, /proc/meminfo and /sys/kernel/slab
and I think that we should keep it consistent.

Thanks!

> 
> Thoughts?
> Vlastimil
> 
> > ---
> >  include/linux/mmzone.h | 1 +
> >  mm/vmstat.c            | 1 +
> >  2 files changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> > index e09fe563d5dc..15e783f29e21 100644
> > --- a/include/linux/mmzone.h
> > +++ b/include/linux/mmzone.h
> > @@ -180,6 +180,7 @@ enum node_stat_item {
> >  	NR_VMSCAN_IMMEDIATE,	/* Prioritise for reclaim when writeback ends */
> >  	NR_DIRTIED,		/* page dirtyings since bootup */
> >  	NR_WRITTEN,		/* page writings since bootup */
> > +	NR_INDIRECTLY_RECLAIMABLE_BYTES, /* measured in bytes */
> >  	NR_VM_NODE_STAT_ITEMS
> >  };
> >  
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 40b2db6db6b1..b6b5684f31fe 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -1161,6 +1161,7 @@ const char * const vmstat_text[] = {
> >  	"nr_vmscan_immediate_reclaim",
> >  	"nr_dirtied",
> >  	"nr_written",
> > +	"nr_indirectly_reclaimable",
> >  
> >  	/* enum writeback_stat_item counters */
> >  	"nr_dirty_threshold",
> > 
> 
