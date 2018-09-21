Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C0AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA0921547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9ggCVEK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AA0921547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbeIUL03 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:26:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55180 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeIUL02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:26:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id c14-v6so1681045wmb.4;
        Thu, 20 Sep 2018 22:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fLlZIkV4RmpB6KLGO5coxLnh3oswoyEfPx53dmpqol0=;
        b=a9ggCVEKCREotf7dBtlkISDOEODCebF2ctfGU2mq3oUW1Oiphcq+VfGmeKBo+fjgmR
         WMr92VnLIPEUik0c84iGzNUx8AiJYsSm+7+gT56rFzqx1lcxqX0JJU72GWfn+GV5L5Ow
         OLeufZqKrjXECofO/wST39Z1u3gdwCy+UELOg2ai71z09k76f7ITueb3/kcT5V4MC41y
         ZiWi7t/XnmTM6Qk0ouFiRNgL28rnuEUPyahEQ45PhlbqouMSnmEqQsJ0xL8NAH5xlbX/
         HRWPDjyDHYYx1ICjUqNM6Mlic4hW9ARz56qY11LoRf/GbFC1d6e/wnllDR01YE3Mdcrh
         EB0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fLlZIkV4RmpB6KLGO5coxLnh3oswoyEfPx53dmpqol0=;
        b=IOt6DATe6+wrnK9mzzaAb4x9PO3Tt9oCYhxLhOwUOtvNmGjyEeuZtk84RmFxGTGDme
         WEd6shSThMeL2MZQYqypaAR4HCwt+GWMm30F34K0SOeWG3/tl3XDinNkN9KHacWBmlfH
         /Y5tGTxSB6TO7n5f4L/VjkVMJpq0y2PFQ/X4Lq7flN5mlGEqYWCCv1ZscObJbICVjjue
         zBFguayI4kJA7JtekhFn1FTHeh6/DK9JPCA9ugN+WY9PLjQ/wDyD2JC3q2cwjrUe8CML
         CWkYwODHhu8reMTRyzy454qzW3lhKAZ20JlCpjRBhvU9h9RzhEdNuQYfp5KLg/MCRGRC
         Ja1g==
X-Gm-Message-State: APzg51AL+3AwtPu8uLbI25vGrJESurtYOaXiw+WXaqqJJ0NdpLdmVxxU
        +A/NOBT/K5jBaD9Oo6lQwDQ=
X-Google-Smtp-Source: ANB0VdYqKThgC5MkvryTI8Ww/wt4VD6nmHFR/mrigr127z2KL7rEIqiBf8vgswgK/fT0AyrUIcgLiQ==
X-Received: by 2002:a1c:6443:: with SMTP id y64-v6mr5528467wmb.70.1537508353701;
        Thu, 20 Sep 2018 22:39:13 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id j133-v6sm5148211wmd.12.2018.09.20.22.39.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Sep 2018 22:39:12 -0700 (PDT)
Date:   Thu, 20 Sep 2018 22:39:11 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-wireless@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wilc1000: Remove unnecessary pointer check
Message-ID: <20180921053911.GA5170@flashbox>
References: <20180920212648.25181-1-natechancellor@gmail.com>
 <32473.1537507532@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <32473.1537507532@turing-police.cc.vt.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 01:25:32AM -0400, valdis.kletnieks@vt.edu wrote:
> On Thu, 20 Sep 2018 14:26:49 -0700, Nathan Chancellor said:
> > Clang warns that the address of a pointer will always evaluated as true
> > in a boolean context:
> >
> > drivers/staging/wilc1000/linux_wlan.c:267:20: warning: address of
> > 'vif->ndev->dev' will always evaluate to 'true'
> > [-Wpointer-bool-conversion]
> >         if (!(&vif->ndev->dev))
> >             ~  ~~~~~~~~~~~^~~
> > 1 warning generated.
> >
> > Since this statement always evaluates to false due to the logical not,
> > remove it.
> 
> Often, "just nuke it because it's now dead code" isn't the best answer...
> 
> At one time, that was likely intended to be checking whether ->dev was a null
> pointer, to make sure we don't pass request_firmware() a null pointer and oops
> the kernel, or other things that go pear-shaped....
> 
> So the question becomes:   Is it safe to just remove it, or was it intended to
> test for something that could  legitimately be null if we've hit an error along
> the way (which means we should fix the condition to be proper and acceptable
> to both gcc and clang)?
> 
> 

I certainly considered whether or not removing the check versus fixing
it was the correct answer. Given that this check can be traced back to
the initial check in of the driver in 2015, I figured it was safe to
remove it (since a null pointer dereference would most likely have been
noticed by now).

Most patches addressing this warning just remove the check given that it's
not actually changing the code, such as commit a7dc662c6a7b ("ASoC: codecs:
PCM1789: unconditionally flush work"). However, if the driver authors and/or
maintainers think that this check should be something else (maybe checking
that the contents of dev is not null versus the address, I'm perfectly
happy to submit a v2 with this change.

Thank you for the response and review!
Nathan
