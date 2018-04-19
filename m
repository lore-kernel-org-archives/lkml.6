Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3169877-1524144113-2-2163173805303333105
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524144112; b=B5f531BVClusTJ3TM07JEeebqoVqtgI93Wxm19mAuT5Dso1OCe
    m7qtviGYW6EKipxu7IYWnE5TfRgtgd/vlErSgkvynQLk6EUvoTxZuDzD+wxtCLhO
    NEr2PAJ0iGkGZT/fDC354EjkOgmyKyesBoKog6Hsp5t4qgjE1RBTUEqZa+iOJ+a2
    /0ptlQ8k3yMb/AYfX6CjZL+prCARnvDoZODwykd6pthgXq7E8NKS6FZlFgl7dJh1
    HwWoAlAF88Ew+uwIA03KkMPboBjSEgnmocU7qm1euAhDJfmgA90GP+F51C+HPWDC
    50fAFDukCTyIMzLKgkwfNpSF6dY71W7NKLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524144112; bh=vsrASDGrhRiiIRiIX7ugP5npQ7yqIc
    3JAJiYzRkevVI=; b=qQ8qgqaiOdabQZI1qORUrTlO1YdMTOpFCDpP433OqrN/0C
    ll/xVtTnhyvBb+DLLrnSxQiPBhwYa4A8qFrl28l7SU8bEtUuTCIfMi6LJ1pHs2dH
    MgFXpzFZmudnHeAEMTvSHdcruG9OQ10uGLwzQXpi+llslLkT9Xcz88mNpq5Y8VYq
    gCuxcDiSHpMuR5owsIIbCdUL4Zq7TS6TftOR+ft7HPQtR/Y8BXTxIUMnLL2wHWGv
    mgsv8XSP6l2gDrVK8B7Pp+slB/yjj1+o1ksoQcKFtd1OkIDZGQ3gVRCm71YgKkPU
    EVcUFG+14tZ14uYH0iZayvV3vBW61WSBP9RFdHog==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Xw/P3JdA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VtGSTIyg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=Xw/P3JdA x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=VtGSTIyg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBehTvXbnTr06iwV2gMT/QTY8iER2wRdD/n4TFUKb7H/TVcv+lFnRg8OV5f/Fzmtp4XGK12tG6tLG9sG1zEjb+/V5AYVIbs7F+PichH7rNhCw3dlwNMi
    TpYdCD8WGvLwxJt9jCuHn+zd6DKXeWzuZghGIDtlqTyaV3KrXl6USFI/gZWvuG0vErAwQyJSUmVfgClp6b8o4O38rEDYXrz7JTm4OSU3JKxyyt8bHNmAVqV1
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=J7Nbbob27coA:10
    a=Kd1tUaAdevIA:10 a=1EsaE_6oAAAA:8 a=ak4iSWE9sJC5WwsuTD8A:9 a=CjuIK1q_8ugA:10
    a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751325AbeDSNVk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 09:21:40 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:39164 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750974AbeDSNVh (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 09:21:37 -0400
X-Google-Smtp-Source: AB8JxZoK9iGmJdT6Ct2344jONn8IC6OLvhTj62gBv6rRTEuEAoY+Qan71SGzlEBXNwMXwCECwnrfTA==
Date: Thu, 19 Apr 2018 08:21:35 -0500
From: Dan Rue <dan.rue@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180419132135.tggxbgw6z2w23lgh@xps>
Mail-Followup-To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180417155645.868055442@linuxfoundation.org>
 <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com>
 <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
 <1524139760.2587.17.camel@codethink.co.uk>
 <CA+G9fYt_Tv89s2DNS9n38DCaSu73e2381YSG9J-Ruv3UAu8FPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYt_Tv89s2DNS9n38DCaSu73e2381YSG9J-Ruv3UAu8FPA@mail.gmail.com>
User-Agent: NeoMutt/20180323
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 06:00:52PM +0530, Naresh Kamboju wrote:
> On 19 April 2018 at 17:39, Ben Hutchings <ben.hutchings@codethink.co.uk> wrote:
> > On Thu, 2018-04-19 at 16:42 +0530, Naresh Kamboju wrote:
> >> >
> >> > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> >> > gets figured out.
> >>
> >> After reverting this patch, network started works on arm32 x15 device.
> >> d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")
> >
> > Does that also fix the hang during 'ip l'?  (If the hang only occurred
> > on the same systems that oops'd in the micrel driver, it could well be
> > because the task that oops'd was holding the rtnetlink lock.)
> 
> Now 'ip l' works and the oops message is gone.
> 
> - Naresh

There may be some confusion since this patch was in 4.9.94 and we did
not report this issue then. The way these failures presented themselves
made them a bit subtle (we didn't get any hard failures, just some
incomplete jobs - not an unusual occurrence on embedded boards) so we
didn't notice them in the last release. It was only after Naresh
manually investigated that this was discovered.

We'll think about how we can improve our process to make these much more
obvious in an automated way.

Dan
