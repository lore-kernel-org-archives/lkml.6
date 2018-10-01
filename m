Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C33B1C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D3CD208AE
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HM7rGPXG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D3CD208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbeJAWr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 18:47:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725740AbeJAWr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 18:47:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vCzHBcL0AXIVd3POd9XRRlcIhbjK31TEpynMqy0O/3k=; b=HM7rGPXGQ8UeriOcaAK2hQloF
        ZcIXHc5Ga0BpLYoi5Mk+/i7MLTGWw9GFoHJKeur5nC6DbEEJdnvoqiDLQk19lzaINaoB5vEbnBqkm
        DfgugSSBtbqqKmK9s3s9C9LdYP7ZG0vVn+YGijfF4zob6vkwkqLWwg1lXE5Oye6x6PHtHjddRgWue
        C+gZ6cbi0TsLkrah/J5pCUpERNAqo2Oasqriw3O0VeYr2t/WCdsi+7oZmnBo+ivY+Zw9lvV6ULQvE
        KbQoKM6f/T54LdNIOX0MNnckUJsAiVgNj2OnxE58w1atrgRTqqV69hVzzbBZ1dn9bgvnXnc4nCDx5
        1Jv+47V0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g70l6-0001Px-Do; Mon, 01 Oct 2018 16:09:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0ACFB2075FAA7; Mon,  1 Oct 2018 18:09:17 +0200 (CEST)
Date:   Mon, 1 Oct 2018 18:09:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        will.deacon@arm.com, songliubraving@fb.com, mingo@kernel.org,
        luto@kernel.org, hpa@zytor.com, npiggin@gmail.com
Subject: Re: [PATCH v2 0/7] x86/mm/tlb: make lazy TLB mode even lazier
Message-ID: <20181001160917.GM3439@hirez.programming.kicks-ass.net>
References: <20180926035844.1420-1-riel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926035844.1420-1-riel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Looks good to me,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
