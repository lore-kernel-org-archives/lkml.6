Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A41CC43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3070525ABF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 03:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HVmje7+b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3070525ABF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeF1DLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 23:11:21 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43136 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753056AbeF1DLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 23:11:19 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5S38io2088192
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:11:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=JcYgWyk5JGBCoK/+mIb+Pv+xD0h8a+UXWDZAJ6JKwz4=;
 b=HVmje7+bFsA23wNMeLnZRPEFXHc7MrHVpkuJTuFp/Fa+7vhcfwSY4RSkIrqEUuAQw8Dv
 ogHXuUQ6akXMs8P6fF+qzVCDza8j++NwCT4Z98P3oXY5Olc1EoVD9fZxsHji3sBS245N
 yxHqoL+P4vZEaGZXKbNd5G2+ACa0fFZBmwSe2uUCEEgvU9Y7w1YUwY35XZ8rLBVH1tqH
 lTScEkyU4MMIqxHG/TYyDEP+jW6DZ2h6ybOrOjdCBGruXlQtJ6YyQlbGVD9ca3/EMKZe
 S+IOJfznIgP5A/nsEWLEMu2KL2gPJiV7AjAR/sezsqW/PkRy1kwGppsG23+VpDFBP8jD mA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jum0a7k3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:11:18 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5S3BHE4009646
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:11:18 GMT
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5S3BH0c021147
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jun 2018 03:11:17 GMT
Received: from mail-oi0-f44.google.com (/209.85.218.44)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 27 Jun 2018 20:11:17 -0700
Received: by mail-oi0-f44.google.com with SMTP id c2-v6so3831330oic.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 20:11:17 -0700 (PDT)
X-Gm-Message-State: APt69E0e81uV+2q7lpKjNv3pQ0IhRytq6jCvhvItSaU+hWwrpCjgENuZ
        DRL4iVjDx9NGnDih1JMhkTwF1RAnuVPL57ntlZ0=
X-Google-Smtp-Source: AAOMgpdvxrTELl4QNBcaMwRkCqKv7oPaGczWAMIrxLWhAG7X4bW3kgiE4JEJ35ViSCyDARagRBYLAo8I3E3kuIrwVoo=
X-Received: by 2002:aca:3b09:: with SMTP id i9-v6mr5047345oia.156.1530155476933;
 Wed, 27 Jun 2018 20:11:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180627013116.12411-1-bhe@redhat.com> <20180627013116.12411-2-bhe@redhat.com>
In-Reply-To: <20180627013116.12411-2-bhe@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 27 Jun 2018 23:10:41 -0400
X-Gmail-Original-Message-ID: <CAGM2reYbGaiMA3fPdSFkcr8PegXY8WqdbCrHmC54rHy22mucYw@mail.gmail.com>
Message-ID: <CAGM2reYbGaiMA3fPdSFkcr8PegXY8WqdbCrHmC54rHy22mucYw@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] mm/sparse: Add a static variable nr_present_sections
To:     bhe@redhat.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        dave.hansen@intel.com, pagupta@redhat.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        kirill.shutemov@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8937 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=760
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806280031
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
On Tue, Jun 26, 2018 at 9:31 PM Baoquan He <bhe@redhat.com> wrote:
>
> It's used to record how many memory sections are marked as present
> during system boot up, and will be used in the later patch.
>
> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  mm/sparse.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/mm/sparse.c b/mm/sparse.c
> index f13f2723950a..6314303130b0 100644
> --- a/mm/sparse.c
> +++ b/mm/sparse.c
> @@ -200,6 +200,12 @@ static inline int next_present_section_nr(int section_nr)
>               (section_nr <= __highest_present_section_nr));    \
>              section_nr = next_present_section_nr(section_nr))
>
> +/*
> + * Record how many memory sections are marked as present
> + * during system bootup.
> + */
> +static int __initdata nr_present_sections;
> +
>  /* Record a memory area against a node. */
>  void __init memory_present(int nid, unsigned long start, unsigned long end)
>  {
> @@ -229,6 +235,7 @@ void __init memory_present(int nid, unsigned long start, unsigned long end)
>                         ms->section_mem_map = sparse_encode_early_nid(nid) |
>                                                         SECTION_IS_ONLINE;
>                         section_mark_present(ms);
> +                       nr_present_sections++;
>                 }
>         }
>  }
> --
> 2.13.6
>
