Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D5C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7F2208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 12:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F7F2208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933357AbeGJMtr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 08:49:47 -0400
Received: from verein.lst.de ([213.95.11.211]:47837 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933132AbeGJMto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 08:49:44 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 5B5FE68B97; Tue, 10 Jul 2018 14:51:19 +0200 (CEST)
Date:   Tue, 10 Jul 2018 14:51:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Christoph Hellwig <hch@lst.de>, Adrian Reber <adrian@lisas.de>,
        viro@zeniv.linux.org.uk, Avi Kivity <avi@scylladb.com>,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH 7/7] aio: implement io_pgetevents
Message-ID: <20180710125119.GA2642@lst.de>
References: <20180502211448.18276-1-hch@lst.de> <20180704142116.GM17048@lisas.de> <20180708204359.GA19198@lst.de> <1632268.WSg4zQ7CbY@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1632268.WSg4zQ7CbY@positron.chronox.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 09:21:53PM +0200, Stephan Müller wrote:
> Without such a patch, libkcapi fails to compile as well. See [1].
> 
> Apart from your suggested patch above, do you have another suggestion how make 
> the user space code compile?

The only other option would be to move the __aio_sigset delcaration
out of the uapi header, similar to what we do for pselect.  This is
also rather ugly, but I gess that's what we'll have to do.  I will
prepare a patch for it.
