Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-650796-1524660789-2-825747024976610086
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
    1524660788; b=XmY46uQUJl3Tji/Hj8ghoBDjAowF0m4fBD38CT6nn8K6F2DM0+
    HI1EknFhHpw5S4g8ULKvuJeVJKXobsOHhuakyeHaAwNj3VPHKkTcmSCgxEZaZ0Se
    eZ1DvnmJw8AMWXiCJXjsX3/yfR56INY7mTyNPzVMXEMbCMA4vmooZoIB19C0wxIK
    iGIcF9+NDOaOMbp+94n8//UQRe60RXEjgwLve/NloK1D9u2zZa336SDIPdjg29Wd
    /Qs19n9LXdzqqR/C9OgW/SE09EsCGV/AZgsEDPkh4/aGnLqfqAKZivDKZFjZFJgt
    aomAdowwyYJJO7qiegHs8GEQSJXlXIxJ39uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524660788; bh=SxJq+bZlZIE5DzvhsQg2UgkMGIfM3R
    LaeQlEexG1Y5A=; b=IsaZjFAX93WElsqoAS9O3ouYXQ5eCqflgfAGK7k/YCC0BA
    AHQFqSjXj6KScR/5NSTtSkTZUTySSvrYXqu0x1C8f0L6KW0EmwNVI+Bgzgud5Ih7
    GdJVtzFvzfWK+lQdwBSAejpFBlanZPGHhu5yUD/TXEJa+k3R0LTXWPIjpVJzwgLk
    pDxcC3okfCEDVKqWY3cLHrvL+aeKBlm762uOcnVxE/P/y7O6RN32MOdeMd3P/aO0
    EEBJ3C4WmevjT9xkk8aQtETSL1NBSulcLdmAnq1Rxmsp+EhpiEb60Gen1Zu78b5l
    w6seHru4zas6C6P/Pfie7QHKOyNHrr7cCxTqmXOQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=lWDvF5dO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=QZWSjXAE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=lWDvF5dO x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=QZWSjXAE x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMWBGIqAs4mb9sNdWqaupgLrnrugJCtytc19l4E7B9LMKCxMrLR5cJljly5Gasyz4FMiJsn3RLUMbKmC+aJf0xyC3/lWW2kiX63TQucHrWJcHCY0k9UY
    hZVib1ffZSzI3YNGFioA3Bl8w8jVIibOsIUkmaqw2c9CJ6L/ga4xba9m1acEJBypQPrQD9+kJHlm5IHtrgesn7V/10b3QaRLp4Pkl2uuFn/520AawormkggX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=D19gQVrFAAAA:8 a=FOH2dFAWAAAA:8
    a=VwQbUJbxAAAA:8 a=b0tdjZVSOcz4K-VgBfEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=W4TVW4IDbPiebHqcZpNg:22 a=i3VuKzQdj-NEYjvDI-p3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753145AbeDYMwx (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 08:52:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:38030 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752862AbeDYMwv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 08:52:51 -0400
Date: Wed, 25 Apr 2018 13:52:12 +0100
From: Roman Gushchin <guro@fb.com>
To: Vijayanand Jitta <vjitta@codeaurora.org>
CC: vinayak menon <vinayakm.list@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, Linux API <linux-api@vger.kernel.org>
Subject: Re: [PATCH 1/3] mm: introduce NR_INDIRECTLY_RECLAIMABLE_BYTES
Message-ID: <20180425125211.GB3410@castle>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
 <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:a2cb]
