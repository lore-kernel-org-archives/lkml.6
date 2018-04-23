Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1566850-1524506635-2-3116104226208174929
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
    1524506635; b=ZJoVzhlp8VUm9r2IMQgvkEZVb1n1heWnCQyjxQeAvKVhW47opk
    SzI5iFCp6mEpbWWFEFObU/T7VYABfzouj+z5kaY8c76ryIdmxmdDCP3yhCxdcgUS
    gom+6rx9qJlulIhMcXZ24SQOhXDjtCzgGJqCXzIybMUPFtfI5K0nLUVDmKOxwf0n
    pXpm2ARLNwCu/I1j2sTGCvKnA5lx/JnRpK0EbTVDoStnEW22D9cZStNRBJmPWVX5
    4nGLfAnLi3Kl4Rww+JlVw3JyAMN4p16ZglfI0j8U5aJ41qwCdx/nj+sOFYyZhcS6
    JoA0nDf4TaJ2p8V2YG2QU/ZVk5c28QSm6MCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524506635; bh=dOh4Um/ATTkQzoa9dXnWM13ZFR17ua
    2KjRswnH/69WM=; b=URYAW/te17w3akMHc32TSTakzux+4jIY3cN9Lru3Q/Mry8
    7jDDN4CYIQ+nb/2J3tHqXOg6o9A4CvY1ZnzhRlsI/2ji3qmo3tvnran8mXsa9Blw
    ZuZSIixXeQZucg6PEF7nSIyZ7okcjGYDViLMpip11+0cmJy/skhFqouwdq6sHFYx
    46AgxnwkCjYwYwsQiY3YKrNBDj+JiDkRzyaCC0eY/+wpB0QgssGwngvT0PHTqOwn
    X+FkD0f6tawQqevQdEegK9HXMseuBASbwyKep/mwdTYYV5ydMiXUHZ3qt0cqsINg
    8rGXcQ7ZGnQc1gho7E/79ujOayg3wQL03l93iGwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfKcWdrDerr9SQCZrK45LTm7ChwpXbpEWCcM3Er1QjfkLtobslv9RCJIxBm6DQbmxqhUcToTPb1LlONmXs3IZSngLzY4pQ1A413T50QFK7JpxU5fkYc8C
    bCUflpWCI12VIBe34qmuRXLjbMi9Qahp78Oy/elxoFCTmpQlKwWEIu4g7WDXREbfAwTJJGllaHPAtg38KOn2o0cGgQRnVpvWdHbp/Tg8N70Qj9jzzRJ5iT/2
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=mxXUtGV5dC8A:10
    a=Kd1tUaAdevIA:10 a=VwQbUJbxAAAA:8 a=8-vRK6DNSD7UNujOA5sA:9 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeDWSDw (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 14:03:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48792 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932252AbeDWSDw (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 14:03:52 -0400
Date: Mon, 23 Apr 2018 20:03:46 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
Message-ID: <20180423180346.GB27081@kroah.com>
References: <20180422135135.400265110@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:51:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.36 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.

There is a -rc3 out now:
 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.36-rc3.gz
