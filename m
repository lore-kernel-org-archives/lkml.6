Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BA8C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:17:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C477D218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 05:17:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="NTYTh2mG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbfAYFRK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 00:17:10 -0500
Received: from mail-40133.protonmail.ch ([185.70.40.133]:31891 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725300AbfAYFRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 00:17:09 -0500
Date:   Fri, 25 Jan 2019 05:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1548393426;
        bh=woeysuqhgtGgsVXmIhjEhQrJa9mY1Hmx2nb9BNPtnFQ=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=NTYTh2mGQP9yM5zh8zt3EwpT8osG9zu/vOVt7enqTnC+K17ci0WZAeD6+b0oTbcNg
         s5kgEmICX3xVCzRdJ4v/M7m4SpG1ba5GJZOCiMxh3dNGoD8VvuhDNt7/kq90u8OVWO
         Mv0gTmy0K20jts20zMGu1L/FJYn1893BvAuRxwBA=
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
From:   Mogens Jensen <mogens-jensen@protonmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Dean Wallace <duffydack73@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Mogens Jensen <mogens-jensen@protonmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
Message-ID: <3ERhUwlxf4lWV_mn3MgjNMrm8ZDgFevrwjq0KRjy05oM1hGiQUdsPpbIlKytNGHi1ViQ_2Xv7bxzqusfruSjbZJyUSpQ9Uo8HCiNyUdyNdU=@protonmail.com>
In-Reply-To: <43070180-1f10-9285-7564-cfa24e1d222e@linux.intel.com>
References: <20181025232517.ywnw54qibemosjws@picard>
 <3e12e051-b874-187d-d4f5-e146f59c659b@redhat.com>
 <U9ny3qDg8fEQ-IaXWgwAmDf_U7yb1NZxpwoOvTorCbG86v8wUae3kWsa5omAv-ngu3VMaSONp6RdzmaI26Cz6uoyf5ddIiXuJQbzGf2MN3w=@protonmail.com>
 <20190117091214.7djttnpo4jjzi4su@spock>
 <c935552f-951f-ab9f-b41c-76c729c6d85c@redhat.com>
 <pozwYTgSVvWumpTgwwf_C-qvYFNnl7yl9gcq9M-LOUXQTvkSX5f8E_2d-HYNYV_ruL8kAURaIR3ItM_UmFJeV-e28eYy8b2MomlwHMbb-5U=@protonmail.com>
 <983fb777-df22-1b53-acea-8bbcab23b260@redhat.com>
 <G5Oa_GRw3iClWMtIg1FeCwj1szJHRH6ToqQqCskS_HKzyNhpFFQ3sJndttzyvP3IHRJuHXvDsUC82dnw8r66OIroHCzyqTYbZoki5sSKPUE=@protonmail.com>
 <43070180-1f10-9285-7564-cfa24e1d222e@linux.intel.com>
Feedback-ID: 4dFv7M8pOtP7CMTtfNdOwXARWpF2vcQYB4dRuX1h9mb-6008qkzO2MVweOzrAYHEdkjJ6P5PUdgJEubk4l9Lhg==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90 Original Me=
ssage =E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90=E2=80=90
On Tuesday, January 22, 2019 7:27 PM, Pierre-Louis Bossart <pierre-louis.bo=
ssart@linux.intel.com> wrote:

> On 1/20/19 11:55 PM, Mogens Jensen wrote:
>
> > The only minor annoyance I'm experiencing now, is a large amount of deb=
ug output from something in kernel log when audio is played on the system:
> > writing to lpe: 00000000: 01 01 01 01 00 00 08 00 ff ff ff ff 55 00 00 =
00 ............U...
> > writing to lpe: 00000000: 01 01 01 01 00 00 1a 00 ff ff ff ff 75 00 12 =
00 ............u...
> > ...
>
> That's enabled via dynamic debug so that's rather a configuration issue
> than a kernel problem?

Do you have any suggestions on how to disable it?

My kernel is compiled without DYNAMIC_DEBUG, DEBUG_FS and other debug featu=
res, so I don't understand why all this debug output is flooding the kernel=
 log.

It's a minor issue, but it would be nice to get rid of it.

Regards,

Mogens Jensen

