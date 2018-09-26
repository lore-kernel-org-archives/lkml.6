Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB92C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FD77208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 09:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MiyXmNFi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD77208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeIZPqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 11:46:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49380 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbeIZPqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 11:46:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=3U7hfMzcimC7DYPkkt47StWN6o+SdKi5RDLagmwY7kM=; b=MiyXmNFiMA9tyrU6aaO0f/jau
        wNRLJUw9bMa8LlIV2nJ8PkwprhD6hq/CS7AuE4QF+MP4oLLeLYXlxz+GMyfiyKCXZWCjJR4upVYR2
        cOk8WH1wywtvvt+kkm6lT96crbIguXEGtxJs8nvykB6hHf+q2wURXuobY+RPY+SpwNqYldIXpS6g1
        LaCti5Oug5a7AJY6E3fduxQyFWWR8bhd1hg2w+2PmqQ+B4V2YljZpo+gf+aYvPKhAKIvULpEb0dzJ
        N/M5JxgJVxi+Z8Qdzsx4PsgHHwsNDEV6pWsHqZWsfAR4hfGppB54ko2XSmIZ1hVYx0XAno/vOPmtv
        CJg9ff1kQ==;
Received: from 177.43.23.201.dynamic.adsl.gvt.net.br ([177.43.23.201] helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g56CT-0005oD-8I; Wed, 26 Sep 2018 09:33:57 +0000
Date:   Wed, 26 Sep 2018 06:33:35 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Steve Longerbeam <steve_longerbeam@mentor.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Niklas =?UTF-8?B?U8O2ZGVybHVu?= =?UTF-8?B?ZA==?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Sebastian Reichel <sre@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 02/17] media: v4l2: async: Allow searching for asd of
 any type
Message-ID: <20180926063335.3c3b863d@coco.lan>
In-Reply-To: <36fd43b2-695d-b990-bec2-c4d88ccb8e88@mentor.com>
References: <1531175957-1973-1-git-send-email-steve_longerbeam@mentor.com>
        <1531175957-1973-3-git-send-email-steve_longerbeam@mentor.com>
        <20180924140604.23e2b56f@coco.lan>
        <a8ea673c-a519-81e8-35b1-9d4a224dcbf5@mentor.com>
        <20180925192045.59c83e3d@coco.lan>
        <36fd43b2-695d-b990-bec2-c4d88ccb8e88@mentor.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 25 Sep 2018 18:05:36 -0700
Steve Longerbeam <steve_longerbeam@mentor.com> escreveu:

> On 09/25/2018 03:20 PM, Mauro Carvalho Chehab wrote:
> > Em Tue, 25 Sep 2018 14:04:21 -0700
> > Steve Longerbeam <steve_longerbeam@mentor.com> escreveu:
> >  
> >>>     
> >>>> @@ -392,12 +406,11 @@ static int __v4l2_async_notifier_register(struct v4l2_async_notifier *notifier)
> >>>>    		case V4L2_ASYNC_MATCH_CUSTOM:
> >>>>    		case V4L2_ASYNC_MATCH_DEVNAME:
> >>>>    		case V4L2_ASYNC_MATCH_I2C:
> >>>> -			break;
> >>>>    		case V4L2_ASYNC_MATCH_FWNODE:
> >>>> -			if (v4l2_async_notifier_fwnode_has_async_subdev(
> >>>> -				    notifier, asd->match.fwnode, i)) {
> >>>> +			if (v4l2_async_notifier_has_async_subdev(
> >>>> +				    notifier, asd, i)) {
> >>>>    				dev_err(dev,
> >>>> -					"fwnode has already been registered or in notifier's subdev list\n");
> >>>> +					"asd has already been registered or in notifier's subdev list\n");  
> >>> Please, never use "asd" on messages printed to the user. While someone
> >>> may understand it while reading the source code, for a poor use,
> >>> "asd" is just a random sequence of 3 characters.  
> >> I will change the message to read:
> >>
> >> "subdev descriptor already listed in this or other notifiers".  
> > Perfect!  
> 
> But the error message is removed in the subsequent patch
> "[PATCH 03/17] media: v4l2: async: Add v4l2_async_notifier_add_subdev".
> 
> I could bring it back as a dev_dbg() in v4l2_async_notifier_asd_valid(), but
> this shouldn't be a dev_err() anymore since it is up to the media platform
> to decide whether an already existing subdev descriptor is an error.

Hmm... that's an interesting discussion... what cases do you think it
would be fine to try to register twice an asd notifier?

Haven't write myself any piece of code using async framework, on a first
glance, trying to register twice sounds like an error to me.

Sakari, what do you think?

Thanks,
Mauro
