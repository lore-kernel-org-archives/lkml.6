Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF6DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:01:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07B9720871
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 18:01:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XPIC0OPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B9720871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934222AbeGISBd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 14:01:33 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:34570 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933795AbeGISBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 14:01:31 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w69HwZVw069928
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 18:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2018-07-02;
 bh=C9x7HvJmSY0v7B0PLu4KFwqJ1JLnkoBvQLyJuV1h9rY=;
 b=XPIC0OPlyit9csr3DoDkEfGqzwGRRl5CZ+k28sHMgwcjE6qAhXSlsy8URxZFLnWnPECz
 Qc6tEiOZ2Cx1UTe6hMxA6Wy+VQ5Vj5jR6wdznwCL9PeUl+kUZ9R5BHeFnP31dP4pyfEg
 HiG4bqBiyA9aHlYXYJrYnVLvjTmVcHVykJp1Vxle6jmOvlSAsljIfTGaeZeAMBKd//zY
 eW9pWje+ymWA5Wm5+IrgftVDho2qw46XJVtlcJJM7GiPte5+Sd5qtdQ9yfqsrvHBtcEg
 TTLaWBCMg22PFx2PzMkytdpLPTRfTAsaU7ffUzyMSTpLLUwTGiS4thHQrmDcTMjZNKah 3Q== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p75wb4c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 18:01:30 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w69I1UVT027994
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 18:01:30 GMT
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w69I1TJY006987
        for <linux-kernel@vger.kernel.org>; Mon, 9 Jul 2018 18:01:30 GMT
Received: from mail-oi0-f41.google.com (/209.85.218.41)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 09 Jul 2018 11:01:29 -0700
Received: by mail-oi0-f41.google.com with SMTP id 13-v6so37566042ois.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 11:01:29 -0700 (PDT)
X-Gm-Message-State: APt69E0FZpJNXxlZoUBxPkTc01yG1QK8abXnwFyPgZuqIFNChzlhfFRU
        qEoqtB95H9UVOj72nwXytErYkuIbz1rqN+nqA9w=
X-Google-Smtp-Source: AAOMgpepKeHfS2Z2lD7WYaC5HuAayXDA1Iil9sczUpLJ+X5EuYlTrcjPAB0mCWN/ZLf8m0irkPfG6UhEbdXfCDbf2N0=
X-Received: by 2002:aca:da88:: with SMTP id r130-v6mr24632722oig.163.1531159289122;
 Mon, 09 Jul 2018 11:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch> <20180709083650.23549-6-daniel.vetter@ffwll.ch>
In-Reply-To: <20180709083650.23549-6-daniel.vetter@ffwll.ch>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 9 Jul 2018 14:00:52 -0400
X-Gmail-Original-Message-ID: <CAGM2reYoHuB25eUFgHCaiL-453G1LUgh=Gx1g9PWus3ztr3_mA@mail.gmail.com>
Message-ID: <CAGM2reYoHuB25eUFgHCaiL-453G1LUgh=Gx1g9PWus3ztr3_mA@mail.gmail.com>
Subject: Re: [PATCH 06/12] mm: use for_each_if
To:     daniel.vetter@ffwll.ch
Cc:     LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        daniel.vetter@intel.com, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>, mgorman@techsingularity.net,
        rientjes@google.com, kemi.wang@intel.com,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.com>,
        yasu.isimatu@gmail.com, aryabinin@virtuozzo.com, nborisov@suse.com,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=363
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807090204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LGTM:

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
