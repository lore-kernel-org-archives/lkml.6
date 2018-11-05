Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3555C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:51:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83AEC2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:51:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="mBTjCj0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83AEC2085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeKFALp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 19:11:45 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35748 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729237AbeKFALo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 19:11:44 -0500
Received: by mail-lf1-f65.google.com with SMTP id d7-v6so6346664lfi.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xgE03pPN+9wuq0qirtwdL1IKr5R838upk1+37/4xbeE=;
        b=mBTjCj0JXCG7qTI4YGpxOfh9KyzFTv4LJfy1o8TDeQ+yZsxfTPB8I0MMR/1pMXXjJv
         f3z/Z1aUw27krQN5dygZmN1SZqM8xUpRb1R0HsqV7rQjO/tsvE/e2JEZyxU1ETPXalEU
         8+lApF/i+yT2XMOPqd+excZlV7A1LVwYYuSIFN8Qv7c63/uqgjKa1tCORuCx/TocpRGr
         G0NP58uTt7eQMxWd65VIsUQ/uUSbWI2j31lIaG992oCBtq2ag068t3TGF31ek3c/Luv2
         dScN6ee6lSI5fzfr/4gM4tC0rT9VD3sMMkrmugI7OXEf60IpZiPUMe71PzjpePKvn2UW
         usMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xgE03pPN+9wuq0qirtwdL1IKr5R838upk1+37/4xbeE=;
        b=cA69K80ldtYCtB5EDMic8o56DoGE6lOZpMF1EBKU27vA4MAW9THMOh0nUowwkEyF8F
         NTHy9XYwPgu7uqE0AmqzUxc4uTJUYs+eI0vLu+HQXa4ezaWdaizlRRUrTYPbriEdVf64
         s9e8QTzpAiZIt/1uOmRopjTyQqcRKEb/vkb19CJVSmbQd1R5XFYhHbX6tb1mLcANLrr8
         40b1Z/u6EjnNWOLDAZAHT1CJMBn8bBEtjnyJLx8k8UhNPyZhL4QbVeDatXaids3ow2MC
         uOB3LeKldfMkqfPvFSSV3CdithKMdaWRkHsMgF/LF8t4iCt+9GiXf55RWuKU1aAmfMrS
         5Aug==
X-Gm-Message-State: AGRZ1gJ/og/NVzAkcWkYlDmU8ZMhjJ7XPyWamPJUWXOxUxb4GYniQyKy
        BeBtPSVV6CZn7JIcwMnzkNGSjivdSvVlve78C0kPZw==
X-Google-Smtp-Source: AJdET5eQe1LAJ7sULuMRfrX81hnzPJ6bD2dowS76kklylGDMRdUD4k7CUVEHKaiKD8HC6gb8CPQpMxByAttTFArauF0=
X-Received: by 2002:a19:a28e:: with SMTP id l136mr13596169lfe.87.1541429498746;
 Mon, 05 Nov 2018 06:51:38 -0800 (PST)
MIME-Version: 1.0
References: <1540447621-22870-1-git-send-email-manish.narani@xilinx.com>
 <1540447621-22870-6-git-send-email-manish.narani@xilinx.com>
 <20181105125644.GA7937@zn.tnic> <41c5ca53-ed4b-38d0-c612-e1229004293e@xilinx.com>
 <20181105132007.GB7937@zn.tnic> <a81f47e0-1778-a6ac-4cd8-634502661d6f@xilinx.com>
 <20181105134218.GD7937@zn.tnic>
In-Reply-To: <20181105134218.GD7937@zn.tnic>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 5 Nov 2018 06:51:26 -0800
Message-ID: <CAOesGMj=EbWgcYF2Mhh6TFMCdn1ub1Ze6fbXJnFFdsttWByXYg@mail.gmail.com>
Subject: Re: [PATCH v10 5/6] arm64: zynqmp: Add DDRC node
To:     Borislav Petkov <bp@alien8.de>
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>, manish.narani@xilinx.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Li Yang <leoyang.li@nxp.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-edac@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 5:42 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Nov 05, 2018 at 02:32:55PM +0100, Michal Simek wrote:
> > you don't have that HW anyway.
>
> Grrr, I'm not talking about me - I'm talking about people testing
> linux-next. And perhaps in this particular case it won't matter because
> this hw is not shipping yet or whatever but the question is about the
> principle of the whole thing.
>
> > I looked at v10 and I can't see your ack there. Can you please give me
> > a link?
>
> I'm talking about *other* patches for another driver.
>
> Please note that I'm replying to this thread as an example - the
> procedural question I have is not only related to the synopsys changes
> but the synopsys changes are a good example for the problem of EDAC
> changes being sent to me along with DT additions.
>
> As such, the question was aimed more at arm-soc people - that's why they
> were in To: - not at you.

Hi Boris,

In general, for new functionality where needing both the driver change
and a DT change to enable it (or a driver change and a config change
to enable it), we have been merging the changes separately between
driver trees and arm-soc. I.e. things will be in place, but not
enabled, until both sides land. Main reason for doing so is to cut
down on arbitrary dependencies between the trees, since there can
sometimes end up being a lot of them.

Since DT should strive for being backwards compatible (i.e, a driver
change shouldn't require a DT change for the kernel to not regress
functionally), this has been working pretty well.

However, if there's some other reason to share a base between the two
trees, we can do that. For most cases we've found that it's not needed
though. So let us know what you prefer here.


-Olof
