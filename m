Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2479957-1525768821-2-8229620046973499566
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525768820; b=ZyyjiZK2ydxKpxiZP6qppkBkD+WyB2i2BhIztr+mNhgp7CmI33
    GLLMmcSLIsHlSkQdS//kLbLyn4Xm3cyPsRSW4h6OKgxKzVJUh8sQ1HWo4nrun6aW
    3rqIKw69jYYi1S89ab1YcreA4m15/aaB+NGP8z3dLs7Ye6Htf6lu3MIXYn7wADMH
    3At8t6v2B7utkZuDvMY9OX55YBOBS27/asywJGHKfgWZ0IYIT5j4wE7TxYJe4py/
    FDgu0O2ZdEfq9TavPbFCSoX7sGoSKxy1V502rHqFamhaIirpNo8N2Bmu/xg/8U2C
    vqWLSgj23N2/VBhA6IyB6UjCifHA/1ne6+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525768820;
    bh=Va6P2NleY21mcglELCv+CGPyF7PBgWpcVV9TS4LNQG4=; b=TX5U0pZATVoL
    nlXOuuOaFd5NaEacL1ydsDQWVE3cg7JTuSvJw6S7Teto9mOIhkpf2RFRDwJ5l+Zf
    hj8DoSPPGlvYTFeOLyYC8aMoIvg9bsJgQbL77ouSrUUwrnr33jMh8Kd2PRlM4+48
    h7vORq8HzXcz2QT0tL11xK43O118hP9h1gv1l53EmOsL00Jd0lw4/swGOjN7dwbb
    Pj8gCUimVoovCU5WdupYJ8SrG8msFh3EkgCAZaNS4o4znE4wAA14N5U70P0vlcim
    KJtn+mloF0b4LR16dObezHXQukuIdNg5wnK29KCXIQLK/Jm9OqMgWmOLWfv9XTDF
    PLAMz0zheg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=OAcKYoZR x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=tqeNC7Lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=OAcKYoZR x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=tqeNC7Lj;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP+KJJZQm1ydOYJGiPDDWy0kLh5wb2l+gi1RCZIez/e8adrhg+Cd8SGwru+heFK1p2o+V26CeLaENXkww3/y1SFyP01bMEs5ZCs+cneFJBBfzhi+MrQ9
    gZRUw+GYKhRXhyhk7Fcm3bwOhudYv2t2Ok3iUCn8+IfQS25Klbk7C1YqqDI8bR/NceYS6LnCiW4TQ6GKgVxMrc4qjUvGC2+j98rnmw7cAzU9aHNdzbcEiwaO
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=tmjX-nCzVX8A:10 a=xqWC_Br6kY4A:10 a=4_-BN3WEXhEA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=v9_5yHEMgVOQguqFc64A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933239AbeEHIkB (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 04:40:01 -0400
Received: from mail-pl0-f48.google.com ([209.85.160.48]:39720 "EHLO
        mail-pl0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932540AbeEHIj7 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 8 May 2018 04:39:59 -0400
X-Google-Smtp-Source: AB8JxZqTKjKry9jJ4OWhZ2Dj+j9F3sgjE3+VvaPHluguAanakdz67iE/5qZ6vgLkUNyo/krkquVv+Q==
Subject: Re: [usb-storage] [PATCH] usb: storage: Fix a possible data race in
 uas_queuecommand_lck
To: Oliver Neukum <oneukum@suse.com>, stern@rowland.harvard.edu,
        gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-scsi@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
References: <20180508074743.13622-1-baijiaju1990@gmail.com>
 <1525768070.24345.8.camel@suse.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <37706c9a-8b12-8440-29fd-34342e47a68e@gmail.com>
Date: Tue, 8 May 2018 16:39:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1525768070.24345.8.camel@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018/5/8 16:27, Oliver Neukum wrote:
> Am Dienstag, den 08.05.2018, 15:47 +0800 schrieb Jia-Ju Bai:
>> The write operations to "cmnd->result" and "cmnd->scsi_done"
>> are protected by the lock on line 642-643, but the write operations
>> to these data on line 634-635 are not protected by the lock.
>> Thus, there may exist a data race for "cmnd->result"
>> and "cmnd->scsi_done".
> No,
>
> the write operations need no lock. The low level driver at this point
> owns the command. We cannot race with abort() for a command within
> queuecommand(). We take the lock where we take it to protect
> dev->resetting.
>
> I don't see why the scope of the lock would need to be enlarged.

Okay, thanks for your reply and explanation.


Best wishes,
Jia-Ju Bai
