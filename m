Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E81C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AA424349
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 10:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43AA424349
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933543AbeGDKpr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 06:45:47 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46644 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932531AbeGDKpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 06:45:45 -0400
Received: from 79.184.254.38.ipv4.supernova.orange.pl (79.184.254.38) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id 925c196a9dd8eb0e; Wed, 4 Jul 2018 12:45:43 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on supplier unbind
Date:   Wed, 04 Jul 2018 12:44:20 +0200
Message-ID: <2991909.NMIP74eIIJ@aspire.rjw.lan>
In-Reply-To: <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <20180627125056.12851-2-vivek.gautam@codeaurora.org> <5b2d17e8-2224-512c-e01c-212828ecf74b@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
> Adding Ulf and Marek.
> 
> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
> > Add a flag to autoremove the device links on supplier driver
> > unbind. This obviates the need to explicitly delete the link
> > in the remove path.
> > We remove these links only when the supplier's link to its
> > consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
> >
> > Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: linux-doc@vger.kernel.org
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-arm-msm@vger.kernel.org
> > ---
> 
> Hi Rafael, et al.
> 
> Gentle ping.
> Do you have comments on this series. I would really like to conclude these
> device link additions sooner, and get things moving on the long awaited
> arm-smmu clock/runtime support series.
> 
> Thanks again for reviewing these patches.

They are fine by me.

I can queue them up for 4.19 if no one has objections (Greg in
particular).

Thanks,
Rafael

