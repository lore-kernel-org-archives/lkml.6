Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B239AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:00:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 584082151D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 00:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQJT4una"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584082151D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJJHTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 03:19:39 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41994 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbeJJHTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 03:19:39 -0400
Received: by mail-oi1-f193.google.com with SMTP id w81-v6so2685687oiw.9
        for <linux-kernel@vger.kernel.org>; Tue, 09 Oct 2018 17:00:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t8QAeh9Tz7X3Mwvi8glm9eUiZ24FrTdrg5t4W7wx+fw=;
        b=QQJT4unaeZYRy2N6c8aiXWtrryXmnLl97l1a2f4HdE4icht+7i95pzKskfEwwUAYJu
         AaJvykhR66lNfYlFMtqi1um8V1ihZb3hbvPbH4glr2fV98gSox6YyXMfomJutJ5z7lNL
         JKfC3U2XmAO3mT/fPP5dGa1uTGByeqEWDLYEAMuQgBN5gWRe1J0LRIn3ELVbxXcB4htv
         j33DObeiMpk1ZfSldmvMH5fHSjWq625Omhsidd8CC+wE4TXcXxk9oVLMeDhdfLAm9ig3
         8v9zv7AITsj784eyqa6f9baaNErrW6RGfBeIYRg2GrGSrmwR7y6TsMIzs7L/eBxJkmNm
         Hxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t8QAeh9Tz7X3Mwvi8glm9eUiZ24FrTdrg5t4W7wx+fw=;
        b=JQ/xvlWQLbwlzJPjAKmSdsV4VjRmDlGDE3Q3dmjxCiMierYPNzpIb8MZ1JleOkQeCK
         9RE2rw38wxpx2+Mv71DS/z2p25Ph/Jxg0T+VolkAluF5omXeT2N95p5GLJrZijlqRXVV
         Z7uQWCHWGymJ40rVIbulq3Mmrk3zACBYPsjzGKjKAGr62MqiTxqt8Lch+DfLhRBFq5L2
         rG2yreWiHOiEGTTUka5/BNh5cwJjgVD2aoMhw4VuuVrxZMmpJeH5GR28ibsQ60L4Nwt9
         PKDiOQzGg5e4FbT/2CzQ7Ja6CxB1w/AX9/L0Wk9zpMrrkn8yA0GW3Gl5R/JXGPufJyyN
         jFrQ==
X-Gm-Message-State: ABuFfojxllMn1gGjgi85QFBIwDuhVqdOP6xaM9cbPFNwRF73ZTlonvJU
        TXpYVGnbvo3TAIJLOXIir3Lq90oUl4oeDdJy3Eeh7Q==
X-Google-Smtp-Source: ACcGV60bhqcIhUrmrmCYiVSWn8TMRR/7G0eXm1/RDapvbFAHKIKor6c0KCEz/LeUI8vsIJ+E6momboG/0iZoqL4cMB0=
X-Received: by 2002:aca:ebcd:: with SMTP id j196-v6mr330640oih.206.1539129614533;
 Tue, 09 Oct 2018 17:00:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181005214507.26315-1-jae.hyun.yoo@linux.intel.com> <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
In-Reply-To: <20181005214507.26315-4-jae.hyun.yoo@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 9 Oct 2018 17:00:03 -0700
Message-ID: <CAFd5g44WcAE5oJCmRQKsRmbrfYPx55kdaT6xW1hzCoYAR5YQNg@mail.gmail.com>
Subject: Re: [PATCH i2c-next v7 3/5] dt-bindings: i2c: aspeed: Add
 'bus-timeout-ms' property as an optional property
To:     Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed@lists.ozlabs.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jarkko.nikula@linux.intel.com, james.feist@linux.intel.com,
        vernon.mauery@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 2:45 PM Jae Hyun Yoo
<jae.hyun.yoo@linux.intel.com> wrote:
>
> This commit adds 'bus-timeout-ms' property as an optional property
> which can be used for setting the bus timeout value of an adapter.
> With this patch, the bus timeout value can be set through this
> property at the probing time of this module. Still the bus timeout
> value can be set by an I2C_TIMEOUT ioctl on cdev at runtime too.
>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

Thanks for putting all the work in to do it this way!
