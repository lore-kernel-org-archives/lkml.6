Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2519967-1522792150-2-7868229620599755054
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522792150; b=d2/iwXoVOJ70PcZTZOedN5ajXRJwxKB/87YeePgHVV6rARZ7BF
    TS9nfpEh+NNTGLri4v9kMompvOrChrv8fr+5sT4ghFSZ6SwkqTUWJ9LzUpJHVWS8
    PCh5KMGpaOrYOcrUBJGXhhmJaoyXs9b2EjYvKbAu+XBk+6hWzuy45/4f0Zxikz21
    9rHUlz39jRlt9FjdYTGZcprTUXJoy76tQr0VGXhDS9nigtmZ8pvatO69mshK3jNG
    OhwzZVO4TA+0rXp0ClB0pTMlfR0orUOXM0v41IXwaKOaad7swt+B1kY+dJg4+QXV
    WWub9r8lbnrVrt7812bOZlKFyxNtFKyPowWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1522792150; bh=NenRHhsUCuR6ijTbFoeV/67FTW8LBK/NPt1S/Lc
    zZEk=; b=Lar2MQ4utnDLbbw0m3TeHfzqpI+SMESbEwOC1SxlkAbrbjsLXSgycbl
    Q5ZMnFul+FvKsxIs1dKQfLZ/hBe/39Ik06Z6T+DVrUKbPCacZnm3xjkBFyjE8ryv
    oJai7jvxq20ORHLlu9X1ej6OxU4ymcUaUnhtUoSHFPe74Rak9HUiUwcCUc0bHdZ4
    Kw2L+u2yVWwfWzn6H/bTKK6MPEzITtvxXWSQnRwnRFZ7qlA9Ln2NgDDsjZdg2zhB
    SArw8RkBlBa+PzrnTGj4+nAQj07RnxRTw8n3HSgWm1HxZvweARfGuNAJmwBb85At
    RlIAfrCDq/a2fjRI0HSWbJVc9/ZeFvg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=namei.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=namei.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEdmBz1/kSZhYFC+ab2joZPne6m3rNBIt1IM+63a9T0CG5GjGu8G4Fu9wdsp2Agrhqhbbdwy2zLO7zQgzUxgjiDwxxvbbtfJaOzgk29PyRwaFO6yIqmk
    kN37OVsi/sR3an9VGJ4HZtBREvlpw89xdJ/Ni0sMANTQKfa3iciYdU6UKH0/sMgBxzoQ/hhdBnf+KK9oMQJzNQ4PUrYUdpaxtjF0fkUNAjZqaYL/gtn1iIAX
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=K6HrmWtEAAAA:8 a=VwQbUJbxAAAA:8 a=dd6OhZ_i_D-i0Ki8aCgA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=yV38gEssg_2GhkhKF82i:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753322AbeDCVtI (ORCPT <rfc822;linux@kroah.com>);
        Tue, 3 Apr 2018 17:49:08 -0400
Received: from namei.org ([65.99.196.166]:55160 "EHLO namei.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752813AbeDCVtH (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 3 Apr 2018 17:49:07 -0400
Date: Wed, 4 Apr 2018 07:48:53 +1000 (AEST)
From: James Morris <jmorris@namei.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
cc: David Howells <dhowells@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        linux-efi@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jforbes@redhat.com, linux-man@vger.kernel.org,
        joeyli <jlee@suse.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
Subject: Re: [GIT PULL] Kernel lockdown for secure boot
In-Reply-To: <CAKv+Gu9Na0j=T4syinQhPNZTnbhvnpDXR+Za73EmH3FFXV6KHA@mail.gmail.com>
Message-ID: <alpine.LRH.2.21.1804040748450.31856@namei.org>
References: <4136.1522452584@warthog.procyon.org.uk> <alpine.LRH.2.21.1803311145180.7769@namei.org> <17792.1522491600@warthog.procyon.org.uk> <CAKv+Gu9Na0j=T4syinQhPNZTnbhvnpDXR+Za73EmH3FFXV6KHA@mail.gmail.com>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 3 Apr 2018, Ard Biesheuvel wrote:

>  [snip]

Thanks for the input -- there are obviously still issues to be resolved.

I'll now not be pushing these to Linus for v4.17.


-- 
James Morris
<jmorris@namei.org>

