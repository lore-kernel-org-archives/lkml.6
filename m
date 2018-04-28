Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1327141-1524891769-3-11279610273142341997
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
    1524891768; b=KaogMlTf3rQoV76+YxYfnf5oRg5UoqFaAv/IN5QtsvZ7aQyK2b
    w0KzJw67DNbzWuudOHCqshK+cr/7qDBIU5QTk+nZMdtyswq0Ff9aCYCPHY4Dhxsn
    8ZiYfEPT/iVnD0+1mELucuQW3V4T3hVhqLibGnK7b5Ni49r/A3jqGV9GTXkbVld9
    /ewAF5aYOr1Pu3NsUm6Ql+2RGjR9LPmM//Gvd604MnjVFcFOccwJe54qgvWHJp9u
    /kZP21KYhclp3FQWJJD04WGl/XDAZsmdAqV2vyG18aNWLIzfhMjqhrf8ITS0l6cC
    ZwU1xj1eiNIUOjOGiithnFx9aF7/jG7Ur/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524891768; bh=kjL87LezG4yk5GB2GNW0FuH69QR77z
    NkcDay8ePYJ1U=; b=MBmPvBvqO8GeN+LWCi+PmB7zEIdC4OD1OSZk9khovsdgVL
    Uj8ogjOWXnWbzzawxQ/Rw2zU/m+5MqCl1hHvWQkSrnEXITe6nqAlh6fvuMJbzOOe
    gP9rYgnvYc2oohr8V08s14ZxZkmPKG8mE3g/yonM+pB42fOygFYBuTPwv8HF7BX6
    Qe036ffrlOxWMnVzBSCuqrnn8CGhu1IeOj1/m2Gn8ntSfTEbDPip6l4LIjZy34MO
    qa/zwI6H6ZAg8cnpZlVjJMIlCGJPVGJ27oY9FG/hf5rHWLOODxAz7UQlHfbmSdoy
    LjGxBksI3+3tKWmfJQZPePwDGqu0t5Kr8fsApbKA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
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
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKzfVX/rJbRqDYXD0DRc6vk6V7FQA6kVN8LxQUmHQiG8r2adA4VY1qh2XtYxNA06KoW/QqPMMHzUGQdw0IG1aGnGISOhSII2c07DpE9VdHesdpmRP4TD
    1x0H6/jIinTZkR9AUxnxYGbOnM4YiQF5aRa+LuxM2z4iFYiqBz3m18UIjZiUlfrQjHyRw25NSjAOr6ZugI8bsUkeRul0xMAuKWG52ElJsT+CbnCAzu4dpzmG
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=28HZq395EAYA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=QwK3zxdBwoPrVwGfhKIA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752364AbeD1FCq (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 01:02:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:42278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751888AbeD1FCp (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 01:02:45 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BC5121938
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 07:02:35 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
Message-ID: <20180428050235.GE29422@kroah.com>
References: <20180427135631.584839868@linuxfoundation.org>
 <58442943-fe5c-80f6-7f7d-5a73612b4aa6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58442943-fe5c-80f6-7f7d-5a73612b4aa6@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 12:12:32PM -0600, Shuah Khan wrote:
> On 04/27/2018 07:57 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.107 release.
> > There are 24 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Apr 29 13:56:20 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.107-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Thanks for testing all of these and letting me know.

greg k-h