X-ClientProxiedBy: AM4PR05CA0009.eurprd05.prod.outlook.com (2603:10a6:205::22)
 To CO1PR15MB1078.namprd15.prod.outlook.com (2a01:111:e400:7b66::8)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1078;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;3:I0toDN1WJRC29YWLUs5iTRCMkkrTXGpF5gjvtILAEfiozT7kgoUdYEf9crDIfsMGsenIa9EqxadC03s5ZK4nq4ojwF9zZcCy3IpuTEU6OK1TMzPV+1FB9egFA+Q4S0ZZ5bwieEy6cDpnHSrGxuo3ow6qYfYX9pVW/6ac20tcXhE26IjyBhbU6wQANklfZKiuYrlYpZoQR6g0Bksdf5y7fIjgoDjIh+YaUqS+BxfInX1puekupJHNnB2dH74RTTYc;25:6U2SLxWV6irOB3EkrMPLeJJa+0gYLTKpNZ58SVxvuGlNxMggkDjwR/jCWOUShJOZ8HmWQqO/LICTSvVifRvdi06Bb0Q7AyiIyV8hbbv9gixLnm3ECyBgDklHYvSgrieiaIiHs7QAeOftjRuiN2gNnZiFgnOOKjOaUMKrWu9xeIVbtHE5AGv7EG9SVkqn2d0k0XRxM3NkwpX5l+UOf5hL1q+gQPzF8Go+0AySHL4GtpPQ2DG+o4YQuEhh7BmfFMz4Pf7O9//H/Bowmm9Wml1YqpmpSwUAxdhC5mkT+7RHbuvoqfgGCx2O5ncWvNQBTjiGQjDdS7/6V2PN4qZ+uUfKLw==;31:gRno7YcOpvk8QdZn8mIQHs29KskUSbQ4ZztiAUVmz/2Cf7BfR45DLAhle8Dp4LQ+rU4uixRtWwi+TWDA4zFu+e7AulgKp4vtEMHr/KRRbUMnOL9imGWZzXfywo3glNx8fszkqoxY4Zurq27XdU3uuftzVAYfajQQ+SHmOdMGzQx3ju3HxcQ7gzFrG64rsHrkqUxU7JAH3D08AEM17BgzEORse1/Mt+rJ8dgvn1GmTxc=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1078:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;20:VUbGEpP3g/lTjvFkaOvY47cz+MwQNH8chM9aIK0yOee0C4Pm/P4DsnvCu0MDNbSYvRtxdeRcGYpbDgfyfgpDXs70fEcClUVMkwq31DAwL5Ep/nd6t0MO0O5JTCcjBWyeEWiGW2KBKmvdpx9uv6u0/hc98P/dMK/UV37og8hjowSnsWCklsb+XZFmrw2d+DdJ0vlIIi5AjiSwna1XX/MwQF0yeU9U7RqSQ5QaiVghCXfHVcjjHRcB2Erne0NBSb0DbSmxAfvCYTUJu90JPiuWjXE0uzlaX1uoYqm9XJ4bzKxNrD/GWv6TMk7FqFNLAcq/yYzSDoIPAhUg+CJqZ9Fev2RhE8nYdmu4c6yerjtcdlpfXweOunbxIfTBPI8GiMyFadFhS7jIy0+Qq7YTLKwCPKwCkJt1DpSUNrGCXV8P9tTIuW1Zyt2jos+2vFL75rvCkD09YcDyf3IflmM9uVioNunIJcqbcFcV8wlzaHvWdi61x9gO3HIxcRiwXU85Ppo4;4:nuMsFzUki830sc13Xk6B4sOSz8cs7ijoFF/W6EwIgS4dyuyO6zKs57dGyTE2u3cZi5b9SsdKypxsOj/C85Qa0IkidxTmlcncJR2zfrg6pLf3JPzpn2ERP9dX8PNIWLE0tAbyyp8sHLl/kauzwIfaHOlxrenym1fmISmQxWybgYEhD5gBry8AmiHyzsODyTT5pmf14z1rRIt4Ldj4/Y+5N5T+th96+ETsQm3EZEGAL+X2UYQqVpQO7NhTQ/LetlZ0AmkwX674VQH/o01LJOimRCfnsAaV48tmGWyKumLVxUb6YnPm9ceh94W85/p+vibk
