Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2530676-1521850068-2-11374846636499435371
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521850068; b=EMuWzGZssZInLnSrlB+bhJ1lCnrjd/0QTNM9Q/bW/g+njf/
    pxKe1dORWJw3+sAEZkJ5w80QwAw0tALT1OXpspr8EqzU4UwuVV01QH1vhy5jisLQ
    ne8eZ6EfLHLh4UvWgetO3TSn3/JNW54q+1VDyWjJv9wFBrGMkRwi+AFCdWaXEs7w
    OvQEwDYq1dWyZ6Mi/Z83Nz0bn6Hk+Oxj9e06fFwxNo5uJiJZrzzhAiy4+KIq1EJ+
    /GydTNastZn6mJLerVW5xkwqguZRAiMD98skTRDxBkIoqJKhybFJhy5k8RJpJxBC
    W60G/JVtkWHZcojsUOJEsRJ/LihhKe9/lvApdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521850068; bh=p8jKlOzLUaZuFpQ3XEZqXB5pmM4S2la6PXsgFJDdox0=; b=S
    tIkpz2iIm+iGl1fluL6IRT4y1LgjkPFv+O7iLzHX8/5qrWtaMYfcRpYyYee4yT9Z
    w4s31xtpjSXymNGesBWUX5jvcCHmi69uviz3cXYmfmTxtDks0bq5TbJB4IDU/A4n
    6k7Su1ylhmXRSkz7bR4Obmkrg7nDGdJOwzgb3ZiRogy3+OGQlREdcsyRlCuutSh1
    7XYond4u9VGo4CNdTKEeqgyfEABxBsnAsw5FMi/Od+ygkXPkgIK0Me4GLTI4Hk30
    L3oqOK2Ven4fRjfWMoSn4vq34z8iqhnKj6sZhiTA4ZI3+dtxtzY2eft3Yl1mu8qn
    ellIf5USbQ88T8I4LKVHg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qM4HYTnM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QPSTRhKb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=qM4HYTnM x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=roeck-us.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=QPSTRhKb;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=roeck-us.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751793AbeCXAHo (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 20:07:44 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:41441 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCXAHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 20:07:43 -0400
X-Google-Smtp-Source: AG47ELsXelKsinNqPFUMIrNa5tasnhBkfDHUi0WGdLrBtkY6BRA7Jr3YaL2OaCtI439e01oWy7Yx1w==
Subject: Re: [PATCH 3.18 00/47] 3.18.102-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
References: <20180323094248.117679641@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <e8b0dff7-d0ab-3370-8c8f-a43e912f313b@roeck-us.net>
Date: Fri, 23 Mar 2018 17:07:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180323094248.117679641@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/23/2018 02:54 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.102 release.
> There are 47 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 25 09:42:36 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Guenter
