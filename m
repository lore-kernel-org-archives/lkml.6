Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3F3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CEF120831
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0sLM+5d5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEF120831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbeJ3Vof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 17:44:35 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47020 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727450AbeJ3Vof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 17:44:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Ai0KZ2a2trGvfMZruqHzC/C+IADbGHlYf0cLUeygEAE=; b=0sLM+5d5in9f0GGS9MQAmyGVt
        h9j4IZtReQUB3rhOyfK0XNMrpAaKTmYhFynFyQOKqkN2Ybg75/KjycVzkwqLDM2QuG5UBlzJwpbPn
        Qm7YC3FHG0EBSkPHi1EQE9Gl1ZPlroeOQEtqxGu19xjO53ov+S9B6wMUxMtjXzN7PDKGROzebNMxA
        bcj7CiFoFPkoyK4mBTJ9VgdVDYV7kP5lmCQzdN9MnyI2o6LQ3N8yUBdtKMa4R6LmCnk7NRZQ8X1Z8
        9KshIljG7J0u2g9ii40zFVrBSAPoA4RCvuFMx1d4CWh/i7Svisz2J5Kbe7+SZDl/wpfZfP6cmlbEV
        63qtm/o7Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gHTUA-0002wB-I1; Tue, 30 Oct 2018 12:51:07 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BC682029FA14; Tue, 30 Oct 2018 13:51:03 +0100 (CET)
Date:   Tue, 30 Oct 2018 13:51:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH 1/2] perf: Add munmap callback
Message-ID: <20181030125103.GD8177@hirez.programming.kicks-ass.net>
References: <20181024151116.30935-1-kan.liang@linux.intel.com>
 <20181025002943.GT3109@worktop.c.hoisthospitality.com>
 <0083c5c2-8a53-3aca-543b-16bd764e31ab@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0083c5c2-8a53-3aca-543b-16bd764e31ab@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:00:07AM -0400, Liang, Kan wrote:
> Is this patch you mentioned?
> https://lkml.org/lkml/2017/1/27/452

Yes.
