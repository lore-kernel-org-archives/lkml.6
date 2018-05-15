Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3198856-1526415424-2-15026891017812068027
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526415423; b=DytxR7NOL27psLKo+Jv3YeTcBWTrGjyePcaBtdzkN1TpF1kZhT
    VGlafoa5y0CwN0AqWFUdZQ3VASMFy8692eP3jym119/+xJ88UXiPuZpumvVUcTsY
    tW+yQonabw44Z8wz+RjgecU8Rey3o9ZlpGAW1i5MxcBqsh1JD9IuiMnTb6PCg1iK
    2WqJHwYB8pmLcg/4WfiyxqchwAY7TryYVyshQfpuFkRQbqBB5P+LC44vKb3m6Ozk
    lu4btAByKjCerFPRrmN4/OlL3DFbBOwS2Y1dOYWo5y/e9/Fw0rWIAjhqu3ay5Yde
    uSVfUGL6U978yXPPff+RcFhFvc/basb8XkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526415423;
    bh=sz9jsx3VD8IArT7umc8HnCTYauMZnRg4+68DxDsZCgQ=; b=CGp+VbkTbqTh
    MuqyWz48FgWa7F+ZgEIAMZGZeHbAP0RuevWDklwXdsXUprhWtvB7OEGIKp1kGNM7
    5idDN3mIjNQTS1RcCQM0vyk0HmQKyMwu52q14Ez1y89rPghO636BD7X4QHWozWto
    0WNORTFSStaW66MTidhLwdqS5SJVl47lb6YjpP3iFoCqRaWDgrvFOuOJOubEo2EO
    E5SI6IFq/lw93pWXgqpkl/CvAye9LZVGMZ5y4fDvOQSH1Tz+328zzCbt01TXQIN+
    yb6ItmIFpDarGWwofb9J+wLuHanOL/+cPRvSSZ5tkt+1gb+Q+cEZDTINzNUFBhDr
    KwMvarG4Rw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=codethink.co.uk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=codethink.co.uk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMMhyCH32ZesUvaOF4TFT8TTH1inDyXJnmh8QFsI683uNCishX2KGyim+lgRNitsxYAY204JScustTWefnCrPi4xBMC7beL8lx547+4wHX8mOHLMORFX
    IEzo4T5qzc+Irc/CeNBo75DrVcyu0pwnfWwd2V/PaGYtLOhRu8PA2XZvULhh1Taw15YczvuoxJY6LrZUXMuLBRQpdy+GesT5d0mEPzeyYpT9RQquIpt7TU7K
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=HSIkpTvyAAAA:8 a=af3WO94KfBcm7QW0wYQA:9 a=QEXdDO2ut3YA:10
    a=nEgUQDT1tczs5vzW8NB_:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751284AbeEOURA (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 16:17:00 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:58023 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbeEOURA (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 16:17:00 -0400
Message-ID: <1526415414.9159.57.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 054/190] xfrm: fix state migration copy replay
 sequence numbers
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Antony Antony <antony@phenome.org>,
        Richard Guy Briggs <rgb@tricolour.ca>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 15 May 2018 21:16:54 +0100
In-Reply-To: <20180411183553.484169269@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
         <20180411183553.484169269@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-04-11 at 20:35 +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> > From: Antony Antony <antony@phenome.org>
> 
> 
> [ Upstream commit a486cd23661c9387fb076c3f6ae8b2aa9d20d54a ]
> 
> During xfrm migration copy replay and preplay sequence numbers
> from the previous state.
[...]

I noticed another similar fix, which might be suitable for stable:

commit 75bf50f4aaa1c78d769d854ab3d975884909e4fb
Author: Antony Antony <antony@phenome.org>
Date:   Thu Dec 7 21:54:27 2017 +0100

    xfrm: fix xfrm_do_migrate() with AEAD e.g(AES-GCM)

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
