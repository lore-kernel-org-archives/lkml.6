Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B0FC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CCA2733E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 12:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="phXdoCKA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32CCA2733E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935014AbeF1MQC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 08:16:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48862 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934923AbeF1MP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 08:15:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5SCEB0c166975
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:15:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=d4FgTD/8iTCfR5dm4WMMXnmLs7+PRZJBW5TVC9PSHUI=;
 b=phXdoCKAK7+Gy7J39ekVDWn3YLxh6pd1l5U0RRc29XjE7wlIVrAwwxKgyqF51KlOda1N
 iA+LKq6PB0uqRuT6kTvYwjT/zmklu3MFws+3XtiAbbs/JIp62jIjpUX7HeDBWq7RwhLl
 ERxungs0+Tm1FHRlNRgZ5KzSb+5UlcE11MB/KeQuJJdAcFlvhgZRsg2TvVBTXLWL9BBA
 Aa7MpzNQ8qBDjdqLPeLiysh1WMDDQ5TM7QD/jBcaDscXIISt830woP9swOUuNpwHjkw3
 VhIrBt8faAhDkZnhLT4o+O2Wq6AhYSt25uaVfU9CjxnAyWyTYS2tF+hIlUmlMALjsn/D Pw== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2jum0aa0yj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:15:55 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5SCFsjp010738
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:15:54 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5SCFrVL005877
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 12:15:53 GMT
Received: from mail-ot0-f182.google.com (/74.125.82.182)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 28 Jun 2018 05:15:53 -0700
Received: by mail-ot0-f182.google.com with SMTP id c15-v6so5875470otl.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 05:15:53 -0700 (PDT)
X-Gm-Message-State: APt69E1IC9Mxfl2Y14J4ItfGjjazdEMDL51T0p5fMO3g7fUmEj5gXtQ7
        K8TAW6FZEezkJUP1GTz2quApKGICW9igoGIuIaI=
X-Google-Smtp-Source: AAOMgpcx/1UOreWVDVh/Oc1bNMnI3JcYe4mfC0l+EemNk2YgCBUfmuT3khfje21k7VnRQ2dxR4cqpfu6+or8g9Tq1FA=
X-Received: by 2002:a9d:2e0e:: with SMTP id q14-v6mr3884558otb.275.1530188153336;
 Thu, 28 Jun 2018 05:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180628062857.29658-1-bhe@redhat.com> <20180628062857.29658-6-bhe@redhat.com>
In-Reply-To: <20180628062857.29658-6-bhe@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Thu, 28 Jun 2018 08:15:17 -0400
X-Gmail-Original-Message-ID: <CAGM2reb1=f6mhfuLSWGo2BSSdpherEsRB9-u87b2Q5eT11tJUg@mail.gmail.com>
Message-ID: <CAGM2reb1=f6mhfuLSWGo2BSSdpherEsRB9-u87b2Q5eT11tJUg@mail.gmail.com>
Subject: Re: [PATCH v6 5/5] mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
To:     bhe@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        osalvador@techadventures.net,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=813
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 2:29 AM Baoquan He <bhe@redhat.com> wrote:
>
> Pavel pointed out that the behaviour of allocating memmap together
> for one node should be defaulted for all ARCH-es. It won't break
> anything because it will drop to the fallback action to allocate
> imemmap for each section at one time if failed on large chunk of
> memory.
>
> So remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER and clean up the
> related codes.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Pavel Tatashin <pasha.tatashin@oracle.com>

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
