Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4053558-1517502031-2-7243654730828137399
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517502030; b=YkLIId1fSoDsxzaLDgAB4QpXViPOYGYUiww58GatOukvUE+
    rRSyaQIWoQ1YinEB6CnxNVJadfYJtEC8C+AuLpmqS+V8crSYOncf/iBUQ/EG2nm0
    0IZ732dmFAFhn2MOvYa3SGQ7GIlNne3WetqUVqkTfW0kXOIgOfM9m2Z1DmMZsBD6
    81SAyNzkZ20ZziKQl8JUiX/RNS4PeKS1JSMBydaDzkxqmHwS+Kqvz4p8U37drmMD
    3JwDdXu7YRReGV6TrtL9HGPH3FgpH1752VuvU+ku4a0X81iELYtXCu4WDbcX5OdG
    cfLqg8iP8I6cnN7zesRprNiXfIzqS3UUlSZfU2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1517502030; bh=1qudofcTZRbH1LBx0/rvoOvVDL53i36Kjg7F/CaSJgU=; b=J
    db8YnLObYBgFUHBR9Q/fX717japgk62GWyS7yXvzZDFQ35TKPGsJN+5+t2CEku9K
    rVe9Ps4MyYgZkN6MFCYBZ64tnIVWWGRFQu/9v2fGEpyG8dtwrP+EVHTwo0IZxGNq
    Ws9HpdaSb/QBb2O4x4OxZ+BuauqqotbL7/yfDXifYPFN1aCdTUZw2igZhPWosMVk
    0HnzSnQXwook1y4vQtxcndYA41McmOZ7h/IGAGqDHj7lgNBwlfGYOuHJ+JMtbFsN
    CwLNfSEhLOOTJSjyhNmNisAmLplWsf594K4PFR46W46Hm9R3jSnTVNtFk51Jx8T/
    Wh4bCA0nU3fFWkJUT2lRQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=HIQDhEi/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S2xB8Aqm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=HIQDhEi/ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=S2xB8Aqm;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=android.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751988AbeBAQUR (ORCPT <rfc822;greg@kroah.com>);
        Thu, 1 Feb 2018 11:20:17 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:36843 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751718AbeBAQUP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Feb 2018 11:20:15 -0500
X-Google-Smtp-Source: AH8x224X5Sj492eHQaOVLZjXpfGTjGZyGwo3+B9tQME2Q5rOZPObuaYHony/dlPAfS5uFNLNWumAtg==
Subject: Re: [PATCH v2] general protection fault in sock_has_perm
To: Paul Moore <paul@paul-moore.com>
Cc: linux-kernel@vger.kernel.org,
        Paul Moore <paul@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Stephen Smalley <sds@tycho.nsa.gov>, selinux@tycho.nsa.gov,
        linux-security-module@vger.kernel.org,
        Eric Paris <eparis@parisplace.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        stable <stable@vger.kernel.org>, James Morris <jmorris@namei.org>
References: <20180201153708.63506-1-salyzyn@android.com>
 <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
From: Mark Salyzyn <salyzyn@android.com>
Message-ID: <5fb5622d-e58b-c174-3d5c-bfe55569b88e@android.com>
Date: Thu, 1 Feb 2018 08:20:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <CAHC9VhSdR9UGpYhod5xhA76EbSKHzTW5rEiYWMovC0t6gfowig@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/01/2018 08:00 AM, Paul Moore wrote:
> On Thu, Feb 1, 2018 at 10:37 AM, Mark Salyzyn <salyzyn@android.com> wrote:
>> In the absence of commit a4298e4522d6 ("net: add SOCK_RCU_FREE socket
>> flag") and all the associated infrastructure changes to take advantage
>> of a RCU grace period before freeing, there is a heightened
>> possibility that a security check is performed while an ill-timed
>> setsockopt call races in from user space.  It then is prudent to null
>> check sk_security, and if the case, reject the permissions.
>>
>> . . .
>> ---[ end trace 7b5aaf788fef6174 ]---
>>
>> Signed-off-by: Mark Salyzyn <salyzyn@android.com>
>> Signed-off-by: Paul Moore <paul@linuxfoundation.org>
> No, in the previous thread I gave my ack, not my sign-off; please be
> more careful in the future.  It may seem silly, especially in this
> particular case, but it is an important distinction when things like
> the DCO are concerned.
>
> Anyway, here is my ack again.
>
> Acked-by: Paul Moore <paul@paul-moore.com>
>
Ok, both Greg KH and yours should be considered Acked-By. Been 
overstepping this boundary for _years_. AFAIK Signed-off-by is still 
pending from Stephen Smalley <sds@tycho.nsa.gov> before this can roll in.

Lesson lurned

-- Mark
