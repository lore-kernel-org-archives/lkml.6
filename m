Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976F1C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A5720834
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 17:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EWLiBnB+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A5720834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeJZCGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 22:06:47 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:34646 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727455AbeJZCGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 22:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S3YoGq4XbxQXDh2VwC+Lw5UGYV5iCRqWdlrOL2/2RjM=; b=EWLiBnB+VM/z0Cfx5aOPvks8h
        gkWXS8vKFkt1JcORp2XOzwtDecCJ3uZsKFkum4WBtO1VlKposOJTjNAQ6Pcrnfpe0Bz7opRd43vPg
        tuTY7Wz0BkpsdL2WJFcyFmc3Pu5oOvvJUQLFuYlJzRSg7sWa8a1xY1fyAZ6+GQ0Rzdsc0=;
Received: from n2100.armlinux.org.uk ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:54692)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gFjV0-0000NI-5R; Thu, 25 Oct 2018 18:32:46 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gFjUx-000132-KO; Thu, 25 Oct 2018 18:32:43 +0100
Date:   Thu, 25 Oct 2018 18:32:42 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-arm-kernel@lists.infradead.org,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Kim Phillips <kim.phillips@arm.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@redhat.com>, l.stach@pengutronix.de
Subject: Re: [PATCH 2/2] perf tests: Add a test for the ARM 32-bit [vectors]
 page
Message-ID: <20181025173242.GC30658@n2100.armlinux.org.uk>
References: <20181025000905.6095-1-f.fainelli@gmail.com>
 <20181025000905.6095-3-f.fainelli@gmail.com>
 <20181025021013.GA30116@lunn.ch>
 <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <175fd725-a97a-c282-5aa1-952014ff9023@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2018 at 10:19:54AM -0700, Florian Fainelli wrote:
> On 10/24/18 7:10 PM, Andrew Lunn wrote:
> > On Wed, Oct 24, 2018 at 05:09:05PM -0700, Florian Fainelli wrote:
> >> perf on ARM requires CONFIG_KUSER_HELPERS to be turned on to allow some
> >> independance with respect to the ARM CPU being used. Add a test which
> >> tries to locate the [vectors] page, created when CONFIG_KUSER_HELPERS is
> >> turned on to help asses the system's health.
> > 
> > Hi Florian
> > 
> > I've suffered the pain from missing CONFIG_KUSER_HELPERS. The
> > segfaults give little clue as to what is going wrong,and gdb is not
> > much use either.
> 
> If you have a working backtrace, you can typically see the virtual
> address being in 0xffff_xxxx which gives a bit of a clue, but yes, this
> is not particularly helpful.
> 
> > 
> > What i don't see here is any clue to CONFIG_KUSER_HELPERS. If the test
> > fails, could you print a message suggesting CONFIG_KUSER_HELPERS on
> > ARM?
> 
> Sure, sounds reasonable, thanks for taking a look.

An alternative would be rather than adding this to user programs, to
have the kernel detect it and print a warning itself.

BTW, I note that the help text for CONFIG_KUSER_HELPERS needs to be
updated.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
