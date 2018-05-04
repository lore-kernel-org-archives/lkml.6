Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3604505-1525406396-2-10078008462797565812
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='hk',
  MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525406395; b=YbrOV1njWBWTgUAvDHjn5BrJD/HqQHKaJTCXgT5A/M5FWPA0fz
    lXBPkClC//qBYFBSJ6JyMYus0l/KEKRXD/zRQ/P5dUoTEuewcmbdXQeb0tR39Z+t
    h9VeK5pjfWgPq2/IVP6QZRft4wEzp1GyytzQd/pO51k9dOGfAj2CMwPMl7O2rcpc
    e/6n63PWRy28LeIkVd2DjfNXYcic2bia7xOgo9hsSV0ld5h80bdlC55WZPIFLn7x
    SpClRAUomv1EiqmrkJFKNSTXcXiDDFVXiEUOxwHBuGpES0I0zKanS3I8GL4QlIUJ
    1dbYDF6JDzTefvxzSGYjrwE95c5HA68dwbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525406395;
    bh=6X3lC6zdcc9zlvNQppyIfmET5X7NxfcZp8eTSKIJTBI=; b=lwBWZEzf2xHD
    NKHPjXnA4Ru+mXHTI9gtECphM0eJ6pe5qHWgXk2JOCmzNkPPNA51Y5XB+ExWYx4+
    Ld6roMz8TsanUCtfht4MUb/OJLigRvn+xnETCUXkpglxNG4yOTSdOeuzbhRfQwEQ
    5vO6rvHvecOPW0lSOA0Ah9sp41SFgYUkjEJZ6AX6h22ol11wr7bzMnJKU5U/+XNh
    kfd1QcgvTXaF//uOp8Sv1y9RYXnO538DYPEsj3UfzSXo6gtt3AYWuB+3MQiY8Jqk
    3WUTgneBGOfv/fMrxe9LC5dNor5/JhQgTb36z5kCz8xlRBw6JLIL55EsEKMMudM3
    wA5+GhPnwg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gtsys.com.hk header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=gtsys.com.hk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gtsys.com.hk header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOfP1MKuNm2vKVsGkMGm+MVF13rFPM/lCahn6ELHLH42wfEzUPnObab0tfYpTIHDQlZ4cl6wCd7Ym8AUH/IceI+hXrHmZ6dj1he0gKQKSLDnuUbr2ign
    IGVB0Fx8U514LONNra9JqwhN33Er7VbzIe3gZRCl8+fHFJiMsTsXrjG2ui+xH0jX8Hk7akOfeOmBZieE30a7761gN9kGxLqKlHlb0V+ZVqy0mVUhD7iQV/RZ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=xqWC_Br6kY4A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=HF_MKpNI09jAw7FtRnoA:9 a=QEXdDO2ut3YA:10
    a=HUqATDVKn4QA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751287AbeEDD7x (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 23:59:53 -0400
Received: from sh1.xit.com.hk ([111.91.236.50]:46570 "EHLO sh1.xit.com.hk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeEDD7w (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 23:59:52 -0400
Subject: Re: [PATCH] serial: imx: enable IMX21_UCR3_RXDMUXSEL for non-dte-mode
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1524186479-25315-1-git-send-email-chris.ruehl@gtsys.com.hk>
 <20180420061316.sakoupltqxn2qhfr@pengutronix.de>
 <ca240b4a-aa42-b747-9bab-49b18290ca49@gtsys.com.hk>
 <20180503201317.GA19401@kroah.com>
From: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <162654a7-5add-2ea4-b947-783189535091@gtsys.com.hk>
Date: Fri, 4 May 2018 11:59:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180503201317.GA19401@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>>
>> The IMX serial driver is broken in the 4.9.x tree since 4.9.89.
>> Uwe's patch
>>
>> 6df765dca378bddf994cfd2044acafa501bd800f
>>
>> please apply to clear the situation.
>>
>> I know you very busy! -
> 
> It's best to email stable@vger.kernel.org for stuff like this, as I
> almost missed it...
> 
> Now queued up.
> 
> greg k-h

Thanks!
will follow up and cc the stable@ next time.

Chris
