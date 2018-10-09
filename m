Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=1.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A16C64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F70B213A2
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 06:15:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FengMAMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F70B213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbeJIN2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 09:28:23 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44924 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 09:28:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id 63-v6so383206wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 23:13:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YD88qprnDrlarseP5uPXj49vRZjipGiZca8ogrXpD68=;
        b=FengMAMcFKc4Xoty98DaX72g1I9YSZ5sAvKf+7SYVVaRTkFynwTJbtR3jU4DAwapqo
         4UsPUvx+Qvq2kRxMla4S/2vwkMplioKxczVCIUEq7sGVW30P6wJdp4Poinqp7dE3lJy4
         6CCPNtLlzlVQ4iABbkfk8f/6j4esySk+SAGstYFA+8R1Tb9qHie9cLpYSaMIxp4S3HNm
         snh7/ERhIg3DiJepFMbJynA/itDyE7m2gLdpvVW6WLXk5rA+EYgIEFScaQDWwHHtx1H1
         1KiR3UcH8cXx63HAsPYHqUbqXRKRI7h8Ci8tUWIWLb6yzvUf3nyVZyhnKEmoRG+Q3t+8
         AGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YD88qprnDrlarseP5uPXj49vRZjipGiZca8ogrXpD68=;
        b=qeRwUIM3W+pmVogLMPWODWffcyRycf/0e9lFxtmyGutzJgfpdKhne7Z5AJm8QtOUuc
         Zw8gZJpuiIsYraGQozKpUM/LyrwoSlxxD6ipEqlZLcInxhT0vh7KgSiZlQ6APXwQ6+Pm
         8r92FL1Yn7igsDdEMg82V1Iry5oK4CwCkiJqmD+fK7EjwFnfYnHmiOkT/dCRFk+yXQw0
         NsCN3Oc+nNqkF1M5nIHQMBCeP2ZRpg7AnwILeStJECVAlor2KsqErPn0w6nDAZJ3x69U
         en0yxF89ArwfyI2suTlFh/0bp3wd8ScJI0F+YgXkui8JnySEdKcGynYZE4rHzJRpqM/8
         kGlA==
X-Gm-Message-State: ABuFfoiY7Itwn0jetlr6PvgmB0vA7OL64P/aWIb73+ZV/WWFh/eviemG
        8mT8cG55n6RW+EknpMnA2iXdVqLF
X-Google-Smtp-Source: ACcGV60zCrjy91jNmf5zl7XqeApqXHNsbf8V8NBEePMmF8X66LhC8KGBb6Y9C11Wu4FxoPjqmFB38A==
X-Received: by 2002:a5d:46d2:: with SMTP id g18-v6mr18090926wrs.185.1539065584211;
        Mon, 08 Oct 2018 23:13:04 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id j6-v6sm10447615wmd.29.2018.10.08.23.13.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Oct 2018 23:13:03 -0700 (PDT)
Date:   Tue, 9 Oct 2018 08:13:01 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: unwind_init() takes 100 ms
Message-ID: <20181009061301.GB116930@gmail.com>
References: <81a1ff79-b303-c384-f926-c9618afac8f0@molgen.mpg.de>
 <20181008173417.crlfndi3p5pevnx3@treble>
 <20181008173614.bchqq6unw65bc57x@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181008173614.bchqq6unw65bc57x@treble>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Josh Poimboeuf <jpoimboe@redhat.com> wrote:

> On Mon, Oct 08, 2018 at 12:34:17PM -0500, Josh Poimboeuf wrote:
> > > 4.  Would a command line parameter be reasonable `disable_unwind`, so people
> > > could decrease their boot time with distribution kernels, and easily turn it
> > > back on, when they need a stacktrace without having to rebuild the Linux
> > > kernel?
> > 
> > I think a boot cmdline option to disable ORC would be ok.  However,
> > disabling ORC would need to fall back to the "guess" unwinder.
> > Otherwise it would make debugging impossible.  That shouldn't be too
> > hard, but it would require restructuring the code a bit.
> 
> But I should also clarify that this option wouldn't be worth it.
> Sorting at build time is the way to go.

Yep, very much so.

Thanks,

	Ingo
