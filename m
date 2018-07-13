Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE23FECDFAA
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1AC214C2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 02:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vcajbfaQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D1AC214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387747AbeGMDFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 23:05:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:43204 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387677AbeGMDFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 23:05:35 -0400
Received: from devnote (unknown [180.57.129.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A104D2147E;
        Fri, 13 Jul 2018 02:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531450386;
        bh=oYYSyUlDi7zkLZbYJC0ngVr4cb6ZyS5f+8FwsS1JUs4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vcajbfaQDCfS2f9+vUNBDGGe1wm3ecwyVKt5PInOPH5sjZmQn5ZerRIF5RN9vDarz
         Npji2XoYtcWx5nrlCYmTnGcon/N2vjzlWzYKn9T2ZH9GgVEuBh1An+o7TX2kW7zPsj
         CMUb3Y0FSeBIxWtTsTzL6VLYg9ya1XJy/Mr5b54k=
Date:   Fri, 13 Jul 2018 11:53:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Francis Deslauriers <francis.deslauriers@efficios.com>
Cc:     rostedt@goodmis.org, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: kprobes: Prohibit probing on notrace
 functions
Message-Id: <20180713115301.532ab1484e8b0befd90782d0@kernel.org>
In-Reply-To: <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
References: <1500044315-9508-3-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-1-git-send-email-francis.deslauriers@efficios.com>
        <1531418053-21414-2-git-send-email-francis.deslauriers@efficios.com>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jul 2018 13:54:12 -0400
Francis Deslauriers <francis.deslauriers@efficios.com> wrote:

> From: Masami Hiramatsu <mhiramat@kernel.org>
> 
> Prohibit kprobe-events probing on notrace function.
> Since probing on the notrace function can cause recursive
> event call. In most case those are just skipped, but
> in some case it falls into infinite recursive call.

BTW, I'm considering to add an option to allow putting
kprobes on notrace function - just for debugging 
ftrace by kprobes. That is "developer only" option
so generally it should be disabled, but for debugging
the ftrace, we still need it. Or should I introduce
another kprobes module for debugging it?

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>
