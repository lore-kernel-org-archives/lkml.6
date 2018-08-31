Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08764C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B778E2083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V4nWhRXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B778E2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbeHaFb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:31:59 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46138 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727249AbeHaFb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:31:58 -0400
Received: by mail-pl1-f193.google.com with SMTP id a4-v6so4619801plm.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 18:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oewCE0rbqF1xfUlpTgexnF0X9nN8oyOsDs85sy26LHE=;
        b=V4nWhRXOk0mJ8IfEtfb9V3FTX7Sh4JJ9k/K+oCmJi17GjoV/nhEjJBk+6oDzWsMr8R
         rd8AzI/6QO8s3hwMtCso9yL4+LAS8fVDU/jkjQhmRKxSzTnztggeYj6KTtAmLQXs2nYZ
         3PWvUW0nuf94nqLoR4N/FeRULUWWQHaEKSEyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oewCE0rbqF1xfUlpTgexnF0X9nN8oyOsDs85sy26LHE=;
        b=MwhWmWqrDOAnNnclrgjc+WDEAT8B50k0MJFpuPwOVgpGmSakoi3EO6b+TPpWWOt1XR
         DiuHuKCVOCGZc7ixExShpnnYwFuUI3tsFgTOQR4TpGPH+IOSvVAgkmA4BE5Wv6gE8rM/
         bpWCWctTkChuNjOyTc5YzGy5hG4tBXSFY6fNm/2mixGECfRvFDkf7gUVoq9BIOhd61j6
         d3ezpzGn2xKTbyeOuDB1LT0jMCm1HQxXkTRFSg30AzwM3cAQ30DHkGW+2Imq7FZfVAQr
         FT5ioQ2PL9r4B/eTUnMzB9bL/Pyhbvq2zuI1HC4worFV369C9YIkJUMU/cnJVYviDEb+
         rvLA==
X-Gm-Message-State: APzg51Bs+gRcXmu0i5OuegsFShC/Xbj1yJkYejrpzwgCn7ODFkDCLoQd
        XYlNxCN8eKINDTasxk1JM/x6mQ==
X-Google-Smtp-Source: ANB0VdaLZIlLBtaNsrG+RBIH+T4gtiLwaD2vqeA8uWTILcPRV2ctu08OqUTRRFknxZYMN6e351D7FA==
X-Received: by 2002:a17:902:24e1:: with SMTP id l30-v6mr12905515plg.315.1535678821609;
        Thu, 30 Aug 2018 18:27:01 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([2620:15c:202:1:299d:6b87:5478:d28a])
        by smtp.gmail.com with ESMTPSA id e64-v6sm20020228pfk.87.2018.08.30.18.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 18:27:00 -0700 (PDT)
Date:   Thu, 30 Aug 2018 18:26:57 -0700
From:   Brian Norris <briannorris@chromium.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [RFC PATCH v1 0/3] device property: Support MAC address in VPD
Message-ID: <20180831012656.GB67271@ban.mtv.corp.google.com>
References: <20180814223758.117433-1-briannorris@chromium.org>
 <a240b3f9-d41b-30d7-ef11-5dcd1a981c0f@gmail.com>
 <20180815002204.GA258561@ban.mtv.corp.google.com>
 <bb1b2b7d-2c47-a6b3-7618-063351f379b2@gmail.com>
 <20180815014436.GA17200@ban.mtv.corp.google.com>
 <20180815221601.GB24830@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180815221601.GB24830@rob-hp-laptop>
User-Agent: Mutt/1.10.1+48 (1f3a9df87d11) (2018-07-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, sorry for the delay, and thanks for the response.

I'm still not sure whether I'll pursue this series further, but I'd like
to at least narrow down what it'd look like.

On Wed, Aug 15, 2018 at 04:16:01PM -0600, Rob Herring wrote:
> On Tue, Aug 14, 2018 at 06:44:36PM -0700, Brian Norris wrote:
> > On Tue, Aug 14, 2018 at 05:52:49PM -0700, Florian Fainelli wrote:
> > > On 08/14/2018 05:22 PM, Brian Norris wrote:
> > > >> Also, aliases in DT are meant to provide some stability.
> > > > 
> > > > How, specifically? I don't see any relevant binding description for
> > > > aliases under Documentation/devicetree/bindings/net/.
> > > 
> > > Indeed they are not, likewise, we should probably update devicetree-spec
> > > to come up with standard names that of_alias_get_id() already consumes.
> > 
> > A quick grep shows we already have divergence: both "eth" and "ethernet"
> > are in use.
> 
> Uggg, it would be nice to clean that up. 

Is it fair to just change them, since they were never documented? Of
course, only after documenting the "right" way.

> There's several aliases I'd like to get rid of (some platforms went a 
> little crazy with them) and I'd like to start requiring alias names to 
> be documented. I created an issue for the spec. Patches welcomeTM. :)

So e.g., new text in Documentation/devicetree/bindings/net/ethernet.txt
and Documentation/devicetree/bindings/net/wireless/ieee80211.txt about
'aliases' entries? I can do that, especially if I give up on a new
binding like in this series.

> > But anyway, would the idea be that you just put 'ethernet{0,1,...}' and
> > 'wifi{0,1,...}' aliases in the /chosen node, then require boot firmware
> > to insert any {ethernet,wifi}_mac{0,1,...} into the paths represented by
> > the corresponding aliases?
> 
> In the /aliases node, but yes.

Oops, yes.

> Seems to me that nvmem needs to be extended to allow providers to 
> retrieve and interpret data. Not everything is at some fixed offset and 
> size. Something like this is valid dts:
> 
> nvmem = <&phandle> "a-string";
> 
> But that's pretty uncommon (I can't think of a binding that actually 
> uses that). Perhaps the provider has an array of keys defined and the 
> consumer just provides the index.

In the case of VPD, all keys are 0-terminated strings (there's also a
length field, but the key is still 0-terminated), so that scheme could
work. (I'm not sure an indexed provider is extremely relevant right now,
although it probably could be supported if I expand the of_nvmem
retrieval to support a generic of_xlate() override anyway.) The
information represented is almost the same as in my proposal, except that:
(a) now I have to give the VPD a phandle -- so far, I've avoided that,
    as it's just an auto-enumerated device underneath the
    /firmware/coreboot device (see drivers/firmware/google/vpd.c)
(b) this is no longer directly useful to ACPI systems -- I'm not
    actually sure how (if at all) nvmem provider/consumer is supposed to
    work there

But maybe this isn't really that useful to ACPI, and it's sufficient to
just have fwnode_get_mac_address() call of_get_nvmem_mac_address() when
we're using DT.

> Or we could do '<key>-nvmem = <&phandle>', but parsing that is a bit 
> more complicated.

That doesn't seem to have much advantage to me.

Brian
