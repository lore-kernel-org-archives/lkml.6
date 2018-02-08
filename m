Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1401688-1518058235-2-15853609087939167008
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518058234; b=Yp6grtYO8YTGZHR6QQgLNQLgjy0FRlSUWYyiaWEu2boR6Nu
    wzwD8+GGGP0wWo/3usx16vEE42hNBI8QcLa8SZxOMWM4vUyyES5rtzfeXfkGCd3+
    6+hWRFG00wZZImlUXmOw70xWbXjGyF14DgGDQuiL8FKMuVA0Ea9WJgVioSpSscDY
    RIt9qxS9vGIblVVsyU2pPYN/kdavaW5Ik+Ui1C97uA/DcWBGWoxIIXeZ9PeBnH9f
    sDNaw3VZwx5HSMSmb2YLcq7KwahoNxmyRYpGfjkdMkF6Ix2lkTojk9AX4IdjXYIR
    4nEzfaBfG6YTkQPRwmlAMQboKtQcNmHavWubpwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1518058234; bh=gemw0HF
    JHA379tGGhBQ/oEzEHSlMOeovLleXcJ0ywBs=; b=fP5XMvz30O18oWOBQmO1JP1
    SSg2ztugPlNVsx0g3/tfNKWZHMl7BfpTW3QtW1wjBBOno44NxZdhi5Xc7UTcBiAu
    UYAMv5YGGtneSxxKS8ky+uirLc0C9wbx4p562UXQP3pL+S7f7yJOB+VrKgqMvEmX
    8rtEgsOrt8tMCRLwouL1GjEStjSnRNna0twMYGNBJb8VDT4QjnkwglsUIItloGQe
    w5zfObOGVZlxfnJcK5YecaI1ZtHWMoVAnN5fafcgOapr3JJPs25SssJkj0SKi0k2
    jDm9vHtynG7qAfzIdCEIIiCw39h1Hlvsk21ORRZ4WJ6FBtVKvcoa+6G2ZLECi8g=
    =
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
        id S1751946AbeBHCuc (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 21:50:32 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:48132 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750806AbeBHCub (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Feb 2018 21:50:31 -0500
Date: Thu, 8 Feb 2018 03:49:59 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        KarimAllah Ahmed <karahmed@amazon.de>, stable@vger.kernel.org
Subject: Re: [STABLE 4.9.y PATCH 0/9] Backport of KVM Speculation Control
 support
Message-ID: <20180208024959.GA16399@kroah.com>
References: <1517938181-15317-1-git-send-email-dwmw@amazon.co.uk>
 <9ea4d52a-7ae6-a179-2f86-1e7b77255387@redhat.com>
 <1517951146.3677.34.camel@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517951146.3677.34.camel@amazon.co.uk>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 09:05:46PM +0000, Woodhouse, David wrote:
> 
> 
> On Tue, 2018-02-06 at 19:01 +0100, Paolo Bonzini wrote:
> > On 06/02/2018 18:29, David Woodhouse wrote:
> > > I've put together a linux-4.9.y branch at 
> > > http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> > > 
> > > Most of it is fairly straightforward, apart from the IBPB on context 
> > > switch for which Tim has already posted a candidate. I wanted some more
> > > review on my backports of the KVM bits though, including some extra
> > > historical patches I pulled in.
> > 
> > Looks good!  Thanks for the work,
> > 
> > Paolo
> 
> Thanks. In that case, Greg, the full set is lined up in
> http://git.infradead.org/retpoline-stable.git/shortlog/refs/heads/linux-4.9.y
> or git://git.infradead.org/retpoline-stable linux-4.9.y

Many thanks for all of this work.  I've now queued up all of these.

greg k-h
