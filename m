Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-987394-1524674980-2-1921849506024864940
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
    1524674980; b=u+4ThfEXnrtVHTyGXGxb1NOun4wf3D2XTx6/4xctUzI3Px6dAt
    Pbai9QJYPqyv5k6vvx6q3ZpmTNp2lMsyjszs2wYviSP4s0AEJzTp98VrZZTS5fh2
    y8ipbJ7opFyz1u4QnlqtiUbNcafwYWc39A2ZNNAH/B7iA997xG9Dip5+EgiIyIIz
    oLxpPh+vRXDuWNYi+8a1oikusBYtM77Q3AeV93dyJ60uMJQ1gFv+sfeJP02ydT5l
    tZ54LEuTwXEpl0QGPtAsdupSqDPOBbOnyZGCTfprdISufaEUQmmZDSS1wNn9DGfu
    b+Yd9DLyQ1/TCciZNyWXNK2ex1zRj/bkMHRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524674980; bh=U20tXP51KR1MXb52N7DdbdoA653sWu
    oI8p/lt6X45Q8=; b=VD33bBcvcOdHms//7FGgRo4Q5nEEExhRP4y+ZZg8mjFgW5
    B9jL6/xUoNUXXpfJcLppUFuL7ytUAz/kRQnsBjD0W+n/fZFOGwlP6U1UCvpYXv5u
    SraHiypCHpT0VDcZSgJVajG839mw50zYD2cQu7Ftm8aH4XzAbduRZT4Llo583XGw
    jkXeov2r0zS30eF60/9HpzcwQHJM1Mr9SM79Xfgwv9uAV/KwfeZ4VvVHzNoeROXD
    J6PHfn04PPjM8dxrQdnz4B7691C4TjktE1UoqkbHgJ2B4HAYtQQuyljinLflw8xa
    Ll9+FDuMNQzGTnIEmtsl+9yOuVV1CCYgpuuFNtGw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=iAx7JExr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Kw0X+830 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=iAx7JExr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=Kw0X+830 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAp0Ooe9/dm4ltxdFvRd2DF4YUMHWOFTruh1LejvzwkmgsMdwkQTVvoxRyHj1uaurD9hlc5x2mhFU+ezpS3cMBQgFYOV+J3hrEGRkixmiXiz5+SQNo+H
    QC0hLI1S7oi5Mykpr+zKan9ea04xMJnwz35i6vL2/CEgAL2UOvRXIr18ewiLREJJeYR9cXOj4A/Tezai/q2Jim1ywxt9WTorTUl219VUX6ZxrmGs5nywkKwb
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=BYvagUY0noIA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=VwQbUJbxAAAA:8 a=H2PZbVbj1ObPzmJJQBgA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755295AbeDYQtg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 12:49:36 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:43020 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755141AbeDYQtd (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 12:49:33 -0400
Date: Wed, 25 Apr 2018 17:48:53 +0100
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
Message-ID: <20180425164845.GA7223@castle>
References: <20180305133743.12746-1-guro@fb.com>
 <20180305133743.12746-2-guro@fb.com>
 <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
 <20180411135624.GA24260@castle.DHCP.thefacebook.com>
 <46dbe2a5-e65f-8b72-f835-0210bc445e52@suse.cz>
 <20180412145702.GB30714@castle.DHCP.thefacebook.com>
 <CAOaiJ-=JtFWNPqdtf+5uim0-LcPE9zSDZmocAa_6K3yGpW2fCQ@mail.gmail.com>
 <69b4dcd8-1925-e0e8-d9b4-776f3405b769@codeaurora.org>
 <20180425125211.GB3410@castle>
 <db71bf8f-0c76-e304-25c3-d22f1e0d71e5@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <db71bf8f-0c76-e304-25c3-d22f1e0d71e5@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:a2cb]
