Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3753091-1519158630-2-5057481807421083138
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519158630; b=GbE/LeMdMx0BLL0CTMRDbfyuXMH9E98mGlr2gu6bk/+e+w+
    LFyr6HDr8xgqJSa+uEN2/W1u+fE9vdkXYzCMSRAHQJfNfrlRzU5MsOTVELz1Asjy
    rFhaM6BayekFPH1AUhmNndzFKA/UlvvlXhrFzi/IL6u0uU6O0PMpLqqBVYKyh+sZ
    dY9pl4t+aCsjkUT7E1Itd1O0/cJpr+/D4N4ZoRN234znX2y5sw+ufbWJj7kKXf47
    /CnWzu78H9fML7bXpOoCaNEUNKNGj6QoCCLBWCEaxZX51gAsIH7ctJATJPkzVZLY
    yziqIxp7iHEtmvjxXKnu7EuaiRQblDgHnvsIihQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1519158630; bh=EyMsZDOvzQp3mbmBjnG8A6s7SKas80PJmkS4No
    gAGPU=; b=BgGPWAGHyG2M+f4iU7oVmKzv99IdqDaj7F+hgaIIdVgkkFsUrqMFzM
    bEh+3zApAsy+RH3yATpEq9uKmU2PAOZwT/PatONKUdfFmJDUFDXG2VeG9AA9I1Yr
    G4obu1OCRPrfzjjqOk0h46iNuWiGa2L3l3uZ06BG3eWrqrnM8mFPBPyebm4hw3QQ
    pFLV4Y3AiHVAf7HHhhIOOWg6BX4ThbaFCKzCpsc804iDiBEmPOsX6x7VVFiDIy9B
    nHHpUbs1OZTI767MeHFnDIHJfpwfNQbdTmaNlpbbxGrcACENh/h6x1yVLho/jFAJ
    zhpgz/D+19lwzRFKH7NSOzngZX9BnYBQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZKLHIljT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGlO+NDU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=ZKLHIljT x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=GGlO+NDU;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeBTUa1 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 15:30:27 -0500
Received: from mail-yw0-f179.google.com ([209.85.161.179]:44280 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750985AbeBTUa0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Feb 2018 15:30:26 -0500
X-Google-Smtp-Source: AH8x224tRY19xqxu3yefW0oEcZLFL7NutIbL2q5Q/jipQOk9qjPdSqwUalERk7w8c/ddgLSIU6WK2CIwau57QtXHRJ0=
MIME-Version: 1.0
In-Reply-To: <20180220124354.6awua447q55lfduf@quack2.suse.cz>
References: <CALvZod5H4eL=YtZ3zkGG3p8gD+3=qnC3siUw1zpKL+128KufAA@mail.gmail.com>
 <CAOQ4uxgJqn0CJaf=LMH-iv2g1MJZwPM97K6iCtzrcY3eoN6KjA@mail.gmail.com>
 <CAOQ4uxjgKUFJ_uhyrQdcTs1FzcN6JrR_JpPc9QBrGJEU+cf65w@mail.gmail.com>
 <CALvZod45r7oW=HWH7KJyvFhJWB=6+Si54JK7E0Mx_2gLTZd1Pg@mail.gmail.com>
 <CAOQ4uxghwNg9Ni23EQA-971-qAaTNceSZS2MSvK06uEjoXG_yg@mail.gmail.com>
 <CALvZod7FTNzoGfGnaorqjk4KEsxJFdz1pApHi04P1cF10ejxpQ@mail.gmail.com>
 <CALvZod4SNwWHYZQsphB90cY-wc8WSLurKsA2kNxfVKV-upwy9A@mail.gmail.com>
 <CAOQ4uxifddquri4BNqBSKv6O_b13=C08kKYinTo9+m56z1n+aQ@mail.gmail.com>
 <20180219135027.fd6doess7satenxk@quack2.suse.cz> <CAOQ4uxjkfTTJ7nxrtj8ZsKcsWfBz=J0RPv3N=u3JaskRgG9aWw@mail.gmail.com>
 <20180220124354.6awua447q55lfduf@quack2.suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 20 Feb 2018 22:30:25 +0200
Message-ID: <CAOQ4uxjAaRXPEwbqEMqL9Jr4-JhAscYcFtc01EMQbm5yEafq2Q@mail.gmail.com>
Subject: Re: [PATCH v2] fs: fsnotify: account fsnotify metadata to kmemcg
To: Jan Kara <jack@suse.cz>
Cc: Shakeel Butt <shakeelb@google.com>,
        Yang Shi <yang.s@alibaba-inc.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 2:43 PM, Jan Kara <jack@suse.cz> wrote:
> On Mon 19-02-18 21:07:28, Amir Goldstein wrote:
[...]
>>
>> I just feel sorry about passing an opportunity to improve functionality.
>> The fact that fanotify does not have a way for defining the events queue
>> size is a deficiency IMO, one which I had to work around in the past.
>> I find that assigning group to memgc and configure memcg to desired
>> memory limit and getting Q_OVERFLOW on failure to allocate event
>> is going to be a proper way of addressing this deficiency.
>
> So if you don't pass FAN_Q_UNLIMITED, you will get queue with a fixed size
> and will get Q_OVERFLOW if that is exceeded. So is your concern that you'd
> like some other fixed limit? Larger one or smaller one and for what
> reason?
>

My use case was that with the default queue size, I would get Q_OVERFLOW
on bursty fs workloads, but using  FAN_Q_UNLIMITED and allowing to
consume entire system memory with events was not a desired alternative.
The actual queue size was not important, only allowing admin to tune the
system to bursty workloads without overflowing the event queue.

Something like FAN_Q_BESTEFFORT (i.e. Q_OVERFLOW on ENOMEM)
+ allowing to restrict event allocation to memcg, would allow admin to tune
the system to bursty workloads.

>> But if you don't think we should bind these 2 things together,
>> I'll let Shakeel decide if he want to pursue the Q_OVERFLOW change
>> or not.
>
> So if there is still some uncovered use case for finer tuning of event
> queue length than setting or not setting FAN_Q_UNLIMITED (+ possibly
> putting the task to memcg to limit memory usage), we can talk about how to
> address that but at this point I don't see a strong reason to bind this to
> whether / how events are accounted to memcg...

Agreed.

>
> And we still need to make sure we properly do ENOMEM -> Q_OVERFLOW
> translation and use GFP_NOFAIL for FAN_Q_UNLIMITED groups before merging

Good. it wasn't clear to me from your summary if were going to require
ENOEM -> Q_OVERFLOW before merging this work. If you put it this way,
I think it makes sense to let user to choose between GFP_NOFAIL and
Q_OVERFLOW behavior when queue is not limited, for example by using new
fanotify_init flag FAN_Q_BESTEFFORT (or better name), but I have no problem
with postponing that for later.

Thanks,
Amir.
