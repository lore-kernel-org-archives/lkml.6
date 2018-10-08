Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1CCC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934DE2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNavVJ9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 934DE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeJIAoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbeJIAoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:44:06 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAD1B213A2;
        Mon,  8 Oct 2018 17:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539019880;
        bh=NLPEY81wqQ53/q8AsiQWfXedoTGhNuJmqLS/lT9GBgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rNavVJ9M76Shp3Cvxmfy2k79lTTNt4b+c9aUQLzTLCtyo+CF2XT7OzhZqDSreIlN8
         SUiJRq3bmU4fG231uEe7JwYL1UZnh5+3S25jU4rLGyH8w+9lsGA7hncoOpjYrJ+kYy
         Yk8HAAE8wHPdwTf2hzXxoTiTPrF8/zSu4H9cD7No=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 1E9F3141DDC; Mon,  8 Oct 2018 14:31:17 -0300 (-03)
Date:   Mon, 8 Oct 2018 14:31:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH] tools/lib/traceevent, tools/perf: Move struct
 tep_handler definition in a local header file
Message-ID: <20181008173117.GO3541@kernel.org>
References: <20181005122225.522155df@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005122225.522155df@gandalf.local.home>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 05, 2018 at 12:22:25PM -0400, Steven Rostedt escreveu:
> 
> From: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> 
> As traceevent is going to be transferred into a proper library,
> its local data should be protected from the library users.
> This patch encapsulates struct tep_handler into a local header,
> not visible outside of the library. It implements also a bunch
> of new APIs, which library users can use to access tep_handler members.
> 
> Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

Thanks, applied to perf/core.

- Arnaldo
