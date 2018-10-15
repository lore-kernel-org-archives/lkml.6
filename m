Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A799BC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6ED208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="G3nhdXIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6ED208D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbeJPCRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:17:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:37608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbeJPCRY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:17:24 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E8720881;
        Mon, 15 Oct 2018 18:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539628260;
        bh=g/vQCRJJcuZHh2bDJjhSKORadK3fCszgnRDhB39/a2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G3nhdXIyaxedgU5PBtH4BFC33E7mwBoGNxHaqtE3lHUv0RGaJhXyy5J57uSRBaqtw
         DKEt88yqLnQMyC2cPgxL8KzuZISOKefXxKc4nVYv/CPvQCBD/4Kyd1Osn9puejOQAh
         8u7JNSonb0pIQZlxoDt/gGR4Ugp2voEoSSQVdxoc=
Date:   Mon, 15 Oct 2018 20:30:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <groeck@google.com>
Cc:     Ross Zwisler <zwisler@google.com>,
        Duncan Laurie <dlaurie@chromium.org>, furquan@chromium.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/4] gsmi: Google specific firmware patches
Message-ID: <20181015183057.GA11514@kroah.com>
References: <20181012160448.79018-1-zwisler@google.com>
 <CABXOdTfUKWejqTxvtcH_O6SKaWDRGcu5qCVafTstm-r8y7ke1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXOdTfUKWejqTxvtcH_O6SKaWDRGcu5qCVafTstm-r8y7ke1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 03:44:45PM -0700, Guenter Roeck wrote:
> On Fri, Oct 12, 2018 at 9:04 AM Ross Zwisler <zwisler@google.com> wrote:
> 
> > This series contains some Google specific firmware patches that we've
> > been carrying out of tree.  I've updated the changelog for each so that
> > it is suitable for upstream, and I've retested them to make sure I know
> > what the patches are doing.
> >
> > Duncan Laurie (3):
> >   gsmi: Fix bug in append_to_eventlog sysfs handler
> >   gsmi: Add coreboot to list of matching BIOS vendors
> >   gsmi: Remove autoselected dependency on EFI and EFI_VARS
> >
> > Furquan Shaikh (1):
> >   gsmi: Add GSMI commands to log S0ix info
> >
> >
> For the series: Reviewed-by: Guenter Roeck <groeck@chromium.org>
> 
> Greg, please let me know if I should send this for every patch.

Nope, this works.

greg k-h