X-Microsoft-Antispam-PRVS: <CO1PR15MB10784E939709DDAE48B1F6C4BE8F0@CO1PR15MB1078.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231232)(11241501184)(944501410)(52105095)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1078;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1078;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(39860400002)(396003)(366004)(199004)(189003)(446003)(16526019)(11346002)(25786009)(4326008)(186003)(81166006)(476003)(8936002)(105586002)(8676002)(486006)(106356001)(229853002)(58126008)(33716001)(46003)(316002)(16586007)(86362001)(6116002)(23726003)(305945005)(7736002)(2906002)(68736007)(6916009)(6666003)(97736004)(7416002)(54906003)(93886005)(55016002)(6306002)(81156014)(33656002)(50466002)(47776003)(6496006)(478600001)(966005)(52396003)(52116002)(76176011)(33896004)(59450400001)(386003)(53936002)(6246003)(39060400002)(9686003)(1076002)(5660300001)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1078;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1078;23:sfGL5OHJVfQHv7SkBGh8f4UjMKkiUlJMGdQvK1SdJ?=
 =?us-ascii?Q?Ua34Is0DHMw5BEu5Birl+Wz/YFjYbibPNDQR+2of/VyW9mR7gDPrLMQROcnl?=
 =?us-ascii?Q?tmOLJnT0bNXPUAl9/1xuuJF7VolJhD3JQHyCHcOIo4hhDvN/r9l3yfuMgBKU?=
 =?us-ascii?Q?sTP+b3QuODttFc7Qmkl7U7kUmjBuVFr01E84QsMA2QiwQ/47Mulu8Q2zUWCW?=
 =?us-ascii?Q?CR1aoMSr57NbKI3iphwMNRXCd4JbHy3j0MPQ3UeT6UajndTGXRccVfTlsB/k?=
 =?us-ascii?Q?C32OYbT0zlbeFFDtGv/1C2EJpXZ2eEhqCQWykmBEvxXsO93TdR2cHS8TJ8+M?=
 =?us-ascii?Q?aSenJISVVL+IsMkTOzpD9bmWQzDv+DE9z3OKyV2ipDvWX+yp3AhKVbi0xaMw?=
 =?us-ascii?Q?xJrrKcbbnXDNBa44aW0j4URWvLVGQ0Uhifd+mMZWVUrvhys4/LZcv7HRRzxn?=
 =?us-ascii?Q?Gsi9kZaLsWliRtQFUASfjX2iIPd0wSYL5U2Yn34zL4NVyXUmcdaFiOgke+dW?=
 =?us-ascii?Q?P45HgZWfiyioM7KFBMm0ZOdsMPPZD/G2wY+cFzuTEvMRco3HffBi2Zf+PIE7?=
 =?us-ascii?Q?MObkaB7ZDK5ypcu9F4f2E2A26af5GkjBv8Np7MgerxerauFKwxwYlgRTteY0?=
 =?us-ascii?Q?Nl0kxj9oaiV8izY5XxqmsQovYifYiHmykCRMRrE0teq0IzVu41QVrlN3noKX?=
 =?us-ascii?Q?Yyf3hFLMa9X1rBVqoAgb9FC2uME0VT8aDuf2dRPfVVgTK9Yz/6Vz1SKJOAxe?=
 =?us-ascii?Q?t3gR76KwfOLbKNFSgaUc/1i9sGQ/jRD78nB0gCBcdgDbbR9xmVHDSMqXXPde?=
 =?us-ascii?Q?3ndkP/5e3y6SIwnVmdm93vqj4DsAN3alxA2qpw5hvkWaj6ILRGAwLgQKON2y?=
 =?us-ascii?Q?S6cuTOzOL9dJGbgmYE03vPV5DD2qyotuxTEMi4t6RnH7mlkZ42hUi4u9f49S?=
 =?us-ascii?Q?yQZRXUhg/TpfkRB037foH7QsrEqAqAgodT55lwEeTDIDQ4ryAcg68kjBo1HE?=
 =?us-ascii?Q?7Yyj+GK5/Ku4hkzv+V5PDRi5HAsAAFP8WxBc1NaQPi8ErooV7xCAQePieLSZ?=
 =?us-ascii?Q?8NHnMAsTSLAZr19epEeIYglx5zLOEALDIOeEZENyx3HEXZmu7sNx3M0hvZ18?=
 =?us-ascii?Q?vscL8b18DDkHpXmx05knn68KGQGKSd3HtUEuRJA5w/Ztg7sQchkJpbVGMiML?=
 =?us-ascii?Q?P3ZW6lt9f+MMb5WcXCQQLn5kN0VjJytcvVEnIzoA8hjqDl8pv9fULnioureM?=
 =?us-ascii?Q?LO+gQVj3Q9FkRgoj7RzH8VfzJUh1xWkisSW0KhTmJISyDQRxohZGC4A//R5f?=
 =?us-ascii?Q?jaTbyYDxrT7O0uf+/WjhMpBEJMgprk540JqDu/cYkeaLn9MbuHl5bQ1RRa9W?=
 =?us-ascii?Q?55zPxC0t0mG2cD1YZc1B0sCwZkO2OsScYY2aVgg8Hs92ruz?=
