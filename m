Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532D1C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F1920820
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 09:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmNWMA8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbfBDJaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 04:30:01 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44293 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBDJaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 04:30:00 -0500
Received: by mail-pl1-f193.google.com with SMTP id p4so3252480plq.11;
        Mon, 04 Feb 2019 01:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vC0I2QcFWDt79wc3DJXbLipu30Hgu4Gh5A3UpGV1TkY=;
        b=FmNWMA8m9BxofLkORTNmr+OJycyzkFn4WzZo8S80gogSbJqXB7DH8OK8KlQkozkYHN
         PC9FQ2989+V5kkxCMyxDrLiVKfN6zoKC4HZN0Ueg+wSyQcQ4MPPOjmcMOhyo9s6Btx3N
         vqSANaZGFQ24AUr+y71mOP+9ynmcbnGgIJzU8NJphcHldCNwhuo16xP6+mItSyFt+V2O
         J13mE5nm3pjPyLpBIt6K6dbr+wTCjgtQ+Ul7CRscIh/ec0tT5ZFEDcrNXrZAD5WuiZTq
         /gz1RP8VycZeLhcNDsNPzHWStn3hMQn3Y2iIkQ1oD9Ml3Hhxdybm6xjYSDoFUftaX7ny
         VA+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vC0I2QcFWDt79wc3DJXbLipu30Hgu4Gh5A3UpGV1TkY=;
        b=G52UBZtDAV6B0Ab0M2EGUVBJ3G4M5XwqFyWMHDDBpti7W8ZSRXpa3C7RYps8v3NjdF
         Ha8ij6FJQqcL2gwj8ZBEVIM6KuV9t0BXznAAjUrhrOl3PRRdVl9q7t0rGHYVy+CtbVEW
         RfBAmpe1zkiQUxm5uw0Tf8xWc2/Bgx+mPba8vpZbcMIknMCDEP1sY0eC/vOEwLvgOZN4
         jMpXLBQIM6d/XFBT4BIYkO3yLBS7EbuyAGDtFHSq/nvmg6KLbZppRlrrUcMQsbvENPNe
         ZqRSzwmBMcdrokXIpJ/KozVN1pFzKbjcy8D2C4yH5UG6elNQHMuo5YxDhz6Dvgv1NXYQ
         epRA==
X-Gm-Message-State: AJcUukdpsPZQwal5Zs+i2RTexYdMFln7gN3kuw4t1qk0SvyUBHe1oe3w
        +Nb2/rXRAJEx0mzQ5DcEpeA=
X-Google-Smtp-Source: ALg8bN7mZ+JNZWqbjt/0d+1DR6rlUb4ScfhyZ+I7ueIEGxk0zZCYRghekeB8RZBLMqYZLAZodbv2HA==
X-Received: by 2002:a17:902:7791:: with SMTP id o17mr50125194pll.60.1549272600029;
        Mon, 04 Feb 2019 01:30:00 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-176-3-80.san.res.rr.com. [76.176.3.80])
        by smtp.gmail.com with ESMTPSA id 64sm21433470pff.101.2019.02.04.01.29.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 01:29:59 -0800 (PST)
Date:   Mon, 4 Feb 2019 01:29:57 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: Add NULL check for tiocmget() and
 tiocmset()
Message-ID: <20190204092956.GA31979@myunghoj-Precision-5530>
References: <20190130053925.GA26699@myunghoj-Precision-5530>
 <20190131154000.GU3691@localhost>
 <20190203063823.GA8228@myunghoj-Precision-5530>
 <20190203105323.GA4686@localhost>
 <20190204072859.nrglf7pfj42itzh5@myunghoj-Precision-5530>
 <20190204090436.GA3711@myunghoj-Precision-5530>
 <20190204092216.GC4686@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204092216.GC4686@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 10:22:16AM +0100, Johan Hovold wrote:
> On Mon, Feb 04, 2019 at 01:04:37AM -0800, Myungho Jung wrote:
> > On Sun, Feb 03, 2019 at 11:29:00PM -0800, Myungho Jung wrote:
> > > On Sun, Feb 03, 2019 at 11:53:23AM +0100, Johan Hovold wrote:
> 
> > > > You should add a Fixes tag identifying the commit which introduced each
> > > > bug and a stable-cc tag. If you want you can indicate the version after
> > > > a # sign, but that can also be inferred from the fixes tag.
> > > > 
> > > > For the hci_ldisc fix I think the tags would be:
> > > > 
> > > > 	Fixes: 2a973dfada2b ("Bluetooth: hci_uart: Add new line discipline enhancements")
> > > > 	Cc: stable <stable@vger.kernel.org>     # 4.2
> > > > 
> > > > You can use git blame to track down the offending commits.
> > > > 
> > > > This should all be explained here:
> > > > 
> > > > 	https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> > I have one more question. The title of new patches should be version 3 like
> > this?
> > [PATCH v3] Bluetooth: hci_ath: ...
> > [PATCH v3] Bluetooth: hci_ldisc: ...
> > 
> > Or newly start with [PATCH]?
> 
> You should keep and increment the revision number even if you split a
> patch (so use v3 for the resend).
> 
> I suggest you send both patches in a series (as they are related); take
> a look at git-send-email for a convenient way to do that. 
> 
> And always include a brief changelog (below the cut-off line, "---")
> when revising patches.
> 
> Johan

I see. I'll submit version 3 as a patchset with change logs.

Thanks,
Myungho
