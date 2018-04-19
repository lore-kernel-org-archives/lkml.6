Return-Path: <tom.hromatka@oracle.com>
X-Google-Smtp-Source: AB8JxZrB9HyrC1Cha6CVtu6CP1uPPqDARNV7ekSYBOzymH+km+m2sTOKXhyf4rUSl7Vdcqoi/pZ8
ARC-Seal: i=1; a=rsa-sha256; t=1524143681; cv=none;
        d=google.com; s=arc-20160816;
        b=B0QN05GnTCec1ElAKBUZVdJO7ChjOoa/Lc+rqf6aqWcTlv8htfgRD1ctm/GiM985jJ
         UxGrfwlGfGjTpmqZ0URprOOJi+3knCfnRfud8IMqc97AnnpHtxWe1baHu25A6rziXgRG
         hpHv0eMw3lkd6QL/YG9KoRooCGg6kKhJnZxn94Bi2MFCWt9onavR4jdzcapIDhdGJ7db
         0xHRY03c/c+FPF9lCMrvCXJ4FDCTA+kWc9cutkWvPI2H6RCffuBpSlOpO/ZpOWxqplmS
         VERbM/1nGBx3hDOnu1h1VlWsad+stszuc5iCF5s3scQQr8Klr7j/DPPpTfYnHCoJ+Pgh
         vgxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=zzi5WtQ7wXCy+jpUuMu3NQAZknktYUHXHtvF97QYGB8=;
        b=uGQGIKU5e0SB84CBni8DHR2CpA2pWlKl0KATE3Ovqc+jKZ7dk4JqJgHgBhq+nH554f
         DI4Wwxo1VjSulCOo0DyBmd2gzBcCYsNMb7Sj+/fWiY5GqNTd2TD6jZv8BU2TtclreSz7
         A+kGW6c5cgKcn0NG4qjEfrQdHgPNYgMf9ISF0jz2MuSACwQcRyRBdFYe1T+msu8mn1ya
         YxhPfN0JflEUcvgOGwVmWhbDKRKNPIv/YK6v+1lMLR1N2RKH58oLGlwbHUSeaymJc6TK
         fuccn+zYX47dGRP0maU5MurPgMq4H7E4dz9uCmXuAwoe+hDyZiol903Bm6WpdiE3C4Pr
         7T1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PXn4H6/P;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=PXn4H6/P;
       spf=pass (google.com: domain of tom.hromatka@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=tom.hromatka@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Subject: Re: [PATCH 1/2] char: sparc64: Add privileged ADI driver
To: Greg KH <gregkh@linuxfoundation.org>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
References: <20180418162958.442909-1-tom.hromatka@oracle.com>
 <20180418162958.442909-2-tom.hromatka@oracle.com>
 <20180419074536.GA20145@kroah.com>
From: Tom Hromatka <tom.hromatka@oracle.com>
Message-ID: <02055d2b-eabf-49b0-4e8b-40842b92101f@oracle.com>
Date: Thu, 19 Apr 2018 07:14:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419074536.GA20145@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8867 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=663
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804190118
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598102182453630648?=
X-GMAIL-MSGID: =?utf-8?q?1598180484639318738?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 04/19/2018 01:45 AM, Greg KH wrote:
> On Wed, Apr 18, 2018 at 10:29:57AM -0600, Tom Hromatka wrote:
>> +/*
>> + * Copyright (c) 2017, 2018, Oracle and/or its affiliates. All rights reserved.
>> + * Author: Tom Hromatka <tom.hromatka@oracle.com>
>> + *
>> + * This program is free software; you can redistribute it and/or
>> + * modify it under the terms of the GNU General Public License version 2
>> + * as published by the Free Softare Foundation; or, when distributed
>> + * separately from the Linux kernel or incorporated into other
>> + * software packages, subject to the following license:
>> + *
>> + * Permission is hereby granted, free of charge, to any person obtaining a copy
>> + * of this source file (the "Software"), to deal in the Software without
>> + * restriction, including without limitation the rights to use, copy, modify,
>> + * merge, publish, distribute, sublicense, and/or sell copies of the Software,
>> + * and to permit persons to whom the Software is furnished to do so, subject to
>> + * the following conditions:
>> + *
>> + * The above copyright notice and this permission notice shall be included in
>> + * all copies or substantial portions of the Software.
>> + *
>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
>> + * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
>> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
>> + * IN THE SOFTWARE.
>> + */
> Please just use a single SPDX line at the top of the file for this huge
> license boiler-plate.
>
> thanks,
>
> greg k-h

Thanks.   Will do.

Tom
