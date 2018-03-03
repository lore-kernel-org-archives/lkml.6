Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3941094-1520067565-2-14596951002398010942
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
    t=1520067564; b=VXlL2VIwHsdjgOrUF0b/CWiYmiyEjUikKPAGVqmwISAsDol
    Wm5VvCerxsmD9DRFGmDn72g2wjTr+dZfNQ/muXy+cXZKuP9hzkDRdNG20VqkIEW/
    hv3FKXWU+S/nx2ooAPPTXYC3BSFl0h4XOux/L3US/33dnD7lvvk2mCekK4EP8Dkc
    FtC8qshd2dcHoMfqE0q0vMQEceO55huPQYAtI9LvBoG56guk9hSQEE89Iwcs2B/U
    /d8l8ZemMUiUPwG0uLsFzg7Oh+7i+1yZd6jS2H3PvyhJXgndpD8/luLq9oyyau0R
    CMmCoWyeHHv8ibxaf6w4wKNi7bjtGhYQM8B+ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520067564; bh=INJIIqc3AD0m2xEfqzQyg27T1z
    m6aGHkA7a9/h0jnqQ=; b=Wvpzic+k0aKnjDOfpR02iQaz6yARKVUMdXiGXTjXsK
    XYzwqn/JsRR8dwhcSxVqpaX8WMIN9tZlQevBtR0R9rftTNbP9+sHaNAo6J30c+fM
    ez1vtxIKImXJch3xue+K//sf0PPIMAK9/ycbkwIiVDsr/HwjJHbZlom48rt/L0Jx
    jlXh/hsdVj+2NKw9ZfJJFKQRgzicBcPqg+HHE/4a3Z0L0rflI3N2WeFyA6PsoSlK
    OpVedkiQAcZ+nrd6shqLxxR7Tr08QkSVYvIqlTXFZdZuvhYIdwPdWer9NxIMEgei
    yXKFvTGrPh/imXXuAYVxw5pCNjeJ+5ksoTUJI/AlqxxQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751821AbeCCI7X (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 03:59:23 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:35814 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751568AbeCCI7X (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Mar 2018 03:59:23 -0500
Date: Sat, 3 Mar 2018 09:59:21 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/115] 4.14.24-stable review
Message-ID: <20180303085921.GC23988@kroah.com>
References: <20180302084503.856536800@linuxfoundation.org>
 <d26769b0-5a4d-5dff-ee8b-54482b89df4b@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d26769b0-5a4d-5dff-ee8b-54482b89df4b@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 02:29:01PM -0700, Shuah Khan wrote:
> On 03/02/2018 01:50 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.24 release.
> > There are 115 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar  4 08:44:32 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.24-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thank you for testing all of these and letting me know


greg k-h
