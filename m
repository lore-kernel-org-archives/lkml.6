Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB75C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 330B3218A1
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbfAWVcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:32:43 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:35098 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726352AbfAWVcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:32:43 -0500
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1gmQ8W-00086u-57; Wed, 23 Jan 2019 22:32:40 +0100
Date:   Wed, 23 Jan 2019 22:32:15 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Gary R Hook <ghook@amd.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/2] debugfs: return error values, not NULL
Message-ID: <20190123213215.3rbgwc6n4t6xecqc@linutronix.de>
References: <20190123102702.GA17123@kroah.com>
 <20190123102814.GB17123@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190123102814.GB17123@kroah.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-01-23 11:28:14 [+0100], Greg Kroah-Hartman wrote:
> When an error happens, debugfs should return an error pointer value, not
> NULL.  This will prevent the totally theoretical error where a debugfs
> call fails due to lack of memory, returning NULL, and that dentry value
> is then passed to another debugfs call, which would end up succeeding,
> creating a file at the root of the debugfs tree, but would then be
> impossible to remove (because you can not remove the directory NULL).
> 
> So, to make everyone happy, always return errors, this makes the users
> of debugfs much simpler (they do not have to ever check the return
> value), and everyone can rest easy.

Thank you.

> Reported-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reported-by: Gary R Hook <ghook@amd.com>
> Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
