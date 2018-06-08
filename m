Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id kQiHHnXYGVtHZwAAmS7hNA
	; Fri, 08 Jun 2018 01:14:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 435726074D; Fri,  8 Jun 2018 01:14:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2wjFIWl"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9A312606DD;
	Fri,  8 Jun 2018 01:14:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9A312606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeFHBOu (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:14:50 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44413 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFHBOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:14:48 -0400
Received: by mail-pl0-f68.google.com with SMTP id z9-v6so7220420plk.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NvpdvWWl9NKgZXlIdVT4KAUy/PGBGXuULRfhkwMXiWQ=;
        b=b2wjFIWl4qS/Zq6893u9c7KL4//IPUyIaYcauBIsYweMBOy2DNutXDEKUSt4kvY8SX
         gmxdciqh8FvVoJLWQj7tRxHq19TmiUBaqWa9cOjdQVsZSIIoFaxIM41cdJltfd+YLLbs
         zV7njREg5tFdUnbW6uH/AwsSIZn+Of3dUv6QP0qL/0Qfj/Rwl8fxpPNEZVgF4wtEokU7
         bme/l+w/FNWGO+9/+/I4i5UUYDd3it/mXj3qpN2j+IDjbJnZlCgnjKJvHDqAlxX2e+jN
         Utp9KGh+PRSOmUmtEkBElTSh9+NHVezsOgG+SKYrk4HZ70rMwL63ZoqR8LIPGq94DmwQ
         7XQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NvpdvWWl9NKgZXlIdVT4KAUy/PGBGXuULRfhkwMXiWQ=;
        b=t2aOqpqAOnDwh1QrSnlgjDDO7x4zkqQ9SdURfT5nlJsww3kiTM52WiYk/zH5xiu2AJ
         YKpemQsdr5ga4GSAsffY9dJdv6kIaQH73x2pWLIpYUuSq/FhQ85IPo2BO8pTFF3ayQfa
         tvbV1Z1OBOcGqTrKQ5CCf5+YrPWpzlXE1n86yTYH0sWaIQ4R3ycvT/6gjc5ZGToqCOgj
         K6XqEJIRwTd0Gg4LaJ0muBEh5xccLyEo6KMRpFvPeT8nmMIFKrnti2KWUuHPViUB1Oq8
         z8d33gQuxArK4P0v+qPVnwzL7ObJGufrTu5lezbhxRupGmhCzmR21rF6H3LI2CknUzOE
         2lpQ==
X-Gm-Message-State: APt69E1BuokgcXPlnAutJdkHH8fk1Rhq/5bgmjkX/00ngy5kltPMPn6P
        GiQbKk02U3GuUfsTjZepLXZjOyxTs54=
X-Google-Smtp-Source: ADUXVKJjNRPNqxcsYny8ghuCBYNi8Z9cHvDq7AT1eGwJZAArMggE2SgqCAFhX9o64QDKR1AAreS3mA==
X-Received: by 2002:a17:902:8a82:: with SMTP id p2-v6mr4281145plo.244.1528420487574;
        Thu, 07 Jun 2018 18:14:47 -0700 (PDT)
Received: from jchowdhary0.mtv.corp.google.com ([2620:0:1000:1612:de71:f59c:9968:92ba])
        by smtp.gmail.com with ESMTPSA id n10-v6sm24941664pfb.27.2018.06.07.18.14.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 18:14:46 -0700 (PDT)
Subject: Re: [PATCH] uapi: Make generic uapi headers compile standalone.
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel-team@android.com,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
References: <20180606231602.231326-1-jchowdhary@google.com>
 <CAK7LNAR+P68OrNfhkY3p05mqrr3OMb53DQNMR01_WRP79gW_bQ@mail.gmail.com>
From: Jayant Chowdhary <jchowdhary@google.com>
Message-ID: <eb5585b7-d301-73e0-aad5-d56b1654e977@google.com>
Date: Thu, 7 Jun 2018 18:14:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR+P68OrNfhkY3p05mqrr3OMb53DQNMR01_WRP79gW_bQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 06/06/2018 09:58 PM, Masahiro Yamada wrote:
> Hi.
> 
> 
> 2018-06-07 8:16 GMT+09:00 Jayant Chowdhary <jchowdhary@google.com>:
>> In order for static analysis tools to analyze each of the uapi headers,
>> we need to enable them to compile stand-alone. Some uapi headers were
>> missing dependencies which would not make them compile stand-alone in
>> user-land. This patch adds those dependencies.
>>
>> Test: make defconfig; make -j64
>>
>> Test: make ARCH=arm64 defconfig;
>>       ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make -j64  all
>>
>> Test: ran header-abi-dumper[1] on all the affected headers with
>>       appropriate include paths[2] for arm64. eg: for drm_fourcc.h,
>>
>> $HEADER_ABI_DUMPER -o drm_fourcc.h.sdump \
>> include/uapi/drm/drm_fourcc.h -- -target aarch64-linux-android -std=gnu99 \
>> -isystem $CLANG_INCLUDE_PATH \
>> -I include/uapi/ -I arch/arm64/include/generated/uapi \
>> -I arch/arm64/include/uapi -I private-compiler-headers
>> -I include/generated/uapi \
>> -I include/uapi/../../arch/arm/include/uapi
> 
> 
> First of all, is this check sensible?
> 
> scripts/headers_install.sh manipulates exported headers.
> 
> So, shouldn't you do this check after "make headers_install"?
> 
> 

Apologies, I was unaware of this. Now it is obvious that this check is not
sensible :) The headers which should be checked are the ones 'make headers
install' produces and not the ones being checked currently. I'll fix this in the
next version of this patch.

