Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBA1C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE5820855
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 12:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syu3nYwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfAQM61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 07:58:27 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39632 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbfAQM60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 07:58:26 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so4715349pld.6;
        Thu, 17 Jan 2019 04:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h3axuAUQ9AZrLG+Kid4he/ssj3HK1iC7IF7JMh3/Ltw=;
        b=syu3nYwm8ejHp5R1pIkS5vevxaxnvomXX3PH5JYv1OC1uGk6GDI2QlkqaekXuIlRqV
         C92pn1DnbjAf6DvVqRWzlEpdzoeybXRsP1OX6k+e933pfoqwbQ4D1yJv3aIIpjiINOP/
         dxOTHLsaJSE5nnpHNuZhQSXiMaIYIqQ5X2MYiT4hzx7UYCSeADNV8pGU7ACjJfKHy4dY
         Iim/JAdPbEp3nS2RToEVzaN1doz5AfPKrnjZBWAQZyUdb1L4+5nkLkJiXJ4VLVPVRcAX
         Gt6ulBilGQbNuowtjSltP8w14VFKijfPFRCqsjHEcrwRcWndGWzSwuc8OfzZDZMsScEn
         T0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3axuAUQ9AZrLG+Kid4he/ssj3HK1iC7IF7JMh3/Ltw=;
        b=LMFqI5veRlttUVHZFRq8+MRL9e9FphKkitcHV40/C0BWrAAOKOkCojhhi3lJeQNl++
         Iyv5JyukLQxDFBHoWiR666/lE0mYGAwUeIfKXhcVzOYhwWAdgW7D3gursRWFIrmoR9u5
         OxXSJj9Q57OypI12PVOVpDr+1Iq+BVKKJCMCqBHnGzpMP8B7hK0YiYw8ptdGeHaPR+nY
         7JKpyeR8B1y2cIPHzJfrlqmo9Yn0jk74OLx6Ewe4CN/H/R9JCPrbqx5/5jHCIFoQRM/0
         rDgrHzhFhS+4IHR7LNBvg91s7wrVrXjl1vhDCExZg9kh2MUxFyCjhi8jmitYa1CIdPmB
         vhSQ==
X-Gm-Message-State: AJcUukcSGyEJhKpg9rRWPOQOFyK9GgwIY+NZSmvZPvceFGOAotMdUxo/
        dfpdzFGnUfn4mh7hUVdKxY4=
X-Google-Smtp-Source: ALg8bN7iNLxkjInIyDfVbf0gz1T/i1EL17W2SbpymvYUJ6BOO1X8/J28hxhQ59xW9YTc+qJLECcqvg==
X-Received: by 2002:a17:902:161:: with SMTP id 88mr15163032plb.306.1547729905896;
        Thu, 17 Jan 2019 04:58:25 -0800 (PST)
Received: from localhost (14-202-194-140.static.tpgi.com.au. [14.202.194.140])
        by smtp.gmail.com with ESMTPSA id f67sm4052280pff.29.2019.01.17.04.58.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 Jan 2019 04:58:25 -0800 (PST)
Date:   Thu, 17 Jan 2019 23:58:21 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv4 00/13] Heterogeneuos memory node attributes
Message-ID: <20190117125821.GF26056@350D>
References: <20190116175804.30196-1-keith.busch@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116175804.30196-1-keith.busch@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:57:51AM -0700, Keith Busch wrote:
> The series seems quite calm now. I've received some approvals of the
> on the proposal, and heard no objections on the new core interfaces.
> 
> Please let me know if there is anyone or group of people I should request
> and wait for a review. And if anyone reading this would like additional
> time as well before I post a potentially subsequent version, please let
> me know.
> 
> I also wanted to inquire on upstream strategy if/when all desired
> reviews are received. The series is spanning a few subsystems, so I'm
> not sure who's tree is the best candidate. I could see an argument for
> driver-core, acpi, or mm as possible paths. Please let me know if there's
> a more appropriate option or any other gating concerns.
> 
> == Changes from v3 ==
> 
>   I've fixed the documentation issues that have been raised for v3 
> 
>   Moved the hmat files according to Rafael's recommendation
> 
>   Added received Reviewed-by's
> 
> Otherwise this v4 is much the same as v3.
> 
> == Background ==
> 
> Platforms may provide multiple types of cpu attached system memory. The
> memory ranges for each type may have different characteristics that
> applications may wish to know about when considering what node they want
> their memory allocated from. 
> 
> It had previously been difficult to describe these setups as memory
> rangers were generally lumped into the NUMA node of the CPUs. New
> platform attributes have been created and in use today that describe
> the more complex memory hierarchies that can be created.
> 

Could you please expand on this text -- how are these attributes
exposed/consumed by both the kernel and user space?

> This series' objective is to provide the attributes from such systems
> that are useful for applications to know about, and readily usable with
> existing tools and libraries.

I presume these tools and libraries are numactl and mbind()?

Balbir Singh.
