Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52842C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6C0125FFC
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="l9DCRP+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6C0125FFC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=efficios.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964879AbeFYSKN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:10:13 -0400
Received: from mail.efficios.com ([167.114.142.138]:53990 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933990AbeFYSKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:10:12 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 5DAF71C2C34;
        Mon, 25 Jun 2018 14:10:11 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id M_baklF6yqF3; Mon, 25 Jun 2018 14:10:10 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B64D81C2C31;
        Mon, 25 Jun 2018 14:10:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B64D81C2C31
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1529950210;
        bh=CB7yFnDG6eH60Hxcx8Ee25ITsW8xCkrtpUFF1WSD7G4=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=l9DCRP+RaxuQ41GHTfLytl1PyKgaa82+hekGpM3lKTe8I5kev3GF11oARmXDyFcwr
         7jQF8tYWHZAjciHWC49zVnNXp8stPkeY8FpG4gxzQ0a+mnzW68Y/fwigK0jRLtWaWr
         CnkLSqGU/tbyhnxAMHmM5YKq1M8Ln4fmGS7nevi5Rt8V0xn74OqRuZ2BtmSIydRadD
         DAZ/OSzOP4B/OAv8t0Omf33bZ8yrfQrLYE3FtrBJa7CPbBYRLuV4SxDpFo4QktzCTN
         6ax7WTYj5yTIxqUp8YEIDSi6feRVy+8KzKgfjvetD39zEy0/2jIsmXbYewYpy6WOWx
         Mf7jS/YfmPTiQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id 3vp_32iBWNDr; Mon, 25 Jun 2018 14:10:10 -0400 (EDT)
Received: from mail02.efficios.com (mail02.efficios.com [167.114.142.138])
        by mail.efficios.com (Postfix) with ESMTP id 9EBE71C2C2A;
        Mon, 25 Jun 2018 14:10:10 -0400 (EDT)
Date:   Mon, 25 Jun 2018 14:10:10 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Will Deacon <will.deacon@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        peter maydell <peter.maydell@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>
Message-ID: <501929863.3051.1529950210436.JavaMail.zimbra@efficios.com>
In-Reply-To: <1529949285-11013-4-git-send-email-will.deacon@arm.com>
References: <1529949285-11013-1-git-send-email-will.deacon@arm.com> <1529949285-11013-4-git-send-email-will.deacon@arm.com>
Subject: Re: [PATCH 3/3] rseq/selftests: Add support for arm64
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.142.138]
X-Mailer: Zimbra 8.8.8_GA_2096 (ZimbraWebClient - FF52 (Linux)/8.8.8_GA_1703)
Thread-Topic: rseq/selftests: Add support for arm64
Thread-Index: yP7vNsKbxoqvvCxYacs6zXLc8e16Qw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Jun 25, 2018, at 1:54 PM, Will Deacon will.deacon@arm.com wrote:

[...]

> +#define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,		\
> +				post_commit_offset, abort_ip)			\
> +	"	.pushsection	__rseq_table, \"aw\"\n"				\
> +	"	.balign	32\n"							\
> +	__rseq_str(label) ":\n"							\
> +	"	.long	" __rseq_str(version) ", " __rseq_str(flags) "\n"	\
> +	"	.quad	" __rseq_str(start_ip) ", "				\
> +			  __rseq_str(post_commit_offset) ", "			\
> +			  __rseq_str(abort_ip) "\n"				\
> +	"	.popsection\n"
> +
> +#define RSEQ_ASM_DEFINE_TABLE(label, start_ip, post_commit_ip, abort_ip)	\
> +	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
> +				(post_commit_ip - start_ip), abort_ip)
> +
> +#define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
> +	RSEQ_INJECT_ASM(1)							\
> +	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
> +	"	add	" RSEQ_ASM_TMP_REG ", " RSEQ_ASM_TMP_REG		\
> +			", :lo12:" __rseq_str(cs_label) "\n"			\
> +	"	str	" RSEQ_ASM_TMP_REG ", %[" __rseq_str(rseq_cs) "]\n"	\
> +	__rseq_str(label) ":\n"
> +
> +#define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
> +	"	.pushsection	__rseq_failure, \"ax\"\n"			\
> +	"	.long 	"	__rseq_str(RSEQ_SIG) "\n"			\
> +	__rseq_str(label) ":\n"							\
> +	"	b	%l[" __rseq_str(abort_label) "]\n"			\
> +	"	.popsection\n"

Thanks Will for porting rseq to arm64 !

I notice you are using the instructions

  adrp
  add
  str

to implement RSEQ_ASM_STORE_RSEQ_CS(). Did you compare
performance-wise with an approach using a literal pool
near the instruction pointer like I did on arm32 ?

With that approach, this ends up being simply

  adr
  str

which provides significantly better performance on my test
platform over loading a pointer targeting a separate data
section.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
