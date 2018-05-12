Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-590407-1526085751-2-10679594921643787178
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526085750; b=avi+tT8OVgpIdMhrhiJDaKmhl1ciqmwDPz3MbCirk7uQPHWJ0+
    9de1U8aZgIdkK8nMAxBPdebnk0VsaI1pQ8xONq1nu5grNdtD9+fuhWZTvSJddr3B
    CkKzLZcm7rknK/G1KOczC5tu+LNDHHkZa4vsS1HDXdUKUCULvlHMQkR8fbJJ07Mm
    xXMRQV9/7zMTriBaSENkhHbhWTH8wksZ4ET+e3soQIfApb5nt1uWjmSbX9BjuMjl
    niNoxG+SNYmq9GaRpZf3iJvuyfw3Urxb6HrfChiAQUEK6TTGGrgKuYYokYVCegJT
    PEAya8kHuvys56PH5mxcwRjXrggoKFH5nZ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526085750;
    bh=JMfJGn923d7F/xIPUZN5k32UTyGZ+6nXhMLZ/bk9fos=; b=VYw0O3trEro9
    YtgRbwndszqWTvBJ92rHVBfdHnNNftMBNhXdtc+JUa9QEzUWqW4vLyupLHqQrSVm
    9fOyjdEkvqFvrCXz2joIeCwtK7vmTHOuH6/BB6EAehZazSE0EhAz4Dut7y1KarRI
    dzqr//NJnqELMKlWhaMGK6h+Phc5Swv+lhedztiV04lKa7BKMSnKqKY/l62YcPxb
    E6alhiKd6rdiZ1D3i9ypY5Dc5juuql5c5V/FXBYIJ/qKNQIwIQNDw1W90DqY6ASj
    3BiYHg3+u/BkwWQT4tGsY9uDlnNtZBS48rbVdUsFjFmvNWbIVqPwTI2BSyPof2oc
    72funcD5DQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=VV9knec7 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=VV9knec7 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBYHOUFgPel1dvYIIl12+a4NcrVUM0+vqxK/lDliZcDVz/UCWsK4yPg4X/4AQTK3iCxnY+m/jmj+8O+hGkBm15QrRfaxKIx3mmS+7v/TOIm6LocQlNjt
    TXwCkZmkr17AerC9ORHkY8ad35iPQdv6ChWQqlGffo5msX4fQvgaRrKK18MHKY8IiKRB5ZO0xH+U+L39V4UsmQT2rdww2ZHHUOKetK6KojNSSBl4hWBXtXU4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=PHq6YzTAAAAA:8 a=VwQbUJbxAAAA:8 a=PMT70qdeAAAA:8 a=YhlAls6PJlfj8XbK10IA:9
    a=Zr7Q7lzBsEcMnobV:21 a=F0iW8we2XEAP6iZO:21 a=CjuIK1q_8ugA:10
    a=ZKzU8r6zoKMcqsNulkmm:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750793AbeELAm0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 11 May 2018 20:42:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:60034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750776AbeELAmZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 11 May 2018 20:42:25 -0400
Date: Sat, 12 May 2018 09:42:21 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: gregkh@linux-foundation.org
Cc: Wang Nan <wangnan0@huawei.com>, Will Deacon <will.deacon@arm.com>,
        Jon Medhurst <tixy@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        David Long <dave.long@linaro.org>, stable@vger.kernel.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [BUGFIX PATCH v3 0/4] arm: kprobes: Fix to prohibit probing on
 unsafe functions
Message-Id: <20180512094221.e911fa262d8ca9a70ab8869e@kernel.org>
In-Reply-To: <20180508112503.GD16141@n2100.armlinux.org.uk>
References: <152540727123.29650.13679359124038587629.stgit@devbox>
        <20180508112503.GD16141@n2100.armlinux.org.uk>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

Could you pick this series to stable?

Thank you,

On Tue, 8 May 2018 12:25:03 +0100
Russell King - ARM Linux <linux@armlinux.org.uk> wrote:

> On Fri, May 04, 2018 at 01:14:31PM +0900, Masami Hiramatsu wrote:
> > Hi,
> > 
> > This is the 3rd version of bugfix series for kprobes on arm.
> > This series fixes 4 different issues which I found.
> > 
> >  - Fix to use smp_processor_id() after disabling preemption.
> >  - Prohibit probing on optimized_callback() for avoiding
> >    recursive probe.
> >  - Prohibit kprobes on do_undefinstr() by same reason.
> >  - Prohibit kprobes on get_user() by same reason.
> > 
> > >From v2, I included another 2 bugfixes (1/4 and 2/4)
> > which are not merged yet, and added "Cc: stable@vger.kernel.org",
> > since there are obvious bugs.
> 
> Please submit them to the patch system, thanks.
> 
> > 
> > Thanks,
> > 
> > ---
> > 
> > Masami Hiramatsu (4):
> >       arm: kprobes: Fix to use get_kprobe_ctlblk after irq-disabed
> >       arm: kprobes: Prohibit probing on optimized_callback
> >       arm: kprobes: Prohibit kprobes on do_undefinstr
> >       arm: kprobes: Prohibit kprobes on get_user functions
> > 
> > 
> >  arch/arm/include/asm/assembler.h  |   10 ++++++++++
> >  arch/arm/kernel/traps.c           |    5 ++++-
> >  arch/arm/lib/getuser.S            |   10 ++++++++++
> >  arch/arm/probes/kprobes/opt-arm.c |    4 +++-
> >  4 files changed, 27 insertions(+), 2 deletions(-)
> > 
> > --
> > Masami Hiramatsu (Linaro) <mhiramat@kernel.org>
> 
> -- 
> RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
> According to speedtest.net: 8.21Mbps down 510kbps up


-- 
Masami Hiramatsu <mhiramat@kernel.org>
