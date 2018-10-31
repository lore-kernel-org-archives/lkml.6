Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DE8C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E8C2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufHi3E7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E8C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbeKAGOs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:14:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:45012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbeKAGOs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:14:48 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DA1D2080A;
        Wed, 31 Oct 2018 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541020500;
        bh=2CsSE2wOvMJY16T9Ez5ZhPq5v9OmyFK3QTFr2DTIeb8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ufHi3E7LQU5UwdbLyu+TMPnYNDNs4DhV982yjqwxH8WYy6SL4VBU6xAVBqdRC5hV6
         UoS7mrWTRTgNxzzaDCyBeaCpnvyPFATyffrlWa+EXGECQ5W0Za6en5qNbvPV63sYSO
         23p7Fz5FrOn4U8EinMrjQyn9IKWOvNhzK63upBcw=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id B1D4A142D18; Wed, 31 Oct 2018 18:14:56 -0300 (-03)
Date:   Wed, 31 Oct 2018 18:14:56 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: arm64 tools build failure wrt smp_load_{acquire,release}
 expansion on gcc version 5.4.0 20160609 (Ubuntu/Linaro
 5.4.0-6ubuntu1~16.04.9)
Message-ID: <20181031211456.GE28340@kernel.org>
References: <20181031154550.GA28340@kernel.org>
 <20181031174408.GA27871@arm.com>
 <50dc7bfe-47de-6837-30e0-4d31dabacd31@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50dc7bfe-47de-6837-30e0-4d31dabacd31@iogearbox.net>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 31, 2018 at 07:08:29PM +0100, Daniel Borkmann escreveu:
> On 10/31/2018 06:44 PM, Will Deacon wrote:
> > Diff below...
 
> I just gave this a spin on 16.04 and it resolves the build issue, thanks
> for the quick fix, Will!
 
> Tested-by: Daniel Borkmann <daniel@iogearbox.net>

It buildz, ship it:

# time dm android-ndk:r12b-arm \
	  android-ndk:r15c-arm \
	  debian:experimental-x-arm64 \
	  ubuntu:14.04.4-x-linaro-arm64 \
	  ubuntu:16.04-x-arm \
	  ubuntu:16.04-x-arm64 \
	  ubuntu:18.04-x-arm \
	  ubuntu:18.04-x-arm64
   1 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   2 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
   3 debian:experimental-x-arm64   : Ok   aarch64-linux-gnu-gcc (Debian 8.2.0-7) 8.2.0
   4 ubuntu:14.04.4-x-linaro-arm64 : Ok   aarch64-linux-gnu-gcc (Linaro GCC 5.5-2017.10) 5.5.0
   5 ubuntu:16.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
   6 ubuntu:16.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 5.4.0-6ubuntu1~16.04.9) 5.4.0 20160609
   7 ubuntu:18.04-x-arm            : Ok   arm-linux-gnueabihf-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
   8 ubuntu:18.04-x-arm64          : Ok   aarch64-linux-gnu-gcc (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04) 7.3.0
#

So I've added it to my tree as below, can I keep it like that?

Thanks,

- Arnaldo

commit 86b21876a75c912917ade1e2b3831501eb2e9e45
Author: Will Deacon <will.deacon@arm.com>
Date:   Wed Oct 31 17:44:08 2018 +0000

    tools headers barrier: Fix arm64 tools build failure wrt smp_load_{acquire,release}
    
    Cheers for reporting this. I managed to reproduce the build failure with
    gcc version 6.3.0 20170516 (Debian 6.3.0-18+deb9u1).
    
    The code in question is the arm64 versions of smp_load_acquire() and
    smp_store_release(). Unlike other architectures, these are not built
    around READ_ONCE() and WRITE_ONCE() since we have instructions we can
    use instead of fences. Bringing our macros up-to-date with those (i.e.
    tweaking the union initialisation and using the special "uXX_alias_t"
    types) appears to fix the issue for me.
    
    Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Signed-off-by: Will Deacon <will.deacon@arm.com>
    Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
    Tested-by: Daniel Borkmann <daniel@iogearbox.net>
    Cc: Peter Zijlstra <peterz@infradead.org>
    Link: http://lkml.kernel.org/r/20181031174408.GA27871@arm.com
    Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/arch/arm64/include/asm/barrier.h b/tools/arch/arm64/include/asm/barrier.h
