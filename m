Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1135939-1523543971-2-14613678715496705252
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
    1523543971; b=hPmRao0LBhv70LdaYydytG/sYATIQPCeTu6ManB6sivyTlHz0a
    yGQVwxLILgh1vvwV6a1BkB+5NtikDGmn+kenOZfLxKlTkEoePobFKwjBOEdFZoFs
    wxyCedDeT6+H2Cc0CHHzP4GSSRyONG5GGJH2sIG4GWU6ZlWf7sSyIfwiqSR6ExmV
    0k0qfLnoMK1O0opuT3U3cb2GTYqEa9VZMK79qSPxjbSF8NgUCXLVVTUHlAxEnCo5
    +ZCqS2ogKmaa2jW7iykDBppZoWfK/GjxAlLO7t9UECGEIcj6xVERKJWhqxH54s0r
    vnJ6sozv2rQfFmgemgFF90GrO8XWmlWmKREg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523543971; bh=CbhuD4c2C/NZG5fC4I1t5s3TqGCNq8
    dr4XKZ+WX3cvc=; b=WM6wlsRy4Qv7ufweImHVrAE/ynX9aYrI/sV2AmsSM8WhFr
    NF8+NECdDQq5r9TYziA2WU2fEpw621ncm6881s7Hj/6+f9xV571h8+p0SfF472Ve
    5gYCq4rv9GozP1eZUeQf4oq0e8OmZfcWsAIk2ZWnvBMU12iWb3F3aFX19yFD94hd
    pD1ZAhyu94lPaV9bvnqErarv8XgoF5sTJCi7NbniRQT2uzeimdRSZ2mI5zyhHsH2
    SdkdPVoB572ja78VB62WYR34Iw/Ptcc9ElFusuH3hfm0Z7IuEs8VwOw4ffBNpnES
    h78dEYfgvw77R2VJs4+46BW378i5IL8dMh/4YhuQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=q+JpI/xR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Ri/JNkDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=q+JpI/xR x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Ri/JNkDz x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfG0DC6wOsptxmF8aKw3fKkr4hRznpP6YivACaftqfJ54kivZRTyqlmyI/cJglHVvzYgXgYrUcVXShDoXns/MBcfi3EDRmHjYEPSha0os9FZ8gecvj10u
    W5XCC1lRAO3w8XrMop/Aln7Iy260CsRUXvBEywjmd/96GicP87zHFxao1Id4B/sR8Ele1NVNw3qP7iXw7wJgRt3mothp5mxenCHMwtWLpG5c996xPYGrV3O/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=VwQbUJbxAAAA:8 a=wMbpIZKmlBNxJz5gXP0A:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753348AbeDLOjY (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 10:39:24 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36704 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752824AbeDLOjV (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 12 Apr 2018 10:39:21 -0400
Date: Thu, 12 Apr 2018 15:38:33 +0100
From: Roman Gushchin <guro@fb.com>
To: Michal Hocko <mhocko@kernel.org>
CC: Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180412143826.GA30714@castle.DHCP.thefacebook.com>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412115217.GC23400@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180412115217.GC23400@dhcp22.suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:53ee]
X-ClientProxiedBy: VI1PR0902CA0047.eurprd09.prod.outlook.com
 (2603:10a6:802:1::36) To CO1PR15MB1078.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:EOs800hSqBYLULM4gp1WPe7ijVA5ZPToi8d4emvjBXn9Sh6Ipt9D+tleYHPlrwoX8zBdJRX5vAEukvuCW7EgOHi4cVSJQxDa+ok5UoeOxO1YuUOHR8WoZ3uEKwMlvL+H3RjsAvjw17ysF4/Z1bgttZZxNQoFW+5flKt9d4zPI0hFrynpMX+47uUojp7S5uMJ7KCYnvboMRF1jYdtkeiFa+p2mFleZZRm8wg1miRmYUIY98lqF7W38EVCVKDf0ylq;25:GojwaZmfDu3Wfzx0JnOUP/mMKznMRWbhaP8DVYt0YHDJssgTaFBaMIXN0DK2IXMU276R/nN17h8loG6mW0Cu04V6TJ4cUcWTH4FNMLV8vPRi3YgQa05jvWVRdGfW5YW6WQhs45mLiuRVExNy+qvlwGHou/A8K8ugiKCo0Gm8CjGumaxKSXkE1COU4PluEvTqOMCclJ7GqkBkTBVTZ4+BBXeHliB6kIF92elP2+bI0ohHPW8wdeHHOXtceMi1i87QUmFOG/yKEZ3doJc1W+ulHnTGZgq/U/rSjJKnAffsUAzA3ozP/St4GPYzse7apwKg/PZkImX8xrb3SG9UBpAH8A==;31:dJ3VQ/HG7SDAjvV5vUGNRFXAg2VmDDKcM1iJcr0uckaCfRgCcsDUnx4Pwizr2iA0VIv/QlYsUQqy20c2dsZAJr+c/bs3bDHaSoMEQ58jquShTs3ezj7Hn+h5LRZQ1WN/H1I02E4KYpv3OxCfGFV9ZQIuJz3i4DZFF7jm59c+Q0Znq2xEqk4xBIo0Lcl6EJj8xdmV1BmA2p3tgkLqL9IqpMOaB09BD/Q6n6EhL6OltUA=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:dKF/7KApPYVWXL3uFYbZHxFHq9hu8pihVq5g2915eX7WHRMKYf9RlLKcbq7/ConDT1rJY1SYhOcnSSZPOIspdMPOy4AdLz9t1Lc5UHCe/vkximsbnwi6t5r6k1XSbDCtJjdEdLhpKZFcEB59Qg+zWtdV9FURdYPADtlJBCrs7ZROpmGb5HP17ehjhOjG73RjffuaELyijhMG+eAZ5VVzD2hetgsT9dMv5lqaRkyrMVL7oHiXdKhzCyAabAj8PS1/ayHRw5ACQuHBbjeejknHWR0Q2imDx31wxvk5RWNGQAyWdSRkV87tjQh4OwhbPAhE7IQBEV9w2/R8fmbaQ3AnUaGWsrx9nXoQmOxPNAMnas5/QY3A8iaEiTxqPaZmMABhKScxldoXs61VpPpdjlYdb46m8cgiswokCQUx88RlNSNDZhtk213yi108IsbqZGrrUBtvd+U+gavh3zbVDv1kwXdu2LAeATGaBUD4H5hFADUP04jrANNLj1UoB4AIUdqz;4:V4PhMr2p9HmTdarbyiboklIVWk8CBE/Uxq4qskhixIiJv6MXyFmbVDzHPOS6nD0E565KKbgwA43Vxni8vo5fjJn+Euamfr6E6jhYYgZortc2Et6IlxZFleyJ+Fr8IkFxUCozux/NjiKlq+53QnTOhEeSYf4c/gIqoxqBC2LHDNYnAmmau6PSNvUKUQ1TqGNUxH5MSrp0BHFWWNwnBoeEx+StUhfEugVtm3JGxUrcjohkRVcXcxjFgP1PCZdhOBC+hty8/07qJ1oMY+FsMgegd/bKnaaMN7PN1w+tzQ5jsSDyMX3KDAP1UFQHUotEKnRU
X-Microsoft-Antispam-PRVS: <CO1PR15MB10789A2D930CD4B45C168735BEBC0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(11241501184)(944501327)(52105095)(3002001)(10201501046)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(376002)(396003)(366004)(346002)(199004)(189003)(377424004)(16526019)(6246003)(53936002)(2906002)(4326008)(478600001)(97736004)(186003)(305945005)(47776003)(46003)(11346002)(486006)(7736002)(25786009)(6916009)(81156014)(6666003)(476003)(33656002)(81166006)(446003)(8936002)(229853002)(8676002)(105586002)(106356001)(23726003)(6116002)(9686003)(50466002)(5660300001)(55016002)(1076002)(59450400001)(6506007)(16586007)(58126008)(53546011)(386003)(52396003)(76176011)(93886005)(54906003)(316002)(86362001)(68736007)(52116002)(7696005)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:d6i8QjitqZKifIzlxeKNRezS0Soy7BKMFc5PAcf+w?=
 =?us-ascii?Q?EF5zOD7n5PoS03L7Gn/+L+miY/9Zr6dbFXQ/+KInU/i0u14unabXFCEfdXxp?=
 =?us-ascii?Q?+m/CjT1wExSpX/8tMpI7ILMP9bDE4SjeWsMrwby62uFASw67Gljexos1j9Og?=
 =?us-ascii?Q?gHRnmsvz3gBRI+zCk9OvPljmFbph4YWjbRf+xJf8OJU5QdjlYB0ctjYyWznc?=
 =?us-ascii?Q?pen+baK6buv1SIzg+IA45K4DHEnMSEF9hNjrBZ2dYA+RSwM+lb1/9pM2EyUS?=
 =?us-ascii?Q?Y2yT8aToiaExAo9fFKaGXGVfdtlrk48agnoXb5xl4jjY0YKdvsJFibcUp3Ip?=
 =?us-ascii?Q?AUJ9KhxrETQmdJG2a8+zJkPoVBlstsYZYIv01GEALbLIKo1+P7nRtPLmQTpP?=
 =?us-ascii?Q?+dBZonjjhHtKfy/eapHeweVg9NvU4MhJWh73JMnBAlOyTsEJ4yMA/ZfEzgdt?=
 =?us-ascii?Q?Xo3usOgfS/jLRujvRMoUdisEJHjq0nSx1xIPx0H8TjaHFBu7nbOorEG8bbwq?=
 =?us-ascii?Q?o1rJifQJ0O0zyxJ5aIp7CWQn5/NF6skEdVO/vhCXKoL+maFclDxpxJW80jHm?=
 =?us-ascii?Q?Hcaf0U1h7URBPi3n0uv3oSKESa9pf8SQ4rACIOR4lOuP59AGJ6XrnVhjsecY?=
 =?us-ascii?Q?B3Tv+HaLId1Y6qzDWP3kVjm+hZFISiKhPSEUpH0UrgkCl4XXRlwkC5IkRj82?=
 =?us-ascii?Q?Cz0gRvi+hR671ltqvW7iao086xdNNvjsUWQKDgc3MHOyIytAkMMgBkfsyzqm?=
 =?us-ascii?Q?+vjhO1ysuxsE8OgmPk50HkCkVVFO5+157xUaOLBxsdt+THCQ5MhKh4p84tmA?=
 =?us-ascii?Q?AqNb6cA6SKyKDe8ekhtT268/yGzadQx8oB/JA1poyf5JjhQmLe6jDrZLUhWd?=
 =?us-ascii?Q?h+NxFPRGbSI/HL5NQKS66Se50mkXJmNXn+XM85R68pJY4bTqaxhUKCMSi+wy?=
 =?us-ascii?Q?dsH11dOFckl7W23x9ZUqzKykRfC7YLmn360FgN261Qioxh4jFVXvJW8kAu1o?=
 =?us-ascii?Q?6c5CxVcTdM1jc8kVKtKaCg0WdeTb4tnkCzdtkUGIbkQtYEe4gZ8ttqDdbso8?=
 =?us-ascii?Q?4zW8MfK5tV2G4dYDic9BjTrAfhJNqOd8Ktz1vlgwi91Fk6PKBj56sfuzAtrP?=
 =?us-ascii?Q?qtW68QUxpb+HpUp/29ZRr/EbS4mQLDN2FtDtjVuUXj+7Uq4uUbnNuUbkd2q+?=
 =?us-ascii?Q?T/Z8AHdY5rYlgTQgaf+51cfyn9BqDVQXI2cvjItv6Y5ThMmgg4i3hlQub+yC?=
 =?us-ascii?Q?nQ/KRvN3k+jzw79Y9VFkN9cAYYhhE2taGkEX2avPL1xE0WZdSJV5VBcdeMCc?=
 =?us-ascii?Q?VlPnNetj2AxRZPcH0LA0WWeZrbWaQ3Cp57AoJhmIzYTs1W1Bxk4GcbXPQlOx?=
 =?us-ascii?Q?tLUQw=3D=3D?=
X-Microsoft-Antispam-Message-Info: 2vp4Rl+QGIrCtZ0tJ0NKNkvgzy+dP9cHTDK1N/+LwX4D0ULrGoT4J/C54+LeFhvOWYt6V6GCVFy23Sw8m2vgzg8a3KpBFLNNYjf05ATy3paXmAEF0ubM8FgytuDkJHSSKk3ulPGEofqqa1b2SDMbwZNhCKx62xAblKe0xzsO7Owl6ytNGDQ1o+3pjOPhuyJW
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:EOxgIrSosJxETFEBCmZEP46C4XKECwSt8ElBFMc1Sclpdw2G6kAlLApn4nrwZqcDEteDLJNlvPG1r0OYV22qbQyeVh59uy8APPicq0e73rLTcKWDb1VC39XCETBLzXWyV70QeSZczh0xIVU/G9oovJjtm67ef9dAp+9LRhHYCMD2pFqMDHfQpzcCLK5uXPzsBOnE9cdIQH5++k3yshQqM8BkadI3yFu3n9+PteOpfph/dURPyd8ive8bTOCULEXPbFnQQKSml1HQRthm7VxIzeZBlb2rw586fNgwErN/Z4MaFSYVcgWwsnKMcghT96kSYD6aT9yB+qqJ/mtjXweKExEHxvPMTuyOwvHjJY3o+UYza33pcGhkcmvbphBF5WluXw2usGAz15V5EorVAflMk7m20yh6FAHnICl3j1IOeBoQNS66Gl+zRJdqYzUKOWqGkqzmTwKDTiAujdbVCCLSjg==;5:/Inc1XB+XBGRWFCMnP5cxsFIYf21rqbUAM6QuyiMtkPOBucSEf6dYkcsyjVa5riEXvafGeycBpfNfhavgAtpiwh+ovjn3vLGphn+P3Ie4ZRdNr2MRqICRLdPItDAMSXTGy2/sTtbdwccUWk4oli5dyJ10PaG5g/QJRuXiS+KJWM=;24:8syH0nmuUCs76CV0JaAxXp6CIGPtr7MKHUYIsg874k4m9eumaRXipEtGoQMdH5ySVvLmN+hu0u9mQIEb+3NWWmiBzwQQcAyn/qFr74/bE/k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:vt1ctOK39iNmJP3N+tIoHXO+qyaINbNUAYmRHwkUaG5WQgcw+cPCUvWNlbcwdQp6S9x9eC3sdM4Xqq3rnukv8UAjWLthcMZM6Ezt711lrjhGs4Z+xmeWSVJ6QTZyd7ojUcufKBSpMXT9X4z65+1fObyfnFRJWi1y2NchKEhvZmhoIlCxOAAy1CSzS5qo6WW9pwd3HP1BQLOTSwK3peWztBEd0LT6CySuEOQSgpJVqjkyM1B5NYxKrTRs4Ber7BZC;20:AlVraqHhZIwEvOe9Tb7YTHkQcX6gHnLmCpZqyzTamY7xAO7H7mtJ72qsu2W3LxdxvyxXj0kOkP35INQsfs7Ydy6icbzVIaxS1d/H8is3hzWl8wwmiOAC3HdYF3cPrxSRRS5w9wKUK+FGEUWd3Rn4o2174EczaW+XY82TvU780GU=
X-MS-Office365-Filtering-Correlation-Id: 1b9cc543-b9a8-481b-551a-08d5a0831c78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:38:49.6913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b9cc543-b9a8-481b-551a-08d5a0831c78
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
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

On Thu, Apr 12, 2018 at 01:52:17PM +0200, Michal Hocko wrote:
> On Thu 12-04-18 08:52:52, Vlastimil Babka wrote:
> > On 04/11/2018 03:56 PM, Roman Gushchin wrote:
> > > On Wed, Apr 11, 2018 at 03:16:08PM +0200, Vlastimil Babka wrote:
> [...]
> > >> With that in mind, can we at least for now put the (manually maintained)
> > >> byte counter in a variable that's not directly exposed via /proc/vmstat,
> > >> and then when printing nr_slab_reclaimable, simply add the value
> > >> (divided by PAGE_SIZE), and when printing nr_slab_unreclaimable,
> > >> subtract the same value. This way we would be simply making the existing
> > >> counters more precise, in line with their semantics.
> > > 
> > > Idk, I don't like the idea of adding a counter outside of the vm counters
> > > infrastructure, and I definitely wouldn't touch the exposed
> > > nr_slab_reclaimable and nr_slab_unreclaimable fields.
> 
> Why?

Both nr_slab_reclaimable and nr_slab_unreclaimable have a very simple
meaning: they are numbers of pages used by corresponding slab caches.

In the answer to the very first version of this patchset
Andrew suggested to generalize the idea to allow further
accounting of non-kmalloc() allocations.
I like the idea, even if don't have a good example right now.

The problem with external names existed for many years before
we've accidentally hit it, so if we don't have other examples
right now, it doesn't mean that we wouldn't have them in the future.

> 
> > We would be just making the reported values more precise wrt reality.
> 
> I was suggesting something similar in an earlier discussion. I am not
> really happy about the new exposed counter either. It is just arbitrary
> by name yet very specific for this particular usecase.
> 
> What is a poor user supposed to do with the new counter? Can this be
> used for any calculations?

For me the most important part is to fix the overcommit logic, because it's
a real security and production issue. Adjusting MemAvailable is important too.

I really open here for any concrete suggestions on how to do it without exporting
of a new value, and without adding too much complexity to the code
(e.g. skipping this particular mm counter on printing will be quite messy).

Thanks!
