Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E05F8C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BBFA2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 07:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s09zyqwa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BBFA2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934400AbeFMH66 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 03:58:58 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:44093 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754467AbeFMH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 03:58:56 -0400
Received: by mail-oi0-f66.google.com with SMTP id c128-v6so1465624oig.11;
        Wed, 13 Jun 2018 00:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=fIdUJBBZVqdD86TJJVMpEHa/XwGDq6K5QSv+EGJTghk=;
        b=s09zyqwacTaYcWejx6N2pbYDWdLLPeOz6ciTsiLtjNJlqkpe97MOr+iE9TIyBPZVGR
         GT3TTnhindjZiwy0NcqOjDreqAJPAI5EQB2wnx2yuO9xjfOmd/ws/PzSDyRQIhg4BxRq
         6+wLKEEJQoK1uhJZi0PYc3H15nHfixM2EhWg2KD8RNIT+/BlA6KbbP75UqcqEGAy1Puq
         7TCl6BFUh34gxhB4r1nopfagOKKu7JURaIGrqzqyMOANTc1NFJvukhM/g/GON2uVgfX7
         nLd7PUQC87HJsaYIs5C7ReeFU8zndSoY25kGohxWqqRZQYf0G0+EBlsibXvFmZo/Hgyu
         TSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=fIdUJBBZVqdD86TJJVMpEHa/XwGDq6K5QSv+EGJTghk=;
        b=HwqgBVpwh8OGgLs8dJTO1rL6KQk8VkghxRBxpxG9K/YXGGMhnaZiYJREsVFfgJ8f4X
         CQQm/Y50Abrf3rnrDBaZjsPYivdb21pyetX+1OjsO+ikp+oezfjC++gjl/OgTJUJGvSP
         vX/0KXx1FnDxUMQ0WdyzK2G3wSpuI4zufLq3Iib9OHCPJD7rf7mtYcqIcOc7UbnoLwgp
         gz2JUoz6aeGwUHUcCVfO5aHcwV7mKXkUD+fGBiGztptSvdJGtJAQ7aG3gaNqms3kHHCd
         rPtS9pj3v4TfGVmtjq5rLr92RZG+UApByDUEica5k1yT9hIVvp85BBMSuHc9apzdolSm
         lytA==
X-Gm-Message-State: APt69E1KcPyXc4oEEZqM28q+HqCfM6Bk1Fq+eksoUvYWXa7dS2b7QxrD
        N75VgMxzQTLfhF9IFDGhdI6RIHL/zbCU0sUAIjs=
X-Google-Smtp-Source: ADUXVKL0e6Ns1uWmm5yOq40qv+HGEzm2KlwQoDS3VUc2p8G6mMfI74fKpJjnP4bAudcqrA3KxqvnNzuq3NOc7AhnCGY=
X-Received: by 2002:aca:e143:: with SMTP id y64-v6mr3638957oig.282.1528876736251;
 Wed, 13 Jun 2018 00:58:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Wed, 13 Jun 2018 00:58:55
 -0700 (PDT)
In-Reply-To: <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
References: <CGME20180612110807epcas5p10e076681eac6f50b01840c0052748d12@epcas5p1.samsung.com>
 <10125310.W3e2TP0641@aspire.rjw.lan> <20180612124424eucas1p101e61369a42132234d103ce52918b08e~3akoRUwbQ3138731387eucas1p17@eucas1p1.samsung.com>
 <CAPDyKFpSx7Kif_AtrVNtPSW0gy4058VBCfFQgMqMWVQGq+2BXA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jun 2018 09:58:55 +0200
X-Google-Sender-Auth: -kRWH2mM_VR0P3igedqGNQqePsU
Message-ID: <CAJZ5v0gYpceS_zpmOqowu3_Pn2qVo=H4r__67qv-Ybyy-ijFZQ@mail.gmail.com>
Subject: Re: [PATCH] PM / core: Fix supplier device runtime PM usage counter imbalance
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lukas Wunner <lukas@wunner.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 9:43 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 12 June 2018 at 14:44, Marek Szyprowski <m.szyprowski@samsung.com> wrote:

[cut]

>>
>> Is there any way to keep old behavior?
>
> I think the old behavior is sub-optimal. I am sure there are users
> that really don't want the driver core to runtime resume the supplier
> unconditionally.

I agree.

That said, the existing behavior has been there for quite a while and
the callers of device_link_add() that have grown a dependency on it
should be given a chance to change before it goes away.

> I would rather go and fix the few users of device_link_add(), to use
> DL_FLAG_RPM_ACTIVE, in cases when they need it.

Which BTW was the original idea. :-)

> Of course I am fine if we do these changes in a step by step basis as well.

OK, because that's what I'd prefer to do.
