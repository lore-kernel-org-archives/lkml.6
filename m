Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DAAC282C7
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2292F21903
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 03:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548558039;
	bh=VQZ9p5D0SjFbMo7+hJBCYP4JqQfOx1wEolKfSx+wZwI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=JkCN0vxh3KB882TaWn9ORDGdsLMSnnik1mg2SKS0PUpF9PsEvu+OK1lxzGxcAZoo0
	 nwh8yMlZqBx7rPiyqEmUtak+ml/tZhGB4sA/MljuT8WHWwXlZ9cXaIjKo+23PtW+vX
	 z1ZAxrx66DIAQpCCoRIZfbIaOmKcNDhXZi6x39r4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfA0DA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 26 Jan 2019 22:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:38716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbfA0DA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Jan 2019 22:00:29 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6761C21920;
        Sun, 27 Jan 2019 03:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548558028;
        bh=VQZ9p5D0SjFbMo7+hJBCYP4JqQfOx1wEolKfSx+wZwI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OnHAFGAZgzXIyZqT+g4jjiJKbgFOMZ5tVZGorAneODvYXAbnF++XmCbdha+HsDAfL
         QG4hvFL6gZ3ryA+6bxYykz9SJ57Z8mdvtnVyx+tnYCQudufzFJA+iNSoV+2n/wfA2e
         eEQNNkcSNRCWK7Y0O0iD2qU+STnoObBx6AYj2qSQ=
Received: by mail-qk1-f170.google.com with SMTP id y16so7637835qki.7;
        Sat, 26 Jan 2019 19:00:28 -0800 (PST)
X-Gm-Message-State: AJcUukdhX4YL+XCo98U7r3Jy0n7fVuaNloxqSk01bRPY7E13ktMUb1Sc
        a0aaA+mefpoDqwSHIn7T77M2AZV/JKHAeN8VWg==
X-Google-Smtp-Source: ALg8bN4jf4q7gzMidj4mMrXVcLr7bxoeZvYw6qytdthD58afqiisLh4HxHLUZEeywpFTlVr/F9bqu62NPHmWrvLDXuA=
X-Received: by 2002:a37:a483:: with SMTP id n125mr14681058qke.184.1548558027423;
 Sat, 26 Jan 2019 19:00:27 -0800 (PST)
MIME-Version: 1.0
References: <20181211202406.27721-1-robh@kernel.org> <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
In-Reply-To: <CAMuHMdUZHi87Dv=m4USocfQ60s6_uHmny5DvCVm+hZ98+ROvdA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Sat, 26 Jan 2019 21:00:16 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Message-ID: <CAL_JsqJKhOmp+UKS=B-_8txHhRbqheG3GuogcZpXJ+aYcO5Oqg@mail.gmail.com>
Subject: Re: [PATCH v4] kbuild: Add support for DT binding schema checks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Sean Hudson <darknighte@darknighte.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Grant Likely <grant.likely@arm.com>,
        Kumar Gala <kumar.gala@linaro.org>, arm-soc <arm@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Marek <michal.lkml@markovi.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 9:33 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Tue, Dec 11, 2018 at 9:24 PM Rob Herring <robh@kernel.org> wrote:
> > This adds the build infrastructure for checking DT binding schema
> > documents and validating dts files using the binding schema.
> >
> > Check DT binding schema documents:
> > make dt_binding_check
> >
> > Build dts files and check using DT binding schema:
> > make dtbs_check
> >
> > Optionally, DT_SCHEMA_FILES can be passed in with a schema file(s) to
> > use for validation. This makes it easier to find and fix errors
> > generated by a specific schema.
> >
> > Currently, the validation targets are separate from a normal build to
> > avoid a hard dependency on the external DT schema project and because
> > there are lots of warnings generated.
>
> Thanks, I'm giving this a try, and get errors like:
>
>       DTC     arch/arm/boot/dts/emev2-kzm9d.dt.yaml
>     FATAL ERROR: No markers present in property 'cpu0' value
>
> and
>
>       DTC     arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dt.yaml
>     FATAL ERROR: No markers present in property 'audio_clk_a' value
>
> Do you have a clue?

That's really strange because those aren't even properties. Are other
dts files okay? This is the in tree dtc?

The only time you should be missing markers is if you did a dts -> dts
-> dt.yaml.

Rob
