Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78E2C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99950204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 17:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=firstfloor.org header.i=@firstfloor.org header.b="r99slEnc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99950204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=firstfloor.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeI1Xoa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 19:44:30 -0400
Received: from one.firstfloor.org ([193.170.194.197]:50606 "EHLO
        one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1Xoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 19:44:30 -0400
Received: by one.firstfloor.org (Postfix, from userid 503)
        id BCBFB873AF; Fri, 28 Sep 2018 19:19:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firstfloor.org;
        s=mail; t=1538155184;
        bh=AN80b524CLLm2NxKqeXIscs5HVD+r5eIFVprc9a9Jqg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r99slEncG9p+vduK51FOFHiyTzvoDss5cprCM3cQXHaJkTSlsiekO8/0fxHK0tsir
         7m987mdRh6Se0vISI/m4sHeTwoG/7zEpZmiEsQ+gfnNQrN9ynb/t05VgproS6aNXqV
         nIQwu2wxaEEgHxt/kE+t5rBaUs9j8nW1k1t5jvso=
Date:   Fri, 28 Sep 2018 10:19:44 -0700
From:   Andi Kleen <andi@firstfloor.org>
To:     leo.yan@linaro.org
Cc:     Andi Kleen <andi@firstfloor.org>, acme@kernel.org,
        jolsa@kernel.org, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH v6 3/5] tools, perf, script: Add --call-trace and
 --call-ret-trace
Message-ID: <20180928171944.sdejhgyqka4p3kc3@two.firstfloor.org>
References: <20180920180540.14039-1-andi@firstfloor.org>
 <20180920180540.14039-4-andi@firstfloor.org>
 <20180928102331.GA15533@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180928102331.GA15533@leoy-ThinkPad-X240s>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Seems to me, these two features are _NOT_ only benefit for intel_pt,
> other hardware tracing (e.g. Arm CoreSight) can enable these features
> as well.  This patch is to document only for intel_pt, later if we
> enable this feature on Arm platform we need to change the doc;
> alternatively we can use more general description for these two options
> at the first place.  How about you think for this?

Likely it already works for CoreSight

I specified intel_pt, because if we just say traces the users won't
know what PMU to specify for record. Being too abstract is
often not helpful.

If someone successfully tests it on CoreSight they could submit
a patch to the documentation to add "or <coresightpmu>" to these
two cases. That would make it then clear for those users too.

-Andi
