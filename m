Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02713C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8631205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547741389;
	bh=CJtIY4NEtj8gyPpZ/1gZzecu2raRHCvoTm6ctsKK5HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iy/zVlniAdz/ExivHCyheT9RKhHRGTOXMFQcv/QmFf226bSHioB5AfC9C386rdQu6
	 YEo3JXxNamTRN6ZxpdUS87NR0xtEFiBli1GUnrgw8CvYK6rGoR0mzD1LXjBKccd9bd
	 uN3SZLRxMS6a73WDmNfj6tndUQWLucbMZAxMm+54=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728758AbfAQQJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:09:48 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44907 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728448AbfAQQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:09:47 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so8197640lfe.11;
        Thu, 17 Jan 2019 08:09:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aBFxL++UnNFhQvpwhZyZGzmq0zLtiFgGOAfstxtcCAI=;
        b=Hpkpt/6b0lbnKXq+pBSEzLxogiUNvNZPkPYIZnNLqZsSfZTPd/gOahtJsnB34YOJev
         XgafkUwaOuIQUv4PTiLLiD2s3srE5lsKlJBy4MzHWB+CR/ZVc6lutMA+6fgAi2BwTcv9
         Ch742lUyPmGnjjJKp4jiVCkxHlSoH76YAXY5J8D4Tu5Dl/RcWsdHrmqvq6gsjrBW2/el
         bLhopJnJAx7CLmzSs+iUEhmU/woiFfIO0UB2FSRNQI/5wvc8x+WpzPmcStEArVksW3mt
         DkEWPz8Ga8izBlknNQLVJVUUsVxR76hdegCcXfHfwLGXA8KnxlZrwnLEZ0n1mks6y/aI
         Oe3w==
X-Gm-Message-State: AJcUuke+wI0rBHpw0knH4d0cIwLHBZR3ymO1mSdh7K0toEWGON1cILhp
        u5fiVPcV6ZzKTuYuCMRfLeI=
X-Google-Smtp-Source: ALg8bN4LLKx5wkBFUVzLxi2/M2Uqzc1kXLackZtiXwN6yUCgR/8brFLDtmhm3Jd6X35Uso6AhC2uVA==
X-Received: by 2002:ac2:554b:: with SMTP id l11mr10459668lfk.92.1547741385162;
        Thu, 17 Jan 2019 08:09:45 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w16-v6sm314749ljw.11.2019.01.17.08.09.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:09:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gkAEi-0007fy-Be; Thu, 17 Jan 2019 17:09:45 +0100
Date:   Thu, 17 Jan 2019 17:09:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Johan Hovold <johan@kernel.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190117160944.GV3691@localhost>
References: <20181220144639.15928-3-bgodavar@codeaurora.org>
 <20190109145224.GN14782@localhost>
 <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115234628.GQ261387@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 03:46:28PM -0800, Matthias Kaehlcke wrote:

> Using RTS seems|ed like a nice solutions, since it's the native way to
> prevent the controller from sending data, instead of doing some custom
> hack. However Johan seems to be fairly convinced that flow control and
> manual toggling of RTS can be problematic, and we have seen that
> disabling flow control has its own problems. Maybe it's time to
> consider other solutions like the DISCARD_RX flag we discussed
> earlier. Not that I really liked this custom solution, but in the end
> it might be a more robust way to address the issue.
> 
> Johan/Marcel/others: Do you have any further ideas or input on this?

I don't see why deasserting RTS wouldn't work, well at least as long as
the RTS signal is wired correctly.

My point was simply that calling serdev_device_set_rts() will generally
not work unless you first disable automatic (i.e. hw-managed) flow
control using serdev_device_set_flow_control(). The exact behaviour is
serial-controller dependent, but I assume the driver needs to be
platform agnostic.

Johan
