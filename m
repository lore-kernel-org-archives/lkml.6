Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3606188-1521487850-2-12021398455573073861
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='windows-1252'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521487849; b=qCpzu8trQ3vmdZPfx84jNayI9IiZpmpipFfNEDz2TJTyNkO
    uBN6L64O+av6Lm9WKVfvY+1B+gJSoOMSyjPdb1ZbSPvFwfsymaugOvKfvJLdqar9
    oQ3CvCenR450sauMJbbm6+pCjyNmc7iaRZyrn4kEVrf+aOiOcb49iQYe1H8tTZMs
    GpoVlzIeFoosPcR6Kp1jOiuyqk7h0bdXi+4cijNC/omCPKikhNuhVi60QsznnQ3P
    rJGMakdd6LSgT44aAXRDRqgRzWDo8IuK1RiWX+n2xi6PWJdFRP+jFldCBzdLIbaW
    q+SpZyBOzJMwC0wJPrWSmWmCUBsMJHk+lfEDsAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1521487849; bh=CkunFts4zY097w8rs41wWQVCgTzpkjjYRSoCinjJro0=; b=q
    971l/MJPiMfNvRi0d3YHLtoHtStR0Z/Gum78x+jHo/1jqZ7Z2DUexhnY1Drqa559
    NPad2IQSzqWJ9StA5tCA2kN65syh8fWjkUT81PPtvSTtjaxSe+RMyvMICMpcVj+8
    S2WhhCeKUzqKUy73TetrKKwXaZZBPXugIXHVeFsmL0SAL23agZTSikD2K1kXYmrn
    PSSogy1Lzd+u0bgl7YfJn2h84hh4R34LTgGXXPBaH9Ra+skzndrNSE0LHTI0oo0A
    5QwEUxgJJFg+I0kjXJcGPTP3BmYMxcg7VW2ZkwtSx/l16ayyM1jx1yys5jSKPRyS
    gDXOgWmRduYQwNKls8BPQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bsKQUWhE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduvdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefheenucfhrhhomheplfgrtggvkhcutehnrghsiigvfihskhhiuceojhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdekfedrvdekrdeifedrudeikeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudejleenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N6tsavdL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=bsKQUWhE x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduvdeiucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgshhpjeesthejredttdefheenucfhrhhomheplfgrtggvkhcutehnrghsiigvfihskhhiuceojhgrtggvkhdrrghnrghsiigvfihskhhisehgmhgrihhlrdgtohhmqeenucfkphepvddtledrudefvddrudektddrieejpdekfedrvdekrdeifedrudeikeenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeegudejleenucevlhhushhtvghrufhiiigvpedt;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=N6tsavdL;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965986AbeCSTad (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 15:30:33 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:32810 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965728AbeCSTaa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 15:30:30 -0400
X-Google-Smtp-Source: AG47ELulNUahEBhc0MJ0IixLUzj2cifQp0SRucCwdp0jOkOZRPsy28Oihl/jPYPKEjN8oG9oRcnYSA==
Subject: Re: [PATCH 4.9 1/2] Revert "led: core: Fix brightness setting when
 setting delay_off=0"
To: Greg KH <gregkh@linuxfoundation.org>
References: <1521271862-4599-1-git-send-email-jacek.anaszewski@gmail.com>
 <1521271862-4599-2-git-send-email-jacek.anaszewski@gmail.com>
 <20180319133711.GB27855@kroah.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, pavel@ucw.cz
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <27de6e0e-5f1a-d339-01b5-3ec27f8e56b6@gmail.com>
Date: Mon, 19 Mar 2018 20:29:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180319133711.GB27855@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/19/2018 02:37 PM, Greg KH wrote:
> On Sat, Mar 17, 2018 at 08:31:01AM +0100, Jacek Anaszewski wrote:
>> This reverts commit 86b9fa2190907f4f550d9d6bf490c5f89ca33836.
>>
>> The commit being reverted has two flaws:
>>  - it introduces a regression, fixed in the upstream
>>    commit 7b6af2c53192f1766892ef40c8f48a413509ed72.
>>  - it has truncated commit message
>> ---
>>  drivers/leds/led-core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> I need a signed-off-by :(
> 
> And maybe a few "reported-by:" lines as well, that email thread seemed
> to have lots of people on it...

I've just sent v2.

-- 
Best regards,
Jacek Anaszewski
