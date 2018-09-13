Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA849C04ABB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD2EE20881
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 07:06:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2EE20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbeIMMPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 08:15:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40946 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeIMMPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 08:15:01 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BC5D5707;
        Thu, 13 Sep 2018 07:06:51 +0000 (UTC)
Date:   Thu, 13 Sep 2018 09:06:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc:     Sasha Levin <alexander.levin@microsoft.com>,
        stable@vger.kernel.org, Stefan Schmidt <stefan@datenfreihafen.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.4 48/79] ieee802154: at86rf230: use __func__ macro for
 debug messages
Message-ID: <20180913070648.GE11496@kroah.com>
References: <20180823074918.641878835@linuxfoundation.org>
 <20180823074922.245271192@linuxfoundation.org>
 <1536696373.3024.148.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1536696373.3024.148.camel@codethink.co.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 09:06:13PM +0100, Ben Hutchings wrote:
> On Thu, 2018-08-23 at 09:53 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Stefan Schmidt <stefan@datenfreihafen.org>
> > 
> > [ Upstream commit 8a81388ec27c4c0adbdecd20e67bb5f411ab46b2 ]
> > 
> > Instead of having the function name hard-coded (it might change and we
> > forgot to update them in the debug output) we can use __func__ instead
> > and also shorter the line so we do not need to break it. Also fix an
> > extra blank line while being here.
> > Found by checkpatch.
> [...]
> 
> This is a perfectly good fix for upstream, but really not important
> enough for stable.  Sasha, please retrain your patch selector.

For some reason I thought this was a dependancy for a later patch, but
that seems to not be correct.  Was the real reason later removed from
the series?

greg k-h
