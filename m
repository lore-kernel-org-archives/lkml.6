Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-485710-1525875798-2-845615242125858194
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='dk',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525875797; b=WyZ6uRyY+EtTvmFB3E+/ZroQJr8qRV99cA+U1ZARqoCDcN6H9o
    TkcTbLY1oTaUkVyjFc44Pc+DtUHQCbPiAFLM/qG9WMfDYvMLPZDhu2KHh3uin2jD
    KgWVvuZ2Dl4LG7KAj/CQHk72FkgeT9hCSuFvFT6Dlw/SIl+oDLl7wcfjdrWhbqk4
    Sms3VHWWVAqM1P2dIicsGO21cSmxb+hOSI8J5zM0mjwg2JV0Q1T39oql+S1yL/3y
    GWAsu/qVTHyVTmzq7tCbPJtmql+40YDON4FXJ2GEjbnAbEFbenjQTHy/cU42hApF
    bPOOGhp+Kvf8HFWQ5U3OEmkwXj+wO4AOskwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525875797;
    bh=6x6OCmeb6dV5lknNw6mBOTHJpelfnEs8KRlNoRxiNjY=; b=Og7xc67RL4ta
    F+egnJ6Ts9stqoDR907AxavboaTtHB6AKSLcOQEXs4jgwP26iEn++Q3vfJ77KkOy
    HCBILVawAITYuOnXzreu57+MhaQOR7OvF2bKCh5rGKGVWFyRG6cE4olu622hsqss
    eV5z8mPTyZ+iCJJkyQo0Pe1Hqu2yfCqYtt6GRrV4pRR2FZaeUUBSJN/8W/GXXXmP
    HVp4s66RPypfo3w0A4Npg0nlLgnoATOFKBtdWyJQyokR6yYUJhxyGB/gvwujbnkq
    wnrCSgHwJxQ36PwPfK3Iqt2OkKCW58H+7seo18pI293L9SviTLVtwLefhagQd5Wa
    XrkdKma7sw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=kernel-dk.20150623.gappssmtp.com
    header.i=@kernel-dk.20150623.gappssmtp.com header.b=Afz8gY8q
    x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=jxT9IqFC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=kernel-dk.20150623.gappssmtp.com
      header.i=@kernel-dk.20150623.gappssmtp.com header.b=Afz8gY8q
      x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.dk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=jxT9IqFC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.dk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBSDv2miNsYyKLL8Q+z2gIWYlr9iuZLMQMeiCmNLXGcBQqVzspzk7cvVzI6gLpe+t72DX6Mu0DGpZzpaNjJdLhUCHCrGa5pGuyzwHEugqF40EejfU1eu
    M/n+nE9Q4cCn3f1dELM8yCdRl8uwh16/O617XC/VxfOzuhvhFnmAJs0YkciaRUKC1QeIeCfn3SNM12AreHBY+MUgwPsdiwt8Wb2C9MPhw+OBurNQ7iFG1OtQ
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=JF9118EUAAAA:8 a=VwQbUJbxAAAA:8 a=Lpdk4Uo1DMNlzMQvx1UA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=xVlTc564ipvMDusKsbsT:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934999AbeEIOXE (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 10:23:04 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:52104 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933828AbeEIOXD (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 May 2018 10:23:03 -0400
X-Google-Smtp-Source: AB8JxZqB+/9O++P30mPYHFPRSCc+cN5Tg81cU0/XSNNc6z7hwLFIuE5hAWjK9wWfCWkRKc7/Ov39gA==
Subject: Re: [PATCH v3 2/3] fs: Convert kiocb rw_hint from enum to u16
To: "Theodore Y. Ts'o" <tytso@mit.edu>, adam.manzanares@wdc.com,
        viro@zeniv.linux.org.uk, bcrl@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-api@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180508174202.2537-1-adam.manzanares@wdc.com>
 <20180508174202.2537-3-adam.manzanares@wdc.com>
 <20180509133432.GD28388@thunk.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <0aad993b-448c-3586-cfc0-f2e50b1dda28@kernel.dk>
Date: Wed, 9 May 2018 08:23:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180509133432.GD28388@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/9/18 7:34 AM, Theodore Y. Ts'o wrote:
> On Tue, May 08, 2018 at 10:42:01AM -0700, adam.manzanares@wdc.com wrote:
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 760d8da1b6c7..7a90ce387e00 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -284,6 +284,8 @@ enum rw_hint {
>>  	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
>>  };
>>  
>> +#define MAX_KI_HINT		((1 << 16) - 1) /* ki_hint type is u16 */
>> +
> 
> Do we really think there will be *ever* be a need for more than 16 I/O
> priority levels?  I would much rather use the low four bits of KI_HINT
> for the priority level, and reserve the rest of the 16 bits in KI_HINT
> for some future use.  (For example, we might want to use some number
> of bits for a stream ID.)

Streams is essentially the only thing ki_hint is currently used for,
with the write life time hints mapping to a stream. The idea for the
user side API was to have other things than just write life time hints.

Since Adam wants to do priorities, he'd either need to pack into the
existing ki_hint, or do this patch does, which is make it smaller and
add a new member. I think the latter is cleaner.

-- 
Jens Axboe

