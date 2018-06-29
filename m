Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE6DC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C5D2217BA
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1lU/yUSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C5D2217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936891AbeF2SzH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:55:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932846AbeF2SzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:55:04 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4D0217BA;
        Fri, 29 Jun 2018 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530298504;
        bh=zBS9W/2FMF/6jJcSaOk2dmaTtHCi5cFCGrczmSK3K3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1lU/yUSgCUUuZzXc59UEpDQn2DeUgx9JgzzWIr3TJ50iuAWr26HUXCYL9otuiyNbi
         sPSVyd6qOmj70Lj+D4rM2mjjw7eThNCIkaTC0HV/zph1ni0ZGBQb9wm1/sW17eW3OP
         p+RiGGhbxmbpAVasS7BIlDp7KH62ZNLBORczmXrQ=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 061A114453C; Fri, 29 Jun 2018 15:55:00 -0300 (-03)
Date:   Fri, 29 Jun 2018 15:55:00 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Kim Phillips <kim.phillips@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.vnet.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Hendrik =?iso-8859-1?Q?Br=FCckner?= 
        <brueckner@linux.vnet.ibm.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/4] perf test shell: Replace '|&' with '2>&1 |' to
 work with more shells
Message-ID: <20180629185500.GD3593@kernel.org>
References: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629124633.0a9f4bea54b8d2c28f265de2@arm.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Jun 29, 2018 at 12:46:33PM -0500, Kim Phillips escreveu:
> Since we do not specify bash (and/or zsh) as a requirement, use the
> standard error redirection that is more widely supported.

Thanks, applied the 4 patches,

- Arnaldo
