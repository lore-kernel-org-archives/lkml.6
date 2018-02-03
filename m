Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-500972-1517646001-2-14047527772513427367
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_03_06 1.592,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517646001; b=iNCKLxfw3UJikyLO+UM8GBYPgVHP1uaCGfDxFdcRzQgaXI9
    F6ZIvw0caAs1Blufy665C4Xy7zCn+Fo1ck62k7zu1fuNzFFZFT8Bpv+lrKUBclN3
    DLedrfrpPil+zcMnr1K2sm6aAS9claAG+47xFpRa85qQN5NyfoFJafudrvWprwEV
    rTxACIBvS2S1H0jBPEY59iIOIjo6ZbFZPfQCj01SKkQiOxLGTI3OZt87C/r1ULyG
    tdPRKsnVZtmUvGzDT/0bn1RfDnNs+jxGM6OmYkYnhhdQPewJP0NmytiULMQxnOmz
    CKY2gpgjMeYduGqZowpVulq+EEQfig8SzM9/w3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1517646001; bh=B7IM92AAajU9FqNTvtw4njZ0+Z
    IXCL44nVCOwBaKWww=; b=sDafMOW+unfJdpu9HH53kRjmu2GomPlqnnwzL2wlrN
    pcnhNWA43IizZKQvkUhIi5DmOpYa/af4ma36ZNmKDpdvJLid/9EaNzUMg3XeLBjZ
    +1XgMyoElansBVfj3Lofwb8wqbiEC7bpow+qn1WQVSa4PP1NslhDTM5xMNcYM1py
    tGjLVSmmj9+b0seTByz78c8ozMqjceEmtqIoeRJsrqIZuEwhVJQiouU7ep/bDaGl
    zatmCQ4nsXZK7QQfe60cWSIzjLWkVpspt3QthHE8o2HT9GsmSUXOKk69dPnmYczq
    iqk8OXhNs2UDzcl4AADOOXZfidAssv76qY9XSQT+FOmQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752019AbeBCIT6 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 03:19:58 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:60132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbeBCIT6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 03:19:58 -0500
Date: Sat, 3 Feb 2018 06:16:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Shuah Khan <shuahkh@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, linux@roeck-us.net,
        patches@kernelci.org, ben.hutchings@codethink.co.uk,
        lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/55] 4.15.1-stable review
Message-ID: <20180203051635.GB1329@kroah.com>
References: <20180202140826.117602411@linuxfoundation.org>
 <7742cd84-39c1-7cfe-9b66-5118b1643407@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7742cd84-39c1-7cfe-9b66-5118b1643407@osg.samsung.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 02, 2018 at 03:17:42PM -0700, Shuah Khan wrote:
> On 02/02/2018 09:58 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 4.15.1 release.
> > There are 55 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Sun Feb  4 14:07:50 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.1-rc1.gz
> > or in the git tree and branch at:
> >   git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> > and the diffstat can be found below.
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Compiled and booted on my test system. No dmesg regressions.

Great, thanks for testing all of these and letting me know.

greg k-h