> 
> You are adding around <linux/compiler.h> to various UAPI headers.
> Could you tell me why it was added?
> 
> The tool rips off <linux/compiler.h> anyway when exporting UAPI headers:
> https://github.com/torvalds/linux/blob/v4.17/scripts/headers_install.sh#L37
> 
> 

I had added these to satisfy the defines included from <linux/compiler.h>,
however, since headers_install.sh removes the #includes and the defines
themselves, these additions should not be needed.

> 
> 
> Also, you are adding <stdint.h> to several headers.
> Please do not pull it in to the kernel space.
> The kernel space defines fixed-width types in its headers.
> 
> For example, you added <stdint.h> to include/uapi/scsi/scsi_netlink.h
> 
> In my opinion, the correct fix is to replace uint8_t with __u8 or __uint8_t.
> 
> 

Sure, I will correct this.

Thanks,
Jayant
> 
> 
> 
> 
>> where
>> HEADER_ABI_DUMPER=\
>> $ANDROID_BUILD_TOP/prebuilts/clang-tools/linux-x86/bin/header-abi-dumper
>>
>> CLANG_INCLUDE_PATH=\
>> $ANDROID_BUILD_TOP/prebuilts/clang/host/linux-x86/clang-3289846/bin/../lib64/clang/3.8/include
>>
>> on a lunched aosp tree [3]
>>
>> [1]
>> header-abi-dumper is a clang based static analysis tool, used by android's build
>> system which parses a C/C++ source file and emits information about the data
>> types included in the source. More information can be found at
>> https://android.googlesource.com/platform/development/+/master/vndk/tools/header-checker/README.md
>>
>> [2]
>> Some  headers, eg: compiler_types.h, compiler.h, sys/socket.h are not in the
>> set of uapi headers, even though they are included by uapi headers(
>> include/uapi/linux/types.h, include/uapi/asm-generic/signal-defs.h etc). The
>> 'private-compiler-headers' in the test clause was included with private copies
>> of these headers. libc distributions (eg: bionic) often have their
>> copies of these headers as well.
>>
>> [3]
>> https://source.android.com/setup/build/downloading
>>
>> Cc: akpm@linux-foundation.org
>> Cc: kernel-team@android.com
>> Cc: linux-kbuild@vger.kernel.org
>> Signed-off-by: Jayant Chowdhary <jchowdhary@google.com>
>> ---
>>  include/uapi/asm-generic/ipcbuf.h              | 2 ++
>>  include/uapi/asm-generic/msgbuf.h              | 3 +++
>>  include/uapi/asm-generic/sembuf.h              | 2 ++
>>  include/uapi/asm-generic/shmbuf.h              | 2 ++
>>  include/uapi/asm-generic/ucontext.h            | 5 +++++
>>  include/uapi/linux/agpgart.h                   | 1 -
>>  include/uapi/linux/android/binder.h            | 1 +
>>  include/uapi/linux/chio.h                      | 6 ++++++
>>  include/uapi/linux/coda_psdev.h                | 1 +
>>  include/uapi/linux/dvb/dmx.h                   | 3 ---
>>  include/uapi/linux/dvb/video.h                 | 3 ---
>>  include/uapi/linux/errqueue.h                  | 1 +
>>  include/uapi/linux/kexec.h                     | 1 +
>>  include/uapi/linux/kfd_ioctl.h                 | 1 +
>>  include/uapi/linux/lightnvm.h                  | 1 -
>>  include/uapi/linux/ndctl.h                     | 1 +
>>  include/uapi/linux/netfilter_bridge/ebtables.h | 1 +
>>  include/uapi/linux/nfs4_mount.h                | 3 +++
>>  include/uapi/linux/psp-sev.h                   | 1 +
>>  include/uapi/linux/scc.h                       | 2 +-
>>  include/uapi/linux/sctp.h                      | 3 +++
>>  include/uapi/linux/sdla.h                      | 2 ++
>>  include/uapi/linux/socket.h                    | 4 ++++
>>  include/uapi/linux/stddef.h                    | 5 +++++
>>  include/uapi/linux/sysctl.h                    | 1 +
>>  include/uapi/linux/types.h                     | 1 +
>>  include/uapi/linux/vbox_vmmdev_types.h         | 1 +
>>  include/uapi/linux/vboxguest.h                 | 1 +
>>  include/uapi/rdma/hfi/hfi1_user.h              | 1 +
>>  include/uapi/scsi/scsi_bsg_fc.h                | 2 ++
>>  include/uapi/scsi/scsi_netlink.h               | 1 +
>>  include/uapi/sound/asound.h                    | 2 +-
>>  32 files changed, 55 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/uapi/asm-generic/ipcbuf.h b/include/uapi/asm-generic/ipcbuf.h
>> index 7d80dbd336fb..41a01b494fc7 100644
>> --- a/include/uapi/asm-generic/ipcbuf.h
>> +++ b/include/uapi/asm-generic/ipcbuf.h
>> @@ -2,6 +2,8 @@
>>  #ifndef __ASM_GENERIC_IPCBUF_H
>>  #define __ASM_GENERIC_IPCBUF_H
>>
>> +#include <linux/posix_types.h>
>> +
>>  /*
>>   * The generic ipc64_perm structure:
>>   * Note extra padding because this structure is passed back and forth
>> diff --git a/include/uapi/asm-generic/msgbuf.h b/include/uapi/asm-generic/msgbuf.h
>> index fb306ebdb36f..8cdd7ca75df6 100644
>> --- a/include/uapi/asm-generic/msgbuf.h
>> +++ b/include/uapi/asm-generic/msgbuf.h
>> @@ -3,6 +3,9 @@
>>  #define __ASM_GENERIC_MSGBUF_H
>>
>>  #include <asm/bitsperlong.h>
>> +#include <asm-generic/ipcbuf.h>
>> +#include <linux/posix_types.h>
>> +
>>  /*
>>   * generic msqid64_ds structure.
>>   *
>> diff --git a/include/uapi/asm-generic/sembuf.h b/include/uapi/asm-generic/sembuf.h
>> index cbf9cfe977d6..7f37edb95d9f 100644
>> --- a/include/uapi/asm-generic/sembuf.h
>> +++ b/include/uapi/asm-generic/sembuf.h
>> @@ -3,6 +3,8 @@
>>  #define __ASM_GENERIC_SEMBUF_H
>>
>>  #include <asm/bitsperlong.h>
>> +#include <asm-generic/ipcbuf.h>
>> +#include <linux/posix_types.h>
>>
>>  /*
>>   * The semid64_ds structure for x86 architecture.
>> diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
>> index 2b6c3bb97f97..1c5e7165fca5 100644
>> --- a/include/uapi/asm-generic/shmbuf.h
>> +++ b/include/uapi/asm-generic/shmbuf.h
>> @@ -3,6 +3,8 @@
>>  #define __ASM_GENERIC_SHMBUF_H
>>
>>  #include <asm/bitsperlong.h>
>> +#include <asm-generic/ipcbuf.h>
>> +#include <stddef.h>
>>
>>  /*
>>   * The shmid64_ds structure for x86 architecture.
>> diff --git a/include/uapi/asm-generic/ucontext.h b/include/uapi/asm-generic/ucontext.h
>> index 351868a72168..19199f45c523 100644
>> --- a/include/uapi/asm-generic/ucontext.h
>> +++ b/include/uapi/asm-generic/ucontext.h
>> @@ -2,6 +2,11 @@
>>  #ifndef __ASM_GENERIC_UCONTEXT_H
>>  #define __ASM_GENERIC_UCONTEXT_H
>>
>> +#ifndef __KERNEL__
>> +#include <asm-generic/signal.h>
>> +#include <asm/sigcontext.h>
>> +#endif
>> +
>>  struct ucontext {
>>         unsigned long     uc_flags;
>>         struct ucontext  *uc_link;
>> diff --git a/include/uapi/linux/agpgart.h b/include/uapi/linux/agpgart.h
>> index f5251045181a..4e828cf487bc 100644
>> --- a/include/uapi/linux/agpgart.h
>> +++ b/include/uapi/linux/agpgart.h
>> @@ -52,7 +52,6 @@
>>
>>  #ifndef __KERNEL__
>>  #include <linux/types.h>
>> -#include <stdlib.h>
>>
>>  struct agp_version {
>>         __u16 major;
>> diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
>> index bfaec6903b8b..fd6de2203057 100644
>> --- a/include/uapi/linux/android/binder.h
>> +++ b/include/uapi/linux/android/binder.h
>> @@ -23,6 +23,7 @@
>>
>>  #include <linux/types.h>
>>  #include <linux/ioctl.h>
>> +#include <sys/types.h>
>>
>>  #define B_PACK_CHARS(c1, c2, c3, c4) \
>>         ((((c1)<<24)) | (((c2)<<16)) | (((c3)<<8)) | (c4))
>> diff --git a/include/uapi/linux/chio.h b/include/uapi/linux/chio.h
>> index 689fc93fafda..5e63753a0d53 100644
>> --- a/include/uapi/linux/chio.h
>> +++ b/include/uapi/linux/chio.h
>> @@ -3,6 +3,11 @@
>>   * ioctl interface for the scsi media changer driver
>>   */
>>
>> +#ifndef _UAPI_CHIO_H
>> +#define _UAPI_CHIO_H
>> +
>> +#include <linux/compiler.h>
>> +
>>  /* changer element types */
>>  #define CHET_MT   0    /* media transport element (robot) */
>>  #define CHET_ST   1    /* storage element (media slots) */
>> @@ -167,3 +172,4 @@ struct changer_set_voltag {
>>   * c-basic-offset: 8
>>   * End:
>>   */
>> +#endif
>> diff --git a/include/uapi/linux/coda_psdev.h b/include/uapi/linux/coda_psdev.h
>> index aa6623efd2dd..31b1867021b7 100644
>> --- a/include/uapi/linux/coda_psdev.h
>> +++ b/include/uapi/linux/coda_psdev.h
>> @@ -3,6 +3,7 @@
>>  #define _UAPI__CODA_PSDEV_H
>>
>>  #include <linux/magic.h>
>> +#include <sys/types.h>
>>
>>  #define CODA_PSDEV_MAJOR 67
>>  #define MAX_CODADEVS  5           /* how many do we allow */
>> diff --git a/include/uapi/linux/dvb/dmx.h b/include/uapi/linux/dvb/dmx.h
>> index b4112f0b6dd3..ce30e9f6145a 100644
>> --- a/include/uapi/linux/dvb/dmx.h
>> +++ b/include/uapi/linux/dvb/dmx.h
>> @@ -26,9 +26,6 @@
>>  #define _UAPI_DVBDMX_H_
>>
>>  #include <linux/types.h>
>> -#ifndef __KERNEL__
>> -#include <time.h>
>> -#endif
>>
>>
>>  #define DMX_FILTER_SIZE 16
>> diff --git a/include/uapi/linux/dvb/video.h b/include/uapi/linux/dvb/video.h
>> index df3d7028c807..8f3a485b9988 100644
>> --- a/include/uapi/linux/dvb/video.h
>> +++ b/include/uapi/linux/dvb/video.h
>> @@ -26,9 +26,6 @@
>>  #define _UAPI_DVBVIDEO_H_
>>
>>  #include <linux/types.h>
>> -#ifndef __KERNEL__
>> -#include <time.h>
>> -#endif
>>
>>  typedef enum {
>>         VIDEO_FORMAT_4_3,     /* Select 4:3 format */
>> diff --git a/include/uapi/linux/errqueue.h b/include/uapi/linux/errqueue.h
>> index dc64cfaf13da..ad2421e3d613 100644
>> --- a/include/uapi/linux/errqueue.h
>> +++ b/include/uapi/linux/errqueue.h
>> @@ -2,6 +2,7 @@
>>  #ifndef _UAPI_LINUX_ERRQUEUE_H
>>  #define _UAPI_LINUX_ERRQUEUE_H
>>
>> +#include <linux/time.h>
>>  #include <linux/types.h>
>>
>>  struct sock_extended_err {
>> diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
>> index 6d112868272d..49d50d469723 100644
>> --- a/include/uapi/linux/kexec.h
>> +++ b/include/uapi/linux/kexec.h
>> @@ -8,6 +8,7 @@
>>   */
>>
>>  #include <linux/types.h>
>> +#include <stddef.h>
>>
>>  /* kexec flags for different usage scenarios */
>>  #define KEXEC_ON_CRASH         0x00000001
>> diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
>> index b4f5073dbac2..4a882a133b69 100644
>> --- a/include/uapi/linux/kfd_ioctl.h
>> +++ b/include/uapi/linux/kfd_ioctl.h
>> @@ -25,6 +25,7 @@
>>
>>  #include <drm/drm.h>
>>  #include <linux/ioctl.h>
>> +#include <stdint.h>
>>
>>  #define KFD_IOCTL_MAJOR_VERSION 1
>>  #define KFD_IOCTL_MINOR_VERSION 1
>> diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
>> index f9a1be7fc696..af28d32b0ac3 100644
>> --- a/include/uapi/linux/lightnvm.h
>> +++ b/include/uapi/linux/lightnvm.h
>> @@ -24,7 +24,6 @@
>>  #include <linux/kernel.h>
>>  #include <linux/ioctl.h>
>>  #else /* __KERNEL__ */
>> -#include <stdio.h>
>>  #include <sys/ioctl.h>
>>  #define DISK_NAME_LEN 32
>>  #endif /* __KERNEL__ */
>> diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
>> index 7e27070b9440..a89a294e5ca5 100644
>> --- a/include/uapi/linux/ndctl.h
>> +++ b/include/uapi/linux/ndctl.h
>> @@ -13,6 +13,7 @@
>>  #ifndef __NDCTL_H__
>>  #define __NDCTL_H__
>>
>> +#include <linux/compiler.h>
>>  #include <linux/types.h>
>>
>>  struct nd_cmd_dimm_flags {
>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
>> index 0c7dc8315013..c57850b90b50 100644
>> --- a/include/uapi/linux/netfilter_bridge/ebtables.h
>> +++ b/include/uapi/linux/netfilter_bridge/ebtables.h
>> @@ -16,6 +16,7 @@
>>  #include <linux/types.h>
>>  #include <linux/if.h>
>>  #include <linux/netfilter_bridge.h>
>> +#include <stdint.h>
>>
>>  #define EBT_TABLE_MAXNAMELEN 32
>>  #define EBT_CHAIN_MAXNAMELEN EBT_TABLE_MAXNAMELEN
>> diff --git a/include/uapi/linux/nfs4_mount.h b/include/uapi/linux/nfs4_mount.h
>> index d20bb869bb99..6c9792073b19 100644
>> --- a/include/uapi/linux/nfs4_mount.h
>> +++ b/include/uapi/linux/nfs4_mount.h
>> @@ -19,6 +19,9 @@
>>   */
>>  #define NFS4_MOUNT_VERSION     1
>>
>> +#include <linux/socket.h> /* for struct sockaddr. */
>> +#include <linux/compiler.h>
>> +
>>  struct nfs_string {
>>         unsigned int len;
>>         const char __user * data;
>> diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
>> index 9008f31c7eb6..c796f1b194a3 100644
>> --- a/include/uapi/linux/psp-sev.h
>> +++ b/include/uapi/linux/psp-sev.h
>> @@ -18,6 +18,7 @@
>>  #define __PSP_SEV_USER_H__
>>
>>  #include <linux/types.h>
>> +#include <linux/compiler.h>
>>
>>  /**
>>   * SEV platform commands
>> diff --git a/include/uapi/linux/scc.h b/include/uapi/linux/scc.h
>> index c5bc7f747755..9122d48a4227 100644
>> --- a/include/uapi/linux/scc.h
>> +++ b/include/uapi/linux/scc.h
>> @@ -4,7 +4,7 @@
>>  #ifndef _UAPI_SCC_H
>>  #define _UAPI_SCC_H
>>
>> -
>> +#include <linux/sockios.h>
>>  /* selection of hardware types */
>>
>>  #define PA0HZP         0x00    /* hardware type for PA0HZP SCC card and compatible */
>> diff --git a/include/uapi/linux/sctp.h b/include/uapi/linux/sctp.h
>> index b64d583bf053..de4675d92e9f 100644
>> --- a/include/uapi/linux/sctp.h
>> +++ b/include/uapi/linux/sctp.h
>> @@ -56,6 +56,9 @@
>>
>>  #include <linux/types.h>
>>  #include <linux/socket.h>
>> +#ifndef __KERNEL__
>> +#include <stdint.h>
>> +#endif
>>
>>  typedef __s32 sctp_assoc_t;
>>
>> diff --git a/include/uapi/linux/sdla.h b/include/uapi/linux/sdla.h
>> index 1e3735be6511..2a0dc687aa49 100644
>> --- a/include/uapi/linux/sdla.h
>> +++ b/include/uapi/linux/sdla.h
>> @@ -24,6 +24,8 @@
>>  #ifndef _UAPISDLA_H
>>  #define _UAPISDLA_H
>>
>> +#include <linux/compiler.h>
>> +
>>  /* adapter type */
>>  #define SDLA_TYPES
>>  #define SDLA_S502A                     5020
>> diff --git a/include/uapi/linux/socket.h b/include/uapi/linux/socket.h
>> index 8eb96021709c..51c11f6b26e6 100644
>> --- a/include/uapi/linux/socket.h
>> +++ b/include/uapi/linux/socket.h
>> @@ -11,6 +11,10 @@
>>
>>  typedef unsigned short __kernel_sa_family_t;
>>
>> +#ifndef __KERNEL__
>> +#include <sys/socket.h>                        /* for struct sockaddr.         */
>> +#endif
>> +
>>  struct __kernel_sockaddr_storage {
>>         __kernel_sa_family_t    ss_family;              /* address family */
>>         /* Following field(s) are implementation specific */
>> diff --git a/include/uapi/linux/stddef.h b/include/uapi/linux/stddef.h
>> index ee8220f8dcf5..c949a6836417 100644
>> --- a/include/uapi/linux/stddef.h
>> +++ b/include/uapi/linux/stddef.h
>> @@ -1,6 +1,11 @@
>>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> +#ifndef __UAPI_STDDEF_H__
>> +#define __UAPI_STDDEF_H__
>> +
>>  #include <linux/compiler_types.h>
>>
>>  #ifndef __always_inline
>>  #define __always_inline inline
>>  #endif
>> +
>> +#endif // __UAPI_STDDEF_H__
>> diff --git a/include/uapi/linux/sysctl.h b/include/uapi/linux/sysctl.h
>> index 6b58371b1f0d..fac6c1c7def2 100644
>> --- a/include/uapi/linux/sysctl.h
>> +++ b/include/uapi/linux/sysctl.h
>> @@ -26,6 +26,7 @@
>>  #include <linux/kernel.h>
>>  #include <linux/types.h>
>>  #include <linux/compiler.h>
>> +#include <stddef.h>
>>
>>  #define CTL_MAXNAME 10         /* how many path components do we allow in a
>>                                    call to sysctl?   In other words, what is
>> diff --git a/include/uapi/linux/types.h b/include/uapi/linux/types.h
>> index cd4f0b897a48..d61eb82432be 100644
>> --- a/include/uapi/linux/types.h
>> +++ b/include/uapi/linux/types.h
>> @@ -11,6 +11,7 @@
>>  #endif /* __EXPORTED_HEADERS__ */
>>  #endif
>>
>> +#include <linux/compiler_types.h>
>>  #include <linux/posix_types.h>
>>
>>
>> diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
>> index 0e68024f36c7..26d0e69f6fdc 100644
>> --- a/include/uapi/linux/vbox_vmmdev_types.h
>> +++ b/include/uapi/linux/vbox_vmmdev_types.h
>> @@ -11,6 +11,7 @@
>>
>>  #include <asm/bitsperlong.h>
>>  #include <linux/types.h>
>> +#include <linux/compiler.h>
>>
>>  /*
>>   * We cannot use linux' compiletime_assert here because it expects to be used
>> diff --git a/include/uapi/linux/vboxguest.h b/include/uapi/linux/vboxguest.h
>> index 612f0c7d3558..44606c96f830 100644
>> --- a/include/uapi/linux/vboxguest.h
>> +++ b/include/uapi/linux/vboxguest.h
>> @@ -9,6 +9,7 @@
>>  #define __UAPI_VBOXGUEST_H__
>>
>>  #include <asm/bitsperlong.h>
>> +#include <linux/compiler.h>
>>  #include <linux/ioctl.h>
>>  #include <linux/vbox_err.h>
>>  #include <linux/vbox_vmmdev_types.h>
>> diff --git a/include/uapi/rdma/hfi/hfi1_user.h b/include/uapi/rdma/hfi/hfi1_user.h
>> index c6a984c0c881..6f5e461b8015 100644
>> --- a/include/uapi/rdma/hfi/hfi1_user.h
>> +++ b/include/uapi/rdma/hfi/hfi1_user.h
>> @@ -58,6 +58,7 @@
>>  #define _LINUX__HFI1_USER_H
>>
>>  #include <linux/types.h>
>> +#include <linux/compiler.h>
>>  #include <rdma/rdma_user_ioctl.h>
>>
>>  /*
>> diff --git a/include/uapi/scsi/scsi_bsg_fc.h b/include/uapi/scsi/scsi_bsg_fc.h
>> index 62597d86beed..23971d00c46d 100644
>> --- a/include/uapi/scsi/scsi_bsg_fc.h
>> +++ b/include/uapi/scsi/scsi_bsg_fc.h
>> @@ -23,6 +23,8 @@
>>  #ifndef SCSI_BSG_FC_H
>>  #define SCSI_BSG_FC_H
>>
>> +#include <stdint.h>
>> +
>>  /*
>>   * This file intended to be included by both kernel and user space
>>   */
>> diff --git a/include/uapi/scsi/scsi_netlink.h b/include/uapi/scsi/scsi_netlink.h
>> index 5ccc2333acab..37d39eb671cc 100644
>> --- a/include/uapi/scsi/scsi_netlink.h
>> +++ b/include/uapi/scsi/scsi_netlink.h
>> @@ -25,6 +25,7 @@
>>
>>  #include <linux/netlink.h>
>>  #include <linux/types.h>
>> +#include <stdint.h>
>>
>>  /*
>>   * This file intended to be included by both kernel and user space
>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index ed0a120d4f08..b569f0eb3a7f 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -31,7 +31,7 @@
>>  #endif
>>
>>  #ifndef __KERNEL__
>> -#include <stdlib.h>
>> +#include<linux/time.h>
>>  #endif
>>
>>  /*
>> --
>> 2.17.1.1185.g55be947832-goog
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
