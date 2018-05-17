Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526550131-2-17660894772084080196
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526550131; b=TS+c9wCRF7GJyyq6q+AdVjmKALK467c839KKkbgTHOk567AtCv
    lgHMAGzuYmKON1Q25Ku3LbhOKLUVidwqamZ9Gcyscgmoaik9hkYRJWeTuv1Meej2
    aIPLOeCyHjHbapWKIyKFPInHC3im+E87/y54F1PceEHVb1zI0J8s7SJbCzvlXg+u
    BzHiEnjwSx9MujKOY48xoulsyojI4aVM4gN4KZu+vcXPY8AoapFhzxpjlbP/yEPy
    Owwwet347qQJzazz59Jn+Jfg2jh65UVyxrZwXzIlU1lvkcoO6hAL3lwFxArhUw5T
    b2rDGPs12cGkhuCVqnkT9DEEjkUfEKADjMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526550131; bh=6fZxcV3nPRG
    wSlDsT4Ei+7XqYGqHKlKrn2a9MjgAsnU=; b=e83qvmk+beqDKyAPnDbQ3M5tIVS
    JRd69q4QW7fKRKVEqbjiOZpNc//2conIIBxOU3UaS+etmMkbwQINd7coTNrNasAh
    hDk57l+BPLrUy+vzMmivbuLtIMdDuDYxw5wwl7kVNviC4PkiyHS13LobcDeAjOAf
    T4jldsciZvQFdujSuCcBAAjcTV9GgIotLFLaEAy5rnXrhUhoyyGD7w7hrr4P5YCq
    3iG703OSQH5e+Vgf+eOcYmZGyNIdNE1vw2vKT/exFZ5Q6fNorL/ZcjmL4ndjAItb
    z5EzaonhqMDiYLqWp+XgvJ5xK9rWH/QdLghjtMjVzFRYvdirCWnyfr5MYxA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=eKNwNlS8 x-bits=1024 x-keytype=rsa
    x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linuxfoundation.org header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=eKNwNlS8 x-bits=1024 x-keytype=rsa
      x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linuxfoundation.org header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOf7+TJxULY24qyK3KFfvTHtXyyoIr///ihU1VYQqWixssD6Qpr0DmwwRY90SYswa0jG2UfY06FUdLxHwyN+PxAAdogQtrmqQ0SB5fWtaPPqkQgIYhp6
    cBsOYsZ0MRtfpBgiQuCwSCUc+Ph5BEXSqwtAWJ7HaEbv70ylzw48RMJCgatHdSjGfGEe7WW31ON0zsjDes/z2nJn/RRD7UI/Y3ZCaHQlAWpeqnbN/eHVw+Kj
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=8AirrxEcAAAA:8 a=NFkFOvk_0bcHYUF2pwgA:9 a=wPNLvfGTeEIA:10
    a=ST-jHhOKWsTCqRlWije3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeEQJmI (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:42:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751280AbeEQJmH (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:42:07 -0400
Date: Thu, 17 May 2018 11:41:50 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 035/190] ARM: dts: imx6qdl-wandboard: Fix audio
 channel swap
Message-ID: <20180517094150.GB28396@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183552.238086370@linuxfoundation.org>
 <1526412924.9159.42.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526412924.9159.42.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 08:35:24PM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:34 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Fabio Estevam <fabio.estevam@nxp.com>
> > 
> > 
> > [ Upstream commit 79935915300c5eb88a0e94fa9148a7505c14a02a ]
> > 
> > When running a stress playback/stop loop test on a mx6wandboard channel
> > swaps can be noticed randomly.
> > 
> > Increasing the SGTL5000 LRCLK pad strength to its maximum value fixes
> > the issue, so add the 'lrclk-strength' property to avoid the audio
> > channel swaps.
> [...]
> 
> This depends on:
> 
> commit 570c70a60f53ca737ead4e5966c446bf0d39fac9
> Author: Fabio Estevam <fabio.estevam@nxp.com>
> Date:   Wed Apr 5 11:32:34 2017 -0300
> 
>     ASoC: sgtl5000: Allow LRCLK pad drive strength to be changed

Ah, I'll go revert this now, thanks.

greg k-h
