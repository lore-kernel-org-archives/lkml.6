Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A153FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:10:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57965208E3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 15:10:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CV4Stoql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57965208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732693AbeGLPUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 11:20:02 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44968 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbeGLPUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 11:20:02 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6CEwhOT134273;
        Thu, 12 Jul 2018 15:10:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=xTdcDNapBbWvyWlNIIpCyH8/uVEfqy2vR2XM18aLlGA=;
 b=CV4StoqlcIY+F2cCzL+HTUlpVyN+lhSZCwcbWJ3THgVZB+EqHCK5eVH8XKrMdHuMtG29
 oGgbDbhj8tV1T2eL3+o4uaVAxpirJlneCaNs4d1gmj8F3Kenw/0Dr17OSBDgn/JgU3IH
 5g+RNb/vxwANZo8NSFzKpFmTKchGizHKkAAiXRplV1lUC8lHDc5cculr9bR5cyFW7tvA
 IfEevxRRULGiDJ4F/VnggooFR5yeONyyp5WCnui9m8x8p2k1211RQExr7wyjGGXAI+jm
 IZaEyPzZ12AFMpatNyXk8q3Nk2ih3yu/K79v7GoNxpNp6sFAj/DMl7vUitBCjgMvSGW7 wA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2k2p7e4441-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 15:10:02 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6CF9veb018316
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 15:09:58 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6CF9vcx005529;
        Thu, 12 Jul 2018 15:09:57 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Jul 2018 08:09:57 -0700
Received: by mail-oi0-f44.google.com with SMTP id l10-v6so9713075oii.0;
        Thu, 12 Jul 2018 08:09:56 -0700 (PDT)
X-Gm-Message-State: AOUpUlFCZB9iSoUssgLG6/vMrzXp4kNaCSf+R75+by/oRatuOpP2GRZK
        5MxPT+ptuy5/hlXqdb2/aOQIyHELafFWQWewkKY=
X-Google-Smtp-Source: AAOMgpdRAVtsbrqIrewCgko0bxq+LwgguCfNcJnunY4XbulXUwSnVGT2iJ8mmXmT1LDnqsbnrLRUcVX/1rP6Aoahpx4=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr2556543oig.221.1531408196500;
 Thu, 12 Jul 2018 08:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20180710235044.vjlRV%akpm@linux-foundation.org>
 <87lgai9bt5.fsf@concordia.ellerman.id.au> <20180711133737.GA29573@techadventures.net>
 <CAGM2reYsSi5kDGtnTQASnp1v49T8Y+9o_pNxmSq-+m68QhF2Tg@mail.gmail.com>
 <CAOXBz7ixEK85S-029XrM4+g4fxtSY6_tke0gcQ-hOXFCb7wcZg@mail.gmail.com>
 <87efg981rd.fsf@concordia.ellerman.id.au> <20180712095002.GA5342@techadventures.net>
In-Reply-To: <20180712095002.GA5342@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 12 Jul 2018 11:09:20 -0400
X-Gmail-Original-Message-ID: <CAGM2reb=KeLH7KKUP+7-u27nJxvTcBskhtS2cDH8SwiiEZ1jNQ@mail.gmail.com>
Message-ID: <CAGM2reb=KeLH7KKUP+7-u27nJxvTcBskhtS2cDH8SwiiEZ1jNQ@mail.gmail.com>
Subject: Re: Boot failures with "mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER"
 on powerpc (was Re: mmotm 2018-07-10-16-50 uploaded)
To:     osalvador@techadventures.net
Cc:     mpe@ellerman.id.au, osalvador.vilardaga@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        mhocko@suse.cz, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, mm-commits@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, bhe@redhat.com,
        aneesh.kumar@linux.ibm.com, khandual@linux.vnet.ibm.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=708
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807120158
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 5:50 AM Oscar Salvador
<osalvador@techadventures.net> wrote:
>
> > > I just roughly check, but if I checked the right place,
> > > vmemmap_populated() checks for the section to contain the flags we are
> > > setting in sparse_init_one_section().
> >
> > Yes.
> >
> > > But with this patch, we populate first everything, and then we call
> > > sparse_init_one_section() in sparse_init().
> > > As I said I could be mistaken because I just checked the surface.

Yes, this is right, sparse_init_one_section() is needed after every
populate call on ppc64. I am adding this to my sparse_init re-write,
and it actually simplifies code, as it avoids one extra loop, and
makes ppc64 to work.

Pavel
