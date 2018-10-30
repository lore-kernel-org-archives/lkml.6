Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A06C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DABF22081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 18:21:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uolTsqQ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DABF22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbeJaDPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 23:15:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:40502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727957AbeJaDPq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 23:15:46 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A19B22081B;
        Tue, 30 Oct 2018 18:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540923673;
        bh=KOhjtIffSCMDKe8Uo/xz7BLM/PYENOCQq4p5GdZI3oE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uolTsqQ/DmuK1iTIXYrFANVtGY/ku5H9pSCMAf8mTRip7UvX5JeRHXpc0w4xkIv8y
         K4MRr4PoDtBsZLEZ3wGB2n7P4ZV6xDs3xNpiGtgtxxepI62FP7YwVtibywzr9rImyC
         i+g+2y5lOhMEUG5mDjieeJ1PVGafEqzrh54Bwil4=
Date:   Tue, 30 Oct 2018 14:21:12 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH AUTOSEL 4.14 17/19] selftests: ftrace: Add synthetic
 event syntax testcase
Message-ID: <20181030182112.GB194472@sasha-vm>
References: <20181030132824.218056-1-sashal@kernel.org>
 <20181030132824.218056-17-sashal@kernel.org>
 <20181030105815.36974eb4@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20181030105815.36974eb4@vmware.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:58:15AM -0400, Steven Rostedt wrote:
>On Tue, 30 Oct 2018 09:28:22 -0400
>Sasha Levin <sashal@kernel.org> wrote:
>
>> From: Masami Hiramatsu <mhiramat@kernel.org>
>>
>> [ Upstream commit ba0e41ca81b935b958006c7120466e2217357827 ]
>>
>> Add a testcase to check the syntax and field types for
>> synthetic_events interface.
>>
>> Link: http://lkml.kernel.org/r/153986838264.18251.16627517536956299922.stgit@devbox
>>
>> Acked-by: Shuah Khan <shuah@kernel.org>
>> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
>> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Why are you adding selftests for old kernels to test a feature that
>wasn't added until 4.17?

We backport all selftest patches to stable to keep selftest on stable
kernels as similar as possible to upstream.

--
Thanks,
Sasha
