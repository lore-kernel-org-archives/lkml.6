Return-Path: <borntraeger@de.ibm.com>
X-Google-Smtp-Source: AG47ELv7NL5Nq6ZflwL3GGeRJMg5jduCSbI+KLJAC+JhK87AIhvSwu1SKPpv9Q9rJtlQuuYV6rVE
ARC-Seal: i=1; a=rsa-sha256; t=1520242241; cv=none;
        d=google.com; s=arc-20160816;
        b=L0DibhXuJB3NrLiud6o6GXhKCix8Dis3RiSee0iUfSKBh1/Z181EXM4PFEkV82vVaX
         IZ7wh+eFoWfxPBU8RipobHzPjdewccCfabstvq4gty2Q2jwqlqqRjoVUE01bcfPAOAk2
         1Oy0F/CAqqylxwiaEOEbH9Im4nNmr76s/25vAQScxt9kMy0of/ppd6a+iZdHtuFKKQEC
         QIXSCcGUXPuBBT58nv5uZhvculJ4V6RBJYq6/5IykjTe5oFeUVn2z58ejrL2OoKqBtXn
         G3eH3YZit5wHtU/ZKNX92cse6lJJmuooRA3tWnkAAdh8CUWSJYuJS6hZjV7Jl6I9GoGW
         zgNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:from:references:cc:to:subject
         :arc-authentication-results;
        bh=6gu135xJV7xAVumoi5TVUnsCNMymNSoJc6Lq6N7Fv3g=;
        b=oP1MXjiDzo+kctJNZa/pWDEAvNopPg9A22Gu1DqwKl4CqENGvubCm8O+vTT42HCoQ/
         dZvgpjlpGRoMo4zq+ORA69UkfZFgnWGMWd1OgsOkGB5Tco4irHcjgdhQsbVQb9RtX9HT
         7V1ujcWEs+StSl4if6MPUY7un9UaylaKwc4c/wLJQdcZHp5/xgkzhoVRhmy7jfcYSaIr
         qxKzUCG2+o5VIc/ITuhHEz8VhQegP86RVzPYy86qhylcCnpEeYdTyhsyQ3KOyeeXBlaw
         D/pg7UDpi0OEXxnTBylsEnzaBexsrTIqvGx59acSQl50e4vBTJByHeubn0gcvu5Msm6q
         BHzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of borntraeger@de.ibm.com designates 148.163.158.5 as permitted sender) smtp.mailfrom=borntraeger@de.ibm.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=ibm.com
Subject: Re: [PATCH v3 02/10] include: Move compat_timespec/ timeval to
 compat_time.h
To: Deepa Dinamani <deepa.kernel@gmail.com>, tglx@linutronix.de,
        john.stultz@linaro.org
Cc: linux-kernel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org,
        acme@kernel.org, benh@kernel.crashing.org, catalin.marinas@arm.com,
        cmetcalf@mellanox.com, cohuck@redhat.com, davem@davemloft.net,
        deller@gmx.de, devel@driverdev.osuosl.org, gerald.schaefer@de.ibm.com,
        gregkh@linuxfoundation.org, heiko.carstens@de.ibm.com,
        hoeppner@linux.vnet.ibm.com, hpa@zytor.com, jejb@parisc-linux.org,
        jwi@linux.vnet.ibm.com, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, mark.rutland@arm.com, mingo@redhat.com,
        mpe@ellerman.id.au, oberpar@linux.vnet.ibm.com,
        oprofile-list@lists.sf.net, paulus@samba.org, peterz@infradead.org,
        ralf@linux-mips.org, rostedt@goodmis.org, rric@kernel.org,
        schwidefsky@de.ibm.com, sebott@linux.vnet.ibm.com,
        sparclinux@vger.kernel.org, sth@linux.vnet.ibm.com,
        ubraun@linux.vnet.ibm.com, will.deacon@arm.com, x86@kernel.org
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
 <20180116021818.24791-3-deepa.kernel@gmail.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 5 Mar 2018 10:30:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180116021818.24791-3-deepa.kernel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 18030509-0040-0000-0000-0000041AD39A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18030509-0041-0000-0000-0000261DE199
Message-Id: <c6fb6676-a8d3-8893-660c-2b9899c5d5ab@de.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-05_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1803050113
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1589713718016333322?=
X-GMAIL-MSGID: =?utf-8?q?1594089528230682454?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 01/16/2018 03:18 AM, Deepa Dinamani wrote:
> All the current architecture specific defines for these
> are the same. Refactor these common defines to a common
> header file.
> 
> The new common linux/compat_time.h is also useful as it
> will eventually be used to hold all the defines that
> are needed for compat time types that support non y2038
> safe types. New architectures need not have to define these
> new types as they will only use new y2038 safe syscalls.
> This file can be deleted after y2038 when we stop supporting
> non y2038 safe syscalls.

You are now include a <linux/*.h> from several asm files
(
 arch/arm64/include/asm/stat.h   
 arch/s390/include/asm/elf.h     
 arch/x86/include/asm/ftrace.h   
 arch/x86/include/asm/sys_ia32.h 
)
It works, and it is done in many places, but it looks somewhat weird.
Would it make sense to have an asm-generic/compate-time.h instead? Asking for
opinions here.

> 
> The patch also requires an operation similar to:
> 
> git grep "asm/compat\.h" | cut -d ":" -f 1 |  xargs -n 1 sed -i -e "s%asm/compat.h%linux/compat.h%g"

some comments from the s390 perspective:

> --- a/arch/s390/hypfs/hypfs_sprp.c
> +++ b/arch/s390/hypfs/hypfs_sprp.c
ok.
[...]
> --- a/arch/s390/include/asm/elf.h
> +++ b/arch/s390/include/asm/elf.h
> @@ -126,7 +126,7 @@
>   */
> 
>  #include <asm/ptrace.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/syscall.h>
>  #include <asm/user.h>

see above.
[...]
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
ok
> --- a/arch/s390/pci/pci_clp.c
> +++ b/arch/s390/pci/pci_clp.c
ok
> --- a/drivers/s390/block/dasd_ioctl.c
> +++ b/drivers/s390/block/dasd_ioctl.c
ok 
> --- a/drivers/s390/char/fs3270.c
> +++ b/drivers/s390/char/fs3270.c
ok
> --- a/drivers/s390/char/sclp_ctl.c
> +++ b/drivers/s390/char/sclp_ctl.c
ok
> --- a/drivers/s390/char/vmcp.c
> +++ b/drivers/s390/char/vmcp.c
ok
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
ok

> --- a/drivers/s390/net/qeth_core_main.c
> +++ b/drivers/s390/net/qeth_core_main.c
> @@ -32,7 +32,7 @@
>  #include <asm/chpid.h>
>  #include <asm/io.h>
>  #include <asm/sysinfo.h>
> -#include <asm/compat.h>
> +#include <linux/compat.h>
>  #include <asm/diag.h>
>  #include <asm/cio.h>
>  #include <asm/ccwdev.h>

Can you move that into the other includes (where all the other <linux/*> includes are.
