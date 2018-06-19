Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2FC2C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A226F20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sLxuA2Cr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A226F20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966493AbeFSNve (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:51:34 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45548 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965731AbeFSNvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:51:31 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5JDiE5E104274;
        Tue, 19 Jun 2018 13:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=0F96SoZI8Hgi8HA73WG+z0xkiktTsTAacPey2CNwZEI=;
 b=sLxuA2CrjgfGtyQASSbirxpTRcvGtWth/s2XdWxJFAl6zFFWu2CkTW7ia8v8XGDV/ff2
 WcCaytHflgbM7KPbin/htrJZLv/hTqT8Rfu+mx1O5bxmrHmMz6mHX3uaQDm4qgbcjrxF
 3L6fqzIYEBO9e6mHvXlh3KevAJPtc/HG6KalQTU5y1i8ZLX8j/nWOYhUkwHXblxyBXWA
 +zXethXqwM137UhJb3RjaJeqdKPTV5c6J9106V29B2KFAncVhujZK175qGKrbqD9CXAd
 lffeA6gJubTb+VUW+SgOUoOJ3PZGn15hKt03ohWIwjPeKuO9FupBeGLTsI8nb8n/iOvw wQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xr6d2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 13:51:31 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5JDpUaG031237
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 19 Jun 2018 13:51:30 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5JDpTOs004471;
        Tue, 19 Jun 2018 13:51:29 GMT
Received: from mail-oi0-f42.google.com (/209.85.218.42)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 19 Jun 2018 06:51:29 -0700
Received: by mail-oi0-f42.google.com with SMTP id k190-v6so18191132oib.9;
        Tue, 19 Jun 2018 06:51:29 -0700 (PDT)
X-Gm-Message-State: APt69E3eNbkCqxLXyHh+ZYvnnbm6aToBBrP/9jqgSGjC+TH+56AJHoTA
        mtfNkobjuI/uOZcSkdqWH9LvwUD63zV0nlSRZSs=
X-Google-Smtp-Source: ADUXVKI8/yyHzc0xvmy/D9908s7YWFgUkHmRJSgG0pHBFpiU1xj+ZeRfwsmXsMmayhqSTtkL4/fo/LlIGv3jA/5WWfo=
X-Received: by 2002:aca:db0a:: with SMTP id s10-v6mr9965494oig.339.1529416288874;
 Tue, 19 Jun 2018 06:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20171117014601.31606-1-pasha.tatashin@oracle.com>
 <20171121072416.v77vu4osm2s4o5sq@dhcp22.suse.cz> <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
In-Reply-To: <b16029f0-ada0-df25-071b-cd5dba0ab756@suse.cz>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Tue, 19 Jun 2018 09:50:52 -0400
X-Gmail-Original-Message-ID: <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
Message-ID: <CAGM2rea=_VJJ26tohWQWgfwcFVkp0gb6j1edH1kVLjtxfugf5Q@mail.gmail.com>
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
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8928 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=905
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806190156
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 4:04 AM Jiri Slaby <jslaby@suse.cz> wrote:
>
> On 11/21/2017, 08:24 AM, Michal Hocko wrote:
> > On Thu 16-11-17 20:46:01, Pavel Tatashin wrote:
> >> There is no need to have ARCH_SUPPORTS_DEFERRED_STRUCT_PAGE_INIT,
> >> as all the page initialization code is in common code.
> >>
> >> Also, there is no need to depend on MEMORY_HOTPLUG, as initialization code
> >> does not really use hotplug memory functionality. So, we can remove this
> >> requirement as well.
> >>
> >> This patch allows to use deferred struct page initialization on all
> >> platforms with memblock allocator.
> >>
> >> Tested on x86, arm64, and sparc. Also, verified that code compiles on
> >> PPC with CONFIG_MEMORY_HOTPLUG disabled.
> >
> > There is slight risk that we will encounter corner cases on some
> > architectures with weird memory layout/topology
>
> Which x86_32-pae seems to be. Many bad page state errors are emitted
> during boot when this patch is applied:

Hi Jiri,

Thank you for reporting this bug.

Because 32-bit systems are limited in the maximum amount of physical
memory, they don't need deferred struct pages. So, we can add depends
on 64BIT to DEFERRED_STRUCT_PAGE_INIT in mm/Kconfig.

However, before we do this, I want to try reproducing this problem and
root cause it, as it might expose a general problem that is not 32-bit
specific.

Thank you,
Pavel
