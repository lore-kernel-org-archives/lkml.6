Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-2934828-1520038342-2-10490078414139503158
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.85.160.67', Host='mail-pl0-f67.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520038341; b=cMd5oLAqFtzVyXTz4bM4zoI/v4JNb26qlN5ZIz9Vxh8PLJX
    BbmM4+RK2zHW5yCuqtuEAsANUFHQVSJ8C6nWI1sgKEkjrIJqLgRPNcseDzScpi9V
    sF10ctno1w9D4Rp0r3yskC6jnDleEOdet84TCDRbyS1puSOteOg3yNDOxFUh54Os
    AaD5r0o5RCxHKrcgRXpfb9bDAsjXI8blpWGfKrFHaCC4IJ0iBjOee9uvmX5fHreJ
    +q69bu/W/Wys4bx20wSSv3seivFtgPQ91NlCGMmHn1UvOzSNMKUBnFup86aTszGG
    0IX6LNJFpoQCQMulbYGeNfrV6o8NwPL6cGCCDxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1520038341; bh=5mtU1Qc2
    6aeoEC3yyOdSV9DOHqlHuai9RGNHR9FlS64=; b=sqNBMqOFwr6ZixCgobS0N4OL
    JjrwsTR47ckDqhXzu8MqXYC1+nTdGbE3NdOr5zQjVROofcHtw7e1tDBokvxHeh+o
    3+Zvx5jxuDv7hcnNh4638uAyXx/9/7fJ/ikA8FbdZThaiw5JfhcvCnAVX6TcUy5l
    Vju4knXqQ02TlEbGIGzvmt2aONTnDnQEFvclxrGzVB7ussiDoKRcYhUWq8Pd3Gk4
    rrNjD8sm0mX0VzLY7vw/1L5JPq6prhptBm73vaHYt8q2rrmfbGlD+CVuB+ulnxnU
    TyRdy9c4UU2Vxco2cP9HKeH9vAkHiYogxnvlZlOgcVug0TsTFHDPe8TLQ/t2zQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=E+DvBr8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tVT4jNlp;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=E+DvBr8o x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.85.160.67 (mail-pl0-f67.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pl0-f67.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=tVT4jNlp;
    x-ptr=pass x-ptr-helo=mail-pl0-f67.google.com x-ptr-lookup=mail-pl0-f67.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELsPXF4cpNvUhKaW815cSOu+XF6zut3JU341fe9x36GJlWXUbbgxI2fyecgZwdDhj3MUImgUHQ==
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg KH <greg@kroah.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
 <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
 <86r2p23h3v.wl-marc.zyngier@arm.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <a16dc104-2ede-77db-506e-266a7127e373@linaro.org>
Date: Sat, 3 Mar 2018 08:52:07 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <86r2p23h3v.wl-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/02/2018 06:29 PM, Marc Zyngier wrote:
> On Fri, 02 Mar 2018 09:02:32 +0000,
> Alex Shi wrote:
>>
>>
>>
>> On 03/02/2018 12:46 AM, Greg KH wrote:
>>> On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
>>>> Hi All,
>>>>
>>>> Resent without non-upstream patches.
>>>>
>>>> This backport patchset fixed the spectre issue, it's original branch:
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>>>> A few dependency or fixingpatches are also picked up, if they are necessary
>>>>  and no functional changes.
>>>>
>>>> No bug found from kernelci.org and lkft testing. It also could be gotten from:
>>>>
>>>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
>>>
>>> Also, how did you test, what platforms did you test, and did you test
>>> that this actually did fix the spectre issue on your platforms?  If so,
>>> what test did you use?
>>>
>>
>> On the kernelci, there are 18 kinds of platoforms with different
>> configure tested booting, detailed info is here:
>> https://kernelci.org/boot/all/job/lsk/branch/linux-linaro-lsk-v4.9-test/kernel/lsk-v4.9-17.03-4844-g6f782cff6edb/
>>
>> I also tested the qemu boot on hikey620. and normal boot on
> 
> Did you try QEMU in conjunction with KVM? Or just in emulation?

Many many thanks for response!

Yes, I tried both of type boot with or w/o KVM. Both works.

> 
>> hikey620/db410c/junor2. The other testing include the LKFT testing which
>> is reported by email, same as test for LTS. None of testing show
>> regressions.
>>
>>
>> As testing the spectre bug fix, that's a good question. I also asked
>> this question to original patch authors, like Marc. They said they just
>> figure out these patches could block spectre or meltdown issue. From my
>> side, I just reproduced the process internal spectre. But all fix on arm
>> can not resolve the user space internal spectre. It can block from user
>> to kernel or kernel to user spectre according the code purose. So I
>> believe these patch could do their job. And arm cpu would drop the
>> spectre branches if it has 20+ 'nop' instructions...
> 
> What are you talking about? What's that story about NOPs? There are
> clear mitigation guidelines for ARM cores, please don't make things
> up.

Oops, sorry for misunderstanding! what's I meaning is, among many kind
of solution to mitigation issues, like ATF changes, compiler change, BT
changes, 'nop' is interesting for me. Sorry for bad expression.

Regards
Alex
