Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2005596-1520009896-2-14180503538923482495
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520009896; b=BGsUMc/YTLemq7EQxF+UkgyW/dmjN3/51Ap8M7Bvbgy+KSa
    dQqvenY6CITa7PTyUX1idpB0jEpcvsrcBv3HOORaGcyPA/7Ry4YjFsi1L18E4E2C
    7xS6N7zb2kyRzErLOQu7Wuf7PbGPmyGSpD0fbVSkvVmVJIEef4aP/GIKFGPpz9PH
    RMWRXkyDT9Khp1bok58jGPbfIrL5cJapanVlR56YIrPc9ke1zKOCGl+Bbk2R0dx6
    T1rvdZRS0tXvq1JB+xsjK9BHsnGnaoHW2CVKKDjfClCnMpjsoSapI6v33uKUTEcZ
    rmyRuMC032LTWxAKl/A/GbnI86hg3spnAU9hIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520009896; bh=d3t/iC/DWqJjGZJH+gSLL735ZB
    G9dMpR/CC9mCVgtTc=; b=NNAFFLneuO8v97uJnj2LA/MtjzZ0tjnS4j26ZMQE7Q
    5TXQsICeYBYGxS6hP82Hvr5ri2rx928X7b/nl6iWCHkwE0jI6sHLBnCfEFykVMsz
    VWA+2RuD/TQz1gAeqIeJqrDQ0m6u75QROARMwph96GUixp8JEJ4dsMLFxs3XFGwc
    wHW4832x5OgitnFU+5HFWR8nOjLsN5B2PBmFhkuFSyzCpl5d1TOJxSboveRGeygP
    3ZQFqz5grRAOHIfe59WvVo8il+HzUcnkrwgS1zxWevAjgxp00qmPNwAUPuddcpO/
    ZoTOkTKZVWTa9lBdtMfURwwSCwhpFrwJLbO7eZ0dEIAg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034460AbeCBQ6N (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 11:58:13 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:51790 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034433AbeCBQ6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 11:58:12 -0500
Date: Fri, 2 Mar 2018 17:58:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dan Murphy <dmurphy@ti.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
Message-ID: <20180302165812.GD8704@kroah.com>
References: <20180302084503.856536800@linuxfoundation.org>
 <735255b8-7ba8-e94e-8dc6-c739275b58e5@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <735255b8-7ba8-e94e-8dc6-c739275b58e5@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 07:24:09AM -0600, Dan Murphy wrote:
> Greg
> 
> On 03/02/2018 02:50 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.24 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> 
> It seems we missed the patch.  It was supposed to be queued up for 4.14.24.
> 
>  ARM: omap2: hide omap3_save_secure_ram on non-OMAP3 builds
>     
>     [ commit 863204cfdae98626a92535ac928ad79f4d6b74ff upstream ]

I don't see the request to backport this, when was it sent?

thanks,

greg k-h
