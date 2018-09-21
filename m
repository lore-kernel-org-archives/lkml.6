Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E10C46470
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74E5B21569
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="M9jJcNRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74E5B21569
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390267AbeIUV0b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:26:31 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:55422 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUV0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:26:30 -0400
Received: by mail-it1-f196.google.com with SMTP id d10-v6so2415564itj.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeMMhyav29csSKU6ahMZ2lZL3GAaLT0hOmQ5A3MvC/o=;
        b=M9jJcNRwJlGCzv4UV8+eZaiH/wp+WJS0PAom8iFvDuFYofukV/l7abQMISliYv465r
         k+RbCRRpFGzwm01MDRG5GpKkEpwacCCl3DC61nJon+jljWIwJzmNMDHA6snSuUIALO+6
         vZVHqO1RHumQOLoDLCVp0Y+x/4boS+64hMDh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeMMhyav29csSKU6ahMZ2lZL3GAaLT0hOmQ5A3MvC/o=;
        b=DQinap4ZnFBVXMTq3B3MbJgzd/2gcetBI20Xh4BnLqxtKQBZ2Ot2C50xmSmhpdSV/h
         vJTB3jwH6LFqegCJTknFBiBmMBZ6m1jR+mAZ/8hW+Sc+HkWUF356nVXJN6kXEdbi1Ej1
         gg3aeLEMGy5KomRF7HbEGN2k+9pXAudUfM6o0QT9k+ipGoWU6z7AWvzbXkBwCl6BKaJe
         MHhLJOT147Il9EJ7pKL75vHFDmQ4hXpuUOYXXM1DqBr9jGtZJEDfgPmWx8Df8v/1GOVU
         OT2AttQdh4yZCJLXprH9KIx0lcrQTwFiFowQScmZpev2j4wI7/lOQ8RfPcTiCmh5PNmL
         dPGw==
X-Gm-Message-State: APzg51DxbPu+So80pOva+Hq/Vjk+HGURaeOXi8QThPOL1fVV20QHI8LE
        zRVlpWFcXJ6I/MYeHw+6sGDl+weSJQ7bGMAKliGiDw==
X-Google-Smtp-Source: ANB0VdaYSAWFjJ/f6C/XwUBFiMCTMXHGmBdV2WYIzdJQvsDfDRHlzYjq0qx29+FnSKAmndiKKMq+M5lx9twV9En6oV4=
X-Received: by 2002:a24:9d84:: with SMTP id f126-v6mr6456333itd.130.1537544225591;
 Fri, 21 Sep 2018 08:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20180917181603.125492-1-dmitry.torokhov@gmail.com>
 <20180917181603.125492-3-dmitry.torokhov@gmail.com> <20180920135348.GF11965@kuha.fi.intel.com>
In-Reply-To: <20180920135348.GF11965@kuha.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 21 Sep 2018 08:36:53 -0700
Message-ID: <CACRpkdZtM4G=4r3m6vLTms9MJFkdiOdPFucebO-Z0Kh-3ws3+g@mail.gmail.com>
Subject: Re: [RFC/PATCH 2/5] device property: introduce notion of subnodes for
 legacy boards
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Input <linux-input@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 20, 2018 at 6:53 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:

> The child nodes will change the purpose of the build-in property
> support. Originally the goal was just to support adding of build-in
> device properties to real firmware nodes, but things have changed
> quite a bit from that. These child nodes are purely tied to the
> build-in device property support, so we should be talking about adding
> pset type child nodes to pset type parent nodes in the API:
> fwnode_pset_add_child_node(), or something like that.
>
> I'm sorry to be a bit of pain in the butt with this. The build-in
> property support is a hack, it always was. A useful hack, but hack
> nevertheless. That means we need to be extra careful when expanding
> it, like here.

I dunno how we got to here, what I tried to solve and Dmitry tries
to make more general is converting old boardfiles to use fwnode, because
I initially tried to just support gpio descriptors from board files.

If boardfiles is what you mean with "build-in property support" I don't
know, it predates both device tree and ACPI and any other hardware
descriptions on the ARM architecture, from the perspective of these
systems things are fine and the hardware description languages
are the novelty...

But I guess you know because you worked with OMAP :)

So there is something I don't understand here.

Yours,
Linus Walleij
