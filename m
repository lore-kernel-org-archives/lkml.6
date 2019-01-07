Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99934C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683F82147C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rqIU7pkA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbfAGS4M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 13:56:12 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40489 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726746AbfAGS4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 13:56:12 -0500
Received: by mail-pf1-f195.google.com with SMTP id i12so600163pfo.7;
        Mon, 07 Jan 2019 10:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XwNl/TitawJ7N8zhHe2JPKNdQp6kHxtlY82AbdRT/V8=;
        b=rqIU7pkAybil15Cs2wWlLgjed/zO8ei3hxF4jgZf3+1gVsIhf9ECpa8q2AQVU/uNso
         9M2eSdUzhgNdhFVuGwswTBFygsVihK8NVArxBpkxiGM0Bh52KWHZfRCpDIBo2Q65WiN+
         WHBaLzQ+bldsc6PHDpQhXrgUVK8ctefPZQ3ut33pzzDBdD1NTK6skqolOMJmW8SPc+GV
         ssblPsdwMOxF0NZvLIzv/PXTPUsu88SpSXF/NLCGe9nvu68/GuyMp+e4oaN2Fd9xts0H
         b+PLpdIJUKdrkNDKihiXA8fMPbbFUIiOf+qIVIycGWKNxwK6Tl/0Q4L0vuwv3d1Ty7ov
         sTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XwNl/TitawJ7N8zhHe2JPKNdQp6kHxtlY82AbdRT/V8=;
        b=hNt3OYkyyZxBus8fcP/Z6RdZWlTCksZviu2jo/L5ae7D9eFF3/bRPwZLFaEQmvOmfw
         1ly3cWhoPQ+CFbfcaDL9AEdaRyIOxk4oppjdO46rRWS8NzZ7e17mEE7Nd7i0LuMLgYI1
         m3kMuVFAbpeXSV7Tk746z+bGK3LX4r++Ox+qU0MwTHXwfd1gwp9Tq9QE35LN7NvwsIUj
         Re1mWRGNrTyUIFxfkaa670sqTRu54I89cUoN2OlwNpmkY9y6pIHlDdXXQq35ngpOBVtD
         msY5w8cWJagdue/ql0P76gKaFmDt3aKSA/+gUF45y9KXYGzRr8cBCrQWzrwoILo/HLDq
         ESxw==
X-Gm-Message-State: AA+aEWYx20MVBnNdPhIiv1LA8zR9NTEBXBzMizezicj5dvRa/FS0n1PQ
        CY3WLmEsg24rTaHUprXEGDM=
X-Google-Smtp-Source: AFSGD/Vj4JuqvcCFj9ki1vLht2OuyrGnY45hbDRwciKiE0iPzG4vdyxj+mRWSxVr+ypYK+/Jd8YNYQ==
X-Received: by 2002:a62:16d6:: with SMTP id 205mr63842799pfw.256.1546887370729;
        Mon, 07 Jan 2019 10:56:10 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id 134sm80404085pgb.78.2019.01.07.10.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 10:56:09 -0800 (PST)
Date:   Mon, 7 Jan 2019 10:56:07 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gonzalez, Alex" <Alex.Gonzalez@digi.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Input: goodix - decouple irq and reset lines
Message-ID: <20190107185607.GA141497@dtor-ws>
References: <1546617648-23445-1-git-send-email-alex.gonzalez@digi.com>
 <1546617648-23445-2-git-send-email-alex.gonzalez@digi.com>
 <20190105225147.le5fgpnvq7sctxe5@penguin>
 <6b8f757eb52eb74d9dc2c3bedbfec798a58c0ec2.camel@hadess.net>
 <20190107164225.GA5394@agonzal-linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107164225.GA5394@agonzal-linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 04:42:26PM +0000, Gonzalez, Alex wrote:
> Hi Bastien,
> 
> >Given that we do have access to the datasheet, it would also be useful
> >for the patch to mention where in the datasheet it says that the reset
> >line can be left pulled-up,
> 
> The pin description table on section 4, on the "Reset pin" row, contains a 
> remark as follows:
> 
> External 10K pull-up resistor required, active-low reset
> 
> This comes from a newer revision of the datasheet though:
> http://focuslcds.com/content/GT911.pdf
> 
> I guess it's open to interpretation whether driving the reset line is 
> optional. The code seemed to imply it by using devm_gpiod_get_optional() to 
> obtain the GPIO.

They are optional in the sense that driver should work without them, but
if they specified we need both.

> 
> >or mention on which shipping device this
> >setup is already used (and if so, what the DTS or ACPI snippet that
> >declares those is).
> >
> 
> I am testing with an LCD application kit for the ConnectCore 6UL SBC Pro:
> 
> https://www.digi.com/products/models/cc-acc-lcdw-10
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts?h=v5.0-rc1#n120
> 
> This display in particular does not have the reset line available on the 
> connector. The only way to make it work seems to be to use the INT line to fix 
> an I2C address.

Do you have to use 0x14 address? Can you used the default 0x5d?

My concern with trying to do the address selection without RST line is
that it is quite unreliable, as it really depends on timings between the
chip reset, INT line being driven by the host and then being switched to
input.

Thanks.

-- 
Dmitry
