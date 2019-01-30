Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07DFC282D5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 651D72087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 09:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548839084;
	bh=uxpJVxlPQyJt3ObitPVVSU54MtnXPL6Ze1MKUaS5U1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=i3TI/5LvAVDYitTEAEiXDaeYNhsb9nIbE4Bit2vEupXzLLcc0qUf1EAC8hyljXbtv
	 ABOOV+zg4dA3S5mzsvmHIeqITMpiLuWAmiYhh21G42PVotfmmge9bBhJiZeuwY20pA
	 V6nJnvUK8m9uNEWIYkK5FRDodoo/gMxkMre4ttC0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfA3JEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 04:04:42 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44935 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726577AbfA3JEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 04:04:41 -0500
Received: by mail-lj1-f195.google.com with SMTP id k19-v6so20001927lji.11;
        Wed, 30 Jan 2019 01:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QoQZ4GgYDj6n1gU/ce6Vzp9QRl1ywletoyNIgYo5xQA=;
        b=Wv4M9qTqeKYemMI5Eqzq+Shj3bxFlkZz474FvEKe+lc+YzS0yrXws3MseVmPE8k9sx
         hrRn58wcdZKtYNJ4v9XZKlLNyNWTogRkV1lc3GyNILBXahO/OC+Bv3MpBzVlL7K620lx
         esvjYo1AxdREbZZGYnEpPyjoUD23odQLnBkAvIEmfdpYzL1d7Ecnq0yLynoCHwjoCkp5
         zBvLjdMJQS/NNLmCCtw4QxPw2Fe8tebLum0rwJvhrM/aAwdOX/xPcNA6CClYB6ujyTnF
         ycM6kHASpV6OlTn/9hF4qIpvn8VG8WGyJXz0jljxSvAFvXQFdvq5LM6gzJH0fCa+MHCN
         u7kw==
X-Gm-Message-State: AJcUukdiUD4XsTNPMMCkoMTvw2GoR7eGe3uKIIEitbvbhiSQr7xdUv14
        iroUJQPza+SDsTj/uHVq4c4=
X-Google-Smtp-Source: ALg8bN7o+DNTYloG6hh4Yda/Xc30ii/kbCW2ZO+SLY6Cr2JycyLXMUMP+irG1OHU7lZmGcLKQCngoA==
X-Received: by 2002:a2e:9017:: with SMTP id h23-v6mr22475613ljg.71.1548839079231;
        Wed, 30 Jan 2019 01:04:39 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id h85-v6sm171415ljf.68.2019.01.30.01.04.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 01:04:38 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1golnO-0000un-GH; Wed, 30 Jan 2019 10:04:34 +0100
Date:   Wed, 30 Jan 2019 10:04:34 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH v2] arm: dts: gta04: add gps support
Message-ID: <20190130090434.GM3691@localhost>
References: <20190129073843.14979-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129073843.14979-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 08:38:43AM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v2:
> - some s/gps/gnss/
> - not added vcc-supply because the regulator is not modelled
>   in dts at all

I strongly suggest not sending revised patches before people have a
chance to comment on your previous version and resolve any issues that
may have been raised.

Also it is customary to CC anyone how bothers to help review your
patches.

Johan
