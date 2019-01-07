Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB7D7C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD7C2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdToh3wb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728269AbfAGRkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:40:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:35887 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728229AbfAGRkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:40:37 -0500
Received: by mail-pg1-f195.google.com with SMTP id n2so447449pgm.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jan 2019 09:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=drbN1pN+UO6JfPjXIUI7eX4GQF3buWvK8fmB7RQN4h8=;
        b=pdToh3wbX698UsiYM8emd+pM/JqXJab3wl3AE60NOsbiVkedXqbLy6T6lxWJy40AEu
         E9K76gd+nvYcjl1SBDxFlThdRk7/bvFfH1132oPLlasA2YLYzmwI0+AuR1q6AkG5TMSi
         NI6xUM53mZT5/Bk+T73MAEVENNNsKkowDYKObwSm0EnuGC+f3lS3KP1q/pBkDTaQBoft
         eBi4VxrqjjNl4AZ+BNou9eZRxcd+tbQSrV+liISFqpGJsacxXehPKRNuTMpFVHfKEUSD
         S5uELPrEQi6paDiDeyTjtSZCO1EtLLwbOz/MpiJpht7EeD2fRhMDWs/1bNwTBxo3RV0f
         3wHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=drbN1pN+UO6JfPjXIUI7eX4GQF3buWvK8fmB7RQN4h8=;
        b=E1bQIxyOf4w+SQDwLuGVB6ctqHTNGWFsH1rxk3rwVLOhAa0oKGQRusfQW7/wDg5txs
         SAmBphElBy7S2gvshQV3tnYCn9aVQnPZ7zUPFBsbTQagudetn22xq9XbUX4ANlwKiRud
         Bo88mH+Q0/Mr9pkd8+82f/Okh0wywAxAwpWRO2qpFQ/WVJBmnVtdDyugTfZ65KCEyBo9
         6fogD20jBKF2fN3tRl8BDHdPHKBi0xrOH/g4MWlg0QYgWbllhQmBD3hIwD5L3jKCcfjN
         YQiBfTgJ7z05vhBImeTfy2ZSBG2n06AiuevxE/UMpwczB3h2i8PwdQXtGRGPmcnobPlx
         JtTA==
X-Gm-Message-State: AJcUukdqNhDenpupc6CRTUuD4XwKTwnYz5mtJTjLX07d2AotdXydKso2
        ySRlt3zCprf9p/fGrmlxRdjvqSzOCzM=
X-Google-Smtp-Source: ALg8bN4gtej9O+me4he4RCopuHqyUvl3cr7SDsZtsaSqHtj2bLt6VPmnZmlDNNRHMXkxGusBnD40PQ==
X-Received: by 2002:a63:2507:: with SMTP id l7mr29372801pgl.22.1546882836297;
        Mon, 07 Jan 2019 09:40:36 -0800 (PST)
Received: from Ideapad-330S ([49.206.13.149])
        by smtp.gmail.com with ESMTPSA id d129sm102010061pfc.31.2019.01.07.09.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 09:40:35 -0800 (PST)
Date:   Mon, 7 Jan 2019 23:10:30 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: tlv320aic32x4: Kernel OOPS while entering DAPM
 standby mode
Message-ID: <20190107174030.GA12944@Ideapad-330S>
References: <20190102170633.GA9724@Ideapad-330S>
 <20190103124554.GS1846@sirena.org.uk>
 <20190103193421.GB18413@Ideapad-330S>
 <20190104164040.GA10873@Ideapad-330S>
 <20190105044622.GA14481@Ideapad-330S>
 <20190107125907.GC9570@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107125907.GC9570@sirena.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 07, 2019 at 12:59:07PM +0000, Mark Brown wrote:
> On Sat, Jan 05, 2019 at 10:16:22AM +0530, b-ak wrote:
> 
> > 
> > Hi Mark,
> > 
> > Fixed the build error.
> > 
> > Thanks,
> > Bhargav
> > 
> 
> Please submit patches following the process covered in
> submitting-patches.rst, don't send them as attachments to replies in the
> middle of threads.  Doing that confuses all the tooling for handling
> patches.

Ok. I made a mistake while sending it with Mutt.
Will be sending it inline now.

