Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-582301-1527102524-2-14166946468374836887
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527102523; b=k6dK7hrl831/r25LbKQXpkTqhoQvv1MQZVPQcR4V4JLjl4g2Ms
    x3xVdcO18CN/BDb4znBXZRtnBJ0zk1b301l6riH1AcxzuQFA6Y9ID9C97KnTG5qH
    HX2+kGD7QhYukpBsFKJbIdfk/FxlxqWkcPdj9dM76D6AWFg2zB0p8eiDBg4TWYDC
    3zJ8niiYa81v0G6vek/HS8vhe9OEFMf3MYwJo6thqiVFsTM31vXjlBscGXOAXw0I
    4uUkW6vp1eI/VqRL4near+HR10shUX8P52J0eOUtQpKwVc21UI7gYohplaPmJu9r
    NiDaMx5dzn90fssUlarDJk8Pu2ZMD6Af5o2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1527102523; bh=Pz3gcAAWa6Er8eF4X4cvoHxowwoaDn
    I7Mb+YSeAOobI=; b=SmZtuf1UZo4fVe28Uzug1R4qavDdPB9WgNMIB0lIKavcBL
    1M/BDuepnDt4soOYug4OyqcAWaFJu5WRkWjMgMaKpIIxxxd2fW3V0NvZydmkgDtR
    MGZY6Ziq3bzLTE6O0DROL4Cab8eHaLLpUqSURo1tCw1uzwey82bHqljVu1oI1/F+
    ZEYO0+GFhKKmiZvk+xXs4PlFuCkTQYUItxhn0b+k+Bxe89zh4NFBk0+/KllEXUaI
    jmCxc7oGOaZ3VTfyaScvGqSp/cnxooTdW8ToiKtxLwqvuu6aVqJHBAKCpWMmrmad
    h6+eHx4oxj0S2sqaUeOq48il7SRI/r8VSkdOOBoA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=stgolabs.net header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=stgolabs.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=stgolabs.net header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNncez8q0RVv9juwhsqWt1fd10p6IhjTx3P6ylVto1P/Mtt4vbIYjS98m441QF+89UqywUxkgWacmlfFJkbTfdAcS8MM0IAHN1GMke61UEqNms1OFChx
    h42lxFU1u+guha6AuJI5T2ddneSbqJlLcrsUOotEY3HMKf2rDnoqTVHBlxR835L6bRxjeCkvFJbE3N46CaS4IYud2qsmCzt94HbEHel9DSG1nkn4UWYZzAVZ
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=R4ayLD03AAAA:8 a=VwQbUJbxAAAA:8 a=1EdCk_DDOrl7kx4UIUcA:9
    a=UrimMgIBG4VXagK2:21 a=MHIRsnAlcpvmskVh:21 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=qJlm0-shE6CLU_iKUWNr:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934053AbeEWTIl (ORCPT <rfc822;greg@kroah.com>);
        Wed, 23 May 2018 15:08:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:57665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933928AbeEWTIk (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Wed, 23 May 2018 15:08:40 -0400
Date: Wed, 23 May 2018 11:52:13 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: semantics of rhashtable and sysvipc
Message-ID: <20180523185213.oagftojqlh4rexa6@linux-n805>
References: <20180523172500.anfvmjtumww65ief@linux-n805>
 <CA+55aFwAtfiMa22-OFGf1dNR8CNzSKjjLLj5UL-HqgapV7Tf1A@mail.gmail.com>
 <20180523183103.cdgv4slom62y56wi@linux-n805>
 <CA+55aFwJtj5ucfx3T-g9VnNgWG7EqHS9+oFMSv8oyv11Yaa2UQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFwJtj5ucfx3T-g9VnNgWG7EqHS9+oFMSv8oyv11Yaa2UQ@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 23 May 2018, Linus Torvalds wrote:

>On Wed, May 23, 2018 at 11:47 AM Davidlohr Bueso <dave@stgolabs.net> wrote:
>
>> Note that even if the allocation was guaranteed, there are still param
>validations
>> and rhashtable_init() can return -EINVAL.
>
>So?
>
>It's not going to happen, because you're not going to give garbage
>parameters.

Maybe EINVAL could be replaced with WARN_ON(). That would grab the programmer's
attention.

>
>Why would you add a BUG_ON() for something that cannot happen? You might as
>well sprinkle them randomly in every damn place.

Not suggesting this. Before I started the thread, I was actually thinking of
ipc using ENOMEM only for rhashtable_init() filure considering the EINVAL case
will never happen.

>
>And even if somebody screws up the parameters because they are being
>stupid, then SO WHAT? rhashtable_init() won't initialize the pointers, and
>we'll get a NULL pointer dereference.
>
>And hey, we'll probably get it later during boot, once the system is
>actually up and running, and that NULL pointer dereference might even get
>logged in the system logs now because the machine booted successfully, and
>mnaybe it will even get sent to a distro and debugged.
>
>So at what point was there _any_ advantage in doing a BUG_ON() for a crazy
>case?

For the record, I'm not arguing in favor of BUG_ON().
