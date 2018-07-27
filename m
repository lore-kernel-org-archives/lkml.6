Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E480C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1608C205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 14:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GxSYFsSD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1608C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388503AbeG0QQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 12:16:21 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:38788 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730714AbeG0QQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 12:16:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6REhxlT134277
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:54:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ccFNO2RC5TnSnUSGrld7JQAt/erF48OCW+LVyrfhryU=;
 b=GxSYFsSDHI5gIkoxeQvDLpTbGVGIr1pHPyoH/86cT9FKF+n/sBAZRXdwobmhjCrmRNb7
 ZbFKhnYnsIaKWXyIAO3MjG5yTrrldx6WBOM0lKUoccRRShYUUgWB1GeQnwyihXHfyprR
 kAA0Tcgmd5srWoOhn5234XlgEk7EiGeMt6Wv4meUxI0wcaxIpjCrxJjBAK/wm2JnOPFX
 I3o5F1st9MEUa1ZJEZ+U41PMq+UX/JAnWc/dYgq+UM14k509APbHpONInRn+QRBIHqH0
 DMksfl+rePTLwHoU1oKbxyQe3jY4/5W/5BR8X+fm5o4JstD5wahSwR5zQmHWYB81EVyH Zw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2kbv8tfm1k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:54:03 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6REs1b1025369
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:54:01 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6REs14b015483
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 14:54:01 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 27 Jul 2018 07:54:00 -0700
Received: by mail-oi0-f47.google.com with SMTP id k12-v6so9513672oiw.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jul 2018 07:54:00 -0700 (PDT)
X-Gm-Message-State: AOUpUlFuzJxqIXqwe5r2h6c7SP9AUVaEziMfRylx9oUOdMig1gXN/v3Y
        X2A16A+hIkiuz1c5BUtEf1wy6XLgrE4DQsEMrrY=
X-Google-Smtp-Source: AAOMgpcg/1n1qjdXUvJygdZJ1i51jFo1Q+ogNiYVFGb4djIF4ZQMwMJoCz269Qc/5TFgYjkbMvzw+ThxthklU6mcYD8=
X-Received: by 2002:a54:4f88:: with SMTP id g8-v6mr7226312oiy.191.1532703240360;
 Fri, 27 Jul 2018 07:54:00 -0700 (PDT)
MIME-Version: 1.0
References: <20180726193509.3326-1-pasha.tatashin@oracle.com>
 <20180726193509.3326-3-pasha.tatashin@oracle.com> <20180727115645.GA13637@techadventures.net>
In-Reply-To: <20180727115645.GA13637@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 27 Jul 2018 10:53:24 -0400
X-Gmail-Original-Message-ID: <CAGM2reZnrwy1Y8MFRgyDLG8VZ6Hf+v-PAmZvUG4H65zunmjWZw@mail.gmail.com>
Message-ID: <CAGM2reZnrwy1Y8MFRgyDLG8VZ6Hf+v-PAmZvUG4H65zunmjWZw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mm: calculate deferred pages after skipping
 mirrored memory
To:     osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kirill.shutemov@linux.intel.com, Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        dan.j.williams@intel.com, jack@suse.cz, jglisse@redhat.com,
        Souptick Joarder <jrdr.linux@gmail.com>, bhe@redhat.com,
        gregkh@linuxfoundation.org, Vlastimil Babka <vbabka@suse.cz>,
        Wei Yang <richard.weiyang@gmail.com>, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8966 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=793
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807270152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

                         unsigned long *nr_initialised)
> > +static bool __meminit
> > +defer_init(int nid, unsigned long pfn, unsigned long end_pfn)
>
> Hi Pavel,
>
> maybe I do not understand properly the __init/__meminit macros, but should not
> "defer_init" be __init instead of __meminit?
> I think that functions marked as __meminit are not freed up, right?

Not exactly. As I understand: __meminit is the same as __init when
CONFIG_MEMORY_HOTPLUG=n. But, when memory hotplug is configured,
__meminit is not freed, because code that adds memory is shared
between boot and hotplug. In this case defer_init() is called only
during boot, and could be __init, but it is called from
memmap_init_zone() which is __meminit and thus section mismatch would
happen.

We could split memmap_init_zone() into two functions: boot and hotplug
variants, or we could use __ref, but I do not think any of that is
really needed. Keeping defer_init() in __meminit is OK, it does not
take that much memory.

>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thank you,
Pavel
