Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3869068-1524812185-2-12716825056989169031
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524812184; b=UbmPEnLbQGF/KW4Yt0c7PXaoiddsO2ELHbfg5+qI1DwFwXAI4N
    oj8myXNKNEoC/kZT9SC5EtuQlCgOAzVAoZ/LEzc0f6iSGpQU2tqHQxpExmr4KxmR
    RKwpTNr/9G6LAqNDkDEips+ufvmcRtd8RxX1F3AtyJoC2aB78j6+Z6yn6o6mVpvN
    yq6pP6F/RcTm45I37H4fGzdzEZmRimtjXYGT/awbWyWyaaT1vhBdc0R05nV+yQix
    kJJ51uVUgJxSITpzzggd90h97Q92exeQvSgpvNW84r9aCzYbCp+g5vInFA3tTkq5
    p5fQNaKtd8mUPzoHZ44Ea+ZO4uCb9W+ctbZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524812184; bh=m25hq9DISY7z8LstVoIp3llf+nmwRv
    /ELrKAI4SHmUw=; b=HjsrLdrHHTkyFolC5uWGhSr9C4bYYirs4tip3P/WlDytAT
    8/mMPly8MDpywk+PX9S0Pt8UNOvdSuYn7h6q8GAEb6uCSoWrjjSvv1RBnflGbfX7
    aDACFbV/Sp5Q2O0j7G4VzHBWkgam0+UPAEOAXdYgGwstdwyDJr1lQZqzyk53vRo4
    lrPcoj5y9ISYumHtLfpz4FdYt833+iiGs4IQdyDT0bvoyuaKOqS4sMUK9LSgY1or
    STav7eDweNJj6jdqY/jpbvsLMUL2Q9ws1SwyDkUxn08S6Yo4RzoKSf6mKHkKENnw
    IAzGuYIFYx073wGDO2W7oBEMHIbCJft5p8CkdXRw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEbXSJZ1+T5P+vpamkjcUOAgFoM4FZ/v39oREoJYstvp3fNvpfcEoYFSECqZcvxh/Hg6bjrT/YFa7Lb3rmXZhYrOd9LgR4gUnwV/kAd2gG56y81KgntL
    sa2zjlNHnKbBdnzfhOxlRLPVE7jTG0KS3qqbBo9ER/KQRA0M50NWUy2vefGXs2XBaTCzvklxvJl4L1ZcGtoD5pxCB5C4dt4tkfZDYVr8+/qwPCFDcgujSkNq
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8 a=3re9b2k1qhass2TTofUA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757414AbeD0G4V (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 02:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757283AbeD0G4V (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 02:56:21 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5CDF214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Fri, 27 Apr 2018 08:56:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20180427065611.GA4361@kroah.com>
References: <152481117776.22588.1210388093668905564.stgit@devbox>
 <152481120919.22588.16126591608892708741.stgit@devbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152481120919.22588.16126591608892708741.stgit@devbox>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:40:09PM +0900, Masami Hiramatsu wrote:
> Since the blacklist file indicates a sensitive address
> information to reader, it should be restricted to the
> root user.
> 
> Suggested-by: Thomas Richter <tmricht@linux.ibm.com>
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  kernel/kprobes.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

If you want these to go to the stable tree(s), that is great, but please
mark them properly.  As you did it here for this series, it will not
work.

thanks,

greg k-h
