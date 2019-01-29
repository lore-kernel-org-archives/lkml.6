Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88A36C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F92E2175B
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbfA2DqE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:46:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:40034 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726843AbfA2DqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:46:04 -0500
X-UUID: a032271e0a8644039eaab1da89e4fc61-20190129
X-UUID: a032271e0a8644039eaab1da89e4fc61-20190129
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1622491935; Tue, 29 Jan 2019 11:45:58 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkexhb01.mediatek.inc (172.21.101.102) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 11:45:57 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 29 Jan 2019 11:45:57 +0800
Message-ID: <1548733557.9796.13.camel@mtkswgap22>
Subject: Re: [PATCH v2] mm/slub: introduce SLAB_WARN_ON_ERROR
From:   Miles Chen <miles.chen@mediatek.com>
To:     David Rientjes <rientjes@google.com>
CC:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date:   Tue, 29 Jan 2019 11:45:57 +0800
In-Reply-To: <alpine.DEB.2.21.1901281739230.216488@chino.kir.corp.google.com>
References: <1548313223-17114-1-git-send-email-miles.chen@mediatek.com>
         <alpine.DEB.2.21.1901281739230.216488@chino.kir.corp.google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-01-28 at 17:41 -0800, David Rientjes wrote:
> On Thu, 24 Jan 2019, miles.chen@mediatek.com wrote:
> 
> > From: Miles Chen <miles.chen@mediatek.com>
> > 
> > When debugging slab errors in slub.c, sometimes we have to trigger
> > a panic in order to get the coredump file. Add a debug option
> > SLAB_WARN_ON_ERROR to toggle WARN_ON() when the option is set.
> > 
> 
> Wouldn't it be better to enable/disable this for all slab caches instead 
> of individual caches at runtime?  I'm not sure excluding some caches 
> because you know they'll WARN and trigger panic_on_warn unnecessarily is 
> valid since it could be enabled for that cache as well through this 
> interface.

We can enable this option only for specific slab(s).
e.g., slub_debug=W,dentry
or
enable this option for all slabs
e.g., slub_debug=W

