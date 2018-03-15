Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4181139-1521109199-2-10080745644708694035
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
    t=1521109198; b=jtX09M1dIFdVtX6HXokVKKmdFgymPiDffbxrtb2HmxM96Ww
    tPGDPiNPGXidsZeyFBBUsvqLf/uCl4kbBzpWj+6UlXJGiiLaolnK/BWWKSp3r8t8
    IpRYbKKAytOlmJ0VordchZD7S7w4g2tLXyRZDu3ulZBAAKUkxCRPlUrAJbadGZdp
    sU8bQQ+k7RyF/T9vZzECm6XHdsFNtkc+HBOPjCLlJk8+NSGb8SDj5BfsLTDaEW4V
    f8yYpSfq4SkdeM72F/HuaBbT2EBdqpNpm//q31RPe0KMBY/IZO5pAoxRUgXHcUfi
    HGsh4PSylrbUjxd4ObE4ZFkkOhSidKYGjIDYmmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521109198; bh=BAOhjF/
    ph61S0DoG6j2GkGDtvubcdM4nYWBM/7TlbrE=; b=uwLTL7URKtxqG5yzIrKmDm7
    uYQT1nUMzmuSKBJxo+9Dv1XDsICjQGjc6tWbSfFSRlrRjVwkCCw/r+47nHJ/xuCc
    M2qvZxFweimP8w/GajTxtv7ZgfHThffPG/wyQx7D055nCUZ/Rjs8fg2gv6iZAUap
    KrCt9ZNbZuzlMDFEE+XtLlEMrabTDMHcWoh8nlfI6ThKVu1o5oJyODUMch1zRwe2
    4tBME7do+7xegpG7QdUQtAetW5Z0nicUBJ960rh3VUOoxfGfd+c9xSGcFwV9Gb/4
    LDpP2F/uLXmSXFj8zSabqeFpQgCjupBbC/ri9m6KfC4VnC1DnWB1z6wl/rdReNw=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751512AbeCOKT5 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 15 Mar 2018 06:19:57 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44832 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751410AbeCOKT4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 15 Mar 2018 06:19:56 -0400
Date: Thu, 15 Mar 2018 11:19:55 +0100
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
Subject: Re: [PATCH 4.15 000/146] 4.15.10-stable review
Message-ID: <20180315101955.GC2802@kroah.com>
References: <20180313152320.439085687@linuxfoundation.org>
 <20180314105625.GG32615@kroah.com>
 <CA+G9fYtf7-TD6Jvt1rZwwy3+PrHV==WDciScaxQpsvAe5SE0jQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYtf7-TD6Jvt1rZwwy3+PrHV==WDciScaxQpsvAe5SE0jQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 12:23:36AM +0530, Naresh Kamboju wrote:
> On 14 March 2018 at 16:26, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 13, 2018 at 04:22:47PM +0100, Greg Kroah-Hartman wrote:
> >> This is the start of the stable review cycle for the 4.15.10 release.
> >> There are 146 patches in this series, all will be posted as a response
> >> to this one.  If anyone has any issues with these being applied, please
> >> let me know.
> >>
> >> Responses should be made by Thu Mar 15 15:22:37 UTC 2018.
> >> Anything received after that time might be too late.
> >>
> >> The whole patch series can be found in one patch at:
> >>       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc1.gz
> >> or in the git tree and branch at:
> >>       git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> >> and the diffstat can be found below.
> >
> > -rc2 is out to resolve a boot problem on some ARM boards:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.10-rc2.gz
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm, qemu_x86_64 and x86_64.

Great, thanks for testing both of these and letting me know.

greg k-h
