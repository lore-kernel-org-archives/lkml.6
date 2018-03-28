Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3402981-1522276227-2-2243660482079778371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522276226; b=oLNs1mSZvawEVJnTx2xje1PdGLAsvLdULEGRO9nPRTYy/4k
    vUihZoK41GfXSTW9TOpcl7vCELmT1UEkDAV3VfwVCGykJuiH1f7tIZMqClsjk6Jw
    h3M2T5n2UBeAgMTagwGzQkP0RTD8/xPbXXdV7X2s+EUbr/gGy+VlORP8WoWlcZE7
    NozyTOWmP1E6eYjbwwALPLoZgyPUf1S5GzkV4pKcKSzAEFPmX/W5CMcbUkl/caKJ
    LJkQ+Ndt80FGjaReNs3etKC0m6vCVa2/Opl6QJjQY5HEEnzdYm+OqtAiW4PfUiEG
    R2NARxqm/s02z6M1oE+3SKpbsyD+Kjl50e8ryPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522276226; bh=Ttv6/0l/J7NvvxiSdqiFEXx8o/
    A1RlyCKvG4pUlJ9Sc=; b=l3XHaAO4sE0N/Eus3UYFB1jz5VzVO+SLX8xE0q33cQ
    S4Wmb18RLOpgV+9mslsZQgHQtnAJehvB6BYkRslw1WjP7TXHPWRe37Z0ElGelKDH
    CkfQ1sK0Hbr57MOQD7xUKNEbNVJXmwy72t8r3Q+ZuCxDFXwsFnp4ZRJP+lHhn/4p
    mESwI1hzGZtUV/kkUjz+/ljZAidphTSE0jxmm8EQmMRb7EaELrROVJnliSgloeRX
    53NAbE7Rqyvwk/TMAvdk4BPMhHcF3Ii9RNuzyow6QbhpOybzoRoersP4c/dTGyfG
    C+REdy0p3h8xE5grAz2q2FHx9ysAs0DGzcdJYX5KQ+Wg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGTt8UXDkzBQzFIf1CVc3W2Ky24FA5kt78Mrvu9OPIDqBKN+3y2uOzSZUiEqtKt0Ztx8cHFrjtG3g1LlpWwwerPm+p4/LzCzLC6D1EulczMDqSnlJK+n
    hNQBcR3RekOaEPc3zRQFqB0J0VStGgxx0aryX9qj00txiiGi0F541YFmF680As07vC5es0o0ZX5S7Chzuhqgq+fKcQa5FEb+IjhSIDCtU8wezUn5RIKaMK1k
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=sozttTNsAAAA:8 a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8 a=xIo0oIc6g0y2Z2yfdOgA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=aeg5Gbbo78KNqacMgKqU:22
    a=UeCTMeHK7YUBiLmz_SX7:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeC1WaZ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 18:30:25 -0400
Received: from muru.com ([72.249.23.125]:34246 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeC1WaY (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Mar 2018 18:30:24 -0400
Date: Wed, 28 Mar 2018 15:30:21 -0700
From: Tony Lindgren <tony@atomide.com>
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: omap: Provide ability to enable/disable
 UART as wakeup source
Message-ID: <20180328223020.GL5700@atomide.com>
References: <20180327120217.4749-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327120217.4749-1-vigneshr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Vignesh R <vigneshr@ti.com> [180327 12:03]:
> Enable/Clear module level UART wakeup in UART_OMAP_WER register based on
> return value of device_may_wakeup() in .suspend(). This allows
> userspace to use sysfs to control the ability of UART to wakeup the
> system from deep sleep state. Register is restored back in .startup()
> call that happens as part of resume sequence.
> 
> With this patch, userspace can control UART wakeup capability via sysfs:
> To enable wakeup capability:
> echo enabled >  /sys/class/tty/ttyXX/device/power/wakeup
> For disabling wakeup capability:
> echo disabled > /sys/class/tty/ttyXX/device/power/wakeup

To avoid confusion, can you please add this to the description:

Note that the UART wakeup events configured in the 8250 hardware only
work for idle modes that do not cut off power for the UART. For deeper
idle states, dedicated padconf wakeirqs must be used. Or in some cases
the UART RX pin can be remuxed to GPIO input if the GPIO block stays
powered.

I tested this briefly and the dedicated wakeirqs still work for me,
so from that point of view:

Tested-by: Tony Lindgren <tony@atomide.com>
