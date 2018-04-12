Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-872240-1523535795-2-15086361717729166913
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523535795; b=eN0xACRRp8E9CsE9CRimennPloQObE78m994AphLIGTozuiNM/
    NzK91r0UTGwkN4caV7rbFbz0oQKQT2LGHNHDlfUuOe8gyUfksi1VA6h+1nXsi/pJ
    0VQWaFdsTumm+s0Sg1x2yGGKuCJaCX5d4cNZKG4bOxe4fH6ykfzuy5MnUlSSnnT3
    aSLUrne8MomJp8J3aqnYle6TBCR1u3WmKo5iEzmc0t//+QCR3M6/N1EQBYiEgwt2
    ClN53aM96lC3h4hEUo6LPq0bwAMTIuFruQNSwQApBREffzHMHuNZMPN1S6+N8kI3
    gTgX/LcDBlQozf9hbuD2AmH8qYbRbrmExd6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523535795; bh=aA7+cItW8Gc
    6/8kIbZZiEnPXOCAXKK9iIYRTx96wyDs=; b=HxzzoAHZ2oQQqkcpvRJVTPuV4PF
    S9Ktogur65Zmbdr+frQUXrt7ifIXvGt5gcm8a+xjyDpzyA5/gybx9jzAx7YbqLJi
    c7Wyudn4Agw3Eh/Cvm/1leMiiqKB8tj2tGKHyZoalr9vsCNOGUZ5D1b3RhB+JJTB
    sUx0GXStJE69LPU6rDw3tjuhnhiitAv7gaBBaz4WNCTo15pekFj6xZnczwJtmdeJ
    f0E/3O4VSrINimhCQ214TwdGwWNc9exj+PW946jW6GXUk1FH35zXZMJnRqwQh1Y/
    8iO99ZiRR5RgDmZQueoBDM4YbtED2QqE8s/jRZ5OsIf0KoFg4COwPQ71U/w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP7ZQ1xO1K3vDHjWyj5ixYsz4no5Srx12lAMlfNi4CmU8tuDQQTP4F7alIL2fu5Eq2SWl6kBnslIT5GJmDYe+hRbO2YtA2fukUqw4cWr8mPwE9IiBtuk
    oNVyhUAfLH9jtPN/LsdnOkNTQfv1uwXO1a1L8oEEBZIn1PKy4QVo8T3SmHx/8MJ1/MPWgVK1sWgwxeEAOLnv+6wHRgNDjvobP2ea5zQFP4AQBesIEiwcuQEV
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=zoehSAk54XIA:10
    a=Kd1tUaAdevIA:10 a=KKAkSRfTAAAA:8 a=D19gQVrFAAAA:8 a=yXb3C22XzuMQwtPDKmQA:9
    a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=W4TVW4IDbPiebHqcZpNg:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751870AbeDLMXO (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 08:23:14 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeDLMXN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Apr 2018 08:23:13 -0400
Date: Thu, 12 Apr 2018 14:23:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Thierry Escande <thierry.escande@linaro.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        Anibal Limon <anibal.limon@linaro.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
Message-ID: <20180412122305.GA19236@kroah.com>
References: <20180406084331.507038179@linuxfoundation.org>
 <20180406222524.dzzyzh3su3ytgh3u@xps>
 <20180407061118.GF18744@kroah.com>
 <45305b36-b5fb-5016-4948-38a7465691af@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <45305b36-b5fb-5016-4948-38a7465691af@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:17:50PM +0200, Thierry Escande wrote:
> Hi Greg,
> 
> On 07/04/2018 08:11, Greg Kroah-Hartman wrote:
> > On Fri, Apr 06, 2018 at 05:25:24PM -0500, Dan Rue wrote:
> > > On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 4.9.93 release.
> > > > There are 102 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
> > > > Anything received after that time might be too late.
> > > 
> > > Results from Linaro’s test farm.
> > > No regressions on arm64, arm and x86_64.
> > > 
> > > There is a new test failure on dragonboard 410c (arm64) in
> > > kselftest/cpu-on-off-test. However, it looks like the test was failing
> > > but giving a false "PASS" on previous versions of 4.9. This -RC seems to
> > > have changed the behavior enough to cause the test to actually mark a
> > > failure.
> > > 
> > > In any event, this looks like a db410c-specific pre-existing issue that we have
> > > already escalated to our Qualcomm team. Details can be found at
> > > https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.
> > 
> > Thanks for testing these and letting me know.
> 
> The test failure on dragonboard 410c comes from [1] to fix a possible
> deadlock related to the hotplug rework. It's been reverted in v4.12 by [2]
> because the cpu hotplug rework was not ready yet at that time. Since the
> hotplug rework has not been backported to v4.9.y, the splat cannot be
> reproduced and so [1] can be reverted or [2] applied on v4.9.y.
> 
> [1] https://lkml.org/lkml/2018/3/23/452
> [2] https://lkml.org/lkml/2017/5/7/124

Hm, so I need to drop some patch, but what one?  lkml.org does not work
for me, please be specific and use the git commit ids, or at the
very-least, the subject of the patches.  Never make someone have to rely
on the existance of a random web site not under kernel developer's
control to figure out what to do...

greg k-h