X-Microsoft-Antispam-Message-Info: kMx0M+5i80fw3GDdX3SUP1v5Rpe8ovPC2sPs/f3l8wt21Vp8i+oRjcwGK43XO/kIPEvUYQNXe2yjk04ITjdWrRVCvyK4ycjXcTyj4fvC4fyLPVd8p9jUe5G59fI5C6hOD6hr2j7O6JW74DuPn2MZloIpzT/526zhZbp9854KFj5Ndl+XDzv3eRVZ+KbKRgOH
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;6:ihvjUako/rcOseeeGP1EGpWTMjZ2zdER8BWqfE38nsGXLc1IV/+AFvBgIXHN8qF7nPL5BkA75pNuhc2bYT4BnOCalqqRPH9njTKHcU5sR/08N4xg/Yj/FDP3wBVeJqkDLe7D8d9C62gfiQRCBJALUoMu7VSJmCdSNV/v3Bj4+NhoRyIR3GP2OAypkyRsXx0545ftY/DKsLobORZP4Bxj51SW45XAsNzYZUk44SNVNSL8EdqERZd8iWaI/k/GRnSPxLj7QIn4ubKZ8nbPsyqdpoE8XZiAHGazR0PvAJU07zES9gCwd8SATZutzBCfUnoCudWDpP2o5tdTs/D5kFThaFx9k2MenDMLGcf5/jryTBKh0MEXGSkagDYe6zQxo1GGf4sfA/X2ZifovUIRd/utDOxf2yFupoSS2J9a688rQGZJmDOX0tDVw5AUaYWOii3q2pXMEB52BFUc2dmUr86o3g==;5:f2pv9wru3nWt4znWtYe49U+Q/x9NEpsTmiwSkNsbAeyhouOsWMEOY94np3Ly8kka4MZMzdwxN6i/cRolB5H+Ph2A2ZmoxipDU0HFMjQdB/tVtVAGeUMro/WUxJTqGVPTQY5FdDFGPo+EkGnlmSpGxIvtYxYC5a++4wIt0bcuruI=;24:VcSbhweUGeYOiQGY9o4F2Cu/Bshy1+Lx2/3n7f327uNgTZoY7qg0WdZYbrErqriGy6ZwEWDwl8KcFoOx0YU8Hpsm6uO1dmMoRBxmbZY1urY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1078;7:pFmNIoIlY70ewGldUqErjIVHh2HCN1OhcfwIDdF8kC/6Aeyav+Q+JbMAMi8sjzqIM4QNt1qn28Ng606+L6sCba9KNkNznv0XGXE11VkZiTVI3dbgtRipjCgRlah3/r1+LGTm49dQMLj9hoAMKBWAFsb/KfvApcmVoyCrDTdL0PlXsjH8/C2EXtQllVighVlWYsKdG9WucvJL0sgcCFn78u/mlMB99oO3FCOVB8DUNxySdCu6/VM82IsaYFEvxJcL;20:LgklpHO3gfqgjjdwZ2TkWEPm40REWuv8l+1lrTVmS9HiY3x58scNmVgBlGZP4q2J/Z6voOQ/D5OuOocPBaxCtKNVWOcQdTwjhp/bUaXmzrc38ijRq/WrazJJ0n0qANDYlTzKbWqjJGgnnvBWH1Yrl9Q6ooJmpFB/1c0jl1/Ok6U=
X-MS-Office365-Filtering-Correlation-Id: c5463846-dde9-4460-ea80-08d5aaab65c3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 12:52:23.5478 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5463846-dde9-4460-ea80-08d5aaab65c3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1078
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-25_04:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 09:19:29AM +0530, Vijayanand Jitta wrote:
> >>>> Idk, I don't like the idea of adding a counter outside of the vm counters
> >>>> infrastructure, and I definitely wouldn't touch the exposed
> >>>> nr_slab_reclaimable and nr_slab_unreclaimable fields.
> >>>
> >>> We would be just making the reported values more precise wrt reality.
> >>
> >> It depends on if we believe that only slab memory can be reclaimable
> >> or not. If yes, this is true, otherwise not.
> >>
> >> My guess is that some drivers (e.g. networking) might have buffers,
> >> which are reclaimable under mempressure, and are allocated using
> >> the page allocator. But I have to look closer...
> >>
> > 
> > One such case I have encountered is that of the ION page pool. The page pool
> > registers a shrinker. When not in any memory pressure page pool can go high
> > and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
> > a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.

Perfect!
This is exactly what I've expected.

> > 
> > Thanks,
> > Vinayak
> > 
> 
> As Vinayak mentioned NR_INDIRECTLY_RECLAIMABLE_BYTES can be used to solve the issue
> with ION page pool when OVERCOMMIT_GUESS is set, the patch for the same can be 
> found here https://lkml.org/lkml/2018/4/24/1288

This makes perfect sense to me.

Please, fell free to add:
Acked-by: Roman Gushchin <guro@fb.com>

Thank you!
