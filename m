Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80CC5C169C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48294217F9
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="yKf2QFWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfBGDL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:11:26 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42082 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBGDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:11:26 -0500
Received: by mail-pf1-f193.google.com with SMTP id m6so682246pfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 19:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=F/+7rRTfbZwfbHmaF3iZzoY6bHWWxxmy6iraekkllWc=;
        b=yKf2QFWQ9kNL+f5kHd3S7Jbm+JZ9GNbbas2UNL8rUF4HW2i/yx/ZHK5uAXAmxASN36
         8M2vN5z7rG85IIAtaGes9APh2VE1TQ1jZbcaEDO8ENkpjR4ATsT3+NVMNWTAQuQgoCjr
         pwbJwNKzZO+XLeKuq9apJxuW0+Lxp8RksBYKcSF/zE73ZX4rC9TD7sttRylR66Wt8tVW
         ACe+KcKZkbc8UtsTqxSbmaqha/yXUDvFI0Nn9K9x02ritem9O+DdAF8OBg7hFHJn8s33
         HiYefKiXf44FQNkLS3YIo0/EbxXOuBCc1N1SirBV6hYlwkKW6DBpBASldez4Y3StqVpq
         J9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=F/+7rRTfbZwfbHmaF3iZzoY6bHWWxxmy6iraekkllWc=;
        b=rKtRC5g+R+ViOBDW88B/DWPvbHBBuVq6WMinYHddHnjdoJgH12dmQDdfnEEGFkD3kN
         YUXRDcYOC9Fw1LUo/FRdxII+3RNMkhjbgEkI+1gQEPi8BQ36wGT5cHJgIzECKG7PiJZS
         F5Qc4VT/onblU2yCAlmiLneQlxyYp84QzWNMSnHownVVMIav91WRLip1tuxdJ+moB90T
         MlGJXMX9PxZZZ9YxkhtwsNSy5K+Vm9sBGLa3CJN7UU0dyQWwgk+LJ9xdpvsK3RvoiroF
         7R0M+5BVqIST1k8boba5Rrj/NusdARdXx3x7L3J1mEEqkoW6stnMgNJrNzaHbvkqf/6L
         x7hg==
X-Gm-Message-State: AHQUAuZPu36GKP2wkhDf36uqVDj0yNpP5UZ1NsRVSGjM1I/dXpd6SQjN
        oeCGKOF/Bm5+0Bb2JUsDr9DVHA==
X-Google-Smtp-Source: AHgI3Ibo9yDr6Lr5sHfOOmyOps09J7HfOK77FkIyrpu/ogCE2IHiZ3zhz9WvNtI/TAcJcu+1aQb+Sg==
X-Received: by 2002:a63:2ccb:: with SMTP id s194mr12774860pgs.214.1549509085280;
        Wed, 06 Feb 2019 19:11:25 -0800 (PST)
Received: from localhost ([2601:602:9200:a1a5:1818:ce94:f47:7c12])
        by smtp.googlemail.com with ESMTPSA id l2sm7563903pgn.52.2019.02.06.19.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 19:11:24 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list\:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list\:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list\:ARM\/Amlogic Meson..." 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] pinctrl: meson: g12a fixes
In-Reply-To: <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com>
References: <20190117102315.1833-1-jbrunet@baylibre.com> <CACRpkdb7pje9mrgOQoiWTRxGQC8xsOvJ9a8PCguM807unPtpCg@mail.gmail.com> <a434c3b1c55a1b5a1485adc29cfe26b45131a936.camel@baylibre.com>
Date:   Wed, 06 Feb 2019 19:11:23 -0800
Message-ID: <7h36p0i97o.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jerome Brunet <jbrunet@baylibre.com> writes:

> On Mon, 2019-01-21 at 14:53 +0100, Linus Walleij wrote:
>> On Thu, Jan 17, 2019 at 11:23 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
>> 
>> > This patchset fixes the initial pinctrl support added for th g12a SoC
>> > family, which is mainly around the register regions claimed by the
>> > driver.
>> > 
>> > Linus, would it possible for you to provide a tag with these changes to
>> > Kevin ?
>> 
>> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git/log/?h=ib-meson-fixes
>> 
>> > ATM, we can only use the devices for which the pinmux is already set by
>> > the bootloader. Enabling the broken pinctrl driver could cause regressions
>> > in kernelCI. Having a tag, would allow us to start using pinctrl on this
>> > SoC in this cycle, w/o regression. It would be nice :)
>> 
>> When you say "this cycle" do you mean I should target fixes (v5.0-rcN)
>> or next (v5.1) with these patches?
>
> I was referring to the 5.1 release but it is a good question, I did not really
> think about 5.0.
>
> Those changes are mainly fixes, so guess it could go in the 5.0 but support
> for this SoC is still in its early stages, so either way is fine by me. 
>
> Whatever is simpler for you I guess ;)

If it's not too late, v5.0-rc is simpler for me as it means not having
to deal with this as a dependency branch/tag.

Kevin
