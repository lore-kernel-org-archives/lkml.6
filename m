Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA1DC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1AC22077C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nuiWeZ5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1AC22077C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeIENLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:11:53 -0400
Received: from merlin.infradead.org ([205.233.59.134]:58320 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbeIENLx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=RZCPPZOG8Tu/iUvLbuiol+k/5ywiIvn77e7rVkj2gvQ=; b=nuiWeZ5btwOeNG5cYQ8s+qes0
        2w4bcdZeDU+sP1g/9PwmrlB/Go3JPpyuDIeyNw7wu0XKUUCF3P1jXmpHEzRm4lZkQHg5sYA+P4GBo
        pV+x+VmPpb3lAOfzoXTrQN+vktdE6tendsbaM7K5x7iTUwwGDQ7vWnItODbbsjtj/7D9fjlNn4VTK
        8O9e5jXXOulG2SB6tvui9+ldpBx695jeVb9mcWu4TmLexXv7oi0mY1KzygQefRESY29ev6QwG1V+A
        AUpUK0DVD/zEmTdjXQYwpdjeZzVWY69I8Az00H5JLXP4Ta+emddlYlsf1g57aCbg/ppyJAcAlHFS8
        79qxHJAiQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fxTOc-00040C-UQ; Wed, 05 Sep 2018 08:42:43 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A420A20191BFF; Wed,  5 Sep 2018 10:42:41 +0200 (CEST)
Date:   Wed, 5 Sep 2018 10:42:41 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org
Subject: Re: stop_machine() soft lockup
Message-ID: <20180905084241.GS24082@hirez.programming.kicks-ass.net>
References: <20180904190322.GA21835@centauri.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904190322.GA21835@centauri.lan>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 09:03:22PM +0200, Niklas Cassel wrote:
> Hello Peter,
> 
> I'm seeing some lockups when booting linux-next on a db820c arm64 board.
> I've tried to analyze, but I'm currently stuck.

Please see (should be in your Inbox too):

  https://lkml.kernel.org/r/20180905084158.GR24124@hirez.programming.kicks-ass.net
