Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2297825-1520016804-2-2804522325436781155
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
    t=1520016803; b=Yv5zidnzCYIivZmhaH4aSg9xTgIUQv8A9H9kz92axk6VcoA
    jNfWlQrqJW1FKlsLE5JZ1iAPNhqgpGDF+9TksOr4QHscrW4bx5+tWnzfa6oigAmM
    DWyJAY8yuXOtOrC4mdjsGK1IGQhNf0K8zFV07wOEIHTpdFEPrEMS+PRjNaH3zVKP
    vV4e1AperWS72Ie9Q6e2k85trpPh8snN8UsvjF+hGLW0PIUlzohwXflFsuWz9Y1R
    kTj7j0K566kDhnJQ36WDaUyGNItByG1R8Hiy4asO3YMKZN03udp5+mQjSmP0udLW
    GTHnj5mY8hvAyzl9l9yGCw5ahsgOn5wntEwxHFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520016803; bh=B5CfKyjInvDI6NQphADhbd5VG+
    bItcF2ZWlp3dw+uYY=; b=jjhi5J4Cjiowbtn+0aoXTlUv+Aki7Ud/Cs3r2vRsRn
    CLcUZldB0Wg8k8cwO2+Tr+q7MSt1+9ybbHwvZzpZZ6y9M4YyolsJ+76ULplwZm7n
    nX43zemB331eJ95pa59O3Fv6h6EON03Ag4KNTnnN+zYoc0s9idQ04ZwagvkEn8tf
    jdbIGK6f8/RtMrjwPpWoIlbPJxCWg07KrDi7pqKS8KEg6M7Pavo8GWuBHIO0G7PJ
    mXqVuh2TEdMzJ1G9g3laEZVOYz9PWAfHzisOluFFP8+aEqTrE2T7nDw/p+MTyi3r
    CJV85kIspzrp1RpKrptOCB/mg26cEMfcpzf+AO3II2Xw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1947560AbeCBSxU (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 13:53:20 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37332 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1947551AbeCBSxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Mar 2018 13:53:17 -0500
Date: Fri, 2 Mar 2018 19:53:17 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/24] 3.18.98-stable review
Message-ID: <20180302185317.GC16331@kroah.com>
References: <20180302084239.157503766@linuxfoundation.org>
 <CALpmF+Ess8+k+N0q6YyVEUL+YmM5m1rS2ORs9xyR=sZoYXTwHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+Ess8+k+N0q6YyVEUL+YmM5m1rS2ORs9xyR=sZoYXTwHA@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 02, 2018 at 05:41:28PM +0000, Harsh Shandilya wrote:
> On Fri 2 Mar, 2018, 2:25 PM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.98 release.
> > There are 24 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar  4 08:42:22 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.98-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> Builds and boots on the OnePlus 3T, no merge issues with CAF's msm-3.18
> tree.


Great, thanks for testing and letting me know.

greg k-h
> >
