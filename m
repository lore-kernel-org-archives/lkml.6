Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B86C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D081208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lmU9gdIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D081208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732510AbeGaQZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:25:08 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54208 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732402AbeGaQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:25:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VE90uA046868
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : from : date : message-id : subject : to : cc : content-type;
 s=corp-2018-07-02; bh=t3HqzqKSoqb/3plGFTWy3IMh6yx9tOQfD9ADyQm+QJY=;
 b=lmU9gdIfcyyTcvguWYANVWMOWetfhwgtBf8yi7abcQdU3twFYNGjGb/ux6+rW30D58hv
 Dh+BdUnJ0ahbx75BrGVMnkFsLKtSIGPC8KFuV65PFwh2cqQR0i+a1CO4cFwM888hy/Uk
 juar8sP0eOuT7V4zwt+eBhHaygJaQWLrJSiet3MxAVLBPoJHGErEZ03PRwshS3EFZU/2
 +LB/8SAamRFXHIGSlz/wt8xlHSSF1p9CCKQCpuCkwdzdULYshvaqxzfSnrRCdkk73xuD
 hk7hPY37zV+y6X28UCTPRzXPcNcPhMdLodjQ3aalMg/O9bGGh/iw4bAys59UD8xImkth 3A== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kgfwt1d6f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:28 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEiR4c012530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:28 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6VEiRaj014088
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:27 GMT
Received: from mail-oi0-f50.google.com (/209.85.218.50)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 07:44:27 -0700
Received: by mail-oi0-f50.google.com with SMTP id q11-v6so28381505oic.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:44:27 -0700 (PDT)
X-Gm-Message-State: AOUpUlHnCV6/Zcd6rDSsbA8Lcn4nua0CGwcNjOvESaJMD+3zAf5DrpDF
        ceBBLBReVD/HLMxr18hdVXsqrY1BCTTEOiXmKPM=
X-Google-Smtp-Source: AAOMgpc4+mzZkO/2/RCS0z5Uq667ptqGj0SAkYPo7esm/PH+6sq4CBlUZtMMZLGZXk0qyQPJD8czWpHio2QxwXrr1Vs=
X-Received: by 2002:aca:3bc2:: with SMTP id i185-v6mr24442152oia.156.1533048267399;
 Tue, 31 Jul 2018 07:44:27 -0700 (PDT)
MIME-Version: 1.0
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com>
 <20180731144157.GA1499@techadventures.net> <CAGM2reYmwqQDfk7Lx-whqxDnAb41VU=dusJjGrP3zhNyYQQJcg@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 10:43:51 -0400
X-Gmail-Original-Message-ID: <CAGM2reZa0z9-H+630ojegw6Z8n2KDFY7k+w5mYtTru2=MCUrJQ@mail.gmail.com>
Message-ID: <CAGM2reZa0z9-H+630ojegw6Z8n2KDFY7k+w5mYtTru2=MCUrJQ@mail.gmail.com>
Subject: Re: [PATCH] mm: make __paginginit based on CONFIG_MEMORY_HOTPLUG
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        kirill.shutemov@linux.intel.com, iamjoonsoo.kim@lge.com,
        Mel Gorman <mgorman@suse.de>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8970 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=804
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 31, 2018 at 10:43 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> Hi Oscar,
>
> There is a simpler way. I will send it out in a bit. No need for your first function, only  setup_usemap() needs to be changed to __ref.

I meant first patch  not function :)

>
> Pavel
> On Tue, Jul 31, 2018 at 10:42 AM Oscar Salvador <osalvador@techadventures.net> wrote:
> >
> > On Tue, Jul 31, 2018 at 08:49:11AM -0400, Pavel Tatashin wrote:
> > > Hi Oscar,
> > >
> > > Have you looked into replacing __paginginit via __meminit ? What is
> > > the reason to keep both?
> > Hi Pavel,
> >
> > Actually, thinking a bit more about this, it might make sense to remove
> > __paginginit altogether and keep only __meminit.
> > Looking at the original commit, I think that it was put as a way to abstract it.
> >
> > After the patchset [1] has been applied, only two functions marked as __paginginit
> > remain, so it will be less hassle to replace that with __meminit.
> >
> > I will send a v2 tomorrow to be applied on top of [1].
> >
> > [1] https://patchwork.kernel.org/patch/10548861/
> >
> > Thanks
> > --
> > Oscar Salvador
> > SUSE L3
> >
