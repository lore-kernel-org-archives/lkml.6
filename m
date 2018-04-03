Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AIpwx48venE4qdz7EDL/iairLyM90X43Vbn5ljeUS0kCAqeStDg3wjm/TmznmBUNkUMDN1OkzFB+
ARC-Seal: i=1; a=rsa-sha256; t=1522745014; cv=none;
        d=google.com; s=arc-20160816;
        b=h3RIF7w7YMPXod9hC4D8NHpagC1f04lphZVf+vLMNF0Nz42SJ0za9gCsdlb5GHCOlk
         0ehqNIUjRE6WqGxG3ZsPW1BpKXRRFjTb1NMx6qQs35Gq18IPxATEIyH2joaaVubyTeFL
         HGS/5wtCpMikVugl8EwYiwXlY0Gmtq4s/QqTKuBE7lJFw0fN4i+IuC0faVM8btkeCgmb
         EbajDim4EGF64UPodhAr32Fz1KkI2AXx9n8SbepTxqKgV6m+jfWHxTGsP1PK47/XbpCz
         irdr5iwFDyYbVO7vsesNYbFFzeSFc7KLESBTgleMyH4/e5GJyvbmuhNNsYUBlVP2GXY7
         Mxeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=3DiL5iwWYRGWej2Skso1/C0UMOAnFa7DjynkJzGU0TE=;
        b=bqyok6ku/ZYwBIWdAY5KewiFsWLcbcPfYkseNqn1Z17iHp46uQRiCTW5UlX6c+R4kf
         j6wnPHJRBtToXy8gcchfrP4kYbR2JzS3FkLsrTIbIanEp3sbSmhZafMpb7IGfdZ+wBXM
         rRwwqObEB8HxmydrZYmUKQS7vUaDMKdZV5K8vZCXIkm6UErL+73519dp3GI+J+EWg7le
         CnWEe++ZV00fsWw8hQgR6jbEgwe0Y5iBAfz4XNvqHdLPQ7t2VtM+gPGBRlUIw39sGu3Y
         4q9MOgIKBE4ajXdPNkmKa40I+NHQpcaVejjpVHsqMPvZsgfabySUdj/MW2nu0Az/WpSX
         KjEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [PATCH v8 0/4] Fix issues with huge mapping in ioremap for ARM64
To: Chintan Pandya <cpandya@codeaurora.org>, catalin.marinas@arm.com,
 will.deacon@arm.com, mark.rutland@arm.com, toshi.kani@hpe.com
Cc: arnd@arndb.de, ard.biesheuvel@linaro.org, james.morse@arm.com,
 kristina.martsenko@arm.com, takahiro.akashi@linaro.org,
 gregkh@linuxfoundation.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, akpm@linux-foundation.org
References: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a613f834-f356-a826-526f-aef532f62951@arm.com>
Date: Tue, 3 Apr 2018 09:43:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1522742446-5084-1-git-send-email-cpandya@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596711199968894044?=
X-GMAIL-MSGID: =?utf-8?q?1596713875823060333?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Chintan,

On 03/04/18 09:00, Chintan Pandya wrote:
> This series of patches are follow up work (and depends on)
> Toshi Kani <toshi.kani@hpe.com>'s patches "fix memory leak/
> panic in ioremap huge pages".
> 
> This series of patches are tested on 4.9 kernel with Cortex-A75
> based SoC.

Given that this is targeting mainline, can you please test with 4.16?
Basing your patches on something that is over 15 months old is not
exactly reassuring.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
