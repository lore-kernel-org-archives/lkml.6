Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C780C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:35:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8E0420892
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 10:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pctXCMOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8E0420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOSUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 14:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726357AbeJOSUE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 14:20:04 -0400
Received: from localhost (unknown [178.227.43.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D30862054F;
        Mon, 15 Oct 2018 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539599724;
        bh=hhk9cR7/5mxeMIuUX38lsU05bSHqx69gVgOy0gDsTsY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pctXCMOUN/Sat9sP8wxPok5MAzPerbTzgIgQPtwXN3yfief8Eb7FpTI9CeQwjwvYN
         iSulQ1nHtmsp6zRTxzduMw70FcNP39F/iMgfWQgncPOmCbCpZlwU9GTk3pQSXZjFhX
         aeGIN3T5YwnQshaolLLDAIrtIAsDhPjyleEQaBj0=
Date:   Mon, 15 Oct 2018 12:35:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Todd Poynor <toddpoynor@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Rob Springer <rspringer@google.com>,
        Todd Poynor <toddpoynor@google.com>
Subject: Re: [PATCH 00/11] staging: gasket: fixes
Message-ID: <20181015103520.GA25232@kroah.com>
References: <20181015045927.156790-1-toddpoynor@gmail.com>
 <20181015102949.GA11341@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015102949.GA11341@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 03:29:49AM -0700, Christoph Hellwig wrote:
> On Sun, Oct 14, 2018 at 09:59:16PM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> > 
> > Various fixes for gasket/apex drivers.
> 
> I still can't find any explanation in the staging tree or in your
> comments what gasket even is.

No one really knows, it will all eventually be deleted and they will
just use the UIO interface in the end, but it's fun to watch them
work themselves toward that over time :)

greg k-h
