Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-356304-1524840764-2-13912616988214090969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524840763; b=JoFjLEDfHzSvqmxghFVu4MPL6b+T2WN3VzCCcoP6iu5tIuKocR
    jcgQ+U4mM+M403xGKX0509/lV8dk+E99r8QmmGgrrPM6Plh30POD99OyXuNRr+dw
    PcN9ihUZtAmnMOgdW+PqJsCmyJV4YOC1Bai7/C0LkRj9cjvixldWJI2/lv8Z24Av
    rpSAYz/aARsTWMsDa8zWuZAoe3qNR2kmjNMf6jT++F9OYJqAnF1J+WStjpy1o0L5
    vOqv3GkhiHXVhQF3gT7Ei4Tkntdy0WQC0p1+tKjW3m6A7Yb+8FsrOAy7y+WgG4Eh
    0+MWobSThrtnb1KJfVwZG8EamurtHtglSaKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524840763;
    bh=x2ZE62Mvc11/v3pJACwyie1mXrcXzlo9RId/F31e0Jw=; b=dGY9DyauotG+
    S5MSm8W6/LI4G48laQ78KI8RKNj2rchAfoVZ1tA52nh8Sf74xRHICSnCUYHOdpGL
    4ne0XJUcRZmdpUa6f6FADqrZoydpdvohMnBdcFTvClIUJFqpxemyREULkqHLYjDN
    EmOwwAEt7/jcSi4DmqDnKYLCGPgW+BTzBmhxpVgEhekEDNrES1VWr2oAqjSoAVbw
    uZulvRgOraZexa7T7iV3pCjPqAAi94234sfvOeEFPwrYEjdxeG4C5EcrMG/oQ40C
    RVIFViFLTyP71C8jeUWMMSCR0919N2ChQ1TkExqGIb/dSn6RYc9E9u13q8z0SND6
    i+FS1LYyVg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPyxSTKvZZEtieKCIb/cV3EtcwiQtKboa0ULjhRDPJ9nRurk04SGx5kK8av2N/ZTYF239vsb68nDa73xZtXBjD9NlCc+C0lo4d1KrhwyivYeWuCzJYjv
    zvc1QHtB+2Apag7IQyZGPrCtGUXzVnsdkSlngVav1GptcqCARJ1FMzfMe363TBtnBaEFHdBNKhEHQ9QXwk2IjK815fN5bf7uoBuJRWFe9zb3fyCwndrF4pWL
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=ag1SF4gXAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=EknxJscgKnilBMqQVKAA:9
    a=CjuIK1q_8ugA:10 a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934312AbeD0Ow0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:52:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:39218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934268AbeD0OwY (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:52:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7080C2188D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Fri, 27 Apr 2018 23:52:18 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Jon Medhurst <tixy@linaro.org>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "Tobin C . Harding" <me@tobin.cc>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        akpm@linux-foundation.org, acme@kernel.org, rostedt@goodmis.org,
        brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com,
        stable@vger.kernel.org
Subject: Re: [PATCH v3 1/7] kprobes: Make blacklist root user read only
Message-Id: <20180427235218.60aec544b20f7abc5362482d@kernel.org>
In-Reply-To: <20180427065611.GA4361@kroah.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
        <152481120919.22588.16126591608892708741.stgit@devbox>
        <20180427065611.GA4361@kroah.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 27 Apr 2018 08:56:11 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Apr 27, 2018 at 03:40:09PM +0900, Masami Hiramatsu wrote:
> > Since the blacklist file indicates a sensitive address
> > information to reader, it should be restricted to the
> > root user.
> > 
> > Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > ---
> >  kernel/kprobes.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> <formletter>
> 
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.
> 
> </formletter>
> 
> If you want these to go to the stable tree(s), that is great, but please
> mark them properly.  As you did it here for this series, it will not
> work.

Sorry Greg. I'll mark it properly for next version.

Thanks,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
