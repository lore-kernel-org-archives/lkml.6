Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1251132-1524690175-2-4643378996042227195
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
    1524690174; b=vbp2HN8GFOWouBWbJsmKm7RjJVkd+lwZTyC3z9PjhBGTPuijIo
    F/FMWFvGAMeNwDq8vckPIjDT45YL8Ld7NlLmFB9TTsavDSEpdlDiPdIeiEHHqcCv
    JQeO53fFAHp4TDWFZiMBKm27jRER28lUOOozNrNwdoGOfqTEHfaGQICzm+BaZe8q
    9cYW4aOG6CKeKTWuVKiZFaSxXd//oEICdmnJXBDLCYRwWo2RqD9wirvUH2K8vehv
    C99YeWfYx+6cR2mQ6PvtDgE+uZSs0JsHPUOTW4nkf2RmTE/Z2tjPfKyrNhS1r9Lh
    6uF6Yppol4GiG1fe3wCdGRZKmc+IGXVFC/bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524690174; bh=pzIiPAgRE7HPj+u++WNQzijNQcWBjV
    ue1Y+7dzfaZqo=; b=TFll72V6slOyD3Bb1j4D+3aPkCRinZFXpvAgAngou2N3je
    Cneg35e0ceNYoospozCs7MWCfU2cSPAjAW6iXobJwYd2PG9m8Lkt5doWGzk2tmCP
    Kfgbs8h14fuswzTPNww/M+TpMXds2c7ADXzw+4zXZNO2nKInHRiIQjfmDZEXIm8S
    mPGhXKHHeOtvL0aBLuC6P56bGcMU9kPqvmgAnJqfJwePzUdMTn6+5OGGtv5bxMzu
    jQsS3K/BZgAoD/jxItPeWthuW1tH8xrcSM5NafdU3/eXDMIg1+2+b0lHzpIks1ZI
    0ZZ9lgruZJk9YVX1wVtO7EXb/z3bHohdpmOY0yLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=GtSWcDG8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=GBLgVvvP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
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
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=fb.com header.i=@fb.com header.b=GtSWcDG8 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=facebook;
    dkim=fail (message has been altered, 1024-bit rsa key sha256) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b=GBLgVvvP x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1-fb-com;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=fb.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=fb.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLWxEg/9vSwebAaK2BSdjWmfK5IfiK4k2HF4sfNfnL/PK4w0356dVbpzrC1SurHh+y3sRzaePoY0k057gzjlvRMbstKSuvvgCcOdwxFTRimocDjhVvke
    uGu1ghtQ9Dqig5JZajI5ZEM9f25XUh9g1yU7fba4Fhc1MJGYNUaZ8UC4jV8phF3H9Rwy381/Q8+v6T7HFKBGqGIUjntBepw05qYJqVM0eGK/ogNMZNLoSo5r
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=osDrW2AON7y1HyiAeOL6jdcP5bE=:19
    a=24E3seQpDqkA:10 a=Eag7SCfzW0YA:10 a=XsZOAn2TkIEA:10 a=kj9zAlcOel0A:10
    a=Kd1tUaAdevIA:10 a=jF-tZZ44EvIA:10 a=VwQbUJbxAAAA:8 a=jTlKZ6bY1fFa3kU5xDIA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeDYVCv (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 17:02:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:47502 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751410AbeDYVCu (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 25 Apr 2018 17:02:50 -0400
Date: Wed, 25 Apr 2018 22:01:49 +0100
From: Roman Gushchin <guro@fb.com>
To: David Rientjes <rientjes@google.com>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-api@vger.kernel.org>, <kernel-team@fb.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [PATCH] mm: don't show nr_indirectly_reclaimable in /proc/vmstat
Message-ID: <20180425210143.GA10277@castle>
References: <20180425191422.9159-1-guro@fb.com>
 <alpine.DEB.2.21.1804251235330.151692@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1804251235330.151692@chino.kir.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Originating-IP: [2620:10d:c092:180::1:aea8]
X-ClientProxiedBy: DB3PR0202CA0014.eurprd02.prod.outlook.com
 (2603:10a6:8:1::27) To CO1PR15MB1077.namprd15.prod.outlook.com
 (2a01:111:e400:7b66::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CO1PR15MB1077;
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;3:OhGbEzMtFUn4fRk6G2F6f4n2H3g9esywcJuCcep22Hf50OM9p3e/9noCFXKt4cYA48r8DeRoVxNu+ZpSbtvJFBmZPCOKrW5Iod4QQzyt3sGdCCqNwgISExWeDF0D26mtVCuAQtU+nJNKQCFd41vmqJQHMgvviSssfnKAj3rWjwCZgbgGkVsnYUzRzr5Wbh17jpk4IxG15r2FzdPVqgyrTK0cVL/dGvrSFDupX+hfERIlcGoQuUM6aqfqmVX64Gyg;25:BLn1Cjqcs5hrUSf2cEiMZDgkO3rnuIJqBeopEXxgEBdnsG3nJvT+GvTvLPdtHGDtiB9nUuBmGnstsX4Hqjejw9XZ4wANB0fdgM02zWhiwIy/DfcVYkHj+W6v/4BrChmmQCoUCX0vH0awHdrucaNRzVMCG3u1uUuDGNtw8ohZC4X2J8f3B+MCSzNDVh1EoO5Q+87rhjwpBqZliQzJ+3YzoESEHTNkYUIBBP0RpsNDOQYRBHMPgXRVPgTD2b0Yk+XcAuzggFnJwfo1SBjZQN+LnBjuQBMshe8XgcMybiuMxtX7PZKVkFDmrmwcvJrQxEFLPAupwwYdV0OzKsE1btoqkw==;31:u95sy8s9b7h2/NNJvYZLZPoReMe/X3PSxs+0n3+PBgTanRTY9ZEvYwGbvq7zcjWsBHD4X+A1p94BAE5usUpzCDZsnEBct6u2v0iE1K2uKRD/hHFaKtGu80ZiLIhES1ODLCBgptKMHPRM6fYzms1Q0Q/9oB5maMYTOFzcXqZvmNenhOO1o6PxlcT0ymVaN3AzzxX+M1tAeUYmmnW9LzPzT4WgEyfKXjJOnTlIGDA4lvM=
X-MS-TrafficTypeDiagnostic: CO1PR15MB1077:
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;20:dpNZpRy11gVPErvoVTxQINJ07pY+n/OYWp12/Wu2++R2r8oKz8wPmW2tJtjsKDJPhGJgSJSB9JD7WHT8lYRBNFDdWKbgVkmf9Su0kvKPwp5DnSIOZnCzyu2W/7y8K633h8bxosc8NT5KAP6o+6C/0cruuyzWOY5v62gU1xOHPnkrCubMlSx7fp5YiaS/3Inr9yvtjhkoDfSGdt7YCWzRHOsZ8CED8RFrQkVycvJ9gnyqB4vpW7NLNkoh/LW0q5iyZP62liJ57Fss7CHhpkkx8JN3OC8yPDQiEcRnkIIB7nZzw0etPLSYV9l2wVM7yBB5FjtcaIrPGW4O/Kbc/KqBYJ+4dMYY4IuOcUgs8hpwG3aZD1FwrT6CgnB8rxDeMHrGMXbpLtfcorJKGwrfSG3z5d5GA5gg0gax7H1+3vRjAuq2gMya7ZP9ftMchZtSYv8JFhcB5nW9DX1V2l1fYtUkFaK8o0RYhy60pkyukGrvMHg0Bv1fVR772F1d0alRCggG;4:k84zKI+odS5DWnrRX1NWaxa1/MXfGbYCrRfJW6wcdk2btfG3Hnyuqpu900ruN9NOoddcmALs0avhb/0k6kCxF5hTxBbxMB3MpAt7G8b/kWVP76vzpxlGQObMz2B4bvQzKc6RIUE2mSHEuESi2b3LZf+HRV8XKSrgNZY4znVr3XKcU7RBbRXydU/zXsZjq8fSZUeMeO1laJZsfaNwqx88tFVPzgbxTvEKK5wknQO9CAakOn4DrvUIbKf+AeUqDsZZ+1jW7uBu+Z0aKHUpYJ3JRw==
X-Microsoft-Antispam-PRVS: <CO1PR15MB10777BE161B213ECD3657625BE8F0@CO1PR15MB1077.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231232)(11241501184)(944501410)(52105095)(93006095)(93001095)(6041310)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CO1PR15MB1077;BCL:0;PCL:0;RULEID:;SRVR:CO1PR15MB1077;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(366004)(346002)(189003)(199004)(386003)(316002)(486006)(446003)(11346002)(33896004)(478600001)(186003)(16526019)(476003)(9686003)(55016002)(6246003)(86362001)(76176011)(7416002)(4326008)(305945005)(5660300001)(25786009)(53936002)(16586007)(58126008)(46003)(54906003)(33716001)(50466002)(68736007)(6666003)(97736004)(6916009)(229853002)(23726003)(6116002)(6496006)(1076002)(106356001)(105586002)(47776003)(81166006)(81156014)(7736002)(33656002)(8936002)(8676002)(52396003)(52116002)(2906002)(18370500001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR15MB1077;H:castle;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:3;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CO1PR15MB1077;23:JKc6NywPaCOWY8Cf7lAsV+VJViQ8ebaSpfttV+V5f?=
 =?us-ascii?Q?vkKqFBdCKKaFyIGxZ45U9jXm9N5T/1qwpZHdMdsI+cuiNs2DI382haqvMnpj?=
 =?us-ascii?Q?YQpP1q3o6TXyTKChqD17yZNnAwWZIbt2F7cTQ0A6QL9A37igNo9WZfiKGjQK?=
 =?us-ascii?Q?MTNTfLZJOwa0/dvELX/5RN0NtwKi1MNrEimmRIkjxrelI3N1WWPoqwvHlkwh?=
 =?us-ascii?Q?4Z8kCiFAyqWVHCG6FIOt6iineh/4ltVoMHDvVbhAhz9wh5+vpfhA6KAPSljM?=
 =?us-ascii?Q?Y/lOxAK0h5oSgfbxost+eb9Guyeis0bb8H0VXhILZpkooZmk/nUVto4i9CCP?=
 =?us-ascii?Q?H7OPBHtzOUIOqtYh+Nsi5EHq2Khz7qiL37s32XMeDT1MpgCT7jiYTlG3bsHZ?=
 =?us-ascii?Q?G8FBt8/gaQ3oRa7olQ38tNthYOGJRqQlw5XH5pI5KrIqdHYa88+phaucsy2V?=
 =?us-ascii?Q?6IaatFscKYKdiBPKLqs+Q4jSixVUzhaZGrQjWKzVOa09V3HvjvM+8OwOwVx4?=
 =?us-ascii?Q?uWBo9SdmvV0tP3Lrj/dBUGD66WOnjLAWBvOy8z80pWrtI8dPt1k3crPDqcT0?=
 =?us-ascii?Q?vi44J7Nmxy4icJgntzOSEEMLteEtBBA1Kd3EcEEi1Xu30CRIPFr/f0EIipAL?=
 =?us-ascii?Q?UTbM2mv/QkFsnrOl+NZeRiSXfIOCGn8/vYP1jNRf+HtFLWSmFAjSuUx6fWM3?=
 =?us-ascii?Q?jD4wxHDne4xag97ui3fB0X2L6ILoisTZ6Bl+Qux9QdVXitEbaitbuXWvY16J?=
 =?us-ascii?Q?ytbu2ZU38Qj/cWwoBXqOaK351WikHFs5bplO18gESUntHzVW7wwZSPwKgROe?=
 =?us-ascii?Q?mcAlyUA6ghQ0RvNFDzMEeVRxLp+JONJllGh+TKkNC8LOtkxgjCIIPBOnG6qM?=
 =?us-ascii?Q?XcLqEBRO7gqEBwksa5LNceIyBTKAt8zxSwN+SZHuzgEVfGWGrsGNi4UGNq+1?=
 =?us-ascii?Q?TQRoIkU2teMZDQzGNL1IePh9569QIHJYpqXe5qg+9f383n/j1G63bhusBvzA?=
 =?us-ascii?Q?CVETl1O2e8taMN08zpnQ7FaKyY5p0c7ZUy3CalkmGV91uujjpd2DQw7Nb9gM?=
 =?us-ascii?Q?APUcYpbOExfiAa3yPzaGhYoDdVmJ1IlwjpKMbTETv4pCRoSTyMyYC6qBBbIV?=
 =?us-ascii?Q?jWfdowZQtRxWzD/otuo//Qep0QpkpL87PWUA/3a84dqopgjHd8tm6XX8VjI4?=
 =?us-ascii?Q?c4OGr6oCZTJMFGnJfLqc2Fu2UuhWEc81HdVPv4E28SmuR9o6xlGEHZMPKfHf?=
 =?us-ascii?Q?Z+KSHuXeo79/uyHlLEaqBnU3RLJBre/vwbrXtYwP/eU5RuJ2VnpSBf8EVJhc?=
 =?us-ascii?B?dz09?=
X-Microsoft-Antispam-Message-Info: bG3xDWpe0cYtmXPHQ34JXTtWxqJrPF99kJ7zfzIDa1iRscsLVtnWEOknABoCpME75FdWfC8Y7WhtPVL8EpC/5pzNkD4kR3fypdzm3DjiNXvHBQ9drwxxurZLC+DKcnfuT7RoOa1PaCQbhEl/zXTZSBTPf9JSA+yrfn1nN1wPWwU9cOhQkaY8+HQ5GlWqpB9/
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;6:L77Usb2P9FGczUYZMoORjY+VKnfYLJ0LdVdfLQ6VFvCuJO0IkXgQISlVn6i2OglMjrnrpZgXSJBOm0Ik8WiXYUYgtNJJ6yI3DNFJUKsm1aXxYBxmnO84M+9vLA9W8ihw26vPwG7ZmWwrScqq9eF48wpJs4x4293sUw701HHsv5xv0Tjz4tdH7Axyw1otER+TnqnBleN6YpDSFyMa3ZwHswGOQBEpxYhWkzewCb1zMk5puqlXGn/7J/WweqoplwXpmra/inWygoWP62sqz8xIMknGLB4Mv2RBPSIgko7Ls5/oYxrccHpBUG/8SltohWfQYozL2YM4APHYVrWvUHEsOML0vKkpCG/CMQJ69P2OKXKWYGO9+2fU/CYiFiXVXO5MWoVkUqLU8dGFXuO8SSiNdomsZJc198H3Y4d4lRX+4Q6lZKVBIKBIv3Dse7nGWx9kdYsEJLHydb179e+2UD0GPw==;5:2rQg1AZaAG8bcL5yTYztLUEq/QxTER2OqcZPsQq2ZC0HtZChoxESk5UOzUloJRct3HqJ4UYciFV2qe5wjuM8ZlwyPTyNfiNyGrfqLDCqko/BnWKHZRXBwQT6b+kcEpKPC9zo1x0x36KHAgpCCIqOT5oICPxyfvaslmufu94TUlY=;24:RLnFGuIqN2uK0qx23fSBIsrAfzfo06ft2AGcEz6j0ErKWgFeH6f73Qgc5Q5fNolJ4n9JOFBpljH6qqvZC68mEZ5UrgNfAuPLUUukP2xgFb4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CO1PR15MB1077;7:sPtCB84jn+288yw2heB+PxsAeaTJjWnmjWbR50kQ5lumLfPL0f6nw9E1JSi/Tjc90yMGQFF9EszqcGioYxZs2LiAUC3esFSi4UH0joXnsVpeV2XiuadPuZkGp/Jd4lZOG1Bg8msRVr8kvo94BS1UkxbRn3YbMEJRrFLisj2s9f9pn0+ScAZ9Uiv0s8Y5V1IoMf8LBiHYFgw+l+U+o+0xmAwFT+OgVEtM4a+4eyQ3ZoU5sWCaFOkijYP/mxR9qbVI;20:cZhfKEj+SopbYqqeUHxgA++nRDkznDcFT/aXkKI+tql9BjsG47UgFFVN/qBwheUvXYJYaCOdDCHb2O1guoODlAfA7Vx03/Q8ZCkr423nnUyvSCeoEQ7IpEk7nEpHQvl5tWtMxd7vfpygPCWLi7WCh/oG0D3B0WIbj1M8Dy7gLHg=
X-MS-Office365-Filtering-Correlation-Id: fc8a14a2-d968-45e5-bcd5-08d5aaefcbb6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 21:02:01.0225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc8a14a2-d968-45e5-bcd5-08d5aaefcbb6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR15MB1077
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

On Wed, Apr 25, 2018 at 12:37:26PM -0700, David Rientjes wrote:
> On Wed, 25 Apr 2018, Roman Gushchin wrote:
> 
> > Don't show nr_indirectly_reclaimable in /proc/vmstat,
> > because there is no need in exporting this vm counter
> > to the userspace, and some changes are expected
> > in reclaimable object accounting, which can alter
> > this counter.
> > 
> 
> I don't think it should be a per-node vmstat, in this case.  It appears 
> only to be used for the global context.  Shouldn't this be handled like 
> totalram_pages, total_swap_pages, totalreserve_pages, etc?

Hi, David!

I don't see any reasons why re-using existing infrastructure for
fast vm counters is bad, and why should we re-invent it for this case.

Thanks!
