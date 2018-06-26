Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673FFC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1111C268D0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 10:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1111C268D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934468AbeFZKUj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 06:20:39 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:61140 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933478AbeFZKUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 06:20:38 -0400
Received: from 79.184.255.183.ipv4.supernova.orange.pl (79.184.255.183) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 47f7c1da5ffe8d6b; Tue, 26 Jun 2018 12:20:36 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Greg KH <gregkh@linuxfoundation.org>, lukas@wunner.de,
        dmitry.torokhov@gmail.com, aspriel@gmail.com,
        Robin Murphy <robin.murphy@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 1/1] device core: Add flag to autoremove device link on supplier unbind
Date:   Tue, 26 Jun 2018 12:19:20 +0200
Message-ID: <6354476.UjADPVylrh@aspire.rjw.lan>
In-Reply-To: <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
References: <20180530095704.5788-1-vivek.gautam@codeaurora.org> <541c84e9-47fc-e7bc-8249-1477b9e63455@codeaurora.org> <CAFp+6iGwcbOm0p33o9NEE7YBZNNvRsBeU0ySy0HcEmvq8mhBJA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 26, 2018 12:03:44 PM CEST Vivek Gautam wrote:
> On Wed, May 30, 2018 at 6:21 PM, Vivek Gautam
> <vivek.gautam@codeaurora.org> wrote:
> 
> Adding Ulf and Marek for their side of comments.
> In summary, we do not want to not maintain a device link pointer
> when adding a device link in supplier's driver, to delete the link later.
> An autoremove flag from the suppliers side (similar to what we already
> have for consumer side) can help autoremove the device link
> when supplier driver goes away.
> 
> Hi Rafael, Lukas,
> Gentle ping. Can you please consider reviewing this patch.

ISTR telling you that I didn't like the DL_FLAG_AUTOREMOVE_S name
as it is too similar to another existing flag.  That hasn't changed.

BTW, please CC the patch to linux-pm when you resend it.

Thanks,
Rafael

