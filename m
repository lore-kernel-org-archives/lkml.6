Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2496537-1522792558-2-5384512473706157773
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522792557; b=sJoKkBJcsqeHxMdpu9oSeTI5xW1E+xei2RMkXaj7I0IRNQpzvm
    Yptgyh4xkGorvK1M4drhfzKMMI2BFxIJPBbhrhS5kIB971YxDMyI/uEIwNnS6zva
    g4su7Gu6MUlwXa/REa4tGHXVX/0k0BJVZF++8Vl91pcpj39Rvn1nbsymsURXQnM7
    s4BUaXD1dHHfH3cptJWjIoAfzjIVb947THYmll56s6IF+MzMOid/CshvARSeBxQl
    g0h2U2qVY4HkWsR2YraJLiTKv7kJhBd81KexWr4RZJQKeNteo5AVx8JWxsfuvkVK
    /jywj927P7cx46ColC7p9IXCpLiu/Yn+Xj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522792557;
    bh=tNfZEGR18H23P8YeFmc0msT0sv2vHgQq6tiY2UgRFGI=; b=Ik6h/3WdCRQi
    ynjvMEpXoUArkrRe+X5IJXvoVO6+AEM+kXkJ2LX8qqxaxVNBTRh69qDs+cpj9Asu
    9sgZZu0yZXWYRG90guwG0JEVtxsq9Pu7LWPQMfFIz8UwI9y4QwpbKqKTmpnI3p+Y
    X2i9m022KHSi9FqfByF33Lcha1WNMkDBiONxlcDXsTWxll/zvkcUEdwW833vs57q
    bUy2LehFp5qIxN0vqs5ZqDQjZSHeuc9Z8h7M+6oJIoWNAfNL++6agyhM8FirKYt+
    Qj2lMWq9afGoqabc8eA8xIiywdE8jaI79TPEKArZxw21MQlvdAsQfQkaGrGrtmYY
    P2P0tOu4ww==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sz3j39D2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=sz3j39D2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFibM/LuC6JMXMpz7rP+70D458jYI4E+rb7yXIYLTCZBQWVbv1OqqOzXOz+STUrL6U+wuhcev8IsCNucoNKeoueJq9Z3t6/+wpp1ChBUssa/Sy4NT4qF
    RyJKIh8VZO9GfNcopZrmoG457N/0WeRH7HjK+YFFOHF+qYv4NytXhPCLOmLQ4IlzReUFYU8Yzhd3TA9yOy4MAv39QoDRUs6n2YERuir+mv5sKMGMSsk2VQIX
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=Zj6SbNRTkxVQd2BmteIA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753091AbeDCVzy (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 17:55:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60234 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDCVzy (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Apr 2018 17:55:54 -0400
Subject: Re: [RESEND PATCH V4] pidns: introduce syscall translate_pid
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiederm@xmission.com, khlebnikov@yandex-team.ru,
        serge.hallyn@ubuntu.com, oleg@redhat.com, luto@amacapital.net,
        jannh@google.com, prakash.sangappa@oracle.com
References: <1522706249-11578-1-git-send-email-nagarathnam.muthusamy@oracle.com>
 <20180403143838.614ecc083835d07d409a699c@linux-foundation.org>
 <678f275b-8d78-9b0f-177f-5ff5c9c55657@oracle.com>
 <20180403145248.fb4cd8c5ccd270ca77fd18f3@linux-foundation.org>
From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Message-ID: <6a117d9a-f005-e1ae-5632-25e5c61dcb8f@oracle.com>
Date: Tue, 3 Apr 2018 14:51:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180403145248.fb4cd8c5ccd270ca77fd18f3@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8852 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=561
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030211
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/03/2018 02:52 PM, Andrew Morton wrote:
> On Tue, 3 Apr 2018 14:45:28 -0700 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com> wrote:
>
>>> This changelog doesn't explain what the value is to our users.  I
>>> assume it is a performance optimization because "backward translation
>>> requires scanning all tasks"?  If so, please show us real-world
>>> examples of the performance benefit from this patch, and please go to
>>> great lengths to explain to us why this optimisation is needed by our
>>> users.
>> One of the usecase by Oracle database involves multiple levels of
>> nested pid namespaces and we require pid translation between the
>> levels. Discussions on the particular usecase, why any of the existing
>> methods was not usable happened in the following thread.
>>
>> https://patchwork.kernel.org/patch/10276785/
>>
>> At the end, it was agreed that this patch along with flocks will solve the
>> issue.
> Nobody who reads this patch's changelog will know any of this.  Please
> let's get all this information into the proper place.
Sure! Will resend the patch with updated change log.

Thanks,
Nagarathnam.
>

