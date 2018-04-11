Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2635071-1523457893-2-12158637561324740838
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523457892; b=JICRGILRv/ks8xeJtWDQ3HML70qKH6tkb/vToXZgdbHT44QrxF
    0GI4VoYSc9vGR3HUbiVE2yr6p1uw3z+Vs1WAeIsgMKvKh5mvyPkf6TSOx9KgX+9L
    Ry584bpFUmVX1JOaTMUs4whq99een1O5Q/fqr3Y8U27vILmihVMlSAmXrSWYn98L
    nPyLjt1TZvgmfIyDY4mJcmtevoOhBjmfpUyyRQx4/XWWHRKSS0DLkGERQkJvcwqn
    uq69cnDkCSYdPuzau2/jTmHlq1qH4/Joe2CBO0UhR+HQ3e30e6kAy7F7GDBaSZPo
    XtwquMepUAOnzuh9/F2OdQ+AcUrZzF8Glajg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:message-id:to:cc:subject:from
    :in-reply-to:references:mime-version:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1523457892;
    bh=9SazLx4zAudYBoV8pUsQTQxFgZTsdO/yK7HOjYD/fEc=; b=ssqKX7/Kduhk
    4crEWZCTKfJYQNpo77t+JYiyLzhzFGXemAgy5iuq2qzc3V5GL9OA2rlscAmjpxxL
    TCC4fL0u9WGorBbQPJsN76zCQNM+DQgpTrH6dTyiLnnRJ4q2bo7WyWH3ZAjNJT0y
    fZ/gVCUThBe0YYQBvJxxOZIjSrdOdHCro9labPY/mibsAO12LWOcllLeYXASHVdy
    WCmri4xe3xYhrvlKstu4F6+49LIrF+8HJlVYoK71DuTwaB0rN5O8+oS2RmOL3QbH
    AYs3St//VOjEauOnIk3NjcTWHcx6WReADnyWzG9BAiNDrbDTGlQJ36R+8wtxGWjS
    D/H6lAXE5g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=davemloft.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=davemloft.net header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAof5fymSaOiKop4BbHt7pt5fw3w8/Do8o9qjc/joElsUV9pPnIGsRf9v5nPiUql/7sEU2+SMLDXC/fVdwywrznPHdZetXUlzMKkR0pspCNlCVbMGiRu
    m+apQIM22LfGtmoG6q5/c2QHqCzJvU5sN/8ml/kZzK7JZkzmjy0yM6L+n7+t944RFofShsNcgph9EZ02BW+9X+z6PoTU8hjkn+6CmbWes3KCoBm2IqwIA+E8
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=20KFwNOVAAAA:8 a=gu6fZOg2AAAA:8 a=xowBwbGdq_d2mvTJMskA:9 a=CjuIK1q_8ugA:10
    a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753267AbeDKOov (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 10:44:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:41458 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752943AbeDKOou (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 10:44:50 -0400
Date: Wed, 11 Apr 2018 10:44:48 -0400 (EDT)
Message-Id: <20180411.104448.240595797106804343.davem@davemloft.net>
To: mst@redhat.com
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        syzbot+6304bf97ef436580fede@syzkaller.appspotmail.com,
        jasowang@redhat.com, stefanha@redhat.com
Subject: Re: [PATCH 4.14 134/138] vhost: validate log when IOTLB is enabled
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180411162435-mutt-send-email-mst@kernel.org>
References: <20180410.205553.264864966341341110.davem@davemloft.net>
        <20180411080413.GC2137@kroah.com>
        <20180411162435-mutt-send-email-mst@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 11 Apr 2018 16:25:15 +0300

> On Wed, Apr 11, 2018 at 10:04:13AM +0200, Greg KH wrote:
>> On Tue, Apr 10, 2018 at 08:55:53PM -0400, David Miller wrote:
>> > From: "Michael S. Tsirkin" <mst@redhat.com>
>> > Date: Wed, 11 Apr 2018 02:33:16 +0300
>> > 
>> > > That's a bug, davem just queued a patch to fix this upstream.
>> > 
>> > It did not get queued up.
>> > 
>> > The patch series didn't apply so I asked the submitter to
>> > respin and resubmit:
>> > 
>> > 	https://marc.info/?l=linux-netdev&m=152337186209819&w=2
>> 
>> So should I drop this until a fix comes in?  Or keep it for now?
>> I have no objection to staying "bug compatible" with Linus's tree :)
>> 
>> thanks,
>> 
>> greg k-h
> 
> Fix was just posted.

Yeah let me integrate this and send you a copy Greg.
