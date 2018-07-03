Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A23221F44
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 03:03:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EGVsoveo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A23221F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932441AbeGCDDs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 23:03:48 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60894 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753841AbeGCDDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 23:03:41 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w632whDK167829
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 03:03:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 references : in-reply-to : from : date : message-id : subject : to : cc :
 content-type; s=corp-2017-10-26;
 bh=dxbu4nA2nP/MbwitFReqzU5AdYkvVGJGwH3yEmljLT0=;
 b=EGVsoveof28X1WnkRH44dB78CfcITSMGFBjR61C/e11x5j6cCXsfAb8UyTy/AxhGT281
 rkhU8sWtT53WeSyeTDoRl33e9Nsa8m1KbKZPqyMdDAw/p8i+mGemb2QbtHXirsKMF41W
 Mez0ElVfMJ1pdrXTGLujqcsQqGSysJsEGPySXNe3ge5vuKhSoBhiOtY6Bme3E/R8kEuy
 TXF40UCQsJFW8IthoJGlAGtgRtqZUQPpjYiL5ZvEfTaq/8pCca8qrrOctlnK7dk4p6Bn
 R8+lwXzC+7cht+hHN9B4CwRKclVRdppI2GtAqcoO9TmwWt6BX/UEG9+o155AyFbLrr3/ dw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2jwyccpuvm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 03:03:40 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w6333cjs011938
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 03:03:38 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6333bhg026757
        for <linux-kernel@vger.kernel.org>; Tue, 3 Jul 2018 03:03:38 GMT
Received: from mail-oi0-f51.google.com (/209.85.218.51)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 02 Jul 2018 20:03:37 -0700
Received: by mail-oi0-f51.google.com with SMTP id c6-v6so922744oiy.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 20:03:37 -0700 (PDT)
X-Gm-Message-State: APt69E14qrbo/vlXEJzTxXo+JYRWOioEt2zMfBRuOJAd0uhLMnYtMUFe
        o1tW5mO6cQ/slu4Gth/8NUdHqpOJsmRSfUZ+plE=
X-Google-Smtp-Source: AAOMgpcSx2whwLriO4URYWLbdCiXjEiawvTmWK/0i0rkk/0Lrob7RJHCOqzQMrYSPQUvbq0RRdMFFQcDF2Hl0Q8FneI=
X-Received: by 2002:aca:edc1:: with SMTP id l184-v6mr17468960oih.65.1530587017079;
 Mon, 02 Jul 2018 20:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <1530239363-2356-1-git-send-email-hejianet@gmail.com>
 <1530239363-2356-3-git-send-email-hejianet@gmail.com> <CAGM2reYn3ZbdjhcZze8Zt1eLNSdWghy0KwEXfd5xW+1Ba_SMbw@mail.gmail.com>
 <bfe24a3b-c982-9532-c05b-f42ebb77bbba@gmail.com>
In-Reply-To: <bfe24a3b-c982-9532-c05b-f42ebb77bbba@gmail.com>
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
Date:   Mon, 2 Jul 2018 23:03:01 -0400
X-Gmail-Original-Message-ID: <CAGM2rebfdacH5imNtU+6bEOCGLhgpp=Kc9o9ooJx-os6keNkDw@mail.gmail.com>
Message-ID: <CAGM2rebfdacH5imNtU+6bEOCGLhgpp=Kc9o9ooJx-os6keNkDw@mail.gmail.com>
Subject: Re: [PATCH v9 2/6] mm: page_alloc: remain memblock_next_valid_pfn()
 on arm/arm64
To:     Jia He <hejianet@gmail.com>
Cc:     linux@armlinux.org.uk, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mel Gorman <mgorman@suse.de>, will.deacon@arm.com,
        mark.rutland@arm.com, hpa@zytor.com,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Gioh Kim <gi-oh.kim@profitbricks.com>,
        Steven Sistare <steven.sistare@oracle.com>, neelx@redhat.com,
        erosca@de.adit-jv.com, Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        james.morse@arm.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        steve.capper@arm.com, tglx@linutronix.de, mingo@redhat.com,
        gregkh@linuxfoundation.org,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kemi.wang@intel.com,
        =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <ptesarik@suse.com>,
        yasu.isimatu@gmail.com, aryabinin@virtuozzo.com, nborisov@suse.com,
        Wei Yang <richard.weiyang@gmail.com>, jia.he@hxt-semitech.com
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=634
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030033
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you put it into memblock.c

> Do you think it looks ok if I add the inline prefix?

I would say no, this function is a too complex, and is not in some
critical path to be always inlined.

 I would put it into memblock.c, and have #ifdef
CONFIG_HAVE_MEMBLOCK_PFN_VALID around it.

Thank you,
Pavel
