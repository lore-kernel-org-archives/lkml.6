Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 4z3AIbzcGVtCDgAAmS7hNA
	; Fri, 08 Jun 2018 01:32:44 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6A4D96074D; Fri,  8 Jun 2018 01:32:44 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7liRR/a"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A2F80601B4;
	Fri,  8 Jun 2018 01:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2F80601B4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752685AbeFHBci (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 21:32:38 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39311 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752641AbeFHBch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 21:32:37 -0400
Received: by mail-pl0-f67.google.com with SMTP id f1-v6so7250028plt.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 18:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gkIIY3jarTCFgeQbMFkuwYT4qKO28/PjkBHu9tb/kBc=;
        b=S7liRR/a04jdtNuiTH/7o90u35QcSscYr30dklJ/hbAZExAudhCcou26GgOm6/g5+P
         MfCmujAl5RZoreb0oMS5SwO90yVQJcdXDZeeeOmlytDdjww7EG3ROx8gaf7DLdP6jkVj
         113Dw1ZcYBs6IzA7/epF4u2kICpQXQpl5CmhX4/tZpNXb9miTNldkWo1uabLecKmG4wm
         l+tChbnCOsAhqGl9C901vL4Ln5KEquHiqcAT0hiX5KzoBBttvEOUSSi0f2BTc47A0jpt
         xVucd55lsYpO2fXLFUBaxx2uNJwcIxmrmTAVTf31YPPB2bbR9E1eNP+oWN7U0uNtVYnF
         iVCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gkIIY3jarTCFgeQbMFkuwYT4qKO28/PjkBHu9tb/kBc=;
        b=RlmwlLzYZOM4CVSsM6yXPa0sm8vzYCLmoSEMcKNFsl1WoH0BKvF0WlBZe5qRBcl9LV
         zn7/lTgmm9WmQHswWKKcHVUlbcR6fnlqrxX6vZdYSFjsPJvFTMx1Iv7xB4CiWeyciYPb
         oo1o6f6+59/fawGZRT3GPOMNvs/Nw1HffyVHTsrwiR3dXw8cSHwyXg4fPxVnokFarbGU
         n52+H+XHUk0IaiHPUZb/u1uZn0eWsBC4hZREAEmuCjCcv8KaFFlzzGOvEDHZFp/2N5SF
         HVeOmM0wlVELKSjCYPS90hWY4dTTTYyUfMoaktlCP+2jVmCQNx9omlIrJtIjfIHNov1t
         DO4A==
X-Gm-Message-State: APt69E0tWMjvMvEpL7tZAIOEkivjtBxhDYLxAor6Lh24YLsCAgOy9RDg
        7tm8ktlgGNtjXaNvH9DybR0=
X-Google-Smtp-Source: ADUXVKKqXju7/DSZvq38/W8rlmYtWRkg9G9BS9WY6ec0XbFcFxJPTH3rg4VVCXpw7svSQmaVbzmnow==
X-Received: by 2002:a17:902:145:: with SMTP id 63-v6mr4354555plb.332.1528421556475;
        Thu, 07 Jun 2018 18:32:36 -0700 (PDT)
Received: from [0.0.0.0] (67.216.217.169.16clouds.com. [67.216.217.169])
        by smtp.gmail.com with ESMTPSA id p1-v6sm96290519pfp.137.2018.06.07.18.32.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 18:32:35 -0700 (PDT)
Subject: Re: [PATCH v2] mm/ksm: ignore STABLE_FLAG of rmap_item->address in
 rmap_walk_ksm
To: Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>,
        Minchan Kim <minchan@kernel.org>,
        Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
        Arvind Yadav <arvind.yadav.cs@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, jia.he@hxt-semitech.com,
        Hugh Dickins <hughd@google.com>
References: <20180503124415.3f9d38aa@p-imbrenda.boeblingen.de.ibm.com>
 <1525403506-6750-1-git-send-email-hejianet@gmail.com>
 <20180509163101.02f23de1842a822c61fc68ff@linux-foundation.org>
 <2cd6b39b-1496-bbd5-9e31-5e3dcb31feda@arm.com>
 <6c417ab1-a808-72ea-9618-3d76ec203684@arm.com>
 <20180524133805.6e9bfd4bf48de065ce1d7611@linux-foundation.org>
 <20180607151344.a22a1e7182a2142e6d24e4de@linux-foundation.org>
 <20180607233800.GA6965@redhat.com>
From: Jia He <hejianet@gmail.com>
Message-ID: <91c87688-50d3-581c-339d-70ad658a292a@gmail.com>
Date: Fri, 8 Jun 2018 09:32:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607233800.GA6965@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea
Thanks for the review.

On 6/8/2018 7:38 AM, Andrea Arcangeli Wrote:
> On Thu, Jun 07, 2018 at 03:13:44PM -0700, Andrew Morton wrote:
>> This patch is quite urgent and is tagged for -stable backporting, yet
>> it remains in an unreviewed state.  Any takers?
> 
> It looks a straightforward safe fix, on x86 hva_to_gfn_memslot would
> zap those bits and hide the misalignment caused by the low metadata
> bits being erroneously left set in the address, but the arm code
> notices when that's the last page in the memslot and the hva_end is
> getting aligned and the size is below one page.
> 
>> [35380.933345] [<ffff000008088f00>] dump_backtrace+0x0/0x22c
>> [35380.938723] [<ffff000008089150>] show_stack+0x24/0x2c
>> [35380.943759] [<ffff00000893c078>] dump_stack+0x8c/0xb0
>> [35380.948794] [<ffff00000820ab50>] bad_page+0xf4/0x154
>> [35380.953740] [<ffff000008211ce8>] free_pages_check_bad+0x90/0x9c
>> [35380.959642] [<ffff00000820c430>] free_pcppages_bulk+0x464/0x518
>> [35380.965545] [<ffff00000820db98>] free_hot_cold_page+0x22c/0x300
>> [35380.971448] [<ffff0000082176fc>] __put_page+0x54/0x60
>> [35380.976484] [<ffff0000080b1164>] unmap_stage2_range+0x170/0x2b4
>> [35380.982385] [<ffff0000080b12d8>] kvm_unmap_hva_handler+0x30/0x40
>> [35380.988375] [<ffff0000080b0104>] handle_hva_to_gpa+0xb0/0xec
>> [35380.994016] [<ffff0000080b2644>] kvm_unmap_hva_range+0x5c/0xd0
>> [35380.999833] [<ffff0000080a8054>] 
>>
>> I even injected a fault on purpose in kvm_unmap_hva_range by seting
>> size=size-0x200, the call trace is similar as above.  So I thought the
>> panic is similarly caused by the root cause of WARN_ON.
> 
> I think the problem triggers in the addr += PAGE_SIZE of
> unmap_stage2_ptes that never matches end because end is aligned but
> addr is not.
> 
> 	} while (pte++, addr += PAGE_SIZE, addr != end);
> 
> x86 again only works on hva_start/hva_end after converting it to
> gfn_start/end and that being in pfn units the bits are zapped before
> they risk to cause trouble.
For this panic issue on arm64, I started another thread to discuss
https://lkml.org/lkml/2018/5/2/61


-- 
Cheers,
Jia
> 
>>
>> Link: http://lkml.kernel.org/r/1525403506-6750-1-git-send-email-hejianet@gmail.com
>> Signed-off-by: Jia He <jia.he@hxt-semitech.com>
>> Cc: Suzuki K Poulose <Suzuki.Poulose@arm.com>
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Cc: Minchan Kim <minchan@kernel.org>
>> Cc: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
>> Cc: Arvind Yadav <arvind.yadav.cs@gmail.com>
>> Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
>> Cc: Jia He <hejianet@gmail.com>
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>> ---
>>
> 
> Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> 
