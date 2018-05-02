Return-Path: <tmricht@linux.ibm.com>
X-Google-Smtp-Source: AB8JxZqLQCcAkowUgGlv69N7uEiLUEKvrt0gJ6eJfQ5mxKGvvg6dHEyIrh5fnpWEqgyGPKHSsbjo
ARC-Seal: i=1; a=rsa-sha256; t=1525245400; cv=none;
        d=google.com; s=arc-20160816;
        b=T+LG+t6oEP5HCWnvcUKj6k7z8XCHJPovrBK2FvZeifUFURBMZp+h4ix2IjCzhCG20j
         RvtY1LDtgn6aXA3GHrfLj2wGlmG2xBBwlqq3IZBQMFkl86v9JmrcMWEf5SfMJwm/fcQT
         2n51ABP25oqacV9oGjhwL1HNyOXrsRDsI8UjCo+tTFBjfnolX9H77HASlKsGFo6fqJ67
         VJvMt5DLelgkyKYmsDu1FJ821vCKHB7eBrmerGSjx/V1gQtviI06iiORqdRS/FZLoneq
         uAEiMFJBDz/Ayd47ZIMFSUSKPuZlYb8Ks+TLNhZe1kMIozxI/oJ0mXyunOHtQSK5sr+w
         BPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=Uc+9YYT4ecb25kbjOJR7YrZKGzDbKDlM45cfWblQVmo=;
        b=v7wVOYJNvCnHpsnKlmzfdEkr7T+xVOMT7qEwaLKJKwSSnveWiAvishTmN/GNxAlcCg
         Wm7fywRbjj+oNRkH9mJyb6oOBWmIqijHMftj+alcfmQiqeZi2sQdIJ7Gqwcz/SQt22mT
         EeRcn01RIp29DXsziYhbD3u23CdZ3vz/WwYn8IoG/XzQ9zxA4cZEocfDgi8+ygRjg5xI
         24HtgNAwzLoYoDdtgRrsKieiuolgjzbm02AIVJFzmivZtazfzTWxk9SmbB+3Q7x9lnOY
         CabgwPQc9kXkxt5iIrrhSUfGvxJahrqKb989Q5oFZXC3M/nyDlDxHNYdmC8cCArPs60C
         T/uQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tmricht@linux.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=tmricht@linux.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v2] inode: debugfs_create_dir uses mode permission from
 parent
To: Kees Cook <keescook@chromium.org>, Greg KH <gregkh@linuxfoundation.org>
Cc: Kernel Hardening <kernel-hardening@lists.openwall.com>,
        brueckner@linux.vnet.ibm.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20180427123547.15727-1-tmricht@linux.ibm.com>
 <20180427134936.GA31171@kroah.com>
 <CAGXu5j+LK8-g9bg+RNn+-v1LpRC32sTCAUNZr1v0HXquiG9fQw@mail.gmail.com>
From: Thomas-Mich Richter <tmricht@linux.ibm.com>
Organization: IBM LTC
Date: Wed, 2 May 2018 09:16:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGXu5j+LK8-g9bg+RNn+-v1LpRC32sTCAUNZr1v0HXquiG9fQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18050207-0040-0000-0000-0000045405B5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18050207-0041-0000-0000-000020F82425
Message-Id: <8d3e702b-470a-542e-4e0d-6a3c58419f0f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-02_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1805020073
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598885939373348657?=
X-GMAIL-MSGID: =?utf-8?q?1599335720865883315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 04:58 PM, Kees Cook wrote:
> On Fri, Apr 27, 2018 at 6:49 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> I'm going to add Kees and the kernel-hardning list here, as I'd like
>> their opinions for the patch below.
>>
>> Kees, do you have any problems with this patch?  I know you worked on
>> making debugfs more "secure" from non-root users, this should still keep
>> the intial mount permissions all fine, right?  Anything I'm not
>> considering here?
> 
> This appears correct to me. I'd like to see some stronger rationale
> for why this is needed, just so I have a "design" to compare the
> implementation against. :)
> 
> Normally, the top-level directory permissions should block all the
> subdirectories too. The only time I think of this being needed is if
> someone is explicitly bind-mounting a subdirectory to another location
> (e.g. Chrome OS does this for the i915 subdirectory). In that case,
> I'd expect them to tweak permissions too. Thomas, what's your
> use-case?
> 
> -Kees
> 

There is no 'real use case'. I wrote the patch because of discussions
regarding file permissions for files located deeply in the
directory tree, for example

  -r--r--r-- 1 root root 0 Apr 27 14:23 /sys/kernel/debug/kprobes/blacklist

which gives the impression it is world readable.
This happened to me in recent discussions when I wrote patches to fix some
of the address randomized output of /sys files which broke the perf tool.

During discussion people often forgot that the root /sys/kernel/debug is rwx for
root only and blocks non root access to subdirectories and files. They simply
looked at the file permissions.

I have not thougth about the bind-mount case nor did I test this scenario.

-- 
Thomas Richter, Dept 3303, IBM s390 Linux Development, Boeblingen, Germany
--
Vorsitzende des Aufsichtsrats: Martina Koederitz 
Geschäftsführung: Dirk Wittkopp
Sitz der Gesellschaft: Böblingen / Registergericht: Amtsgericht Stuttgart, HRB 243294
