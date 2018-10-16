Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F39DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4172098A
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBEFWXy5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4172098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbeJQBYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:24:19 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39190 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726986AbeJQBYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:24:17 -0400
Received: by mail-pl1-f193.google.com with SMTP id e67-v6so2365313plb.6;
        Tue, 16 Oct 2018 10:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=y1w0FJdINzv8gNqozV1Vu9E1dyRS5C9BvaJd60sGdYg=;
        b=qBEFWXy5JNqkNzxO81sCCemT2BsVU7C2EphkTH/VvvRWcQWA+1tZbV8Q440FWochcl
         JRwNqIiA/9dpJE6uYcJooektXcjSL9zV14MZWoLBg/nhuxgFPggcmGmeO8HmjkD8eyEB
         N0E2W1HHU4qLJwcW/Zn/maMh0NTsIUonzMeGReF3p5R6BOmqYv36QmLUFFj778tE1yKf
         V21LpmmU77dOtVoT/LpARZWXmJayShobquL0yK5nGu2cAOmSTzUNZy33tyVN+bRQOKol
         2qag6XOkml6yH9mbh19FAVbYAVeEwVffqV0jzXP9XLB3K+Pwtv/H2gW7kGnJ3Sfve14M
         fang==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=y1w0FJdINzv8gNqozV1Vu9E1dyRS5C9BvaJd60sGdYg=;
        b=TiIK7o3UKO1oDPxNpBCs+vcAldERUoqXGicqK3vvJq9bGnEAUntrGPZI+VenAuPRp0
         LmIH0o96PX7WauIRQSO4opNe0EA84rKUZZAVohJmZyHVE5E6c38qV9U3J9hAICM+CqCK
         Ymy5FC7mkV0Twn6nlBFnIBycyIM256vlmv715cH1yXCPCODWcKG/NLRrGtT9jjJlxHyw
         7acRDlgGUO2THEiRV7aJfK4EKUfQvDiTqVLiRrBXsiWFyqaEBSZKsQLmlzwf13LGCv7I
         55m1v+z0U9G0crM13/yhLbwmA4KsclywG+KV94akAvboGgHVy1rAJwmzgzdRoRueesQb
         hNZw==
X-Gm-Message-State: ABuFfohiy2A3ls6sFDAk6MIMlY+2AAvKqSNH2MwzE6gxq+w/2uJnPhE8
        XxSBj06nur+YK2PT+DXubkQ=
X-Google-Smtp-Source: ACcGV622G9yue09V80MDbbP/gixbDsT0T0c/i7XXfoIZ23rAFznJCBa8HTXo6EcA5ZPXPlklwXppVg==
X-Received: by 2002:a17:902:9004:: with SMTP id a4-v6mr22051104plp.166.1539711168545;
        Tue, 16 Oct 2018 10:32:48 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id a14-v6sm17524344pgi.75.2018.10.16.10.32.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:32:47 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:32:44 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] device property: Introducing software nodes
Message-ID: <20181016173244.GB230131@dtor-ws>
References: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181012113934.29942-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heikki,

On Fri, Oct 12, 2018 at 02:39:29PM +0300, Heikki Krogerus wrote:
> Hi guys,
> 
> To continue the discussion started by Dmitry [1], this is my proposal
> that I mentioned in my last mail. In short, the idea is that instead
> of trying to extend the support for the currently used struct
> property_set, I'm proposing that we introduce a completely new,
> independent type of fwnode, and replace the struct property_set with
> it. I'm calling the type "software node" here.
> 
> The reason for a complete separation of the software nodes from the
> generic property handling code is the need to be able to create the
> nodes independently from the devices that they are bind to.

It would be great it you would provide an example of creating these
sowftware property sets separately from devices. How do you tie device
and its properties if they are not created together? For OF we have
compatibles and phandles for references, ACPI has HIDs and CIDs and
notion of references as well. What do we use here, especially when
software node is created in one subsystem (let's say
drivers/platform/x86), but device is created somewhere else?

Another issue that is not clear to me: looking at the USB connector it
seems you want to have references to fwnodes. How do you resolve them
when there are nodes of different class. I.e. how do you express
software fwnode referencing ACPI or DT node when you are supplementing
ACPI or DT description of a system with these custom/secondary nodes?
What about the other direction? I.e. can I have a DT system with USB
connector and augment USB set up with static nodes? Not only
basic/scalar properties, but links as well?

As I said, having and example of using this new code to achieve your
goal with regard to USB connector would be awesome and clear a lot of my
questions.

Thanks!

-- 
Dmitry
