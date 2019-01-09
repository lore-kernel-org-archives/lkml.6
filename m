Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 958ABC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EFC921773
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062678;
	bh=EZwCmpG0G5qh4czKxKOq3f/cDJpe64iBGJDT3RxA150=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=jYdu7zHQUZD6bDuT24zGSZqid28FWWGh/mLRxeyoYyqYgHoIa8Dk5qwrTca+rDw6k
	 szG5VdqDIfLf+UZRQfXqRk8ttQ1BOk7qBRSP0VakyiO+2d//hNtaAsqkvonAbJrRx1
	 2+/vjkWxjw4kbDe17vXDYtSkPdwuZr9Jvco0xO6U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfAITh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:37:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728307AbfAITh5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:37:57 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E59121773;
        Wed,  9 Jan 2019 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062676;
        bh=EZwCmpG0G5qh4czKxKOq3f/cDJpe64iBGJDT3RxA150=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezl0EKj6RtkYTXnrtdKsJWEt9OjrEbcbgAJNwMZWsle6Q21JNx2UOv9F9IqwUhpPZ
         uBPtRS5NI320bCmhUjvW/nTR81kKJqSXZVyohidh2LVLYB2ZefGqYtJ+eS8Sdz4b/b
         j8pM5/R2mRXjheaZ7Yttbl0K1rTyRe0EefWiE+zs=
Received: by mail-qt1-f170.google.com with SMTP id n32so9619018qte.11;
        Wed, 09 Jan 2019 11:37:56 -0800 (PST)
X-Gm-Message-State: AJcUukfKyBDxZeXHBBwA+x00VLpCzX/CLkhUt1TR18NbfRDw+Jk9CRs4
        ymwb/Zmig6wnJgURUpZ4wO6v7xkC7QV5HZALZA==
X-Google-Smtp-Source: ALg8bN4PEHQhPD+X4149E1iN6jhAL+mbVzLIWDX/6qRNox4l3aS7OvIQCYfnHU96PN3dPzK7bc+gxU/v0+BK+aDcmJc=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr6932104qtj.76.1547062675758;
 Wed, 09 Jan 2019 11:37:55 -0800 (PST)
MIME-Version: 1.0
References: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
In-Reply-To: <97349a696b43af65d62b5d8e795ec3771b5e78bd.1547060514.git.hns@goldelico.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 9 Jan 2019 13:37:44 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com>
Message-ID: <CAL_JsqLhGGx_amtDSZh3OJ+Tq-Oziu450NOt4Z+aoQMt-JY46Q@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: omap3-gta04: Fix graph_port warning
To:     "H. Nikolaus Schaller" <hns@goldelico.com>
Cc:     Tony Lindgren <tony@atomide.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 9, 2019 at 1:02 PM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> From: Tony Lindgren <tony@atomide.com>
>
> We're currently getting a warning with make dtbs:
>
> arch/arm/boot/dts/omap3-gta04.dtsi:720.7-727.4: Warning (graph_port):
> /ocp@68000000/dss@48050000/encoder@48050c0 0/port: graph node unit
> address error, expected "0"
>
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Acked-by: Rob Herring <robh@kernel.org>