X-ClientProxiedBy: VI1PR0902CA0057.eurprd09.prod.outlook.com
 (2603:10a6:802:1::46) To CO1PR15MB1079.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::9)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1079;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;3:h/tZY7848Cf/6754NSxhULoarF7C397OsazsvgawDic//XyTLFwPXf8Fz0ObfYpLjNHBQW5YbpOx8A4/qFNsSkdbVodTjLZf6o95jNjl1CVwJI+nJKJytT79DMWP3nERnvmhqU++OB0RNa8vCmSeAdT2ZPpijpXjNc9wzEFKJbOKEa0UaMAI0gZXoDoy597L8fFjHud7RErbKIqs+u7d6jwn6t5vah0OzPx7nKoklKZIr5fBKWq+m4M7VJ8AK1ZY;25:zazpC83tOeipgqPNHQTEzQGHuDkhtdrJnLZrV5AwPaRevxWUjoLVVZytvoOBxtNQiIsywUhvMeXFHn60RWAPYfDqtmXbqllMd8nGbwNyg437apgXQIKynEnO94Q7ajZjECOJu8cqtH0L0Pjq1l57RVhZKKCVpsSrU8oITvHcOxSr67V0mg/3JyZ7Yfvs17iH1yc4Yvj9q5sxnYdY8w0LFECAx6iws9EZ9YWb7i5aL2pMjuHm5uqeRDKENge3/+VtU+fSDC4aPP/SmUf7pxtI0j+wnIClCae0miQxPr/9VRdiQz+ZEKwE5uluZeh6tXs8h0oiLjM55j4d64nm6odSJw==;31:XaYNyYTMXKaN6xR8C+JagnKESXat+cn9qCV6DRZYNcXknUwjUJJ2ChSPQr5WxuhymfrO6GhfIB0qXxjhR92L5/QTImCugJz7bX9938EWarogzapLTdy2AyjoQXqDCA5/A7XRLKLUi6AgfKcdWg3ORA5sQeafBDi4xccVs9wZnRiJG3a7iYY4SoaZO4c0v32oIopGLFTI3L+MskJ356I9+aaI62anzvVymLGiWsm7kCg=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1079:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;20:Ne6V7frQcoio3b68Esm79ZflpUn+YvJ3WoJl/QvSJnjB/hWnXL0usaXX4o5mggpAGorOyH7vFG25lWbYoaiF+XHRM6G/fTi7Vt6+4ahZbCw0d3toK/vWTUI4cpwSe4pPztiHCpoffJwAX4/0jhqdAR/7HFPXsBRBGQs4bngvBQA7l2NQ4L+dqrw7JfGOGfB0hdygrfezLukHRmyyuRGj/XU8m6AKY1JKhvNd6pMHY7quWc05Mw+zIvBFaP/sLjdeC3bKtk8VqiRDxSN4b6nC2MSMxeQIx1V72pBXfl1pjWB4v3b82UMJK7NOgTT9xT4zXjnDDPV39wj0Tbk3LJcH/Y0dRqGhnLYnEA2tnqUOIHQlIYDk8Rm5uWVquAp6Fk+L2/Op2D2Hk+T5oq/nKOFJMEFqdHLKc/r2TGYiKdtrwVBc5qDG1fbT1geEKIRSw33tzKDsAJo+YkYLeGh79foM9eCk1twyEnEC2JtsJXOdVOExyWObnd6NFghcydx1VCyr;4:68uGUCldKXG/P4E9JqsqbDEn6Z/cbJBqVRER+FdhANGicutmz16IIAg+zyLngB6ImRGbEaCGDp70hAYtXBQ9QYWbrwcQAXrZIg4qO9N6o86yBXetJo29fSjkJ4P8VF5G830m2TZf6NBBTDM/OFfmBrnQ3cJZaBEGT/ICrgfWNk2TL/u2erxS71jPmBKZNHVYkeICXaA6yXlK06TT/ZW7S2W0HCqCjyzPzaY2Rox9rv3u2zTe5rmgorkiSae73t/XZsZim/w38ABEePpyq82hkQ==
