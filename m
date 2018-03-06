Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AG47ELsKsKGSJUs6jJYFiLgGOSwg+5IU18D1jWQqgOmBexRpD4GVefnsf9tinomujaeB92gZwlDz
ARC-Seal: i=1; a=rsa-sha256; t=1520340516; cv=none;
        d=google.com; s=arc-20160816;
        b=wdQLe4cTpSR9BZmdrybaqCS0SUjMynVLeL7fP407WekCOuSAb5J992HD5VC6xyL+f0
         WikphPGHXLHkL3KeklKu7BEilKXC4tlXY9/ww9rkyWpLpHy8Ckl+lbl4xynGRAc5+cm1
         xsrNJQI3khXc/FshAwfLP7WCFW2r2gXgY1jPLAYOtRsL7WD4cPoJD7LuxthbbKGCfkzU
         HUIfgkUZAhTfczFtHCrphRjl3LigofKqnfg8bI+KXzXcBN6ejnmJMi6Jp+B3muhZX2Bz
         Lx8Qo1WkkKs2/f3lJtV4yxk1RCNplp43RODDRUWkmpvni1+JhMdwUX+wwoDStNOZ3L6G
         NcRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SgNHHXPQKE0s5LAcAJoJBfeiPbbgUk4UVt4EAtRI+II=;
        b=hemMMsOtm+0nq68zvdWQrgfZow42oM64qCYakeQ6/ZWlPwRnpEaD9Chee4AKmqtvGz
         oD5bZhr8FPjh+x0d9TyW+1BygEEK/DltmDM1xlJZyZW4e0SlYYqqAsooa2w6awyA2oDA
         nrw/pZaCD8+cuIfM3NAczQGDoKOa9GjT3HW3vL8UmEU0xokZ5jniuccW3FMB3bwrRxEh
         nYcwZaAdouXcpwYlLvStrYFdfcZWVGlIdSAXnGhwT5Izvaon/mHUbpVaV8EAaA8Qbs8M
         fT4prESkZ9iMnCvRj5Ad6Kw2ugmlpV6CMDv65D003buNf3CetHQBx4z+ICWz99+RPtXR
         PTcQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Arnd Bergmann <arnd@arndb.de>
Cc: Deepa Dinamani <deepa.kernel@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras
 <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
        sparclinux <sparclinux@vger.kernel.org>, devel@driverdev.osuosl.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Helge Deller <deller@gmx.de>,
        the arch/x86 maintainers <x86@kernel.org>, sebott@linux.vnet.ibm.com,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>,
        oprofile-list@lists.sf.net, Catalin Marinas <catalin.marinas@arm.com>,
        Robert Richter <rric@kernel.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>, gerald.schaefer@de.ibm.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        gregkh <gregkh@linuxfoundation.org>, cohuck@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        David Miller <davem@davemloft.net>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
 <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
 <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 6 Mar 2018 13:48:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0Gm1L70EaFzJBk0drRNKtX0FE22BHOSrXBgH1wNfKZ5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18030612-0008-0000-0000-000004D86BB6
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030612-0009-0000-0000-00001E6B8210
Message-Id: <d8480da9-afe9-8a43-9c47-50919215a2de@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803060145
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589713718016333322?=
X-GMAIL-MSGID: =?utf-8?q?1594192576998870425?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 03/06/2018 01:46 PM, Arnd Bergmann wrote:
> On Mon, Mar 5, 2018 at 10:30 AM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
>> On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
>>> All the current architecture specific defines for these
>>> are the same. Refactor these common defines to a common
>>> header file.
>>>
>>> The new common linux/compat_time.h is also useful as it
>>> will eventually be used to hold all the defines that
>>> are needed for compat time types that support non y2038
>>> safe types. New architectures need not have to define these
>>> new types as they will only use new y2038 safe syscalls.
>>> This file can be deleted after y2038 when we stop supporting
>>> non y2038 safe syscalls.
>>
>> You are now include a <linux/*.h> from several asm files
>> (
>>  arch/arm64/include/asm/stat.h
>>  arch/s390/include/asm/elf.h
>>  arch/x86/include/asm/ftrace.h
>>  arch/x86/include/asm/sys_ia32.h
>> )
>> It works, and it is done in many places, but it looks somewhat weird.
>> Would it make sense to have an asm-generic/compate-time.h instead? Asking for
>> opinions here.
> 
> I don't think we have such a rule. If a header file is common to all
> architectures (i.e. no architecture uses a different implementation),
> it should be in include/linux rather than include/asm-generic, regardless
> of whether it can be used by assembler files or not.
> 
>>> --- a/drivers/s390/net/qeth_core_main.c
>>> +++ b/drivers/s390/net/qeth_core_main.c
>>> @@ -32,7 +32,7 @@
>>>  #include <asm/chpid.h>
>>>  #include <asm/io.h>
>>>  #include <asm/sysinfo.h>
>>> -#include <asm/compat.h>
>>> +#include <linux/compat.h>
>>>  #include <asm/diag.h>
>>>  #include <asm/cio.h>
>>>  #include <asm/ccwdev.h>
>>
>> Can you move that into the other includes (where all the other <linux/*> includes are.
> 
> Good catch, this is definitely a rule we have ;-)

FWIW, this was also broken for 
arch/x86/include/asm/sys_ia32.h
