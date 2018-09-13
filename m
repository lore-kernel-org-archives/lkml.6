Return-Path: <SRS0=SXUR=L3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E412FC6183
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB7C21797
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Sep 2018 17:07:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XLlCTUXj";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="XLlCTUXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB7C21797
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728622AbeIMWSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Sep 2018 18:18:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51500 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727384AbeIMWSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Sep 2018 18:18:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9362B6053B; Thu, 13 Sep 2018 17:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536858468;
        bh=d1fj1A3kTlnkZAaqD45rFa5WJWOcBSaqJFnoONkROyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLlCTUXjntasxi0uYAKK32pXgvnJLissBVA9muBjqaWC/OiMe2cc/4MQRWGgjnLm1
         zcYf7WwcLl1LTvTdnyk7z/aOU1nUjXt4xwcL5U89jyZNvCbJEIyDyaY7fHBGLl6Ali
         NfvOrbJz5mdBTv5G6+d/TG7v0q3rmaAegHjBUwAI=
Received: from jackp-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jackp@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B7BA2601A8;
        Thu, 13 Sep 2018 17:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536858468;
        bh=d1fj1A3kTlnkZAaqD45rFa5WJWOcBSaqJFnoONkROyA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XLlCTUXjntasxi0uYAKK32pXgvnJLissBVA9muBjqaWC/OiMe2cc/4MQRWGgjnLm1
         zcYf7WwcLl1LTvTdnyk7z/aOU1nUjXt4xwcL5U89jyZNvCbJEIyDyaY7fHBGLl6Ali
         NfvOrbJz5mdBTv5G6+d/TG7v0q3rmaAegHjBUwAI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B7BA2601A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=jackp@codeaurora.org
Date:   Thu, 13 Sep 2018 10:07:46 -0700
From:   Jack Pham <jackp@codeaurora.org>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 2/2] typec: tcpm: Add option to maintain current limit at
 Vsafe5V
Message-ID: <20180913170746.GB13306@jackp-linux.qualcomm.com>
References: <20180913021113.18150-1-badhri@google.com>
 <20180913021113.18150-2-badhri@google.com>
 <20180913063943.GA13306@jackp-linux.qualcomm.com>
 <CAPTae5JLnbHnFUXv4W0GY6a=kAmGCx7XfOUKrWo0q__enbvvQA@mail.gmail.com>
 <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPTae5KXAeCKerHh4PMFJ=7JhmwFwbc7-CQB-3JYamYbHtV+2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 6:43 AM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Wed, Sep 12, 2018 at 11:39 PM Jack Pham <jackp@codeaurora.org> wrote:
> >
> > Hello Badhri,
> >
> > On Wed, Sep 12, 2018 at 07:11:13PM -0700, Badhri Jagan Sridharan wrote:
> > > During hard reset, TCPM turns off the charging path.
> > > The spec provides an option for Sink to either drop to vSafe5V or vSafe0V.
> >
> > This doesn't make sense. By definition the sink isn't sourcing VBUS, so
> > how can it control whether to allow the voltage to be 5V or 0V?
>
> The way I understand it, this is for the current limits that can be
> set on the Sink side.
> During hard reset, sink has to fallback to VSafe5V or VSafe0V if
> higher pd contract was negotiated.

Ok, you are talking about sink current draw limits but vSafe{0,5}V are
voltage definitions so these are orthogonal. Again, the sink can't
directly dictate the voltage that's being sourced so I don't see how it
has a choice here. If a PD contract was negotiated for greater than 5V
and a hard reset happens then yes the voltage would fall to 0V and then
rise back to 5V and during this time sink needs to draw appropriate
current.

> > > From USB_PD_R3_0
> > > 2.6.2 Sink Operation
> > > ..
> > > Serious errors are handled by Hard Reset Signaling issued by either Port
> > > Partner. A Hard Reset:
> > > resets protocol as for a Soft Reset but also returns the power supply to
> > > USB Default Operation (vSafe0V or vSafe5V output) in order to protect the
> > > Sink.
> >
> > I can see how the wording here "vSafe0V *or* vSafe5V" is misleading, as
> > I think it actually is both. In later parts of the spec, the source's
> > VBUS behavior is well defined in that it must first drop to vSafe0V
> > and then return to vSafe5V. Please refer to section 7.1.5.
>
>
> Yeah thats for the source. But for sink, Say if the source isnt PD, then,
> sink initiated hard resets happen during the connection. Sink would hard reset
> couple of times before deeming that the partner is non PD. When connected
> to Type-A ports/non-pd partner, vbus is not going to likely drop so there isnt
> a reason to setcharge to false or drop the input current limit. Do you agree ?

Sure that makes sense. In this case I wonder if TCPM even needs to call
set_charge(false) considering it does not yet know if the partner is PD
capable or not. For sure, if the partner is PD capable and contract had
been previously established, we'd definitely need to set_current_limit()
to default levels and/or turn off charging.

But in the case of hard reset attempts to try to determine if the source
will send its capabilities (thereby being PD capable), wouldn't the
initial default current limits still be in place? I think this is the
point you're trying to make, that there is no need to disrupt charging
if a hard reset is not going to cause VBUS to reset.

To me it sounds like what you're trying to do makes sense only if you
can make a run-time determination of a partner's PD capability, and not
based on a config option.

Thanks,
Jack

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
