Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6DA4C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B636C2173C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj1AGEkk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728531AbfAGTyC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 14:54:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34024 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728226AbfAGTxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 14:53:35 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so652367plz.1;
        Mon, 07 Jan 2019 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=kMDRe+iyxuC6xlIrVWLEuvBWeTNckgs1iRV4IeKloMs=;
        b=nj1AGEkkoxpPib8kYSzr+EE6vdwRGnWWu8hZ+URxAwZvJkryPNlV87Wt9Z4zIx+W2I
         5RYhHbxj6skuc11JuBherctxM/0DZynDxziPIzQwoNz2b7BByl+pdt9n8GdDXnnWNk8O
         aO4X86KO2AqBbSLZA89XrrBpMiR3GaObOBpkuswOkAv7w/I9r4Q0lPTVRnwblw4dNs8b
         JTDG+/J+xYnowUjUqPmr0+XiqE/1Fo2TcGiFFyVuoAbTLu4LmKeMhC0Q/KzSRJM0Ci88
         ot8r6YkizgjtGhSLkEr/NxXOWv6pm5rHeRlxXW57Ro1q49kIZtMzA4CrO0+mmUSZ3nJf
         NSRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=kMDRe+iyxuC6xlIrVWLEuvBWeTNckgs1iRV4IeKloMs=;
        b=Vf2Xlkspvu3BIOefdLn1DQBQDvsKyRVvltBah8XEcNtxTHpb8v0U9XBdeWItA0P+ZM
         SFRAkOzLLStUBCkHc8ogq+6dqn7aiFzOG9hO1/qJS5ZF13w2yZ5N2iNPEK3ijzew88dH
         pYhpyeD8EHH4GJ2xChC6G4G4SLT5dcXUtJZh2LEVTp+3iwsTrqakn8rk6dJYBKVtB1yP
         OWnOnSzuhW2+r0OIQDJ+dpoaGhDMOpEqok8vbaXtUBJQ+iZ9eqQSslRZpUk76KAA6Cam
         RprZkfiqGZpjxabnf1/ENEyX7ET6J0a/YuoRVMlELnk215sd4cPUBoLdGNnsriwGibWe
         vDYg==
X-Gm-Message-State: AJcUukextD0AoafVcauabrMj4sZnWWPaXQIn77Fw3JZkIYMghCJEFRFO
        96WSZW2WlrGq6dWNc9yThgo=
X-Google-Smtp-Source: ALg8bN5HLB42rjYRiBMLZ4wMfJLCYmkhbSNO5kmtghA8LRP//ZkGcpDengNf44KISG95pQP9bDvcsw==
X-Received: by 2002:a17:902:1005:: with SMTP id b5mr62798205pla.310.1546890814269;
        Mon, 07 Jan 2019 11:53:34 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id m67sm130282924pfb.25.2019.01.07.11.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 11:53:33 -0800 (PST)
Date:   Mon, 7 Jan 2019 11:53:31 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     =?utf-8?B?UGF3ZcWC?= Chmiel <pawel.mikolaj.chmiel@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, xc-racer2@live.ca,
        simon@lineageos.org
Subject: Re: [PATCH v3 0/7] Input: tm2-touchkey: Add support for Aries and
 Midas
Message-ID: <20190107195331.GC141497@dtor-ws>
References: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190107185346.30184-1-pawel.mikolaj.chmiel@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 07:53:39PM +0100, Paweł Chmiel wrote:
> This patches adds support for Aries (Samsung i9000) and Midas (Samsung S3)
> based devices to TM2 Touchkey driver.

Applied the lot, thank you.

> 
> Changes from v2:
>   - Change property name from keycodes to linux,keycodes
> 
> Changes from v1:
>   - Added Reviewed-by to some patches
>   - Use ints for keycodes (they could be bigger than 255)
>   - Droped separate name changes
>   - Added missing const in few places
>   - Removed redundant cast
> 
> Jonathan Bakker (5):
>   Input: tm2-touchkey: Correct initial brightness
>   Input: tm2-touchkey: Allow specifying custom keycodes
>   Input: dt-bindings: tm2-touchkey: Document new keycodes property
>   Input: tm2-touchkey: Add support for aries touchkey variant
>   Input: dt-bindings: tm2-touchkey: Add support for aries touchkey
> 
> Simon Shields (2):
>   Input: tm2-touchkey: Add support for midas touchkey
>   Input: dt-bindings: tm2-touchkey: Add support for midas touchkey
> 
>  .../bindings/input/cypress,tm2-touchkey.txt   |   9 +-
>  drivers/input/keyboard/tm2-touchkey.c         | 132 +++++++++++++-----
>  2 files changed, 108 insertions(+), 33 deletions(-)
> 
> -- 
> 2.17.1
> 

-- 
Dmitry
