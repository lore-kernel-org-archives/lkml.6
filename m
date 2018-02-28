Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-476314-1519832497-2-12271000599110361138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES enda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519832496; b=Ykg0/yW12tN2Guj9sDxlgeVJk4chdzBu8aYmRJYiQSzU+7+
    eiPpyBhmj7bzDey0QlqVSNgtPZQ1OtCW7DW7ShAKFH71TRms5N+LaeAHMnAh0SEE
    xYqNcpGIZNwORN3Dq60SDeYIJ+qkVRSYrqtnpuCLpwBXZEMwJ/Ae6cu5fKOXBgfV
    bbFETDBVeyQb9etD7mKDfrivaj8bylcuLVChEoO1kc8gsUXcV5+dM/Wc6kM3IpSB
    SDZHm836/9xm4beb1YWrTKJi675yTKX+YvcE4TUEzwkhnwR0DOnyWLGbG4peRCLk
    /ZF6zQp5GtRyAqv1dgqew3DhrwDmZbiQC6LRamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519832496; bh=kRxaCskFDwdNNm7O8q6nCyAqBSKfswfs431SeO
    Lybj8=; b=jWrFpM3kPJJmZ1Maxh/htkCXkWsn5cVNWGINzsuUXeqBTwcWWg1X9n
    aqcvwB0HIS2xV/tRKETzG1MewSQ0lGDbxtMA/FsVsgEw5RaDBf6Wbf2B6ygrjrXh
    QyZBlI0pkU7eOGZPWxJRJhvYSEVuMePBmJlG+dpN4PqLKtvVQMH7Bo/mST3FdP8E
    y65yUEAx0W1vWndTHz90xkSaHVG3uBphHLMdfJS41/PWKPUWxP2HZ/6QOr76sSD+
    wMe0bF80u0Hutjp9w1qz4dNuTiu6oW5f9+ymhW5HD6puFcnkSy2bQfYUV92o4ghy
    ujFqUrPaHJ/BGSJjz2XnDd5VQhud8YZA==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OTf20BdL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XdWNRG8V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=OTf20BdL x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=XdWNRG8V;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752688AbeB1PlT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:41:19 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34322 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752679AbeB1PlP (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 10:41:15 -0500
X-Google-Smtp-Source: AG47ELuXyX5rn5uqJtxg3JcLwAyd++fAKl6DffacWiqxtYmpR8mnbNaE4Qm0EirvSUPImRi/VO0z2RfZe+YHf1rR9Gs=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
References: <1519815044-22669-1-git-send-email-bich.hemon@st.com>
 <1519815044-22669-3-git-send-email-bich.hemon@st.com> <CAHp75Vd+UcUSG7t6SxzTmUkB6d2TAYVmgO92m9iV0YVJ1=XbzA@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 17:41:14 +0200
Message-ID: <CAHp75VeX_L_B2e648LiBrbHNBEg-C3NBw-PUTmQdhHhEb=2N-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] serial: stm32: update interrupt initialization
To: Bich HEMON <bich.hemon@st.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 5:40 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Feb 28, 2018 at 12:51 PM, Bich HEMON <bich.hemon@st.com> wrote:

>> -       port->irq       = platform_get_irq(pdev, 0);
>> -       stm32port->wakeirq = platform_get_irq(pdev, 1);

>> +       stm32port->wakeirq = platform_get_irq_byname(pdev, "wakeup");
>
> But this one is redundant since Tony's patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/commit/?h=bleeding-edge&id=da997b22c40473b7db60bde6ea188d35565d10c8

Oh, it'a bout getting a resource by name...

Sorry, discard my previous comment.


-- 
With Best Regards,
Andy Shevchenko
