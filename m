Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 077C4C10F00
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DA22146F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551104389;
	bh=33AzkHZ5yjsJo9E10NPPbOvXZ+4ZLrhfPVbNHwgGegA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uE7Q7B2AGLbeLAVH6c3WyZgU7FZccjgWa6hmB1ModJxCB4xrIXp+W5jR7E/v6mIEX
	 l7LpWuZU96TciZKdP3RXTBSLS7AmNSKsyHpaB1tPr/UjgdqUNLO8KmdcxlmHbzHB1V
	 uTIoampxWJz5Bn0ER4+Id41nrd5LZ2+W5OkF0t94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbfBYOTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:19:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727281AbfBYOTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:19:48 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28480213A2;
        Mon, 25 Feb 2019 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551104387;
        bh=33AzkHZ5yjsJo9E10NPPbOvXZ+4ZLrhfPVbNHwgGegA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JriSL9p/x4YKfNYMR3C3206r1Jbd/td51s9DYwdTD0Vilc9PSJwDo0XgrOUjK4acn
         rSzP9VAFcLvajupqevrohJAWa0QSLrtm3o0hRyGbt68w3Pq0I7Ec7DPP5Q8sbwwhWi
         FDbhWYTKFzQyeW1CeeM6TPfto5WTq7MTpM40+y3s=
Date:   Mon, 25 Feb 2019 15:19:44 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     lantianyu1986@gmail.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [Update PATCH] x86/Hyper-V: Fix definition HV_MAX_FLUSH_REP_COUNT
Message-ID: <20190225141944.GA13067@kroah.com>
References: <20190225141214.4848-1-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225141214.4848-1-Tianyu.Lan@microsoft.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:12:14PM +0800, lantianyu1986@gmail.com wrote:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> The max flush rep count of HvFlushGuestPhysicalAddressList hypercall
> is equal with how many entries of union hv_gpa_page_range can be populated
> into the input parameter page. The origin code lacks parenthesis around
> PAGE_SIZE - 2 * sizeof(u64). This patch is to fix it.
> 
> Cc: <stable@vger.kernel.org>
> Fixs: cc4edae4b924 ("x86/hyper-v: Add HvFlushGuestAddressList hypercall support")

"Fixes"
