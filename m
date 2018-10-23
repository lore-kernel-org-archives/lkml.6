Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA380C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D8120813
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 21:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIv21TGk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84D8120813
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728313AbeJXFtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 01:49:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:57168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725266AbeJXFtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 01:49:14 -0400
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFD362075D;
        Tue, 23 Oct 2018 21:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540329844;
        bh=wwcdspXG6QFJv1EJG95QyYFklhDWfnDwjgZNCJAZCV4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PIv21TGk+dan451a8w8ITTitXHCFB4XUCcrrrSOoqK2AfUWoQCpy3NjaFY5cwnTgS
         9lGvd5o2ol4foWJUrz+ZZlyEziQ37POazdKLUPEM34eZg53m6j7sJCYaq/vuoiLSf2
         WlWkast41Ig+1szk6g7rdK98j/p5IDC0bHMWSuXo=
Message-ID: <1540329842.6502.9.camel@kernel.org>
Subject: Re: [PATCH v6 07/15] tracing: Move hist trigger key printing into a
 separate function
From:   Tom Zanussi <zanussi@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Tue, 23 Oct 2018 16:24:02 -0500
In-Reply-To: <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
References: <cover.1539288364.git.tom.zanussi@linux.intel.com>
         <7b9b456df5b0738f73aa6a688db82c345d0358e1.1539288364.git.tom.zanussi@linux.intel.com>
         <20181023233722.95a6685f2395c0ba979698a4@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, 2018-10-23 at 23:37 +0900, Masami Hiramatsu wrote:
> Hi Tom,
> 
> On Thu, 11 Oct 2018 16:02:04 -0500
> Tom Zanussi <zanussi@kernel.org> wrote:
> 
> > From: Tom Zanussi <tom.zanussi@linux.intel.com>
> > 
> > Future patches will want to print a histogram key outside a
> > histogram
> > - add and use hist_trigger_print_key() for that purpose.
> 
> Hmm, I think this change should be done with such user code, because
> without
> the user code I can not decide it is good or not.
> 

OK, will move it into the following patch, 'tracing: Add hist trigger
snapshot() action'.

Thanks,

Tom

