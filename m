Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AB8JxZrQG2fDfab5fhD8N5ypLFOGrHnAnG11Fu9QUYxscGH5yu2zYyaS1hhU/fOojtI0MPwPvijB
ARC-Seal: i=1; a=rsa-sha256; t=1526350988; cv=none;
        d=google.com; s=arc-20160816;
        b=kpvYE831ezCTR/LRPRGi8QVKHjW25dym1E44NyNCPlKZgvLFmP0FxPhhP8sD9OOGqg
         /zpB2L/UHz1851URHFgGN9paH4f9q4IbimW5uA5chlMvkS+UmbUlTHnp1kdoi6isCOkB
         ccIhF8XlUvMdB0MXMwje0atEqWnx2MxOsH7ewiXr8ygg6UVZMtH+/gGQHQsIJruHsYRT
         fwCfGYZyAzBQtunxdxz21cuE2x848T7n32TsXXpkrC7S7s7cBucrGOT59DiScRPWzR0l
         dwB6VY8qvuKLx8YmXtjVB0Wqcn1/d/RSVoOYerD4jzVJgeuJZ+X1fjPuTPJ2kPUMRDMt
         EGVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=Sopz2SQ/67frl+VX6vVEx6isSbUml3jI6cptuWRJgKU=;
        b=FVhQgWfm93SoV8C38RqWQOrUuArATiXRthuvQSRhAAp0K08H6XGxxsQHHpniHj7BdF
         FwUDE6B+mFEmt9gEN8qLHTB8cQy4rUWAcF7oIIvTGpiy1ZbZ4DgAekPKeO9dvIHt8wgL
         s9ABN5CYjQhsg6f1S8l5ILWzcJ+nPBUrDAcLm9tY0qL+9sMxS/UIPxdgSDDJVimSSjbb
         30sYi4NMpe5HceDa9PapqsXBAIFznYxr68C7X94Ux5IESZI9E98TGWfGuhzxgf7+ELTz
         Bwi0yEhthpJmXQc3ZhsT2riV3iV283NpnF9Sgg21WpKj2yepdw3JOpbMQr3bPfFMw9vV
         QrLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JbI3O8J6;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=JbI3O8J6;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.79 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com w4F2M8PJ020933
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Lihao Liang <lianglihao@huawei.com>, linux-kernel@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pekka Enberg <penberg@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 3/3] types: use fixed width types without double-underscore prefix
Date: Tue, 15 May 2018 11:22:05 +0900
Message-Id: <1526350925-14922-3-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
References: <1526350925-14922-1-git-send-email-yamada.masahiro@socionext.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600495013490118173?=
X-GMAIL-MSGID: =?utf-8?q?1600495013490118173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This header file is not exported.  It is safe to reference types
without double-underscore prefix.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/linux/types.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/linux/types.h b/include/linux/types.h
index be15897..9834e90 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -10,14 +10,14 @@
 #define DECLARE_BITMAP(name,bits) \
 	unsigned long name[BITS_TO_LONGS(bits)]
 
-typedef __u32 __kernel_dev_t;
+typedef u32 __kernel_dev_t;
 
 typedef __kernel_fd_set		fd_set;
 typedef __kernel_dev_t		dev_t;
 typedef __kernel_ino_t		ino_t;
 typedef __kernel_mode_t		mode_t;
 typedef unsigned short		umode_t;
-typedef __u32			nlink_t;
+typedef u32			nlink_t;
 typedef __kernel_off_t		off_t;
 typedef __kernel_pid_t		pid_t;
 typedef __kernel_daddr_t	daddr_t;
@@ -95,23 +95,23 @@ typedef unsigned long		ulong;
 #ifndef __BIT_TYPES_DEFINED__
 #define __BIT_TYPES_DEFINED__
 
-typedef		__u8		u_int8_t;
-typedef		__s8		int8_t;
-typedef		__u16		u_int16_t;
-typedef		__s16		int16_t;
-typedef		__u32		u_int32_t;
-typedef		__s32		int32_t;
+typedef u8			u_int8_t;
+typedef s8			int8_t;
+typedef u16			u_int16_t;
+typedef s16			int16_t;
+typedef u32			u_int32_t;
+typedef s32			int32_t;
 
 #endif /* !(__BIT_TYPES_DEFINED__) */
 
-typedef		__u8		uint8_t;
-typedef		__u16		uint16_t;
-typedef		__u32		uint32_t;
+typedef u8			uint8_t;
+typedef u16			uint16_t;
+typedef u32			uint32_t;
 
 #if defined(__GNUC__)
-typedef		__u64		uint64_t;
-typedef		__u64		u_int64_t;
-typedef		__s64		int64_t;
+typedef u64			uint64_t;
+typedef u64			u_int64_t;
+typedef s64			int64_t;
 #endif
 
 /* this is a special 64bit data type that is 8-byte aligned */
-- 
2.7.4
