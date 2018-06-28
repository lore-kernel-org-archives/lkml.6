Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EDC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24BAC27334
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:12:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TebH7dpn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24BAC27334
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934835AbeF1MMo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:12:44 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:46418 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933830AbeF1MMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:12:43 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SC4FlI185876
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:12:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=Jq12nq3reiDKCYh+fPduG5hfM5jjtJBLoF53xlEMsJA=;
 b=TebH7dpnLtO98sKtwnjqLbKQFt52JkdOPYToZBhkAJudy8YIB3bAP2YEhPa0snth1+HN
 Wkr1B/rnhbv2FtWW5cGML9X4xEJpC5tmocwuQahdLn8CUfAIRbklfUEoVkIGuSW++ZHa
 89cW+69Xc4wO4ERvP4BVHI20UDeJq1FpUmHa+uW2E/DgIiJtqqeLquqo4r8uhYBu1oZ8
 WoQEth8HdIWWFaynUAr0+VGa65NUoc/IKVfqpDg48y09Nr5f/mWHeKTTMaq/UNz9vn8J
 oSIXzljs86ZNFhXMQgC9WQrlkOGk7d7nxvsvfRjDI4xN1b0oPYynDQwAaygXC2jeZc1I lQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2jukmu24mv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:12:42 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5SCCfIg002729
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:12:41 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5SCCfIS000635
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:12:41 GMT
Received: from mail-oi0-f45.google.com (/209.85.218.45)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 05:12:41 -0700
Received: by mail-oi0-f45.google.com with SMTP id r16-v6so4435637oie.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 05:12:40 -0700 (PDT)
X-Gm-Message-State: APt69E16kIOsAYIJUotH02RcyyCVMY7+xlL3qlSNn5Bu01Sy1O5H54//
        qtIB7m9/i8RK9+euLeBSc/5k3d1mbxK9m/M8jXY=
X-Google-Smtp-Source: AAOMgpfOFA3YrwZw3avpNi/nS8ZlZGb35Gv7+0t+jjJj8VTyXlOtAmgyzek15R3Ow+YW6W2LF984Vo8FK+q0Pod/RJQ=
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr5904844oia.156.1530187960686;
 Thu, 28 Jun 2018 05:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180628062857.29658-1-bhe@redhat.com> <20180628062857.29658-5-bhe@redhat.com>
 <20180628120937.GC12956@techadventures.net>
In-Reply-To: <20180628120937.GC12956@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 28 Jun 2018 08:12:04 -0400
X-Gmail-Original-Message-ID: <CAGM2reZsZVhhg2=dQZf6D-NmPTFRN-_95+s61pC7Axz5G5mkMQ@mail.gmail.com>
Message-ID: <CAGM2reZsZVhhg2=dQZf6D-NmPTFRN-_95+s61pC7Axz5G5mkMQ@mail.gmail.com>
Subject: Re: [PATCH v6 4/5] mm/sparse: Optimize memmap allocation during sparse_init()
To:     osalvador@techadventures.net
Cc:     bhe@redhat.com, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=504
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280140
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +             if (nr_consumed_maps >= nr_present_sections) {
> > +                     pr_err("nr_consumed_maps goes beyond nr_present_sections\n");
> > +                     break;
> > +             }
>
> Hi Baoquan,
>
> I am sure I am missing something here, but is this check really needed?
>
> I mean, for_each_present_section_nr() only returns the section nr if the section
> has been marked as SECTION_MARKED_PRESENT.
> That happens in memory_present(), where now we also increment nr_present_sections whenever
> we find a present section.
>
> So, for_each_present_section_nr() should return the same nr of section as nr_present_sections.
> Since we only increment nr_consumed_maps once in the loop, I am not so sure we can
> go beyond nr_present_sections.
>
> Did I overlook something?

You did not, this is basically a safety check. A BUG_ON() would be
better here. As, this something that should really not happening, and
would mean a bug in the current project.
