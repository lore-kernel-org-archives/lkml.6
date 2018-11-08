Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3628CC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDFF620840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="etvN4lBK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDFF620840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbeKIIWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:22:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:58854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKIIWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 03:22:20 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B670220857;
        Thu,  8 Nov 2018 22:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541717077;
        bh=OlEi6anXuXbfeCFuP3weSfXPEum1FVRB21YlvPoC1lw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=etvN4lBKk9uB85itMmg386VbnW0IqCcB3Hor0u5+uowRdhxXYsQggg5zeTLtcBhyy
         bQtE9BnPdb3XX3oa33Q3aq6e7gjdZ3XenPk12aUdqJUt1/Std/qCwYGk/OBBirVEHK
         3+uZpv/p3swFG+dHE6fGMvhsqLTTz7MZ1LFj5dms=
Date:   Thu, 8 Nov 2018 14:44:37 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 3.18 053/144] ARM: OMAP2+: Fix n900 board name for legacy
 user space
Message-ID: <20181108224437.GA20928@kroah.com>
References: <20181108215054.826084593@linuxfoundation.org>
 <20181108215058.676426973@linuxfoundation.org>
 <20181108220530.GA17186@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181108220530.GA17186@amd>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 08, 2018 at 11:05:30PM +0100, Pavel Machek wrote:
> On Thu 2018-11-08 13:50:24, Greg Kroah-Hartman wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit 71c4f6027da75c6c1fd92e05b63108a09ec2b109 ]
> > 
> > N900 legacy user space apps need the board name in
> > /proc/cpuinfo to work properly for the Hardware entry.
> > 
> > For other boards this should not be an issues and they
> > can use the generic Hardware entry.
> > 
> > Let's fix the issue by adding a custom DT_MACHINE_START
> > for n900.
> > 
> > Tested-by: Pali Rohár <pali.rohar@gmail.com>
> > Acked-by: Pavel Machek <pavel@ucw.cz>
> > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> I don't think this is good idea. N900 support changed a lot in the
> meantime. It may not be neccessary or may break something, not
> sure. Not comfortable with this w/o testing.

Ok now dropped, thanks for letting me know.

greg k-h
