Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=5.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA9F7ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74FC520882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="YZyGwjgz";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="kJz7nJaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74FC520882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727944AbeINX6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 19:58:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51346 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbeINX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 19:58:29 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8D74160BF7; Fri, 14 Sep 2018 18:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536950565;
        bh=+vYJ+BNdbhbGL2E8fwhABXon5Y2/19HIHSTL4804ZAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZyGwjgzNlF6PBZfdI1c9PBwOwBZvGuscryKoQlQ/FqRf8KNQoIjZ0S+gwUlLXDTs
         BbgXMdBNxLonNRFr0jq+cu+KgTbomfceI1fF/IvB1XjBuc6hoQPkO4AcwQ42cNfhiM
         +IoHdsC9PcMRlXrLe2peFcY+2s2lVO06axgMz9Bo=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 731D7609A1;
        Fri, 14 Sep 2018 18:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536950564;
        bh=+vYJ+BNdbhbGL2E8fwhABXon5Y2/19HIHSTL4804ZAM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kJz7nJaDo2NaFeq3siakmzuj2ppa23WZUL6zGc2SfZpMPIU+ogeJkn4U10FOisXgB
         hEmsPaFwFk6MUgxPViPZx4IyAzmKOshxONPPxb2WAn0jNkgZGedW0JaNtd1qxFIwVz
         x5jRQAH1txN6jUhzd06ZttWyCWsLziMEV9TBCirI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 731D7609A1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Fri, 14 Sep 2018 11:42:42 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at
 Vsafe5V
Message-ID: <20180914184242.GC13306@jackp-linux.qualcomm.com>
References: <20180913021113.18150-1-badhri@google.com>
 <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com>
 <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
 <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com>
 <20180913170746.GB13306@jackp-linux.qualcomm.com>
 <CAPTae5+WyxADQfDJivzmCBpFbA8RqpCGKDys6tUpHwF8+vt8iQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5+WyxADQfDJivzmCBpFbA8RqpCGKDys6tUpHwF8+vt8iQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Badhri,

On Thu, Sep 13, 2018 at 04:38:10PM -0700, Badhri Jagan Sridharan wrote:
> On Thu, Sep 13, 2018 at 10:07 AM Jack Pham <jackp@codeaurora.org> wrote:
> > On Thu, Sep 13, 2018 at 6:43 AM Badhri Jagan Sridharan
> > > Yeah thats for the source. But for sink, Say if the source isnt PD, then,
> > > sink initiated hard resets happen during the connection. Sink would hard reset
> > > couple of times before deeming that the partner is non PD. When connected
> > > to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
> > > a reason to setcharge to false or drop the input current limit. Do you agree ?
> >
> > Sure that makes sense. In this case I wonder if TCPM even needs to call
> > set_charge(false) considering it does not yet know if the partner is PD
> > capable or not. For sure, if the partner is PD capable and contract had
> > been previously established, we'd definitely need to set_current_limit()
> > to default levels and/or turn off charging.
> >
> > But in the case of hard reset attempts to try to determine if the source
> > will send its capabilities (thereby being PD capable), wouldn't the
> > initial default current limits still be in place? I think this is the
> > point you're trying to make, that there is no need to disrupt charging
> > if a hard reset is not going to cause VBUS to reset.
> 
> Yes that's right ! I wasnt sure how to put that in words. Thanks for
> doing that !
> You do concur right ?

Yes.

> > To me it sounds like what you're trying to do makes sense only if you
> > can make a run-time determination of a partner's PD capability, and not
> > based on a config option.
> 
> Yes this should be possible. port->pd_capable already has that info.
> 
> To sum it up:
> if the partner is pd capable, set charge to false in SNK_HARD_RESET_SINK_OFF and
> readjust current limits to default in SNK_HARD_RESET_SINK_ON and turn
> on charging.
> 
> If partner is not pd capable, do not turn off charging nor adjust
> current limit as host port is
> not going to respond to hard reset.
> 
> Does it make sense ?

Right, although the "not pd capable" path could also mean the partner is
PD capable but it is not determined yet. For example: if a sink is
connected to a PD source, established a contract, and the sink reboots
and has to initialize TCPM again. Assuming the sink never disconnected
from CC when rebooting, the source won't automatically re-send its
Source Capabilities as it will still be in its previous state(*). The
sink TCPM however would send a hard reset in order to try to
(re)establish a contract, so here is where this path overlaps with the
not-pd-capable case. In this case I think it might be proper to readjust
current limits to default also unless it was already done earlier--I see
it is done in tcpm_reset_port() and in SNK_DISCOVERY, so you might be
covered here.

The question I have is whether you still need to consider calling
set_charge(false) for this example.

(*) Just thought of one more thing, what if the previous contract was
negotiated at greater than 5V VBUS? How does the sink TCPM handle
setting charging parameters after a reboot but prior to hard reset?

Jack
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
