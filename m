Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBF8C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F9002080A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 18:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kApAc8ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390555AbfBNSAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 13:00:50 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35495 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbfBNSAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 13:00:50 -0500
Received: by mail-lj1-f196.google.com with SMTP id j13-v6so6063689ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNdmBhJV6l2CrpOn23AdUvuvbdoQzPMeGeladPJyn9A=;
        b=kApAc8juLL1jfsml6kvJ912qHNEFbMQMO0HAg6aPT+R9mD7nmIVEz9780OYMNDENsy
         5KLMqJuFyeTsEIyCMUFclXbwU7ny5JbACEz1fgVxx2hHfBVKBTdRRLgqMPi14FyENs/b
         phPeh1WjjPTFjNPwtwKLdYKZ2aZAM/miG+sR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNdmBhJV6l2CrpOn23AdUvuvbdoQzPMeGeladPJyn9A=;
        b=o2N0SGCuYrscyzcQlAnuQEVPr7Ysf1JTGhc0Cpoe5mFjQfNIjvv09KQHIZoe+5EoEb
         JtqgMEHL6z557/6P+Qwfxd+rKdw+SxIrGlZA4NmcpptLnBnw3xbEE0PJm5op3lqIhafA
         /wUjY+JVGa8EaDw4T9mabO+zMNjyfIj6Yl3beRTSno+4YZ86psU0kKBeoNQ4hYKx795D
         jzn+8L0YsM2Unbub2ZMx+kctsj8536Y+Jqr0tEcrFkvO2slkgJQRHW9Yfsk6jmT7Ljtt
         EU1KWPlnc5ivXpfsXgnONOWoGsQKlEfKa4eA22I5dSLclu9TybZloW6WPBhlUc+umHYA
         xOfA==
X-Gm-Message-State: AHQUAuZJjwivBkv1pdLOjFg40R59cH6AgIKJRt7hZ4KxC6V2p8LRBqTJ
        6m7sEsWtdiOTJntBvTavbzGGY/ajnNM=
X-Google-Smtp-Source: AHgI3Ia62/Nap2c6NWr/E2Db0/e/ZDbcb6CvA7IB3d6sG8ePyoqzVZvHqkOeybIXLRok45iDDVTiVw==
X-Received: by 2002:a2e:8105:: with SMTP id d5-v6mr3375665ljg.76.1550167247746;
        Thu, 14 Feb 2019 10:00:47 -0800 (PST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id r10-v6sm554310ljj.71.2019.02.14.10.00.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 10:00:47 -0800 (PST)
Received: by mail-lj1-f179.google.com with SMTP id z20so5026607ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 10:00:47 -0800 (PST)
X-Received: by 2002:a2e:99c9:: with SMTP id l9mr2782851ljj.60.1550167242216;
 Thu, 14 Feb 2019 10:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20190207205730.199332-1-evgreen@chromium.org> <20190207205730.199332-3-evgreen@chromium.org>
 <yq1d0nvqeix.fsf@oracle.com>
In-Reply-To: <yq1d0nvqeix.fsf@oracle.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Thu, 14 Feb 2019 10:00:05 -0800
X-Gmail-Original-Message-ID: <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
Message-ID: <CAE=gft6bdM2dLc9RhGYMWp8bz6_c-W8Yy-CUTM9wXe+UiYkXEw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] loop: Better discard support for block devices
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Alexis Savery <asavery@chromium.org>,
        Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 6:40 PM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Evan,
>
> > If the backing device for a loop device is a block device, then mirror
> > the discard properties of the underlying block device into the loop
> > device. While in there, differentiate between REQ_OP_DISCARD and
> > REQ_OP_WRITE_ZEROES, which are different for block devices, but which
> > the loop device had just been lumping together.
>
> Bubbling up the queue limits from the backing device is fine. However,
> I'm not sure why you are requiring a filesystem to be on a
> discard-capable device for REQ_OP_DISCARD to have an effect? Punching a
> hole in a file is semantically the same as discarding.
>

Hi Martin,
Thanks so much for taking a look at this patch, I was getting nervous
it was languishing again. I got confused by this comment though. My
intention was to not change behavior for loop devices backed by a
regular file system file. The changes in loop_config_discard() should
result in QUEUE_FLAG_DISCARD being set for backings of regular files
that support f_op->fallocate(), same as before my patch. The change in
lo_discard() to call blk_queue_discard() on the loopback queue itself
was just shorthand to avoid duplicating all those if statements from
loop_config_discard again. Am I missing a spot where I've implicitly
changed the behavior for file-backed loop devices?
-Evan
