Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2519967-1522791590-2-7026862543636195453
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
    1522791590; b=dJ9nZT84FF/TyW2bPHQ4l/1LM4IJVS+eWkjge/5hPxYycyvb3C
    Z8XALzZKgjVPDihC648ux0ekZfHRquI/L2cWrACqwyxtFnWKoU5nV9gQ176SFt6x
    1AkyP+4FH5p8EZdEEENIPJ5VoQ+q3vrbioLMLoZYp/2awpA/R3MPfxxO0oPltdn8
    CF2f7oEt90s8qP2wNEop8/8G4MpHP6RY4SMEnd81h2HyAkdVGA14KgujfDcQhbUd
    x3J2QZTWaXjjIaA9UU1BigBJrPG7kUuOp3g1cVhmfdiwzEKTchtf0pKNzRadJuVv
    aOdy09MC/l1rOi+FSffKaJmMf7qcVB1olbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522791590;
    bh=bnDb3DU9Hj9N+ml0RNjcefkc1wdH+XqJCQ3QM7OHvDA=; b=fFd/fbcxPyS4
    xwtDXy3PfZymnteGdnpM6XEDE6dn9N3254vbvbpEknUGzsKsvw78F6AITdzAP3va
    VIYAqHpiPviFCwJAdd0vUFXuwO40Zu6770Rq+bnXZryaUxoKWcMbnino1t2lqSwP
    I0sqZY8HDk+IV+AtG42UqEgHhufZ6qlVoAjcTWnBAWfg4eC6S8eikzNYQf0wTcIb
    oy8rBllm1mngkIUYzqfSsjTzcPjxX+dPWR26h63ufPuCXD1K6qSDjEyCBNEJuBht
    5zR+d07HQejsSI66t6WUFQ/pUBm9/n8edL6axTY8FyzuqQA/C6WvFB3Tbtpj2ZA+
    f6ZFOmaieA==
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
X-CM-Envelope: MS4wfBheMeVzdya/oBZqqP4jmELY5OdZYs3ir3jCFxAuGMIV6R+s8xn9uwDg3HOvRYZ9ErGO41EL8pTSGnbXXszwx183HITO8SKHjcfpqcx6w2HUkjaVA2PJ
    VI6VErLMkzY8WIAtSCksVRTikMWDNRIPeMeYe0ZlXUeEP1CiaCdjPaSZdMoloZTPFUAQzfz1xyQ05NizMFmlhV0kbr6FOqUEzkoGzFcIP2JJM6YqF6OrSjB4
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=i0EeH86SAAAA:8 a=pGLkceISAAAA:8 a=G3VDakNVtRGz8tb4YPoA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDCVjr (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:39:47 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:33982 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752845AbeDCVjr (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 3 Apr 2018 17:39:47 -0400
Message-ID: <1522791583.2654.140.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 68/97] net: hns: fix ethtool_get_strings overflow in
 hns driver
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Timmy Li <lixiaoping3@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Tue, 03 Apr 2018 22:39:43 +0100
In-Reply-To: <20180323094201.429866014@linuxfoundation.org>
References: <20180323094157.535925724@linuxfoundation.org>
         <20180323094201.429866014@linuxfoundation.org>
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

On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Timmy Li <lixiaoping3@huawei.com>
> 
> 
> [ Upstream commit 412b65d15a7f8a93794653968308fc100f2aa87c ]
[...]

This is not a correct fix; please also apply:

commit d61d263c8d82db7c4404a29ebc29674b1c0c05c9
Author: Matthias Brugger <matthias.bgg@gmail.com>
Date:   Thu Mar 15 17:54:20 2018 +0100

    net: hns: Fix ethtool private flags

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
