Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0E5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9535720857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 04:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ettus-com.20150623.gappssmtp.com header.i=@ettus-com.20150623.gappssmtp.com header.b="S6YQpC5f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9535720857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ettus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeIEIeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 04:34:00 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43082 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbeIEIeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 04:34:00 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so2125299ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 21:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ettus-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ru3LkvNqiDLUo3vcjvBnu/LSVA4ozycOs2c8a7S8do4=;
        b=S6YQpC5ffbJpDYpldaKw2V9X0oe+tmkpUVN/PZ/eTVCWcHUfJ0wFsgF6bgbxyeiG6R
         AAFVcxxY5em4D0EkE/pgG+ZcMYGLQjGytKXwY2ubLMQsuNbM+s+vhVimwHtCvCVsQ2ba
         V8VHVao0nl7BgkKIbxgJGYJrnZtZxXZsHR6lbOGPfOcQGiw/Dkl+Rev122FE6Fo3sNY9
         BoLwwMZG9BcS6qsQqZzvfuwD4dmKbpNHeyl+NHuHSSY8BNHt24PUrbyalEpftWX5jSyw
         NuGSWc5O/BZ6fvmN201mneiCZ+BQeA7MCEDeZwTVek+lv1ZAo6c4yphlPUOdHDgxEdd/
         XE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ru3LkvNqiDLUo3vcjvBnu/LSVA4ozycOs2c8a7S8do4=;
        b=ar3xPbup1HlT5N6FW06KNQiAL+c+evCUuKQ71+ulXm515MMRjfDC6HeFsmgHPnNTlR
         h9erSjuvHuRSUWU2iuiqbk66vouAh2Yr3Njyqcavlsu809kG5I9uAjNCd90jbN9TkBuY
         UGPH8Ecl60MhxBQRvGaDuoeG3GcOwbvgwGfbpZnptVG0/IUgGpHGPqFrNUSAoJF94m/U
         +/Te7d7e5SeG9kUyV+MY4MBfX/8aUjqxvPaIKhdm0oF98qzNLjPpdJy7Y/ZN0st7GKm8
         Trxy6b3XafTojugGMcKZUZ19MhI1a+9KuDvy6PBriq5OtfD183JPf9akUL1nohOGk6xq
         /k8w==
X-Gm-Message-State: APzg51AVvP0rRUVbGt5Bz/5vy3fW9gUs65IxyN+hd3yJWjULeXTwMaQP
        UD18T2Eh5lnDmU21na/j5Jel7jC4zXzv5R9uFoX6Mg==
X-Google-Smtp-Source: ANB0Vdb1AeG8dHQOCloaaOiZ2am75JLW9PN8BR9/G9RXR5gGCzo3q2/wyf6Y3CHWQPW996S2gU3c/plS+Ppc5znPyIo=
X-Received: by 2002:a81:620b:: with SMTP id w11-v6mr19871855ywb.143.1536120346630;
 Tue, 04 Sep 2018 21:05:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:e106:0:0:0:0:0 with HTTP; Tue, 4 Sep 2018 21:05:45 -0700 (PDT)
In-Reply-To: <fa4fca9c-5950-8ec1-5746-91e51085cecf@gmail.com>
References: <20180905001535.19168-1-mdf@kernel.org> <fa4fca9c-5950-8ec1-5746-91e51085cecf@gmail.com>
From:   Moritz Fischer <moritz.fischer@ettus.com>
Date:   Tue, 4 Sep 2018 21:05:45 -0700
Message-ID: <CAAtXAHdZxgvb7=DG0B2irB4wJ+taJaOYbxhGjNtjWvaAQP8_nA@mail.gmail.com>
Subject: Re: [RFC/PATCH] net: nixge: Add PHYLINK support
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Alex Williams <alex.williams@ni.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Florian,

On Tue, Sep 4, 2018 at 5:27 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 09/04/2018 05:15 PM, Moritz Fischer wrote:
>> Add basic PHYLINK support to driver.
>>
>> Suggested-by: Andrew Lunn <andrew@lunn.ch>
>> Signed-off-by: Moritz Fischer <mdf@kernel.org>
>> ---
>>
>> Hi all,
>>
>> as Andrew suggested in order to enable SFP as
>> well as fixed-link support add PHYLINK support.
>>
>> A couple of questions are still open (hence the RFC):
>>
>> 1) It seems odd to implement PHYLINK callbacks that
>>    are all empty? If so, should we have generic empty
>>    ones in drivers/net/phy/phylink.c like we have for
>>    genphys?
>
> Yes it is odd, the validate callback most certainly should not be empty,
> neither should the mac_config and mac_link_{up,down}, but, with some
> luck, you can get things to just work, typically with MDIO PHYs, since a
> large amount of what they can do is discoverable.
>
> If you had an existing adjust_link callback from PHYLIB, it's really
> about breaking it down such that the MAC configuration of
> speed/duplex/pause happens in mac_config, and the link setting (if
> necessary), happens in mac_link_{up,down}, and that's pretty much it for
> MLO_AN_PHY cases.

Let me check, it seems there is a register that indicates whether the MAC can
do either 1G or 10G. I might be able to use that for some of the above, but
there is not really much in terms of writable registers there.
It's like a DMA engine with a bit of MDIO on the side. Let me see if I can make
it look less weird with that. If not I'll go with a comment explaining
that there
isn't much to do for the MLO_AN_PHY case and the MLO_FIXED cases?

Cheers and thanks for your feedback,
Moritz
