Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDB6C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:33:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9CF214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfA2Jdf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 04:33:35 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40874 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727861AbfA2Jde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 04:33:34 -0500
Received: by mail-qt1-f193.google.com with SMTP id k12so21453054qtf.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 01:33:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SZK6rhjzKsNAVNoC2fMYxO/EZ9mUIoWTwpD+w8KTOFw=;
        b=OFcI5IX5dWbGazAZ84l+WqSyPHnvzpFkb3Vb6IxxCc2L8dN2mMT25NM/BuCinfv6zS
         Kc143djEElvo2xLXHzipqoby+5uOAbm2uPvuqwoMsseNgApwK0lX9jY79h/pRdw9wzMg
         wZSGH3gVSg9E/OjtAtZgIf1VBSymggJwVLw5bhMNeT5rknR1dnX1oY03f1SsyKex5NCf
         Ob57Lm+ZqFtSApHfu6izI22oQnnwNqCW82j1a6RbV+XQvPOBP5wvZU/D7zf38LKYywSV
         CzHUgvVlu068x/JCcJkFNQaWqFI5OMQZg7Q9jaZiMCx187siAqOI80PS69N0EWq1yVDG
         5+/w==
X-Gm-Message-State: AJcUukcmBRea7XSQDS2/Z4vaYrVV2J3p90tw53vqFBhzaEwr5QEHovjJ
        W5VQ9cVlku3u7LVOsmfcwbplb/t3MIyIYFLxI/2s6Q==
X-Google-Smtp-Source: ALg8bN5+iSHYvarMxh8ezJXLg7k4/E22NJRLTu+DpB41X8XPxTNOW0isyy/aw6VPu/DXsda6pYn6elI6nrOrRcsIbXY=
X-Received: by 2002:aed:2844:: with SMTP id r62mr25461431qtd.112.1548754413431;
 Tue, 29 Jan 2019 01:33:33 -0800 (PST)
MIME-Version: 1.0
References: <20190126170722.8035-1-vdronov@redhat.com> <CAO-hwJJGux_5bQJmXgLrcj+v=n3n8hvqXfqPEu60aghYNJSfzw@mail.gmail.com>
 <20190128111818.GA22143@redhat.com>
In-Reply-To: <20190128111818.GA22143@redhat.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 29 Jan 2019 10:33:22 +0100
Message-ID: <CAO-hwJK_WoimsUMR19GR_qEUCk0ZMaKGham3DSJ5SDqtc8oCzw@mail.gmail.com>
Subject: Re: [PATCH v2] HID: debug: fix the ring buffer implementation
To:     Oleg Nesterov <oleg@redhat.com>, Vladis Dronov <vdronov@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vlad,

On Mon, Jan 28, 2019 at 12:18 PM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 01/28, Benjamin Tissoires wrote:
> >
> > Oleg, can you provide some feedback before I push this?
>
> Looks good to me, feel free to add
>
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
>
> > > +               set_current_state(TASK_RUNNING);
>
> I still think that
>
>                     __set_current_state(TASK_RUNNING);
>
> will look a bit better, but this is really minor.

Would you mind sending a v3 with this change? I'll apply it ASAP.

Cheers,
Benjamin
