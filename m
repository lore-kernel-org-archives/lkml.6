Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1044611-1524677030-2-4758561627681426570
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
    1524677029; b=sj23omkHIpP/rEXhIvOI+4lVpwA306s6QTugvS54y5WqpZuf5E
    Hox99Xts6ID6aaGllBuIb10pagW7LaO4O/0QtpEglOUCj7SFL4KVTgG9zTXc9UnG
    XhErRQu89GrwXigVIJBcE/9eP+fOd7BcNyBWvDZlTFvfAKAj+/WUj7jGEUPgPtRq
    KpTjeSxu1O3p02WXdjvuwWbJ6wTIw8IyLVSNf3i6ogCfwQagFwjatVsW5ew0u4QK
    pwcS/lR0o/ZA2DP4e8Er3YGJAyqcEh/Toe2LN0faHVUR1bEDISYLTGeF8zAfqH8F
    Cb+ffljtV61bNvPqR4sP5BSfnkmoDV9zRPbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524677029; bh=jNmEP3lUCXyduJjc5NiN+ABRIcNiNI
    5EPtfF+GxnfwE=; b=A1oW7Ibn7i+PBYEJ2GAK3FvnldnUGmb/CwdrfvgZCmL0sx
    OSkRbfYil3En7jR1l59qoOokl0DLS8KguCNgfoYh+hcxDmrBGShJYeu2WLpaLMoo
    gChQMyyVHV4G96CrTzRDa5NIPBwazY4TdfJHbqrdbqhKRFOaniKiiy/btZ1KBfTE
    ppnHMLAqr3Xe5VNRjxfAUDZE3l9E4EVWTMBdavAfzHVxhmSL3bEv6O2NVxs5ZdWs
    yZp3u2lET95zLeUpwRUz6rAij7M0mHNGTeDYYYuSDvIRuyeTCKr2+d1X951wi/gO
    qQ+uOOQuItzRQMUOIOUzquA/L2YfFR2EflawX0pQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=h8Pq/Kx2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=igCBE+Zl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=h8Pq/Kx2 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=igCBE+Zl x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJard9H8FTs0X/yZuPHJcuIIWtPleQgQ37l7b6kSabI2NGN4pE5GmbSFZHIXoXMdU3TUB7uxUXz0MYx4sXmWZkzbP8JNOhsiphr1XCE+JtJzNH5nn2D/
    k/gaVnNfvwjQIIv8bVF7GqluhIEe5HlYL3HNbYWG34WZrhWwKBEXP2tWqKydVpbAQOHQs4Og40uiVj60GTakH5eEVCko4k+bNUZOznKQKc8MxiHDgAVvyddg
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=VwQbUJbxAAAA:8 a=PPQ985mdl-TeuMF82AAA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754649AbeDYRXr (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 13:23:47 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57726 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754618AbeDYRXo (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 13:23:44 -0400
Date: Wed, 25 Apr 2018 18:23:04 +0100
From: Roman Gushchin <guro@fb.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: Vijayanand Jitta <vjitta@codeaurora.org>,
        vinayak menon <vinayakm.list@gmail.com>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180425172258.GA8052@castle>
References: <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
 <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
 <20180425125211.GB3410@castle>
 <db71bf8f-0c76-e304-25c3-d22f1e0d71e5@suse.cz>
 <20180425164845.GA7223@castle>
 <7fc2986e-b867-eb32-9124-d10ef6c1a3a3@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <7fc2986e-b867-eb32-9124-d10ef6c1a3a3@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:6b]
X-ClientProxiedBy: VI1PR0502CA0022.eurprd05.prod.outlook.com
 (2603:10a6:803:1::35) To SN2PR15MB1087.namprd15.prod.outlook.com
 (2603:10b6:804:22::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:SN2PR15MB1087;
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;3:7W64Bl1DpM+7KCosyflseEZDxpCU5Co8MMinea20aLUE8gmJARN54e/E0ytex2FKYJFaxGQUX5UsYcLAiEf6u1X/GPeqKS0jvQxOOs46bJLSf6mkXuC08sTU+lFQT8b62MIf8wBiLpMqeHbUeSzAv9kfhMrC7DwvC6vr9cLtq77uxcjGyP4qfoB3+qs5KJrWLgcpPA5kd9ZKpc+sVI0szePacgGvnsQUlHtuc1EDlvipJUdJ4sQUbii4zVqUcpIg;25:eDByUWdzKI+BSLz4LFh3ZU2Mnc/Y2mIHrm4tbs6cwVZXBKvKmvGTbIaz5WxV0dzBTs48uFCAbZ9YzJ9pAqd/GDQoy6+VQOYIZ0/OVAz/ktaoBZy9IghQP7M9C5Tdo3Lqm2hCOHVoulBEzeTdEWmYPji1tAU89hcL3RZrLsiJOQCki/GSi6VFUbrAcqEmik3fT7v8+WAGwdXUNodDQaMaT1KpyePuDcZWrgHWMyH6Ad/eSrpk2ne6YWHinp20S5++2Qz+0fTIMmMekDrnomNY2JIdV+mAxsuvhDxpdoEXSDQB3d7FEGfW+8JZzKMpezkZyeUz7KR5wNS4NtoCNwofsw==;31:Fima022fipeIi7l/CBuqG83b/nX74sZDjxFkfVOJn0w2gLubtOv/sjAPpZKNbnv5RKPjzrIkcYjCOjwCO//1hZDsJsjtzayvtq5gTtqnq0HIJRxI2O6JNJS8yCbS6gsnY0NwMiao9iUWkWgWcEshBc1KK7bJLAgNbndhsiITX3CGO+nkmCHSWHNYD4ei3CsCgUHFf7+IvCcB7VzPcLTuoUgkKw/FgXGfUxfqzAJjJ9M=
X-MS-TrafficTypeDiagnostic: SN2PR15MB1087:
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;20:abY/pa5JnXx8WGaE7TCiihb/Mo0lPsbY3oRsCTro2XIIbZLIHWpUh0cSmKiy7h2kPqEIh3gbur5/+ZGm355kX8py5RL3uMyvRQsHgS0hCFpoG2fk7nWJ6JrceT7QyUrJvZGtnsCmVmN1z3FVoihQg2ok1LD+QHMYpBHvcvj10aRjPoEyUJHCBLUkGu26eh6tIPq6jwddrQQ+31sspkmlORdZa91ZOPeeci/cfUJyYybftVlfO/eDVGmosOGW8TiduKkiI8lE4zNQEHjo3rFt+xXHXuMDYyomalwHRHhK6OQevpYKfrk4v/XICigapKXNhOk29CW6Yo4PsfMh4KdQugzKCnWmRnxDU8SFC2a0CecqYTk6W683RvYMs8WGLT2qow9YpAvMFL4W9zPA+443R4LG9cPDNgnuZLM6VAera/GUNCXWAf/mwhJZzGS+IcJadSQbBs38evECmF1/xJCLkpEyCgigYmQtxoost9dcgp+P1AhiRHaRegjV0t3W4ja8;4:wBPf+Tt2qMDjct6mpAn5S2S54bMdIYHdLhPwPCRtYsmhizLDjJwL1pRxuB2yEvkLmyQ6z66YHsfoRIUax2iewiRxPx31WrZ1XPlPgLFjDwH+Ezan4U0nQSpPQDbM43+Xbn6CmzN8yv+Z2m8NC/IcKgAa569XagKxgrHrD0D2KBPDOTilgzmVeFTAfVLgOrfUaHg52kQELjAfb+z0V+SpCysJ0gYI9zuyqbeZduEEqvLepeGRXG+hQsEUPnetNrLmN1Js7W3pafN9wHQ0lNts4g==
X-Microsoft-Antispam-PRVS: <SN2PR15MB1087836DB9F48D8A5BA96DB4BE8F0@SN2PR15MB1087.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231232)(11241501184)(944501410)(52105095)(3002001)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:SN2PR15MB1087;BCL:0;PCL:0;RULEID:;SRVR:SN2PR15MB1087;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(376002)(39380400002)(396003)(366004)(39860400002)(199004)(189003)(69234005)(93886005)(59450400001)(4326008)(16526019)(446003)(52396003)(5660300001)(86362001)(6116002)(105586002)(53546011)(9686003)(25786009)(50466002)(68736007)(7416002)(11346002)(386003)(305945005)(316002)(6916009)(16586007)(33656002)(97736004)(39060400002)(52116002)(33716001)(58126008)(6246003)(76176011)(55016002)(7736002)(54906003)(6496006)(23726003)(47776003)(2906002)(33896004)(486006)(476003)(53936002)(478600001)(8676002)(229853002)(46003)(106356001)(81156014)(186003)(81166006)(8936002)(1076002)(6666003)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN2PR15MB1087;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN2PR15MB1087;23:slZ79gWm1rLuu8eFHqrqElZpC+3y+cnR67Yq+C6sM?=
 =?us-ascii?Q?D8LQCSMJvVehIuYOpywqYgGgNORvVWBxXXYuC9DGk+JOrd3KMqDCtt/rjBgP?=
 =?us-ascii?Q?vSH/887us2ucbgLo2zhjTPvJAJvtIINZX5hSejxqLE/EAqbg2g1lKzTqXTQS?=
 =?us-ascii?Q?CvAZZ9LAD3KfgQbU/wshDfgNgMNkPlhvNLZVEyA5Rq3rWYMrb9zQzFmu/BZJ?=
 =?us-ascii?Q?wx51TTALZqaQOMdbFSFrkWxnDmGSbVvPCDJ944bb9/CHt3IP2xM1Md2QLjhF?=
 =?us-ascii?Q?MWkRAy8KhynZIzrVnCdUBobQ6ASNW9Yatl77b8GwznIHkjirBTFzHeGfG71/?=
 =?us-ascii?Q?uENHosmdeXiK3/lTmhhxNWTNb+3Akj6W4GrFUct+XzytRWRE884lShGqE+Pk?=
 =?us-ascii?Q?r2Ri8laXkd7vjkdJ5j6R+1q4FEfKJANNuioxElcyvrLEfmqaNsQ4cHu7U6Fj?=
 =?us-ascii?Q?bFaxBC8VMCNO11lndNi7fBziR5xnJTf6rWumD2vzGeLK7JZsWUEKkYHy13AW?=
 =?us-ascii?Q?T3haWEFZbbMe2aDB1nGFVmzi1fnO9QpfZ0xtqrnLkil3stDM0AMH3pweuQeI?=
 =?us-ascii?Q?30HQqVmCm3zIVRud5ZspoTnG9dFDvYUhgl4MQqYeLAC99paQqO2VNIKz+1xU?=
 =?us-ascii?Q?cDCs+B2Q1Yb7yGjd54GKIOB20gmusOHt3Yovg3Cwjz9Ni46fm3IA1Kq+5Rkn?=
 =?us-ascii?Q?4cQj+W4BDixfMrZctEw3xYWnRLpA4xafiyUB8+0NR+IxvQzCYPf32tb9sL30?=
 =?us-ascii?Q?ksKzcXghbW4ai4g7j3k7Q297ISIRN5Zo6W6+jGlG3ObrQ622thH2IM8UR1TO?=
 =?us-ascii?Q?vZi0fDunZuUfrvaSgWEiVkUP9SuzW4voO+ha/MdzlkK5ErTWn7yyG1kmBm5H?=
 =?us-ascii?Q?i3cTbcAur1Ij3BwtfroviXAKjRVnHgwZpdy71uwJy+iaDHek7CTnNG9DpbkJ?=
 =?us-ascii?Q?7OODWl6sXe/9d8blapTROszhAXUye28oGXErwIKii3Y4M5xrOEWAwtymnxyn?=
 =?us-ascii?Q?jIWKmU+I7G1P0vyJ15zZO1th9vy2t8XCXeEvLK4UTGgpQwYecD3yRe0q1Izf?=
 =?us-ascii?Q?UI+2kYQfs7wthLzr2XUxvTMDVQgSzH86z8LhkvoyE6FVMI4xMKzirde7UbmT?=
 =?us-ascii?Q?QQR8hgogIYvlPZa1fJm5R8nfzUAEvtNB3OpFRHiMcgljdM3+rFHh8VdtTQDJ?=
 =?us-ascii?Q?j0nFuQMQJjQs5cOCRxjeyz8WVuMpH+yWNfTz9jLO3QXWaHMtNhciepwTE0nx?=
 =?us-ascii?Q?+imAa5Et1mU8Lqg/uLJsiQXBGYyx6UcVrkuLmBD+ye/1DOKVfgCIkiiI5u4F?=
 =?us-ascii?Q?1d+Yf4kHbH5zPn8oK0Hb5E2w/G/RT/uhC3r86A4kpE3GF93aqQZWa7capHez?=
 =?us-ascii?Q?NG4GohK2yxj6n485oSJ7QNbmYEPFyW24ODyTAIj3emghq+hp98fSOLg2VXsh?=
 =?us-ascii?Q?amJlyN1jg=3D=3D?=
X-Microsoft-Antispam-Message-Info: yWf1BvosCLFTN7QAJsAr7X5LW8JnuDyTsclJuGSn46e9uHqGLj4a0PeBQV8rKXc8ya6f1oraC3gozSHieFGAmBnw6oK4VDGE4YIHIq07r+KuQwk7fdRBop8IS+94TntOc6oNQoN1NBm7EvpQwQbPRRS9DBb3lHSTpV9Xt5MWO8ufwru+zET9SMDArlPFYuUK
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;6:HYK3KDlc761P6MmKhnog+R+6K4HJDC8u7r+ilCfQUEGi/SEEhzA+ogvImkf7/DFmw/abke13R8e3fEO3SafQmSleHpUGB4z1ZTleznmHx1XNdhr4sgsKYPMZK0jJE3+IO/Ni7z/a+z9B7o19pRnSkjdhnUsgVzChZWy6ptopglzlHcml1684UyVqgzRYS4Dz1yq5Oi6lqCLF3rK/mPXAwlG/bwGZRBOHh+ZKhZ1Q9ApBJzv9zfFPv5ZFKLsPhBDu6y0eklFriyTY+FGwAZ8joI+Ggymr0Pv8+QoVFBkDXw27e9TTHYrGXh0OlHVB5zUvwDFnniH2gXELq5iDdRz434dFyF279SY0JNqY+ILYMX8l7i9JNg21x/LmVB9QBRCRIp7ZOqkl5WuG50jo/J7517Tu63876BUrn8oezcVeQxuxKG2ITO6kEEPpNJJKCe0tDzvEa9IW4Cwm0Cay+fi9Ng==;5:FGED9bw/qGxpxxfg0OjYVW891A0TX6OMrMXXx7iK1lUwwrIaLABowxBerzR2AggTrVPyd5SSZonHg8xllyXY3Q0fKi/9CJqDVPFyUOps4Mzyf3j7Id2pz9yG2j/YnAzJUOl0Ds14DFFSTQpfeKXM2jd/nNHXNhlznB8yr87/UIw=;24:mDgOtIkKb4DaU+Ewip3qJL/yDMubY4GdEhG84m5talJt9BOmrIQ/N7lXDZav7Kkkh2Z5aU4XXT5kRCcACq6/nounqda74xcNjDDcg70c0QM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN2PR15MB1087;7:bCxMLuFcroFSX+stamwbbPbqE35FjL4KqZbCkE2tTJ8bTttjNkjgaIIbfo+0Q+/TJBt9bTzlxwvTS1bdQilKuFK1Gf0IxGGpBzTp8LV+TBY9TFSNdGfyGt40grjREKa1hPVbTUAjmyPkTw7XeuNQvHyvrdzOGaP+k2up58ixi+vIGnVnM7uaONMaX5Ktit+oDuX+4FdAddZFYA9EJGRGCp5JlXOrgL8rf7deQ0FqzzWZ2mb8X5n1Wv3AprEYALur;20:VwEHF/c41gWON5YcyNST4NVxS2TffdaTkgxPS0W6GwgWKySf2YY/BHQ2CWis6XvxfMxrt+/HU3TY4dj9Q/VtLES14NgqJMJmWcjZ4lwIQ9Z7mFsMDsAH4Kd8h+JKxxdDeGizL9ouGoJzHQleU6nOqOgkzQfM0fxQU6o1t2w/2WQ=
X-MS-Office365-Filtering-Correlation-Id: 6d817950-f118-4caf-1d95-08d5aad13ed6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 17:23:19.4086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d817950-f118-4caf-1d95-08d5aad13ed6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN2PR15MB1087
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 07:02:42PM +0200, Vlastimil Babka wrote:
> On 04/25/2018 06:48 PM, Roman Gushchin wrote:
> > On Wed, Apr 25, 2018 at 05:47:26PM +0200, Vlastimil Babka wrote:
> >> On 04/25/2018 02:52 PM, Roman Gushchin wrote:
> >>> On Wed, Apr 25, 2018 at 09:19:29AM +0530, Vijayanand Jitta wrote:
> >>>>>>>> Idk, I don't like the idea of adding a counter outside of the vm counters
> >>>>>>>> infrastructure, and I definitely wouldn't touch the exposed
> >>>>>>>> nr_slab_reclaimable and nr_slab_unreclaimable fields.
> >>>>>>>
> >>>>>>> We would be just making the reported values more precise wrt reality.
> >>>>>>
> >>>>>> It depends on if we believe that only slab memory can be reclaimable
> >>>>>> or not. If yes, this is true, otherwise not.
> >>>>>>
> >>>>>> My guess is that some drivers (e.g. networking) might have buffers,
> >>>>>> which are reclaimable under mempressure, and are allocated using
> >>>>>> the page allocator. But I have to look closer...
> >>>>>>
> >>>>>
> >>>>> One such case I have encountered is that of the ION page pool. The page pool
> >>>>> registers a shrinker. When not in any memory pressure page pool can go high
> >>>>> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
> >>>>> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.
> >>
> >> FYI, we have discussed this at LSF/MM and agreed to try the kmalloc
> >> reclaimable caches idea. The existing counter could then remain for page
> >> allocator users such as ION. It's a bit weird to have it in bytes and
> >> not pages then, IMHO. What if we hid it from /proc/vmstat now so it
> >> doesn't become ABI, and later convert it to page granularity and expose
> >> it under a name such as "nr_other_reclaimable" ?
> > 
> > I've nothing against hiding it from /proc/vmstat, as long as we keep
> > the counter in place and the main issue resolved.
> 
> Sure.
> 
> > Maybe it's better to add nr_reclaimable = nr_slab_reclaimable + nr_other_reclaimable,
> > which will have a simpler meaning that nr_other_reclaimable (what is other?).
> 
> "other" can be changed, sure. nr_reclaimable is possible if we change
> slab to adjust that counter as well - vmstat code doesn't support
> arbitrary calculations when printing.

Sure, but even just hiding a value isn't that easy now.
So we have to touch the vmstat printing code anyway.

Thanks!
