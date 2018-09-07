Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FC99C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0244D206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 08:01:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0244D206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbeIGMlF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 08:41:05 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46659 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbeIGMlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 08:41:05 -0400
Received: by mail-qt0-f196.google.com with SMTP id d4-v6so15303257qtn.13;
        Fri, 07 Sep 2018 01:01:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ieUrACbzLr6QpetR5oOZNHG1E1oPyAV8O8kPP3I8fBU=;
        b=BjnwvZaSD3O/6mmaLiw9QYXcQTvZftoTr+3LDg0boIIG6PDsGvMNjXhSI3/SHlVogw
         BQryvK7Ub4hJu+UCR3VcFYjdTzzcJxRPopGUG3JAvZ71DQu2+BDW+y2wzsjPdbIF3ojq
         So4E8W3268cdesKXB1xbFyFeroIF+68cj8KMCViq3OHf8f/5Vdmn/2mnTJrGXWq4GLKW
         8L1DNkJwjo5MJqFqTe4FT4JBzaoI/jVyClOySPNCgETu+BhuV2Lkw5B8CDRvdWknXcEw
         HVTBrWbiIxDWu69pwq9vDXwxjPNCkWBLbY6W2JRETVUBXBsGE485VhaB9l3Yli6KbjJw
         5U+Q==
X-Gm-Message-State: APzg51B442mBLYJAlmOXOU8KwdzayT3cnVTB3RNkvgKs2gjVWWDYWQyK
        T0BlsFbkcUkUAhLatDK16YQN2NONpDUwFc/7M5k=
X-Google-Smtp-Source: ANB0VdadJzfnur0cfWGPulf9+wybXXxqNddDqAG9sy0YLUnEsKkzaaD4WqBUhCdJwi5FXXoo8XEGnn/kaJ7DWU2vFxw=
X-Received: by 2002:ac8:c9:: with SMTP id d9-v6mr5107813qtg.213.1536307279681;
 Fri, 07 Sep 2018 01:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1536138304.git.ren_guo@c-sky.com> <66335e5f59c186b291f8c3c98c9dadbd61d0cd3e.1536138304.git.ren_guo@c-sky.com>
 <CAK8P3a2pOYNB6LtFB6hJ3WMXzJsj5wwNKvBK4_dP-4uPKas-Pw@mail.gmail.com> <20180907051747.GC13356@guoren-Inspiron-7460>
In-Reply-To: <20180907051747.GC13356@guoren-Inspiron-7460>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 7 Sep 2018 10:01:03 +0200
Message-ID: <CAK8P3a3HTySouXpwd3qbxzKodJgmTF+N_NxPzt5u7erNbkELig@mail.gmail.com>
Subject: Re: [PATCH V3 17/26] csky: Misc headers
To:     Guo Ren <ren_guo@c-sky.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        c-sky_gcc_upstream@c-sky.com, gnu-csky@mentor.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        wbx@uclibc-ng.org, Greentime Hu <green.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 7:17 AM Guo Ren <ren_guo@c-sky.com> wrote:
>
> On Thu, Sep 06, 2018 at 04:16:30PM +0200, Arnd Bergmann wrote:
> > On Wed, Sep 5, 2018 at 2:08 PM Guo Ren <ren_guo@c-sky.com> wrote:
> >
> > > diff --git a/arch/csky/boot/dts/qemu.dts b/arch/csky/boot/dts/qemu.dts
> > > new file mode 100644
> > > index 0000000..d36e4cd
> > > --- /dev/null
> > > +++ b/arch/csky/boot/dts/qemu.dts
> > > @@ -0,0 +1,77 @@
> > > +/dts-v1/;
> > > +/ {
> > > +       compatible = "csky,qemu";
> > > +       #address-cells = <1>;
> > > +       #size-cells = <1>;
> > > +       interrupt-parent = <&intc>;
> >
> > Ideally, qemu would supply a dtb file that matches the current configuration,
> > as we do for instance on the ARM 'virt' machine. This allows you
> > much more flexibility in running all kinds of options, as well as extending
> > qemu later with new features.
> So, I should remove qemu.dts in next version patch?

It's up to you really. If you won't have a version of qemu that can do this
by itself, it may make sense to keep it around for a while. You might
want to include the version of your current qemu port is based on
qemu-2.x but not upstream, you could include a qemu-2.x.dts file
here, and have the future 3.x port provide its own.

      Arnd
