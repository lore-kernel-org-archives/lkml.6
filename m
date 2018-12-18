Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B88C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E69EF2184C
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 21:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545169221;
	bh=NjVwqfXeFsL9NB6Y1BCrOiBFK7L9VhI63AU+az+6d2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DrFRPvPHHu585a/kM0YRui/AROR9MED3aY/D7wONQEaCNModxKIDOg7K+tjTOL3j0
	 hyYr7dcENxVqI4nsyLXe0M4NYntbRXx/jC61yqMIVd8lAwcJhTx4yq4adzhJLeU0V1
	 abWHPcdVXlSaH1x1CY9Hp9EPkkoV7m2tyJsCthfo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727208AbeLRVkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 16:40:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:47262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbeLRVkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 16:40:19 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B59721871;
        Tue, 18 Dec 2018 21:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545169219;
        bh=NjVwqfXeFsL9NB6Y1BCrOiBFK7L9VhI63AU+az+6d2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eE0DKYKWh9Anh3HMu3TEvZSZDwzP5UL1ybma9lHyb/OEXbxw92/LBvCWVMg/JjICr
         puc9CpWJGnuEMhnoJZ/MTe2TW/nfPCX1abGGpGbCuJpe3jcm/k0CVZTXkWyQav5Cej
         YOSxDempwNLPTAqF1N+9RPvL4dICKNsPhAIYtZeg=
Date:   Tue, 18 Dec 2018 13:40:18 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, dm-devel@redhat.com,
        Alasdair Kergon <agk@redhat.com>, stable@vger.kernel.org
Subject: Re: dm: give req_size precisely given by user
Message-ID: <20181218214018.GA31062@jaegeuk-macbookpro.roam.corp.google.com>
References: <20181218172537.12300-1-jaegeuk@kernel.org>
 <01a60138-63ab-6a9d-c0ba-b8fea551b14e@kernel.dk>
 <20181218194708.GA24676@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218194708.GA24676@redhat.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18, Mike Snitzer wrote:
> On Tue, Dec 18 2018 at 12:45pm -0500,
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On 12/18/18 10:25 AM, Jaegeuk Kim wrote:
> > > This patch makes dm be aware of io_pages to assign sane req_size for reads.
> > 
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > 
> 
> I've applied this, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git/commit/?h=dm-4.21&id=c6d6e9b0f6b4201c77f2cea3964dd122697e3543

Got it. Thank you so much.
