Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE3EC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 215DA20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:48:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 215DA20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732287AbeGKJvf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:51:35 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46364 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeGKJvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:51:35 -0400
Received: from 79.184.255.246.ipv4.supernova.orange.pl (79.184.255.246) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83)
 id e070bb6c99e58c30; Wed, 11 Jul 2018 11:48:04 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Robin Murphy <robin.murphy@arm.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH 2/2] device core: Add flag to autoremove device link on supplier unbind
Date:   Wed, 11 Jul 2018 11:46:33 +0200
Message-ID: <1982222.Z9Wz93BAKD@aspire.rjw.lan>
In-Reply-To: <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
References: <20180627125056.12851-1-vivek.gautam@codeaurora.org> <CAJZ5v0jb2075fcabZDxPpE+7Bo=NpcFm7kEY5QfO-ZbcfGkDyw@mail.gmail.com> <1c0f5cb8-4805-4200-406f-0725122b524f@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, July 5, 2018 6:28:16 AM CEST Vivek Gautam wrote:
> 
> On 7/5/2018 4:49 AM, Rafael J. Wysocki wrote:
> > On Wed, Jul 4, 2018 at 8:09 PM, Vivek Gautam
> > <vivek.gautam@codeaurora.org> wrote:
> >>
> >> On 7/4/2018 4:14 PM, Rafael J. Wysocki wrote:
> >>> On Wednesday, July 4, 2018 9:16:20 AM CEST Vivek Gautam wrote:
> >>>> Adding Ulf and Marek.
> >>>>
> >>>> On 6/27/2018 6:20 PM, Vivek Gautam wrote:
> >>>>> Add a flag to autoremove the device links on supplier driver
> >>>>> unbind. This obviates the need to explicitly delete the link
> >>>>> in the remove path.
> >>>>> We remove these links only when the supplier's link to its
> >>>>> consumers has gone to DL_STATE_SUPPLIER_UNBIND state.
> >>>>>
> >>>>> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> >>>>> Suggested-by: Lukas Wunner <lukas@wunner.de>
> >>>>> Cc: Jonathan Corbet <corbet@lwn.net>
> >>>>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >>>>> Cc: Robin Murphy <robin.murphy@arm.com>
> >>>>> Cc: linux-doc@vger.kernel.org
> >>>>> Cc: linux-arm-kernel@lists.infradead.org
> >>>>> Cc: linux-pm@vger.kernel.org
> >>>>> Cc: linux-arm-msm@vger.kernel.org
> >>>>> ---
> >>>> Hi Rafael, et al.
> >>>>
> >>>> Gentle ping.
> >>>> Do you have comments on this series. I would really like to conclude
> >>>> these
> >>>> device link additions sooner, and get things moving on the long awaited
> >>>> arm-smmu clock/runtime support series.
> >>>>
> >>>> Thanks again for reviewing these patches.
> >>> They are fine by me.
> >>>
> >>> I can queue them up for 4.19 if no one has objections (Greg in
> >>> particular).
> >>
> >> Hi Rafael,
> >>
> >> I will resubmit these 2 patches as part of the arm-smmu series, as one
> >> of the patch in the series depends on addition of
> >> DL_FLAG_AUTOREMOVE_SUPPLIER.
> >> So these 2 patches and arm-smmu series should go together.
> >> Can you please consider givnig your Ack?
> > I would prefer to apply them myself to be honest and put them on an
> > public git branch for you to pull from.
> 
> Sure. Fine with me. I will base the smmu patches on your branch.

The patches have been applied and are available for pulling in the pm-core
branch of the linux-pm.git tree:

git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git pm-core

Thanks,
Rafael

