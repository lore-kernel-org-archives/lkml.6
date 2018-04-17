Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2662433-1523997455-2-5002018266273408831
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523997455; b=KKo3YVIK61S/mwK5WZ2HLzmlwJdcH3gf137AgFuCPdJ3hWxYFo
    1enUc6QnHgvrroL21YR9QL4pSYeVdS/3K6wBdUw0awJ471nYE8PqvW4HrC5RiMZN
    uYQz1mCWpWuEMtzc/T7oUb8t9B6FsunZ43bgu6uA8Kz/cnwZ351hrhZhQY7jaeEH
    haXX8NfRztz0XWURYwYpZxn0J8HxWcEkxyAw6/pxUssJAjSsVo6Jxqhv+kSg31QE
    w2W0Pepm4EfehXal9g4cybNoTOYhVrI4CgztWuCF1nS991S1DCI43LPAECG4Kbgp
    OS4oEUPCkuSDICCB5dWcSvrFYm4PJFeMI7oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1523997455; bh=DSNW4fa1Tr7ekhPeoFTL43WdoJfbGDglBJPlapgQzl
    4=; b=YImXGXJf3FKFiOwwXJgvUIHYDKzdmd6Jd9GDf1l1S2IlPKqzKjMmBENuXH
    93g5KLgMsEVxMqcEMADYDLyavVvntTppGbh7O5WSuUVRodlGPTdOvIivym7O0iov
    yrsibIyI3UvtUuKR73MHwuGqdVHF/dUE7oBBoCOa5FyDO3t8OIVAYQf3UoXzjxvB
    cjAsjM/wFSgscnXv/Sf+HjEmBHSN6vKsnZY1c+3Bo4w2/elYOdM6ehrCdNkbpDk8
    r+TO0rMShjzxKPzTCWjget8wS6bWA1Jsyg5LlkvMYsJZvXutYBIyQsznr/2yl5jO
    q3wE8k6kDZ3YtGa4lcVSwA33b0tQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Q6YMTZlJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UprVuIwH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=Q6YMTZlJ x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=UprVuIwH;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEVVc0ZrrnnnfJRYFhdCkj3or/hokGCz07ssTKOGO8amELTTMAC3+3O4sSnnASeDU9PT7xUVIx5/Jd8VpTmK9bhDL+PgNlbEyulsuRZip82ICT/Mukgh
    Ntvg28S5WNhrFAx8/cAX0bH0jT2HiQcxGZGuMbOfOEQ/Aca5LLhu2v4FqOED63f54c1GA0VcKTNT73zAzB3q0jCZnUxShjJXphPo4fqKf4pl5UpAq8vUyz8K
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=W_uslV63yMIA:10 a=Kd1tUaAdevIA:10 a=hGzw-44bAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=CbDCq_QkAAAA:8 a=86RP8W1o9Cg_u5Kl52AA:9 a=QEXdDO2ut3YA:10
    a=HvKuF1_PTVFglORKqfwH:22 a=AjGcO6oz07-iQ99wixmX:22 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQUhc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 16:37:32 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:46566 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752254AbeDQUhb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 16:37:31 -0400
X-Google-Smtp-Source: AIpwx4/MYCMsm8D7voFdAOeqxCjjYvJ1/5f2Box9MUY4dFhsZhqjlMjG++bSGJE2kGa0gEKhRLwdh6GVTMWlnjmCGEY=
MIME-Version: 1.0
In-Reply-To: <MWHPR2101MB0729D25984E4C57E79355794CEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180417191710.14855-1-longli@linuxonhyperv.com>
 <20180417191710.14855-2-longli@linuxonhyperv.com> <VI1PR0502MB30080A26FFC2A6132397C549D1B70@VI1PR0502MB3008.eurprd05.prod.outlook.com>
 <MWHPR2101MB0729D25984E4C57E79355794CEB70@MWHPR2101MB0729.namprd21.prod.outlook.com>
From: Steve French <smfrench@gmail.com>
Date: Tue, 17 Apr 2018 15:37:10 -0500
Message-ID: <CAH2r5muTc79_PLn=O1ZQfzMQLQO9JkW4yvEZyp1O9qTFRWS8ig@mail.gmail.com>
Subject: Re: [Patch v2 2/6] cifs: Allocate validate negotiation request
 through kmalloc
To: Long Li <longli@microsoft.com>
Cc: Parav Pandit <parav@mellanox.com>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 3:11 PM, Long Li via samba-technical
<samba-technical@lists.samba.org> wrote:
>> Subject: RE: [Patch v2 2/6] cifs: Allocate validate negotiation request through
>> kmalloc
>>
>>
>>
>> > -----Original Message-----
>> > From: linux-rdma-owner@vger.kernel.org [mailto:linux-rdma-
>> > owner@vger.kernel.org] On Behalf Of Long Li
>> > Sent: Tuesday, April 17, 2018 2:17 PM
>> > To: Steve French <sfrench@samba.org>; linux-cifs@vger.kernel.org;
>> > samba- technical@lists.samba.org; linux-kernel@vger.kernel.org; linux-
>> > rdma@vger.kernel.org
>> > Cc: longli <longli@microsoft.com>; stable@vger.kernel.org
>> > Subject: [Patch v2 2/6] cifs: Allocate validate negotiation request
>> > through kmalloc
>> >
>> > From: Long Li <longli@microsoft.com>
>> >
>> > The data buffer allocated on the stack can't be DMA'ed, and hence
>> > can't send through RDMA via SMB Direct.
>> >
>> > Fix this by allocating the request on the heap in smb3_validate_negotiate.
>> >
>> > Fixes: ff1c038addc4f205d5f1ede449426c7d316c0eed "Check SMB3 dialects
>> > against downgrade attacks"
>> >
>>
>> Format is:
>> Fixes: ff1c038addc4 ("Check SMB3 dialects against downgrade attacks") It
>> should be right above Signed-off signature.
>
> I will fix up and resend this patch.
>
> How about the rest patches (1, 3-6) in the series? If they don't need any changes, is it okay that I resend this one only?

Doesn't matter to me either way - I already merged patch 1 in any case.

>> > Changes in v2:
>> > Removed duplicated code on freeing buffers on function exit.
>> > (Thanks to Parav Pandit <parav@mellanox.com>)



-- 
Thanks,

Steve
