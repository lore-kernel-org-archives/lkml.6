Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0125EC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1C8220861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1C8220861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbeIGOiz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 10:38:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52386 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726031AbeIGOiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 10:38:55 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7BE3D77886;
        Fri,  7 Sep 2018 09:58:44 +0000 (UTC)
Received: from krava (ovpn-204-250.brq.redhat.com [10.40.204.250])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62D9D2156889;
        Fri,  7 Sep 2018 09:58:43 +0000 (UTC)
Date:   Fri, 7 Sep 2018 11:58:42 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] perf tools: Fix maps__find_symbol_by_name()
Message-ID: <20180907095842.GB23726@krava>
References: <20180907085116.25782-1-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180907085116.25782-1-adrian.hunter@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 09:58:44 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.1]); Fri, 07 Sep 2018 09:58:44 +0000 (UTC) for IP:'10.11.54.6' DOMAIN:'int-mx06.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'jolsa@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 11:51:16AM +0300, Adrian Hunter wrote:
> Commit 1c5aae7710bb ("perf machine: Create maps for x86 PTI entry
> trampolines") revealed a problem with maps__find_symbol_by_name() that
> resulted in probes not being found e.g.
> 
> 	$ sudo perf probe xsk_mmap
> 	xsk_mmap is out of .text, skip it.
> 	Probe point 'xsk_mmap' not found.
> 	   Error: Failed to add events.
> 
> maps__find_symbol_by_name() can optionally return the map of the found
> symbol. It can get the map wrong because, in fact, the symbol is found
> on the map's dso, not allowing for the possibility that the dso has more
> than one map. Fix by always checking the map contains the symbol.
> 
> Reported-by: Björn Töpel <bjorn.topel@intel.com>
> Tested-by: Björn Töpel <bjorn.topel@intel.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
