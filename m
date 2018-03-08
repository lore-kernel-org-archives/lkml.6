Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2448136-1520529992-3-12873855443785951318
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520529991; b=eDstRo7c9KywM/XHFkUIruvCWVzdZmfi0/hFkn5+QpYtF0T
    4YIpbdyp8FcdfbTydprbymBA3ZGCpGXVAM+9g8D++z04dzX2A788yUgqzHF5oQ6o
    oY3aVNsh/naKEQL87Uqh4oa0nOxP1e2O+yFwhz1biRUdf3VKYdfepOkW28rI08Rq
    YXGhyHlXl8/vQDChBs/XmAMJY+UcvR9N4KqCQ2VD2fA/43DAhfFSRekIdM1SS6Zq
    nmv2Cww7J0k7tYDKp2SMS7lh0sprSulG6p+gkedGSFSCpJiJVB8XxDtfACRPQ/Y1
    KT5fz5ETyKBTv+B2DYnxPbs4tuZslTVduVRRStA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520529991; bh=WPNgQrfw4LlIqCLDoWo9kCmdLL
    AYk3QuTgauSePt8U8=; b=Aa271gGTxJ9MzNuMPAXBFvuLCp1nkGqGhQOpygvinI
    ytZQPsRlmfmQLGnV+XlZcwWpLl3f8Pmd7sPAci/ISbDMNlZSQySZ8AnVoduEhFXs
    sVyO3IbjQcBN0CNcFeI+W3wwWINnCwq10T3k2k6ujpnNU6I81YVv4Xgj6taGk5GR
    mqSlslMnXdkl/Y2ftxOTqZfAaifiEGeG+IrNK6+Lwm2Hm6Du3pK8nm9bwBJbN/XW
    CyUOXyZI6+ZtUCjEIE9NgCrVRDxv7bNbwLKOT1624sWp1WSvwPPky9610EY2eeLs
    G5YxBMyMHAl472RngabdXSpW/+8tdx+BdI2RxCU4TpXw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754542AbeCHR0P (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 12:26:15 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38516 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeCHR0O (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 12:26:14 -0500
Date: Thu, 8 Mar 2018 09:26:15 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 000/122] 4.15.8-stable review
Message-ID: <20180308172615.GB22996@kroah.com>
References: <20180307191729.190879024@linuxfoundation.org>
 <ac613883-0310-9af9-0025-d105511d6d05@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac613883-0310-9af9-0025-d105511d6d05@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 08, 2018 at 06:48:59AM -0800, Guenter Roeck wrote:
> On 03/07/2018 11:36 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.8 release.
> > There are 122 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri Mar  9 19:16:43 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 147 fail: 0
> Qemu test results:
> 	total: 141 pass: 141 fail: 0
> 
> Details are available at http://kerneltests.org/builders.

Thanks for testing both of these and letting me know.

greg k-h
