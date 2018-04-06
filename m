Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1200889-1523014977-2-571206708349807050
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523014976; b=D/F0JZho+RDnwaeohqkGFmgSx8KbdBJ8pyw8pAfR0W2bWNhIxj
    qr9uB7MX98heYh8RdcGLyY4OcC3LBffh3eWgSpVrtmEi3mOJkoNgz6Bt8L2bpDJG
    TDZipQxgwuB9PH9IOOpDZnvdypheq8ri/bZPKlX0R7xlRhuxw6tsEU1I0WiSvm4t
    6TLIlHtBU/HacLocRhshJM2bRIdrnZ7Ui9IMIhi1trcrbNjl9fd5yEob+BYDMT9e
    pqav1adSYoxN8b5ldqn2wWVMx+AdDST7LOHJkICseIUtSABrdRJTTVNzR2OAuT5v
    HcuWq1BN2hyAgZJfvGCQ1eL+NxbUovgt7xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523014976;
    bh=6hS2U0mslBQYLqp//wsHxUFiQB9+GQdjceGBq98WLfw=; b=tzbzsVUZaYwM
    Mc0BUcUM/8S0c+iSIuZBhQX2IN6wNMP6dEeIx6CTsSRaKlM8a0bVt9XJvbh/iHa+
    q0CKagzC9kbNhGIYB+9kjx46ZTpatz+EZrytuP3FAuSLBEFoi9ClpNY1pf0nM4XX
    AVx4zwucjVPV+0J0rmWrd+bvoWLlRvn7Kblu10awk5DReFZNp03uhqf9eAZUeiJK
    un+rQKnrm4COtOTnoJ4hOvugTUZW7MzpIgB0aPBGYyFJauXaPeRlc2ZyjpwGqTZ6
    F5aJyISz1kNCN5tUWTGfguEcgrqo9sVvmxabOqCU0i14cpgGK/NzeK9cfESTkEfz
    1VK3rm11kg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lxorguk.ukuu.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lxorguk.ukuu.org.uk header.result=pass header_org.domain=ukuu.org.uk header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfGK276sdm5TjJcctiW2p+5P+MyJ8UR7MlNIYU6HhgsAIgSXsMSwMRbZzmHANHuOsGXnCPyP27uxoYyedIp5SVmlSqudjxMQslHVVX1qHNgSOVdEcKjpF
    1VNGOt3Dzw3YW5P2P7lydsuuNS93ET07PUGlnspsaBd0Ly7fK1D/KoFKkJ0Cffr/6o9QId3Wo31lmUuHnihgfCjQ1R500hdTwieucLy9BOLJYkkq/EjnSYxG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=rPFsBPrGOvww9quNL9wA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752370AbeDFLmy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 07:42:54 -0400
Received: from www.llwyncelyn.cymru ([82.70.14.225]:54238 "EHLO fuzix.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752365AbeDFLmx (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Fri, 6 Apr 2018 07:42:53 -0400
Date: Fri, 6 Apr 2018 12:42:47 +0100
From: Alan Cox <gnomes@lxorguk.ukuu.org.uk>
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: linux-serial <linux-serial@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        kernelnewbies <kernelnewbies@kernelnewbies.org>
Subject: Re: uart throughput
Message-ID: <20180406124247.551e26a9@alans-desktop>
In-Reply-To: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
References: <CAHhAz+io6_dS=+YO=Zd9rYuPomOOFtd2GsweKyvN1A4zKQZOVA@mail.gmail.com>
Organization: Intel Corporation
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

> The primary factor affecting UART throughput is the baud rate, apart
> from this any other factors affect the UART throughput?

UART
CPU power
interrupt latency


all the usual suspects.

> > For 4000000 bps uart baud rate, what should be the theoretical peak
> data throughput?
> 

Depends entirely what the uart is wired to, how it works and how the
driver is written. If you've got bidirectional communication going on
then you also need to consider latency and windowing.

For a raw transfer over a decent UART with DMA with no post-processing I'd
expect you can do the full line rate but it may eat a lot of CPU time.
The uart code isn't particularly optimal for that kind of usage. It's not
impossible to fix by fast-pathing the non N_TTY line discipline cases but
nobody has found it a big enough pain to bother.

Alan

