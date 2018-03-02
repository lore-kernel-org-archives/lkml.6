Return-Path: <alex.shi@linaro.org>
X-Cyrus-Session-Id: sloti22d1t05-1073259-1519981368-2-15914575109756498350
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_NONE -0.0001, RCVD_IN_MSPIKE_H3 -0.01,
  RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.83.68', Host='mail-pg0-f68.google.com', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: alex.shi@linaro.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519981367; b=beOeVQmKp2kmvko4SYpcm2HONPvjzGpGlo1uiKNsqHaSSHj
    d/ICWQC3stCidzTNsRB+GV6+uVIUw7cMxxMZfeK/+9VbrnVHVtZUrAcKSAu0zN1a
    RPuti4FbOdCJRV5kO26dK2CKSn3CvkbcrfXy/RRSWCGF73HYC0H5rvb1It8+//qV
    MmMIpGtRaCGAdmIFBQDWzmO6C3sY23S6g1D95149obnpDTZaijgrf5WIxoArhP+b
    6udfHyZ7WJckGx6rKmPNmiXUa95TMI2YRnvndCi8zBVQ8TJpU0MaqUIu28IBwVDt
    POwMAYGv+pJq/gIrcGs1GpwT8CNSx8d9/upeibg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding; s=arctest; t=1519981367; bh=I8ByxBMY
    lrqEAOs5uTto7JJaSh+AuRjQD/L0ohkFig4=; b=Tn8yrFCTK606X1dcHSRAHkjn
    Bg4zgqBzz3BI/p8QhD0EeuDc/FWHcQd2Z1F+vY2CaFIzCVmvMcYKgFTLs3H4iQQM
    c1+BY76dWhshYszR0/05by6HXjFuWRvXwRhn9BlIAlAO1ePyGVEgRAS+Sko9p2MT
    0xFUxe8At0aUAA2NawBXjF5rdw/Bw+GgGRSAoR62OAsxxmibssIt4vWUPib6yeCV
    RrdrFuPqlunyXy+2VqhA9RHcAMw6LCwub7DP1YMDfaN3TV922nOovtnG7lARjfuQ
    0Oxqm3hgotxX53mEoLGLrHwYAIrnNvk5Vlw1i9n6wDGz/RvmOASSXqOxJT60+A==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h9Cb00r+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EYleIJkb;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=linaro.org header.i=@linaro.org header.b=h9Cb00r+ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=pass (p=none,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=74.125.83.68 (mail-pg0-f68.google.com);
    spf=pass smtp.mailfrom=alex.shi@linaro.org smtp.helo=mail-pg0-f68.google.com;
    x-aligned-from=pass;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=EYleIJkb;
    x-ptr=pass x-ptr-helo=mail-pg0-f68.google.com x-ptr-lookup=mail-pg0-f68.google.com;
    x-return-mx=pass smtp.domain=linaro.org smtp.result=pass smtp_is_org_domain=yes header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Google-Smtp-Source: AG47ELs6N0kvuuO6R+Rpemzzu120Nsee4nOvb3d2d4OGR8kOx9JbUjGJ+1ijEDM1RgxvFWtECGmrwQ==
Subject: Re: [PATCH 00/45] arm Spectre fix backport review for LTS 4.9
To: Greg KH <greg@kroah.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>, Will Deacon <will.deacon@arm.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, stable@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1519908862-11425-1-git-send-email-alex.shi@linaro.org>
 <20180301164630.GB23321@kroah.com>
From: Alex Shi <alex.shi@linaro.org>
Message-ID: <c96bc4d8-25b8-684b-83f6-7d6c6c0fea4b@linaro.org>
Date: Fri, 2 Mar 2018 17:02:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180301164630.GB23321@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/02/2018 12:46 AM, Greg KH wrote:
> On Thu, Mar 01, 2018 at 08:53:37PM +0800, Alex Shi wrote:
>> Hi All,
>>
>> Resent without non-upstream patches.
>>
>> This backport patchset fixed the spectre issue, it's original branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
>> A few dependency or fixingpatches are also picked up, if they are necessary
>>  and no functional changes.
>>
>> No bug found from kernelci.org and lkft testing. It also could be gotten from:
>>
>> git://git.linaro.org/kernel/linux-linaro-stable.git v4.9-spectre-upstream-only
> 
> Also, how did you test, what platforms did you test, and did you test
> that this actually did fix the spectre issue on your platforms?  If so,
> what test did you use?
> 

On the kernelci, there are 18 kinds of platoforms with different
configure tested booting, detailed info is here:
https://kernelci.org/boot/all/job/lsk/branch/linux-linaro-lsk-v4.9-test/kernel/lsk-v4.9-17.03-4844-g6f782cff6edb/

I also tested the qemu boot on hikey620. and normal boot on
hikey620/db410c/junor2. The other testing include the LKFT testing which
is reported by email, same as test for LTS. None of testing show
regressions.


As testing the spectre bug fix, that's a good question. I also asked
this question to original patch authors, like Marc. They said they just
figure out these patches could block spectre or meltdown issue. From my
side, I just reproduced the process internal spectre. But all fix on arm
can not resolve the user space internal spectre. It can block from user
to kernel or kernel to user spectre according the code purose. So I
believe these patch could do their job. And arm cpu would drop the
spectre branches if it has 20+ 'nop' instructions...

Regards
Alex
