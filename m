Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2147157-1519756468-2-1627346633459034794
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
    t=1519756468; b=A852AlnZ4a6UVn4D1HK3F8oFaUwgncQZqV5OSw/NXGzdxNU
    VdyzF3d/SKaXNHXwaTuh2QtLwT+eia9HtA+r2X4w2RpizULg3IRRw1dAdPuQa4Cu
    eYCJULWqDkgkqsUY5OqFxbmCrwnaMY82qiYlSgsWx4aBR2COV0QMi9ixAxx+EmUH
    XdrttY7vgzaZxcpRf23W5rZ6LectVyqKXAojaioO4XXMrO0Xc44vNpMCxShaDB7Z
    a/6m9VU6uA2LlQr83AXk5R+/5W9QR0BXpxC0qiuce28vs/gEoO3CIrECDuwfb20r
    h4DE4Hq9y6qfdW9DjJ+qFIXJUvr61m9epOJeC0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519756468; bh=cvuiY5hPXzAJBT6Ke5Dj9sepmL
    yGO6GmE3W/YPkg18s=; b=TmxfxhSQrR/oCPyrekSbEPyvmGyutxlHJVPqh3W1n/
    pc0L5NvMUH3gT4WIRd1Mfqy91o6+VFhdDCehnTrSoBuDV0B43XTK7wQoHpbNBkCe
    LNMCkhJ9iOMy83wLsVUnDyXNDETlXnt7qQT+ntNTlwmMw9h3bETLwiKf6g3b91R2
    GtIqsPP1KAReLltBqCKrcvoRPDvmA743gnTnGeCkub6iV9kxEt5n44BcECIW2Zky
    1rRyzW+sJxZ7q+17IA9TlFh7oNO4vamgpwVvnZQvbRLlJm49spPiMeSjVgTRZ9im
    oj76cWdTz/REjKuaqM4g2orvr+xQFgJKtjAHL3W7qMCA==
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
        id S1751791AbeB0SeM (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 13:34:12 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:56990 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeB0SeM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 13:34:12 -0500
Date: Tue, 27 Feb 2018 19:34:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/39] 4.9.85-stable review
Message-ID: <20180227183412.GE20601@kroah.com>
References: <20180226201643.660109883@linuxfoundation.org>
 <e6e1abd6-cbfc-d54c-fef1-ef1acbbe798b@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6e1abd6-cbfc-d54c-fef1-ef1acbbe798b@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 06:56:09AM -0800, Guenter Roeck wrote:
> On 02/26/2018 12:20 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.85 release.
> > There are 39 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 28 20:16:31 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 145 pass: 145 fail: 0
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Yeah, I got one right!  :)
