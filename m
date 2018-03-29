Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-890949-1522329429-2-15883967444330562651
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522329429; b=YYWbAkS8GgnKjViU3cQBvhro50FoszDvU1/NCGWU3ojqh3FnXx
    GIDF6N1vUKwPh1ViXpUDQC3CiPrXqsmVLjfzVELsjkx0wrqTBnLvX00NYR15EegA
    xB4/3YkNL5pq/E81oQM/78rdRc9snzWWIpZp9HXzRv9hSJmozw2DIT2b+w2i4ByK
    7phuJtMGL2vfRwaH84+b+WA5UwYCXklsDy2+psZ5jxlq7k/QrLG1J6S367QXqtoM
    FJOWHYKtglNjTQvK0rJbB4JjYQvx+Xlck3rcuqXO6T/ZIvxgMdiVmk0ghv2rM1ni
    NPX4If0VlU6Rg0Bup2dnQ9c1m93eCOkWpTGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522329429;
    bh=OKqp465hrjz4Pv5vbYO1fdU2byMPn7jp/m7ZasRi+OA=; b=AjAlmb1Bzc2u
    +Fy+06jg1fOnnSJfWi8sQ0U8KvWZJnjP1d8QgnWHZHFyf0r8FCXKlZ/UFr1PgSqp
    CKH/Y5GDUMH0NKbOkrS+ErorVyzNTMOZdqC/zFIA7rqzrdfjkfJ2xfBP6/GaZ/h7
    3zisQVqZGNC2rD3MugGdoPT+PK9zYhpIesuKVY6A29je/PwvVf4DyACI8Ywuj8Ih
    cWehxQIvT32zxkz28wbK1+C7m+Z9AlClsk4HABt1FP/PcYHk70+5FpmMai3TxWzs
    F3W2LA6Wi78NxgZ+3OLE9OQBcgQbrUi5Y/Nja/9ZYoaWiBhTTCBMMpC86cwQED8H
    EmPUoMhi5g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kjcOa3Yg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=kjcOa3Yg;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAkUHPdc0BV7+6nFN8ZgUkm/+ghEZNUjQnYYh+Y2aeNHy00cfnDBTBSX7mnwcD2BvSCBJFlpsuIJFDYPoDcA5VX3RSK5p5Aejnjuzj8uynHb0e0ehSn+
    EWnWbSfjkNw242i4W/mHnifM0UhOMGF0wSk9bXMm+4sxuG8BgsEOK3bxE8u5NbHkEkoMqqtc+pRoAygzosz//x6Tq0JPM3RVN3c7DYo0BooFQfQmoIpodGjs
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=N_pEWQGzfLIwqO1MAj4A:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752543AbeC2NQy (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 09:16:54 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:40435 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752653AbeC2NQw (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 09:16:52 -0400
X-Google-Smtp-Source: AIpwx48D64ineEjTPKay2Ipp32YDlrLYqf/+RLXS2y15+sZF26x+ZjpdworiD4HEOhsRAc75HE3+rw==
Subject: Re: [PATCH 1/3] virt: vbox: Add vbg_req_free() helper function
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Michael Thayer <michael.thayer@oracle.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20180329112116.26488-1-hdegoede@redhat.com>
 <20180329115630.GB6734@kroah.com>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <d2f9fe54-4ae6-df3b-4af4-aeec0b11f0a4@redhat.com>
Date: Thu, 29 Mar 2018 15:16:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180329115630.GB6734@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 29-03-18 13:56, Greg Kroah-Hartman wrote:
> On Thu, Mar 29, 2018 at 01:21:14PM +0200, Hans de Goede wrote:
>> +void vbg_req_free(void *req, size_t len)
>> +{
>> +	if (!req)
>> +		return;
>> +
>> +	kfree(req);
>> +}
> 
> Wait, no, this isn't ok.  Don't create wrapper functions that you never
> use except as a wrapper :(
> 
> I can see someone sending me almost the indental revert patch right
> after this one gets applied...

The 2nd patch in the series changes this function to be more then
just a wrapper around kfree. As mentioned in the commit message
this is a preparation patch for that 2nd patch, the idea is that
by splitting out the patch replacing all the kfree() calls with
vbg_req_free() calls the 2nd patch becomes easier to review.

Regards,

Hans
