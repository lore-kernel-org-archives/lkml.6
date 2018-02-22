Return-Path: <alexandre.torgue@st.com>
X-Google-Smtp-Source: AH8x2261N8W4DfNUnDRWXg/94JxUueKXPlf6OhR57jT2FJmb0vI5kc/v8CS9ZnPGuYk++BG3rZc+
ARC-Seal: i=1; a=rsa-sha256; t=1519313156; cv=none;
        d=google.com; s=arc-20160816;
        b=M83RMn9vl2bSCx4tFDGEXL4v+vfHzWAeb97ozkQaPuMsWBk6mrSAsqYah+rZZpXd+O
         O+0OxnEWF+ViWaPbwGN0CSctvJhvEKhc+M1e1Bwz0sQCi9yDkoDtDylovsArLSMkArqJ
         BMQolB5ZAkZaXLNxA8BQTceuhE/bWTepfdfBGOfqlO1IslSuoeFEUGY4lWwGKIAO/0o9
         Dxsd2d5lJNHStqN1WWyrz2LiqeB2cuy0GlfyCnTDCf7Muk83poumGsbAuvdN0dPR6WiA
         +1uUNqOG9BP+qmsNsr5urkeJwLbGPq1zhIFjtEn929nv28JZ9QthbXsYu1or0BPs+3h0
         Ixzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=gO+93JOsgDoiXt5IAgtSq2ytpaCfh9RWc/Maa72FBNA=;
        b=ed5GE8/5My/h/v0elCOQT4227zxKE8gPsHuO4yz24o1aPKBQDx+ggsw91tRG7Wv/qo
         B/aODpV9Pa0h2aH2Jlfg94FdFKKSQJOnYgg9tJB4euekHZVpEMpfTLVQbFJBcuwnPXOD
         7a58L3bjlf1pzZQsvcNhJUaw1QtlAcdA6CSEhuQSh9+pJ/v1JXdUu0/bm7FKmCKN72yE
         y1oSNkCwUBdmgr/aBgE8A30ShYISX0ci6jjNNFYHlnLCkgOI64zNNcCXMIf3LAnasseY
         oUv+1/b+t6wvgrqm6X3JfR9dvdoQHbTLZ6kO1JWkfXUk9VPTtLTwUrXeHaSGA3ofTJ8k
         XP+w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of alexandre.torgue@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=alexandre.torgue@st.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of alexandre.torgue@st.com designates 91.207.212.93 as permitted sender) smtp.mailfrom=alexandre.torgue@st.com
Subject: Re: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
To: Herbert Xu <herbert@gondor.apana.org.au>,
        Lionel Debieve
	<lionel.debieve@st.com>
CC: Matt Mackall <mpm@selenic.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Rob Herring <rob.herring@linaro.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>,
        Ludovic Barre <ludovic.barre@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
 <20180222140328.GE28447@gondor.apana.org.au>
From: Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8dcbcea1-78f7-27ff-66a0-a6180d32a05e@st.com>
Date: Thu, 22 Feb 2018 16:25:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180222140328.GE28447@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-22_05:,,
 signatures=0
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592472174804694074?=
X-GMAIL-MSGID: =?utf-8?q?1593115312064471797?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi

On 02/22/2018 03:03 PM, Herbert Xu wrote:
> On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
>> This set of patches add extended functionalities for stm32 rng
>> driver.
>> Patch #1 includes a reset during probe to avoid any error status
>> which can occur during bootup process and keep safe rng integrity.
>>
>> Patch #3 adds a new property to manage the clock error detection
>> feature which can be disabled on specific target.
>>
>> Patch #5 rework the timeout calculation for read value that was
>> previously defined based on loop operation and is now based on
>> timer.
> 
> I should take only patches 1/3/5, right?

You could take all (dt-bindings + drivers part).

regards
alex

> 
> Cheers,
> 
