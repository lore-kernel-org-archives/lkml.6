Return-Path: <kernel-hardening-return-12954-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx4+MZXXMzT8X/LfrPvgw/MzeStbyziwz4GqeqyC/VT+VnwOgvCr5C+MQWwrGchlcX0HscRZZ
ARC-Seal: i=1; a=rsa-sha256; t=1523350777; cv=none;
        d=google.com; s=arc-20160816;
        b=Gr1TaH/5hIXOKaygREFzoPvVP7y9re2Qmz4Agg6LlGPRdlf5FIiJzwfHEBToqf86o7
         LIBjyv8ez4omIHSF/x0lWRPGExpcPY9EEXL56BIrO7cxu0SbBuPzgmsfvzOSdFzCrwLT
         4/9AgE2+LZV2vCTBXWnJDBria/dtPVj+yKKu/f1R1zaWdrpY/ffoMIj37bfZZD1jhPCk
         35jPYGjwfLwbTAwtZnWjAvJqtmIIZ5JAgjVdnDIRza+do+vC+pQRCGrVjOMSMme4xqK5
         GEs1OaHTm/Jvgz0tdIDjvlh0GERJ/EAqdOGqBtSQdk/EXKtGlDpgEQ6P4Mlmttgf39ik
         F6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:delivered-to:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=GWjXUVa/UTqlPEZcyNvSPq3m8GDZj34+6nyxl73oja4=;
        b=v484K6508BlYP2TSMtu43HiPVu7UN9cJFbB94DDtrIxfJM1mjVH93PEdTRNFh2XXT3
         Rj2/uHfi3SJV3ytbVSUjAaRh5SjiX9byeiqjoUSH7zgi/xoiTf4O2Uc8tBEZVKqrTV8p
         0ibKXd5faZVK31Gz4Mgo7D3s1BN7sa8/S+UyFm1LB6mYQf5ouJ9jtSWWDg9sFuCwSpRi
         9U2tvFVW5VR8B4OcssWqUvDPs5ZLDqr+eYx55ii2Ct4AaSkUgRjRqUGoDpF98d12uwZy
         TtPVvQkiSTfx1MdF1QRnShxpbVnV4PbnzhE4sZIsC+J2753X/PqrIYy/WLV5qWn27GOr
         iMAA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=US9YgdmT;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MMObWEek;
       spf=pass (google.com: domain of kernel-hardening-return-12954-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12954-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=US9YgdmT;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=MMObWEek;
       spf=pass (google.com: domain of kernel-hardening-return-12954-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12954-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 09 Apr 2018 19:19:16 -0400
From: okaya@codeaurora.org
To: Laura Abbott <labbott@redhat.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Dan Williams
 <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com, Kees Cook
 <keescook@chromium.org>, dmaengine-owner@vger.kernel.org
Subject: Re: [PATCH] dmaengine: dmatest: Remove use of VLAs
In-Reply-To: <9bdd8bb4-b6d9-e170-b585-b2dc3b8f0d67@redhat.com>
References: <20180409210603.3575-1-labbott@redhat.com>
 <4491bde2-cf38-5103-0634-1986ecd32a7c@codeaurora.org>
 <9bdd8bb4-b6d9-e170-b585-b2dc3b8f0d67@redhat.com>
Message-ID: <e2991519fb007653c35bf52210af36b9@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304199213101990?=
X-GMAIL-MSGID: =?utf-8?q?1597349064308931547?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-09 19:14, Laura Abbott wrote:
> On 04/09/2018 03:48 PM, Sinan Kaya wrote:
>> On 4/9/2018 5:06 PM, Laura Abbott wrote:
>>> +			/* dst_cnt can't be more than u8 */
>>> +			dma_addr_t dma_pq[255];
>> 
>> This is 2k stack space on 64 bit architectures. Isn't that a lot?
>> 
> 
> Depends on your definition of 'a lot'. My assumption was that
> since this was a test module there would be some willingness
> to be a bit more generous. The problem is the array size is
> based off of the parameters passed in, although oddly enough
> it's based off of the minimum of two variables. If you have
> a suggestion for a tighter bound we can use that. Another
> option is to just switch to allocating the array with kmalloc.
> That might be reasonable here since there's other setup
> that happens before the test starts.

I think allocation is a better choice.

> 
> Thanks,
> Laura
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
