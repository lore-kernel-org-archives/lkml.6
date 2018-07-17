Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F5FECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:55:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD6E20C09
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 06:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD6E20C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728330AbeGQH06 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 03:26:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44376 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeGQH06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 03:26:58 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 61B0ED0E;
        Tue, 17 Jul 2018 06:55:52 +0000 (UTC)
Date:   Tue, 17 Jul 2018 08:55:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Todd Poynor <toddpoynor@gmail.com>
Cc:     devel@driverdev.osuosl.org, Zhongze Hu <frankhu@chromium.org>,
        John Joseph <jnjoseph@google.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Simon Que <sque@chromium.org>,
        Rob Springer <rspringer@google.com>,
        Guenter Roeck <groeck@chromium.org>,
        Todd Poynor <toddpoynor@google.com>,
        Dmitry Torokhov <dtor@chromium.org>
Subject: Re: [PATCH 05/18] staging: gasket: sysfs mapping creation fixups
Message-ID: <20180717065548.GA10961@kroah.com>
References: <20180714055816.223754-1-toddpoynor@gmail.com>
 <20180714055816.223754-6-toddpoynor@gmail.com>
 <20180714063224.GD20451@kroah.com>
 <CAO3upoZQ0QXc5OjvhJbwN42QE71m6ABvLb2WM_iFVWd64iGgSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO3upoZQ0QXc5OjvhJbwN42QE71m6ABvLb2WM_iFVWd64iGgSg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2018 at 02:14:27PM -0700, Todd Poynor wrote:
> On Fri, Jul 13, 2018 at 11:32 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Fri, Jul 13, 2018 at 10:58:03PM -0700, Todd Poynor wrote:
> >> From: Todd Poynor <toddpoynor@google.com>
> >>
> >> Return EBUSY for attempt to create a mapping already in use.
> >
> > Why?
> 
> The existing code returns EINVAL which often means something bogus was
> requested, whereas EBUSY is sometimes used for requesting something
> already in use.  If that's not an error typically returned in this
> situation I'm happy to drop it.

My "why" was rhetorical, please spell this out in the changelog text :)

thanks,

greg k-h
