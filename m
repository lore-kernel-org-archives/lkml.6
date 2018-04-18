Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx4+vVCqXSTxtduX7itv5MMrUAUgTlUgYHBs/yjWZ/lOyk1uT8GLmSTAQQmxfC7ebeVrNZCIW
ARC-Seal: i=1; a=rsa-sha256; t=1524081827; cv=none;
        d=google.com; s=arc-20160816;
        b=rhXF2rq+qu7enAtO1ZMpcDY2+Tr03fPRsr6Wgu5nIqazb2SXizVZT7uujbDX/Koohv
         /mo4O0+/4j/TbiTFfO60hQTB/vtuQ7Uho0jnip+DHSwAHQO3IAowVEyWnGZJZ4a9nYRY
         xEerUFX8HJ5CHxmHphKT5FHsBNtQT1R+QwMOBKb7zGKCJEKomcM+ExBnwM6j02rAyTSJ
         YtgyUrOqYjVmTJNgY2z3cTXJTwHKPXdG14aDrtIm063d2OAOmaVdof11/BY3tqmeCkUR
         i5tXDtFLZcdqTr9gIIIhXzpoNtTF7xEed39YQ8PGDsIiZXHqIAlZYE/X0Q2cd6ctBAs+
         gw6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=V7La1uQiyQslY1TzDSQ/JdeyAZYAY5CKQbXvhbxVYY0=;
        b=lNHKJowZlFZOuoIfkN2vlWnG4unQOPYmj3kW4SZfxpXYoW+ZMg8SVxqVmg739iKPCR
         w3wltTwfrFkWxmRy3qQLVDSAf9lFl011/pyMt0MubBfYaX0y3L41vKJblX+X1ChIbjhP
         Hx5a9JESFnXAbBKJAzyQltY1D/DBerEGY3IneAtWSb2N0LlOQ4WDemKFeiTbclnVns0K
         CX7gRGbvRiXBz4fm3ES7a3TdUSUk74I5+/5cjVXeVpr51j9g3mp0KL5OyKBJZ27i0Ck9
         3XoUBHJXp/TtuN3H0F3ozLXJ+44dRRM9E6/JHB5iunsOOySiKkHcqaMysTcHzn1H1yoj
         dddg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fU8ayK73;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=fU8ayK73;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 2/2] selftests: sparc64: char: Selftest for privileged ADI
 driver
To: Shuah Khan <shuah@kernel.org>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        allen.pais@oracle.com, khalid.aziz@oracle.com,
        shannon.nelson@oracle.com, anthony.yznaga@oracle.com,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180418162958.442909-1-tom.hromatka@oracle.com>
 <20180418162958.442909-3-tom.hromatka@oracle.com>
 <6ef81e28-7656-ccf5-5d4d-ef315ae250ce@kernel.org>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <a44ead3d-8565-2d44-5a28-dfc51d4920d9@oracle.com>
Date: Wed, 18 Apr 2018 14:03:37 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6ef81e28-7656-ccf5-5d4d-ef315ae250ce@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=776
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804180180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598102184109699061?=
X-GMAIL-MSGID: =?utf-8?q?1598115625846188927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/18/2018 01:58 PM, Shuah Khan wrote:
> Hi Tom,
>
> On 04/18/2018 10:29 AM, Tom Hromatka wrote:
>> Add a selftest for the sparc64 privileged ADI driver.  These
>> tests verify the read(), pread(), write(), pwrite(), and seek()
>> functionality of the driver.  The tests also report simple
>> performance statistics:
>>
>>          Syscall Call    AvgTime AvgSize
>>                  Count   (ticks) (bytes)
>>          -------------------------------
>>          read          3  167134    8133
>>          pread         4  137217    6741
>>          write         3   73787    8133
>>          pwrite        4   65832    6741
>>          seek         10    2422       0
>>
>>          Ran 8 tests
>>          All tests passed
>>
>> Signed-off-by: Tom Hromatka <tom.hromatka@oracle.com>
>> Reviewed-by: Allen Pais <allen.pais@oracle.com>
> Thanks for the patch. A few comments below:

Thanks for the quick turnaround, Shuah.  I'll work through your
comments and get a v2 out in the next few days.

Regards.

Tom
