Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B09CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:20:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CAFF2081C
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="wH7Ulaht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CAFF2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeK2QY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 11:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:47116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727406AbeK2QY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 11:24:58 -0500
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 349422081C;
        Thu, 29 Nov 2018 05:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543468853;
        bh=S1V9F1pz8mjf5zZG63pmQg2nLq0ARO5egYpy4YDWMJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wH7Ulahtxs3jkwp9Bo9S89S0SAGFXgbUDSLiA8Q8lXSLJwCg2v+5CE1ndVQDexPSf
         jtFYYjeerXwkheR6v9pNeFxkuNo4y1TUS5jVPjq1wuXDAUfuQsV5bNbaa/YWSSyPNQ
         co4jVqoIpOibPJjuicEJOUURff5NFBE9+WY4dREI=
Date:   Thu, 29 Nov 2018 14:20:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 00/12] tracing: Unifying dynamic event interface
Message-Id: <20181129142049.9404dcc0f74d65c9c129d13c@kernel.org>
In-Reply-To: <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
References: <154140838606.17322.15294184388075458777.stgit@devbox>
        <20181128163101.d86844338bcba3fc3b0580f1@kernel.org>
        <ff8ca3062cad3747a664e6888790cc3c58e24c7e.camel@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Wed, 28 Nov 2018 17:42:22 -0600
Tom Zanussi <tom.zanussi@linux.intel.com> wrote:

> Hi Masami,
> 
> On Wed, 2018-11-28 at 16:31 +0900, Masami Hiramatsu wrote:
> > Ping?
> > 
> > Hi Tom,
> > 
> > This series, especially [09/12] tracing: Remove unneeded
> > synth_event_mutex
> > will effect your current working series. Please tell me your opinion.
> > 
> 
> Sorry for the delay in reviewing this - I completely forgot about it in
> my inbox.
> 
> It's all very nice, and the mutex updates along with the dyn_event
> management make that part of the code much cleaner, thanks!
> 
> In any case, you can have my
> 
> Reviewed-by: Tom Zanussi <tom.zanussi@linux.intel.com>
> Tested-by: Tom Zanussi <tom.zanussi@linux.intel.com>

Thank you!
And as I pointed, synth_event_mutex is removed by this series, it may
affect your hist trigger series too. 

Thanks,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
