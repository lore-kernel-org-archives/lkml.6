Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56544C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:44:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2609521726
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548096291;
	bh=WkBPCGNsdmn4jUhxAXGoZLrFy2EOGBTLPTLOWLTc7Nw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zTWZjdKoMhvEoqbRiTS5ixdazx9MZNoU5fTMgN3+2d0Hr0Hzr5Xnnaf/b2zEo6nw4
	 8l7tIEGJHdmgxhFHRIfeapSIa9EFajxJ2OzpbGcPhI8vgsQocGHfTIt6OFfq2Smg5E
	 pKIWDZcBcMlWFyuPg0qPecYKv76a1aGjCGbAKGTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbfAUSot (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:44:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:47808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfAUSot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:44:49 -0500
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EEF6C21726;
        Mon, 21 Jan 2019 18:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548096288;
        bh=WkBPCGNsdmn4jUhxAXGoZLrFy2EOGBTLPTLOWLTc7Nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ukQfKm8OCoVpXwwuS7QE4vGrQMxA0Q+R+t7u+Cl0gJlmAGeeF3jsIPzsITocDS+gX
         jHRs2poRKOtbXC0TEcXhBGcSnpo1mu6pEaMthQAJ8ptG+hpR+q5cMEAy5dcF1/SwK+
         OLnjuhqlujJKMJN0IWQSqpdLQNoPyiQqgy3E1XDE=
Received: by mail-wr1-f46.google.com with SMTP id t27so24590850wra.6;
        Mon, 21 Jan 2019 10:44:47 -0800 (PST)
X-Gm-Message-State: AJcUukeK2nXyGCmshOvAaK8CMPAOE9bOaUtJ4Ms+zJEo2bLTbz42+D3Q
        rR6asa4LoqgXTCV8BDl2vgWBr1iM0a+ZPkDXlfU=
X-Google-Smtp-Source: ALg8bN5jhLVM7PhuAyOsnPvXiFgHqX1g/kuXwBtzPZxKMWJHYa11vtn8xHyCLRMHpDn/srbc4qfsdmcu7tYK/jdu2tc=
X-Received: by 2002:adf:b243:: with SMTP id y3mr30303350wra.184.1548096286455;
 Mon, 21 Jan 2019 10:44:46 -0800 (PST)
MIME-Version: 1.0
References: <1547744074-28308-1-git-send-email-lollivier@baylibre.com>
 <1547744074-28308-3-git-send-email-lollivier@baylibre.com>
 <20190121171019.GA2903@bogus> <86imyhapl9.fsf@baylibre.com>
In-Reply-To: <86imyhapl9.fsf@baylibre.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Mon, 21 Jan 2019 10:44:35 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Message-ID: <CAGp9LzpgZDEdKFH4ZLqxtO60unxXRJoXNsGugNT=oojHDMp+3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: gnss: add mediatek binding
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     Rob Herring <robh@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 9:29 AM Loys Ollivier <lollivier@baylibre.com> wrote:
>
>
> On Mon 21 Jan 2019 at 17:10, Rob Herring wrote:
>
> > On Thu, 17 Jan 2019 17:54:32 +0100, Loys Ollivier wrote:
> >> Add binding for Mediatek-based GNSS receivers.
> >>
> >> Signed-off-by: Loys Ollivier <lollivier@baylibre.com>
> >> ---
> >>
> >> v2:
> >> Renamed bindings from Globaltop/gtop to Mediatek/mtk.
> >> Moved current-speed as an optional propertie.
> >> Removed the status line in the example.
> >> Added "mediatek,mt3339" compatible.
> >>
> >>  .../devicetree/bindings/gnss/mediatek.txt          | 39
> >>  ++++++++++++++++++++++
> >>  1 file changed, 39 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/gnss/mediatek.txt
> >>
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
>
> Thanks Rob,
> If there are no objections by others, I'll stop sending these two patch
> (1/4 and 2/4) and reference any new patch serie for 3 and 4 as depending
> on those two.
>

Hi Loys,

Thanks for adding the first GPS device driver. It's really nice to see
more device drivers added to upstream support.

Do you mind send the series again with Cc linux-mediatek@lists.infradead.org ?

Sean

> --
> -L
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
