Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-791436-1524206759-3-14372816376886198114
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
    1524206757; b=QHBGI7TWayUypWel0/2dWpQjdM5BkC8/RN2TyCY4p71+2u2IvZ
    RkAdeDuJ2bOj/LKJknvZFQT5UbFh902GpxTcMYHaUbkfshwo6KM6FS4lQyHr5r0S
    L1m8avga9gZ84v77juP7cjxWmyi74IyfN3NnXG30Dz6CRD0FVpaNhxSV+p49Fhor
    nz/t+kw+ZHGKp1Svx1H42pKtWlKnypGXx8sQBaCt/5GKAuAB8nwSdCYRvqhD/Tys
    R4i7ytv8hVQgKBYGpu2jcdybzJ5ZT8jIoHUIw4SLZba2TKPLCvEN+U+5NzenU1C3
    EFwgkgL1LK9y1LBkixlgp4bYAG04LQtjb45A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524206757; bh=l/PrAzdmTdx
    GiomeyowCvqswtmOqRIR/XEUTO3h7cJg=; b=A7ntrlJmXiPalDDPLC3nwsvOpe2
    dauW6dTOpcaC27TpAq2pyENuu1I/4MVGkh8GVrjfqKK8Z4g+du2PxpE/PjJ4R2P1
    hP/XYVJbmWtiz+k449uGSBIOslTGtK65Gj4aWMWSkQsLiSneeN3Ral091Nc/UtDc
    q3XBM03H1zPy4mNcox935Yb8MSnqimk+j1saXn5KYxplQU7Gj9U7gN1ow1ndvwI5
    zhQGbJ7Xw1PmzPT6hH512/85feBtryRpmueX/ecy7oeA+TSXQmSSVJ3oTkhnnfE2
    VvFfyQIfpqvs3vluodXCjU6LQBQsJGrfjYvowwzh9tQ8yKWNVI6+ilNj4hw==
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
X-CM-Envelope: MS4wfF3+FpkqsmJDnlCDdajz5t4B+T4kDIOLdLUHZlBHx+wtTpR715M1LGJer9EatvWdWrShVQgW069BYSO+Bl7YPObsfHhFQDyhH8w+5e0kc+sqcycYpUpG
    JQSUXbhvMWKK8KM8PIVqfLVW2sh7iq4gPDNqhs719r1eboo+gDjMnK0B5Nk4EhE1WZ5z9/SJ5qsb2mePvf8jJZAiYpq5khpbWa8cqZ0HWMp3wdz0EZ4L9ViX
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=J7Nbbob27coA:10
    a=Kd1tUaAdevIA:10 a=3brTBEz5tH2tvSn4e2QA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753806AbeDTGp3 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 20 Apr 2018 02:45:29 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60446 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753728AbeDTGpX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 20 Apr 2018 02:45:23 -0400
Date: Fri, 20 Apr 2018 08:27:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuahkh@osg.samsung.com>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 4.9 00/66] 4.9.95-stable review
Message-ID: <20180420062704.GA8615@kroah.com>
References: <20180417155645.868055442@linuxfoundation.org>
 <20180418174244.ke5n4uhbj5geijco@xps>
 <20180419075608.GA4230@kroah.com>
 <CA+G9fYvwDU481Ui6cAC2ORi+A7rikx=ZGrLew5bAepkMY3wqrw@mail.gmail.com>
 <20180419140305.GD16862@kroah.com>
 <20180419200405.uxm7etj3yc4i6bdj@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419200405.uxm7etj3yc4i6bdj@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 03:04:05PM -0500, Dan Rue wrote:
> On Thu, Apr 19, 2018 at 04:03:05PM +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 19, 2018 at 04:42:56PM +0530, Naresh Kamboju wrote:
> > > >
> > > > Can you try 'git bisect'?  I'll hold off on releasing 4.9.y until this
> > > > gets figured out.
> > > 
> > > After reverting this patch, network started works on arm32 x15 device.
> > > d7ba3c00047d ("net: phy: micrel: Restore led_mode and clk_sel on resume")
> > 
> > Thanks for letting me know, I've now reverted that commit.
> 
> Alright here we go.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Great, thanks for testing and letting me know.

greg k-h
