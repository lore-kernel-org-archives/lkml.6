Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1286548-1524493354-2-14930382232326676551
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
    1524493353; b=bbnCs01w3rdGIKncl+xhMVsCChIFmh8KaNArR1HWCigjrGqk96
    idLVdIWTrf/AO6ZLyAN3n+06X2gdamVHqtafkYJZRVZc7I8P0tWUuCvOK4ZoWlk7
    UNHdJzYJhKxGfrvMb7FZKo45+7oZIAZWnYAeCviaQaaVUkZytaiHXciWmxvEHhgI
    1I1MER9/5Izqeyx5XOy+2MAAptqTJV1V+P/nE4atfOQ1vRWXByQ107ikS08KbY0E
    JEMdsdHptX0lBVfWtuYL8aYal6nQznpS9pjkjddriqLOopQmrbCl+0+Dl3yaQvdu
    8VoKPvMU7dKfM1CGr+o2l0B988tvN/tL2dbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1524493353; bh=TBmF4AkHSromOwJzpL+ZEMdG15iWw0
    4+9zdZkRihGV0=; b=PyiK8imAJGwy2UJ1l+mymV+9TMn6OwvrvWfReackDXLBhZ
    Xjmn4oRCPGDinYZjpvWXJ7meMJzkW8giop8GUSlIPaKvTdqGBXU4pfS72NslwUlA
    BGjF+8UXRA3XcTCKQvPWuWMS/uree/uT7guVCrzu7EN9p11UpHfbRHvoQJ4gniGH
    Pkmw9N3LedQy1u9BC3EKZkyMjMJ+d9J3mgO+o6zCAcNeOCEfsveSrcfpyAj54hAc
    1YIVZID8loesoTTwH/Nu/7l0JBUUeIVLRFzjb/TBN9WU8j3mFK/42de+R9tbgg82
    30Lkt9UDJpJWJzEDC5RzOZLO4A7hV6IXS1o4wMjw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfDy//FoCcynEp0gtpZX8K58TT+HSkCUkL7Fq34JfThErbhblysYT6PdR6dP9ojqofUI618bgJVMjaFiPsF4+ePmva59nBEacAE1tHNbT3zCKSJgtWYb9
    ObhOW0UrNZuNpfUgIZm9/Kdkgujejx5NdBI0XJTonOLg/fWMP92SmPJ0ZI3fRKlWor1njuX3sCDYaZKABoIb+aF6DAupNVk84mMIfg2Q0hXthgO+NOtiHREU
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=gu6fZOg2AAAA:8 a=ToIxPfQ0T96HZ5z8u58A:9 a=CjuIK1q_8ugA:10 a=-FEs8UIgK8oA:10
    a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755293AbeDWOWa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 10:22:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:48760 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755184AbeDWOWa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Apr 2018 10:22:30 -0400
Date: Mon, 23 Apr 2018 16:22:22 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Theodore Tso <tytso@mit.edu>, Wen Xu <wen.xu@gatech.edu>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [4.4,50/97] ext4: add validity checks for bitmap block numbers
 -- regression?
Message-ID: <20180423142222.GA31421@kroah.com>
References: <CAOi1vP-oSB65aqWkYX+2AWMHUg4Q8jeRkN65b1xftACR1A=dmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOi1vP-oSB65aqWkYX+2AWMHUg4Q8jeRkN65b1xftACR1A=dmA@mail.gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 23, 2018 at 04:15:20PM +0200, Ilya Dryomov wrote:
> Hi Greg,
> 
> Commit 7dac4a1726a9 ("ext4: add validity checks for bitmap block
> numbers") seems to be the cause of the regression reported here:
> 
>   https://marc.info/?l=linux-ext4&m=152416385122029&w=2
> 
> ext4 folks are probably busy at LSF, so no reply yet.  Should this
> commit be held until we get word from Ted?

It's already been removed from all of the stable queues and a -rc2
pushed out for every tree.  Happened earlier this morning, my timezone
:)

thanks,

greg k-h
