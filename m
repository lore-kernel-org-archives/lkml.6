Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 903FFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47E7F20989
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:34:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xwUSwC8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47E7F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeK0SbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:31:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:57260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727631AbeK0SbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:31:11 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 910E120873;
        Tue, 27 Nov 2018 07:34:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543304053;
        bh=24q5wLnKgihp/iFVe8z+lfLwDrEXCNLZPX6x+Hh+uM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xwUSwC8K97bjypwTHLtcPiNF3k4RLGUUH4SHGesMsZxcaZhnG3cU0rqbsA9d41OkR
         Ru72Nd7eH1m3Ft5PK9I9eD8PR4P1Fqboi2KDIWbsVrKdIrkkfce4THy+z/exlsZDeZ
         7E9h6FyDYnw7g1TL0ZR9A6ju7ZxFdd6Tnd3ZKkUo=
Date:   Tue, 27 Nov 2018 08:34:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rodolfo Giometti <giometti@enneenne.com>
Cc:     YueHaibing <yuehaibing@huawei.com>, davem@davemloft.net,
        richardcochran@gmail.com, sudipm.mukherjee@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH -next] pps: using ERR_PTR instead of NULL while
 pps_register_source fails
Message-ID: <20181127073410.GA13965@kroah.com>
References: <20181126102422.24028-1-yuehaibing@huawei.com>
 <44edc27b-e679-24e8-aef1-fe5b7570f982@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44edc27b-e679-24e8-aef1-fe5b7570f982@enneenne.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2018 at 11:43:06AM +0100, Rodolfo Giometti wrote:
> On 26/11/2018 11:24, YueHaibing wrote:
> > pps_register_source() has keeps error codes in a local variable,
> > but it does not make use of the code. This patch let it return
> > the errcode in case of failure.
> > 
> > Suggested-by: Richard Cochran <richardcochran@gmail.com>
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>

You are the maintainer of this file, shouldn't you be the one sending it
off to Linus or putting it in your tree somewhere?

thanks,

greg k-h
