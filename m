Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094F8C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:20:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3612156B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 14:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="I6dLwrjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3612156B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeI1UoN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 16:44:13 -0400
Received: from a9-92.smtp-out.amazonses.com ([54.240.9.92]:57564 "EHLO
        a9-92.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726349AbeI1UoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 16:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1538144411;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=ZbnARDe+RpOyl48vo7C9HOJDOoa/6QgM3aKRrNmhzPs=;
        b=I6dLwrjWsRv1HtGboAWKQJTUwRxaeKy8CwytYTfBaFox6VlTDYQvi37+/kWUZ9X2
        JTGdMrAzBXRlcsLOi0I4Zd3iNXwA9nipj3k7pBAlkorxRrpt1+gYAHoB6/FNN87WS9w
        56ni5ZFMV+lr9jZqjdDe9fQPRhgdzamb1v3NNs4I=
Date:   Fri, 28 Sep 2018 14:20:11 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Aaron Tomlin <atomlin@redhat.com>
cc:     penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, malchev@google.com
Subject: Re: [PATCH v3] slub: extend slub debug to handle multiple slabs
In-Reply-To: <20180928111139.27962-1-atomlin@redhat.com>
Message-ID: <01000166208d1f55-2b13fdf8-a1a5-4a64-80f2-2e1a5314285e-000000@email.amazonses.com>
References: <20180928111139.27962-1-atomlin@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2018.09.28-54.240.9.92
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018, Aaron Tomlin wrote:

> Extend the slub_debug syntax to "slub_debug=<flags>[,<slub>]*", where <slub>
> may contain an asterisk at the end.  For example, the following would poison
> all kmalloc slabs:

Acked-by: Christoph Lameter <cl@linux.com>

