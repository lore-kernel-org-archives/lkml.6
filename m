Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572BDC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:44:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1297620851
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 15:44:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1bhVkNql"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1297620851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729868AbeKTCIm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:08:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:33380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729669AbeKTCIl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:08:41 -0500
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C164520851;
        Mon, 19 Nov 2018 15:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542642284;
        bh=8CpBedE+Lo1gzjNibkFfMEFWtwkiNpJPrap4E43LQ3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1bhVkNql1ye2p+0FnMzk7Ru5E01buMvS4Q0Y+EU/YLR6y1lt+VMyew0yLvvrKKCC8
         9JPFX6TDS5d5mQ52pEmALk9jgwDMQw93gOUpuaUx78X+1UNfno0uxcN/9UXOccTyCz
         7VI4HFihozw+ICIW5pLvhkxIauhwpmtCx5Q+jPAQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B0B171443D3; Mon, 19 Nov 2018 07:44:41 -0800 (PST)
Date:   Mon, 19 Nov 2018 07:44:41 -0800
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>,
        linux-kernel@vger.kernel.org, leo.yan@linaro.org,
        David Miller <davem@davemloft.net>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH V2 0/3] perf tools: Fix for cases where cpumode is
 incorrect or insufficient
Message-ID: <20181119154441.GF18319@kernel.org>
References: <20181106210712.12098-1-adrian.hunter@intel.com>
 <f988a358-fc72-e758-8fa5-e7bfb0498e60@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f988a358-fc72-e758-8fa5-e7bfb0498e60@intel.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 19, 2018 at 03:37:37PM +0200, Adrian Hunter escreveu:
> On 6/11/18 11:07 PM, Adrian Hunter wrote:
> > Here is V2:
> > These patches probably deal with most cases except the one fixed by David
> > Miller's "perf callchain: Honour the ordering of
> > PERF_CONTEXT_{USER,KERNEL,etc}" patch, and also cat_backtrace() which looks
> > like it has the same problem, and the cs-etm fix.
 
> Are these patches ok?

Just got back from LPC, will resume reviewing these soon.

- Arnaldo
