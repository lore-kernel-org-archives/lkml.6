Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2341778-1520526731-2-7261546042362535020
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520526731; b=L+ZabJmPxTZ9Nv2PDNUvcYVIk6sI2ghDQskGtubf5uEgjcm
    0F457TPDpejb368YcuDbkShbjld7y1DPkM6/7PsKhL7D+L7MJdgzpUrPL/oR3xxU
    XKAxSdp7R+gKgef9dIj2nysnYDJbO8Il9DA21NK/4BtFb3YmrnqGVl8qOcAG+vtE
    M9y4kVxmu56bYnjb5HMXaQGyNxWKwHN5kBrGgMEZPgCvDMEz5HO+Y6FuupBiR44G
    LOyZHwMGgXa1PXMbFGgRw90j7WTayhwvsp5ubQOxHVBAQ/hF1KdPei8N3or/9t/y
    spSo06etOF23EmdGUcERWVnIyq2jl1WBIqEIjEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520526731; bh=gH4602uLCZDLfMpIbylChUhbCyxK1CyBRjeSgAAniz4=; b=O
    e/9fSo8R7LJMhBf6Otch5VTRBa8Bu1MgCYbjnO5WzzfobSgWT59iMqlYcJOHmWgg
    0SFZTCv6aqyiGKsccEu2pzz9aanJIeZbQAKCK+xhFRx31J6hl8E/Qqr3YDbdOjpK
    N6YziceFSRWwVHFzbPyjyqqtgDoZjh91+A8W4vLjkYPw14pv9C64TkESQvT/FlCp
    qqi+cP72DcIqSzaejSrbyowyPSJ1PON5zWQPcdd3PfzQ9Dzmn1BDuRaLJCpHHmJ7
    mfGM2n5tShp6D47xym2210vZpZdPBi0VZ1sas66ElYbJv5fknb4SB3Ds98BbYE+m
    3Zirwsv8LDMxb8g/KeyZA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tVoGPoRR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SqMfUZ4s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=tVoGPoRR x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SqMfUZ4s;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933560AbeCHQbw (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:31:52 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:41072 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754612AbeCHQbu (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Mar 2018 11:31:50 -0500
X-Google-Smtp-Source: AG47ELt2iljdQDTIsm9+2urWI7dPtMoa9P66FGOqm/rEBv8icKdhUhF9gcwvYdZMIpoShoMaBcefSg==
Subject: Re: [PATCH] net: xfrm: use preempt-safe this_cpu_read() in
 ipcomp_alloc_tfms()
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Greg Hackmann <ghackmann@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180307192416.233202-1-ghackmann@google.com>
 <20180308073328.GA8111@gondor.apana.org.au>
From: Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <feddabcd-61c5-a1ef-8c1e-6e3f1d71a9b9@gmail.com>
Date: Thu, 8 Mar 2018 08:31:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180308073328.GA8111@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/07/2018 11:33 PM, Herbert Xu wrote:
> On Wed, Mar 07, 2018 at 11:24:16AM -0800, Greg Hackmann wrote:
>> f7c83bcbfaf5 ("net: xfrm: use __this_cpu_read per-cpu helper") added a
>> __this_cpu_read() call inside ipcomp_alloc_tfms().  Since this call was
>> introduced, the rules around per-cpu accessors have been tightened and
>> __this_cpu_read() cannot be used in a preemptible context.
>>
>> syzkaller reported this leading to the following kernel BUG while
>> fuzzing sendmsg:
> 
> How about reverting f7c83bcbfaf5 instead?
> 
> Thanks,
> 

Because that would not be nice.

this_cpu_read() is faster than going through raw_smp_processor_id() and 
per_cpu_ptr()
