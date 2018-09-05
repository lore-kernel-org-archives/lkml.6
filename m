Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239AAC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C00992073D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:30:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GlXXF0yM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00992073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIEK7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:59:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36894 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726426AbeIEK7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:59:09 -0400
Received: by mail-it0-f67.google.com with SMTP id h20-v6so8098622itf.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 23:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gUIXVqQ+e4p6svaItZ15QZA4cIxJQnxxDRm2cI5KcUQ=;
        b=GlXXF0yMPl7RuiQipGfa6vZBgyM/0HkdD8WwNvD93j2j5x0eB8MxGbDZlNALiQKap4
         IflqkcT+CxnB84Dw04eYSEhAYl3pNYynpuwyBiNHAEzYdfXG8QKii8G46K/p6q3AgefN
         S0FlUzP2dHztyTRLLFEb1wLnObUPSxseRakpM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gUIXVqQ+e4p6svaItZ15QZA4cIxJQnxxDRm2cI5KcUQ=;
        b=Ry5leNtOM0qvKQpWoaCxgDkrvSVXoN5UiPIGz8Dp2cwAlFICZIXSfem2gnbIQThdK1
         phOkMHKv5lgZbt2rzu3aG7zos9v0AXHvjczQE76af6/re5flGHP2YMQ27DAKIpUtzHmY
         aCK+iJdIAbr2aMIIlPEjjatVYaf9BwT0n4dIb9tpCDFFtsB2GvnW2qaGvIiOASv1wIBt
         Nnzs1SIsBvM/iNn1YYUrUXpkyYHPAsH4oc3tao0cc+RhLBVcK0PqgCpaajcvfXtSah9t
         06YH2M9wCpdVFO+TS1zfCJ/Maw5fYLI8LT6jjZZpRo9K05rVOKFlcSCJmQ1wnSeA1xv5
         OdnA==
X-Gm-Message-State: APzg51C0n2PvMPDJMu+57ljTmOO2BRRPDb//kTlR+jIWqUdb7Cx/iNNw
        hGohK0r7Dsu+KkZjUAl7DvHoOdf+TYewtdWp0YH6oQ==
X-Google-Smtp-Source: ANB0VdY0LooYnm6U2Va66Updxx34h2Cnr4Uj+3J6StE75TL322Wexciud81Nw+BHosv9aSY2etuNeg88FBn+/PWdCWM=
X-Received: by 2002:a24:b919:: with SMTP id w25-v6mr2698734ite.101.1536129030355;
 Tue, 04 Sep 2018 23:30:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:4f9a:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 23:30:29 -0700 (PDT)
In-Reply-To: <20180904125402.GR28861@localhost>
References: <20180827082153.22537-1-johan@kernel.org> <20180827082153.22537-5-johan@kernel.org>
 <CAPDyKFot-Nx=R83vxS=WQp2kSFmMiQ7wfOK4m6hbPt0MB3Z25A@mail.gmail.com> <20180904125402.GR28861@localhost>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 Sep 2018 08:30:29 +0200
Message-ID: <CAPDyKFo1vwg43Nzaco4-vfmDp9RShdh4wcyM5UrdFzd89qaNcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] mmc: meson-mx-sdio: fix OF child-node lookup
To:     Johan Hovold <johan@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Rowand <frowand.list@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Carlo Caione <carlo@endlessm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 September 2018 at 14:54, Johan Hovold <johan@kernel.org> wrote:
> On Mon, Aug 27, 2018 at 04:44:44PM +0200, Ulf Hansson wrote:
>> On 27 August 2018 at 10:21, Johan Hovold <johan@kernel.org> wrote:
>> > Use the new of_get_compatible_child() helper to lookup the slot child
>> > node instead of using of_find_compatible_node(), which searches the
>> > entire tree from a given start node and thus can return an unrelated
>> > (i.e. non-child) node.
>> >
>> > This also addresses a potential use-after-free (e.g. after probe
>> > deferral) as the tree-wide helper drops a reference to its first
>> > argument (i.e. the node of the device being probed).
>> >
>> > While at it, also fix up the related slot-node reference leak.
>> >
>> > Fixes: ed80a13bb4c4 ("mmc: meson-mx-sdio: Add a driver for the Amlogic Meson8 and Meson8b SoCs")
>> > Cc: stable <stable@vger.kernel.org>     # 4.15
>> > Cc: Carlo Caione <carlo@endlessm.com>
>> > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
>> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
>> > Signed-off-by: Johan Hovold <johan@kernel.org>
>>
>> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Thanks for the ack. Rob's gotten the helper into -rc2, so feel free to
> pick this one up directly to whichever mmc branch you prefer. I've been
> able to trigger crashes after probe deferrals due to the use-after-free,
> but this seems unlikely to be exploitable.

Applied for fixes, thanks!

Kind regards
Uffe
