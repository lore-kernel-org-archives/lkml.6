Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D03205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 17:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eWMbQFct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29D03205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbeKBCiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 22:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:55660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727532AbeKBCiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 22:38:14 -0400
Received: from devbox (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B00A2205F4;
        Thu,  1 Nov 2018 17:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541093659;
        bh=Jh8gdHTlq1TnXgLQu5yKNVVyuP80ka3kc6eRUTpRhbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eWMbQFctleQQvMi7CZeZSQ8brdt/Lm8TaT1kGQFw9AxcBzdQe9PhS2gQvq/My+Kwj
         5yG2j3f6mLlmXmxfgvVDO+i9vRhrQnpyb+VMu9rnN7aGiNkpna9xaT6a4vtbSBcSsa
         irgLpMxdh48Qv92XgNFZQC7pFT/121VXveqyUWpY=
Date:   Fri, 2 Nov 2018 02:34:16 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 17/19] selftests: ftrace: Add synthetic
 event syntax testcase
Message-Id: <20181102023416.6cf8e9236d8d3cd78484a516@kernel.org>
In-Reply-To: <20181030182112.GB194472@sasha-vm>
References: <20181030132824.218056-1-sashal@kernel.org>
        <20181030132824.218056-17-sashal@kernel.org>
        <20181030105815.36974eb4@vmware.local.home>
        <20181030182112.GB194472@sasha-vm>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Oct 2018 14:21:12 -0400
Sasha Levin <sashal@kernel.org> wrote:

> On Tue, Oct 30, 2018 at 10:58:15AM -0400, Steven Rostedt wrote:
> >On Tue, 30 Oct 2018 09:28:22 -0400
> >Sasha Levin <sashal@kernel.org> wrote:
> >
> >> From: Masami Hiramatsu <mhiramat@kernel.org>
> >>
> >> [ Upstream commit ba0e41ca81b935b958006c7120466e2217357827 ]
> >>
> >> Add a testcase to check the syntax and field types for
> >> synthetic_events interface.
> >>
> >> Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox
> >>
> >> Acked-by: Shuah Khan <shuah@kernel.org>
> >> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> >> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >> Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> >Why are you adding selftests for old kernels to test a feature that
> >wasn't added until 4.17?
> 
> We backport all selftest patches to stable to keep selftest on stable
> kernels as similar as possible to upstream.

Hi Sasha,
Yes, you can feel free to backport selftests fix, but also please backport
corresponding bugfix patches. Unless it, the stable tree will fail the test.

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
