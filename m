Return-Path: <thierry.escande@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523535473; cv=none;
        d=google.com; s=arc-20160816;
        b=HDjg3R2pARWqhCDb5kAL9mVq96foH0hQJCG+/PQVCeV7Mu3ElDdGl90Dw6C1x1MeDb
         +DbbtBznRVMlyPn49r6EUNb4BzSXUn5sbnMvVkx7md/eh1WHafOEVX+cLgR0lwGCO4sB
         4ZhqOhEIQLqB7sqPsyS4jrhS4WicdX8EMRE7W0mw5KMVUy390j5hT1Yk5bW17+VALZiV
         X0vF/PD9ztkz3PeCc6slSGC6w0p9e5lrJ6/4CNI/mXZpIO66zRaXDeWdeHAcD0Bq95Gf
         T5TmU+mRSwlTdXU8jKArX1Tf+49U0I2FZJOmD9rd5rwshujByEn4xnPkrKpbFhXyPzEf
         mAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:cc:references:to:subject
         :dkim-signature:arc-authentication-results;
        bh=fmt8UQUSoTbNBmqeUfgeauHEN89jcTOOJS80NzyIKxk=;
        b=pHoscgmBcb+YKLvMpAl/cFd7G9snhNy42vXd/au8ti/Nvlm59WC3nSEO6Zs+1MK5wo
         Cptz2ZyWAfb+nlN6GeMJOHwLz0NjuLXYfKP5MJU0j+Rpu30v4rj4cS3VOhsXGYfIgWhb
         1g3vut2F9RDcWck93i1Gs/s6/SpFX6+wKgdTgbzPsvxY64XGFcU4mWd3CBgTGf3FraVW
         LrrcVH4YxPj2NiNWlXoQ4IM/Zr4mLZaGPMYuo5J3uTYvc61s9+auGYrdQHMUE2g+gs9t
         ninQSJIkNsSvfpGcBaGtaYSOxkODkIWAx+gnnpLsl5BKvR//by0ZIPWhO6A2qnsCOoau
         3YhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hZROuBln;
       spf=pass (google.com: domain of thierry.escande@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.escande@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=hZROuBln;
       spf=pass (google.com: domain of thierry.escande@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=thierry.escande@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AIpwx495kSC2LXQCye43YAcjSxzkvZ1LSKW+uqfHzflzZQlIBT7CpBjtT5qa9JI4IBZpOEvzSSr+fA==
Subject: Re: [PATCH 4.9 000/102] 4.9.93-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180406084331.507038179@linuxfoundation.org>
 <20180406222524.dzzyzh3su3ytgh3u@xps> <20180407061118.GF18744@kroah.com>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuahkh@osg.samsung.com,
 patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org,
 Nicolas Dechesne <nicolas.dechesne@linaro.org>,
 Anibal Limon <anibal.limon@linaro.org>, Will Deacon <will.deacon@arm.com>
From: Thierry Escande <thierry.escande@linaro.org>
Message-ID: <45305b36-b5fb-5016-4948-38a7465691af@linaro.org>
Date: Thu, 12 Apr 2018 14:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180407061118.GF18744@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597003940861807257?=
X-GMAIL-MSGID: =?utf-8?q?1597542732025336640?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 07/04/2018 08:11, Greg Kroah-Hartman wrote:
> On Fri, Apr 06, 2018 at 05:25:24PM -0500, Dan Rue wrote:
>> On Fri, Apr 06, 2018 at 03:22:41PM +0200, Greg Kroah-Hartman wrote:
>>> This is the start of the stable review cycle for the 4.9.93 release.
>>> There are 102 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Sun Apr  8 08:42:55 UTC 2018.
>>> Anything received after that time might be too late.
>>
>> Results from Linaro’s test farm.
>> No regressions on arm64, arm and x86_64.
>>
>> There is a new test failure on dragonboard 410c (arm64) in
>> kselftest/cpu-on-off-test. However, it looks like the test was failing
>> but giving a false "PASS" on previous versions of 4.9. This -RC seems to
>> have changed the behavior enough to cause the test to actually mark a
>> failure.
>>
>> In any event, this looks like a db410c-specific pre-existing issue that we have
>> already escalated to our Qualcomm team. Details can be found at
>> https://bugs.linaro.org/show_bug.cgi?id=3723 for those interested.
> 
> Thanks for testing these and letting me know.

The test failure on dragonboard 410c comes from [1] to fix a possible 
deadlock related to the hotplug rework. It's been reverted in v4.12 by 
[2] because the cpu hotplug rework was not ready yet at that time. Since 
the hotplug rework has not been backported to v4.9.y, the splat cannot 
be reproduced and so [1] can be reverted or [2] applied on v4.9.y.

[1] https://lkml.org/lkml/2018/3/23/452
[2] https://lkml.org/lkml/2017/5/7/124

Regards,
Thierry
