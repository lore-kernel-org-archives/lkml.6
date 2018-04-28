Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1303162-1524890175-2-13608660055309396046
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524890175; b=GFf8PAHXdSnIslkiDm5IKk/6HnN8HZ+4/yUEq05+JfiBOuczAU
    AtQiRk/PR4h/4ZVgdgE+HARMzGR1XzecyVkwBPMjck/ES2/aImFhYFKTdvNHdLC+
    +SLTpG43rNVj2FL1PoxEsSojwCjctN9RjwnwFavDNarPUnPeKuAnvjjlakTKAVH/
    h71AS4Hdeclw1yd7dsg61xKhWIAUmn1861JjP93GPij9gBTMeZqO5XQOhuFGEHRx
    b1ObMydwNt/QJIjrUCqZiwiUo7svKTMI+iTKNg0puhyz+q6MMCZ55Rzb8o8Eo0MM
    s4e5miwDb9/S+IPn334xsqqNwl1weSeoHa7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524890175; bh=b0BAbj20zosjqaU2DVOqpufXE71Whw
    rnTjPQk51ruW4=; b=dddCQz8cR4EFszQziLhLqSrMLQKBpMhk/s2Zc5ptmqDCeI
    Puzd+S+azt5aga4WVbPu6Hfkg61hr6bhEPFOl+UwZ/Ql89k6VSBjw7IKDg1Z0M5c
    8SMvZIrvZyckud6QjYejDxHXnKY2kqHg8sx6BC9sJ3dlkPfYqHeJEW6s3xQGMl30
    0AgfOgvT8bWvGd8yuJyWOEpC2oKULUPZudhnK7izsA/reDGUxgyEqTlZi8CsGjOj
    CakLIvq9Y7tDvp4RoStjD43lp91rz06aTkuA73qiaeqzTsWXvBpGa2b5X2rXKn7Q
    fN5XcrOT1Aqg4YsQpfGj7PgMCnGuBmrAU41J4AVw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNbKaqJRYPiI1CeBMuTyQunn+e8MolFy182GR5Ko7EDyw/KvieRVJUJWUbbgr+2rtCP0EiYSOqik0oAfB1ebMFGBorSzB2AeH4U3XMiNNKx3safPbUBm
    VwGPB7wCApURfaUjqh15VQQiRF7QySvRywsYPymARvm5fru00aV54c8HJZ6f6ew9cKPAsk63Symz6bcz58pwpcrm2bh1m7dMMqyTK2uMDdgE4k2NFOE8tVma
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=28HZq395EAYA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=Y0E5369zGsYJOY20M_EA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeD1Ef7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 00:35:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:40170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751663AbeD1Ef6 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 00:35:58 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2082B21935
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 06:35:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
Message-ID: <20180428043547.GA27835@kroah.com>
References: <20180427135631.584839868@linuxfoundation.org>
 <20180427194128.GK5965@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180427194128.GK5965@thunk.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:41:28PM -0400, Theodore Y. Ts'o wrote:
> On Fri, Apr 27, 2018 at 03:57:35PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.107 release.
> 
> The kernel.org page currently lists 3.18 as EOL.  I assume we released
> an update for Spectre/Meltdown after we declared it end of life, but I
> was surprised to see that there was going to be a 3.18.107.

There are no patches for Spectre/Meltdown in the 3.18.y kernel tree that
I know of.

> Should we change how 3.18 is listed on kernel.org?  Or should we just
> keep peeople wondering whether will be updates after 3.18.107?  :-)

Keep people wondering.

As I have stated before, I'm keeping it alive as there are still a few
tens of millions of devices out there using this kernel, including one
of my personal phones.  I might get tired of keeping it semi-up-to-date
and then will stop releasing updates, and reserve the right to do so at
any point in time :)

thanks,

greg k-h
