Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1725073-1521823827-2-6711032055708745589
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
    t=1521823827; b=J6vtonxN2YPLwnjBG01EsrqOVFkpRTacUJzMCMeEO0EMBcV
    tOtdeoi/q4uMWJY+gh663W+CrnK+ig+eZ3zJRinEJutdhbi+rrIu/4cMLCvTFZ4t
    z9WIjF3ULaZgWS9zCLNn1PIqPCmSuZwhXnlpR23JfzG19FBYsezYv0hR3QOGSkvq
    uB9zgayguJNYoa0DHUAzm4mrfrkr7cqqtR5bYUGyL5t25Uy43r67GLhAsMtEaROW
    0j3aElabORQ7EJu5WqzShR8RicdcibMG8ePZCum7FvY9orv5MIXPmsc5IuN6r/Jq
    6axs+mY7GCH0sS6HPrOEM6kqdPcVl8rHboR0jFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521823827; bh=AZx+Ifn
    WDAt5ZqaZUJxIjhuLOuOcy0dG3oeTUAp4RqI=; b=UOBsa7p+zTFFS2Ka8ut9G8s
    ZEUt1zr59oj8+tKkMZghF5FXfqz6000ckfUw63trc0w7cl89+K6zMAl774YLvH2s
    /LGDV0AR8J12xYNxu1/pNdpbaEZYw1aEdVvaOrbCUZEXdIn2qDcJUkaz3StaOzyw
    NSH0tTwKiN9dksWbSUBz5yPsJnknWettfhm3tb34mOy+lQ75NqzeBTX1O9hHILZ5
    43Vzwbv94moQMbyXOcGHK733cySNviT9/zgupawG9FvqOjjC/PXcDUuitPGMNVR7
    mG+qIkNKWlR6KVYBUY7OXEmtWxwhB03ApHTfy53b/vrOGuoYGcMcdiyB5urRPkA=
    =
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
        id S1752216AbeCWQuH (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 12:50:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751985AbeCWQuF (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 12:50:05 -0400
Date: Fri, 23 Mar 2018 17:49:29 +0100
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
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
Message-ID: <20180323164929.GD7794@kroah.com>
References: <20180323094205.090519271@linuxfoundation.org>
 <CA+G9fYuQJiRGZ+qVWcyiwj1FK41_Si_HaNtoYFCZNR+rupY6kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+G9fYuQJiRGZ+qVWcyiwj1FK41_Si_HaNtoYFCZNR+rupY6kw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 08:20:00PM +0530, Naresh Kamboju wrote:
> On 23 March 2018 at 15:22, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > This is the start of the stable review cycle for the 4.9.90 release.
> > There are 177 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.9.90-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.9.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
> 
> Results from Linaro’s test farm.
> No regressions on arm64, arm and x86_64.

Great, thanks for testing these and letting me know.

greg k-h
