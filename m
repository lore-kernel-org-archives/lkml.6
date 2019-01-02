Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7D2C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872CC218EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 17:16:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KMsKNcLb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730658AbfABRQ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 12:16:29 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34654 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730645AbfABRQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 12:16:29 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so27629519lje.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4JFO6Laz7oXWpX9ib4TeCRQfW+0VPYAqmkKGreX0qg=;
        b=KMsKNcLbkGLYadny6DPVK8UZ+QU+Bq72FnyvdoK2YSYMt8PLh0xENW6jpqOufUKPJ8
         6X90bNFfZNUIVuMuZLeG14sz55NJwx1XZqtK62NWdpM6APlMrdzeMe6lQTj84vFFDv8y
         KKbv08AjotX69tthZzYEY3cgDOkBtlTYt0E2M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b4JFO6Laz7oXWpX9ib4TeCRQfW+0VPYAqmkKGreX0qg=;
        b=sTVI2MCO5Ymo2mOSLLohguSqBMom75lusCbab+wHRpw09u2/T9tephiTknHdBQg8Nb
         cPjlfiBwc6CwsBAHHnu6XKZQaWh2KOsQc4U8Xh76DOSh22v4u+k3Qk2HcgOQji4cJHh3
         BcUBPlFOfAHC74U0r1SprNzcEesXiW0JtpoRQYInzAm12oK3j+vk9WXw62AGReHaVQAM
         Cs22Cz447gMRMKvSAs03/4WySIlDDrrfhTQEgP9pB2ODwmBpRzomcMSwkJaH8lQfONvR
         qunY1pppWUMB2uI36/Gy+rAh7kumzZsOO/10avDgVjlHYuSZ2vv60ijXEZd/tlLd9CKI
         17BA==
X-Gm-Message-State: AJcUukc9A1nK3jFvyuovukzOh1ZDGlRTw+XE7h5oc4BTlQK/hDkfgVcl
        pdtVuAmb9w82Y36qxI1kmq/w30kLPWo=
X-Google-Smtp-Source: ALg8bN6MAYm+XLKESPxuTellJTxN3lLqOzo5AUtStWhwj8kiesmqfqX1gH+nPPXKAfjNyA/3oP0E1Q==
X-Received: by 2002:a2e:8256:: with SMTP id j22-v6mr25337184ljh.40.1546449386745;
        Wed, 02 Jan 2019 09:16:26 -0800 (PST)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id u26-v6sm11215502lji.22.2019.01.02.09.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 09:16:26 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id y14so2470494lfg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jan 2019 09:16:25 -0800 (PST)
X-Received: by 2002:a19:1f54:: with SMTP id f81mr21032423lff.153.1546449384915;
 Wed, 02 Jan 2019 09:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20181221201001.160613-1-evgreen@chromium.org> <20181221201001.160613-2-evgreen@chromium.org>
 <20181221220533.GB9704@minitux>
In-Reply-To: <20181221220533.GB9704@minitux>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 2 Jan 2019 09:15:47 -0800
X-Gmail-Original-Message-ID: <CAE=gft4CmCU0xfbrBJnP+bL7mXVKgyJjsJsiDuC=tuvG5Ac=iw@mail.gmail.com>
Message-ID: <CAE=gft4CmCU0xfbrBJnP+bL7mXVKgyJjsJsiDuC=tuvG5Ac=iw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: rmtfs-mem: Add class to enable uevents
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Ben Chan <benchan@chromium.org>, linux-arm-msm@vger.kernel.org,
        David Brown <david.brown@linaro.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:05 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Fri 21 Dec 12:10 PST 2018, Evan Green wrote:
>
> > Currently the qcom_rmtfs_memN devices are entirely invisible to the udev world.
> > Add a class to the rmtfs device so that uevents fire when the device is added.
> >
> > Signed-off-by: Evan Green <evgreen@chromium.org>
>
> I agree with Brian on the whitespace chances, apart from that you have
> my
>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>

Thanks Bjorn and Brian. I'll remove the whitespace changes and add
your reviewed by on the next spin.
-Evan
