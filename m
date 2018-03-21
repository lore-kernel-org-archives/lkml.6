Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521639912; cv=none;
        d=google.com; s=arc-20160816;
        b=a84sJyltZN0j24pKJBCQKyTA+JmybTN7KTW9QaW8ApjSTHyxfwZ7xvfHCXccH1kP+Y
         cqVsHVZqbXibOJIhLNpx1hJU4ruaNxil1azbGdXXiKZGJCZxniJxI8SH58KSQRSWQ8oU
         N4+zQoGJ34jdgf61s6D/71a+6hTSngEv+vdXlsqsqHHcffV1uYmPQg0hApj/LqqPTGfv
         dVNPnRY0/eY8I3K7qA/LBLFLOG/zeD5u2zzPBa+xQAa3n/bKX1dhow6sfR5wcalSYbu8
         RXtdVKun1GTTGNPk6uyICdZLjPiyH7XU5OjCeZtYl9Ql/NrNwY9jjmmgEGl7qxhah9AQ
         LmBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=qwX5TNmC4qGzqXCXgwLBchEv21dVbUPBM2yk6ywdzMQ=;
        b=YwwVbxf7rLLJqEPAZ/riCiu6rixVhRmzpVegbBszBJe9Y57sqeXkESxCklGA9U1XBA
         hCRd0c1Y7mXVGxtoHTCbAXbCL1eUQkH/hRNckPTA+sU6jZUoydrCOZvoBtL1z13V5urR
         zdFRQEQyxbII1Ted4ko9UeES++8Uf8jrveOCdODbWQkzIFi2bDixRsxrhZfgKrkZSxMU
         lfgcXEidSLX+kxCHrQOBSKm/dGKk+ilVcq8s8HD75aTc1vIsK34eAMXiS2mQA9WB3g/H
         PCAyp0xKcSe2G1hp2AHOzLUinbBAKCbLpUwEMhSmko4Bt0IpOMPdWPx9oVPLuKCoXCs5
         VSJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oTPbGYmN;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=oTPbGYmN;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELtV0XRQ8z7iVXMJt3Bo38qFRx62JuhS+24QtGh++m6JHAEKCGYxhceEpsVoH9bCcX6SBeSn+w==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4.9 000/241] 4.9.89-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180319180751.172155436@linuxfoundation.org>
 <ba41bdff-3068-a2e5-717f-715aeab56197@roeck-us.net>
 <20180321132829.GA28002@kroah.com> <20180321133137.GB28002@kroah.com>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <3315d681-289f-24e9-0618-595b71ec9ff2@roeck-us.net>
Date: Wed, 21 Mar 2018 06:45:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180321133137.GB28002@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391137042363427?=
X-GMAIL-MSGID: =?utf-8?q?1595555092764919652?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/21/2018 06:31 AM, Greg Kroah-Hartman wrote:
> On Wed, Mar 21, 2018 at 02:28:29PM +0100, Greg Kroah-Hartman wrote:
>> On Tue, Mar 20, 2018 at 06:35:01AM -0700, Guenter Roeck wrote:
>>> On 03/19/2018 11:04 AM, Greg Kroah-Hartman wrote:
>>>> This is the start of the stable review cycle for the 4.9.89 release.
>>>> There are 241 patches in this series, all will be posted as a response
>>>> to this one.  If anyone has any issues with these being applied, please
>>>> let me know.
>>>>
>>>> Responses should be made by Wed Mar 21 18:07:03 UTC 2018.
>>>> Anything received after that time might be too late.
>>>>
>>>
>>> For v4.9.88-239-g393003b:
>>>
>>> Build results:
>>> 	total: 145 pass: 143 fail: 2
>>> Failed builds:
>>> 	arm:allmodconfig
>>> 	x86_64:allnoconfig
>>>
>>> arm:
>>>
>>> sound/soc/sh/rcar/cmd.c: In function 'rsnd_cmd_init':
>>> sound/soc/sh/rcar/cmd.c:85:14: warning: array subscript is below array bounds
>>
>> Oops, missed this one for -rc3, let me go dig...
> 
> I don't see anything in this -rc that looks to be causing this.  Has
> this warning been there before, or is it new now?
> 

Probably old. I only mentioned it because you had asked to be informed about warnings.
Does it make sense to bisect ?

Guenter
