Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AACC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8092081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 13:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpmubcok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D8092081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeLDNcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 08:32:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726151AbeLDNcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 08:32:54 -0500
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5056B20851;
        Tue,  4 Dec 2018 13:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543930373;
        bh=sBFcr+Jb62B48Hwe1h8iPAD26K2EHQzJ9SUJepkarjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kpmubcokEvNZiAPDAgfqFP6gCoI+6KbzxfoQ4SwiZvNwM0q5aLMmDW2g0ZAq1Vt42
         6hGAnaYHK3D1zjQCtNqzm5jUsYG4amSrI30bt2jvB/9GRqXIswScvvb82o6eKPPZLt
         SvMAq4HzzlqjYXjmBOwt5FjVuxYAQrQlrBLYnWis=
Received: by mail-qk1-f175.google.com with SMTP id m5so9545546qka.9;
        Tue, 04 Dec 2018 05:32:53 -0800 (PST)
X-Gm-Message-State: AA+aEWYb/+Zs5ati2G93m1pm93Vc8IHVaLnbCWmwcuGR34lMMaNtTJUE
        NnnF27OnT71Rqc+F2vTEwzaSi2D6H4C1ByVgOA==
X-Google-Smtp-Source: AFSGD/VMrJg6doU0xFmV7V+hms34CTpTPhPJPLZU6kGzHVDcmsr4VzsC++J9376JDB1j2bVVFVMqPXZls0uYhEkqGcg=
X-Received: by 2002:ae9:ef14:: with SMTP id d20mr18998224qkg.147.1543930372509;
 Tue, 04 Dec 2018 05:32:52 -0800 (PST)
MIME-Version: 1.0
References: <1542589274-13878-1-git-send-email-sugaya.taichi@socionext.com>
 <1542589274-13878-3-git-send-email-sugaya.taichi@socionext.com>
 <154337047410.88331.9696178601340675631@swboyd.mtv.corp.google.com>
 <c746a3de-a9e3-9f25-ecb9-703ceb7e62d0@socionext.com> <154356579701.88331.5043467509900444879@swboyd.mtv.corp.google.com>
 <f5917f71-f15b-a92d-649c-e3f5f5f10698@socionext.com> <CAL_Jsq+dnKht3TwCh1qB1H4pYFhQJmSN0nAayU+=PJLAvq0bbQ@mail.gmail.com>
 <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
In-Reply-To: <90b00858-6e9e-8f7c-f6d4-b35e5daa6eee@socionext.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 4 Dec 2018 07:32:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
Message-ID: <CAL_JsqJ=FRfzVFiOJ0wvoV5iZV+Gx3ft9pGyhb-GoKnOAQgPtQ@mail.gmail.com>
Subject: Re: [PATCH 02/14] dt-bindings: soc: milbeaut: Add Milbeaut trampoline description
To:     sugaya.taichi@socionext.com
Cc:     Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Jiri Slaby <jslaby@suse.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 5:30 AM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi
>
> On 2018/12/04 0:49, Rob Herring wrote:
> > On Mon, Dec 3, 2018 at 1:42 AM Sugaya, Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >>
> >> Hi,
> >>
> >> On 2018/11/30 17:16, Stephen Boyd wrote:
> >>> Quoting Sugaya, Taichi (2018-11-29 04:24:51)
> >>>> On 2018/11/28 11:01, Stephen Boyd wrote:
> >>>>> Quoting Sugaya Taichi (2018-11-18 17:01:07)
> >>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>>
> >>>>>> diff --git a/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>> new file mode 100644
> >>>>>> index 0000000..f5d906c
> >>>>>> --- /dev/null
> >>>>>> +++ b/Documentation/devicetree/bindings/soc/socionext/socionext,m10v.txt
> >>>>>> @@ -0,0 +1,12 @@
> >>>>>> +Socionext M10V SMP trampoline driver binding
> >>>>>> +
> >>>>>> +This is a driver to wait for sub-cores while boot process.
> >>>>>> +
> >>>>>> +- compatible: should be "socionext,smp-trampoline"
> >>>>>> +- reg: should be <0x4C000100 0x100>
> >>>>>> +
> >>>>>> +EXAMPLE
> >>>>>> +       trampoline: trampoline@0x4C000100 {
> >>>>> Drop the 0x part of unit addresses.
> >>>>
> >>>> Okay.
> >>>>
> >>>>
> >>>>>> +               compatible = "socionext,smp-trampoline";
> >>>>>> +               reg = <0x4C000100 0x100>;
> >>>>> Looks like a software construct, which we wouldn't want to put into DT
> >>>>> this way. DT doesn't describe drivers.
> >>>> We would like to use this node only getting the address of the
> >>>> trampoline area
> >>>> in which sub-cores wait.  (They have finished to go to this area in previous
> >>>> bootloader process.)
> >>>
> >>> Is this area part of memory, or a special SRAM? If it's part of memory,
> >>> I would expect this node to be under the reserved-memory node and
> >>> pointed to by some other node that uses this region. Could even be the
> >>> CPU nodes.
> >>
> >> Yes, 0x4C000100 is a part of memory under the reserved-memory node. So
> >> we would like to use the SRAM ( allocated 0x00000000 ) area instead.
> >> BTW, sorry, the trampoline address of this example is simply wrong.  We
> >> were going to use a part of the SRAM from the beginning.
> >>
> >>>
> >>>>
> >>>> So should we embed the constant value in source codes instead of getting
> >>>> from
> >>>> DT because the address is constant at the moment? Or is there other
> >>>> approach?
> >>>>
> >>>
> >>> If it's constant then that also works. Why does it need to come from DT
> >>> at all then?
> >>
> >> We think it is not good to embed constant value in driver codes and do
> >> not have another way...
> >> Are there better ways?
> >
> > If this is just memory, can you use the standard spin-table binding in
> > the DT spec? There are some requirements like 64-bit values even on
> > 32-bit machines (though this gets violated).
>
> The spin-table seems to be used on only 64-bit arch. Have it ever worked
> on 32-bit machine?

Yes.

> And I would like not to use it because avoid violation.

The issue now that I remember is cpu-release-addr is defined to always
be a 64-bit value while some platforms made it a 32-bit value.
'cpu-release-addr' is also used for some other enable-methods.

Rob
