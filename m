Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA89C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68BBA27D5A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 12:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOZLtlPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BBA27D5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965095AbeF2MJX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 08:09:23 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34012 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbeF2MJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 08:09:21 -0400
Received: by mail-lf0-f68.google.com with SMTP id n96-v6so6641325lfi.1;
        Fri, 29 Jun 2018 05:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GD4YhNaObm/KN1SiCinDT1u5FOtGli7nqxeK+NbhMFc=;
        b=cOZLtlPXKNagPOQli+BIeK6x8aunFXI4zye+imWSNJ03hdc6PGdc46Fl1Ixzy+Q0R8
         03XPdoCQP9s9Zv+9m3lHkVi7UKCHlTD+iLfGQUOwIOaF1EU6Fl8yvUlFRl1Wt+a2pxxd
         TkMq5GNjSarKtUpUns9ZCcyBaZ34irVWCcRoD9u3pQ+nAvxIAnAUwaUSEWWzdmjgiI+o
         ZKdyQUHR89NhqUdxORN53jrK7cL6etuIB++tuozwwj9KQKIl+nwjRu/JNLfFp4/c9Ryo
         lCB8wf4+4uxy9DuDyEWBiMjeVBsY+Z6sIH0dAph3UJpuXc9661Liq84q8LJGV/QZZGQe
         ndyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GD4YhNaObm/KN1SiCinDT1u5FOtGli7nqxeK+NbhMFc=;
        b=FIHR32HK2utV2tijtTH83oAYmQYU91BqMtiHtY8ThtXDnxUid+gPOysoGxo2/8La80
         oNaZ5FgTTY04blOAL+Ub10sEbBsnaiomWKhBqHGG/y3SJVyRvCzF7UNh19KMKJJo6jfc
         SQtVLzbP6XrnsSpE5Q0dATtUkZbN7/XSd1oH5ZPaMfd2KUAFdpcjm0z3P48yUu4pvipp
         V/L+L3MzkbfMcNeHZ/64OVAxWVLnJGu0EM/RSYJcnIuv56hqt1GBWD2ZEYle49nVCEhg
         xG1hV9DiROi0eugxvrfUiUzWXVIYTePkriYEpiWRMNy5ZcQ19B03QLMNtsZhabLf1d7S
         rHsw==
X-Gm-Message-State: APt69E1yvcgMSZsLoTxqzec4OG9LkOi9sPcwII97rPktEgTO1rl/m4MQ
        CPmEJFsIg2ji358LO/qI3tA=
X-Google-Smtp-Source: AAOMgpfechK3YICLPzwDDuCF0ppLMJrY9ho16GSiI24/kRpFVkhYNgDewExa/KFRl5Xj7i+Mk119Wg==
X-Received: by 2002:a19:c403:: with SMTP id u3-v6mr9289481lff.87.1530274160330;
        Fri, 29 Jun 2018 05:09:20 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id y67-v6sm1516378lje.74.2018.06.29.05.09.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 05:09:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fYsDC-0002eQ-Sh; Fri, 29 Jun 2018 14:09:14 +0200
Date:   Fri, 29 Jun 2018 14:09:14 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        alan@linux.intel.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . Nikolaus Schaller" <hns@goldelico.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Sebastian Reichel <sebastian.reichel@collabora.co.uk>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/8] gnss: add new GNSS subsystem
Message-ID: <20180629120914.GA9802@localhost>
References: <20180601082259.17563-1-johan@kernel.org>
 <20180628120103.GA28131@kroah.com>
 <20180629094607.GC31718@amd>
 <20180629114646.GU629@localhost>
 <20180629120554.GA2477@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629120554.GA2477@amd>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 02:05:54PM +0200, Pavel Machek wrote:
> On Fri 2018-06-29 13:46:46, Johan Hovold wrote:
> > On Fri, Jun 29, 2018 at 11:46:07AM +0200, Pavel Machek wrote:
> > > 
> > > > > Finally, note that documentation (including kerneldoc) remains to be
> > > > > written, but hopefully this will not hinder review given that the
> > > > > current interfaces are fairly self-describing.
> > > > 
> > > > This all looks great.  Thanks for doing this work and adding a new
> > > > subsystem for something that has been asked for for many years.
> > > > 
> > > > All now merged in my tree, nice job!
> > > 
> > > I don't think discussion was finished on this one.
> > > 
> > > In particular, we agreed that /dev/gnssrawX would be better device
> > > name, so that we still have place where to put proper abstraction
> > > layer in future.
> > 
> > I did not agree with you on that. I said we could consider that name if
> > this was to be changed at all, which I do not think is necessary for
> > the reasons spelled out in this thread.
> 
> So, again: there's nothing gnss specific in those patches. It does not
> know about the format of the data passed around. (Best you can claim
> that somehow data flow characteristics are unique to gnss.) And this
> takes namespace needed for real gnss subsystem. Please don't do it.

This is the real gnss subsystem. Get over it.

Johan
