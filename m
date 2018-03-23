Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1790898-1521826599-2-14600061878156194979
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
    t=1521826599; b=kMlGeAZQmnvK+tEu0J4Br82xN6rQ8rNZ6HCaHb6Gb7KuLIU
    R6e9aukOQ+F+YAjHbNxaL/UggCgf2EodD8TxGWE72MWyUDGUnQ0OAWW0mIFsRnj8
    j4r3AlTgNaNd+kbKn3DWwK58fuLcxiLtsKi0h2aUZpXcVEb6xWs+gy+vra4oxhyk
    7JYZNt/tLVXt/Gu/K7u7R14KDMyyA8M2ub4kp+KUHxyGJuGQSXYyhUfEmizUEke6
    QxtcK2aClOKIjhUqIUDlW8qhm2oa+z/47cq5coUfevdPKmweVUeF3KsVwmzDhJyU
    IDaQkolDbIyjlYvvNkl3/uK/HV8AI57PeY/n+5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521826599; bh=PYF2/Te
    4vmSKc/9CI1zpUOwXZ8aGWYJcUhEJV+D/duA=; b=YjM7K+qcUAIdo+m4S7VUDe7
    AwQBbJiV2JhnNiyh9t+geQXs/b9b0vcaAQRKnsWjfWb6ZJiSE3XoF0cTGpPwIHSJ
    y6mIsoxrGfJc6Bh22B3MmNGq5/4OKNi6I9bUTTQNuaLjYxUJlUE0mQzIP9IFgOaO
    vFfQ5Ufd+KHrb5CCYXa7sOdCt9SCY0Gz7fNzPP5MsD3wh/3kB5AtjXfHvYc3fgmP
    ILFRYpgVHG0LqmXV5zaQ8rxM1eo0S6NLtsjNeOPz/3oftvQsowPeJhuiG857GWEF
    411Rx++Ph+x/0Ji3VEGmpAKks8XU3OTU5qYwSmr4okrwlWBNtQ0ahUD4JoP0OoA=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751926AbeCWRg0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 13:36:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46302 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbeCWRgY (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 13:36:24 -0400
Date: Fri, 23 Mar 2018 18:36:22 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuahkh@osg.samsung.com,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.9 000/177] 4.9.90-stable review
Message-ID: <20180323173622.GA1213@kroah.com>
References: <20180323094205.090519271@linuxfoundation.org>
 <38f8329c-79fc-c217-69df-4bb5dba024d2@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38f8329c-79fc-c217-69df-4bb5dba024d2@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 10:18:20AM -0700, Guenter Roeck wrote:
> On 03/23/2018 02:52 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.9.90 release.
> > There are 177 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 25 09:41:28 UTC 2018.
> > Anything received after that time might be too late.
> > 
> 
> Partial results, build only.
> 
> Build results:
> 	total: 145 pass: 143 fail: 2
> Failed builds:
> 	arm:allmodconfig
> 	arm64:allmodconfig
> 
> drivers/rtc/rtc-ac100.c:570:14: error: implicit declaration of function ‘devm_rtc_allocate_device'
> drivers/rtc/rtc-ac100.c:599:8: error: implicit declaration of function ‘rtc_register_device’

Offending patch now dropped, thanks.

greg k-h
