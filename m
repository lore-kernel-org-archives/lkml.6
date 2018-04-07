Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3142383-1523081376-2-14301727501594291923
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523081376; b=drjZCEk3P4Fo8UbCZCNdgmK0CXJMHkKWUmnSrZlTPUeRngws3u
    LjXHew1Txl7ndae/aa2Nq22yyeMd1rWargUmxsOLX6WGpX1w+SlRLC0zb4n4+oBa
    epdBRlr3qzY331VOGlOp34SwizvBrzP5UoEmG97gyxMiKx2aZObR8M2MTh0tlDqE
    aoaD7D8Rv+/M75/IsHRetrJucltEfLfytv7Xi3vhJR/aA3S/g9cywz1MrP0lWH1W
    0MyWy2wV7Esgw3eRB3WzokgyULDQkf/+jY/UfIJ1mQBPsvqLbOPc2wx97yM8n2Ib
    rQiLU3JBGB3Qb7QjrZcoq6N/Zkqpj+uUD7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523081376; bh=8r8e9rhMPCR0EH/gremYH9feMMaByn
    WENIec+mZ78P8=; b=VmmmQs5McI5oIoWPOUD8szMman+v4aQlUOQiAJDNezFeeQ
    JO68k9mIdoG5ra7tgHP7yFcQij0wrBJNciTNoNl1J8AfmiJp+MdqFuTdrmgE+vJ+
    jrKCE725vaBUAjxh88Fzpu4OsJu6/IOjtZDQzgTXsgP16NC5eQEek9unEh129OkH
    wQdDukvOn18w2K0U8xndf5w82O6+hy/+P2JptgjKCkJSuAlUzSFct1D/f5VRAAd9
    zy5cQfk8UVwa4gGQTrZoqqGmvafvR3n/7TjMvqligFLZXFw7sxB6EIHu4ru/yR1R
    8W0Bsa73/dJ0qZbTuO3RVj5hO6VHuWiquJEnCO9w==
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
X-CM-Envelope: MS4wfJKeHZM1JQvzY0QSkQU33qiwhKeS9PW/Wapg+oAExJfPr5rzP/okWb6+gzQvF/nPA63n71OgnRGwFTc6ynMedoUSEOTUUZngnSQ9pKrvXKlKOSSQ23Ru
    T0t6SliYOCZB5VBisJL8M8ZnFm+HGs0ibiMDMa8hoz4LSOTY9HxAw/5zKNnq+3cgenwk1Zidu+nX4/3L5viL5jYc4i+woWf7SO494ZKLRY+GBtQRlhiUn+d/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=wslChEY2J8gA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=QwK3zxdBwoPrVwGfhKIA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751334AbeDGGJe (ORCPT <rfc822;greg@kroah.com>);
        Sat, 7 Apr 2018 02:09:34 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:44242 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751330AbeDGGJd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 7 Apr 2018 02:09:33 -0400
Date: Sat, 7 Apr 2018 08:09:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/31] 4.16.1-stable review
Message-ID: <20180407060931.GB18744@kroah.com>
References: <20180406084340.999820380@linuxfoundation.org>
 <021efe57-f186-df63-f2d4-efb548d13907@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <021efe57-f186-df63-f2d4-efb548d13907@osg.samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 04:07:38PM -0600, Shuah Khan wrote:
> On 04/06/2018 07:24 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.1 release.
> > There are 31 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr  8 08:43:15 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.16.1-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.16.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these (there were a lot), and letting me know.

greg k-h
