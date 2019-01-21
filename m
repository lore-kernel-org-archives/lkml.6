Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13AC2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A168420861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 14:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548079857;
	bh=xHP63R+cpKc/Tx8CsKsPMr2sKklnPjCr516TYtPiQjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kdLvMRRqKf8lK4TeS/RjFFS6DOZcnVAZfeY984fGNJB1/Q4Bt7UKdY6lJiXAvf+qN
	 eE9x4eWLOzgCc5Xn9Rilqt4vGR4xZPoLmE8pmF2sxlIRvJttdg+sKA2WHx6kJku9Y7
	 3MsNcgieuSopthQM/nqQlk3MgdStnpBAysJSr8eI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731790AbfAUOK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 09:10:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:56994 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730111AbfAUOKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 09:10:53 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3F4620879;
        Mon, 21 Jan 2019 14:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548079852;
        bh=xHP63R+cpKc/Tx8CsKsPMr2sKklnPjCr516TYtPiQjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ahy/IEiAYxc495j5D3mjy1LVdWI8mgWKHX2nTKzeYjalsJF9ApVWwqDplu13kRQDo
         5i3rSwLMQHVm2W/cwa3cOf+2yBnzoEJIEbKxmYkaSZDCEk8w7aofeqVaANuHQ9h8Wh
         UrRwqmYLbeymYIZFr9s/HskCjVhm1K0H5Z9PVbr8=
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 430DA4049A; Mon, 21 Jan 2019 11:10:50 -0300 (-03)
Date:   Mon, 21 Jan 2019 11:10:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     He Kuang <hekuang@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf top: Fix wrong hottest instruction highlighted
Message-ID: <20190121141050.GA15707@kernel.org>
References: <20190120160523.4391-1-hekuang@huawei.com>
 <20190120184043.GD8591@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120184043.GD8591@krava>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 20, 2019 at 07:40:43PM +0100, Jiri Olsa escreveu:
> On Mon, Jan 21, 2019 at 12:05:22AM +0800, He Kuang wrote:
> > Annotation line's percentage is compared and inserted into rbtree, but the
> > percent field of 'struct annotation_data' is an array, the comparison
> > result between them is the address difference.
> > 
> > This patch compares the right slot of percent array according to
> > opts->percent_type and makes things right.
> > 
> > The problem can be reproduced by pressing 'H' in perf top annotation view.
> > It should highlight the instruction line which has the highest sampling
> > percentage.
> > 
> > Signed-off-by: He Kuang <hekuang@huawei.com>
> 
> Reviewed-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

- Arnaldo
