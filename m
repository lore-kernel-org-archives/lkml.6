Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B255C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBF9D21871
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 09:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546593582;
	bh=7oM7huWlak2o8u7fD5Zus6baRDfufRIjRcM+7gMCqrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vtoz2S6mzF+3Oh7k1UWfCadg73Ilc1UwdSa0L0ozOcHOIf4lIIk02HknkyuJJkFQ1
	 UgzeAYaioMxwaxEvU6C0+Ta6IqgP7N0EaN/yImy4GoCPHgnye+eoy3vyuiptBWOXAu
	 3ORO8/3EKszDw+9768Nrf9WPBz8xnHCak6n0gA+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbfADJTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 04:19:39 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45135 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfADJTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 04:19:38 -0500
Received: by mail-lj1-f193.google.com with SMTP id s5-v6so31888633ljd.12;
        Fri, 04 Jan 2019 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8wXozGI8YuI1FDVAsn4StDOzqsKBv3yD482LhH8gg9s=;
        b=Eev7Cs7kd8j1M4TS+40uT0caIasHzYAV6qcDNXUs6TJtmpZO0HFceRgTDfZFTlTxDn
         2GnUF+26eFVzBd9xA17LKaHSXnSgN9EoFZca7ZQprf8Hwdv1iHndnmYmaTbhAR81p0+B
         pt5msIIISD0g0radgnbpx7RNuwHCOjL1/0ZmaIZr84htICZhZ/yfX0K2H2+rj46A0a6t
         oRcB1hKNzVMsq5+8Kr6JCUCszuznKJLZjTzRkVfV/xWEhcaMN2FwQtOEAKYWv02L9Nta
         Ljj008Y8geGRbMmP98CgSSKSYLitj4JXqpsmBnG1WpxZ/lKav7m/XgwCx7XkDVDripJY
         5TCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8wXozGI8YuI1FDVAsn4StDOzqsKBv3yD482LhH8gg9s=;
        b=nPLLn1jMA6co2GiRMq6hYJXqlW/e981QMt/+q/YDAC92MYPTg8kkY7/CmxPI0r7BKt
         eYeUcWZ2cVkZq+mi7sDqwYFRwQk3Qn+4il/rtO9k5ZBkxZDHcSmTs+YocYlKdhusY4bz
         wz0oj29Mj8WePbOyK1DnooeCLjt90wlQP5r6gxUIvagwnxyXv19henHV+tCHQyNyJe4k
         NOqxi33MNiabZ3+PgTGefXXnrCWcjwYy55zL/e4EWPBv/qzFfFrpDIqMlW1QHqyTKsFp
         QKrJMT++ZUZ3cLGfdUCjR0fC3Hkq6Xz3K7LQq9T2PMdusBVk8ysaxzsdgIHzVjH9D/ne
         F6AA==
X-Gm-Message-State: AJcUukcAYlmhTdOVMyROd5sFeJzTKMUUxn/VgRyfU12oOA3pgfS4ypB3
        cbX3URg7lV92qSpdW5+sSF0OBFEg
X-Google-Smtp-Source: ALg8bN7q8xNst/rRtAy4SHpBOVsSTTihoV8SnOZ3fNz6BEa6H8iZz//SoHoE/aNxPuzG56XD8jWznQ==
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr9482272ljg.23.1546593574861;
        Fri, 04 Jan 2019 01:19:34 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id 67-v6sm12247247ljc.26.2019.01.04.01.19.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Jan 2019 01:19:33 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gfLdh-0001JA-3y; Fri, 04 Jan 2019 10:19:37 +0100
Date:   Fri, 4 Jan 2019 10:19:37 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Loys Ollivier <lollivier@baylibre.com>
Cc:     devicetree@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH 0/4] Add driver for globaltop GNSS receivers
Message-ID: <20190104091937.GA4737@localhost>
References: <1545994235-8309-1-git-send-email-lollivier@baylibre.com>
 <86bm4x6830.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86bm4x6830.fsf@baylibre.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 03, 2019 at 05:04:35PM +0100, Loys Ollivier wrote:
> 
> As suggested by Neil Armstrong - this GNSS device seems to behave like
> most generic GNSS receivers.
> I'll send a v2 with a generic driver that works for both GlobalTop and
> u-blox.

That doesn't sound right to me. Judging from a quick look, this device
appears to be based on a mediatek chipset, so I suggest reworking
(renaming) this as a Mediatek driver (gnss type would be MTK, reflecting
the vendor protocol) even if it happens to look a lot like the current
u-blox driver.

If we ever add more features, like support for some part of the vendor
protocol or maybe 1pps, things will start diverging. As you noticed you
already have the generic serial gnss implementation to handle a lot of
the common bits.

> Loys Ollivier writes:
> 
> > Hello !
> >
> > This patch series adds a new GNSS driver for the globaltop GNSS
> > receivers.  These receivers transmits NMEA output sequence as soon
> > as they have booted.  Power management can be done via the main
> > supply and optional backup supply as defined in the device tree.
> >
> > The driver has been tested using a GlobalTop pa6h chipset on a
> > Libretech-cc board using the expansion header. Changes made in the
> > board device tree can be found below for reference and testing.

Thanks,
Johan
