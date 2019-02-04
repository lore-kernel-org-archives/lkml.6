Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7A9C282D8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D60F2070C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549272142;
	bh=+2BwNSmPpCp7jn6DBtGE4O0IzYiegjR09ggBQR1kPKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bB4n/tVLBO0aWHHqf59p0QU3C1lyELcTEKfKNrhPJFtKTHfchm3Pf8XlIcA7g36R5
	 Y+EAsBWSCFq8pjCGwq4k5RVYywwUJtPU0wqggIoNPqDCc6lcMXU0lerraGmpm5USVW
	 tajdDEp98GEur9fNNnEqY6kEGh0QLi8uFAbQRTEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfBDJWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:22:21 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35165 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfBDJWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:22:20 -0500
Received: by mail-lf1-f66.google.com with SMTP id l142so1807732lfe.2;
        Mon, 04 Feb 2019 01:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=brRPXCD2jZcrrLhzRAwaT2u92Pni+2Pr+UuI2xoYGXo=;
        b=KPrhjc6u2IpI9NzCkmxbP1SmZhnSfYn42E4SpysCs+aEs4CVureY9+94xtgb0WAEVI
         Dgna7OGSEHo0yfNLFU2eFJH6VPPOgSTTqxHFi/dZuLXOH6vph/SO6ZYPBz1o4XBvhrmh
         c8GWKG1z+6oDfPGfzOkWr0tCjIb09ZfiFYjrVKl/nK9gioiOYnm3GsTbNGyFA89HPvS0
         i0vxn2zLHDH/czivj/xAjcj70f7rsUJ4Setcd6Vz3L6i9u+I+/WgC8VgmAfUboZtg1j4
         YUIBeuTfGz2/Tn84nXQQXp0A6+OXHddEFSVj9iA9sRmnP7p+hyHGo8DsksBoddWQRJyb
         Kk+w==
X-Gm-Message-State: AHQUAualVR460Y2SvzCGsY6wefs38khS1ZVZAiq67P79hG7x1xArkWAG
        n1nyWuz8U7Iv80rl0wNPQYk=
X-Google-Smtp-Source: AHgI3IYoyWWImArGIzOk1jQ66MqjAYCDnkKZ1j2iADFl6EDxxvQfFX4Q+fYbDzrAbBBvU5G0vJkG1Q==
X-Received: by 2002:a19:4f0c:: with SMTP id d12mr6253662lfb.121.1549272138787;
        Mon, 04 Feb 2019 01:22:18 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id m63-v6sm2895943lje.81.2019.02.04.01.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 01:22:17 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gqaSG-00054o-8x; Mon, 04 Feb 2019 10:22:16 +0100
Date:   Mon, 4 Feb 2019 10:22:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Myungho Jung <mhjungk@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190204092216.GC4686@localhost>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
 <20190203063823.GA8228@myunghoj-Precision-5530>
 <20190203105323.GA4686@localhost>
 <20190204072859.nrglf7pfj42itzh5@myunghoj-Precision-5530>
 <20190204090436.GA3711@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204090436.GA3711@myunghoj-Precision-5530>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 01:04:37AM -0800, Myungho Jung wrote:
> On Sun, Feb 03, 2019 at 11:29:00PM -0800, Myungho Jung wrote:
> > On Sun, Feb 03, 2019 at 11:53:23AM +0100, Johan Hovold wrote:

> > > You should add a Fixes tag identifying the commit which introduced each
> > > bug and a stable-cc tag. If you want you can indicate the version after
> > > a # sign, but that can also be inferred from the fixes tag.
> > > 
> > > For the hci_ldisc fix I think the tags would be:
> > > 
> > > 	Fixes: 2a973dfada2b ("Bluetooth: hci_uart: Add new line discipline enhancements")
> > > 	Cc: stable <stable@vger.kernel.org>     # 4.2
> > > 
> > > You can use git blame to track down the offending commits.
> > > 
> > > This should all be explained here:
> > > 
> > > 	https://www.kernel.org/doc/html/latest/process/submitting-patches.html

> I have one more question. The title of new patches should be version 3 like
> this?
> [PATCH v3] Bluetooth: hci_ath: ...
> [PATCH v3] Bluetooth: hci_ldisc: ...
> 
> Or newly start with [PATCH]?

You should keep and increment the revision number even if you split a
patch (so use v3 for the resend).

I suggest you send both patches in a series (as they are related); take
a look at git-send-email for a convenient way to do that. 

And always include a brief changelog (below the cut-off line, "---")
when revising patches.

Johan
