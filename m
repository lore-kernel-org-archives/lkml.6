Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C015C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA1CA20874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 01:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JkIBthJl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA1CA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754173AbeFUBmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 21:42:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754079AbeFUBmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 21:42:15 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5L1cqv8021399
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=0O5lJHUS3FTNwACyC87ZJCucZgIv/u4qglMoLba5z5g=;
 b=JkIBthJlYGHWUSA5Z43luFHsAo/CeIbLt2U+g3l8WGEGFW8DYNhw1aHIAEuu5vD+IQfp
 2+a4g0n7ixfcxWmhjrdEPuot0hITsfAHt3vyGPr41MwVbWfSwc8ivYBU45Ai8jqumsTf
 6YZ1FREgO2T8pkmshSQ1e67HubD4QeUB0xZoFcdKGePi7ATQ2Nl0TJHdkKZ5sDqT3sh8
 NAvtj82BeLw8QTcKiXEZSb1h0uoTPmHqo/hcxappbENHmsfae0zDATuchdcvI19oPTRq
 foB+QB+dcqtCZiw0DBDzacsRJxWOrKWk/Jl1RuE5dbuvCbFPf+0NqRSkskq8Ea1O/Rsr Cw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2120.oracle.com with ESMTP id 2jmtgwxt2e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:42:14 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5L1gCHO009978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:42:13 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5L1gCFp011919
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 01:42:12 GMT
Received: from mail-ot0-f170.google.com (/74.125.82.170)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 18:42:12 -0700
Received: by mail-ot0-f170.google.com with SMTP id q17-v6so1737563otg.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 18:42:12 -0700 (PDT)
X-Gm-Message-State: APt69E2iUqKeUehaTZc+kJ2Vsv6PoVwE/3SW+FgcYfOd40mcO4m2sW6y
        4Lg5AVZEkLI+gG3lAr2IcTxOWTu+lQPfTEFau6M=
X-Google-Smtp-Source: ADUXVKLA9rCif7StOCaDip6pAIQjpq1NTKDIAJyyKbJzrHVUuhXCCWe9SyYrlxFucsueZxC61lI7AOFvADi2OmAhPGU=
X-Received: by 2002:a9d:4305:: with SMTP id s5-v6mr13491985ote.11.1529545331760;
 Wed, 20 Jun 2018 18:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180601125321.30652-1-osalvador@techadventures.net>
 <20180601125321.30652-2-osalvador@techadventures.net> <20180620151819.3f39226998bd80f7161fcea5@linux-foundation.org>
In-Reply-To: <20180620151819.3f39226998bd80f7161fcea5@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Wed, 20 Jun 2018 21:41:35 -0400
X-Gmail-Original-Message-ID: <CAGM2reYgrpBrfhcw0O7K+sMU-qE-U_+2MzJWsG=7gSbU8n-=kA@mail.gmail.com>
Message-ID: <CAGM2reYgrpBrfhcw0O7K+sMU-qE-U_+2MzJWsG=7gSbU8n-=kA@mail.gmail.com>
Subject: Re: [PATCH 1/4] mm/memory_hotplug: Make add_memory_resource use __try_online_node
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     osalvador@techadventures.net, Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=894
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806210016
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't think __try_online_node() will ever return a value greater than
> zero.  I assume what was meant was

Hi Andrew and Oscar,

Actually, the new __try_online_node()  returns:
1 -> a new node was allocated
0 -> node is already online
-error -> an error encountered.

The function simply missing the return comment at the beginning.

Oscar, please check it via ./scripts/checkpatch.pl

Add comment explaining the return values.

And change:
        ret = __try_online_node (nid, start, false);
        new_node = !!(ret > 0);
        if (ret < 0)
                goto error;
To:
        ret = __try_online_node (nid, start, false);
        if (ret < 0)
                goto error;
        new_node = ret;

Other than that the patch looks good to me, it simplifies the code.
So, if the above is addressed:

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Thank you,
Pavel

>
>         new_node = !!(ret >= 0);
>
> which may as well be
>
>         new_node = (ret >= 0);
>
> since both sides have bool type.
>
> The fact that testing didn't detect this is worrisome....
>
> > +     if (ret < 0)
> > +             goto error;
> > +
> >
> >       /* call arch's memory hotadd */
> >       ret = arch_add_memory(nid, start, size, NULL, true);
> > -
> >       if (ret < 0)
> >               goto error;
> >
> >
> > ...
> >
>
