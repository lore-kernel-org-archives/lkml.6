Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-716958-1521531959-2-770665638650567383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521531958; b=g6yHEqRVGvHJEEcUGi8CU/B92MAQvq2fhYmoX9oOmcATjLt
    NrBQycc8LpDnU4/jVLdlzY/G9LpxFoe3qln8VdnJxUee6eBfYGS9wtTOucjuTnlE
    k6oQoUsQPt7GzzOr5aWGbCTdyHa3hGaPmKZHrqjKi/p7WTYaCUJZTIjAHcmsgPr+
    9ZzF1wgTisSU3Oo+jlgNRjgPnUnksWZiwI4RgKXQuWkhT2hHCzQbcWqttucw4ZhN
    QPIlvNvf5+UzSK+jKULqu5XMmYiTCIMFr/gEKD6jppTppY/7i+7IM89nz2kNAFLG
    5ToR6yFF4183Nnc0kl6X/3cjK69CRs1JCCirKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521531958; bh=RmJ3puW
    SpLmz0TpopyBXFksWPgfMr9nIloQW9UVemSg=; b=sJp4RmD08qe6H9dxpcBtWAz
    90QXA37ghIoKcrzQZvnM2iLsyP73VbZIkB451LhVTs4gtgvpSM/rU4VEQo6HYqEM
    qknxEdhkAD/oLHztDKpGXlu2zXQ5DrA8o4f055AOPu9G8tD/EM7jA/i8iLqBChyJ
    POqc6RIilnePC6SI6KKTsBsTgcfCZlKIrARh6AogHODz2RLyBDUfWg79gzQiJwSk
    of1Ai+5rDq5nB0t7S/o+9WQAm7tqtPRnq4mSgvPhkqP7e6vDr4Cp0wfahdQrG9lO
    oMlpVC8IePHt1NNVkT2etXmDHcqV2jGHVHPOHbVmlaXjkctvC3+H/qGuL3FDfHQ=
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
        id S1751546AbeCTHol (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Mar 2018 03:44:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39090 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751659AbeCTHoj (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Mar 2018 03:44:39 -0400
Date: Tue, 20 Mar 2018 08:44:37 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Shuah Khan <shuahkh@osg.samsung.com>,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180320074437.GD8152@kroah.com>
References: <20180319180734.976730813@linuxfoundation.org>
 <CA+G9fYseAp4pE3Akh12_YwkqP_zTsV0qcfOrCWY27cgP=vBe3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYseAp4pE3Akh12_YwkqP_zTsV0qcfOrCWY27cgP=vBe3A@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 02:47:07PM +0800, Naresh Kamboju wrote:
> On 20 March 2018 at 02:07, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.15.12 release.
> > There are 52 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, qemu_x86_64 and x86_64.

Thanks for testing this and 4.14.y and letting me know.

greg k-h
