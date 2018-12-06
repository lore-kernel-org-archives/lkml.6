Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E771EC04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC94220850
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 16:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544114837;
	bh=NuRjc+lONxErIJvrJGWzdshIY7FAfIrLaSXD5w+kt+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S9GQuVW6gdyp8UnI1GQ8NlXAiqTlyjfZ9K2KjhXiBeOPKPaUwHWpJupGkKfTqGxmP
	 ZhejXfjVckvnW4hgKd6WSlT+ffL34TzXMVjflpN+NrjRC8/EPq/POv+aQul0qSZn1U
	 ZfWSbGwMRb0/RncIjVPv5F+ZmUh7Yj9kZWNx0KBg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC94220850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbeLFQrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 11:47:16 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39629 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbeLFQrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 11:47:15 -0500
Received: by mail-wm1-f68.google.com with SMTP id f81so1743223wmd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 08:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=TI0j2WCpwAux5LcS7gM5nNLJyE/Nr3N9kuNnTxgN00M=;
        b=ug49/ug3hch7KSB9JoR/c67rJPCrESoY2H/qtreISd5buqlsavpRBxBh4J+foFFig9
         bMm9hOJA7Rvl3boBz4DQ/vg7sdFdfc9OGrgEtNzom21W/r8Q3FUVMEM2QDuQyKkMKE6M
         P/P5fzxEc9Jzn7r8cUbgOTDQrAI97DFGDQWW+3nnky1AE5AuqgwmFAJqaOgldfUuBP1y
         /Q3h8QopMuXfvkRYoASnSuXld6s+vSL12MzjrHmey9nioc9dgIF6zUezQk5kVSi6i2uL
         ujpWHwwshGeRbI5PG25vV2kkR7ZsWSZTQ+bTdKaxHgayzmoP/ngliZ6OALPtTdrlKplo
         gCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TI0j2WCpwAux5LcS7gM5nNLJyE/Nr3N9kuNnTxgN00M=;
        b=GYzuD4edMWhIe58Omz/Zap3qcmpiUnQ2CklKAtjZcp3scRVWB4MqavgZ3i4d3PlmpK
         U/u/cc1w341X1DDny0HFwd6xyjefAJKLFvYlUGTmPRNtTP0luXIwPbcieMdhtqzIE4Gk
         QeS8MI16RGpnhQLXA117bEQW86i7FlsVO9Mjp4eCO+KQbsBbFV0RBnMd2u8JvOwD+t2Q
         IU6ZgW5ECWhib0xLgneXxshhZUDKMG0Nxg9Q68BZ2m+jIlsf0HkqRj7DZjEpqhCCJb86
         Z0unOdjaQ1v2qYatKnmSGr1eZfVaaouJKIYAyEL8KyESZVwtV/KnPqzPzczufdHfBJWJ
         WSCQ==
X-Gm-Message-State: AA+aEWbcYWwUrmsQ3l0nyRhlm0HitWXIJvqUmZPDVj6dK/2DsfecPHSL
        bPaSb/HLqeJ2kr4jsv4rv7g=
X-Google-Smtp-Source: AFSGD/WjiPcU02zhudnGewV1klZU/M2lxWROBhETFcbpM9p0ZIzlU7W7A1f3UTsYmm3VGUp/70vLaQ==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr6434539wmt.99.1544114833853;
        Thu, 06 Dec 2018 08:47:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id h2sm461934wrv.87.2018.12.06.08.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Dec 2018 08:47:13 -0800 (PST)
Date:   Thu, 6 Dec 2018 17:47:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86/mm/fault: Streamline the fault error_code decoder
 some more
Message-ID: <20181206164710.GA119529@gmail.com>
References: <20181205163624.1842-1-sean.j.christopherson@intel.com>
 <20181206073409.GA64887@gmail.com>
 <20181206155336.GC31263@linux.intel.com>
 <C1F7477E-70B1-4F26-9457-EA6D825501A6@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C1F7477E-70B1-4F26-9457-EA6D825501A6@amacapital.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Lutomirski <luto@amacapital.net> wrote:

> > vs. (with SGX added as 'G' for testing purposes)
> > 
> > [    0.158849] #PF error code(0001):  +P !W !U !S !I !K !G
> > [    0.159292] #PF error code(0003):  +P +W !U !S !I !K !G
> > [    0.159742] #PF error code(0007):  +P +W +U !S !I !K !G
> > [    0.160190] #PF error code(0025):  +P !W +U !S !I +K !G
> > [    0.160638] #PF error code(0002):  !P +W !U !S !I !K !G
> > [    0.161087] #PF error code(0004):  !P !W +U !S !I !K !G
> > [    0.161538] #PF error code(0006):  !P +W +U !S !I !K !G
> > [    0.161992] #PF error code(0014):  !P !W +U !S +I !K !G
> > [    0.162450] #PF error code(0011):  +P !W !U !S +I !K !G
> > [    0.162667] #PF error code(8001):  +P !W !U !S !I !K +G
> > [    0.162667] #PF error code(8003):  +P +W !U !S !I !K +G
> > [    0.162667] #PF error code(8007):  +P +W +U !S !I !K +G
> > [    0.162667] #PF error code(8025):  +P !W +U !S !I +K +G
> > [    0.162667] #PF error code(8002):  !P +W !U !S !I !K +G
> > [    0.162667] #PF error code(8004):  !P !W +U !S !I !K +G
> > [    0.162667] #PF error code(8006):  !P +W +U !S !I !K +G
> > [    0.162667] #PF error code(8014):  !P !W +U !S +I !K +G
> > [    0.162667] #PF error code(8011):  +P !W !U !S +I !K +G
> > [    0.162667] #PF error code(0000):  !P !W !U !S !I !K !G
> > 
> 
> Please don’t. The whole reason I added the decoding was to make it easy 
> to read without a cheat sheet. This is incomprehensible without 
> reference to the code, and I’m familiar with it to begin with.

Dunno, I can deduct the meaning from the above abbreviations without a 
cheat sheet and I'm sure you'll be able to too from now on. All the 
letters are very obvious references - to me at least, and brevity and 
predictable, fixed-length output matters.

> How about:
> 
> #PF error code: 0001 [PROT read kernel]
> 
> #PF error code: 0001 [PROT WRITE kernel]
> 
> #PF error code: 0001 [PROT read kernel]
> 
> #PF error code: 8011 [PROT INSTR kernel SGX]
> 
> This has no noise from unset bits except that we add lowercase “read” 
> or “kernel” as appropriate.  Even “kernel” seems barely necessary.

The thing is, the 'noise' from unset bits is actually important 
information as well - at least for the major bits: it was a mostly random 
choice that Intel defined '1' for write access and not for read access. 

Thanks,

	Ingo
