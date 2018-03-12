Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3903807-1520839953-2-10659243273708347798
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520839952; b=Ezk8UJRFoXX1YqgsREOMYSfXDUX/HmK2rqLWYuNiUjMcnlr
    7+JjI2E+MBAjFMYxCZHmzESlx8WCJYpqPJJ6GUdexFiw6KLUwY4DlbKFN2pD53H8
    pdZEYt5uH6RkONloxXipkkG+9R3+o260+BJOeES6iUKq6oybOFn42KuWVakGw0Qq
    YzNPZxQGfjRDHmSq4maFLSDGKNapacgAiGaRdZFzR7V8wUpwir7m+PjAmiUifU9R
    iD9rzMzVilnRiegAad9XbtMgVPSAPhG0UdMh/KZbBnM7GQjg+pT5k5vUQxocR4T7
    khYyGqulW3JhE5hxxmghrJcu5IQ5XrScsPZdqVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520839952; bh=YGwAieD2IggMs2RX26LbY7FyDNWproOaX9a1AzLJCNw=; b=L
    o7rFcgDBYkjeJfOrsGYOrRY8DDgwFSfNfkjrRKIqz91KEbg3+HkrxsaQIcrU2+HQ
    VlfiiHQdy2zrbAkhiVzkMh8fPtAkYTDefOiXmPhwKL0vwj+q5L5A9iooMwzF9Z9D
    V6lsdNhTeETDe14XbCBIEwAZalzhA5xehQMbXbd9yLjpACqFQbwzs2upgGm/Rz2R
    H1Jw4cfRZZtGYx8dfS+cfAwrNOA0i1U0PExG3QdI/YDoCpbEDf35lNbTIfBFEpdV
    5WPhLaGsiUP+ZJFQLWdJXeU9IemFE4MvK4XeN63XUqGQDl6Ole4wSus4UaN17fTJ
    e0HcJuWOZjlMputAf6DEg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i582Egt5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i582Egt5;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751880AbeCLHcR (ORCPT <rfc822;greg@kroah.com>);
        Mon, 12 Mar 2018 03:32:17 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:46038 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbeCLHcQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Mar 2018 03:32:16 -0400
X-Google-Smtp-Source: AG47ELsOPP+VEw9CItdwlZNd9wwxRNuj4CIUdhHGqPSWHRsYBPk51nlOv39ijgznIVs7Vb1aJF5ZWg==
Subject: Re: [PATCH 3.16 56/76] x86/syscall: Sanitize syscall table
 de-references under speculation
To: Ben Hutchings <ben@decadent.org.uk>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc: akpm@linux-foundation.org,
        Jinpu Wang <jinpu.wang@profitbricks.com>,
        kernel-hardening@lists.openwall.com,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Beulich <JBeulich@suse.com>, alan@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Dan Williams <dan.j.williams@intel.com>,
        gregkh@linuxfoundation.org, linux-arch@vger.kernel.org
References: <lsq.1520823972.93871245@decadent.org.uk>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <2a1d3a0f-6227-39c6-0ed9-a07c22424d67@suse.cz>
Date: Mon, 12 Mar 2018 08:32:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <lsq.1520823972.93871245@decadent.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/12/2018, 04:06 AM, Ben Hutchings wrote:
> In 3.16 the x86_32 syscall table lookup is also written in assembly.
> So I've taken Jiri's version and added similar masking in entry_32.S,
> using edx as the temporary.  edx is clobbered by SAVE_REGS and seems
> to be free at this point.

I don't know the state in 3.16, but in 3.12, I had to fix the 32bit
entry on 64bit in arch/x86/ia32/ia32entry.S (ia32_sysenter_target &
others) too.

thanks,
-- 
js
suse labs
