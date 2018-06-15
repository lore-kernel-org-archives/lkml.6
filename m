Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6334EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239F20C0B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 19:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iCAT/bky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B239F20C0B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966100AbeFOTdD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 15:33:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:56416 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965768AbeFOTdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 15:33:02 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5FJTI0M015457
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:33:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=RpERRARaJ0TtYWNqnw6ne/1Ffw/lPL62gPnHjxn2jrc=;
 b=iCAT/bkyeL/cnVfQroxvb6cIrLq/bYcYjZPBk19N7p9D/UVYY+nrVgUviwYfMIarr438
 D3SDFiMpU6uCjVJGjhSl9TjnJ51dnT+Lt2+0adYKuK7JNCa6DgvynixXADRS0GQ8aT/G
 oMuWtS3IBaaB5Xefg/qULes+k/s26dXhzjWi2JhXADKTDaYCpiMfCqF9tNWMc/icfcgE
 ePNDgZHwf3bFSXgdDquPH+3W6rqQWKq1knJBega0eJTzccg2SCkgOAlklf2oaP+5paNy
 M5e2qp4WCukpQaytM4ypxGzJnDpr24fsFn7q2TJLC/zMuub30b2fbOZy0F1lxh9BZTvP UA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jk0xr2693-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:33:01 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5FJWxm1027430
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:32:59 GMT
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5FJWxXU007060
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 19:32:59 GMT
Received: from mail-ot0-f177.google.com (/74.125.82.177)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Jun 2018 12:32:59 -0700
Received: by mail-ot0-f177.google.com with SMTP id p95-v6so12199661ota.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jun 2018 12:32:59 -0700 (PDT)
X-Gm-Message-State: APt69E0iSdqYn/HD0dgbTiMNvB9IbcZToSR7aTAf+Olaw/iEdfOfLgW4
        maWQcwwT4iUAEqCk96WCd3mqYfQ0cx59UrfbIQs=
X-Google-Smtp-Source: ADUXVKJmn7TDOE5vRoCbAF78+bRH4TJ0sv9EmAzI9yNUMEiZKlvXwMUrN5EFmZaR9ESOrCzx+Fd0eMXHbN4kAq9IkdI=
X-Received: by 2002:a9d:4e12:: with SMTP id p18-v6mr1941026otf.260.1529091179117;
 Fri, 15 Jun 2018 12:32:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180615155733.1175-1-pasha.tatashin@oracle.com> <20180615181113.GA27558@techadventures.net>
In-Reply-To: <20180615181113.GA27558@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 15 Jun 2018 15:32:23 -0400
X-Gmail-Original-Message-ID: <CAGM2rea+sUcewR+Ur58gNFC-fkdnK5_UHh6qgOvARpZ7un2n_A@mail.gmail.com>
Message-ID: <CAGM2rea+sUcewR+Ur58gNFC-fkdnK5_UHh6qgOvARpZ7un2n_A@mail.gmail.com>
Subject: Re: [PATCH] mm: skip invalid pages block at a time in zero_resv_unresv
To:     osalvador@techadventures.net
Cc:     Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>, n-horiguchi@ah.jp.nec.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        osalvador@suse.de, willy@infradead.org, mingo@kernel.org,
        dan.j.williams@intel.com, ying.huang@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=550
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806150208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Pavel,
>
> Thanks for the patch.
> This looks good to me.
>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thank you Oscar!

Pavel
