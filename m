Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3666841-1521626740-2-5857467511670109829
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
    t=1521626739; b=CJMjsf9D2PWyG+FfSJ8NJ445fe5x0bKAVAtxlVjcT834gs+
    LbunxFunpaNqKARjhH8gZwIaApNVMtSAUNR5mORVcxb/6NcpfNKusuSSIjtj/an4
    2J1UM2iQDZcMhjgqX/+s+HAdcQinz/VuttAdG/3d0/oCPrmJZHj8YRk5obYzLIG0
    oQxCcuIxGNRmXZy9GgVVr4kw2nUjEpFL6lHXz6B28FJHDhnygDlYve/2kdphOhfx
    V2JmL46ck8nd42q5SnJHeqwCFO2/vZtPRL4BHzAEN+BkBNUC+OG5WvhBJKCNW3mo
    Tg/9nk2WH5ecL0FnIMLLVrZ2eHorwp8qEbG++bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521626739; bh=8cgeiJ1UDPx6ZS3EtG2nUZqV4O
    SYAywRQcbjKdG1JfM=; b=mVdcmqzeGhfjrynWZIlFi3F+ItfwSloBrb+di2vIng
    y7Vq/fweKzC9LaKzwluDrS4njsqNPW2iv86Rj81rpaLKvj/DzYflBFbtpC/qC5Aj
    ITDPHsb6+kdM/c7Ga4gxUmF0fcslXRcXDA0ITYll/eowY1zZs7KVNdbpsM+1sNYw
    hCvy58D/k6DepT98AJLQvsyFDI6w2MIbQd6LF7hRAFEm42QoTx9ucEUCXxybRWnc
    h2OYqYDrg0xa8y/m+xePMikTSXS9EoGLxJwJI0d5/Vd6DzMjG4o67mFpZJWByTIt
    2CISEjKG0OFhaX2PQJKr4mdRhVCwdNIHexeeMkiq9AIQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
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
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751815AbeCUKFh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 06:05:37 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48504 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751545AbeCUKFe (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Mar 2018 06:05:34 -0400
Date: Wed, 21 Mar 2018 11:05:31 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harsh Shandilya <msfjarvis@gmail.com>
Cc: akpm@linux-foundation.org, ben.hutchings@codethink.co.uk,
        linux@roeck-us.net, linux-kernel@vger.kernel.org,
        lkft-triage@lists.linaro.org, patches@kernelci.org,
        shuahkh@osg.samsung.com, stable@vger.kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180321100531.GD22453@kroah.com>
References: <20180319171827.899658615@linuxfoundation.org>
 <CALpmF+Fu1EHkBrG__6u8mY2LNa4jpq5ka78Oaa97X14FPwLLQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALpmF+Fu1EHkBrG__6u8mY2LNa4jpq5ka78Oaa97X14FPwLLQQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 05:50:27PM +0000, Harsh Shandilya wrote:
> On Tue 20 Mar, 2018, 2:14 AM Greg Kroah-Hartman, <gregkh@linuxfoundation.org>
> wrote:
> 
> > This is the start of the stable review cycle for the 3.18.101 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >
> > https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> > or in the git tree and branch at:
> >         git://
> > git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> > linux-3.18.y
> > and the diffstat can be found below.
> >
> 
> No merge issues with the CAF msm-3.18 tree, no regressions noticed on the
> OnePlus3T.

Wonderful, thanks for testing and letting me know.

greg k-h
