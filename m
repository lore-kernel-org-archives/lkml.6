Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-788869-1524470871-2-8436062469061101291
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524470871; b=UBvH+b1E/CP1PS1BsV8s1UMVTxFHuC+5hkyJxyOs/h3scscVny
    ldVgqi0tbRB57c7AESxvTpx1QCraz71BiKjiNoJl0vd6/m3E365dh8YaXwp+Pdu5
    vCwpTvE0KfPzMNFDvbWgxZz+WVFkUgFIMPTRIyARTbOYpOcReENt7qmrN6EXCv/z
    W5ab31k7IP4vnDi0fOgQ7qIlVbIw24/gMTaBuqon/oUumEWq7max9bzSlgP9TjIX
    MYsg0RQlvTTz1W0emPxsUpwk0BPvhJ+pBEP5xgm+ReYqroN/nDHjFJ79jXa+fno7
    y+yVS+nQc5FVNb4+PdTKjqFug4ZoqzDGoTAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524470871; bh=TSUmP
    btFQGjmAZaBC6zQwjQoQUyzMIOYoUoGMRbHm64=; b=Lj++2dKseIyzIyQ2Osg7K
    dtDpDoNCpTq68AoBran8ypsGEmmmqzswPnxBhOXd64UyrmrzBMiLMy6x7ERgsrVZ
    1QmJNJGfQnFgqgdvBVuWBa9IjwUMi9lTDacXdVQw4ZvCJReCqv9dbXKeXr1lUNLS
    +rgcgwQoyK73vpV45IF3XId3djOYkigSCeaBZH2rRqKTECaJZdxw8DWQj6cwBLBD
    ebD2dbVYQq6lZeaoHND7Ev/5GLD3K/ha8LJrtkrS31nSawF0MoaZmY16u4cb8v8A
    IiPf/CEUY03FnN40miI1lB8JqiqnGwv5d7IASsz/LzGaFi6nzcdnjIjWt6eLRJk1
    w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ZcBpWSBG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KihlE0nB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=android.com header.i=@android.com header.b=ZcBpWSBG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=android.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=KihlE0nB;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=android.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNjw4HsUttDZ67Fb9/WvUTo97I3uwjxylL28QP6qU+DQyTJzGVhzs7prQeNJJDL9rtASGgFaIlwP3I/4QcqCw1RqJO7Bva9X6GF4Nu2TkGLjOL/Jyx9Y
    NCKN6AV/TEKHgKGZ2wUSr4uiayduj9r0jDHU8W17aesIChVQRXpFcZP6z2GG5NtsMJBtTfZy2xRdtIGiyyI0F8EpwB6VLlXZztBEtxvWpa4I+Eeus726Sekx
    XZTf1pH2QLUDimdlHe9sfA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=n8i27M1mAAAA:8 a=ag1SF4gXAAAA:8
    a=DDOyTI_5AAAA:8 a=tnu1l-Ar2z2_v8HrBiQA:9 a=CjuIK1q_8ugA:10
    a=Yupwre4RP9_Eg_Bd0iYG:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AB8JxZqHL8FqkwsVbrYA2tW3a0OMmFsyfrOPh3WLUYe0ozw091Irdpu/QwAxJpRxcQmY364LKJ3mQJOKxW7DHZyREnQ=
MIME-Version: 1.0
In-Reply-To: <CAB0TPYHAMmbW8Nfqxr94MyB_dR3zeE+5JtSGAadkaNaMyrD46Q@mail.gmail.com>
References: <20180328091450.85073-1-maco@android.com>
 <20180328112838.GA26219@kroah.com>
 <CAB0TPYHAMmbW8Nfqxr94MyB_dR3zeE+5JtSGAadkaNaMyrD46Q@mail.gmail.com>
From: Martijn Coenen <maco@android.com>
Date: Mon, 23 Apr 2018 10:07:43 +0200
Message-ID: <CAB0TPYEt2Hp+dsFU6g3aAkS8AxvAb9cz3wOZ9+ZJqwAiqX5wnw@mail.gmail.com>
Subject: Re: [PATCH v2] ANDROID: binder: prevent transactions into own process.
To: Greg KH <gregkh@linuxfoundation.org>
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: Amit Pundir <amit.pundir@linaro.org>,
 "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
 LKML <linux-kernel@vger.kernel.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
 Martijn Coenen <maco@google.com>, John Stultz <john.stultz@linaro.org>,
 Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 1:34 PM, Martijn Coenen <maco@android.com> wrote:
> On Wed, Mar 28, 2018 at 1:28 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> What is different from "v2" you sent before this?  No change information
>> from v1?

Greg, is this in your queue, or should I just send a v3 to clean this
up? See below for my original reply.

Thanks,
Martijn

>
> Sorry I messed this up - the first resend did not have "v2" in the
> subject but did contain v2 change information, the second resend had
> the v2 subject and did not contain the change information :( Either of
> the last two patches is fine - it just used "target_proc" instead of
> "target_node->proc".
>
>>
>> I'm totally confused as to which is the "latest" patch here :(
>>
>> thanks,
>>
>> greg k-h-
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
