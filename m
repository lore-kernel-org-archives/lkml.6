Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8669AC65BD0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BA4208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 23:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BA4208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbeJFGwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 02:52:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59160 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbeJFGwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 02:52:41 -0400
Received: from localhost (unknown [104.153.224.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id F03B0681A;
        Fri,  5 Oct 2018 23:51:38 +0000 (UTC)
Date:   Fri, 5 Oct 2018 16:51:31 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4.19-rc7] treewide: Replace more open-coded allocation
 size multiplications
Message-ID: <20181005235131.GA27193@kroah.com>
References: <20181005233559.GA37919@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181005233559.GA37919@beast>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2018 at 04:35:59PM -0700, Kees Cook wrote:
> As done treewide earlier, this catches several more open-coded
> allocation size calculations that were added to the kernel during the
> merge window. This performs the following mechanical transformations
> using Coccinelle:
> 
> 	kvmalloc(a * b, ...) -> kvmalloc_array(a, b, ...)
> 	kvzalloc(a * b, ...) -> kvcalloc(a, b, ...)
> 	devm_kzalloc(..., a * b, ...) -> devm_kcalloc(..., a, b, ...)
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Has this had any testing in linux-next?

And when was "earlier"?

thanks,

greg k-h
