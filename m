Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF5EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C6DA2133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551274352;
	bh=eDoudGHQDeHoxJVvQIJbGajvLkVBDSToiGNgTaHz6bc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qNrMD/njaxZJweeqkSCMHqKHDSVER1YfBDaEGFyYthdu/7tPLDM2pBkn0P3zhaR7l
	 VbrxJz4zjmxeegeu1PtD9esa4qHv70b34qw4mAsL2Gm1ZvejYmWiuBRXfbYI2pjZfQ
	 PGp+Dt146L5KnEK5sgKCu0oXAu+6/kD/jum3XZaU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbfB0Nca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:32:30 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36039 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730384AbfB0Nca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:32:30 -0500
Received: by mail-lj1-f194.google.com with SMTP id v10so14010238lji.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:32:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SuRxP1hJTd9BRIdXejyhGdKuCB0pCAzqNB7wK+Mi4Gc=;
        b=jRzKZ4THq1y+F2hAu/jfWpKUbsIEx5kHTzNVBn5Pq86uvwTIDUoq3GMHyje3vWte3B
         KCMcHeXAgbIg3dkTsCjAs0ktoKL+C64eqSvrra3XyeLD5yj0Vx1LELHeHM/mt4jrqm7m
         EzGUMFc0rZx8EXoJWoGzr9xQlDFJbIbwSzt7MvcKWVb/0hxqpK2o59p2BT0EhavhQEZ1
         uj9v+WRC563JcDqtjqnRC0Gw+VizsIMr24Io4PIQ1KpWe7OmlyejvZ5SuHcNsy3T8xeh
         e/5w6AyED23uF/cHO2WbbQrAghCuWEO1FVLJYbuUz3QK1M0UnFDjDKRY3aI5b/ZptQS6
         TqNg==
X-Gm-Message-State: APjAAAUpCYY2XTzqQFaDsxYxu6ZlQDNhVJfK8S1pDeUNEtWbDKTvaYVN
        4wB6btQ9OIArRSQqxjhjoI0=
X-Google-Smtp-Source: APXvYqy0qGaixc9fhEQ5hpnomaBtLUCgZmXQhSVCfbSIokioN7wFN14NIiRqkBk94/ccEavIdPoQNQ==
X-Received: by 2002:a2e:9b41:: with SMTP id o1mr1460618ljj.103.1551274347968;
        Wed, 27 Feb 2019 05:32:27 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id g65sm3809049lji.74.2019.02.27.05.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:32:27 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyzJy-0008Tl-TI; Wed, 27 Feb 2019 14:32:26 +0100
Date:   Wed, 27 Feb 2019 14:32:26 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 1/2] device.h: pack struct dev_links_info
Message-ID: <20190227133226.GQ4747@localhost>
References: <20190226144108.25891-1-gregkh@linuxfoundation.org>
 <20190227092318.GK4747@localhost>
 <20190227093104.GA5354@kroah.com>
 <20190227094021.GL4747@localhost>
 <20190227095424.GA11387@kroah.com>
 <20190227105951.GM4747@localhost>
 <20190227120645.GA15587@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190227120645.GA15587@kroah.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2019 at 01:06:45PM +0100, Greg Kroah-Hartman wrote:
> On Wed, Feb 27, 2019 at 11:59:51AM +0100, Johan Hovold wrote:

> Yeah, that is a good point, normally we use packed to keep padding from
> the middle of the structure from happening.
> 
> I just don't like that 4 bytes sitting there doing nothing :)

You could perhaps put them directly in struct device if the
dev_links_info struct is just used a separator there and this really
bothers you. :)

> But, in thinking about this, there is no real reason that I can see that
> this structure even is in struct device.  It should be able to be in the
> private "internal" structure.
> 
> The patch below moves it out of struct device entirely.  Overall there
> is no memory savings, but it could give us the chance to only create
> this structure if we really need it later on, as very few things use
> links at this point in time.
> 
> Rafael, there is one logic change below, the link structure is not
> initialized until device_add() happens, instead of device_initialize().
> Will that affect anything that you can think of?  Does anyone do
> anything with links before device_add() is called?

I think device_add() may be too late.

	The earliest point in time when device links can be added is
	after :c:func:`device_add()` has been called for the supplier
	and :c:func:`device_initialize()` has been called for the
	consumer.

Johan
