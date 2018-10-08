Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C75C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AEB2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 17:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Vbfr7Ev2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49AEB2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbeJIAPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 20:15:48 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:58358 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbeJIAPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 20:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
        From:Date:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AESrSrhgh6Cmo8lbW8MnOOdQoQLUMYNLDGezVG0Zmhw=; b=Vbfr7Ev2y1bVBRYHtubVXEsYz
        t9GkuL/szAilZFaJPjW4ZtY8lStGe7pLfyQ5PMFi/wXs9mWGtDAO0ZOv6k39zku37fzZZaphudedz
        ZRUFLhsayn2XyfyioV9LfB1bY99yN+YvAhNjt7V77ZwrSjS1ZA3Og5V2M5FGtqpjt97gOOCc4FiKy
        aFX7QnWCcfxl3z/JdQ0wG5ZBJnMIulautghaOlodrLXDHLcwElqx0Sbd2iBWfLCaUQuNXh+Ty1Rc7
        2PdnYVH0mSqUJNs89k5tahXytu/Bawnri2/aupWT0R7AO4AnckuJkjlyesu3CcszWZ9v2/TGQhOIq
        ZG2sdqTAg==;
Received: from [179.183.98.126] (helo=coco.lan)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1g9Yvz-0004LJ-3j; Mon, 08 Oct 2018 17:03:07 +0000
Date:   Mon, 8 Oct 2018 14:03:02 -0300
From:   Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Keiichi Watanabe <keiichiw@chromium.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, tfiga@chromium.org,
        jcliang@chromium.org, shik@chromium.org
Subject: Re: [PATCH] media: vivid: Support 480p for webcam capture
Message-ID: <20181008140302.2239633f@coco.lan>
In-Reply-To: <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com>
References: <20181003070656.193854-1-keiichiw@chromium.org>
        <b2dc51d7-fc92-2e7b-3a07-55a076b95d8b@ideasonboard.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 3 Oct 2018 12:14:22 +0100
Kieran Bingham <kieran.bingham@ideasonboard.com> escreveu:

> > @@ -75,6 +76,8 @@ static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
> >  	{  1, 5 },
> >  	{  1, 10 },
> >  	{  1, 15 },
> > +	{  1, 15 },
> > +	{  1, 25 },  

As the code requires that VIVID_WEBCAM_IVALS would be twice the number
of resolutions, I understand why you're doing that.

> But won't this add duplicates of 25 and 15 FPS to all the frame sizes
> smaller than 1280,720 ? Or are they filtered out?

However, I agree with Kieran: looking at the code, it sounds to me that
it will indeed duplicate 1/15 and 1/25 intervals.

I suggest add two other intervals there, like:
	12.5 fps and 29.995 fps, e. g.:

static const struct v4l2_fract webcam_intervals[VIVID_WEBCAM_IVALS] = {
        {  1, 1 },
        {  1, 2 },
        {  1, 4 },
        {  1, 5 },
        {  1, 10 },
        {  1, 15 },
	{  2, 50 },
        {  1, 25 },
        {  1, 30 },
        {  1, 40 },
        {  1, 50 },
	{  1001, 30000 },
        {  1, 60 },
};

Provided, of course, that vivid would support producing images
at fractional rate. I didn't check. If not, then simply add
1/20 and 1/40.

> Now the difficulty is adding smaller frame rates (like 1,1, 1,2) would
> effect/reduce the output rates of the larger frame sizes, so how about
> adding some high rate support (any two from 1/{60,75,90,100,120}) instead?

Last week, I got a crash with vivid running at 30 fps, while running an 
event's race code, on a i7core (there, the code was switching all video
controls while subscribing/unsubscribing events). The same code worked
with lower fps.

While I didn't have time to debug it yet, I suspect that it has to do
with the time spent to produce a frame on vivid. So, while it would be
nice to have high rate support, I'm not sure if this is doable. It may,
but perhaps we need to disable some possible video output formats, as some
types may consume more time to build frames.

Thanks,
Mauro
