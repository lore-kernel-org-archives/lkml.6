Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5278213F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0001920881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 09:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rVMcchLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0001920881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727346AbeG3LJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 07:09:08 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40932 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726723AbeG3LJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 07:09:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QxJVwW5CT1HZphHLVJUfGch8UWK5OsAjAakDbbNJ9Gw=; b=rVMcchLO847nYBuy4vDa1sfmr
        qBP6OsbqgwbeHd2P4v3sMJtBhSmK3LCMoqVFzgoRrIye2+4IhbwGNPXs+KOifcHQQa68dnxrfuwps
        F3/lJftQailW2auuXDELWV8sFcVcpkHAOZNJ1JPYTSoCowZVb1715i4Dy967+2QMqTAJ+5ZYGm4Gf
        Sbtej/l2qXSfWFjbigMHE3Lx3tshxgtpmmSdwLHQDeRSVfrpUUD+1Ji24g1o3ex065AZkgTOj1wla
        Eim0FXg229yjI1PiGgCakKHv26tAXls9y9GEe8VBwgJDe6CxrdPc45jap5tPKWs67bQP8BKad+3WC
        YszWJa9Qg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fk4Zl-0005Mi-Bv; Mon, 30 Jul 2018 09:34:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04C9320298BC3; Mon, 30 Jul 2018 11:34:48 +0200 (CEST)
Date:   Mon, 30 Jul 2018 11:34:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, hpa@zytor.com,
        Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: Re: [PATCH 1/2] x86/tsc: Avoid a double call if TSC initializes
 earlier.
Message-ID: <20180730093447.GF2494@hirez.programming.kicks-ass.net>
References: <20180730075421.22830-1-douly.fnst@cn.fujitsu.com>
 <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180730075421.22830-2-douly.fnst@cn.fujitsu.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 03:54:20PM +0800, Dou Liyang wrote:
> static_branch_enable(&__use_tsc) may be called twice in common case, that
> is redundant.

It is also really not a problem...
