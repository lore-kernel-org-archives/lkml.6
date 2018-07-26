Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0D5C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F6020862
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="loL9lPTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F6020862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388741AbeGZTOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 15:14:08 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37152 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731823AbeGZTOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 15:14:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6QHrhGZ054001
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:56:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=8FswLCcHgqOEaE8p9bODFHSc/2js+9arUGd/SyULSpg=;
 b=loL9lPTATuALihkhtVFKjKYQKkIQNGJutVfdzxsgPzOsTInakH45kDgWixmwzwFDiThW
 5VcUA80dON9EN6D2Vx/F7gk8cd2hy54mZoNHaafU4uyYdFw8CTnHQDujYHPw1iuW55Cu
 p4ak3pvueTvsqYpmjDYWB/jkW1haXJ1M7lWZbUpdvYAyfLSIrfUj0jlJqLAA/HiTB0Jb
 Y5muPx92BR2VfOq3Azz9v4OLR5HEg/uZNNOtIBdQTRVv26ZXbafiqPLQFW3VpOLtH4VP
 F97c9w/VKt1v7c5MdYofpA+OwaJ9dfsimaL8J34OsDaX5z0ctnpozdHIzVofW23QD66F ew== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2kbwfq46c8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:56:13 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6QHuBkN010294
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:56:11 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6QHuATs031178
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 17:56:11 GMT
Received: from mail-oi0-f43.google.com (/209.85.218.43)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Jul 2018 10:56:10 -0700
Received: by mail-oi0-f43.google.com with SMTP id k81-v6so4502227oib.4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 10:56:10 -0700 (PDT)
X-Gm-Message-State: AOUpUlFtBuGw4BQaxD/mBaQcwKYb+n/6Zg2H51wz748wiPpJIRsFXxwr
        6b6kx5JauNE3/ezC+ujNOjcD/FObrS3CcZeAbxc=
X-Google-Smtp-Source: AAOMgpcj3/c0n+WvmJp2WXIpBHfFrB/Rkw88sYYr/ka/bL4P5OrXETmlM30Z0VS2i1W5BvTocPAzcXZBRMCCaZ4HusE=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr3104758oig.163.1532627770203;
 Thu, 26 Jul 2018 10:56:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180725220144.11531-1-osalvador@techadventures.net>
 <20180725220144.11531-3-osalvador@techadventures.net> <20180726080500.GX28386@dhcp22.suse.cz>
 <20180726081215.GC22028@techadventures.net> <20180726151420.uigttpoclcka6h4h@xakep.localdomain>
 <20180726164304.GP28386@dhcp22.suse.cz> <CAGM2reatUAekg=e9FQM1-UVLOSBKb74-FYo7FcPqO_WaR7AmOQ@mail.gmail.com>
 <20180726175212.GQ28386@dhcp22.suse.cz>
In-Reply-To: <20180726175212.GQ28386@dhcp22.suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 26 Jul 2018 13:55:34 -0400
X-Gmail-Original-Message-ID: <CAGM2reY2HAo3UDzw=P8ue0jJmRRZou-osyJwWjXt6vtC+CF8Ug@mail.gmail.com>
Message-ID: <CAGM2reY2HAo3UDzw=P8ue0jJmRRZou-osyJwWjXt6vtC+CF8Ug@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] mm: access zone->node via zone_to_nid() and zone_set_nid()
To:     mhocko@kernel.org
Cc:     osalvador@techadventures.net,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        aaron.lu@intel.com, iamjoonsoo.kim@lge.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8965 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=789
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807260184
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 26, 2018 at 1:52 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 26-07-18 13:18:46, Pavel Tatashin wrote:
> > > > OpenGrok was used to find places where zone->node is accessed. A public one
> > > > is available here: http://src.illumos.org/source/
> > >
> > > I assume that tool uses some pattern matching or similar so steps to use
> > > the tool to get your results would be more helpful. This is basically
> > > the same thing as coccinelle generated patches.
> >
> > OpenGrok is very easy to use, it is source browser, similar to cscope
> > except obviously you can't edit the browsed code. I could have used
> > cscope just as well here.
>
> OK, then I misunderstood. I thought it was some kind of c aware grep
> that found all the usage for you. If this is cscope like then it is not
> worth mentioning in the changelog.

That's what I thought :) Oscar, will you remove the comment about
opengrok, or should I paste a new patch?

Thank you,
Pavel

> --
> Michal Hocko
> SUSE Labs
>
