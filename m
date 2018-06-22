Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED40C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF7023D4A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mChfm3nf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBF7023D4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751266AbeFVEuM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:50:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:49824 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751052AbeFVEuK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:50:10 -0400
Received: from localhost (unknown [122.167.114.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9304223D48;
        Fri, 22 Jun 2018 04:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529643010;
        bh=TvycDYMcGLXdTixpAoOhDIguKDBO+XvtyZVlRgPH/w8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mChfm3nfaVez6wMWCNfjQGjOcB+BTQqWg+g0GUVTEnP402E2Dcgz813JV4N0/JbD+
         EbqYwH44Exd0z492gW57Q0f8KTdQ5wIvEuVbfZDtTa0gQpH4o//Z0STQxh7Q4Mzf4O
         BGO5vreWM7bTzZr/TMDpaGKFJExc+wXzzgRxlMYw=
Date:   Fri, 22 Jun 2018 10:20:01 +0530
From:   Vinod <vkoul@kernel.org>
To:     Timur Tabi <timur@codeaurora.org>
Cc:     linux-crypto@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v2 0/2] hwrng: Add support for qcpm v2 hwrng
Message-ID: <20180622045001.GK27187@vkoul-mobl>
References: <20180619095430.26358-1-vkoul@kernel.org>
 <CAOZdJXUgYpLT=xMos4wKxMOTOZb8rV8is48YjGB8_9okZsuvhQ@mail.gmail.com>
 <20180622042747.GH27187@vkoul-mobl>
 <0383ce35-caea-dc0f-21fd-2f44e44ca8ce@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0383ce35-caea-dc0f-21fd-2f44e44ca8ce@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-06-18, 23:30, Timur Tabi wrote:

> > But there is a bigger concern raised by Herbert on this not being a true
> > RNG and thus should be moved to crypto/
> 
> I've asked some of the crypto experts in Q to answer that question.

That will be very helpful, I have not got any info on this. Although
specs mention PRNG everywhere..

> > I have the changes ready for that, I will test them later today and
> > share with you, ACPI addition should be easy on that driver
> 
> Ok.  Feel free to just merge my ACPI changes into yours.  Technically, it's
> only a couple lines that are really ACPI-specific.

Sure I will add/port you patch on top.

-- 
~Vinod
