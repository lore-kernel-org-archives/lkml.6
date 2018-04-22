Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AIpwx4/CBMKPWrI4g4/4HERc2TaP8SPAhVhEVx+Gr6buJxSwMB9bChuBcUlkzopiH3w5yoXGi1Gt
ARC-Seal: i=1; a=rsa-sha256; t=1524433981; cv=none;
        d=google.com; s=arc-20160816;
        b=k8XyywmCwGUU2ClTAnlZi3jfnatyBq5WCenIQZH1dHAofP2RbFPoVri49mdUOjPLZ+
         pQu5QdnH9IOVKGRgyse+kdsK1tTdCyqOdRyZfL+/iGVu/PIqkwDJTgGEWoUnZYdpK8Cz
         sozB7WjPaRaJ52U9iluxeQycU8ELeXABU1YGGVyi8+TIIus6/gVGcEv0DeZnireUx1f+
         5y9RlOMFva1aF7j3pv8Kf5dFdMMyL5FH1ZGFI0VTpriHuqP4Gtnph9kwlgPwFMpovFp0
         ffodxnPv1Sr5JiuvO6iPZeRnONpQOJvnAe+3jouPcXf49F9pMIq568IAUU32WNN956k3
         Shqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=WUoLKBqSbt/sssOayc+07qPT0ezVfZSwyNJ2pc4McU8=;
        b=nnRSqWt0FdEGqBAh/cVeGIjx0NN78rbS0k44h1oT9747q3FY2wRf2QjQA9WkCCkMnf
         9qD/E+UtnDkVDOgYAXROxJSz8i1McmOZJ7NDG/I2+EjhZL/9gb4t2fN91hf4oGuZ35Pj
         vPTLYxhfU4PvIE6THmlvfcFjI0nACDPk9K1+JD4hw+gJI828B6fWUvp3+oqWyxYVcCGR
         eNZS4aOvS6EAl/CuBKna+rOpOLaAEYPuhqwlK0RegS/5w1UPo+zerbR87A0rk2ev9K7W
         TEikGJRO9ho7Tw/Z8bLYP2ZfufI6KXisIV6dGEbRk4uLSCakS8imd4oIuWI04y0Z3cA8
         OOUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=alNhwFhg;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=alNhwFhg;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH v4 1/2] char: sparc64: Add privileged ADI driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
References: <20180420205221.488589-1-tom.hromatka@oracle.com>
 <20180420205221.488589-2-tom.hromatka@oracle.com>
 <20180421090449.GA8194@kroah.com>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <7241fc77-c38c-abdb-d8dc-4b22dac36895@oracle.com>
Date: Sun, 22 Apr 2018 15:52:49 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180421090449.GA8194@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8871 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=814
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804220243
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598287411994032224?=
X-GMAIL-MSGID: =?utf-8?q?1598484886942394051?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/21/2018 03:04 AM, Greg KH wrote:
> On Fri, Apr 20, 2018 at 02:52:20PM -0600, Tom Hromatka wrote:
>> --- /dev/null
>> +++ b/drivers/char/adi.c
>> @@ -0,0 +1,240 @@
>> +// SPDX-License-Identifier: GPL-2.0
> Good, but:
>
>> +MODULE_LICENSE("GPL");
> That's the wrong line :(
>
> Read include/linux/module.h for the correct string to put here for a
> GPL version 2 only module.
>

<Tom hangs his head in shame>

My sincerest apologies, Greg.  I'll follow the guidance from
the aforementioned file and re-re-submit the patch tomorrow :(.

Thanks so much for your patience.

Regards,

Tom
