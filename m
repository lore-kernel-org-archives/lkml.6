Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-69578-1524826614-3-934311461553856087
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
    1524826613; b=XFdbUCKGR9/BijF1wtqacxwOcHjQObUfLXJKUhSN1nXl3GqyK7
    9jwbr4huCwXi+sPgXJnajC8y32bHJ6fUv/VGm86wx8//MHsSkUP5cv3CeWDvuPi8
    fY0h/9RJiZIGk3+zRyj/Rej16HMtFpEaon7f8WHO/yA6LgZqrJqFTe58Eb7BeaOP
    TzrywNEh4dlqK8g3Vit/B5LpBSS6CixDsC6/Y4AOxtgy9aaG/i5HVDZdbN8w/bFP
    8CTOOsbX9YztP5xUJmFZdKj1v4WgYoGsDRtksvlpm/B2ErBUi+O6Qcykp5hbjmYs
    RIi8Y4qHi379GKO3Zaj62tVS2/rTNcohb6Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524826613; bh=XS0HONNFxcqBXRLTaEEqNvEM5L1Y2H
    80AGl6DV+npzA=; b=lLDzxN15KKZYNs3KY76A9bftU+hzfMianyTdks8FVTuIzq
    FBKNDXoSsMHZSEsLVdlSlKUKX6PKUC4QFcYavS61S0Sr4z2iUdkRrtqwNbkgps4L
    Kpi5ueS2t/7mLrK3XYjrDLQ4F978RSN4NQ8pU95LP7JlF7Hw/fJ1xUxxL5lXqqJN
    11zphk6MDkmtOW/edfvMqKD4ElHoZdYnXKtUtU8UKse7VunIJUhKKdigxBfkuoiC
    CYXUFM7I/LTRDbqJx/ljBVqszqBABkLUmVbR+JR2gZV2s9EYpb/coJ8NZm0WFSPU
    ebwjMPreoOCwoPN5YwV0eEd9JyUmSFmN3T/ahrpQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=j5v8Wwn3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=h03xnJNL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=j5v8Wwn3 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=h03xnJNL x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfB4eN/vLEx4EJfFYFdhEo8bKDQZDPDO4TMjkt1fiMkPp2y7seVoSzg2+RxBo9D91Po/ImsvUCW3ykJXlcGDJfE4AkYDk2lhi8eJcKg5nMPd37RvmpAlS
    fipbjT9kZ+XzrRNdqShMNT8ScZatfaDSCvYpRhhSYq87XiFw41jR6wHyi+iFF5+rWqROcYlGkkQiHoZ9VgUn6FkoUxlKvbXiVrPxRDwtzT0EahKKeI4X3h++
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=XsZOAn2TkIEA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=FOH2dFAWAAAA:8 a=JfrnYn6hAAAA:8
    a=Z4Rwk6OoAAAA:8 a=drOt6m5kAAAA:8 a=iox4zFpeAAAA:8 a=ufHFDILaAAAA:8
    a=VwQbUJbxAAAA:8 a=Z5N_QahIuaj0_CaU-xAA:9 a=ZEiHC0N-5EVLUPqU:21
    a=cfw4yV8bdCeJx7N2:21 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=i3VuKzQdj-NEYjvDI-p3:22 a=1CNFftbPRP8L7MoqJWF3:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=RMMjzBEyIzXRtoq5n5K6:22 a=WzC6qhA0u3u7Ye7llzcV:22 a=ZmIg1sZ3JBWsdXgziEIF:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932642AbeD0K4v (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 06:56:51 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:53648 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932433AbeD0K4t (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 27 Apr 2018 06:56:49 -0400
Date: Fri, 27 Apr 2018 11:55:54 +0100
From: Roman Gushchin <guro@fb.com>
To: Vlastimil Babka <vbabka@suse.cz>
CC: David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@kernel.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <kernel-team@fb.com>, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
Message-ID: <20180427105549.GA8127@castle.DHCP.thefacebook.com>
References: <20180425191422.9159-1-guro@fb.com>
 <20180426200331.GZ17484@dhcp22.suse.cz>
 <alpine.DEB.2.21.1804261453460.238822@chino.kir.corp.google.com>
 <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <99208563-1171-b7e7-a0d7-b47b6c5e2307@suse.cz>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:200::1:ed0a]
X-ClientProxiedBy: AM5PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:206::35) To DM3PR15MB1081.namprd15.prod.outlook.com
 (2603:10b6:0:12::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM3PR15MB1081;
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;3:cr0haMmokiFvnGTpgjOUE7Q5Y70swLct7Yak5pwtj3zbOk9BDZSgc5/EZRNmeEudNWp0TOYvUw3R56w22/JqKQ3wul9kbPTitHx6bU8K6k5rFrB9eJoPgp5qE577WPiSbAoBvek5cHzZ05e9hg4mb1WjlvdaS4N/QOE0xl3AorOcLT+BpCobDwFQ2tdycoQXbb2msxU67otkBMPlgxQyTvojV+6AgERrXGxIpD6hQCsO6UD1VmPwDqM6kt9N2WGL;25:wfgaa6rJj3/Ti6AXQiSb76vIOhGrZiQY4grJ//eUPHdp801JxLKdpbN3587u+t6YEJRHP4PG/UvlPxfY7fhftGlC9PbMOl1pKS47GixwBQl6qiBJm0pKD/q0tI/4aFPU1pk4n+LRALdqokztoymKDhjRaPK6ifsIuCFMp5Pd6KiR1WV/cYEy5usKCiv+VTxp4kjImQMlPC8Irj2WF92orD8xeHzm6LGUyHHAr1NiUn4CBpf88XqyqfOeYa2ERLLjYYzCaNZTklew8JYrUF14YRx9lKhpMMOzE/gdRzd33oOJk/DCg4xHmpp3FEE6eX82WjnE+CZThnIFpR6jdFWQdQ==;31:B8TEhLya5l1So8kKYlTeGIykkQboSjDxxFtIHbTj5Cp28IigwH2zQhN61bpWSBkdsfadcl67ze4vFt+MiMErWnk3lhO1hzJc1A8CSXApKXfm0UeWSEap0S8+kVG5h0svSix/bInNQuZwiyeOesp6MIgvIfD2ZloVwnhzvQe9nOf/76bEeeQGgH36AzpMnQcoe3HRpaXpLz00HZVswrPvI4VV5zaBBNPGVxum5BWR8do=
X-MS-TrafficTypeDiagnostic: DM3PR15MB1081:
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;20:66max8vLuId5rCFJ+q04zKNwLqghHKBxa6WcmXRudaakyP1oJzkMtvToaYgkRMsDBNfJ+7tzzVVyH6bccAqi5J0YkNAOpuPY2COh49xsNucjpWJ1WaOph1VBC3N79p6i21Hn5y37YKymmhM2zKSfO3WyDnXoK7/8F7DLO6auYXxhl4AKO144UiH8PyH+sPWd46OVDogGSAU6lMLsHdNst/C/loGZaCnrFeW/OJ+LNVg4Kr2wOC/DqVAJRnNyUNorDRF4qFg+KIN1MKsEjNbKBqcoESjdPuGOIgI9S8Ph6l+AjjAPnQ3BGp6kjqwPaa4hJ9qyRAkuyNe2E4GhuKXsqcaUu5oNSyyESE04/a1HwJ82HwUkcWrTr/3hlhPaZK6fTtZbwzpEGxAgzjxH3dGRW6WC/+AD1WQLWHXdRck0sKZ5SC6TZ8nwO0Pfur/BDNwkwortN59fIJbE+L+nigoryDa5R0xss+BVVumrIWvregjt65LE/nixcYrv47jfOb2y;4:EpBim/EsectLdCr6TEhgqb7OWwo7HlH0RgszMzI+wnA1bDzjXlAiwVmtM+K8l1c8MDAT/ZWmA89A7O6uF8OWYnQigE0uYlMvERYfRX8f9YmcIEg6wI4WfKSgCXUDVDog7C8UdSz/Y80vyWyBdmcWHSPKk87InuyOwYdkir2X6dAgjyAKncVAqzMRjpbcZ9vU+ifQkkzW6WQ+qDF4FSNZitlm0lBrjR2EZrZO7b0Fl9ZCzVZb+ZYl3V0Kkf68cIb20Fz9S6i1F2P/plnB2Mjo57bUFV6Xnw1aoLk94BFZaSF5o/OuQ4Qj8JXaB1JmEYbM
X-Microsoft-Antispam-PRVS: <DM3PR15MB1081D79D0099B2ECEE3565E6BE8D0@DM3PR15MB1081.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231232)(11241501184)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM3PR15MB1081;BCL:0;PCL:0;RULEID:;SRVR:DM3PR15MB1081;
X-Forefront-PRVS: 0655F9F006
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39380400002)(366004)(376002)(39860400002)(199004)(189003)(6916009)(105586002)(7736002)(23726003)(6666003)(1076002)(55016002)(9686003)(25786009)(6246003)(5660300001)(53936002)(7416002)(106356001)(33656002)(54906003)(16586007)(486006)(446003)(93886005)(97736004)(305945005)(186003)(16526019)(4326008)(476003)(6116002)(68736007)(46003)(58126008)(478600001)(229853002)(86362001)(50466002)(76176011)(47776003)(2906002)(81166006)(11346002)(386003)(8676002)(81156014)(7696005)(6506007)(53546011)(316002)(8936002)(52396003)(52116002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM3PR15MB1081;H:castle.DHCP.thefacebook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM3PR15MB1081;23:G1w5vh1AsbWXAC4DNi9vluK+mYogpAOWzc59prDny?=
 =?us-ascii?Q?12cFmrCeL1BER/7FJKuHg4Hsyi12AwXNn94cIRw9vCIwHtDmPdobk7eV9HrT?=
 =?us-ascii?Q?TKcTYn56sy0934PRQA5CjcZsfggxGvUWeiwbPlnXVDRN9JVZ0W39Z1Z08e5i?=
 =?us-ascii?Q?143Xh175PoDsEGQt43uhFyGz5Z2JKDC6RqiY2h7nGPG8PIFJb082p4dArUdK?=
 =?us-ascii?Q?N4ywH/qcwAKqs7yap+sQlNwlilRDJETjhGeaOwP3up/jMKg7FB2h531fuIWh?=
 =?us-ascii?Q?qGsJ59sIJPYH4zvEzblRVGmHtz1CcNbO/5BHdOoS25BRTREXvuGrIgwn5ebk?=
 =?us-ascii?Q?ouiWT/8i9u16NHM/YdQiiuC0+5SF5fU2QEhZ5GOp7kbY2HrBD+Iltco1ZBBh?=
 =?us-ascii?Q?SGqPcZMXzWV7EfR1l+byqpKX0qf56cjLR3rHZmkN5FimCGYZHQl2dNcXJ00g?=
 =?us-ascii?Q?mKaiFYE5LAiWyG7XE8KZPu1+suDYwzaUJ53TXhFQ50af83er8M2zdtFYXfW4?=
 =?us-ascii?Q?+gst1IDgFrjVQeaxeyL7xu5/RPHc6ROVqiCQsiP4MJkWft6pjRCw6geF0g/k?=
 =?us-ascii?Q?XKXtpEHYS6LLLGi6TrN6Om1vCAY2xwxUg/6yU6nbQPvbjOmIv3h3OY2CDTG9?=
 =?us-ascii?Q?iHiQ5zqqkh64rSjMUNg5B3+5mBQGkEcDGaH5k66iSMaC3MgF/77+NjSo+iPH?=
 =?us-ascii?Q?xTdxWpl75aGAe0Fx1USlCVMxvbbsCDzHmG6jIt/efubYQKOXxfHXxQS/duao?=
 =?us-ascii?Q?BRJyscTWFgyIrJ1jJ4wqSQEi2pyHPyCRggn3EWqW3WLVQeMXzcwPgoyDwvD3?=
 =?us-ascii?Q?kqJAmMg/G4cSM5xx5bPm5rJv473SsnTvj3IfRsZ06tjyOHsToKxu2OuipdvQ?=
 =?us-ascii?Q?uvJtalcRw+Dr0iURhKxTsHX3JwCARk5H384HsfVTODMK/vbPe245dVdSNw0i?=
 =?us-ascii?Q?cFd91BElREEoKAg8gBUWFtejJEuyaXz//74Yg86Em4VvQnV9jle4tYpEgSDj?=
 =?us-ascii?Q?H6SNp4Xccf53PYf/k7DedpyNLgAXBqLdQ4t68HnIZq7W3S6K4UvOd62IcLyl?=
 =?us-ascii?Q?c5fE44nCDfzL5XBYkUPBPTDrJxNuaLRBHpChF6ermnqdRfvkEhH9NoUrZTS9?=
 =?us-ascii?Q?1XpLmixrsOGApY8OKinYrBrLlzqjnqy1QjKE1azH+pDVxIQPEKCZTHVQmAga?=
 =?us-ascii?Q?INlqPNMSETYl5sKRSlGZrCs0e10dYdLpLZVG7ky8/rikDfUHOXma+YyLEVff?=
 =?us-ascii?Q?qxWfE9bvHZRnaPUrzR4SbSTkU/MB1cO2mHYmlIfDL+2oIWYa+giv5Opb6Z/0?=
 =?us-ascii?Q?Lc1HAymWh99cMvPieycGBo=3D?=
X-Microsoft-Antispam-Message-Info: RkqAkSOCQs3Cu7fG0dhB7/geRmQn7Pf/Pqr7xtZrqSaDf43w8ztzCTj1fWjcl5bTuAXdOI9ZoXMyazGy/3t8m3iL2MRUw1pi2j1qVuja6gums9B/8Z6TepM5TgXWWY2WEVlbqirmBGrXzmauXGhQnku69MLiIfsfvVqi+2MJgwqbxbN5JrIxeGc2SiEKwtmJ
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;6:zk32psvFjtzban2KDveqJZTqHBaJu1eUTgEY3iRbZ4liwe4X/WeDoSku6c/ZXXx5WzdDMzprynuODaQuN9nTmrpqbss96b3wFEcAnDSeTY0uOd9msFuHyEW/QaOgDvPKbGIIYhu8JLkTQzbC0NDDfcCYupypNP8AYXwSNYRTKCAVVCkaJfGKugVSD9XSU/DCCH3Qy7DQ8Ckyqkdvsj6zDPRMqrRXyHw5lU3d/9K3n8A4L2kaLz4I8+Py4rQ3jpPViPy7aKWvz4MvwMnq9eAzlHiWWX7MSuVbbGL0MiScGUxeaWoLFao0TxOGBv9mkeqrf/DeR8aZXie1UqCd7C8KjQHX5p4MXRsAn6MfYPl0+OKtXufVM1kwwpVYmiVfeyP4aEuCy9UAI5vnNy6N4SZF/yHn2HDxm0vlfcYbl3utRMLP9E0FYvn18MtitSX3MHQIxsfLSpgY+J3w41DwBvtqQQ==;5:gz9zftn+wdu0BiqTvILqFXs3y6FDuZpEu0l7wswfZwWadkZZ/c0cy4leJ9+3Vrx5FsKwaWLw85K2kpI6f3YegjLN/pYJ4Pma3CpiVBSyTRKSuf/Q/mtuV6A1CNKh3GOu1UP0C86w4dQ7/9JIqQjUpqWZIwq/NAo521ixgSJq9ys=;24:e6Lxk9og4wAh7ioAcvvIUhJOR2DomZdqNSb5ZBfxurhf66qO5oOSnWaIFPO/RtYthEJ6CKetGa3xzWyqwIfkv5cRrrSD7Kg3Q3ZeeO9newI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM3PR15MB1081;7:Ygm4z+83je3hfGAMyy7rf8Zjt857adhXM+kUTH9ApjKGhIFbBVH93p+zy0knwZA8ZZdOPy1oWMozljLBKsnOKfW+02PczigUeFt2mkEMxvFaj/pwKhDp8EBbNuvWLYeXL6LggHF9gtxJoLYAIGprnqqmrCJhqOBYXyanYEzoDyAMZkXGjArk2on20izVi9iELSvE9qnWZb1i0DXBAj99SN9jawkbW1iCLzFiP00Qxf14QSzCw4ArpOddDaXu2h8K;20:tbi2XPvaBzYfDAO50TH/X/TnlhUM/XzpjWZliz7UflKg/eqB/kr9KRPcu/wifmVsmJKPiqWaSiDokwp4BEaOOM/ATsxwbyNsEgbVl9vzfwF0tEB8sdv7LcsFBQPItjdWZTIkAP6zXA2/Hh5OLeV2jEWBr3rM3iA7X2lPrsFfmow=
X-MS-Office365-Filtering-Correlation-Id: c9d0cb65-7c9b-4f9b-c53b-08d5ac2d7a06
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 10:56:04.5437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d0cb65-7c9b-4f9b-c53b-08d5ac2d7a06
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR15MB1081
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-27_03:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:17:01AM +0200, Vlastimil Babka wrote:
> On 04/26/2018 11:55 PM, David Rientjes wrote:
> > On Thu, 26 Apr 2018, Michal Hocko wrote:
> > 
> >>> Don't show nr_indirectly_reclaimable in /proc/vmstat,
> >>> because there is no need in exporting this vm counter
> >>> to the userspace, and some changes are expected
> >>> in reclaimable object accounting, which can alter
> >>> this counter.
> >>>
> >>> Signed-off-by: Roman Gushchin <guro@fb.com>
> >>> Cc: Vlastimil Babka <vbabka@suse.cz>
> >>> Cc: Matthew Wilcox <willy@infradead.org>
> >>> Cc: Andrew Morton <akpm@linux-foundation.org>
> >>> Cc: Alexander Viro <viro@zeniv.linux.org.uk>
> >>> Cc: Michal Hocko <mhocko@suse.com>
> >>> Cc: Johannes Weiner <hannes@cmpxchg.org>
> >>
> >> This is quite a hack. I would much rather revert the counter and fixed
> >> it the way Vlastimil has proposed. But if there is a strong opposition
> >> to the revert then this is probably the simples thing to do. Therefore
> >>
> > 
> > Implementing this counter as a vmstat doesn't make much sense based on how 
> > it's used.  Do you have a link to what Vlastimil proposed?  I haven't seen 
> > mention of alternative ideas.
> 
> It was in the original thread, see e.g.
> <08524819-14ef-81d0-fa90-d7af13c6b9d5@suse.cz>
> 
> However it will take some time to get that in mainline, and meanwhile
> the current implementation does prevent a DOS. So I doubt it can be
> fully reverted - as a compromise I just didn't want the counter to
> become ABI. TBH though, other people at LSF/MM didn't seem concerned
> that /proc/vmstat is an ABI that we can't change (i.e. counters have
> been presumably removed in the past already).
> 

Thank you, Vlastimil!
That pretty much matches my understanding of the case.

BTW, are you planning to work on supporting reclaimable objects
by slab allocators?

Thanks!
