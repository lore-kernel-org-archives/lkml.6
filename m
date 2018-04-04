Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804109-1522800565-2-2168769781937814154
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522800565; b=ry/AQ2eYZB+354ag8eVsLFGiI1X4ANOzSRojFr+VNOZUVPBVRv
    o4CyGWfqlFum1XRzCvNmsmB2ixoM6D7BFHsAs/GuLZUaCsbNVnFj3yWrpPj5Y1ze
    rum+N2FdXAoYuA0IiH/JKldOVzyEgdUSlDnRyf4hQb4BlzS4hgkvRwrIEl3yTTXE
    zZALi/qNA8waHqIxcZv40uUuvYVg5slFNfIzYPMceFrRgafJoI6Sj/odcGQFRS7X
    nIBq/C7yg5Cpbn9MUtQ1Q+jyFfM80ZtpGhlutwww0zVaIlxtbWVp0N6KWQ6DZLMP
    FektL0yKIggx6FbOalJFdshknUP3zb/x0/DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522800565;
    bh=+E4xNs3dZN6SAwlAjhV5dsVidHbcaUK/lJdzEwvjHGM=; b=TOpTnMBcHRrM
    lekMAAnaCE1x/SQAJ/LlK4eKdVcnu5qupLmpcyUFJCPsX8xYHB7LxTJ6fDocASDg
    l6oY72tV4/n8I55eGL4oQYhOeavDL7LuPNBwYJ+0RFE6CI+bJRncRQspOW5zjdd4
    7ZvcZ00sQHhUKIxWg2MU+5TCA9YPw1a6kDkrcbydgabDKzXxdmFowlFqWDRd5CrZ
    8Vq2CUSavXf8o/sse918xmad2KWprv/W8tJsUBKLkauy45YeiLztE9WsaeS1hU+h
    Jse+pJIRNwtzJIdmCvfy+TotaghaqT9Tc+QlzA7miuGW9/aIfLlpysopXdKwClWp
    dbo7TxI1jw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOWdWvWj1P0bZ6Q3GiI3cz1N+eO5TajY3K4rq14fqap1cI6MHZCllTCoJLR9of2vCjytsdRU+E0d4QNYqCsnLaKF0BcR+CfdIf6hwbJxLJGJ6OtQJ9bi
    /lzMmHKuu4PDhHpGgeIv0ZYsUL/80j5BOZ/enExGpjDYGUetrX/8RDVxaYz3k48thexW+lyMojlkD12++pmRCL67WxY8wdBQL2tSsAVgWQNxAjPcVWbeUOVP
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=ZuHWeD1obCV-Lxef7IwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755324AbeDDAJX (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 20:09:23 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:34932 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755966AbeDDAJW (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 20:09:22 -0400
Message-ID: <1522800556.2654.158.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 92/97] ip6_vti: adjust vti mtu according to mtu of
 lower device
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Petr Vorel <pvorel@suse.cz>,
        Alexey Kodanev <alexey.kodanev@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>,
        Stefano Brivio <sbrivio@redhat.com>
Date: Wed, 04 Apr 2018 01:09:16 +0100
In-Reply-To: <20180323094202.622913188@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094202.622913188@linuxfoundation.org>
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

On Fri, 2018-03-23 at 10:55 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Alexey Kodanev <alexey.kodanev@oracle.com>
> 
> 
> [ Upstream commit 53c81e95df1793933f87748d36070a721f6cb287 ]
[...]

There are a couple of follow-ups to this:

c6741fbed6dc vti6: Properly adjust vti6 MTU from MTU of lower device
7a67e69a339a vti6: Keep set MTU on link creation or change, validate it

The second of those will fail to build on branches older than 4.10
though.  It might be better to revert this one instead.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
