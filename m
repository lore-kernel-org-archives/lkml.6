Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F23C37120
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EDD82089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 21:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="Q+BjbpDB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbfAUVxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 16:53:25 -0500
Received: from a9-31.smtp-out.amazonses.com ([54.240.9.31]:37118 "EHLO
        a9-31.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725993AbfAUVxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 16:53:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1548107604;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=DcXpbnSbvxIdmq741qppTsLN32m9f2v4cydbcvErAV0=;
        b=Q+BjbpDBgsQD/11ROUV+6LLlGtEkEYWE1cAP3Xrim+rdMrlzz8/LqguRcZmbtPlL
        2bNjHzrtqtpGEdkZMf6iCeUwWepSntlMaV138LRW2szfZ4BhieGFXzdTc1+Zkk9GaLp
        NrSg5DYlIFSs3WYwZ7KFyLiBbk4Ak8CxcaDiCQTU=
Date:   Mon, 21 Jan 2019 21:53:24 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     Davidlohr Bueso <dave@stgolabs.net>
cc:     akpm@linux-foundation.org, dledford@redhat.com, jgg@mellanox.com,
        jack@suse.de, ira.weiny@intel.com, linux-rdma@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 6/6] drivers/IB,core: reduce scope of mmap_sem
In-Reply-To: <20190121174220.10583-7-dave@stgolabs.net>
Message-ID: <01000168726760d6-6c4f2b48-870e-4a46-846b-3bb3d324000d-000000@email.amazonses.com>
References: <20190121174220.10583-1-dave@stgolabs.net> <20190121174220.10583-7-dave@stgolabs.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.01.21-54.240.9.31
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jan 2019, Davidlohr Bueso wrote:

> ib_umem_get() uses gup_longterm() and relies on the lock to
> stabilze the vma_list, so we cannot really get rid of mmap_sem
> altogether, but now that the counter is atomic, we can get of
> some complexity that mmap_sem brings with only pinned_vm.

Reviewd-by: Christoph Lameter <cl@linux.com>

