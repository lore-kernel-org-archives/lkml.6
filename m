Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFFA8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B05B217D4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 23:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dYFGN3OF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbfAVXfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 18:35:09 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39573 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbfAVXfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 18:35:09 -0500
Received: by mail-ed1-f68.google.com with SMTP id b14so238750edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:35:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+DolEyr7gJGm9u7cQZrQeuUuAycgGfyCyNIf36AY+m0=;
        b=dYFGN3OFL+KQHonpmte6EDlTICB+8pxnrbTdszH6OB5eeCwBEFiyORrDgtk7In6mx7
         yGqEsnOHnqxXnHCN5qUYOdsEn3NOxgVM8NU+PKFC9dpXmBJ4haJMWHRV+u9lJcFFHCa0
         99DbPaLS5jm0P3S9ArH5e07hWmUiieQIN3ryw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+DolEyr7gJGm9u7cQZrQeuUuAycgGfyCyNIf36AY+m0=;
        b=MiAw90joA4dSM5znM3RmQ5JJAoSFAWijuQq1ok9dQKXXzGtT0J6l/8rX87uVuSVZ3w
         2LjOskJ2nhCAdc8fEUJWlXznchqNg2MlmV5+QnkiUYhjYLjDGtXwqwVS9pQRyXqMfpgp
         uSwzPEjPnrLtxqgM3BoSX6Y6HSf4n5TtkABlOSsTxqAgywY7XOCSisqcSPJPYyHtGLgz
         Fw7/qlZy1yyZX97Ur5+kjMhmT3Uf11RKekvLl0hq1NZrtm0sFbouUlZCDJ0c9pJXdFFO
         unNrPa4hQLLkI5YZmFJPkfRgdLU9+dig0rLnXCXSsv/8aJ0tGoIEDE72O45cjVR3bgbS
         ro2g==
X-Gm-Message-State: AJcUukdxcjJvUfkENmdg08lsa7HWgrl+CTyzUTGWdQ59P3L4aVkEYJPz
        dasEfKE6AlZ9xB4oPntGMGP4u12PPGI=
X-Google-Smtp-Source: ALg8bN4qNU7/EfdIU/GOE+0xBQZW+h6toMXr+ibcfh84SbmmJvcq08rMHJEdrxOYKL7wWXMUxUgMSw==
X-Received: by 2002:a17:906:4c94:: with SMTP id q20-v6mr400719eju.26.1548200107294;
        Tue, 22 Jan 2019 15:35:07 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id v14sm9444505edq.74.2019.01.22.15.35.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 15:35:04 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id b14so238646edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 15:35:03 -0800 (PST)
X-Received: by 2002:a50:951a:: with SMTP id u26mr449585eda.4.1548200103236;
 Tue, 22 Jan 2019 15:35:03 -0800 (PST)
MIME-Version: 1.0
References: <20190122055112.30943-1-bjorn.andersson@linaro.org>
 <20190122055112.30943-3-bjorn.andersson@linaro.org> <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
In-Reply-To: <CAD=FV=X0x4hQ=8yQ6wDWE8ximf9A8hpgpRWTdPrFXDD4FVO8VQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Tue, 22 Jan 2019 15:34:51 -0800
X-Gmail-Original-Message-ID: <CA+ASDXN2+bBiOT6svRE+1VtY7BQTFjjD_s4pzO8J7-dDx9QLDQ@mail.gmail.com>
Message-ID: <CA+ASDXN2+bBiOT6svRE+1VtY7BQTFjjD_s4pzO8J7-dDx9QLDQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] arm64: dts: qcom: sdm845: Define rmtfs memory
To:     Doug Anderson <dianders@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Ben Chan <benchan@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 3:26 PM Doug Anderson <dianders@chromium.org> wrote:
> 2. In https://crrev.com/c/1119572, the argument was made that the size
> of this carveout is board-specific.  That makes it hard to put it in
> sdm845.dts.

And we've increased the size of the memory carve-out since then,
because the memory requirements depend on the SW features you're using
on the modem side.

So that's definitely a reason for giving it a label we can modify it
with, at a minimum (as Doug suggested). I'm somewhat ambivalent as to
whether this should or shouldn't go in the base sdm845.dtsi -- it's
still a feature where most of the definitions (e.g., compatible;
client ID) should be applicable to all boards.

Brian
