Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4107594-1524173110-2-14595747918110366133
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524173110; b=T/X4NLrS+2HzH6Z3ogsA4b9AQWucEjV/u3kZBeocoK3Lrh12c8
    swAIW0j1J/ifDCq+zfyiA9sv4bF6PnbT0GaCnowq39tofB/CH3/LH4YZU7Vi3BTM
    2lmxNfojqrL2X5Bzo1o8+N4mexgLNk4ikdhsOJAH2bazLSW0he1vMbr/eh5EwLXB
    8aMDipPLWMuUHIcOUtTlatr6Xl2w18deo27/GI6oD1ALwGtPo2aG/OsiraB3dStF
    Fzli75rIM65z/UGzkibiurat8hnUdUmy+5XCLUZVWvqFp+tWKlJtakvdUa4egsgg
    qLO2wd203+NNghx3+9Zu5GUuIE/DRFovu8mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1524173110;
    bh=ZtB6Xa1SSKfcPk2dWUU9nU4y+JxAzZ/q/xZrsQxD24o=; b=bNaJsYYxfmIz
    PpiAMceg42nrrotPLwtK+FURem4TCFMg0/dSlQRDJ1NHaSR9f4c+xSzBMEB450AH
    gAp4d6dFSCm3M6M8pSYjTfC0yyU9su0t/BbbzBQ9CTE6o8CEn2MPpXRpJFiWY0vK
    jxTds7ruMUGNKUZrD+uGGubQtemiG6P5eLrkSte8g/TXoEXjcU2BYXYnTuuFaOUI
    9RRAn3nEYUiLQAGAAMLFSA/o407hv1DbMnPIdXWRIg+6ux3O5Zo+XKppF7mGGiyp
    d5CvYWwWZHONficgTsg+qJvLGBOmabooj01akmmQ4Zj2RHCxwpsJM3+XVzlfA7ZT
    9pFxu71O8Q==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MpMIoWcG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RTKifnSR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com header.i=@google.com header.b=MpMIoWcG x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RTKifnSR;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfP9GslSavDXh+EZG2XphGUrkf02c4EbT/Ek0c0q29PRl+S0xjP2B8sVmJisv9W4tu7Rd8HwMrGW4w9pmcgHogKp0oX3Fh0pxV2o+cxGtfG4oAnGPOBP5
    wEkU40PjAFjpP32cFlLxgD354bVW6KtJU7jQvSZh9cE/CncLNAi4mDb1ThULRToNjfxjmCYvkqjQlKFUjU6Jou170yDmLhHbY6/aJF+4PQzNvkrPHjS3zGfy
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=vYsdTCIIDfDGF0UKFZwA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeDSVYz (ORCPT <rfc822;greg@kroah.com>);
        Thu, 19 Apr 2018 17:24:55 -0400
Received: from mail-wr0-f173.google.com ([209.85.128.173]:46803 "EHLO
        mail-wr0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753450AbeDSVYy (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Apr 2018 17:24:54 -0400
X-Google-Smtp-Source: AIpwx48qXQhCLzx5FgwEO9d6JKc7n8dOmVNQcGX6jlyww2btHHb+A3sgK7OGa5TTPXUaCHo333v7V5Nnx6R7wLvK59s=
MIME-Version: 1.0
In-Reply-To: <13d1dfff-e0dc-38a5-e2c5-87e8e1f2fb9d@gmail.com>
References: <20180416132550.d25jtdntdvpy55l3@bender.morinfr.org>
 <20180416144041.t2mt7ugzwqr56ka3@quack2.suse.cz> <9b11cfba-4bdc-8a3e-cd33-2f7e8d513bdf@gmail.com>
 <20180417121207.cs7eijrndovbplgz@quack2.suse.cz> <9cb08428-66ed-2306-d2f2-ae734863c68d@gmail.com>
 <20180419202302.vj2eu43hy77g5mv7@quack2.suse.cz> <13d1dfff-e0dc-38a5-e2c5-87e8e1f2fb9d@gmail.com>
From: Robert Kolchmeyer <rkolchmeyer@google.com>
Date: Thu, 19 Apr 2018 14:24:52 -0700
Message-ID: <CAJc0_fxN9gJ32YVtEgxB-CeByqWvJAkEaL=VBSqMsrYKq00jSQ@mail.gmail.com>
Subject: Re: kernel panics with 4.14.X versions
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Guillaume Morin <guillaume@morinfr.org>,
        stable@vger.kernel.org, decui@microsoft.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 2:16 PM, Pavlos Parissis
<pavlos.parissis@gmail.com> wrote:
> On 19/04/2018 10:23 =CE=BC=CE=BC, Jan Kara wrote:
>> On Wed 18-04-18 10:32:21, Pavlos Parissis wrote:
>>> On 17/04/2018 02:12 =CE=BC=CE=BC, Jan Kara wrote:
>>>> On Tue 17-04-18 01:31:24, Pavlos Parissis wrote:
>>>>> On 16/04/2018 04:40 =CE=BC=CE=BC, Jan Kara wrote:
>>>>
>>>> <snip>
>>>>
>>>>>> How easily can you hit this?
>>>>>
>>>>> Very easily, I only need to wait 1-2 days for a crash to occur.
>>>>
>>>> I wouldn't call that very easily but opinions may differ :). Anyway it=
's
>>>> good (at least for debugging) that it's reproducible.
>>>>
>>>
>>> Unfortunately, I can't reproduce it, so waiting 1-2 days is the only
>>> option I have.
>>
>> Good news guys, Robert has just spotted a bug which looks like what I'd
>> expect can cause your lockups / crashes. I've merged his patch to my tre=
e
>> and will push it to Linus for -rc3 so eventually it should land in
>> appropriate stable trees as well. If you are too eager to test it out, i=
t
>> is attached for you to try.
>>
>>                                                               Honza
>>
>
> Can I apply it on top of 4.14.32?
> I am on vacation for the coming 11 days, so I can only provide feedback w=
hen I am back.
>
> Thanks a lot for your support on this issue.
>
> Cheers,
> Pavlos
>

I expect that the patch will apply cleanly to 4.14.32.

-Robert
