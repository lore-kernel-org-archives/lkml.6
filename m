Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1459126-1519736962-2-13145738684499652933
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519736962; b=s0JaTsn0yZtlxMWbeN7CLiCNDYUVvDTfVYULNXQ04lUFeLq
    xkgvWWBO6gFj/UMdSZuX5gGqKsimcb3LQ6/m1kKM4Cy3eftZCphee/5Vlhc8yq42
    JvFwJXYP2h+JCT88ykbnXU4A9+T0zbA7ol12xeJGol9fSK5NI9YV1wva3ChgeoOI
    qE27Y8/JZeuKPUaWNUs9bZCX4RNsxGAKkrsGAQ/xwaFOGayFynC4XQLB2YeP94rZ
    Bom1HzK1FSTzSxaiEAwpSGx9KbdDEQDxKnMfVDSL1U5NIbsVQpXS8LQ9PmO/kBKF
    RlZqzmDaj5MHzHN7VhpytWOz8Sq8DGtQW4rv99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1519736962; bh=cjWE/EK
    0KBM8C3xZF/SZtnTGc80I71LzVhqvmchCqJI=; b=hCdh+voDnMaYg4TzBcVv2WL
    J3SH3onUCojJ9n4FvEqlgjO5WxGnIDws7zHZq/wpoYRkfag/bpVWZG56XU15IZvx
    JDsoseFNGIa/t85LH9cuv1YC+R/UuGwWhM3QnJexwaD8GiWD1KGLnPUgIeDueCPw
    Z5Y9Ipo29fNsAhCurYBndfKGJ/Rt2Mq1GkFY9kX+pPmlHsfwuCzcRgDU5QMhEwpS
    Wrbiu4ZweHlXI8BvqAT52eYPkEkghvM56RzCBGeX/q+QTLidt8IO6M2xjwOW+UcH
    ocbU1G6HshmOHiZ7NJtes95N+S4ngAlVRoXgEWrIzdrBZqzPhB+qqbxKudhwyow=
    =
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753170AbeB0NI7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 27 Feb 2018 08:08:59 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:46674 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752676AbeB0NI7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 27 Feb 2018 08:08:59 -0500
Date: Tue, 27 Feb 2018 14:08:59 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/54] 4.14.23-stable review
Message-ID: <20180227130859.GC32493@kroah.com>
References: <20180226202144.375869933@linuxfoundation.org>
 <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d4f09175-d9f0-6251-ef34-14934fce5186@roeck-us.net>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 02:59:39AM -0800, Guenter Roeck wrote:
> On 02/26/2018 12:21 PM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.14.23 release.
> > There are 54 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Feb 28 20:21:22 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> microblaze, m32r:
> 
> include/linux/byteorder/big_endian.h:8:2: warning: #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN [-Wcpp]
>  #warning inconsistent configuration, needs CONFIG_CPU_BIG_ENDIAN
>   ^~~~~~~
> /opt/buildbot/slave/stable-queue-4.14/build/lib/find_bit.c:176:15: error: redefinition of ‘find_next_zero_bit_le’
> 
> v4.15 is also affected (m32r builds in v4.15, though, for some reason).

This sounds like Arnd's Kbuild change 101110f6271c ("Kbuild: always
define endianess in kconfig.h")

Does this problem also show up in Linus's tree?

Arnd, any ideas?

thanks,

greg k-h
