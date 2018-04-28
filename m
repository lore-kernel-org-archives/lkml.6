Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352198-1524894660-2-14079775437853914492
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
    1524894660; b=OrHUP6TN7SlXOJ7aVyf0dtdvGXB8WWvEo0HOgBnm5j7cl8gIxL
    oGWWi7AFvY5knI1QokJFs7pXoavSXwWS979HtyfyLQf7EKJpcs6wxPzwtZuCqFBd
    PsC/wZjRUe7envlj3XfVTKwZTebXRoaYJJH0StcExPV7+nGszSZNOdsn8JVx0kA/
    Atd9W+0MyNBqRgVY+dqo/XrAfpbi36gf+/nWmHLOattzWeuzAe75bMYNlTVVrpfx
    lNrFfBMZXa1I5WDUkD4BMn5hNEKmDM9QjUqNm62FJJbS6prOkZNt4DqOmHl6LMKd
    1sTIH87MKpKuFmOcpkVE/Nhn1dJpz+IbMhlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524894660; bh=C6fpRfqsNkG
    EO93AB86+H5724u/F2x5NFKlWvNLLSbs=; b=ZTTsw91oitu6NWxBZefDMk0HXNU
    03TfNyuNT3sRIB2yVecWOvsJLW47UaXow3ka92H8xsuc2cRC/7DlqfSCQ2XBk4nX
    J/lbaeqi6KDsmuAZ1sPwEnOYzcIZESn/6fjtoqPDShrQ0KJW8ydBRoTSxRosR/4q
    pExmQTtBzNSYH9xPZIpAZR+7ixL3s/b2yT+6fpU7mK660aDAlCrx90cM4MkVRoAj
    YQzDbphame8MqWsrjed7r3N1RQ7aNHQMYDrocJyOxk27hUAGIf7JDJNrLwLmqY3j
    Fg7zk1YqXwZ2rts8OqI5As8V9ZhbJ6BX9OYF6t6qXKzWDeufoBb3K5TLI/w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
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
X-CM-Envelope: MS4wfBkU1pubEIS+9aLawxxL+BzDB+A0bQlwv4P8NniHaJ13w8xsGQNB1PZB/rbFHuxNhBk7gwU0vopKCmiw6gmOOe+G3EAjMOdlwffF1rpnvFvZO0JSMcTr
    xTsUJ9cBAgxlTd35BwksVf9I7x3T6fRr1ReYwROoaqFzFiKlZzRJV+1Tedpu8nIuhwcm5nzXXXtGw9N2xqcV5TDXcxSkf2mama38zxQmLjhqP6a5R7tzInJd
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=9hA1FEcAjjIA:10
    a=Kd1tUaAdevIA:10 a=7IsmsMqpS1G-BXXvzCQA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753285AbeD1Fu5 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 01:50:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:45498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753264AbeD1Fu5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 01:50:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F04C22195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 07:50:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/81] 4.16.6-stable review
Message-ID: <20180428055046.GB31162@kroah.com>
References: <20180427135743.216853156@linuxfoundation.org>
 <20180427204114.vic746ypotgnyrbo@xps>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180427204114.vic746ypotgnyrbo@xps>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 03:41:14PM -0500, Dan Rue wrote:
> On Fri, Apr 27, 2018 at 03:58:02PM +0200, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.16.6 release.
> > There are 81 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr 29 13:57:21 UTC 2018.
> > Anything received after that time might be too late.
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Thanks for testing these and letting me know.

greg k-h
