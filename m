Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3FF5C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C57C42084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 18:30:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUa2U5pb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbfASSaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 13:30:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:36991 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728866AbfASSaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 13:30:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so12791839lfj.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 10:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TA9Pw7WO5Vj+eYzev6r74DOWU1l0cFTxt+x5GYK9MEA=;
        b=lUa2U5pbaQfE6zXqR4zUYJ3YxA9wKilvEDioKnJgqs/hSUgJLWje6wJdTBUUY1w14l
         AGccbQ9g2t+UnwOCdMb2lmCjcZEEVDsGldriDP9XlPthx6NRVCcse1aBQjCpxNgdQK9T
         EoNU6d9O15WcY3NMj+4WlaYsOkJs1zb36uX7mvy5OlAL/FUhVvKvj2dpy8/PKBfmBF2s
         z6RbAfHW8v0uHIZ/XPByYWQsmscszT1UStEKxpBoso8S2vwfX8Soc5w6gPE14ESzXS5Z
         kH/jBRYghjcOqMT/YXAx35g9oWJv6A/kV3rioAttpZhF26Lsc08wn1rTRcMHOBB9UFYh
         wz+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TA9Pw7WO5Vj+eYzev6r74DOWU1l0cFTxt+x5GYK9MEA=;
        b=Y1gUoCYWjGa0ZPEzykEvtQruKfSMg9PQri9J9D+vfbZQ3PGTRqSN+eRPmD2Si02jYP
         l9vxzKMOS2c00UBDeTORGBQXz+zSJYwGc8S9yBV3j0HAH7wsCF6qFzKY19QCsSQuYZZD
         XEgaI/rp5N6IH4uflXOviNndGqOcXgu2h2KT/oVDOnRypO/BsXKQ0K2mygW67cdyv/DR
         q70ucUTqpjJUdctdj/NcRgycL73HKGIk4hfB0eetMdeG4QHda5B0iWykDJY3rJp6Ksjh
         PqPBM+ogyGn5bBW2m7CERRwXUpePh4mKBbhT8EV0h7bksqENtd76ZqvdGHVqSI03/k2F
         eCPQ==
X-Gm-Message-State: AJcUukcXPnDbUebNj5CltqeLxy+4XtnQeSWR1tFTVRGuYRWp8i9VrNf/
        7yLdXL3d27xo2NH5P6bfiTZOK9ckKGRLkzre3NPA7PJp
X-Google-Smtp-Source: ALg8bN7LyMuEfHBzOh4SDpnRA+3rYu99qp3JfQUxB12u6M0b/MhFeZnaxOUyVmUngFdeGych+np6P5ywnx48NlzlyDM=
X-Received: by 2002:a19:f813:: with SMTP id a19mr14709545lff.67.1547922617489;
 Sat, 19 Jan 2019 10:30:17 -0800 (PST)
MIME-Version: 1.0
References: <20190118225658.GA28312@ziepe.ca>
In-Reply-To: <20190118225658.GA28312@ziepe.ca>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Jan 2019 19:30:06 +0100
Message-ID: <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Fri, Jan 18, 2019 at 11:57 PM Jason Gunthorpe <jgg@mellanox.com> wrote:
>
> Re-run the shell fragment that generated the original list. In particular
> this adds the missing xarray related functions.
>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Thank for the patch! Picking it up.

Cheers,
Miguel
