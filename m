Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3114275-1517596467-2-202751734612111013
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517596466; b=PaYecaUY3PxcSx1mPeZVljmJxpHP++mNaiT6IfNzpqbN4g9
    oEOAZ0qDJkG0vdNnzfUNp4BkwWrMWgpZXAbPGv1cPakZPMfBIpAuGaVhJLXgtGBL
    wZkb8sGyVsWHub6Ij4vZPwAbxKBTZHYUml2vnolLw64s89zLTljB5yg2UM8Hitio
    AYL4v9QWXRGdZb58Aqc0d1qK0bRcIIIA0eh4Y4DLSZ0NqS1HfVg8XVsQFfJ0cUco
    /5m10RLp0+XBOq68nLbMFhsWEkTLVahYWbWEfNp1g47Z0MU1m57ISXlwcaMJtum9
    omk5aTs+7GY6Zb+Nsq0mmlCS1h/vT8h2CnhABkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1517596466; bh=Lm0j6VmtiFYEzm3eDbkDNDQVsgi1XN9gOgO/EH
    tlVx0=; b=svQlsdRj5+02+eIgU7Y6Sfg1MLh9ZAXAXVOlWacyv+wAY9y6gshPRf
    zrt1Qh7sBA21NS38eoL2GDa8NdsHkqKQ12dVfL62JiX9k0aUqS43LrP8FQj42sa6
    QFYPy6+SoVX63N7fTNM0BcrmT0rVIYeHxIwyOoGMS1kd0fZ/N62rzLSXuM49Jma4
    5Qepb0DPt06z9Rg0duWxK8lkB5dJ01DYFTqyBzQd84IplaCDlz20Cqaw6gOe4bWY
    chPcVMGw9raht9I7tOLtf7juQmUwjwDSGP9UlQ4xdR8aCCYmFc9elz9JO5NlyZeU
    HciTECjUnh2wrK7qUh0r3gD4Mq7PYeJg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ASUOP/v6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DIBb4wBi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ASUOP/v6 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=DIBb4wBi;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeBBSeX (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 13:34:23 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:38229 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752210AbeBBSeW (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 13:34:22 -0500
X-Google-Smtp-Source: AH8x2264r3Uo/0mwtWGISe0FdWxvv48oNvDlOInb9/ULHDE/qORXuPxQPthDwqqF36qTFdsToIfmkw65MQWZ2NLDQwk=
MIME-Version: 1.0
In-Reply-To: <3a4fa32b-7909-9fa6-4b6c-71d6b51ad35d@suse.com>
References: <20180201124019.11693-1-jgross@suse.com> <b8f04374-97f1-76d5-81b5-3583441833f4@oracle.com>
 <CABZSBQcmKBGZ2-i-YRL=Ux6hcAP0peR1zfaVh4Go9vr=JTRThQ@mail.gmail.com> <3a4fa32b-7909-9fa6-4b6c-71d6b51ad35d@suse.com>
From: Chris Patterson <cjp256@gmail.com>
Date: Fri, 2 Feb 2018 13:34:01 -0500
Message-ID: <CABZSBQeJCCRk6bxzsR=omeJaNM8kCfJ=nhdASahqsxkmx+Sh8w@mail.gmail.com>
Subject: Re: [Xen-devel] [PATCH v2] x86/xen: init %gs very early to avoid page
 faults with stack protector
To: Juergen Gross <jgross@suse.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 2, 2018 at 12:56 AM, Juergen Gross <jgross@suse.com> wrote:
> On 02/02/18 01:36, Chris Patterson wrote:
>> Works great, tested it and it fixes booting Linux v4.15 kernel for me :)
>
> Can I add your "Tested-by:" to the patch when committing it?
>
>

Sure thing, have a great day.
