Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3787617-1522830521-2-14519461955462751683
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='ru',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522830521; b=Vviq1CdQZE+1KPRJsZOSs21d6TnZB7a4X2KqCb6wuT+9sg15Ot
    1VWGvtFy6RjrWTLxijES0+fguEI8QwfxRy6KVqANKbQu3urGsTN/c9hf09iuMZ5T
    63IlwEheXeCybqaV/UZG5TNm02pL2kRm9Fqv+GE9AaQVyx6oSwKNJ3ZB/en+p4dr
    YHzbCha8YH4mPEvRl13j4Vs4gi/cE4eZTCIzCzGfEQOS2IBMXTXyrvSayEYChm1L
    +lRRCB+vjkuivnxMXXPfDnFhHJM1hg+5B24CSjgZDshgy4RCmI/LF2KqeO++5zin
    lTE8ltnbH4DvVyxzt+x5WaqCaHUGeYB/2WRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522830521;
    bh=aS2w3kZ4TXswR5j9kuNClEEk0feBA9TqiviPLdtPZA0=; b=rHApR8ZE9lDl
    GFo6vJgGbPju9KhNlM12EnnVJ5bWBldQvvaXwlFiRaZZ88mxIjaF9ITJnLcZxJw+
    bAlSk3LeIaZvBlhezs2I6haWQY38DmLPEw307HMQeWZ6JPlXKu6UPZN5T717mgX4
    TBnBI86pOKSKTs/+Jd2Zv8vMb0F8fUO3Ry+ZgB5sEon2IdgZVGlAEIs4cw6eEJcd
    ejs+l4gSUPNmvkPW2DRkQ/9ijsDtdqWkWmy+Zv4dI+4fO0B3tZEh9Jv4gSHcrl5x
    Ns1EG7Jkx/sPXngsTZOKrG0XnSxBqZrfvCa/F+i9MPYPRgCs1Lf8tgDx7EBmsHlA
    zxWDUIsR2Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=NO30PeCC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim-adsp=unknown (ADSP policy from yandex-team.ru);
    dkim=fail (body has been altered, 1024-bit rsa key sha256) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=NO30PeCC x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=yandex-team.ru;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=yandex-team.ru header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHMXkWeVSw1reRQCBCoZ/34KaeoKO6pTMijjjDJ5toNaI6JHH5FDUWkgH07sHxiphBNYdpkG+5S2vAnRPfDoFFlBpLtJ/o/0zV0KQ9PtdHQFYVL6PzLi
    JFWcKSCu2ECHIDGGSF78DzrdUGb2l+eegm9NEAUzeF+5j2Baa/ZZw+hpZAiyXwYtslmXuQ//MTChes9EQEgtxkugSCH74QQeTzqV6N8fTSKqFDhKEHyjwGvW
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=ycfoZbH95-1PLewt86gA:9
    a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751350AbeDDI2i (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 04:28:38 -0400
Received: from forwardcorp1g.cmail.yandex.net ([87.250.241.190]:43441 "EHLO
        forwardcorp1g.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751314AbeDDI2h (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 4 Apr 2018 04:28:37 -0400
Authentication-Results: smtpcorp1p.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Subject: Re: [RESEND PATCH V4] pidns: introduce syscall translate_pid
To: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, serge.hallyn@ubuntu.com, oleg@redhat.com,
        luto@amacapital.net, jannh@google.com, prakash.sangappa@oracle.com
References: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
 <678f275b-8d78-9b0f-177f-5ff5c9c55657@oracle.com>
 <20180403145248.fb4cd8c5ccd270ca77fd18f3@linux-foundation.org>
 <6a117d9a-f005-e1ae-5632-25e5c61dcb8f@oracle.com>
From: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <0f0a03df-9171-fc29-194b-77d1792b5698@yandex-team.ru>
Date: Wed, 4 Apr 2018 11:28:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6a117d9a-f005-e1ae-5632-25e5c61dcb8f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04.04.2018 00:51, Nagarathnam Muthusamy wrote:
> 
> 
> On 04/03/2018 02:52 PM, Andrew Morton wrote:
>> On Tue, 3 Apr 2018 14:45:28 -0700 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> wrote:
>>
>>>> This changelog doesn't explain what the value is to our users.  I
>>>> assume it is a performance optimization because "backward translation
>>>> requires scanning all tasks"?  If so, please show us real-world
>>>> examples of the performance benefit from this patch, and please go to
>>>> great lengths to explain to us why this optimisation is needed by our
>>>> users.
>>> One of the usecase by Oracle database involves multiple levels of
>>> nested pid namespaces and we require pid translation between the
>>> levels. Discussions on the particular usecase, why any of the existing
>>> methods was not usable happened in the following thread.
>>>
>>> https://patchwork.kernel.org/patch/10276785/
>>>
>>> At the end, it was agreed that this patch along with flocks will solve the
>>> issue.
>> Nobody who reads this patch's changelog will know any of this.  Please
>> let's get all this information into the proper place.
> Sure! Will resend the patch with updated change log.

I have v5 version of this proposal in work.

I've redesigned interface to be more convenient for cases where
strict race-protection isn't required and pid-ns could be referenced pid.

It has 5 arguments rather than 3 because types of references are
defined explicitly rather than magic like -1, >0, <0.
This more verbose but protects against errors like passing -1 from
failed previous syscall as argument.

kind of
translate_pid(pid, TRANSLATE_PID_FD_PIDNS, ns_fd, TRANSLATE_PID_CURRENT_PIDNS, 0)

I'll send it today with including more detailed motivation for patch.
