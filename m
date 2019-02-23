Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C5EC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5E9820850
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 09:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550913425;
	bh=XDhzySR6AMiNUgGVSVVF7yG1jUvCjJqQ19Py9NehLz4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/o3gged+nsFms/M3DHryrcGq1QVqU6kJhnEQ4iyZ6gra+Zvjqs4q3jlOym76nv2N
	 J7jvcUBWXjKCA7eeSA9sO6unZAGzZFnUoeNNaImZEsHj0w/B2BkpSSAblP9eVQ5sL4
	 7IBX+6+lAB7F5eILKSIIMdHo5oLN70yapCR7P7wE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfBWJRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 04:17:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55044 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfBWJRC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 04:17:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B140320850;
        Sat, 23 Feb 2019 09:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550913422;
        bh=XDhzySR6AMiNUgGVSVVF7yG1jUvCjJqQ19Py9NehLz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlvu0Q/L7dr7KsGAFniPn5HLatO88G7YasQ5D8dLVywE6uUxxvvopiVKW1ysd4H96
         /09lgJ+KYPve2B/rKwdSQsgCGFgUzBtHXqNyyaStMqoomYm1+r3+ZCNXqIqUT251eK
         r44Pfmtkht6G6vZnhE5Hdz1lwM229eGDkm1m8pv0=
Date:   Sat, 23 Feb 2019 10:16:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org, dan.carpenter@oracle.com
Subject: Re: [PATCH 2/2] habanalabs: driver's Kconfig must select
 DMA_SHARED_BUFFER
Message-ID: <20190223091659.GA25029@kroah.com>
References: <20190222192959.241499-1-oded.gabbay@gmail.com>
 <20190222192959.241499-2-oded.gabbay@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190222192959.241499-2-oded.gabbay@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 09:29:59PM +0200, Oded Gabbay wrote:
> The driver uses the DMA_BUF module which is built only if
> DMA_SHARED_BUFFER is selected. DMA_SHARED_BUFFER doesn't have any
> dependencies so it is ok to select it (as done by many other components).
> 
> Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>

kbuild reported this, right?  You should always add that type of credit
to the patch.  I'll go add it by hand this time...

thanks,

greg k-h
