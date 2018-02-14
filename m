Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x225TXl+/jr7khz33m2SliAkktmGGRp7A/gC2UtWjiIidsPbbRpuIZS18u8poU3zRGI/p4eYv
ARC-Seal: i=1; a=rsa-sha256; t=1518620591; cv=none;
        d=google.com; s=arc-20160816;
        b=uuEMrMhkqMFcHSzxqQz6z+4+Jv3B9q/IPl99se4i+vLZ+DMl+oMsBElk+9iCCx3ECp
         aLyoNNU/Wz44VGII19qBK/HwjLdEOUenMvS5iSILGhW4Wk6DqQ9BwypkVT5o16UhSve7
         AlKIi0R9wbGMGe9wsRI9pLAuphri9uF3Fs2u4TZwHnGaIndaZRk8CxksTGZKuDAmqWUa
         /cNeiL2my2PiaDM8RuHh+FlXKaRCe7ZRn330V5lUjaeOuNRT37pcUg0Xn96H5NJHBW4W
         KiMiYF7peEYZHMDYlmH+0VU/Qp5sf0V8ZfBfz80kALIq7SpaJd4bNidqJa5xy2vFS8D4
         c2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:arc-authentication-results;
        bh=T2/5EhZxN5RzOqKM0L02pZkT8wHOPVKjr3LmTIx02/I=;
        b=x2hhJcCtxOI4sIvbKlvW/VjTqaNVGIUGyLioVwRDVdg9lmn44nBl1RoYsoBIPcFXPG
         H1JJrBP7/clhMJkaacFM1Dn/Juo7+EPjgjiDHTsvgo2KVJ7Ye/D+a3VYwsqDFBdcGjm0
         zH3q4TtEvzZkCusSxtk/4GIXYafmpiaLm29N07TQGL1fYqsQ5XshFwB71KiH0CKP6KM5
         gawh/uVi7upfB3ph/0VFOlhsmDTOF6nJb2RySNmuEfP274mxXDtDt5C3yBsyNzxc4r0F
         g194FxMHbYG/Sgprpi3PQ6VgVkKGrbivCQ7YwfxnIfIbS/WnrzVgsToEwqJ5EuVHF4yi
         +UmA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030976AbeBNPCl (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 14 Feb 2018 10:02:41 -0500
Received: from osg.samsung.com ([64.30.133.232]:52605 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030382AbeBNPCk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 14 Feb 2018 10:02:40 -0500
Subject: Re: [PATCH] selftests/futex: Fix line continuation in Makefile
To: =?UTF-8?Q?Daniel_D=c3=adaz_Rodr=c3=adguez?=
        <daniel.diaz@linaro.org>, Darren Hart <dvhart@infradead.org>
Cc: linux-kselftest@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:FUTEX SUBSYSTEM" <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <1518024271-12467-1-git-send-email-daniel.diaz@linaro.org>
 <dbf5a78f-4178-2210-9a6c-bf71de7b939d@osg.samsung.com>
 <20180214013347.GA5786@fury>
 <6d498007-de71-2071-646c-05eeb81b2b08@osg.samsung.com>
 <20180214020352.GB5786@fury>
 <CAEUSe781sJsz=4rMBa+np7x=snO7r-ByV_AiaTtmcfUZk06j=g@mail.gmail.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <e321d6ac-b62e-c9af-00e8-7a114da81aff@osg.samsung.com>
Date: Wed, 14 Feb 2018 08:02:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAEUSe781sJsz=4rMBa+np7x=snO7r-ByV_AiaTtmcfUZk06j=g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591763894080699218?=
X-GMAIL-MSGID: =?utf-8?q?1592389105019598293?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/14/2018 07:49 AM, Daniel Díaz Rodríguez wrote:
> Hello!
> 
> 
> On 13 February 2018 at 20:03, Darren Hart <dvhart@infradead.org> wrote:
>> On Tue, Feb 13, 2018 at 06:45:54PM -0700, Shuah Khan wrote:
> [...]
>>> My understanding is that this problem is seen with make versions prior to 4.x.
>>> This specific problem is seen with make version 3.81
>>> I will let Daniel Díaz share details on his environment.
>>
>> OK, thanks Shuah. I think this would be important to capture in the commit
>> message.

Thanks.

> 
> That's correct -- fails with GNU Make 3.80, 3.81; works with GNU Make
> 3.82 and the 4.x series. Shuah, if you'd like me to resubmit let me
> know.
> 

Thanks you both. I will update the commit log with the details on why
this fix is needed. No need to send an updated patch.

thanks,
-- Shuah

