Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1673992-1521823832-2-9592574453787618015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521823832; b=gZC6II3qQZvQUl3I1I1UtLVT1dvWrNVSL8+wSVFZ/MqNE5R
    HSJjBLU03b2vYntL3jXxcYsPJ4f9RUVXLVV+OsrLh5EQ8BwcFcmUHScRrGnrFioc
    8VXoEdH5avQHsmKsB0aJX9Yg1PAfw7Oxrx9WsWt2Be1WPfzeVY66KeSNJMNX34q6
    vp4Sma/yCLkd2f7kMsi0uoURfsewLrGC+FkkM5PpOAosKE1c/0JVI6C61MwwqNo2
    YQdUX5ThHg/gWfUmk4yGkm+aCUfwgGAF2rT2e+y9vjfCpLLudALSl0wqkqRisG9B
    z/cgrlSKcpX4tnxaHBL4s1at3Tb5Xyt3x/f96CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521823832; bh=4drOUi4xwkgxXqyBsUlqhI65Wj
    TuHVMKO3C2xJ609RY=; b=tthfV/WLGPFSGZ+yAZAYm6G3RqCJxDXTT32AeteADv
    U17H8MGfItTvv+DmGz+eCfbt638Hu0MUFe1Znn50QZgnT6xOzryqh4SlOop1SzD0
    fIL2dF96RuNFJ0Xq3Mcv5pFbCZ6WeHjTaqPFR6uQjwu1RTml8RuKFIhcTXaNeXRT
    M5Z0IgQEmg1/FofhwbM0ZGK//9bRBYvSyp/BYg4lZPC9/3btAUSqsW0bWwrcVsxc
    1TVDpV7WSV4E2GQyFVTP2JSX6YtMk4B+8YzLVQnV+hF0hyPAPHQkbQlTzTVjwx5r
    drszNWmqmrAbWTuQKiKl9zYYNm5fjS068mt/V5O6csuQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
        id S1752390AbeCWQuB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 12:50:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752173AbeCWQuA (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 12:50:00 -0400
Date: Fri, 23 Mar 2018 17:49:09 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        shuahkh@osg.samsung.com, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/97] 4.4.124-stable review
Message-ID: <20180323164909.GC7794@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323150141.GA13338@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323150141.GA13338@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 23, 2018 at 08:01:41AM -0700, Nathan Chancellor wrote:
> On Fri, Mar 23, 2018 at 10:53:47AM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.4.124 release.
> > There are 97 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Mar 25 09:41:34 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.124-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.
> 
> Couple small conflicts from Qualcomm's changes but nothing major, I'm
> sure kernel/common will have none.
> 
> No initial issues in general usage or dmesg.

Great, thanks for testing and letting me know.

greg k-h
