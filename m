Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 30292C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1823208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:34:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi5NHV2F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1823208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755329AbeFNNeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:34:08 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35744 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755275AbeFNNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:34:05 -0400
Received: by mail-lf0-f67.google.com with SMTP id i15-v6so9474805lfc.2;
        Thu, 14 Jun 2018 06:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Vnu1VzYJPQ6Xab5xfV/A7VGE7e1uEFgKL4yvJopjTTw=;
        b=Mi5NHV2FD/NuHiA5HQvfCGElggIgijq3kGL7C9oWQrodraLZJIKLK4pHLecUh1ndEf
         3goICWDIfBkW8EX1HpY3zVLcl9htJFhHOcFUbIwlaVXwOV0X7gkeBeC2SQSAqVhm1X+v
         UKUwReL51zy9FTq0m7uwH2ajxvcnDElCsxpxTAph+ynEOizVmBzUzPlWPNA43mk1qo6B
         W/jX4Ut6H+24wY6yBvyTpRHQEuSRtul7dH9wD0BQQ+haMGWdRIbdEc1g+aSxP6wV7cKw
         LZWHeJ/+Egxc4B+Y8YwLL07Qfvzzgq3hkFxMnkrx+2CYCT12kMfareMdYgPuSXXGTw4L
         2K6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Vnu1VzYJPQ6Xab5xfV/A7VGE7e1uEFgKL4yvJopjTTw=;
        b=V2eTB2ATsHtdTv7boPDoERQPyVQRSLDiz7XU6IBSGCLpWGSNsgGsgeJG84VBV32quq
         UVD3Rfu8s9LruFKwLV3Gk6SmL/s1nc3tMmvZmCKC3UDVAPtGqJz/bQwGhS2tP8J0I6IB
         j9d+MWgUmxb9Jt0EdDZ7Udjth0ekQiRzKDl/eHysK6JUtkxicjqiIBcEA9c+5tU1q3ma
         nB8WfA5mCGKV25sZsOoxqCiIdij80p6KHNf6zVu3ciRFEXnJd4qDU/cyNYeE4ekQAEFv
         9pF53fF7/6VXmWHrQtGDHbpUB+u/aFqPt34hORCvGHvRZGDSX0Lt4oJcdFdiF+9ED59u
         fgVw==
X-Gm-Message-State: APt69E0YfAG1NXVfWvtL/flmor3dMw0KHIvgV07JYAU9j7Wfddc5mWDH
        TVZsiH8XeoTAxjzi+meQBkI=
X-Google-Smtp-Source: ADUXVKJlY/qDiUmdzTLvONtqPTjayx+t4B3hqCiEnMqelGkvCdHV4/3YP/u72zborkUHg4XlJBcsXQ==
X-Received: by 2002:a19:c90d:: with SMTP id z13-v6mr6408212lff.0.1528983243984;
        Thu, 14 Jun 2018 06:34:03 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id n19-v6sm951372lja.32.2018.06.14.06.34.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 06:34:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fTSNh-0003IE-4d; Thu, 14 Jun 2018 15:33:41 +0200
Date:   Thu, 14 Jun 2018 15:33:41 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 00/19] Dynamically load/remove serdev devices via
 sysfs*
Message-ID: <20180614133341.GD32411@localhost>
References: <20180611115240.32606-1-ricardo.ribalda@gmail.com>
 <20180614104820.GC32411@localhost>
 <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPybu_0TSdQFOL1ptv67-aKktAftYWPwnSnevmBd_b1T0W7LYg@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 14, 2018 at 01:06:59PM +0200, Ricardo Ribalda Delgado wrote:
> Hi Johan
> On Thu, Jun 14, 2018 at 12:48 PM Johan Hovold <johan@kernel.org> wrote:
> >
> > Hi Ricardo,
> >
> > On Mon, Jun 11, 2018 at 01:52:16PM +0200, Ricardo Ribalda Delgado wrote:
> > > There are some situations where it is interesting to load/remove serdev
> > > devices dynamically, like during board bring-up or when we are
> > > developing a new driver or for devices that are neither described via
> > > ACPI or device tree.
> >
> > First of all, this would be more appropriately labeled an RFC as this is
> > far from being in a mergeable state. Besides some implementation issues,
> > we need to determine if this approach is at all viable.
> 
> From previous conversations with Greg it seemed that RFC labels was
> something to avoid, but I do not mind reseding it as RFC on v3.
> 
> http://lists.kernelnewbies.org/pipermail/kernelnewbies/2018-March/018844.html

Yeah, Greg uses that to triage his insane workload, but RFCs still have
their use (and are still mentioned in submitting-patches.rst).

> > Second, I wonder how you tested this given that this series breaks RX
> > (and write-wakeup signalling) for serial ports (patch 19/24)?
> 
> I have a serdev device (led ctrls) that is dynamically enumerated with
> something very similar to:
> 
> https://github.com/ribalda/linux/commit/415bb3f0076c2b846ebe5409589b8e1e3004f55a
> 
> and then I have a script that does adds and removes. For standard
> serial port I was not testing the data path, just that the ttyS* was
> enumerated fine.

Well there's more to serial ports than just enumeration, you typically
want to send and receive data as well. ;)

> But  yesterday I believe that we found the bug that you mentioned and
> we have fixed it (check end of mail). I will patch the series and
> resend after I get more feedback and also implement what Marcel
> suggested.
> 
> WIP is at
> https://github.com/ribalda/linux/tree/serdev3
> 
> Besides this bug, we have used the new driver for over a week now with
> no issues.

Hmm... No issues when not testing the main functionality of serial
ports, you mean?

And there are more issues with the series which are less apparent than
the rx (and partial tx) regression.

> > Third, and as Marcel already suggested, you need to limit your scope
> > here. Aim at ten patches or so, and use a representative serdev driver
> > as an example of the kind of driver updates that would be needed. It
> > also looks like some patches should be squashed (e.g. the ones
> > introducing new fields and the first one actually using them).
> 
> >
> > > This implementation allows the creation of serdev devices via sysfs,
> > > in a similar way as the i2c bus allows sysfs instantiation [1].
> >
> > Note that this is a legacy interface and not necessarily something that
> > new interfaces should be modelled after.
> 
> I would not consider it legacy, it is the only way to use an i2c
> module without writing your own driver and/or modifying ACPI/DT table.

It's legacy as in old, and to be used for one-off hacks and such. But
sure, that is also what this series aims at even if that doesn't mean
you *have to* copy the interface.

> Author: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
> Date:   Thu Jun 14 11:30:27 2018 +0200
> 
>     serdev-ttydev: Restore/change ttyport client ops

Yep, you found the source of the broken serial port rx/tx.

Johan
