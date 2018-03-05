Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2263408-1520274939-2-10660139046027482206
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.249, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520274938; b=Lwcy7bdEswG9ZSRhqrwP4YGobEM4XOFE4qfKdGtIMH1VDs7
    K8I4DpBrmsqwHZbt0ZRL7c6eeMTpeRyhUvbccAMFKTDc1ign66g5gzebO7H0xyqI
    O3l5Zngn6AR8q591NHa6Yma1Cw2bSg5bHNvY2aTGYMl4nmIlPygIGvGQfa5ol0tT
    SaaB2Lqpf9d4g9Uz96vyCbkR5Nue1iAoPn3tBGCEDKDZJteq4gkMMRnft7cVXp8i
    fkeyAAUddQjWzZ3YfCwNCbSFrlVK9zz/ddfhirvMROcLDJgQ5HIyvFYNMJmEJwdh
    ADS7OPwuC4ILWocjW4Tmgsm3js3cE6lqBfTUfWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520274938; bh=zJhO1ZZt3qQbBx8mLAEE6wA9kgQoL9sH4NFpP9z+KsQ=; b=V
    e/CRfTlv7gfz5vpdx+yy1Dlxs4EBTl6H2BXenUPwwPzEKIdxiGV+RwH2COj0bRa4
    MEtgl70Cf/SSOqyCzfSF64pGtsJxRRXXkl/X4UuIx0+kmudTO6qSlBVjQso9oj6E
    M6r025ZS+rSvVE7zPi2p8VhFd4L1hAXZD6Opbzahn348URdHE70HAr3N5lMcnuxq
    JqoIwqvePYdI84sOZFC5Ow7jz9DxrAaGxC3UGYpbBsQ5dqkarTZo2lq0BqpbHX7j
    LQqSviHbnxuncuRqTvoDa85qUR6YMx7g9L5MHuHa+dCHPZS1y1QBQ+TLD261uEi+
    QGyfWcTOV6rayBjxEsWfg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TXtzEDly x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Cc4+WbBR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=TXtzEDly x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Cc4+WbBR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeCESfV (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 13:35:21 -0500
Received: from mail-wr0-f173.google.com ([209.85.128.173]:41336 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeCESfU (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 13:35:20 -0500
X-Google-Smtp-Source: AG47ELshxb3sUPRAvMuf2JcpW6DJ2vb+xDMfbSMZ+gHsvl93tkTu0GG1WwzI+RFoIAIL0oB8zX1TAw==
Subject: Re: [PATCH v2 1/1] usb: musb: call pm_runtime_{get,put}_sync before
 reading vbus registers
To: Bin Liu <b-liu@ti.com>, Tony Lindgren <tony@atomide.com>
References: <20180227222740.2150-1-merlijn@wizzup.org>
 <20180227222740.2150-2-merlijn@wizzup.org>
 <20180228215943.GI5448@atomide.com> <20180305173802.GB14921@uda0271908>
Cc: Merlijn Wajer <merlijn@wizzup.org>, linux-omap@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <6583654d-5250-a8a9-42e7-6b9990cd538c@gmail.com>
Date: Mon, 5 Mar 2018 20:35:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305173802.GB14921@uda0271908>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On  5.03.2018 19:38, Bin Liu wrote:
> On Wed, Feb 28, 2018 at 01:59:43PM -0800, Tony Lindgren wrote:
>> * Merlijn Wajer <merlijn@wizzup.org> [180227 22:29]:
>>> Without pm_runtime_{get,put}_sync calls in place, reading
>>> vbus status via /sys causes the following error:
>>>
>>> Unhandled fault: external abort on non-linefetch (0x1028) at 0xfa0ab060
>>> pgd = b333e822
>>> [fa0ab060] *pgd=48011452(bad)
>>>
>>> [<c05261b0>] (musb_default_readb) from [<c0525bd0>] (musb_vbus_show+0x58/0xe4)
>>> [<c0525bd0>] (musb_vbus_show) from [<c04c0148>] (dev_attr_show+0x20/0x44)
>>> [<c04c0148>] (dev_attr_show) from [<c0259f74>] (sysfs_kf_seq_show+0x80/0xdc)
>>> [<c0259f74>] (sysfs_kf_seq_show) from [<c0210bac>] (seq_read+0x250/0x448)
>>> [<c0210bac>] (seq_read) from [<c01edb40>] (__vfs_read+0x1c/0x118)
>>> [<c01edb40>] (__vfs_read) from [<c01edccc>] (vfs_read+0x90/0x144)
>>> [<c01edccc>] (vfs_read) from [<c01ee1d0>] (SyS_read+0x3c/0x74)
>>> [<c01ee1d0>] (SyS_read) from [<c0106fe0>] (ret_fast_syscall+0x0/0x54)
>>>
>>> Solution was suggested by Tony Lindgren <tony@atomide.com>.
>>>
>>> Signed-off-by: Merlijn Wajer <merlijn@wizzup.org>
>>
>> Thanks for fixing this. Assuming it passes Bin's tests:
>>
>> Acked-by: Tony Lindgren <tony@atomide.com>
> 
> Applied and sent out. Thanks.
> 

What about stable kernels? Shouldn't this be fixed there as well?

Ivo
