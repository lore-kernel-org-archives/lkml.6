Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6E1C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 229B020851
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 06:59:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PCb3OQ1S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 229B020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbeLEG7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 01:59:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:49704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726369AbeLEG7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 01:59:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B388C2082B;
        Wed,  5 Dec 2018 06:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543993172;
        bh=1xmV+wrM6u/CBZJTFyGh9mkSJHQ0zzNJi+zJCKebNgE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PCb3OQ1S4H+cira0yfT8cHwhWeweXxNvd/2r0fEF4MyV7I8x4vQoepaENdyoSWWz/
         bMvdbSjvXYNwPGVo6VybxTv4f7YFFQQTxjaJDEN4CzEQcy5APa0eAy6Or+Ht1KUFws
         2MIEGK7stKwQHlslqTMYaCwe2H/hOrjx15YhIjw4=
Date:   Wed, 5 Dec 2018 07:59:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, yuchao0@huawei.com,
        jaegeuk@kernel.org, Ben Hutchings <ben.hutchings@codethink.co.uk>,
        sashal@kernel.org
Subject: Re: [PATCH 4.14 054/146] f2fs: fix to do sanity check with block
 address in main area
Message-ID: <20181205065929.GB16346@kroah.com>
References: <20181204103726.750894136@linuxfoundation.org>
 <20181204103729.017806593@linuxfoundation.org>
 <CADVatmNvBKBKsC6CCeCGtHPb6v=F11vzU2FVq_nt0J+VdW8=og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADVatmNvBKBKsC6CCeCGtHPb6v=F11vzU2FVq_nt0J+VdW8=og@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:27:32PM +0000, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Tue, Dec 4, 2018 at 11:05 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > 4.14-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > commit c9b60788fc760d136211853f10ce73dc152d1f4a upstream.
> 
> There is another upstream commit which fixes this.
> 89d13c38501d ("f2fs: fix missing up_read")

Thanks for pointing this out, now queued up.

greg k-h
