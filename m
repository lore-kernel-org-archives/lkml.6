Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60BD5C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32124222A1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550249035;
	bh=dMk+fZ++jd3sL6Z+huDx2quzIAZAjyN1XYmHTeKIEVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZhL5pL8rJ5TIuvEJXHk0vjdUsShZsM6pQfFOUQTvUKjuH4mgz8Col9yJrt2zdeJZZ
	 RgTR6EPXAhUjwFT/Xd11K3aiSsW97rRUrmfwlDFeeid3BRywfwFKWBVm0fXFUrvj02
	 t2BJ+xDyozpJLawYFhaR0MLwKW9Fzg/rR78wwMPY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729590AbfBOQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:43:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbfBOQnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:43:53 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 940A72192B;
        Fri, 15 Feb 2019 16:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550249032;
        bh=dMk+fZ++jd3sL6Z+huDx2quzIAZAjyN1XYmHTeKIEVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JJWKfD9x2Ic8pcVJ0Mj+E/hL8uhQDlOcIrLFhpnwpvqfnV/oKRK08f959kfgzmB2F
         m9c6iJgCmghh50HUsNAnsI0eSYJBtQ1ahIuOol+XqFHWlxwOVGkgg5EMJ2YS0IOxB2
         J1UssVS7sLrFvUU/3vJ8Fs0n13VuG0qyw/9h7UXI=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EE864410D5; Fri, 15 Feb 2019 13:43:49 -0300 (-03)
Date:   Fri, 15 Feb 2019 13:43:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Tommi Rantala <tt.rantala@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] perf tests shell: Skip trace+probe_vfs_getname.sh if
 built without trace support
Message-ID: <20190215164349.GA31177@kernel.org>
References: <20190215134253.11454-1-tt.rantala@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215134253.11454-1-tt.rantala@gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 15, 2019 at 03:42:46PM +0200, Tommi Rantala escreveu:
> From: Tommi Rantala <tommi.t.rantala@nokia.com>
> 
> If perf was built without trace support, trace+probe_vfs_getname.sh
> fails:
> 
>   # perf trace -h
>   perf: 'trace' is not a perf-command. See 'perf --help'
> 
>   # perf test 64
>   64: Check open filename arg using perf trace + vfs_getname: FAILED!
> 
> Check trace support, so that we'll skip the test:
> 
>   # perf test 64
>   64: Check open filename arg using perf trace + vfs_getname: Skip

Thanks, applied.

- Arnaldo
