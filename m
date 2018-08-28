Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B9FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF7920894
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 14:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/rw1AFd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FF7920894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728331AbeH1SRi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 14:17:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbeH1SRh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 14:17:37 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F19F120878;
        Tue, 28 Aug 2018 14:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535466343;
        bh=4eeUdif8vS7zFGnddABD4cpePwr68OktpBL/bAWJpyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/rw1AFd+zyFh1LytSXVe9p279m2q7nIhaA/tI4FKL9/Bw7kNmMRql04gXc83wpHf
         qyuRvLeCGxGZjHmtJ+acdaSCO+2Rv76bdSY2C43MBv/1jzgV/I5497up8I+ynhVX+x
         SJxcjLpwhz6UpaNk1imA8SPKANOsl27YUxuVHgss=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 7C57F141C3F; Tue, 28 Aug 2018 11:25:40 -0300 (-03)
Date:   Tue, 28 Aug 2018 11:25:40 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Milind Chabbi <chabbi.milind@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCHv2 0/5] perf/hw_breakpoint: Fix breakpoint modify
Message-ID: <20180828142540.GI22309@kernel.org>
References: <20180809120305.20693-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809120305.20693-1-jolsa@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Aug 09, 2018 at 02:03:00PM +0200, Jiri Olsa escreveu:
> hi,
> Milind reported that modify_user_hw_breakpoint wouldn't
> allow the breakpoint changing if the new attr had 'disabled'
> set to true.
> 
> I found a case where it actualy prevents ptrace user interface
> to change the breakpoint. It's described in patch 1 as perf test,
> patch 2 is the breakpoint code fix.

Going over these patches now, applying the test, running it, then the
kernel bits, reboot, retest, etc.

- Arnaldo
