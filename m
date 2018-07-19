Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09FB6C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7AC92086B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PRxscx2A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731670AbeGSPLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:11:50 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46554 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731113AbeGSPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:11:49 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6JENmv9078558
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:28:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=EaN9yF9FxgA2LxvWt5nh9cj9OblEct0qTSJ6jqk0Z3Q=;
 b=PRxscx2APrLNgNLbiv+xRS3PIpzTz2RkHfxhcyZnStlHtZ/iDJlzx/zGUxbavHbyYCxf
 cxgGeCAZs7BhwiEKNwlW1EXIZVoY22AhR0fovzZLqSNcjLTviYvdNmHoj4yNtIuZAr59
 qkn+kz6IVkwIfJwq19SFYwwSMBWFSjfXINWI77vK+nN13mNLDlrsQoJvNa2BhwTeV0iT
 OYWVtfKXf/oemRnqEcbws3N1Pz1DicyTxWYsWR42fmlcXmvN2P1qmnZg69ye37m4eTqs
 E8C+HGa/e1uHgB045v381kcfi1Ubllvnjd1l+xjo66QapZWuxgYVzGWCkhkJk+xb7vHk Vw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3tatbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:28:23 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6JESLuK030901
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:28:22 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6JESLxc024642
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 14:28:21 GMT
Received: from mail-it0-f41.google.com (/209.85.214.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 19 Jul 2018 07:28:21 -0700
Received: by mail-it0-f41.google.com with SMTP id v71-v6so9946954itb.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 07:28:21 -0700 (PDT)
X-Gm-Message-State: AOUpUlFPWfvgZd4nP46fvu1ytabVwl6uM/5zlsS9hikPIE2DYrhfOeA8
        b7C3HNalwmHuUynGBKJ/2ep04Jo7twGNfNnhgEY=
X-Google-Smtp-Source: AAOMgpfuFHbmyyOs847QVLt6VLsd1m5G7K5SewB8pxZiLJcSv7e1O9bQgls2uC2N/NmWqNyM3cVAjgBShBbadUTgDBQ=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr10315727oig.221.1532010500763;
 Thu, 19 Jul 2018 07:28:20 -0700 (PDT)
MIME-Version: 1.0
References: <20180719132740.32743-1-osalvador@techadventures.net>
 <20180719132740.32743-6-osalvador@techadventures.net> <20180719134622.GE7193@dhcp22.suse.cz>
 <20180719135859.GA10988@techadventures.net> <20180719140308.GG7193@dhcp22.suse.cz>
In-Reply-To: <20180719140308.GG7193@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 19 Jul 2018 10:27:44 -0400
X-Gmail-Original-Message-ID: <CAGM2reZ-+njLtZSnNpry11frg85KmMk4WWxGdaqk1o4BUJVO1w@mail.gmail.com>
Message-ID: <CAGM2reZ-+njLtZSnNpry11frg85KmMk4WWxGdaqk1o4BUJVO1w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mm/page_alloc: Only call pgdat_set_deferred_range
 when the system boots
To:     mhocko@kernel.org
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, aaron.lu@intel.com,
        iamjoonsoo.kim@lge.com, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8958 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=10 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807190155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 10:03 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 19-07-18 15:58:59, Oscar Salvador wrote:
> > On Thu, Jul 19, 2018 at 03:46:22PM +0200, Michal Hocko wrote:
> > > On Thu 19-07-18 15:27:40, osalvador@techadventures.net wrote:
> > > > From: Oscar Salvador <osalvador@suse.de>
> > > >
> > > > We should only care about deferred initialization when booting.
> > >
> > > Again why is this worth doing?
> >
> > Well, it is not a big win if that is what you meant.
> >
> > Those two fields are only being used when dealing with deferred pages,
> > which only happens at boot time.
> >
> > If later on, free_area_init_node gets called from memhotplug code,
> > we will also set the fields, although they will not be used.
> >
> > Is this a problem? No, but I think it is more clear from the code if we
> > see when this is called.
> > So I would say it was only for code consistency.
>
> Then put it to the changelog.
>
> > If you think this this is not worth, I am ok with dropping it.
>
> I am not really sure. I am not a big fan of SYSTEM_BOOTING global
> thingy so I would rather not spread its usage.

I agree, I do not think this patch is necessary. Calling
pgdat_set_deferred_range() does not hurt in hotplug context, and it is
cheap too. SYSTEM_BOOTING sometimes useful, but it is better to use it
only where necessary, where without this "if" we will encounter some
bugs.

Thank you,
Pavel
