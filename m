Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05C2C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D6020817
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 12:15:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aJqDSz9k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D6020817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbeKZXJj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 18:09:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34455 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeKZXJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 18:09:39 -0500
Received: by mail-wr1-f67.google.com with SMTP id j2so18680491wrw.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 04:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EEQ9MLsJJrgUVklI24gqIJ0evDEG6Ie67bJ8rjOToHs=;
        b=aJqDSz9k39sSaV7wVyGyXG6d/p7T510XVaLN3mdQGe6vH1NLv2qpsaj45y51nd+P0D
         EIHof8pL8ByevgIe42eWt2YOq/McIC5YJvaeEmkJr/eT6EMkcvgfTUxi5GkjiTkqdlBK
         95JJ529EI7ZfFGP8wYXAv0mfBHM7zP7Ltt6bg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EEQ9MLsJJrgUVklI24gqIJ0evDEG6Ie67bJ8rjOToHs=;
        b=MVcp3yWSSTtYH9aJWVQQqrrqZQEeIov+euCfmetk6d21G52NJhWqXRESZTsS7hfWk1
         9TsmNY4XdLSOyzK81HAAlpacveMIArQWQ66fJhTLvMH1pDb7AZUlDIjZ5QEDvOBFF38I
         lm89gTCCg+Ox8ThG6lYplKOMgW3E1pa7XCLkxmFp3EOYcZsm6zgGCVkmsErf5J0L8dTX
         Fvlcw1eUTOZx5j9iybBHSbYT0tBRsr2+rfx/eyp/uoae8pATkNcLXn2tX9uqA2Xv85Ev
         OnWNsLE6yAyyFCZ42QI5TTl8PYuA6uYolsITJWRGoIjbJlw5FvSd/BoDej2TRpDypO1r
         vUww==
X-Gm-Message-State: AA+aEWYxVQYCUl78vyHQUZIx3E95SFod7y2+iuqjMDKdlZRCpohcEh6v
        6Vemnt8E1HkzCPYB1I7ub+Ihug==
X-Google-Smtp-Source: AFSGD/UI82Iz3HyZE51Jg42tfeFVHRZ3HWyAv2W7qH/Z9o2VjqgnbJv9CzktwCfJMrxOK92rCf0sCg==
X-Received: by 2002:adf:9bda:: with SMTP id e26mr12421639wrc.295.1543234539337;
        Mon, 26 Nov 2018 04:15:39 -0800 (PST)
Received: from queper01-ThinkPad-T460s ([217.140.96.141])
        by smtp.gmail.com with ESMTPSA id 6sm820704wmk.26.2018.11.26.04.15.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 04:15:21 -0800 (PST)
Date:   Mon, 26 Nov 2018 12:15:19 +0000
From:   Quentin Perret <quentin.perret@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org,
        Chris Redpath <chris.redpath@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V3 2/2] base/drivers/arch_topology: Default dmips-mhz if
 they are not set in DT
Message-ID: <20181126121519.gnui3asd5pud5p3b@queper01-ThinkPad-T460s>
References: <1543221866-19671-1-git-send-email-daniel.lezcano@linaro.org>
 <1543221866-19671-2-git-send-email-daniel.lezcano@linaro.org>
 <20181126095224.i5se3n5lavww4a2n@queper01-ThinkPad-T460s>
 <97f85a4b-efb6-b26f-94d0-cd538c83a03e@linaro.org>
 <20181126101955.pdn76f2ujeb6urxz@vireshk-i7>
 <20181126110915.372tanwevpfcr7zp@queper01-ThinkPad-T460s>
 <44e471b6-d58c-310a-0883-bf9f444ddcce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44e471b6-d58c-310a-0883-bf9f444ddcce@linaro.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Nov 2018 at 12:36:31 (+0100), Daniel Lezcano wrote:
> On 26/11/2018 12:09, Quentin Perret wrote:
> > On Monday 26 Nov 2018 at 15:49:55 (+0530), Viresh Kumar wrote:
> >> On 26-11-18, 11:08, Daniel Lezcano wrote:
> >>> On 26/11/2018 10:52, Quentin Perret wrote:
> >>>> Maybe you want to test 'if (!raw_capacity || cap_parsing_failed)' at the
> >>>> top of topology_parse_cpu_capacity() ?
> >>>
> >>> I prefer to update the documentation, it makes more sense than adding
> >>> more cumbersome tests in the current code.
> >>
> >> +1
> >>
> >> Throwing an error and ignoring DT number completely for the capacity
> >> are good enough in my opinion as well.
> >>
> >> And who cares for the platforms that can't even fill the DT properly :)
> > 
> > Right, I think we all agree the case with a partially filled DT is
> > broken. I don't actually care too much about the behaviour in this case,
> > but it needs to be consistent with the doc.
> > 
> > So, as long as you fix the doc, that change is fine by me :-)
> 
> Ok what about the following change ?
> 
> "
> 
> If capacity-dmips-mhz is not specified or if the parsing fails, the
> default capacity value will be computed against the highest frequency,
> it will result most of the time on the same capacity value.

That "most of the time" sounds a bit odd no ? Maybe mention explicitly
the case you're referring to (that is when all CPUs have the same max
freq) ?

> However on
> some platform with different OPP set but the same micro-architecture,
> the capacity will be scaled down for CPUs having lower frequencies.
> 
> "

Other than that LGTM.

Thanks,
Quentin
