Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3563148-1520436750-2-8086705475540675383
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520436750; b=Aklf8EIYe5gM/lSDpdeOCVIjnFDVDcGQ+Uu0kRuG1I8G63O
    ah//cQhVRimjsd7QAXRS4zHtXF2BT+ToJG5slnKzvOvdVZUOFbkaSqKEjv5MZhmk
    cOzky3Jtrt0MZjui/cQ5suyhFdDgLJno8CDikTiZzttm9bGtDZyiL4uF0KIEx22v
    D+N8ckjSjbd4dVjPtJLqpmi0YeUq8KF0GOtIuAv4liHUEtumcpeMtBVkWOhYIYbG
    Gzk9AIhWoEyf5ZyiV+0q8W8lGt+FezOGvGCVX47WoDOez2sfM3O6fL+pnreJQDLh
    LUaauvnTeKODb+WW76kigKOc3in5ijJtRMIBQng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520436750; bh=k1eSP4dJTJu1ZMjbM036Fam+gUnb7I8t8+arR412iOU=; b=B
    KHSycLX1IVZOH87FWBCs5hYniyiULL7ZQ4jH5RIRyjnAiJ+KakLKmWBgFokyAh2m
    kStd1xVRvVpDL2F/vaui3sl2vRXR68kGja9WIwZW9Z24ghCLBBpzwgl1ngT9ZQsH
    YibZaYRC3JCaPtMPG9x5NLwY78cDcn9Lct/SqVo5Kh3bHCt3mAMZY1WDb9vzByVV
    bWfjD4dJwQ+WBYduPmyI3CN8pnXgfs4qq5Ez4bn+/uFfxpNMoMC51d/Ks3uvTYRh
    ikeqiRF17khwA6ElFcO6hMCmLeP+RuJDmP8wTCqBTKRwdbdKi3T6R26beZWQG2cq
    +9Hx0WUw8+pzjrudQPiLQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933668AbeCGPc2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Mar 2018 10:32:28 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:53092 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPc2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Mar 2018 10:32:28 -0500
Message-ID: <1520436743.23626.33.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 16/34] led: core: Fix brightness setting when
 setting delay_off=0
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Matthieu CASTET <matthieu.castet@parrot.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc: stable@vger.kernel.org
Date: Wed, 07 Mar 2018 15:32:23 +0000
In-Reply-To: <20180302084437.007951262@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
         <20180302084437.007951262@linuxfoundation.org>
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

On Fri, 2018-03-02 at 09:51 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me
> know.
> 
> ------------------
> 
> From: Matthieu CASTET <matthieu.castet@parrot.com>
> 
> 
> [ Upstream commit 2b83ff96f51d0b039c4561b9f95c824d7bddb85c ]
> 
> With the current code, the following sequence won't work :
> echo timer > trigger
> 
> echo 0 >  delay_off
> * at this point we call
> ** led_delay_off_store
> ** led_blink_set
[...]

The commit message got cut truncated here, which resulted in addresses
being omitted when it was sent out for review.  The upstream commit
message refers to a LED_BLINK_SW flag which is not used in 4.4.  So
this fix probably isn't needed, though I can't tell whether it does any
harm.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
