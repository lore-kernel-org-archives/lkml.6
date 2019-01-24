Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E41CC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13A7921855
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="CcafNqNl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfAXUEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:04:06 -0500
Received: from mail-qt1-f169.google.com ([209.85.160.169]:39707 "EHLO
        mail-qt1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728420AbfAXUEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 15:04:04 -0500
Received: by mail-qt1-f169.google.com with SMTP id u47so8157658qtj.6
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 12:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=UpjSM65vSFVWKvbsNUc+zXwEuqytBGW3xVvN8s52zBs=;
        b=CcafNqNlu/q87wkMbSTriUwItxDs2v8VgEN4EBvUOM/RnciSRv+Ds2a0WzuEXPfAU+
         F95bk+8Z2ApuIdoBjyhfgCx6TRdMFjI0ipJ1rye4yATCobLctjF7CHgLqV60vU4dpN/T
         lrdBuUQA/ThYol3/jBCiPse7ZuvbbUd2Tc6hqJR+LL1xu84y0O5p92X0XKsliLOWuWmA
         aBV0bXFtZvl6em5Byp4xKnyIsv1vhJ9YYTv8W/iQsmM9AwCnc0885BmgovC8aEljxfTn
         +KbuYQpcQcB6FmzhVNfIDGaWjjVozXWuZ+UuJGYMwKOV3Rh7RXJvY+TfggIwvgb2JIII
         EBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=UpjSM65vSFVWKvbsNUc+zXwEuqytBGW3xVvN8s52zBs=;
        b=Eq+iJ3vw7x4eBNekbRc8rdFcB2p23kfwQJ25abwHrRW99AF4RPc4R3QRlH0I8bAMFF
         SMCVuTpjh/kCTSXnoMLxE7YCgQ4/am+UIsPxXlDRNSQTTYmqQOm/+gXnuJstgYW46pl/
         zVLlxBHMtgAOgqrIgdh9GE0l4xdGamWfix619Axij4FhHk+n61whkzGbOC5ZwfVuyvEz
         Jg0AluADectj03+X6Ar+L7Gk/pR7LnV5fbu0+O7fB2V7rIOH8vgaxBgIVkJaVuF5jS2M
         glKwH/B5IEb1JX9tvTSxQwb8ZwLQu9UKFokhV/no1KgZNMyKINMLnu1Scw56pxSJ2tK/
         l7pQ==
X-Gm-Message-State: AJcUukcrvyYe+VBWjZyArTsD0VvUo17o/eKxDSNQwjN/MvLViIt3g/W5
        vkbLMPg5FsAMHkSmkFeje5Z5bA==
X-Google-Smtp-Source: ALg8bN7ObBSAvoEaLO8PJYTgQzS2eHCx/6hbDIEO0jC/SjgTwy1XKFk6N2NNe0ry79Qg9oPDvwD4/g==
X-Received: by 2002:ac8:1779:: with SMTP id u54mr8092021qtk.285.1548360242713;
        Thu, 24 Jan 2019 12:04:02 -0800 (PST)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id o65sm70084686qkl.11.2019.01.24.12.04.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 12:04:02 -0800 (PST)
Message-ID: <ea1b39bf1a14f73b74d17c925f67ea3613ea6eae.camel@ndufresne.ca>
Subject: Re: [PATCH v2 2/2] media: docs-rst: Document memory-to-memory video
 encoder interface
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Hans Verkuil <hverkuil@xs4all.nl>, Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?Q?Pawe=C5=82_O=C5=9Bciak?= <posciak@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Kamil Debski <kamil@wypas.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Jeongtae Park <jtp.park@samsung.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Todor Tomov <todor.tomov@linaro.org>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dave.stevenson@raspberrypi.org,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Maxime Jourdan <maxi.jourdan@wanadoo.fr>
Date:   Thu, 24 Jan 2019 15:04:00 -0500
In-Reply-To: <fcad4ca0-cfdd-d0fb-4b18-808426584755@xs4all.nl>
References: <20181022144901.113852-1-tfiga@chromium.org>
         <20181022144901.113852-3-tfiga@chromium.org>
         <4cd223f0-b09c-da07-f26c-3b3f7a8868d7@xs4all.nl>
         <5fb0f2db44ba7aa3788b61f2aa9a30d4f4984de5.camel@ndufresne.ca>
         <d853eb91-c05d-fb10-f154-bc24e4ebb89d@xs4all.nl>
         <CAAFQd5COddN-YosKyfBJ7n=qt40ONP=YEjBo5HQBOPGhs19h+g@mail.gmail.com>
         <fcad4ca0-cfdd-d0fb-4b18-808426584755@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 23 janvier 2019 à 12:28 +0100, Hans Verkuil a écrit :
> On 01/23/19 11:00, Tomasz Figa wrote:
> > On Sat, Nov 17, 2018 at 8:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
> > > On 11/17/2018 05:18 AM, Nicolas Dufresne wrote:
> > > > Le lundi 12 novembre 2018 à 14:23 +0100, Hans Verkuil a écrit :
> > > > > On 10/22/2018 04:49 PM, Tomasz Figa wrote:
> > [snip]
> > > > > > +      rely on it. The ``V4L2_BUF_FLAG_LAST`` buffer flag should be used
> > > > > > +      instead.
> > > > > 
> > > > > Question: should new codec drivers still implement the EOS event?
> > > > 
> > > > I'm been asking around, but I think here is a good place. Do we really
> > > > need the FLAG_LAST in userspace ? Userspace can also wait for the first
> > > > EPIPE return from DQBUF.
> > > 
> > > I'm interested in hearing Tomasz' opinion. This flag is used already, so there
> > > definitely is a backwards compatibility issue here.
> > > 
> > 
> > FWIW, it would add the overhead of 1 more system call, although I
> > don't think it's of our concern.
> > 
> > My personal feeling is that using error codes for signaling normal
> > conditions isn't very elegant, though.
> 
> I agree. Let's keep this flag.

Agreed, though a reminder of the initial question, "do we keep the EOS
event ?", and I think the event can be dropped.

> 
> Regards,
> 
> 	Hans
> 
> > > > > > +
> > > > > > +3. Once all ``OUTPUT`` buffers queued before the ``V4L2_ENC_CMD_STOP`` call and
> > > > > > +   the last ``CAPTURE`` buffer are dequeued, the encoder is stopped and it will
> > > > > > +   accept, but not process any newly queued ``OUTPUT`` buffers until the client
> > > > > > +   issues any of the following operations:
> > > > > > +
> > > > > > +   * ``V4L2_ENC_CMD_START`` - the encoder will resume operation normally,
> > > > > 
> > > > > Perhaps mention that this does not reset the encoder? It's not immediately clear
> > > > > when reading this.
> > > > 
> > > > Which drivers supports this ? I believe I tried with Exynos in the
> > > > past, and that didn't work. How do we know if a driver supports this or
> > > > not. Do we make it mandatory ? When it's not supported, it basically
> > > > mean userspace need to cache and resend the header in userspace, and
> > > > also need to skip to some sync point.
> > > 
> > > Once we agree on the spec, then the next step will be to add good compliance
> > > checks and update drivers that fail the tests.
> > > 
> > > To check if the driver support this ioctl you can call VIDIOC_TRY_ENCODER_CMD
> > > to see if the functionality is supported.
> > 
> > There is nothing here for the hardware to support. It's an entirely
> > driver thing, since it just needs to wait for the encoder to complete
> > all the pending frames and stop enqueuing more frames to the decoder
> > until V4L2_ENC_CMD_START is called. Any driver that can't do it must
> > be fixed, since otherwise you have no way to ensure that you got all
> > the encoded output.
> > 
> > Best regards,
> > Tomasz
> > 

