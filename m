Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A21C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC41F2085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:26:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC41F2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389674AbeKGCwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 21:52:21 -0500
Received: from mga02.intel.com ([134.134.136.20]:45451 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389281AbeKGCwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 21:52:21 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2018 09:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,472,1534834800"; 
   d="scan'208";a="106373460"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.126])
  by orsmga002.jf.intel.com with ESMTP; 06 Nov 2018 09:26:07 -0800
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id B1364301B6D; Tue,  6 Nov 2018 09:26:07 -0800 (PST)
Date:   Tue, 6 Nov 2018 09:26:07 -0800
From:   Andi Kleen <ak@linux.intel.com>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Milian Wolff <milian.wolff@kdab.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@kernel.org>, namhyung@kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho <acme@kernel.org>
Subject: Re: PEBS level 2/3 breaks dwarf unwinding! [WAS: Re: Broken dwarf
 unwinding - wrong stack pointer register value?]
Message-ID: <20181106172607.GT6218@tassilo.jf.intel.com>
References: <2335309.gnWok9HYb4@agathebauer>
 <3227038.olIWmsCzzY@agathebauer>
 <20181105205119.GC25674@krava>
 <3799078.YBnU1OB0PF@agathebauer>
 <20181106001037.GQ6218@tassilo.jf.intel.com>
 <20181106083957.GB8081@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106083957.GB8081@krava>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> hum, is this about having 'large pebs' or there's this window
> if there's also only single pebs record allowed? which should
> be case for dwarf unwind

With large PEBS today there is never any stack unwind because
stack unwinding can be only done from a PMI.

The window happens even with single PEBS. It's related
to the CPU being pipelined, so complex events may not
happen fully atomically.

-Andi

