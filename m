Return-Path: <shuah@kernel.org>
X-Google-Smtp-Source: AB8JxZpkeLUSXlRhk32n4uk2ndMOraAvaflkT9qkvJY1XBMDSsj/NuXGI5QGjA+Q6CvUVPlAXOVF
ARC-Seal: i=1; a=rsa-sha256; t=1525800996; cv=none;
        d=google.com; s=arc-20160816;
        b=HgMAIhFx48BJIzkNymfuO5NVKJ6xuE/mXNOpvb7qcA0cRWvGhrB/erBkbyCin11JwU
         9dtYVZzpxb0y/Fl/KrBiBxABki3chKhyBJXGlyKJUNe00dRwLJYpdJe70XFYCU4pUOtO
         yzCB1AGeBEyJTSGKHZBZPR7SR37SbRVZmHAOW9MdrhJUdqoM43xEHMq/zJqsQEjbxin7
         6kurdHGZW1cF7jmf/V8agyxkCnCFubwg5E0qSGnII9qFZaQM1o+o8/y0t0BHbk6WIlWz
         EWFX5AulVQH/RSSy7D+IzYD99s7hZHufEynF6fDG/9VYhXfS9rAxuefhKjkXFEWozLlK
         IGog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=fJGjj3tW/vKTaJPEsRApmUfivnGUU6pLZAwBusKR330=;
        b=KHp8LCsrh9kPcuDGj1q3GHHbz64vifNt72feyoVFxub/0AS6cjagVmOxEPSzafuKwd
         wU9AdNdTESLzL+0ADQ/gMOslox4e/K+WlY9faERrahD5rG1snDMGWuuFsN3Tu6F3Mi+c
         /q2x4vgZ2/FqpabB2+Sq9FCllSVBv0F0OD/USsPSLccF/rcuyq3cwmTobpJhsB5/L2Eh
         qJvhhj3DBir9fJStPky+5xRAQE43I4DoOIUPTtUAKDhdjPWPiebxXK0riibQLAtySHhN
         dGGuHNcreNsbZEywzE12zbF0XdQr9+r7oFWLfsUvH6CEmNgzUzFfOtP0Fir9Z2vKm7DC
         N5xA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning shuah@kernel.org does not designate 64.68.200.34 as permitted sender) smtp.mailfrom=shuah@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Subject: Re: [PATCH 2/2] tools/testing/selftests/x86: fix error: conflicting
 types for 'pkey_get|pkey_set'
To: Dave Hansen <dave.hansen@intel.com>, Li Zhijian
 <lizhijian@cn.fujitsu.com>, linux-kselftest@vger.kernel.org
Cc: mingo@kernel.org, tglx@linutronix.de, gregkh@linuxfoundation.org,
 pombredanne@nexb.com, ebiederm@xmission.com, luto@kernel.org,
 linux-kernel@vger.kernel.org, philip.li@intel.com,
 leist.fnst@cn.fujitsu.com, zhijianx.li@intel.com,
 Shuah Khan <shuah@kernel.org>
References: <1525770870-19067-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1525770870-19067-2-git-send-email-lizhijian@cn.fujitsu.com>
 <125eb810-1d48-394d-9665-40da64326fbb@intel.com>
From: Shuah Khan <shuah@kernel.org>
Message-ID: <e80c9430-eaed-6a46-bde2-141b2e4266d2@kernel.org>
Date: Tue, 8 May 2018 11:36:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <125eb810-1d48-394d-9665-40da64326fbb@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599886734480796496?=
X-GMAIL-MSGID: =?utf-8?q?1599918305630160791?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/08/2018 10:30 AM, Dave Hansen wrote:
> On 05/08/2018 02:14 AM, Li Zhijian wrote:
>> -u32 pkey_get(int pkey, unsigned long flags)
>> +u32 _pkey_get(int pkey, unsigned long flags)
>>  {
>>  	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
>>  	u32 pkru = __rdpkru();
>> @@ -422,7 +426,7 @@ u32 pkey_get(int pkey, unsigned long flags)
>>  	return masked_pkru;
>>  }
> 
> I'm not a huge fan of random underscores for undocumented reasons.  But,
> oh well.
> 
> Acked-by: Dave Hansen <dave.hansen@intel.com>
> 

Thanks. Queuing this up for 4.17-rc5

-- Shuah
