Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3807972-1518513667-2-13160730994241270133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518513667; b=Jk7YR1VgCkAN5yK2W18oUPBkVFKbNJx8ErL96j8GyysLu3+
    vSaZpmjxTXuouv2+Ok8AlHRUp0cnqSA0sv7cwaO1hmYpgAUthc9sdbZOrq9RQGvH
    4WFqVlcET8+YZ1FSdX2rxcvJUqsPLaN1s7VU2Z9RJLYwycF43+5k/vaboeo/mjFS
    7a9z5Dm3YvArujqHwpoBISETxkVmCzyhrvOT+EpIVzKP/nU6hxOrCp++d5ezzQ9r
    r4TdBBTOgldO15px12GgjIFqIqOe5Tgo4KIOzSshowsd9LBmORNBpFpEWF8N9dr1
    0grSV9Xiidj3xfTAEmIRMc595kDn9uVjvFJXDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518513667; bh=2qLC/ymZWLG9Nkz5aoG8UmtieV
    tpaNETqluJfel1mc4=; b=nzVMhH31XJvNo7Z0YKFxh92UqbbUNa5k5FX3hpFosW
    Nbk+0mujvNXje8KQSCUZG/2rj0L+UTNE4lR0f6d9lJuyEKHETRM+SkrVYXKt0k/e
    vYyttGdQsjZkXtMG4zjBcZeOQQM4Gs8EwkB6M6TtNJwhV8pYeSFm9RZOBmofEeQq
    rVXZMdwgn5+vPJ5PocbIeyBG2c5EodBoJa2k/eyo10fxN3PSiWNScfVukz1mW+NK
    /thXKXnW1g9tPTRvgB8Rdu6TUFLlSu1gzQf4QbnFsKX47FtMxwo/TuFXBSGTOBGe
    9sG09aRTZXwMeOLxqUFqc1Kk5lHmR1CPSN24bowdstZw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934350AbeBMJTA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Feb 2018 04:19:00 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:50194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933494AbeBMJS5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Feb 2018 04:18:57 -0500
Date: Tue, 13 Feb 2018 10:18:56 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/23] 4.15.3-stable review
Message-ID: <20180213091856.GB13711@kroah.com>
References: <20180209133938.366024920@linuxfoundation.org>
 <cf6b8968-61ad-3670-6f5a-b00da980b811@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf6b8968-61ad-3670-6f5a-b00da980b811@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 10, 2018 at 08:07:16AM -0800, Guenter Roeck wrote:
> On 02/09/2018 05:39 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.3 release.
> > There are 23 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb 11 13:39:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 147 pass: 146 fail: 1
> Failed builds:
> 	mips:allmodconfig
> Qemu test results:
> 	total: 126 pass: 126 fail: 0
> 
> The fix for the mips build problem is now upstream with commit 24f8d233074b
> ("watchdog: indydog: Add dependency on SGI_HAS_INDYDOG") and is confirmed
> to fix the problem.

I've now queued this one up for the next release, thanks!

greg k-h
