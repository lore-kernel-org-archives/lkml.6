Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E83FC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAFAC218D3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 19:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550087244;
	bh=ebJpBf9ktXAGWDafAVY6Tg1PxqT8M5DReJuk9gqBBC8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=2Yc8i0rnNJR0lCbJ3AUmU9cbdsJUuNe9etBkpzr1gAAas4ziDa30C46RIbfZWLWUz
	 31T911X8pl6yqJZD0VJpbOufDrLLm24Efld4ljA+4xj1olXP7HjEy0VGsMgOaYtRgm
	 ScVgAIua26ya/Du+GZksE1Rd0S3HRdgSG/C2mWvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392563AbfBMTrW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 14:47:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:50930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbfBMTrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 14:47:22 -0500
Received: from tzanussi-mobl (c-98-220-238-81.hsd1.il.comcast.net [98.220.238.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC72621872;
        Wed, 13 Feb 2019 19:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550087241;
        bh=ebJpBf9ktXAGWDafAVY6Tg1PxqT8M5DReJuk9gqBBC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oID+KyanWugomJ5jFRXV58DF4TK8QRz9uM0lxv65+Y3Dtmn/ZtPwY7kO9WcNd2m+l
         Vh6bk0IAAgkhb2b21d2UkcNyMhPPndZMhSKjxWzb7rKCenwRTQbaFiJAxtlouO/Ezf
         AR2xckv47VtYFPI4ay8XM29R0d1r+uUHQ58Oi80E=
Message-ID: <1550087239.7529.1.camel@kernel.org>
Subject: Re: [PATCH v14 06/15] tracing: Add hist trigger snapshot() action
From:   Tom Zanussi <zanussi@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     tglx@linutronix.de, mhiramat@kernel.org, namhyung@kernel.org,
        vedang.patel@intel.com, bigeasy@linutronix.de,
        joel@joelfernandes.org, mathieu.desnoyers@efficios.com,
        julia@ni.com, linux-kernel@vger.kernel.org,
        linux-rt-users@vger.kernel.org
Date:   Wed, 13 Feb 2019 13:47:19 -0600
In-Reply-To: <20190213143523.1e387566@gandalf.local.home>
References: <cover.1549403369.git.tom.zanussi@linux.intel.com>
         <c191f511b3d29e1d4a7f36e49d7702a97950e113.1549403369.git.tom.zanussi@linux.intel.com>
         <20190213142551.0b89604e@gandalf.local.home>
         <20190213143523.1e387566@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

On Wed, 2019-02-13 at 14:35 -0500, Steven Rostedt wrote:
> On Wed, 13 Feb 2019 14:25:51 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > I noticed this because we hardcode the size in memcpy. Should hard
> > code
> > it above, otherwise it looks like elt_data->comm may be something
> > other
> > than TASK_COMM_LEN.
> 
> 
> Hi Tom,
> 
> My comments on patch 5 and 6 are the only comments I have on the
> series. Could you address them and post a v15, and I'll pull them in
> and start testing them?
> 

Great, yeah I'll make all those changes and post a v15 shortly.

Thanks,

Tom

> Thanks!
> 
> -- Steve
