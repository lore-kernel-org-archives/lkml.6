Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsagYUBznKkmKE61yk+zN8N9iJFTBmnofHnSCjYtd0nDn8cgbgInoNLYdqXnwgjkkvYw4Y6
ARC-Seal: i=1; a=rsa-sha256; t=1521092764; cv=none;
        d=google.com; s=arc-20160816;
        b=O5wVqzvZVD3+XV6uXw2cZBzP6WQ4dErA+HWn6EMFdizgY4AHH0XB47poGvOjk2zVg+
         7EXM994Of7Dce5uhAT/V2OY0lK/dGp/feSVs1j496ffGKuqaSSYeFniPrYmcqyeo2sXv
         dijvYRMrgt7uKyq5B+0tp0rcWLKOXvOU41fWFytwbfp+h61Hp6wjph7atmQRI8emn8n6
         ZIDth5ccFMhreg8qaY9azM1akJo1yO3cbUswDXD+G/PHKJve+wMj3TFLWUWxONzWcJJG
         c35jDiRt4YiTpGoOCGMmoHAG1FgxXDrM9tqHp+q17QU39jzY0SO76dclOfj1sakcoiL2
         /sJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:message-id:content-language
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :from:references:cc:to:subject:arc-authentication-results;
        bh=d2W7+x3AvIRpcT8NJCYDw1BtvpR7VCKvwm/jtGr7OJs=;
        b=sJTCHYxFlWUdiqBxH4ogVgicHmKIkQIRqwtv4S6f1xhWWPa3wY19mSzQ0gxLQg4ou+
         UKHkRz1Cy5/G7FF6MVGAyv+R+tdbwNUASkJ1gyujvZWBZiwfVLXcjdIGKWzzM7ukkqzl
         RJ6gfuKVNhsB4K+4TKsYySUMzz9CublsD89Iittvx754jLYzqOCHo1FZZgVIXLlTVMi3
         wYHqTg315VtMA+fXDbG5ma+JTNum2rC2+TlDL2uRFmbADfAl7IJK1t74Pyhe9Q2ORQ0P
         BwlI0sWvVjseTu/wJ5nccGrnJFw/Fhwn3gHwZB0Mc3dH+F9RW6sCWg+ogUAxoi6qGT7s
         9iGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751390AbeCOFqD (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Thu, 15 Mar 2018 01:46:03 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:51178 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750745AbeCOFqC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Mar 2018 01:46:02 -0400
Subject: Re: [PATCH v5 16/19] tracing: probeevent: Add array type support
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
References: <152049860385.7289.14079393589900496424.stgit@devbox>
 <152049905133.7289.17516121776689315422.stgit@devbox>
From: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Date: Thu, 15 Mar 2018 11:18:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <152049905133.7289.17516121776689315422.stgit@devbox>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 18031505-0016-0000-0000-00000532CB4B
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18031505-0017-0000-0000-0000286FD370
Message-Id: <72be81a4-710a-b942-277d-9156c3debc5d@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-15_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803150067
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594358839822578667?=
X-GMAIL-MSGID: =?utf-8?q?1594981366347557687?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Masami,

On 03/08/2018 02:20 PM, Masami Hiramatsu wrote:
> Add array type support for probe events.
> This allows user to get arraied types from memory address.
> The array type syntax is
>
> 	TYPE[N]
>
> Where TYPE is one of types (u8/16/32/64,s8/16/32/64,
> x8/16/32/64, symbol, string) and N is a fixed value less
> than 64.
>
> The string array type is a bit different from other types. For
> other base types, <base-type>[1] is equal to <base-type>
> (e.g. +0(%di):x32[1] is same as +0(%di):x32.) But string[1] is not
> equal to string. The string type itself represents "char array",
> but string array type represents "char * array". So, for example,
> +0(%di):string[1] is equal to +0(+0(%di)):string.

I was trying to test this patch. But I'm not getting proper data.
Here is what I'm doing...

$ cat hello.c
#include <stdio.h>

void foo1(int a[])
{
    printf("%d\n", a[2]);
}

void foo(int a[])
{
    printf("%d\n", a[1]);
    foo1(a);
}

void main()
{
    int a[3] = {4, 5, 6};
    printf("%d\n", a[0]);
    foo(a);
}

$ gcc -g hello.c -o hello
$ sudo ./perf probe -x ~/hello foo1 'a=a:x32[3]'
$ sudo cat /sys/kernel/debug/tracing/uprobe_events
p:probe_hello/foo1 /home/ravi/hello:0x00000000000005fc a=+96(%gpr31):x32[3]

$ sudo ./perf record -e probe_hello:foo1 ~/hello
$ sudo ./perf script
hello  6913 [038]  2857.704470: probe_hello:foo1: (100005fc) a={0xd69e4400,0x7fff,0x0}


I don't see proper values of the 'a'? Anything wrong with my perf commands :) ?

Thanks,
Ravi

