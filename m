Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-108815-1520460475-2-747587115246916545
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='iso-8859-1', plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520460475; b=cSrWxngEiH/EAp1stt/UYJwYHAg4dFS00KNs2MmTJBC0QMF
    ybFWKPJmODLPB9a2m8ZAbulAborH50mFGtoZVuai63HLDgpAGDDrFj129eYIbkNI
    jzeMsClXPlvqkjxOfPKx1rSp+oeni6h412B1go+dtnOwA8QsEC6BgBaRz2MzQ2Q4
    SPq4wuNbq2vOi3L1dKWfe/xWLhiK4DHx/gf2tHX8x0GA7VCnQ4WV0E9ArgB3Ei42
    i+wpxtKfO6atUYPaelYBttEHYBmqJU/Nbc1CbTxucVPs6I214flgucKB1SLufDZZ
    UIorEiWWurnhaeNcj+gGQU9K0uyQCSfbxlYz3UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520460475; bh=A1phPHtBHXV//3cbgQiOW36COf
    JE9znQc0H1nu6Ds74=; b=p3Qjrtc99joe0q/Zg2ZMGpH7KQIlSnHBx/k2YYT+Zw
    tF6c93epj5NvUgPTLH54AHruArXBe/VQ+Np0b0mKsKO9+rr6h6H3OIJ+CaIV+0+c
    /9vYaVORNCdSTwjQcDD586rLKAw6p93TKOVnhMTtpNl8j7hqBCnhdORG+jUfdYiQ
    yaOjyjuC0duU6bMTKWGuyh8WqxhRVGNG20wa79nsLSJMlw8kfKeEH9+VZ3wtclAj
    BukJ6YSpXkKa7JB8V6YwLbwtSOK29mkmOEqHlo7gIlp+ykjvH2xfKk8t6LgRUTOb
    X3sYD1zeZfxpnsSJMNoCzxxYu3QLAj5k2eeJvSLpAMGw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754052AbeCGWHw (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 17:07:52 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50010 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754039AbeCGWHw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 17:07:52 -0500
Date: Wed, 7 Mar 2018 14:07:52 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paul Lawrence <paullawrence@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: android: ashmem: Remove deadlock
Message-ID: <20180307220752.GA13844@kroah.com>
References: <20180307214042.135109-1-paullawrence@google.com>
 <20180307214829.GA15587@flashbox>
 <CAL=UVf7Y0Ga869u66xi0EumQAkULAP0fWf9O69Z0vYJ9G5gmcA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL=UVf7Y0Ga869u66xi0EumQAkULAP0fWf9O69Z0vYJ9G5gmcA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 07, 2018 at 02:02:13PM -0800, Paul Lawrence wrote:
> Great! We need to make sure this gets backported to 4.4 and 4.9, and to
> 3.18 with the original dependency, please.

That will happen when it lands in Linus's tree, which should be later
this week if all goes well.

thanks,

greg k-h
