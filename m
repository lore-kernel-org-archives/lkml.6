Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE089C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74979208AC
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 14:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O686Dkrf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74979208AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbeGaQYo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:24:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38986 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727397AbeGaQYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:24:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6VE992O077663
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=c1ZV7H/uOs1HL+FtnF8RFLT4VukUaGHB7RMWNK9NASA=;
 b=O686DkrfHYJPCAY14MPj66cVGuq2eIniGW4BDOc63GpMbmbhEDxLIizi+xXSihXqr6fY
 fT+SQHKOTo7GOT1dZuebUjWBgmMOi2lBtXRZaaHTuftXeoYMqT3Q/+bxnOkIL2Pv1fbF
 XiWvY1/jjB9AtPd4MivLeW1tZQ3a2BRW8HAIfDw3RO7srjIL06+IuTLgEjRJaX9SzKrD
 16F8Er5ZOin2rEz/ix978ZlCLvqR7VwuVb4jLEXiZILuw1tkjtUVurKhQRvZsvJfEoNy
 q/E74uQOlUTsMm0psp70VoKnlTM7C2TWbASgxK6lJVrCSh7cG9ZxXKnxNJkyiep5/00w Bw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2kggep1bt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:04 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEi2Ld011148
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:02 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6VEi2RV018656
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 14:44:02 GMT
Received: from mail-oi0-f52.google.com (/209.85.218.52)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 31 Jul 2018 07:44:02 -0700
Received: by mail-oi0-f52.google.com with SMTP id d189-v6so28374145oib.6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 07:44:01 -0700 (PDT)
X-Gm-Message-State: AOUpUlH+2aWf+iVNyED+Re06mwzKXediYaVLnk0MOmBNg25nAGNPACfS
        NShiUDZCIX0uoBJxAM+CfQiNGccCcKWFOIlbgkw=
X-Google-Smtp-Source: AAOMgpeaKZ9W6RBPp12+3iCY4cDgoJPCmqFkijVPlIzwHTdxNrEULbqPSO8tGPwG4OknoPCQ4bzrIKbzhMd1wYAcvjQ=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr23941040oiy.191.1533048241442;
 Tue, 31 Jul 2018 07:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180731124504.27582-1-osalvador@techadventures.net>
 <CAGM2rebds=A5m1ZB1LtD7oxMzM9gjVQvm-QibHjEENmXViw5eA@mail.gmail.com> <20180731144157.GA1499@techadventures.net>
In-Reply-To: <20180731144157.GA1499@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 31 Jul 2018 10:43:25 -0400
X-Gmail-Original-Message-ID: <CAGM2reYmwqQDfk7Lx-whqxDnAb41VU=dusJjGrP3zhNyYQQJcg@mail.gmail.com>
Message-ID: <CAGM2reYmwqQDfk7Lx-whqxDnAb41VU=dusJjGrP3zhNyYQQJcg@mail.gmail.com>
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
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=765
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807310137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

There is a simpler way. I will send it out in a bit. No need for your
first function, only  setup_usemap() needs to be changed to __ref.

Pavel
On Tue, Jul 31, 2018 at 10:42 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> On Tue, Jul 31, 2018 at 08:49:11AM -0400, Pavel Tatashin wrote:
> > Hi Oscar,
> >
> > Have you looked into replacing __paginginit via __meminit ? What is
> > the reason to keep both?
> Hi Pavel,
>
> Actually, thinking a bit more about this, it might make sense to remove
> __paginginit altogether and keep only __meminit.
> Looking at the original commit, I think that it was put as a way to abstract it.
>
> After the patchset [1] has been applied, only two functions marked as __paginginit
> remain, so it will be less hassle to replace that with __meminit.
>
> I will send a v2 tomorrow to be applied on top of [1].
>
> [1] https://patchwork.kernel.org/patch/10548861/
>
> Thanks
> --
> Oscar Salvador
> SUSE L3
>
