Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716958-1521532230-2-7770605227772477287
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
    t=1521532229; b=ARTv7M5EQyB3rbbIcEoBAbtIy9/30gyQOvsMJ+KeYsaV+8+
    cgAlUCGICMSzz1Sk451Lpps2PKsTFwLy1mUj7bAJCEla6LarIm4fUaHk5GXc+sPZ
    sUNRMgwnlaIc8gJgjwpSh3oq4ltLCHE8QcNVl9y5m6NA8VkRqDH9H4Epnaa2gw9y
    6+ntGpVOp0QsynBAXq4buvKu3R+4egH8+eQcPcVvEyb8Fy7lx5DGybF94gVIR+9Y
    eZ3df+7ydkM51NIIlydG3AhpQ80heW07Z9J03c/3/KbEzlrYhObS6pBP+fTpMCyK
    0kTuMxPB0bl85XGxTGkTs2d5h7GltxTIoMKzFvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521532229; bh=V+TxFC/4kwMVUdfCFRqfp61tzA
    5hE6/XGWcamELOtow=; b=qEfkKhvqOSfUXXc2HB64bfl/EDDRoq8uspRMUvibUm
    LVKTP+SI0866/w6Pv3VGmzrTaYmHaiVeCB1ERN068GdMGOZmjt7igF2MaFroRKdV
    rbkKOwqrzllFYWD8HlCpOWMvCE3bA1RPNmBvKzodCZgVwmw/OeYrZrI/XebW0c22
    i/hQaWItfnJxaG3M9PMZ47hx/ovqq52xkI6C4pXL7m4ZQdcd36YNtFQvSXE4Icql
    OtDR4B2RAxav6+h7kvAhrl8fc4KstBZrOtnxe/A7DF8ptBg9qea33bkJpo3jJK4w
    AN00fyQieGBhD9VTHCkzjUzbqmilCvcZSc1IN6AvK0wQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeCTHu0 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 03:50:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751826AbeCTHuO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 03:50:14 -0400
Date: Tue, 20 Mar 2018 08:50:12 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 000/134] 4.4.123-stable review
Message-ID: <20180320075012.GB10034@kroah.com>
References: <20180319171849.024066323@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:04:43PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.123 release.
> There are 134 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 17:18:04 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.

-rc2 is out to fix a build error that was in -rc1:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.123-rc2.gz
