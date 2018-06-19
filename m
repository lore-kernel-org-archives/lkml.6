Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98C9EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516CC2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 19:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VM/2h8NT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 516CC2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030755AbeFST45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 15:56:57 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48768 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030528AbeFST4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 15:56:52 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JJrfiA179044;
        Tue, 19 Jun 2018 19:56:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=cvmvOEYetQRvox2mdjPCyUCpp4ZGoXnv9HKMwhWGFaU=;
 b=VM/2h8NTlLJDSd1pyBxwzXlK2oMBqlygZX6aKQd9Jf2ntPHJQRju0tVmNqHPB3q/vXuV
 4O74sMx+378yFs/wiW1sS140TI4Tx8NV8qJRyggNz58rCSIN0H0G798eTnp39pPtZvo/
 OjVVecIlkDtYpQY3HfQWESnBPk2Ie0wyOEK5L/aHOpy16cdyYEy2C6tW2sOBdQxTlbpq
 FnY1a59GqoCgLEV3TbNCtTVRxoQ1IKS72dRK8pj07qJaPxcOIan4E4vjAqd5a6Tpcvj0
 3XSWWsNY4Gg350vTYlhxiJxt9eB0svW6qxjJyHrSuMJd2w7tPrbe67BEXpARUJUiIosx AQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xsmy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 19:56:51 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5JJupoq026601
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 19:56:51 GMT
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5JJuoM2026256;
        Tue, 19 Jun 2018 19:56:50 GMT
Received: from mail-ot0-f169.google.com (/74.125.82.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 12:56:50 -0700
Received: by mail-ot0-f169.google.com with SMTP id d19-v6so1063294oti.8;
        Tue, 19 Jun 2018 12:56:50 -0700 (PDT)
X-Gm-Message-State: APt69E1PHIYoZCNiTtG6jlaEYddwOa0Uc4Mc0hrpNu5hrDmh9Zg6DGMP
        OhhDapxP3Wt6ylYdQy3WtHwAI22iPJGuhjFs7wU=
X-Google-Smtp-Source: ADUXVKJLdTWWNCnc1cP3izlx7qWuBAoHM7D8NPzf4g3AGNXNi/fI02MzOL3OUgey9r96KIWaFglQIdSvdYT699mvNjw=
X-Received: by 2002:a9d:2010:: with SMTP id n16-v6mr10497229ota.275.1529438209892;
 Tue, 19 Jun 2018 12:56:49 -0700 (PDT)
MIME-Version: 1.0
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz> <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
 <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
In-Reply-To: <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 19 Jun 2018 15:56:13 -0400
X-Gmail-Original-Message-ID: <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
Message-ID: <CAGM2reYcwyOcKrO=WhB3Cf0FNL3ZearC=KvxmTNUU6rkWviQOg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: relax deferred struct page requirements
To:     jslaby@suse.cz
Cc:     mhocko@kernel.org, Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        benh@kernel.crashing.org, paulus@samba.org,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com,
        Reza Arbab <arbab@linux.vnet.ibm.com>, schwidefsky@de.ibm.com,
        Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>, tglx@linutronix.de,
        linuxppc-dev@lists.ozlabs.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-s390@vger.kernel.org, mgorman@techsingularity.net
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8929 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=884
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190217
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 9:50 AM Pavel Tatashin
<pasha.tatashin@oracle.com> wrote:
>
> On Sat, Jun 16, 2018 at 4:04 AM Jiri Slaby <jslaby@suse.cz> wrote:
> >
> > On 11/21/2017, 08:24 AM, Michal Hocko wrote:
> > > On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
> > >> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> > >> as all the page initialization code is in common code.
> > >>
> > >> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> > >> does not really use hotplug memory functionality. So, we can remove this
> > >> requirement as well.
> > >>
> > >> This patch allows to use deferred struct page initialization on all
> > >> platforms with memblock allocator.
> > >>
> > >> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> > >> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> > >
> > > There is slight risk that we will encounter corner cases on some
> > > architectures with weird memory layout/topology
> >
> > Which x86_32-pae seems to be. Many bad page state errors are emitted
> > during boot when this patch is applied:
>
> Hi Jiri,
>
> Thank you for reporting this bug.
>
> Because 32-bit systems are limited in the maximum amount of physical
> memory, they don't need deferred struct pages. So, we can add depends
> on 64BIT to DEFERRED_STRUCT_PAGE_INIT in mm/Kconfig.
>
> However, before we do this, I want to try reproducing this problem and
> root cause it, as it might expose a general problem that is not 32-bit
> specific.

Hi Jiri,

Could you please attach your config and full qemu arguments that you
used to reproduce this bug.

Thank you,
Pavel


>
> Thank you,
> Pavel
