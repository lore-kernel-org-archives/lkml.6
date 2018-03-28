Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1982828-1522231247-2-11550149047107428397
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522231246; b=IKSucLOoRTY40WivIPmUEFxpJliJWrZM0OAOULvnqcEuqVN
    cG4IIk7yU9GeAAWWWTXqxOpiwAg9nqKzUArYqIRqgKjHhad70QpV7is5kRdurYYE
    dFFIvCyxnP/p28i06/b/2SxfTQTapKEnprRNJMwKGcs73S+l0c1KDWjPwygksZHk
    SPT9JtxGcbraJzaTvDpyAav1maDJ574QovGNpu7OuwQU6fqBGfa/xYRAo2eQxjrg
    qDoTQN0fOysjoExH5VXzaBtm8dXjP9crpTglnhhV5ZqO1I46j+HmOK1p/HTshdLQ
    hfNQu6dv6c6lmlIlrJ/PS61plbLwpMerefE4okQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522231246; bh=QgIojIgHehESJeSI4IbBKp0roa
    Dbxzn9vuhxhReAkyY=; b=eviqtA9J3xpvyVA3JPJKGTJij7Hu2PB7Mm5JiM1nTQ
    9PlvrvUC72SV7orNxk5sD74fKD19lxhmNglLUp2+BngtwC9GoEfmhK49eSFpbR/D
    D00TtgdItvmtrX2f5fz8hjaOAt4uyj4KtvRFZihLLIJjVicNCo9gRPZWyAGUPJ2H
    imqO0Z6FEjYnladWkkzUm10PUYaWUbMvlnC1Xqk4++CL0ywY2kpEYyYK8Od8wH2B
    8gCZ/wcFgcSxycaK+B/ppQ52wS/ruVAdl47JD49N1AErNauNmLgiEXP9w9oXHN8b
    HmS3WGSWQsE0YsijnyEDw50mqLPNFN33FeNIxfvIWfZw==
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
X-CM-Envelope: MS4wfL6d6RNi7uiyYkVWUrSKH4pCKlsqlU9euBXFYBQlrMDUvI6cSwP9CVR5JcuAnq81B2N9qw43dR2IIwZNG2xIw8upGCwRRjp9cxjNNxhrVjNGhTO9X9fM
    K5+6kr0JSTM4hmKF1ijagk+w4d3ORTkoZMRcJoBbKcOkFWNlpApCPS5MhB4s8biQVQDrzXUEGeUsmFdVuOtbjaAr39dwfkOavWwI277fKr/wtcRYL2VAbFYo
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=sVTJds5vj0MA:10
    a=v2DPQv5-lfwA:10 a=VwQbUJbxAAAA:8 a=pw4HcN0x0l-yxCJX3qoA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeC1KAo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Mar 2018 06:00:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52244 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752342AbeC1KAn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Mar 2018 06:00:43 -0400
Date: Wed, 28 Mar 2018 12:00:39 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
Message-ID: <20180328100039.GB29144@kroah.com>
References: <20180316152259.964532775@linuxfoundation.org>
 <20180316180531.GA18177@flashbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316180531.GA18177@flashbox>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:05:31AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 16, 2018 at 04:22:32PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.122 release.
> > There are 63 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> >
> 
> Merged, compiled, and flashed onto my OnePlus 5 (unfortunately, my Pixel
> 2 XL is going in for an RMA).
> 
> No initial issues noticed in general usage or dmesg.

Great, thanks for testing and letting me know.

greg k-h
