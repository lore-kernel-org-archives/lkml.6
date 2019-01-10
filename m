Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CFE6C43612
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0459F20874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 21:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfAJV4F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 16:56:05 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:58530 "EHLO dcvr.yhbt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729257AbfAJV4E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 16:56:04 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
        by dcvr.yhbt.net (Postfix) with ESMTP id 30BA21F803;
        Thu, 10 Jan 2019 21:56:04 +0000 (UTC)
Date:   Thu, 10 Jan 2019 21:56:04 +0000
From:   Eric Wong <e@80x24.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Patrick McDermott <patrick.mcdermott@libiquity.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Sylvain Chouleur <sylvain.chouleur@intel.com>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtc: cmos: ignore bogus century byte
Message-ID: <20190110215603.gliuq36qqpfnflkv@dcvr>
References: <20190106082103.evfgarznrskd4oxh@dcvr>
 <20190110213334.GE2362@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190110213334.GE2362@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alexandre Belloni <alexandre.belloni@bootlin.com> wrote:
> Does this mean that it is set to an invalid value and that in is not
> getting updated properly in mc146818_set_time?

It seems to be set/updated without trouble while the machine is
on.  It's only on a cold boot (from poweroff or hibernate) that
the value is invalid.

Patrick may be able to fill you in on more details.
