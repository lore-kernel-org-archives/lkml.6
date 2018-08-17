Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3551AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB90820671
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 14:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="exv0yHVb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB90820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbeHQSDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 14:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:51392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726544AbeHQSDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 14:03:23 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 585DB20658;
        Fri, 17 Aug 2018 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1534517981;
        bh=Ap7eX/mOfGUbtZdh9Md+4FwkDi+2DnVroa7GtohCP2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=exv0yHVbefpN7Z0JUxuF7OBhYiWDckAQE++WsJQjYUM8OwKTAZRnvIXJu2pBRczD3
         tTYD2qpnj6e4X0tbSU9itWaq5/jghdmiOU6qhEwWephKkhjZPRsUG9eb6hcag6uPtt
         jiqckxVEQr/q3K1WBBGyoE0H6/x++ITHWM3xD/Nk=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id DCDFD141C3A; Fri, 17 Aug 2018 11:59:38 -0300 (-03)
Date:   Fri, 17 Aug 2018 11:59:38 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Joe Mario <jmario@redhat.com>
Subject: Re: [PATCH 0/2] perf tools: Fix pyrf_evlist__read_on_cpu interface
Message-ID: <20180817145938.GC22443@kernel.org>
References: <20180817114556.28000-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817114556.28000-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Aug 17, 2018 at 01:45:54PM +0200, Jiri Olsa escreveu:
> hi,
> Jaroslav reported errors from valgrind over perf python script,
> which led us to discover serious issue with python interface.
> 
> It affects tuned daemon, which depends on this interface,
> and makes it hang.

Thanks, applied.

- Arnaldo
