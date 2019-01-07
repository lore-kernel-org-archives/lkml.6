Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D1C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C85172089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 10:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546856213;
	bh=7bk0BQnjs+s0/FuuVeNhRPZdNs/cubAJJq8XsjY1wLc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DPLthqxeyfolIpRCU4p/Dfbe4VuiaaJ7VO4QnaW8SA/XZTAPiJsowGL6fJWlGgyaJ
	 XgUY00Vk9J7aW3cmCYq8DjY97OOwxPvUBy/a7/pHIbC86wPUpyLhwqPU04sjVYSMFp
	 drAxPtK/j6K09bqQllZWm4swgtGPraqReZP5FCcU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfAGKQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 05:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbfAGKQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 05:16:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03F342087F;
        Mon,  7 Jan 2019 10:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546856211;
        bh=7bk0BQnjs+s0/FuuVeNhRPZdNs/cubAJJq8XsjY1wLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wbO8kAa+oak7PnwcLwq2KQ2omPaaPZioeiPPjzWLRVhk3mXXLTNBRVUBKsHAiRtSa
         F0atFmJSjJ1UAkkO8LdLaCzcrht7uhtOyBrSU3UF4ACY1xNKMQ+22/nntiqIQhkNmy
         U+dWx1+OvxoRGEy+6kTI+5ree/p7BI5lYdlGiTDw=
Date:   Mon, 7 Jan 2019 11:16:49 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Aditya Pakki <pakki001@umn.edu>
Cc:     Arushi Singhal <arushisinghal19971997@gmail.com>,
        devel@driverdev.osuosl.org, kjlu@umn.edu,
        linux-kernel@vger.kernel.org,
        Mamta Shukla <mamtashukla555@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Quytelda Kahja <quytelda@tamalin.org>,
        Wen Yang <wen.yang99@zte.com.cn>
Subject: Re: [PATCH] v2 staging: rtl8723bs: Clean up dead code
Message-ID: <20190107101649.GA2750@kroah.com>
References: <20190106162101.9176-1-pakki001@umn.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190106162101.9176-1-pakki001@umn.edu>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06, 2019 at 10:20:59AM -0600, Aditya Pakki wrote:
> rtw_wps_start() is part of dead code due to CONFIG_INTEL_WIDI.
> The fix removes the deadcode and replaces the function with NULL
> in rtw_private_handler. Identified as part of copy_from_user bug.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>
> ---
>  .../staging/rtl8723bs/os_dep/ioctl_linux.c    | 34 +------------------
>  1 file changed, 1 insertion(+), 33 deletions(-)

What changed from v1?  Always put that below the --- line.

Please fix up and send v3.

thanks,

greg k-h
