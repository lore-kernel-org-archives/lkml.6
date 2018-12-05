Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591B9C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9E520850
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025672;
	bh=sOzvV87mxfzGmbs+8BnENQe3+unSb0+anZf9P4jHxT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rvsFXyaxbLZozKAVSX6K08GO3kJhtRxLeXJE3e/9H1fG6U9aiHZ6F2dsej5ue6zyx
	 aKbVW7JGGMCTY8EK+ApbjSuC4awrSKpGxfM6r+wVzQQKPiJkrMEgU8IQ1Nai0ndRqL
	 6jRLEGgsw/WdmLZLWInnpdXLBczZDsjCGgU0LNkI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9E520850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbeLEQBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 11:01:11 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45328 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbeLEQBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 11:01:09 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so15088853lfa.12;
        Wed, 05 Dec 2018 08:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8uznSbQUk+5ewtVdxU/4+sbJiQI7kQtoN7paPmy6t1Y=;
        b=AYC1fOPg3lKceMX5boCVO1NLK6fpkJSb0PHeMSj1BHF3gH9gWCuxZ3oJKz7gr9o1Hj
         uTMR1BFDatJYuMoOd/3wHQGWzW4EOwU9SDE04LiEyR5uzcBcN7HeYxSqwvF2EaW9YfN5
         oZoCQoefzMm9IHSiBKG5XbiGwhB7ZA77qmGq4C1VR71ljNz85/KZmpjFdR9mw0k2bpac
         dSH6Cwt1qy3BMk9GmnCefGT1/R9jqtZzWMisz15tXNkq5GW9pPWOy/wZ/51SgH8pCGr8
         z4PHAXeNSDcbH0g5S6XXU6eEBYEnwtL/mNvve6YSfG/xyAaeWmDz8abB1mXdp6nkWWXP
         JgGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8uznSbQUk+5ewtVdxU/4+sbJiQI7kQtoN7paPmy6t1Y=;
        b=WYKBg0oa7HgmnbVTERhQBkNnw3LKnwzX/Eg5tvX/JgfE4bLtDFJBka2FolR6yArjx3
         98zDBEgUTmGigueyBDdiTR8DzY2d0DV1vIUj5iv2oLDZ1T/79+VT9VkaQfkQkeEgLj6e
         vKRBH9j+OmlKuNQ9h4ZJLV7FtQ5WtqdsGN5ZsW6pYE6S6QAhoM6uncZM+9u5wFHfUkZz
         4un2Y+vOqfuY+lID9ijt0xuE9hU8kYa4QYGqAZ4rF7T9pCPdhNu8k3xCM5uW0RB1esAU
         Bv+4j2lBe3Sz4q2wRhu6tckIqjlbuW/0YHLJtPKjRNMTLlRXAd7+Zf8veprTeLzYvOxZ
         ZVhQ==
X-Gm-Message-State: AA+aEWbQp+iZPQUA5i/szHSwo9bLzyV+6tbtboW6RpL6X/iaFBzelP0P
        8E4Bo+SirfTUU+3Qpv2s7coU1L0G
X-Google-Smtp-Source: AFSGD/U65oHT+AmH8zl8FdpgvUKLNsdlEK1eA1psML7jW1O/iUP3bwlYZWonA8vwbiiHkqZ5dcyZhg==
X-Received: by 2002:a19:a28e:: with SMTP id l136mr15745160lfe.87.1544025666472;
        Wed, 05 Dec 2018 08:01:06 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id p10-v6sm3825352ljh.59.2018.12.05.08.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 08:01:05 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gUZbo-0004J9-Jj; Wed, 05 Dec 2018 17:01:08 +0100
Date:   Wed, 5 Dec 2018 17:01:08 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Johan Hovold <johan@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Subject: Re: [Letux-kernel] [PATCH 0/5] gnss: sirf: add support for w2sg0004
 + lna
Message-ID: <20181205160108.GN15689@localhost>
References: <20181118215801.12280-1-andreas@kemnade.info>
 <3487514B-E546-4F11-8C0A-F5B4A8114376@goldelico.com>
 <20181119194414.1c7d6887@aktux>
 <20181205151916.GJ15689@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181205151916.GJ15689@localhost>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 04:19:16PM +0100, Johan Hovold wrote:
> On Mon, Nov 19, 2018 at 07:44:14PM +0100, Andreas Kemnade wrote:
> 
> > On Mon, 19 Nov 2018 09:22:59 +0100
> > "H. Nikolaus Schaller" <hns@goldelico.com> wrote:
> 
> > > > Am 18.11.2018 um 22:57 schrieb Andreas Kemnade <andreas@kemnade.info>:
> > > > 
> > > > Here is another chapter of the story to get gta04 gnss power
> > > > management into the mainline kernel.
> > > > There is a w2sg0004 without wakeup line in there, so power state
> > > > can only be determined indirectly by looking at the serial data lines.
> > > > Then there as also an lna which needs to be powered for real gps
> > > > reception. That part needs probably more discussion, since it might
> > > > be an idea to have it more generalized since it has nothing todo
> > > > with the chip itself.  
> > > 
> > > On the other hand if we follow the "SoC is the spider in the net"
> > > way of looking at DTS hierarchy, we have the uart as a child of the
> > > SoC and the gnss receiver as a serdev child of the UART. The LNA
> > > is even one step more distantly connected to the gnss. So it makes
> > > sense to me to have it as a property/reference of the gnss chip's
> > > DTS record which is a sibling of the compatible records. So the only
> > > place where it can be reasonably processed is the driver.
> > > 
> > Or the lna is a child of the gnss receiver. The whole thing
> > should probably not be overdesigned, but it does not make sense that
> > every gnss chip driver has some lna logic.
> 
> Did you mean "does make sense" here?
> 
> > Maybe the regulator should just be stored in the struct
> > gnss_device and then drivers/gnss/core.c takes care.
> 
> Maybe eventually, but keeping it per driver is fine for now.
> 
> As you say above, this really isn't part of the chip itself, and
> therefore should probably be a generic gnss property as it could be
> required for any receiver (in principle).
> 
> But we still need driver support for coordinating it with the rest of
> the receiver power management, so adding it to drivers as need arises
> seems reasonable.

Actually, the property probably still should go into gnss.txt as a
generic optional property, but driver support for it will be added as
need arises.

Rob?

Thanks,
Johan
