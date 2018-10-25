Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CBECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAC920831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 02:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ROxmOEN1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDAC920831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbeJYKlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 06:41:10 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42523 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726236AbeJYKlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 06:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch; s=20171124;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=xDZTEwLjvK/JAq1PEWiQXd98lr4qgLXH7socD7Blx2s=;
        b=ROxmOEN12CNWtMn3WokA9WWm5uRD4uLRmMIYojZS3DNRADgFmp2fPKI8Pbn2MaCvB/6rViC/T2/9MqpBk7XvzOQznRkOOsJ8LGOAxTqHVsHESlqx4E7JrT/vbHPW38tdIHcN8qIfezh1OsNf/7PRoLvkz4708Z9ySXpWxPwD/II=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.84_2)
        (envelope-from <andrew@lunn.ch>)
        id 1gFV6D-0007tx-9R; Thu, 25 Oct 2018 04:10:13 +0200
Date:   Thu, 25 Oct 2018 04:10:13 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        rmk+kernel@armlinux.org.uk, Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, l.stach@pengutronix.de
Subject: Re: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
Message-ID: <20181025021013.GA30116@lunn.ch>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025000905.6095-3-f.fainelli@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
> independance with respect to the ARM CPU being used. Add a test which
> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
> turned on to help asses the system's health.

Hi Florian

I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
segfaults give little clue as to what is going wrong,and gdb is not
much use either.

What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
ARM?

	Andrew
