Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4066542-1522709478-2-9627716774753895461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='ie',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522709477; b=Yngvtjd4jtWhjQm3YAtJ/ZHRvX2hIcMJvOz8DRwUkeR+QV1+Oz
    ednlhHXIDq8EmsQ+uJcTjTb35a5eVc0/D4y3CxWVP2aV1TlFI0USLgRSbOPXamji
    gf6nxzpGi8gvUHfgukcN1oD2BBnLbF1lFtZI0rczqZQ7gitP7zXlKSWZOF5ue8zC
    8c9hUoZWRAoc+GH662FyI3vgMaZGqlin9jwKvUvtcy6XtvT60lZqEm4ucy1HqrAS
    QbkINgEW0vHdGiYWGdMyMny/qXrO6wxeUf5OZ8+9FftWb+0FoogMc7jjXzrhzJsY
    U+Lt/qHv/hYmotRXJoPT0Aq/8vQysSEOXGkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522709477;
    bh=euZqFX4nYthcut/Ma7Y4MgY2eldmYe8dasJRyom0fhg=; b=JLKBy2qwC+u+
    o17zEW31ygqXlbfBo/a2faR0xnqvYlwxIX0tE2cjJgPXWNHIzkMLYCBY+CMhuSoi
    RtA44WIm9Y7lNYw2xZrZUxBUubeEEXrA5iMhgff5SAcIrbVdRMuJJpYmV0on7vuM
    xB3mwm4ODgll5L+yyMUEJGe+mMEsIDVhjxyfuGctXMuWquBDXU56WqpRu9/eYHe/
    Thibi4bnzfc/l+XJbYgP+nqj9tgQGJuoGVPDNdhTjY2zeZvuTuiA6fK8zX32l3Gy
    fpDCMsdcp77hgApieY/o0Bk4ZYId/Xmra3/ND5ASov/JeYNNf0paMOuom+Ldkua2
    JvVqWCNbrw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=qeRpO8fh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i4NWe7/O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nexus-software-ie.20150623.gappssmtp.com header.i=@nexus-software-ie.20150623.gappssmtp.com header.b=qeRpO8fh x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nexus-software.ie;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=i4NWe7/O;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=nexus-software.ie header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA4YmCJIXFTGDlYgiOV6BMVqu6JNEnjIrrocdLZzI9Ts/fR4q7iIkPnxjGfW221Gb0iMnkmOKkAfkd0oAgWdzaqY4NiBGbNdlfilP4+v03fjhvQlDabM
    3hCYw6/dzVtLDFIZ8DHOoSvaFkbnF9iwZttkvuwkVObaszOTD//No0z904UHqfMe7sl39K7N144oDrZsiA0QNbiADl+WXlecCsqC7rO16bbza3SyU4c5+Ar/
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=Ty-_ro0gXYs8xNYQc_sA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbeDBWvP (ORCPT <rfc822;greg@kroah.com>);
        Mon, 2 Apr 2018 18:51:15 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:54443 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754661AbeDBWvN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 2 Apr 2018 18:51:13 -0400
X-Google-Smtp-Source: AIpwx4/r4D2/+AjZsPvgzer0HFU5m1k7cSfCQpLnh9RVx3dkK3yEPmBwW/r+/JiNdWB+xjH1bk161A==
Subject: Re: [RESEND] rtc: snvs: Fix usage of snvs_rtc_enable
To: Trent Piepho <tpiepho@impinj.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@free-electrons.com"
        <alexandre.belloni@free-electrons.com>
Cc: "shawn.guo@linaro.org" <shawn.guo@linaro.org>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "bianpan2016@163.com" <bianpan2016@163.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "guy.shapiro@mobi-wize.com" <guy.shapiro@mobi-wize.com>,
        "Frank.Li@freescale.com" <Frank.Li@freescale.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
References: <1522264445-2398-1-git-send-email-pure.logic@nexus-software.ie>
 <1522282337.10662.268.camel@impinj.com>
 <f380bc29-c8dd-5c20-efc4-ffc0ad69b8d6@nexus-software.ie>
 <1522450739.10662.278.camel@impinj.com>
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Message-ID: <4f9434c7-6977-caef-2fac-5da79364304b@nexus-software.ie>
Date: Mon, 2 Apr 2018 23:51:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <1522450739.10662.278.camel@impinj.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 30/03/18 23:59, Trent Piepho wrote:
> However, I think that even if the driver fails to probe if there is a
> timeout at probe time, it's still possible to hang later if there are
> not limits to the hardware polling loops, such as the ones I added.

I agree with your patch in principle for this the reason you've outlined.

My patch though should still be applied to fix non-starting @ source.

/aside - I don't have your patch in my inbox - if you could resend and 
cc me I'll review it for you.

---
bod
