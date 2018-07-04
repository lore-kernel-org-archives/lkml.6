Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C04C6778C
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B5624268
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jojC8okq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B5624268
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752922AbeGDPSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:18:44 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36474 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752451AbeGDPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:18:41 -0400
Received: by mail-oi0-f66.google.com with SMTP id r16-v6so11377517oie.3;
        Wed, 04 Jul 2018 08:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4eaw2Fk11Klk0d/IbyRnduQmYoeZtVR9JAsHbK5VdFk=;
        b=jojC8okq8GVbOuQ5Iiwc/wXWA9s4qhKYp8BFthbyh0L0YQ+y3cIXMBF5FEZxaoZ5nL
         gGW5CSntx0xpH4IBiTGkjqlwOlJ9Gn3AHB+D6N8bu4ur4cO8p2zi30vRsRE9zvB21onH
         1lCe/p2gvs1OFz+npAi5Pk0S0rSzu6r3nJR8lkqS58sAN0iuHX/cOTzm0EKYeUhOELdk
         DQbSkWCqVOFgfhOtBP6YLefgMSNypw8E4pvd71BqB5a/+2ScD5ftRVtemivTbzwFk/7M
         hk1rprkf1KZaQq6bS1Py3aNfbS0Gjd3rdnGQH9toBw8jdcisDSkSO9pHLCkBTJUlardP
         rR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4eaw2Fk11Klk0d/IbyRnduQmYoeZtVR9JAsHbK5VdFk=;
        b=frxPQUz8ScoSzbBVpmTlHyFJMxSkjmIErPwNVyX/+8bX7cmzhFWvSE5mNphSZWRkAj
         DqIrIuciXfHAY7h51zGOC6KGN66iio9Dsyzk1Cp3yK+hT/YR0fvKU8SsJJ1FmBnmspVq
         5CoSQQt/atWdO3Fa3RQv2VO1tZ4x2m0J21tEjOd3/VIS4O0pUKfw0LeBotabSskvNnr/
         XVUVBJ1pf+M/v15WFFE4KfkGnDFmu1ahWNfsYrLGRfIVXSFSxLLusGr7mOeS7oo6bH0O
         27u9rraSDf5bzcmHYOLIE4GyaPejb/y+G9KLhVktClBJ496K7W1v8zQbGBJ9bO54cow3
         Ifvg==
X-Gm-Message-State: APt69E3v6HEDeep52LfbS2+ygeqiNKJSJkfzXFwBMp3Pj6TGBRiNr+FK
        ls95blbOhEW7Nx2clGGRBbk=
X-Google-Smtp-Source: AAOMgpfg5M1Vz4QY55ZpFu7o38qHCOToKmLx3WvEVtg0upQadgr9To3J/SFaoizl+HgovKKcU4Hi/Q==
X-Received: by 2002:aca:56d7:: with SMTP id k206-v6mr2495832oib.106.1530717520272;
        Wed, 04 Jul 2018 08:18:40 -0700 (PDT)
Received: from localhost ([12.130.117.108])
        by smtp.gmail.com with ESMTPSA id s10-v6sm1819872otb.55.2018.07.04.08.18.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 04 Jul 2018 08:18:39 -0700 (PDT)
Date:   Wed, 4 Jul 2018 15:18:33 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Hutterer <peter.hutterer@who-t.net>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, Mario.Limonciello@dell.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 10/12] HID: multitouch: report MT_TOOL_PALM for
 non-confident touches
Message-ID: <20180704151833.m5d3umukr75nq2dd@penguin>
References: <20180621120908.16706-1-benjamin.tissoires@redhat.com>
 <20180621120908.16706-11-benjamin.tissoires@redhat.com>
 <20180627010858.GB25847@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627010858.GB25847@jelly>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27, 2018 at 11:08:58AM +1000, Peter Hutterer wrote:
> On Thu, Jun 21, 2018 at 02:09:06PM +0200, Benjamin Tissoires wrote:
> > From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > According to Microsoft specification [1] for Precision Touchpads (and
> > Touchscreens) the devices use "confidence" reports to signal accidental
> > touches, or contacts that are "too large to be a finger". Instead of
> > simply marking contact inactive in this case (which causes issues if
> > contact was originally proper and we lost confidence in it later, as
> > this results in accidental clicks, drags, etc), let's report such
> > contacts as MT_TOOL_PALM and let userspace decide what to do.
> > Additionally, let's report contact size for such touches as maximum
> > allowed for major/minor, which should help userspace that is not yet
> > aware of MT_TOOL_PALM to still perform palm rejection.
> 
> tbh. I have a queasy feeling about this last bit. MT_TOOL_PALM has shown to
> not be reliable on some devices (X1 Carbon 6th) and we mask it out on those.
> Changing the major/minor means it's impossible to rely on the touch size for
> palm detection once a device supports MT_TOOL_PALM.

OK, then let's drop this bit.

Thanks.

-- 
Dmitry