X-Microsoft-Antispam-PRVS: <CO1PR15MB1079DA1FA0ABB2559A5F2007BE8F0@CO1PR15MB1079.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231232)(11241501184)(944501410)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CO1PR15MB1079;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1079;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(346002)(366004)(376002)(39860400002)(39380400002)(69234005)(189003)(199004)(52396003)(52116002)(11346002)(2906002)(446003)(6496006)(46003)(33716001)(50466002)(9686003)(53936002)(86362001)(55016002)(25786009)(54906003)(59450400001)(76176011)(386003)(33896004)(58126008)(186003)(316002)(16526019)(53546011)(16586007)(39060400002)(478600001)(93886005)(97736004)(4326008)(33656002)(106356001)(476003)(6116002)(8936002)(23726003)(8676002)(81166006)(47776003)(1076002)(81156014)(229853002)(6666003)(7736002)(486006)(6246003)(5660300001)(68736007)(305945005)(6916009)(105586002)(7416002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1079;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1079;23:r+NNDo1bQP3zDC1esrZKmRJPlY46pkqXsLVjTvWDc?=
 =?us-ascii?Q?ZdFHeZNe6H+g1I1LQ/A/mqGVVN8lO8v+NAkUHcr/p0mr0Ye3oT114zhUxrOR?=
 =?us-ascii?Q?3FAwKsViWyMY1tWNn3rmB26wceQ/8V0VMJwZWBhcP9QoXP+jrxf8XvewfP6W?=
 =?us-ascii?Q?8kDEuPYoVPGlt4dxTFrsdJLMUs6ujGcpbn3STaf8XUorWzvXGLjTjRiZGIj3?=
 =?us-ascii?Q?1KgYLVpQkZN6uF78N45AIaMCjHB9+7oyfkoHL+CQ21X8YBSmO3sJpMMl350D?=
 =?us-ascii?Q?jsG2u7HnvLVyV0yVJ2YbQKB7xfU5EFQrrWUdNEVTA0gWT2AVOxqD1E1BMOE7?=
 =?us-ascii?Q?jFQum6Ol6psay+o21tGWBU63am1KQxP++LFfEgLADzUFPyPi0egqGOocCl8K?=
 =?us-ascii?Q?SelzxVMTfYN/ow+RnoTNOq4DlpZVlwVN/R8gfcPoRl+LpYb5dEnlBqApMvC+?=
 =?us-ascii?Q?FisZOraN5kl6jcDVyp7yaLJOFJ2C4+gBS1JxBr9Nw2Y5sN11Ce0XHCkz7JYz?=
 =?us-ascii?Q?qfP97u7VPk0GG3OyqzjZLrFDBRDHWsUE6UjdM81LMXOJcLBnPdKDYKf8DrCY?=
 =?us-ascii?Q?QOQ5tjPIoySK/ndnDt/tMmIK2XLrkOTULZeN1aD0QQpgSzBIEoCEpLkPTG61?=
 =?us-ascii?Q?6HBFiZokf7DJOCyxLZeSYWAvSM2dK50QkATF73y1D/9y9K+rL84mVsYJt0YP?=
 =?us-ascii?Q?J1DqRvXquxRifpSTpPGMtExvE0uSZyT57Egj9X9hvM2xd8SkUPcTE13Q+rNP?=
 =?us-ascii?Q?hrjh74QIZ032AQ0QFc9rU5axJMTLPCWFS2BoKCF5dU29AIDIV2wC60z/hqeG?=
 =?us-ascii?Q?zC+jB3FFUljkEFZuXOrPOOV1vVM7PtvviSX06HqanG2LigwSSaJEJ/urlwsd?=
 =?us-ascii?Q?kXT97+WIFNJzgfZ88aKKKNnyTdyi2aYLABOkgWmToSrOuTvaQRL3pO35f+g/?=
 =?us-ascii?Q?n0W8/JUSsjki8/tx2dUzqMVX36zrW8mX82rSgDrFlCaKoDMcGANqRj8v0VME?=
 =?us-ascii?Q?VGqhpmlkH0OV+helAyRW8V7XX8xA89JepRPvmfYrrXHt2JDe1QKZWQqJwiwb?=
 =?us-ascii?Q?0oFv+9t92n1P4SZLpdAFcP834rOStY3hWA4sSvXHnawhdv52If7WcAN+uc8v?=
 =?us-ascii?Q?zTOGopfrHaneRxAPb4WhODpvW9TuUjwf6IPppoklu9yndTswz3kzqhdPEUfG?=
 =?us-ascii?Q?1yqJqkUEDS/kbxQ5li+MaraBypNjFrggDj2SMksgSujmC1ddrk7iEaUSqxKR?=
 =?us-ascii?Q?B+g9VdWB0g9Ix6bcaI1PikhfrUInT82O1vClfKSltyK66IWiKOt3UTVm0Y7K?=
 =?us-ascii?Q?5FdJ7UgFRG2zlRbKuWIJTupyfbKC8UsI4fv3BEKqxJP7FV4GD4f4IXe450Bd?=
 =?us-ascii?Q?Q3mNHVKAMKvNrUaGpiZUZjueVMng8Amz2cTw2IIIqEGCbm37Rjj2nvciZaL7?=
 =?us-ascii?Q?FvCkJu3Rw=3D=3D?=
X-Microsoft-Antispam-Message-Info: DpLK1z6I2cpMj27U1xK3yXLBCXmu3RFVtiOLOGDEC89sy9H7scaGJNW+aiGOuQtKjrKXIXyXe9scHux8l08JKjzu8lWjlGYY0cSR9QVu+/myNyw9Eu2yGmuY0ZSfeKNrcEXzoSPt8ZlL70lT7yg1Wwt3JYOOf5SmGX837iu8mkfmxzR7MUdMtUvYjf2ASFZ6
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;6:fEoS7OfE/a0EXgA40/i2lrirJhyOaOrFiQMuMDJGpL262Uz4yCZKX022fUx8K1C5v8OZ93rMyLHtp2GbqmQKXcJta3x5G865thaNZcMVvPhfSwR9DzVI8Ij5Rq9tX8RXVCbhAdKi5WFEsCCEXWw6z6VOGYFnUK1PxPQ1MEc4o+OXZZkM+qcgzHGQH6mUALmuDwrIMmEtgSnd1aG7A607PvOJtIT+U/OTCWwpF7MuzVXVfGbudTeom6eVDg2fGX9aCB8RaeGOXPp80H41buyVU+4pUs+R3h4QOmQ1821J1lRiJ3lEt7xWBPgBiQMIo3r+xwXCVtVrW/QKfPf4y2Il0AMFg+FyOJlpR3J5IHyGe+khpXqRKpAhrjKz9hqABJOGFz9hFt4gXz8DrHiWZi+TR/pDfCdEAdgVr9kEw+rK9GMv20s1pG4eaRcI47Y85FIG26rQHM5aG2gaxQjc3Mm8fw==;5:buEwyChuSuyxYR/QUXnh45kL1j8X6iy06H8rkXQmMh4Vcj+LfzK6Y2Qx9guJLKq+vyEBe23NHIk92ghvnSsFUVLZB05f1GMkjQ48+ro7AWZveSJag6tzKvTxopRunCnudojYmycmKWbUNS9uQa5EmVqxsNEid1Wc4f7/jlh4Ff8=;24:dQ8axtIMhH/J7Gfw/J7XTpoejlERkqAE1WttliZeS4ppoWrslLpxLGf/tY4y/UmteKuCDbyqVBwpQCXVQP9DsM8iZi9jsrSfJkVEaEfMspI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1079;7:4megZEmNYkxMPO+nXnz8P8+RitIWb6IPvm1w4s8pBUeIXGBbhaNMFGlhmaR/lU0jOmjRDCLkE4MWWyZKdJotCxcTKcKshSyD+eqXb1V24yCAbpFomnysGrhdd+vUCzCWOsz3MlewOCIBQxROtB2ebYMRBzqbaNjp5Bc3yqoUj4bFTzFMAGi0uqTKr3Mq0ETcoHD3KEc6HPvAj+tpDP2KWqGGNGxNgF6r7TgdJshUmLUjUFW4udpMXxsBAiPdl+Xx;20:kys72G/dMFzdU/o4KUHrllnF4Vmhj+H/X+hYAtVn8caC6X7MIdAQuayHPjiQExD+DHB37wKkmhgLEFQzWXiBBRE2GZE8ap9CH0DHrE8qFVP1oGrBjwMym3S9vfXpbULSGKjjiZqZRitsQGPQllmPpGpIVgczk8kzC3UJnCFknbo=
X-MS-Office365-Filtering-Correlation-Id: b79b6b75-3eb7-4518-2156-08d5aacc77a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 16:49:06.7184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b79b6b75-3eb7-4518-2156-08d5aacc77a5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1079
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

On Wed, Apr 25, 2018 at 05:47:26PM +0200, Vlastimil Babka wrote:
> On 04/25/2018 02:52 PM, Roman Gushchin wrote:
> > On Wed, Apr 25, 2018 at 09:19:29AM +0530, Vijayanand Jitta wrote:
> >>>>>> Idk, I don't like the idea of adding a counter outside of the vm counters
> >>>>>> infrastructure, and I definitely wouldn't touch the exposed
> >>>>>> nr_slab_reclaimable and nr_slab_unreclaimable fields.
> >>>>>
> >>>>> We would be just making the reported values more precise wrt reality.
> >>>>
> >>>> It depends on if we believe that only slab memory can be reclaimable
> >>>> or not. If yes, this is true, otherwise not.
> >>>>
> >>>> My guess is that some drivers (e.g. networking) might have buffers,
> >>>> which are reclaimable under mempressure, and are allocated using
> >>>> the page allocator. But I have to look closer...
> >>>>
> >>>
> >>> One such case I have encountered is that of the ION page pool. The page pool
> >>> registers a shrinker. When not in any memory pressure page pool can go high
> >>> and thus cause an mmap to fail when OVERCOMMIT_GUESS is set. I can send
> >>> a patch to account ION page pool pages in NR_INDIRECTLY_RECLAIMABLE_BYTES.
> 
> FYI, we have discussed this at LSF/MM and agreed to try the kmalloc
> reclaimable caches idea. The existing counter could then remain for page
> allocator users such as ION. It's a bit weird to have it in bytes and
> not pages then, IMHO. What if we hid it from /proc/vmstat now so it
> doesn't become ABI, and later convert it to page granularity and expose
> it under a name such as "nr_other_reclaimable" ?

I've nothing against hiding it from /proc/vmstat, as long as we keep
the counter in place and the main issue resolved.

Maybe it's better to add nr_reclaimable = nr_slab_reclaimable + nr_other_reclaimable,
which will have a simpler meaning that nr_other_reclaimable (what is other?).

Thanks!

