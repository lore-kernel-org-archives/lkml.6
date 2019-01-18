Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F17C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71BF82086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547804661;
	bh=plVoBg5/nSGmBbaNdNHKt9EilBsqNWFEdPAHVHIN6mM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bKm3J4STRWZej81zHdMvTu/gQuh18E1tEYUhwxCnGwSoB5Yzpxp4+Ga2fHNAvnR/c
	 PScAL1m6JffcmZT3Boc68H2MuxUfqAW9Ix3RI5/Bork3In6IbzfCSM3wrOoKb0RuPX
	 xEWKHPCcCO59gxBC0iLDgr8fAvFz9TvB8xwzQNHE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfARJoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:44:19 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45628 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726288AbfARJoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:44:19 -0500
Received: by mail-lf1-f66.google.com with SMTP id b20so9986402lfa.12;
        Fri, 18 Jan 2019 01:44:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DbNcV5FxgSD+yvWgMWS7YwD0GBsATUSU5Aw9ZdWgggE=;
        b=hdItBB9+EfQ5NEnXuztEWnUwENTHXYats8ctgH3RtU6X2uguFpOLTvnNiut38tko9e
         5BdYsXoEMSUM5WsIp38nUOQeGR8/Khnl0ItijExfeyFK6snvWAxXlrZJQn2McdDAqgGF
         e07WtRwxB3H7X1ozCtQwETMGwRPubRoJfMN0C8dtLFxqJzdJeXJ8EAhj70zV+9BYUvDM
         SAmMSgNJZJtfuzYvMpWBMOybCYQQ1UFCjA/ueFZNx/xlTHybV3F6aS2DLwOCt5zUlIIv
         2m+CdCRfDb/CS00g/t619caRUhuNglbTpa4fCAD3yp5JK5R5fqLJvkwQSnbazP6gxthV
         1Cew==
X-Gm-Message-State: AJcUukf1+LY7q4baubxugcPM5/eD75Ai5MgsNCN9A86WqjOdpz2g4LRO
        BY2KMGs3SpIFvMAuCPvJRuU=
X-Google-Smtp-Source: ALg8bN6u0hKWS5qNTcg1WWHpL34BIDtX0OHA1pfnwfN6P2Zw7cV1ZyzGs6KvBh3H4NBpahDoumsTyQ==
X-Received: by 2002:a19:5059:: with SMTP id z25mr7866757lfj.120.1547804656864;
        Fri, 18 Jan 2019 01:44:16 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i75sm723308lfb.58.2019.01.18.01.44.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 01:44:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gkQhE-0000ui-SJ; Fri, 18 Jan 2019 10:44:16 +0100
Date:   Fri, 18 Jan 2019 10:44:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH v5 2/5] Bluetooth: hci_qca: Deassert RTS while baudrate
 change command
Message-ID: <20190118094416.GB3691@localhost>
References: <b5160d8862b49f0369fa58610516d354@codeaurora.org>
 <20190110143928.GE3430@localhost>
 <61301df80bd6a8ee0265b31b7f6a3aa1@codeaurora.org>
 <20190111013707.GD261387@google.com>
 <194b5d18ea86830b6a24939d483a964c@codeaurora.org>
 <20190111235633.GK261387@google.com>
 <a6e083d245baebc019b6e7163fd6f133@codeaurora.org>
 <20190115234628.GQ261387@google.com>
 <20190117160944.GV3691@localhost>
 <20190117172109.GU261387@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190117172109.GU261387@google.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2019 at 09:21:09AM -0800, Matthias Kaehlcke wrote:

> I observed that the qcom_geni_serial driver doesn't raise RTS with
> flow control disabled. It seems we have to investigate why that's the
> case. I agree that the driver should be platform agnostic.

Sounds like a driver bug, unless the hardware is just "odd". The
driver implementation of this looks very non-standard judging from a
quick peek.

In fact, qcom_geni_serial_get_mctrl() is currently a no-op if hardware
flow control is not enabled:

	if (uart_console(uport) || !uart_cts_enabled(uport))
		return;

Perhaps dropping the !uart_cts_enabled() test is sufficient.

Johan
