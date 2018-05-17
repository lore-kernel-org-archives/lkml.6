Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1882526-1526550086-2-2962968928865422227
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
    1526550086; b=c80fvUIyWuorA+ZkxzAVFG+Dx6fVL/PeQEU+SKmloN7UuCoDXR
    t//fe24AHyrviGALCwCPDWeN+VDQmIOB98k4GOvqTf7Rv6n6rovWILfiHTYhYcQN
    7EXvMhGc+IFW7Tg1zjWE9b8HWJ3T3fWSbmVapFUyuRaOkzxsUPqphNDnwg/CuP4f
    8r5qIriXB/R3LKqpslwq8pgQ9v0BcwmaWuqAimIMn10zZNvUukoQXiimvJmffEpM
    Bl93zTFUfELxezA2uQNpvIuwoCvwvDqrn+ehuS9ZeUPpDG7J/KP9kcMg6MDVRDuH
    Kkwgi5N4re6FJys28FWiH6HZeMtH70q/lGUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1526550086; bh=78r9zcHIWv+
    11LnyCngDWVr2JMxNtxhdB2uu8v59w2E=; b=WR1jycW0w5OZTP+bRtlRd9hajmU
    207VgkTPJmcqUfpww85itmC1wxYC+fF2L/GCg99rVib78PdAB+5JOQTTQfgZuTDl
    +lDWF7YBXHcFJX7YJ/rxaCUVYF3D4hzzcLzqyd/itg9dZWLLU1QbAHHYm+D5HJ4/
    1SWwR6EAs+Tpra27tlZ4TBHFec7w6O/EL6tmpfG0k8DiP1bHLyRe1mfuYEEbULSN
    0uX9AURW4xAVjHlJVv3rEceTe6w8lH0wyqmXrHYKdtyGcr5jfHW+SKBgOWb27iSc
    OEey+IqVxCtSfcYP29QPJW+KZp6oMdfmSBZOeE6gV5Nzvk7T4vu5XKT6/uQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
    header.i=@kernel.org header.b=rnHJduql x-bits=1024 x-keytype=rsa
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
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=kernel.org
      header.i=@kernel.org header.b=rnHJduql x-bits=1024 x-keytype=rsa
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
X-CM-Envelope: MS4wfLlRoogdgHF0EkZzgc+YD9MriMW3xg9Hl7TdZIdqpTYmvsh8fX/7d025asWuyPvnRtOCLew4Uvy6hGiSug52LF95hYq1/TKYPhffb3ODR990vBqFemZE
    DhYxLFkIuypQkKE2GU1Bik0LUwkjekY5j2EmmKJWo9kfpAZ/m+KTsixscplmHZ6z0qcoCXfX/HLZXeszExFeA5gL/gTSnfxIvzPDwf5bXGcWHo/8aPJqgzWX
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=HSIkpTvyAAAA:8 a=gVr2FklhhfKLCM1naSEA:9 a=wPNLvfGTeEIA:10
    a=nEgUQDT1tczs5vzW8NB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeEQJlX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 05:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeEQJlW (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 17 May 2018 05:41:22 -0400
Date: Thu, 17 May 2018 11:41:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Antony Antony <antony@phenome.org>,
        Richard Guy Briggs <rgb@tricolour.ca>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 054/190] xfrm: fix state migration copy replay
 sequence numbers
Message-ID: <20180517094104.GA28396@kroah.com>
References: <20180411183550.114495991@linuxfoundation.org>
 <20180411183553.484169269@linuxfoundation.org>
 <1526415414.9159.57.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1526415414.9159.57.camel@codethink.co.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, May 15, 2018 at 09:16:54PM +0100, Ben Hutchings wrote:
> On Wed, 2018-04-11 at 20:35 +0200, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > > From: Antony Antony <antony@phenome.org>
> > 
> > 
> > [ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]
> > 
> > During xfrm migration copy replay and preplay sequence numbers
> > from the previous state.
> [...]
> 
> I noticed another similar fix, which might be suitable for stable:
> 
> commit 75bf50f4aaa1c78d769d854ab3d975884909e4fb
> Author: Antony Antony <antony@phenome.org>
> Date:   Thu Dec 7 21:54:27 2017 +0100
> 
>     xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Nice catch, now queued up.

greg k-h
