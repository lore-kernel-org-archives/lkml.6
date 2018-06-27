Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9360CC43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 423902601F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 15:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekfWkQtP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 423902601F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965329AbeF0PsI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 11:48:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:38370 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934658AbeF0PsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 11:48:07 -0400
Received: by mail-wm0-f67.google.com with SMTP id 69-v6so5989470wmf.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 08:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ph0dpw/t2HzLPsG3iR2Ea9uIxwKcn39fmC/Zwn2JDcw=;
        b=ekfWkQtPmxzISWUqtBmLV1Mqj8IM2rqCm/4uX39bPdz/TyKz5d9wSfw7JpfOgBGRAU
         tQbS/36YCgraQP60ofEMXzruQOMww2nU1K0aj53WQQyc4z4HXZQJzH3+o7LuYkzwAQ+D
         vB+DN61fjwL+p0srTRp0dcqHvE947I03MChhCv646jSMxyT8FQA5f9MtAXPcULSk/I3F
         LEvaurtDtAVDZz7GYhbQFd4VVGwfdPYOejRoKmprl4ZSDNKoUADMuW0E580MGyPfySa6
         OEMmuJdgQ0bch1SanyAmqK6Na7Z6TQC4WBE3ePi5+WUP2oNgCjWxUR0yIQqDI80Acsc+
         DFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ph0dpw/t2HzLPsG3iR2Ea9uIxwKcn39fmC/Zwn2JDcw=;
        b=H1gCw5QE35sNF6h7/6brMzP/KiV+16c79plHO6GYcPVT8sA+eQsoIX7V+K09HKRj97
         eRqbqoTwYjHfjZ3QzIoP33XX9f4zaOmzuCQTLRjdVuwBe98U8TpEFbuZ4J4wR2JKB0CN
         mIonMpZ+62+jLw1JNwIh5E8U9jlIAJ8FUUryoDyIicEjewE3FQDV3+/R7TBjsYEvVRMO
         vrZR+uQOUwPcVbRVAjHQkvMiip6CGO/UtcSPHEKwotPB13NthI20qzsCyESEVEbNdBE3
         xN00x+f5RFPleDwEoB65d/hdyBq/KR3bm7yiSi6fcnF7juiSDEIiBEmjOI3u06NgBj+S
         4dog==
X-Gm-Message-State: APt69E09fton4lf5ChS4RQcW7qgVgRwtzgt4iDN1ZivvYofUsIrYig6O
        t4xyH0Rb3EEzObKBuH5x2RZXtO9m
X-Google-Smtp-Source: AAOMgpdTb9dJSkSiP3lfixYKCCQ1LEIAVdZmr4DSk1Vx8cuga1l4ZYPTLhmOdEf6jwYEzJ+OrSBGCw==
X-Received: by 2002:a1c:d482:: with SMTP id l124-v6mr5112857wmg.22.1530114485959;
        Wed, 27 Jun 2018 08:48:05 -0700 (PDT)
Received: from xux707-tw (host86-190-130-185.range86-190.btcentralplus.com. [86.190.130.185])
        by smtp.gmail.com with ESMTPSA id j131-v6sm7405102wmg.24.2018.06.27.08.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Jun 2018 08:48:04 -0700 (PDT)
Date:   Wed, 27 Jun 2018 16:48:04 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Justin Skists <justin.skists@juzza.co.uk>,
        devel@driverdev.osuosl.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Whitmore <johnfwhitmore@gmail.com>
Subject: Re: [PATCH v3 3/8] staging: rtl8192u: User memset to initialize
 memory, instead of loop.
Message-ID: <20180627154802.vnkyhl3yqfptzeq7@xux707-tw>
References: <20180624153454.27356-1-johnfwhitmore@gmail.com>
 <20180624153454.27356-4-johnfwhitmore@gmail.com>
 <CAHp75VegybTJJ8GruGORxB3NChgsEKN+kJF55UjU0OvP2svuQQ@mail.gmail.com>
 <20180625123559.pvjrpmbtk6z24uew@xux707-tw>
 <848175111.798938.1529931904819@email.1and1.co.uk>
 <20180625195025.xfbrlj7citq3qx6s@xux707-tw>
 <20180626035640.GA29538@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626035640.GA29538@kroah.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:56:40AM +0800, Greg Kroah-Hartman wrote:
> On Mon, Jun 25, 2018 at 08:50:26PM +0100, John Whitmore wrote:
> > On Mon, Jun 25, 2018 at 02:05:04PM +0100, Justin Skists wrote:
> > > 
> > > > On 25 June 2018 at 13:36 John Whitmore <arigead@gmail.com> wrote:
> > > > 
> > > > 
> > > > On Mon, Jun 25, 2018 at 12:06:30PM +0300, Andy Shevchenko wrote:
> > > > > On Sun, Jun 24, 2018 at 6:34 PM, John Whitmore <johnfwhitmore@gmail.com> wrote:
> > > > > > Replaced memory initialising loop with memset, as suggested by Andy Shevchenko
> > > > > >
> > > > > 
> > > > > Suggested-by ?
> > > > >
> > > > 
> > > > Em, not sure how to respond, it certainly wasn't my idea. I was just making
> > > > coding style changes, badly. ;)
> > > 
> > > Suggested-by is a tag for patches, to give credit. For example:
> > > 
> > > https://elixir.bootlin.com/linux/v4.18-rc1/source/Documentation/process/submitting-patches.rst
> > > 
> > > See section "13) Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:"
> > > 
> > > Hope that helps,
> > > Justin.
> > 
> > Oops... that helps thank you. I have to re-read that document, it obvioiusly
> > didn't all sink in :(
> 
> I've dropped this patch, can you fix it up and resend?
> 
> thanks,
> 
> greg k-h

Yes I'll resend this patch, sorry about that error

jwhitmore
