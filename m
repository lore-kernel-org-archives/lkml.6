Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08057C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E2B218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PeB9KQe5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbfAYFrc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:47:32 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37010 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbfAYFrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:47:31 -0500
Received: by mail-ot1-f65.google.com with SMTP id s13so7530233otq.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 21:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r/ayRG9HGZ+VCVHSNU+R3SZYPNToHrif8kI5gbhyYmA=;
        b=PeB9KQe5RwjogXmolZGzrOSdaUwuiIa9SPMZ7uZR+p33VADVt/hmBKe7Gvk83yL2ps
         49mwfprMmrthLCKeOvKBpdrC9meRNiU+SMpabshT6Jk6QBShp7Qz4WCh3omz1umo/bOM
         UUw/EsYDPjvu71fArpbatP5mhqWQO8GH011SQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r/ayRG9HGZ+VCVHSNU+R3SZYPNToHrif8kI5gbhyYmA=;
        b=NBfF3nujOxpiQrr3KzAi2wQohIMgD9s3vI6U/hfUvhvvFPh4bVaFlC8GFUwkBwAzGA
         PS7IUGfsGG/H4thmEDOjLaG1B7cxPCgIX4hWhRztnSSWZkv+AG5hx6fZGWyIkUQuqhg2
         uru9ianL/cHZPsG0A4Zt+tvcpgDET4KdJbhm67BtM1/yAf3xnuJ3HdYP7g6JrxzbVZ/h
         xoJIhTpfi7Lgm7Dc4jGDt/xhX/Q+5azBGTNBA6aJxdbVTm58LOhTTcyXBaGIhn4O8auM
         Z0/e6XfzBPYVhNkL9ncelX24C1cP5e6lXkiAI78thv0GaCaGseut5nj67YRoXwo1CHlv
         +ZJw==
X-Gm-Message-State: AJcUukcVtlICowhCYSeduKGJyC5JLrwaR8KlvoDGhsdkiTR6j6kUnRJH
        Fl/5oK0aWyk0jUZ5BswuXfTUScPcV0KMAA==
X-Google-Smtp-Source: ALg8bN5eF/S2D4MnO5aAUBTw8VMHmQu7FXuTJoQFSsid/7MEvcZvCiDoiFQgXTWDWjGjfYdqftTSiQ==
X-Received: by 2002:a9d:6143:: with SMTP id c3mr6949656otk.227.1548395250496;
        Thu, 24 Jan 2019 21:47:30 -0800 (PST)
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com. [209.85.167.170])
        by smtp.gmail.com with ESMTPSA id a1sm763787oto.71.2019.01.24.21.47.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 21:47:29 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id x202so6847993oif.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 21:47:29 -0800 (PST)
X-Received: by 2002:aca:ad14:: with SMTP id w20mr441640oie.3.1548395249401;
 Thu, 24 Jan 2019 21:47:29 -0800 (PST)
MIME-Version: 1.0
References: <20190117162008.25217-1-stanimir.varbanov@linaro.org>
 <20190117162008.25217-8-stanimir.varbanov@linaro.org> <CAPBb6MVPhpZkCLFhAfPhE83TSpnCjH4Zy4-Mage5s=LkU9_RzA@mail.gmail.com>
 <47e2feac-3dbe-280d-0523-2226225a6733@linaro.org>
In-Reply-To: <47e2feac-3dbe-280d-0523-2226225a6733@linaro.org>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Fri, 25 Jan 2019 14:47:17 +0900
X-Gmail-Original-Message-ID: <CAPBb6MU+oV3gX=EmdVawnVBEtfs4roNxYVee0d2PLNKxb31F7A@mail.gmail.com>
Message-ID: <CAPBb6MU+oV3gX=EmdVawnVBEtfs4roNxYVee0d2PLNKxb31F7A@mail.gmail.com>
Subject: Re: [PATCH 07/10] venus: helpers: add three more helper functions
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Malathi Gottam <mgottam@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 5:54 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Alex,
>
> Thanks for the review!
>
> On 1/24/19 10:43 AM, Alexandre Courbot wrote:
> > On Fri, Jan 18, 2019 at 1:21 AM Stanimir Varbanov
> > <stanimir.varbanov@linaro.org> wrote:
> >>
> >> This adds three more helper functions:
> >>  * for internal buffers reallocation, applicable when we are doing
> >> dynamic resolution change
> >>  * for initial buffer processing of capture and output queue buffer
> >> types
> >>
> >> All of them will be needed for stateful Codec API support.
> >>
> >> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> >> ---
> >>  drivers/media/platform/qcom/venus/helpers.c | 82 +++++++++++++++++++++
> >>  drivers/media/platform/qcom/venus/helpers.h |  2 +
> >>  2 files changed, 84 insertions(+)
> >>
> >> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> >> index f33bbfea3576..637ce7b82d94 100644
> >> --- a/drivers/media/platform/qcom/venus/helpers.c
> >> +++ b/drivers/media/platform/qcom/venus/helpers.c
> >> @@ -322,6 +322,52 @@ int venus_helper_intbufs_free(struct venus_inst *inst)
> >>  }
> >>  EXPORT_SYMBOL_GPL(venus_helper_intbufs_free);
> >>
> >> +int venus_helper_intbufs_realloc(struct venus_inst *inst)
> >
> > Does this function actually reallocate buffers? It seems to just free
> > what we had previously.
>
> The function free all internal buffers except PERSIST. After that the
> buffers are allocated in intbufs_set_buffer function (I know that the
> function name is misleading).

Yeah, that's what I felt - do you think you can fix this for clarity?