index 12835ea0e417..378c051fa177 100644
--- a/tools/arch/arm64/include/asm/barrier.h
+++ b/tools/arch/arm64/include/asm/barrier.h
@@ -14,74 +14,75 @@
 #define wmb()		asm volatile("dmb ishst" ::: "memory")
 #define rmb()		asm volatile("dmb ishld" ::: "memory")
 
-#define smp_store_release(p, v)					\
-do {								\
-	union { typeof(*p) __val; char __c[1]; } __u =		\
-		{ .__val = (__force typeof(*p)) (v) }; 		\
-								\
-	switch (sizeof(*p)) {					\
-	case 1:							\
-		asm volatile ("stlrb %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u8 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 2:							\
-		asm volatile ("stlrh %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u16 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 4:							\
-		asm volatile ("stlr %w1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u32 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	case 8:							\
-		asm volatile ("stlr %1, %0"			\
-				: "=Q" (*p)			\
-				: "r" (*(__u64 *)__u.__c)	\
-				: "memory");			\
-		break;						\
-	default:						\
-		/* Only to shut up gcc ... */			\
-		mb();						\
-		break;						\
-	}							\
+#define smp_store_release(p, v)						\
+do {									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__val = (v) }; 					\
+									\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("stlrb %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u8_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 2:								\
+		asm volatile ("stlrh %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u16_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 4:								\
+		asm volatile ("stlr %w1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u32_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	case 8:								\
+		asm volatile ("stlr %1, %0"				\
+				: "=Q" (*p)				\
+				: "r" (*(__u64_alias_t *)__u.__c)	\
+				: "memory");				\
+		break;							\
+	default:							\
+		/* Only to shut up gcc ... */				\
+		mb();							\
+		break;							\
+	}								\
 } while (0)
 
-#define smp_load_acquire(p)					\
-({								\
-	union { typeof(*p) __val; char __c[1]; } __u;		\
-								\
-	switch (sizeof(*p)) {					\
-	case 1:							\
-		asm volatile ("ldarb %w0, %1"			\
-			: "=r" (*(__u8 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 2:							\
-		asm volatile ("ldarh %w0, %1"			\
-			: "=r" (*(__u16 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 4:							\
-		asm volatile ("ldar %w0, %1"			\
-			: "=r" (*(__u32 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	case 8:							\
-		asm volatile ("ldar %0, %1"			\
-			: "=r" (*(__u64 *)__u.__c)		\
-			: "Q" (*p) : "memory");			\
-		break;						\
-	default:						\
-		/* Only to shut up gcc ... */			\
-		mb();						\
-		break;						\
-	}							\
-	__u.__val;						\
+#define smp_load_acquire(p)						\
+({									\
+	union { typeof(*p) __val; char __c[1]; } __u =			\
+		{ .__c = { 0 } };					\
+									\
+	switch (sizeof(*p)) {						\
+	case 1:								\
+		asm volatile ("ldarb %w0, %1"				\
+			: "=r" (*(__u8_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 2:								\
+		asm volatile ("ldarh %w0, %1"				\
+			: "=r" (*(__u16_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 4:								\
+		asm volatile ("ldar %w0, %1"				\
+			: "=r" (*(__u32_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	case 8:								\
+		asm volatile ("ldar %0, %1"				\
+			: "=r" (*(__u64_alias_t *)__u.__c)		\
+			: "Q" (*p) : "memory");				\
+		break;							\
+	default:							\
+		/* Only to shut up gcc ... */				\
+		mb();							\
+		break;							\
+	}								\
+	__u.__val;							\
 })
 
 #endif /* _TOOLS_LINUX_ASM_AARCH64_BARRIER_H */
