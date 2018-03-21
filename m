Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3734533-1521630490-2-6274388136512088585
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521630489; b=Xdy1OBtSWT0+8+peKB6eY+akbeG4w6KElJeg6AylsLchNkS
    M1aHUfCyKRUlwre4lc8JmqMnOqsn+qCfEolinItOoUOECMzcvyfVJ8swWBKo7G0E
    wX2Y0RB8oE5C1nusgoe/4Bxg474QdZDyaGQ8vEg48GQ1AJRN+0qwfIBA1eCuo/1K
    4jSWBEuKTW5dDLRRF7NJrGwtkeIfYue4VLISIoi0GXs/gW3aEOExediAsivOcqNW
    LW3IWj9RGS5gh/kh4369Djy3h5VKzSgqX/QRB/zHru53FpLuD1Gayi2I0X9clV87
    thtIlfbI9tHmHddJyunr0N7GYYI1mLMqR9+bnzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521630489; bh=rMEmeBz
    EVAUInfBUKRQx07NwJ4DZrJcxVhDPmqDNjDw=; b=nYWB+lIy0fjfueNNWrWndzX
    C97WU4QfhDobPiuo2JevLscAmAusEXoJanfjxX80bkHXsM5EhLaet23XlUvTkpxx
    /R6bSImiEUT1iOIWZkq9YUHFcnJ7BjmCyADEL0G66rXYNAvP6iLeiLBL4lozxcdQ
    9AwAlCZkVZE5dXxk7P10rYOvWs6JTPJzzBVfwN7JT7dcpvKkmayL1w93Yn8q4VMo
    K6H/tMfvgF5Yv1wlp/bhnxEKKIjo4/m1Z09IlE3jzoA8gj8LuMIAjGknbc5hvSp0
    CrrsUOKl2C89okqY520EGxbcBPtVMkxEwt2Cnz21iZ8Q6+hlNKwnj4+WUOp1lOA=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeCULIH (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 07:08:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751691AbeCULIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 07:08:06 -0400
Date: Wed, 21 Mar 2018 12:08:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: =?utf-8?B?546L6YeR5rWm?= <jinpuwang@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        "v3.14+, only the raid10 part" <stable@vger.kernel.org>
Subject: Re: [PATCH 4.14 00/41] 4.14.29-stable review
Message-ID: <20180321110804.GB6889@kroah.com>
References: <20180319180732.195217948@linuxfoundation.org>
 <CAD9gYJJq8Bpc_4ACt499w+B_yW7Y1gALnevr64NmELNa6_uOVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD9gYJJq8Bpc_4ACt499w+B_yW7Y1gALnevr64NmELNa6_uOVg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:31:19PM +0100, 王金浦 wrote:
> 2018-03-19 19:08 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> > This is the start of the stable review cycle for the 4.14.29 release.
> > There are 41 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar 21 18:07:09 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.29-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Merged and tested on our test machines x86_64, no regression found.

Great, thanks for testing and letting me know.

greg k-h
