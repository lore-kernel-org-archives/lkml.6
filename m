Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEE0C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0B12086A
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0B12086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ah.jp.nec.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731044AbeKGJDn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 04:03:43 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:50011 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730409AbeKGJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 04:03:42 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id wA6NZpU0008541
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 7 Nov 2018 08:35:51 +0900
Received: from mailsv02.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA6NZp5p018111;
        Wed, 7 Nov 2018 08:35:51 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv02.nec.co.jp (8.15.1/8.15.1) with ESMTP id wA6NZYHh016145;
        Wed, 7 Nov 2018 08:35:51 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.150] [10.38.151.150]) by mail03.kamome.nec.co.jp with ESMTP id BT-MMP-5307525; Wed, 7 Nov 2018 08:32:09 +0900
Received: from BPXM23GP.gisp.nec.co.jp ([10.38.151.215]) by
 BPXC22GP.gisp.nec.co.jp ([10.38.151.150]) with mapi id 14.03.0319.002; Wed, 7
 Nov 2018 08:32:08 +0900
From:   Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
To:     Balbir Singh <bsingharora@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hotplug: Optimize clear_hwpoisoned_pages
Thread-Topic: [PATCH] mm/hotplug: Optimize clear_hwpoisoned_pages
Thread-Index: AQHUdijujEsMTOdnTk2OJ4lTNggnAg==
Date:   Tue, 6 Nov 2018 23:32:08 +0000
Message-ID: <20181106233207.GA10086@hori1.linux.bs1.fc.nec.co.jp>
References: <20181102120001.4526-1-bsingharora@gmail.com>
In-Reply-To: <20181102120001.4526-1-bsingharora@gmail.com>
Accept-Language: en-US, ja-JP
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.51.8.82]
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <915B1044C3DC1F46A94DA8D832A6F625@gisp.nec.co.jp>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2018 at 11:00:01PM +1100, Balbir Singh wrote:
> In hot remove, we try to clear poisoned pages, but
> a small optimization to check if num_poisoned_pages
> is 0 helps remove the iteration through nr_pages.
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>

Acked-by: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>

Thanks!
