Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C468C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AFB20652
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 16:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547741615;
	bh=8DlHyi7j/WhNSwFRlTN/q6/L732oeHbySmwAvQQg4bk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iQtr/TeoMVc9HTxeAKgwqT8GbVQ7Ioio5D3OuusGQTdPY2bslaxUE2spSMmdaGTqY
	 bEp56MTJPGnPiCpv5ScdrDfB6bFKm+FUfWoUr4IDOfSl+GnweQ3aaRYLDOa/ISWC1t
	 P5lJ1xyzjUpGvO85aA5ZwG15EXd06AkgzylOd1Uk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728832AbfAQQNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 11:13:33 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34456 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbfAQQNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 11:13:33 -0500
Received: by mail-lj1-f196.google.com with SMTP id u89-v6so9069676lje.1;
        Thu, 17 Jan 2019 08:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xrf4OgcoX/o8KoO2sZMtl9mUjSQNkr86QqteBtAC5f4=;
        b=n7taBPQs+wOohr+lL9OZ/ZH45p744p8/+l76ktdonAKa1fOPv4GrDqxvuU9j/MPn+v
         sZDuFq/z7JlKORDhPk/04phJAXcitlZMx7q81iSoOxmmaqDGeL/gMXcP65YrFLPqWR75
         HUPXS/6rBaC+DntN/k7lqhGC1teyJ7O2w2ZYWcS5WjINEQPespHzbqlhF+sRWYUVouHd
         132urDjjt2K7AsjW7QAgbbVtJHm32ePm12QRlQ9sYf1ajILIjTpLB6sIBNWVAT31iQRF
         J21d0FMwtJsq4P+Rie8Hj9vCsUV5cGh7RnsArLuLUr8P7a2Nl+TUXUPgaIx+OuWvIotN
         0FXw==
X-Gm-Message-State: AJcUukfRLbUGmk7E5fxu5lXLsNdsWAIQykvRDw3bqlBaEeSz7DTfsbBb
        7UijlGp1E/n8WBBwZjzSnlxibL6K
X-Google-Smtp-Source: ALg8bN4Aes8gNUBMOog9w7Gvl/r5UnsXLMFZn6FH/BFZ3C2Ivj9QK0gefXEcJQXt3mvMgEut7tCCPw==
X-Received: by 2002:a2e:1bc5:: with SMTP id c66-v6mr9965409ljf.96.1547741610877;
        Thu, 17 Jan 2019 08:13:30 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id a2-v6sm309658lji.13.2019.01.17.08.13.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jan 2019 08:13:29 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gkAIN-0007hM-17; Thu, 17 Jan 2019 17:13:31 +0100
Date:   Thu, 17 Jan 2019 17:13:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>
Cc:     Matthias Kaehlcke <mka@chromium.org>, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v8 1/3] Bluetooth: hci_qca: use wait_until_sent() for
 power pulses
Message-ID: <20190117161331.GW3691@localhost>
References: <20190116114603.500-1-bgodavar@codeaurora.org>
 <20190116114603.500-2-bgodavar@codeaurora.org>
 <20190116202253.GS261387@google.com>
 <482d8987d38f60dae1844bc30050cd06@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <482d8987d38f60dae1844bc30050cd06@codeaurora.org>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 03:55:17PM +0530, Balakrishna Godavarthi wrote:
> Hi Matthias,
> 
> On 2019-01-17 01:52, Matthias Kaehlcke wrote:

> >> -	/* Wait for 100 uS for SoC to settle down */
> >> -	usleep_range(100, 200);
> >> +	serdev_device_wait_until_sent(hu->serdev, timeout);
> >> +	/* Wait of 5ms is required for assuring to send the byte on the Tx
> >> +	 * line and also for the controller to settle down for the received
> >> +	 * byte.
> >> +	 */
> >> +	usleep_range(5000, 6000);
> > 
> > I incorrectly claimed that there might be still bytes sitting in the
> > UART FIFO when serdev_device_wait_until_sent() returns, Johan
> > corrected me on that (thanks!). So if it takes the SoC 100us to settle
> > down we should be good with the original code.
> 
> [Bala]: sure will revert, i think he commented that wait_until_sent()
> will only guarantee circular buffer is empty. if wait_until_sent()
> guarantee us that the data was transmitted from the FIFO, then 100us
> will work.

No, Matthias is correct; I claimed that the UART FIFO will be empty (at
least as long as flow control is disabled, otherwise it may never empty
and we therefore also have a time out).

Johan
