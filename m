Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1352198-1524894693-2-9393277584441303164
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
    1524894692; b=U9sjziI3G8Sd7EYPZlIdxwiNeyMFJZdEnifrDWUDgiL4AtMPO5
    uhFQ3wiGk60RJtwUWbzC8+dLmIbDIA51r9oB1Q7AOw7L4Ku6P6SRfBIEjO4QWRqU
    gLt8IxvpeQvI5I54rBGwTcTfJQCbfUnW/HKW3ehZdwCU5EapA0HI/qNuGeIekAlg
    mve/xDRh7y+lFhmlMy7269jI3hvdbAv3de18TxoPREJ0F4MHVIKQi7UIKAB09ETS
    rX/BJ2kV71/RywWwM4sXytuLnnV+jO7IWv5VkTk2umOHtrrOdq6FnUnUkAhBYTnV
    UEzZ0ZD3cLdi2U8+PdIOIWDQReUaRl3eWUWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524894692; bh=2oi+tDah5oifCoIe2uPiWLkDWiIXjr
    Vj6A5bOWdy25Q=; b=fh5KOCX34+FsdLGS0xnBy3Nu31XluXU7VIexAmKXviQVF5
    X7L9ZF636c3phsQAXx0ke9zqashVgEH+dACJsueHQR0O5Tsy7XfshuzGpwpk4Wmc
    l9UT7C+d9ErGmNrDx6Jccs7WaDzuZjFQ5Bd/3mcjjiFliFBjFM2K/dG4kqcGoUXa
    6b/B3NzGZYSYbleUlMs9tybtI3/WG/cd5Iy667BMVHmabyM8Uetrohc4GMB42uTy
    anrSpG1adOJUeQEUro9mSFlTkYDXhGtGzI1/9WQaDxYxEcrE//qGVQlcUzuBsMBV
    B9BGve1UX16JcPuaBqwZN0BcAx6zNTPqLQTWhZ/g==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfOIQYKHSTIKMSwQaK/0DoY72Yu2OBZt7RHiRWpVbrD7B51aJJjDBcfQGUzfDc4wOCxIEvDAZ0WoETzMHj7rJtUdO8ErWzJ1IBtcbexy71s5LbQ6cvyQM
    VQM2CHjJoLPrZz9eNad2216lwNPYja/wDhWaINKmun+1tmHEq6h14T9+XGWb4etx7Y13mGrVxVFkAnrISLI0POqf/phNXJj/7AjJNPLm+W/8+qoG0b4tcoi0
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=28HZq395EAYA:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=QwK3zxdBwoPrVwGfhKIA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751731AbeD1Fvb (ORCPT <rfc822;greg@kroah.com>);
        Sat, 28 Apr 2018 01:51:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:45634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751303AbeD1Fva (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 28 Apr 2018 01:51:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BFE32195D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
Date: Sat, 28 Apr 2018 07:51:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dede Dindin Qudsy <xtrymind@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
Message-ID: <20180428055120.GC31162@kroah.com>
References: <20180427135631.584839868@linuxfoundation.org>
 <4b4c131e-5869-a39a-c991-35055c65c35f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b4c131e-5869-a39a-c991-35055c65c35f@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:00:41PM +0700, Dede Dindin Qudsy wrote:
> 
> 
> On 27/04/18 20:57, Greg Kroah-Hartman wrote:
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
> 
> build and tested on rn4, No dmesg regressions.

What is a "rn4"?  Anyway, thanks for testing and letting me know.

greg k-h
