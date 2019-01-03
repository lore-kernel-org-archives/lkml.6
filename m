Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98CDDC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1D920815
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 10:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jVm+bgmD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbfACKie (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 05:38:34 -0500
Received: from mail-pg1-f170.google.com ([209.85.215.170]:38908 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728566AbfACKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 05:38:33 -0500
Received: by mail-pg1-f170.google.com with SMTP id g189so15850313pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Jan 2019 02:38:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zbJC8oznvoWlhWC1pdmFRtt84rPSKGXbCP0A/gGjpLY=;
        b=jVm+bgmDw+dMhdoqMW4nTn1bbyppO7s5apbhgDvoy4u2rDv4nET1hVcFCDzazmk0Ts
         YyuW0w9spf6ELgA7dO5g7kxrmK50h60Salr0EcZq5OAXftKt+21SJACjyqLCMfemRciv
         +aMKZe7UdXa+Y90qryB73mjl5VxJPozqxf7v0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zbJC8oznvoWlhWC1pdmFRtt84rPSKGXbCP0A/gGjpLY=;
        b=mLILrgz+Iu7Nm05Axdes4lBIZOwatZSREE07yi6iiCBbC3APAeehfbklQxDWyVTuZQ
         4pzxReaFsaFcEwEghDj+mB02MAeyr6LKIrqzLuiEbRGhMOFWyqacY9jVT22wQJYZ7BRE
         fioqC/PUOTgrdwtGOLT8Cy7weow1AuDTr9WXAfP3awySampJcaX7edB6DHG76boAhqor
         93MucJY7pAlVKY6drZSwAQAeRFmoW1ZkYI/ZOyEjRkCzp/Iw8hILrJIWmkBQ+VBv2ilK
         JPydncjWj9/0vxK/AMgJqBtWUBKRhz+0ExDrzyU0aUOyhXHD3WyZMuaU+fT8gmEM64J0
         xNDg==
X-Gm-Message-State: AJcUukfRdv5N0SbioYooTlpufbgwUNHahp2tC6MYVaP/zoT7NQhxMl+4
        MpF9bJ6RT5ArY7xqPCLxZpBYFA==
X-Google-Smtp-Source: ALg8bN6CHJAkHgaAlhEiwu88S/eCCydcTHMQAfmZ6bSjP28JKKRLh5FaVVLyxD4tGs2EKknfqhLvww==
X-Received: by 2002:a63:d047:: with SMTP id s7mr44317100pgi.311.1546511912918;
        Thu, 03 Jan 2019 02:38:32 -0800 (PST)
Received: from localhost ([122.166.131.155])
        by smtp.gmail.com with ESMTPSA id o4sm85031729pgs.12.2019.01.03.02.38.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Jan 2019 02:38:32 -0800 (PST)
Date:   Thu, 3 Jan 2019 16:08:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, nm@ti.com,
        sboyd@kernel.org, Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Douglas Raillard <Douglas.Raillard@arm.com>
Subject: Re: [BUG] dev_pm_opp refcount issue on Arm Juno r0
Message-ID: <20190103103829.2bqxhkpihp4r7x22@vireshk-i7>
References: <a2a42913-04e0-e6fc-d9ee-a2e355ac22c9@arm.com>
 <20190103070514.o6yaqvpxouazosnn@vireshk-i7>
 <20190103103318.GA23511@e107155-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103103318.GA23511@e107155-lin>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-01-19, 10:33, Sudeep Holla wrote:
> As you already state the checks are unnecessary, if we drop them we don't need
> to add any firmware specific callbacks. I am thinking if it makes sense to
> add a generic helper function to remove the OPPs from a device. If we have
> that any driver needing that can use it. The main reason I think helper is
> useful is that we need exactly same fix for SCMI driver too.
> 
> Thoughts ?

Okay, will do that and fix both the drivers as well.

-- 
viresh
