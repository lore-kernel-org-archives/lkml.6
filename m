Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0FC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F7E327EFE
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 14:13:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oW+QIRKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F7E327EFE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755549AbeF2OM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 10:12:56 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58428 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbeF2OMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 10:12:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5TE98gX135285
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:12:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=+Vd/ICY6MD5O6c7sqppK5s/vAwX4MUHWIKSAk2qARQk=;
 b=oW+QIRKfsr9IzPHYE1g8nBImI53XsPcQw8NbR1r/MivStyx8cmniLtWelNCRDHDKBho4
 Zz7/PXMc/JeuVHgSpRLOu6G4RFRFkdcF04iau4DXFDpbO506e7juTxqY6gmcOxSfxliu
 9k6+k+0D+AvhhvjqRbhZPOmL1cTCm31aJLXUfSJlOxlmPCXIkdaolC/FddS/o77EsyXO
 qTelphl+qWczHKbfSR2gs3CUOWScjcpcMsRvMje0v0LiP/YAc4wfBmYUkExpKBdhkhO4
 AeW3Z7k3gwCbFAGqW2DEOUnRsrNnu57ejxfYnhNwtixEntVrxVsfVLTVSgRqOrgRACPX 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2jukhspss4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:12:54 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w5TECrJd013019
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:12:53 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5TECqmD023519
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 14:12:52 GMT
Received: from mail-oi0-f47.google.com (/209.85.218.47)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 Jun 2018 07:12:52 -0700
Received: by mail-oi0-f47.google.com with SMTP id n84-v6so8561956oib.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jun 2018 07:12:52 -0700 (PDT)
X-Gm-Message-State: APt69E0zk/8xOQ5Qt9onJpTnVTKV7/3oSy6nGFDYzIupYeHjbQtrW3bC
        PLVD58apMeMhbi4X6NJuY9ZuY1ZQXiDuwSq8oo8=
X-Google-Smtp-Source: AAOMgpdtsebWe+1CAgGQUrDjxjp3bNQfbzEuZ8S2fW05A/HOh6jLZJWT5cjW6PQ+T+dMQfQ52ArYMcrvdihN81TReD8=
X-Received: by 2002:aca:e089:: with SMTP id x131-v6mr3183421oig.221.1530281572596;
 Fri, 29 Jun 2018 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <1530279308-24988-1-git-send-email-rppt@linux.vnet.ibm.com>
In-Reply-To: <1530279308-24988-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Fri, 29 Jun 2018 10:12:16 -0400
X-Gmail-Original-Message-ID: <CAGM2reZvBhfW314XcR7srQhZf-bZMyCXR+9_X4Qtro7i-don5g@mail.gmail.com>
Message-ID: <CAGM2reZvBhfW314XcR7srQhZf-bZMyCXR+9_X4Qtro7i-don5g@mail.gmail.com>
Subject: Re: [PATCH] mm: make DEFERRED_STRUCT_PAGE_INIT explicitly depend on SPARSEMEM
To:     rppt@linux.vnet.ibm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8938 signatures=668703
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=630
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1806290152
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is something I also wanted to see, thank you.

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
