Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AH8x224Mbhznzd0nm31q1ofHoakXB6TvM3/SNAOlmvht3gqyv/xUuoBz/MhdzKRKYAQjH/sbtLTL
ARC-Seal: i=1; a=rsa-sha256; t=1519600826; cv=none;
        d=google.com; s=arc-20160816;
        b=GowjEsHDhZhkVEOxyInb+2s4eWQxfuvlT9NTQ19RlSWkk3ZYM4HipAqSZSJ+fhilXq
         Wa1eHSQJplb8lOiXqGY5E78r6l1Ez6kniI++TFlb9ZDBfrUmnJVOxtNh+unTeYJ80gqU
         pxEd4DDLUuiZNeZ/zPGwoLIQZ9r29Bso2lK6Wuuu62vzJ1Z8+ScSdu8c+A2h+ApzxfXw
         ALUEGRXaqIwH8/JZCgv0QjDOpBRxjmnK0JGZpSFOUZoFzWeCu5r2uP6oBX9/9fOH0GHa
         jBgBJuKhfMKTdeQaSA+MmoqNZOEhwk9YEI3TrjZL3I2JmCf1nEIizBpzrNXQuSbUm55K
         SA7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=rT9JAoheoumWRHXvDY+WOpTCqMbHkmmY9oWyJ0RolDA=;
        b=AXlXBZYIBlLE30hFIK+TLcHNfWlwwSpdgsf1Q8vF9McA1JCWf0sFgVz2dMGWlkE9Nz
         H8e0mRFET92a7mst9OFG7NMHZFLAQZsg894hRvHjn5IQC3RyCzBFL468X2kZpIz3Zfbp
         sZ+KVwlI7Ns9jhU3DJbwYd2R9BqTSzffZbxY2cPqtshciDflvFS21Z9Fmxby622twyFe
         GOjFnTaHmF/udMP7ZTbNdvEHYbvXHvJdUjNbszRa3AYHVs5CzFpGlQA4s5qPZv46zZ8H
         hP0KK3otoYkGnQbMD6KKuF0DdGwRFOr5UP15cWOcVKLQU7la+MhcE1Haz6R0AMTV6pUU
         8INA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=pzb4QiwR;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@gmail.com header.s=20161025 header.b=pzb4QiwR;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbeBYXUK (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Sun, 25 Feb 2018 18:20:10 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37923 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751738AbeBYXUE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Feb 2018 18:20:04 -0500
Date: Mon, 26 Feb 2018 10:19:51 +1100
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: shuahkh@osg.samsung.com, linux-kselftest@vger.kernel.org,
        mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
        ebiederm@xmission.com, arnd@arndb.de
Subject: Re: [PATCH v12 22/22] selftests/vm: Fix deadlock in
 protection_keys.c
Message-ID: <20180226101951.0136f963@balbir.ozlabs.ibm.com>
In-Reply-To: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
        <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064461610258751?=
X-GMAIL-MSGID: =?utf-8?q?1593416956218725895?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 21 Feb 2018 17:55:41 -0800
Ram Pai <linuxram@us.ibm.com> wrote:

> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> The sig_chld() handler calls dprintf2() taking care of setting
> dprint_in_signal so that sigsafe_printf() won't call printf().
> Unfortunately, this precaution is is negated by dprintf_level(), which
> has a call to fflush().
>

fflush() is not the signal-safe function list, so this makes sense.
I wonder if fflush() is needed in sigsafe_printf()?

How about?

diff --git a/tools/testing/selftests/x86/pkey-helpers.h b/tools/testing/selftests/x86/pkey-helpers.h
index b3cb7670e026..2c3b39851f10 100644
--- a/tools/testing/selftests/x86/pkey-helpers.h
+++ b/tools/testing/selftests/x86/pkey-helpers.h
@@ -29,6 +29,7 @@ static inline void sigsafe_printf(const char *format, ...)
 	va_start(ap, format);
 	if (!dprint_in_signal) {
 		vprintf(format, ap);
+		fflush(NULL);				\
 	} else {
 		int ret;
 		int len = vsnprintf(dprint_in_signal_buffer,
@@ -49,7 +50,6 @@ static inline void sigsafe_printf(const char *format, ...)
 #define dprintf_level(level, args...) do {	\
 	if (level <= DEBUG_LEVEL)		\
 		sigsafe_printf(args);		\
-	fflush(NULL);				\
 } while (0)
 #define dprintf0(args...) dprintf_level(0, args)
 #define dprintf1(args...) dprintf_level(1, args)


But both are equivalent I guess, so
Acked-by: Balbir Singh <bsingharora@gmail.com>
