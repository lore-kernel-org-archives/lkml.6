Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F3DECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA98B208AE
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 09:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA98B208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbeIPPBc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Sep 2018 11:01:32 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:52724 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbeIPPBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Sep 2018 11:01:32 -0400
Received: from p5492e4c1.dip0.t-ipconnect.de ([84.146.228.193] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1g1TWC-0005LS-UG; Sun, 16 Sep 2018 11:39:05 +0200
Date:   Sun, 16 Sep 2018 11:39:04 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andy Lutomirski <luto@amacapital.net>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Matt Rickard <matt@softrans.com.au>,
        Stephen Boyd <sboyd@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Florian Weimer <fweimer@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        devel@linuxdriverproject.org,
        virtualization@lists.linux-foundation.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Juergen Gross <jgross@suse.com>
Subject: Re: [patch 11/11] x66/vdso: Add CLOCK_TAI support
In-Reply-To: <FAE37798-8CCE-44A5-9EF0-F69C2199BE60@amacapital.net>
Message-ID: <alpine.DEB.2.21.1809161129520.1650@nanos.tec.linutronix.de>
References: <20180914125006.349747096@linutronix.de> <20180914125119.081037164@linutronix.de> <ABB53D42-2A06-41B9-8A8C-40B39CD0289D@amacapital.net> <alpine.DEB.2.21.1809141625040.10480@nanos.tec.linutronix.de>
 <FAE37798-8CCE-44A5-9EF0-F69C2199BE60@amacapital.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1473863026-1537090744=:1650"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1473863026-1537090744=:1650
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT

On Fri, 14 Sep 2018, Andy Lutomirski wrote:
> > On Sep 14, 2018, at 7:27 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Fri, 14 Sep 2018, Andy Lutomirski wrote:
> >> That’s... horrible. In an amazing way. Can you add BUILD_BUG_ON somewhere
> >> to assert that this actually works?
> > 
> > Sure, but changing any of the clock ids will cause more wreckage than that.
> > 
> I’m more concerned that we add a new one and break the magic
> masking. Maybe two start sharing the same slot.

You are right. The obvious extension is CLOCK_BOOTTIME. That's id 7 which
indeed conflicts. I'll remove the magic.

Thanks,

	tglx
--8323329-1473863026-1537090744=:1650--
