Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-613382-1517651410-2-3821698575194339490
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517651410; b=rVnhfMSrIxUZxsg3b6VeFvYsS6M+XeXrdbImd3Kvq/S/JNq
    eVYqjFmDkge2rmNz8qe2J6Mz619a37CR8CMEn96aFVYbMSS6ODo4bbdn3TvNZoWS
    L5/gst98aa3dBP101Ks9Q44V0Dnx0MZ3jmNRU/qzYIKmnr8DsxycrYFuoyXW7n/+
    jkHe+CoN80ILrza1yiQUOhBdLYsvO1aiorT3BuD1CQOB357bcrPucEg/90CJqG4J
    kqKn/FViSlO9o6BGSfmGlFIgbrFMZ993WCT/PrhLqfShcl4Fm+X7vMomLBT/uKDh
    hYzkzNnHTtn8zbShH4lvWaG3et6Upug5vm/TXwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517651410; bh=TdiCrEg
    GvEDfklavBtnMvgxPS4aPcXSXPrSMUvGN068=; b=uBmdRAihojtusUWoQm97E9w
    1rVDOE6rSypCnkj+Pz3UTgVo5qeWYzSG6R/DZ8DlHuH7aKCEC+lFkdKtjtz5HzqE
    sOTKNqNwsCN7h8S2auR+z+ziKKrxjdtAzPm3erJDpetXZOt/HKCdOguSXG9VCsOr
    zfWyORvctArvTkoz+Dm7XEcY5KN2E3rntiXBtQG+lfn/UqsvGpJiYxZHBKkDFth8
    wHNf2x8EZLUQPPnJ2spERKXovdszjGqjlxvfqVEmjbjt1lEAErpsjMi4kB8Z7nfk
    1ivV8wqfPwAvTavbqBEblelkKjYqlYBr54zCD1LeIraV86tC+Qi5frx/BNXvYSA=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeBCJuH (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 04:50:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:41665 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeBCJuF (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 04:50:05 -0500
Date: Sat, 3 Feb 2018 10:49:48 +0100
From: Borislav Petkov <bp@suse.de>
To: 540263207@qq.com
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Laura Abbott <labbott@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>
Subject: Re: [PATCH] remove raw pointer from printk message
Message-ID: <20180203094948.k5se54bdjudg6iei@pd.tnic>
References: <1517636899-5676-1-git-send-email-540263207@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1517636899-5676-1-git-send-email-540263207@qq.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 03, 2018 at 01:48:19PM +0800, 540263207@qq.com wrote:
> From: qize wang <540263207@qq.com>
> 
> The set_real_mode_mem function always print a raw kernel pointer to the kernel log
> at every boot. So just remove raw pointer from printk message.
> 
> Reported-by: qize wang <wang_qize@venustech.com.cn>
> Cc: stable <stable@vger.kernel.org>
> Signed-off-by: qize wang <540263207@qq.com>
> ---
>  arch/x86/realmode/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
> index d101058..d76a138 100644
> --- a/arch/x86/realmode/init.c
> +++ b/arch/x86/realmode/init.c
> @@ -20,8 +20,8 @@ void __init set_real_mode_mem(phys_addr_t mem, size_t size)
>  	void *base = __va(mem);
>  
>  	real_mode_header = (struct real_mode_header *) base;
> -	printk(KERN_DEBUG "Base memory trampoline at [%p] %llx size %zu\n",
> -	       base, (unsigned long long)mem, size);
> +	printk(KERN_DEBUG "Base memory trampoline at %llx size %zu\n",
> +	       (unsigned long long)mem, size);
>  }
>  
>  void __init reserve_real_mode(void)
> -- 

No need, it gets hashed already:

[    0.000000] Base memory trampoline at [        (ptrval)] 99000 size 24576

-- 
Regards/Gruss,
    Boris.

SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton, HRB 21284 (AG Nürnberg)
-- 
