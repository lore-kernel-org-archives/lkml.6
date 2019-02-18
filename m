Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4051C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A018214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfBRMyv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:54:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37879 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbfBRMyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:54:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id m9so9873962qkl.4;
        Mon, 18 Feb 2019 04:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c2E49QAVohFq0rOCe1RTzJv1jXR7Acf6VdRdHZMGLfk=;
        b=BsXbZ92SrGci/ZAkYjlcHv2vrqk5uwhsqb1/8NQHY7EJdEzVc1teymxtz4b0hmb4bB
         U4XELcx0yyH/et03HQpvoQoAXYobrTW13Ahq+SmrszeHHqCF/f+OdGnT/ZRVu2FiZOtc
         YW1C3A045cgf5r8jetg3pXJKKEv9odI2NdzGd6I7JmKsLPuAv/U5fNuZFEhZkSzwKGVR
         +QEdKWGNRR1u3lfToZaAEpHRQ1BAtHbe5AYf4izOtPtia+m3fAl4zCeAZjVxu93a5K8W
         KzqhXwBAkmT9VCv6/g977AoQWR9aMeMiHtUEl/E40x/8DW1AY4DgjoO8xrhq/zo3vOA0
         4q5g==
X-Gm-Message-State: AHQUAuaDsEw246seYj8spMrwa4fh8bh5WEKXDrY9FcDmKaZNU5Q40GOA
        m8cXfc70isTMQEATh3vKJ98WFa3ieq5Xpu4NE64=
X-Google-Smtp-Source: AHgI3IYtUmFwOJkVcrDfgVprQYA8sHo+mTpLFIH2DovLlnErkL5jBuOV7iqqADRTsk7oZeE5VE5V/+M9VQFbceLRTHw=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr16657260qki.291.1550494489786;
 Mon, 18 Feb 2019 04:54:49 -0800 (PST)
MIME-Version: 1.0
References: <1544604495-4082-1-git-send-email-fabrice.gasnier@st.com>
 <1544604495-4082-3-git-send-email-fabrice.gasnier@st.com> <CAK8P3a1MucNG86=bXwVVsasGBOLJ67kuRSpoeneF6M5aB6GmQA@mail.gmail.com>
 <9e0ee154-a399-9bff-3beb-adfd9d6c6fee@st.com> <CAK8P3a0kV4-OF7JPwM9cEqxaPvNM9dFZdyZetc47t+D5izkFwQ@mail.gmail.com>
 <47a3fe9f-8adb-8f47-e7c1-342f8fc318aa@st.com> <01d49f11-a68e-1674-e6b7-d1b87aa973c9@st.com>
In-Reply-To: <01d49f11-a68e-1674-e6b7-d1b87aa973c9@st.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Feb 2019 13:54:32 +0100
Message-ID: <CAK8P3a01rEa3bqHuhgFbNZJrb38f5XrGnDd=W3xKVorfJXHZkw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] mfd: syscon: Add optional clock support
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Gabriel Fernandez <gabriel.fernandez@st.com>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 5:32 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
>
> On 1/28/19 2:20 PM, Fabrice Gasnier wrote:
> > On 1/16/19 4:11 PM, Arnd Bergmann wrote:
> >> On Wed, Jan 16, 2019 at 3:10 PM Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> >>
> >> What I mean is that nodes that listed as 'compatible="syscon"' get
> >> probed by the syscon driver even when no other driver references
> >> them, and that in turn would acquire the clock, right?
> >
> > When no other driver references them, nothing happens at probe time on
> > the clock: no calls to get/prepare... the clock.
> >
> > => The clock will remain unrequested & unused until another driver calls
> > one of "of_syscon_register()" variants:
> > - syscon_node_to_regmap
> > - syscon_regmap_lookup_by_compatible
> > - syscon_regmap_lookup_by_phandle
> >
> > When another driver references them (e.g. one of the above calls), then
> > it will acquire the optional clock and use it, e.g.:
> > - clk_prepare() upon of_syscon_register() variants
> > - clk_enable & clk_disable when accessing the registers
> >
> > I hope this clarifies.
>
> I would appreciate to have your feedback.

Yes, I think that's all we need here, thanks for the clarification,
and sorry for dropping the ball on this again.

Acked-by: Arnd Bergmann <arnd@arndb.de>


      Arnd
