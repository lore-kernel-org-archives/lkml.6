Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCC0C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB7F2150B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 18:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JwVfAiN5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB7F2150B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730017AbeISA2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 20:28:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:51970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbeISA2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 20:28:42 -0400
Received: from devnote (unknown [209.121.128.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CB5021508;
        Tue, 18 Sep 2018 18:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537296886;
        bh=GSmh9UyAf+AKP8uvYor/5rVSoh/afcwGNeJC9IkyNxQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JwVfAiN5I0xgD7FR3Yh4wp2NogUtlkf3veie8MJbwtEawpqmu0knP8UdyLSY+5mQJ
         XDeIqAr2Kh2/XSe9LZaKp2rChpdnmK31pqSgnPJMfIaten333YLO352X9PEQa0O8vD
         yT6dJz5gWuGd96TEHEcev8XDGxwq/DAt2SncuSyc=
Date:   Wed, 19 Sep 2018 03:54:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Tom Zanussi <zanussi@kernel.org>
Cc:     rostedt@goodmis.org, tglx@linutronix.de, mhiramat@kernel.org,
        namhyung@kernel.org, vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4 8/8] trace: Add alternative synthetic event trace
 action syntax
Message-Id: <20180919035446.4fb6b856ab51229984eb2736@kernel.org>
In-Reply-To: <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
References: <cover.1536605847.git.tom.zanussi@linux.intel.com>
        <95e91d682061a3a43ea293b20ff4beea755b945a.1536605847.git.tom.zanussi@linux.intel.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On Mon, 10 Sep 2018 14:10:46 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> From: Tom Zanussi <tom.zanussi@linux.intel.com>
> 
> Add a 'trace(synthetic_event_name, params)' alternative to
> synthetic_event_name(params).
> 
> Currently, the syntax used for generating synthetic events is to
> invoke synthetic_event_name(params) i.e. use the synthetic event name
> as a function call.
> 
> Users requested a new form that more explicitly shows that the
> synthetic event is in effect being traced.  In this version, a new
> 'trace()' keyword is used, and the synthetic event name is passed in
> as the first argument.

Hmm, what is the advantage of adding this new form?

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
