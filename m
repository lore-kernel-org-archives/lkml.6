Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62ED9C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB662089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 22:52:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CB662089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbeKQJHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 04:07:04 -0500
Received: from mga04.intel.com ([192.55.52.120]:42027 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbeKQJHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 04:07:03 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Nov 2018 14:52:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,242,1539673200"; 
   d="scan'208";a="280669356"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga005.fm.intel.com with ESMTP; 16 Nov 2018 14:52:47 -0800
Date:   Fri, 16 Nov 2018 15:49:26 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Timur Tabi <timur@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>
Subject: Re: Enable tracing only for one function and its children?
Message-ID: <20181116224925.GE14630@localhost.localdomain>
References: <CAOZdJXXYPeb90DzGnHr+c7jhfbZA7z7wiYMzDxgMP4nmuoYaiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOZdJXXYPeb90DzGnHr+c7jhfbZA7z7wiYMzDxgMP4nmuoYaiQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 04:37:55PM -0600, Timur Tabi wrote:
> Is there a way to enable ftrace tracing only for one specific function
> and all the functions it calls?  Then when the function returns,
> disable tracing until the next time?
> 
> When I pass the function name only to set_ftrace_filter, it literally
> only traces that function, which doesn't help me.  

I think you're looking for the set_graph_function option for the
function_graph tracer.
