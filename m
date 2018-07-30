Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F6A13F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 637D220894
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 14:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="omsEQSZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 637D220894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbeG3PqK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:46:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48494 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbeG3PqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:46:08 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6UE8rdo181222
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=ZmZgMWg7qNJdaV2KwClTNnNHABqTAulkQetC3rYphJQ=;
 b=omsEQSZMFN+0yF6CqowiFDnViAR2af/DvSjtulqmDgvvCWwCigpxRujjWsEp1lC6Y1ZG
 wZ66AiyHF1eVHsdNgN+g07S2xq1nSUF9JSwduFWoE82aTfUKVnokey7kBEbD59f9221I
 6rS0A3+5rwL9r0PQNBstrSFnW18Ho5M5YltscaU+lKiDt2EQrGBUf+8JMfQCet2daq2K
 WI/ntAydZxlkEcIsuB2UF4skMRJ6wRzKvzBlbVc0ECCIWaSgNRlxI0eufBjU2K4KTeC4
 ZvoY3M0RPBnm8yfpmkK5valp9IpK3FMmIqeEidt89+icDAzPvb51E09dpmjHz1nPIhzt bg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2kgh4pvk6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:10:56 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6UEAtwI009385
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:10:55 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6UEAsun009330
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:10:55 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Jul 2018 07:10:54 -0700
Received: by mail-oi0-f47.google.com with SMTP id n84-v6so21444699oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 07:10:54 -0700 (PDT)
X-Gm-Message-State: AOUpUlH0duydwW6m9cTCBWl8d1BMfIEYVHlarQkQZFXBR2l77klEkU/F
        P3NaP7JkiE1pe7uHFsxnmpwNw6GCwiKbeVofp1E=
X-Google-Smtp-Source: AAOMgpek9CEe01p0RUP83MMeatL6TNw+mzMhuxKUgIFp+d3i1RTm9qsznJsrvyqno14vP+4Q65bFAI/3+YC3/AuYYK8=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr16826049oih.65.1532959854517;
 Mon, 30 Jul 2018 07:10:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180730133718.28683-1-osalvador@techadventures.net>
In-Reply-To: <20180730133718.28683-1-osalvador@techadventures.net>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 30 Jul 2018 10:10:18 -0400
X-Gmail-Original-Message-ID: <CAGM2reYo+3ONoLQqD8tQMMKuQ5ZPJf6CjpcahHeMtNQ-B1FuRA@mail.gmail.com>
Message-ID: <CAGM2reYo+3ONoLQqD8tQMMKuQ5ZPJf6CjpcahHeMtNQ-B1FuRA@mail.gmail.com>
Subject: Re: [PATCH] mm: Remove zone_id() and make use of zone_idx() in is_dev_zone()
To:     osalvador@techadventures.net
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>, rientjes@google.com,
        kemi.wang@intel.com, jia.he@hxt-semitech.com,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.com>,
        aryabinin@virtuozzo.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, dan.j.williams@intel.com,
        osalvador@suse.de
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8969 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=700
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807300157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 9:37 AM <osalvador@techadventures.net> wrote:
>
> From: Oscar Salvador <osalvador@suse.de>
>
> is_dev_zone() is using zone_id() to check if the zone is ZONE_DEVICE.
> zone_id() looks pretty much the same as zone_idx(), and while the use of
> zone_idx() is quite spread in the kernel, zone_id() is only being
> used by is_dev_zone().
>
> This patch removes zone_id() and makes is_dev_zone() use zone_idx()
> to check the zone, so we do not have two things with the same
> functionality around.
>
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

Thank you:
Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
