Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B86C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860D120869
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 00:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OoJLRFfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860D120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHJCu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 22:50:29 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33936 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbeHJCu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 22:50:29 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so6321056ioj.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Aug 2018 17:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRDo6+WuHy4fXjYpmVcxSBqa6jWM7FRPfIAcILNoQhQ=;
        b=OoJLRFfVcw7Ovwl1IZT5FIEQQjJeclhsdyOmQXVShsKqYpgUK/tHinoENyTMJ/e9LV
         v3Z3RvvQvKZa6LqaxsyV51azH/moRPkrx96nxCAeKKj5Fc0idb4k/EILgfT19ZyIimfh
         TT294B38ReSea9nb3v6+axiW+UofUv9n2bGM2Cwd7jYI8ah+KJWhCqYJ2CaRj9w2Hpi5
         EDO1let0dCoJfBVwLfnsOJt9Jss8otWa7tsbTRxTVZ35pdOpwf+oRz3tzaxYETnU/nvI
         GOFyuMH8uPOx4bAh09CIl1isSvhxeaRmS81fie9FlshBCKyYFQMUw417l3Dvlprm7AP9
         9W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRDo6+WuHy4fXjYpmVcxSBqa6jWM7FRPfIAcILNoQhQ=;
        b=SSuU2JSwOvD6SZxTK8D+BQ1+KLsySs3IRkNOkcK/c+h+qyldwGLYf8qPOvijAyztQw
         chTendt/5EJrH+ZI+b10daJHhZisOvPeu5AYUiAjcRuQesaXf9/wrAYfJFmm2EbS5DMe
         VYCunWfhuQKlpf/gB2aI3q1EVgrvDHaf2ZGrGf4AEW3xngzMIsmarruw2dqIs4gyoX0E
         dLgP3Cy68pCrP3JnsGmevjJpFiN/s01hwbpyOkVUdf10hK1gUtaeNpx0kEkDVC/9cPsd
         HksiOTDzOolaVgd6ATt0hImKLHcyQrRYx9G+MquiumWINYPDewTXPs/hyqqaaHK12PgZ
         QRgA==
X-Gm-Message-State: AOUpUlFEaNhM4gy56JNNFgQrkKVVeeT/lhVXuK9RZHT6M8e3bOsaWTzt
        KsvtoEmEH+eP0gLxbBDGgrJveh7k8idQ7iKDaUPQEg==
X-Google-Smtp-Source: AA+uWPxIPPgypL4zoR2MT1uX5vtLV/NydZ9oKEc2KR2+rvkY7omSBk5m+j0iLUQlN+3YbBx2AIghZoci7GMQdEh+OJ0=
X-Received: by 2002:a6b:bf04:: with SMTP id p4-v6mr3587593iof.15.1533860589235;
 Thu, 09 Aug 2018 17:23:09 -0700 (PDT)
MIME-Version: 1.0
References: <20180711053122.30773-1-andrew@aj.id.au> <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop> <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
 <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
 <9787b471abc49c0b3db60e3471473a7a5b45ade7.camel@kernel.crashing.org>
 <1532045276.1219110.1446722072.546C1F9D@webmail.messagingengine.com> <483b76bac7cb8043d9d780d5ffa5e43438279887.camel@kernel.crashing.org>
In-Reply-To: <483b76bac7cb8043d9d780d5ffa5e43438279887.camel@kernel.crashing.org>
From:   Kun Yi <kunyi@google.com>
Date:   Thu, 9 Aug 2018 17:22:42 -0700
Message-ID: <CAGMNF6XCSdif5=kAQ4eh_6+nmHLAu9Fva403EU2Ji2w27H9R0A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
To:     benh@kernel.crashing.org
Cc:     Andrew Jeffery <andrew@aj.id.au>, robh@kernel.org,
        Eugene.Cho@dell.com, a.amelkin@yadro.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, gregkh@linuxfoundation.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-kernel@vger.kernel.org, stewart@linux.ibm.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Benjamin, Rob,

Thanks for bringing up the set of patches and a great discussion.
After going through the thread I figured that I'd like to share a few
things we needed to hack when programming several BMC boards:

- Debug UART enable/mux
- Disable GPIO D/E passthrough (I think this is supported by the
current pinctrl driver)
- RMII/RGMII strapping
- iLPC2AHB control
- SPI master mux select
- Various SuperIO configurations

As for the discussion whether these belong to a platform driver or
device tree nodes, I think in an ideal world all these configurations
could be nicely grouped and abstracted in a platform kernel driver (or
drivers). However in reality think this as an "M * N" problem: there
are M variants of BMCs and N different platforms built with these
BMCs. Each platform-BMC combination is going to have its own quirks
and slightly different requirements in BMC "tunables". Were there a
kernel driver for the M BMC variants, it would inevitably have a lot
of churn due to the different needs of the platforms.

What I like about the device tree approach is the expressiveness of
the format and the ability to specify non-conflicting initial values
easily. Sometimes we need initial values for these parameters set
before running userspace, and setting such values in device tree is
easier than using #defines or kernel parameters.




On Thu, Jul 19, 2018 at 9:57 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> On Fri, 2018-07-20 at 09:37 +0930, Andrew Jeffery wrote:
> > >
> > > Andrew, can you start with a list that shows what you expect us to need
> > > on our systems ?
> > >
> >
> > Okay, our Witherspoon and Romulus platforms containing the ASPEED AST2500 currently need the following tuneables exposed:
> >
> > > From the SCU:
> >
> > - Debug UART enable
> > - VGA DAC mux
> > - VGA scratch registers 0-7
> > - LPC SuperIO decode enable
> > - VGA MMIO decode enable
> >
> > > From the LPC controller:
> >
> > - iLPC2AHB enable
> > - SuperIO scratch registers 0x20-0x2f
> >
> > (The LPC controller is just as much of a collection of random bits as the SCU)
> >
> > Lastly, our Palmetto platform uses an AST2400 which has fewer features compared to the AST2500. Its tuneable list is the same as the above with the exception of "Debug UART enable".
> >
> > Tuneables that we may need to expose in the future include:
> >
> > > From the SCU:
> >
> > - PCI VID/DID for the BMC PCIe device
> > - VGA device enable (may need to be disabled if the platform contains a discrete graphics processor)
>
> Additionally there's a bunch of resigters controlling the mapping of
> various MMIO regions of the BMC PCIe device to portions of the BMC
> address space. I'm not sure what's the best way to handle that.
>
> This specific set might require a dedicated device as a subnode of
> the SCU in the DT that contains all the mappings as properties...
>
> That or we consider them static enough and just whack it in u-boot.
>
> > > From the LPC controller:
> >
> > - UART mux
> >
> > Alexander, Eugene, can you chime in with your platforms' needs?
> >
> > Cheers,
> >
> > Andrew



--
Regards,
Kun
