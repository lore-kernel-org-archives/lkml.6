Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE334C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5A89218E0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 21:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bCHgDBxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfBFVd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 16:33:28 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33998 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfBFVd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 16:33:27 -0500
Received: by mail-pg1-f193.google.com with SMTP id d9so3513169pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 13:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FRsqwdNgNTtCvCvmInLJ4D43sENxAoRd2qGgSSfOhps=;
        b=bCHgDBxzxGUFLJoECGdx5JsjtxQ71GFJ5FeBhEIx3BUxeCgIVRslRI50YpXtd7exnW
         4mLb9lRjV1f+LhJ68liJ55h61ADx2izpRnOv5k4bmJN4ZHtVh+hl+HmzuttehRSWYtga
         3kmwEqZn5GmbkKJYBI4eEy2H5viRodAytg4BdPh8PE51EgZ2K9mxTIDCute7eUGac0Ss
         C9+m3VxlksBtwqMFGMC2LfEYujkuY3zA57HdJpF2vIdzhrsS0M4/QyGUKffTC1f8oFVR
         UcCU8sQ2pt5Yw2mvLRkZyCgHwBWVKvF255hOodUrFSYW75XgIXBvp51sjzpksTC2qp/G
         suFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FRsqwdNgNTtCvCvmInLJ4D43sENxAoRd2qGgSSfOhps=;
        b=EIpK7BaTH6sugbQLcLzPEzRxN5fCpRvtuCPlQF63C1O3eWEQfmV/eEb7en7J6iCUUH
         uaIfjaJ4gcHrRtuinDwvHR81RUwABiFFiVhB+5Kg5tSTjkkQnIyCbma1Fbmshz/0fa2E
         yH8S/TfynG3td05/8wvhYlSL7ibTh9ZZ+jvGgJz+LPa9zgURbJibIAkRVhZ53M+E90vp
         JevzG9THtTM4mG29wY+AwQfl+oeZxxyMACM/c4twQotkVDWjZwoWkM3SBC7FndPXZ8CJ
         OltfwI0um8K+z+GzA656DvGx+s/25V9agl/hN13OUgiq5UUsEfLTXfLVJ2w9osxqJ4IH
         MFUQ==
X-Gm-Message-State: AHQUAub/xx3EsQeKHgnXz9YFABGPtiKtX9pnF7lrgVQUiOk+y5GRNhMa
        +TvLbYK1xNEfqa+BkR345p0=
X-Google-Smtp-Source: AHgI3Ib8UH6P5cgQEH+2KPu5Y3k2G4N5lZc1Uz1gqvG1sds834g+xBzpWGBtUcOUxpucmHAtN4atyw==
X-Received: by 2002:a62:35c7:: with SMTP id c190mr12987092pfa.76.1549488806426;
        Wed, 06 Feb 2019 13:33:26 -0800 (PST)
Received: from ?IPv6:2601:641:c000:8c20:65b1:6954:4d02:2a9a? ([2601:641:c000:8c20:65b1:6954:4d02:2a9a])
        by smtp.gmail.com with ESMTPSA id w128sm11477925pfw.79.2019.02.06.13.33.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 13:33:25 -0800 (PST)
Subject: Re: [RFC 2/2] ARC: U-boot: check magic number passed from u-boot
To:     Eugeniy Paltsev <eugeniy.paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Vineet Gupta <vineet.gupta1@synopsys.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <alexey.brodkin@synopsys.com>,
        Corentin Labbe <clabbe@baylibre.com>, khilman@baylibre.com
References: <20190206172228.9261-1-Eugeniy.Paltsev@synopsys.com>
 <20190206172228.9261-3-Eugeniy.Paltsev@synopsys.com>
From:   Vineet Gupta <vineetg76@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=vgupta@synopsys.com; keydata=
 mQINBFEffBMBEADIXSn0fEQcM8GPYFZyvBrY8456hGplRnLLFimPi/BBGFA24IR+B/Vh/EFk
 B5LAyKuPEEbR3WSVB1x7TovwEErPWKmhHFbyugdCKDv7qWVj7pOB+vqycTG3i16eixB69row
 lDkZ2RQyy1i/wOtHt8Kr69V9aMOIVIlBNjx5vNOjxfOLux3C0SRl1veA8sdkoSACY3McOqJ8
 zR8q1mZDRHCfz+aNxgmVIVFN2JY29zBNOeCzNL1b6ndjU73whH/1hd9YMx2Sp149T8MBpkuQ
 cFYUPYm8Mn0dQ5PHAide+D3iKCHMupX0ux1Y6g7Ym9jhVtxq3OdUI5I5vsED7NgV9c8++baM
 7j7ext5v0l8UeulHfj4LglTaJIvwbUrCGgtyS9haKlUHbmey/af1j0sTrGxZs1ky1cTX7yeF
 nSYs12GRiVZkh/Pf3nRLkjV+kH++ZtR1GZLqwamiYZhAHjo1Vzyl50JT9EuX07/XTyq/Bx6E
 dcJWr79ZphJ+mR2HrMdvZo3VSpXEgjROpYlD4GKUApFxW6RrZkvMzuR2bqi48FThXKhFXJBd
 JiTfiO8tpXaHg/yh/V9vNQqdu7KmZIuZ0EdeZHoXe+8lxoNyQPcPSj7LcmE6gONJR8ZqAzyk
 F5voeRIy005ZmJJ3VOH3Gw6Gz49LVy7Kz72yo1IPHZJNpSV5xwARAQABtCpWaW5lZXQgR3Vw
 dGEgKGFsaWFzKSA8dmd1cHRhQHN5bm9wc3lzLmNvbT6JAj4EEwECACgCGwMGCwkIBwMCBhUI
 AgkKCwQWAgMBAh4BAheABQJbBYpwBQkLx0HcAAoJEGnX8d3iisJeChAQAMR2UVbJyydOv3aV
 jmqP47gVFq4Qml1weP5z6czl1I8n37bIhdW0/lV2Zll+yU1YGpMgdDTHiDqnGWi4pJeu4+c5
 xsI/VqkH6WWXpfruhDsbJ3IJQ46//jb79ogjm6VVeGlOOYxx/G/RUUXZ12+CMPQo7Bv+Jb+t
 NJnYXYMND2Dlr2TiRahFeeQo8uFbeEdJGDsSIbkOV0jzrYUAPeBwdN8N0eOB19KUgPqPAC4W
 HCg2LJ/o6/BImN7bhEFDFu7gTT0nqFVZNXlOw4UcGGpM3dq/qu8ZgRE0turY9SsjKsJYKvg4
 djAaOh7H9NJK72JOjUhXY/sMBwW5vnNwFyXCB5t4ZcNxStoxrMtyf35synJVinFy6wCzH3eJ
 XYNfFsv4gjF3l9VYmGEJeI8JG/ljYQVjsQxcrU1lf8lfARuNkleUL8Y3rtxn6eZVtAlJE8q2
 hBgu/RUj79BKnWEPFmxfKsaj8of+5wubTkP0I5tXh0akKZlVwQ3lbDdHxznejcVCwyjXBSny
 d0+qKIXX1eMh0/5sDYM06/B34rQyq9HZVVPRHdvsfwCU0s3G+5Fai02mK68okr8TECOzqZtG
 cuQmkAeegdY70Bpzfbwxo45WWQq8dSRURA7KDeY5LutMphQPIP2syqgIaiEatHgwetyVCOt6
 tf3ClCidHNaGky9KcNSQuQINBFEffBMBEADXZ2pWw4Regpfw+V+Vr6tvZFRl245PV9rWFU72
 xNuvZKq/WE3xMu+ZE7l2JKpSjrEoeOHejtT0cILeQ/Yhf2t2xAlrBLlGOMmMYKK/K0Dc2zf0
 MiPRbW/NCivMbGRZdhAAMx1bpVhInKjU/6/4mT7gcE57Ep0tl3HBfpxCK8RRlZc3v8BHOaEf
 cWSQD7QNTZK/kYJo+Oyux+fzyM5TTuKAaVE63NHCgWtFglH2vt2IyJ1XoPkAMueLXay6enSK
 Nci7qAG2UwicyVDCK9AtEub+ps8NakkeqdSkDRp5tQldJbfDaMXuWxJuPjfSojHIAbFqP6Qa
 ANXvTCSuBgkmGZ58skeNopasrJA4z7OsKRUBvAnharU82HGemtIa4Z83zotOGNdaBBOHNN2M
 HyfGLm+kEoccQheH+my8GtbH1a8eRBtxlk4c02ONkq1Vg1EbIzvgi4a56SrENFx4+4sZcm8o
 ItShAoKGIE/UCkj/jPlWqOcM/QIqJ2bR8hjBny83ONRf2O9nJuEYw9vZAPFViPwWG8tZ7J+R
 euXKai4DDr+8oFOi/40mIDe/Bat3ftyd+94Z1RxDCngd3Q85bw13t2ttNLw5eHufLIpoEyAh
 TCLNQ58eT91YGVGvFs39IuH0b8ovVvdkKGInCT59Vr0MtfgcsqpDxWQXJXYZYTFHd3/RswAR
 AQABiQIlBBgBAgAPAhsMBQJbBYpwBQkLx0HdAAoJEGnX8d3iisJewe8P/36pkZrVTfO+U+Gl
 1OQh4m6weozuI8Y98/DHLMxEujKAmRzy+zMHYlIl3WgSih1UMOZ7U84yVZQwXQkLItcwXoih
 ChKD5D2BKnZYEOLM+7f9DuJuWhXpee80aNPzEaubBYQ7dYt8rcmB7SdRz/yZq3lALOrF/zb6
 SRleBh0DiBLP/jKUV74UAYV3OYEDHN9blvhWUEFFE0Z+j96M4/kuRdxvbDmp04Nfx79AmJEn
 fv1Vvc9CFiWVbBrNPKomIN+JV7a7m2lhbfhlLpUk0zGFDTWcWejl4qz/pCYSoIUU4r/VBsCV
 ZrOun4vd4cSi/yYJRY4kaAJGCL5k7qhflL2tgldUs+wERH8ZCzimWVDBzHTBojz0Ff3w2+gY
 6FUbAJBrBZANkymPpdAB/lTsl8D2ZRWyy90f4VVc8LB/QIWY/GiS2towRXQBjHOfkUB1JiEX
 YH/i93k71mCaKfzKGXTVxObU2I441w7r4vtNlu0sADRHCMUqHmkpkjV1YbnYPvBPFrDBS1V9
 OfD9SutXeDjJYe3N+WaLRp3T3x7fYVnkfjQIjDSOdyPWlTzqQv0I3YlUk7KjFrh1rxtrpoYS
 IQKf5HuMowUNtjyiK2VhA5V2XDqd+ZUT3RqfAPf3Y5HjkhKJRqoIDggUKMUKmXaxCkPGi91T
 hhqBJlyU6MVUa6vZNv8E
Message-ID: <21c279e8-df48-e6c9-05ca-30286ff928f2@gmail.com>
Date:   Wed, 6 Feb 2019 13:33:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190206172228.9261-3-Eugeniy.Paltsev@synopsys.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/19 9:22 AM, Eugeniy Paltsev wrote:
> In case of devboards we really often disable bootloader and load
> Linux image in memory via JTAG. In case of using kernel with
> CONFIG_ARC_UBOOT_SUPPORT enabled we may crash as we will try to
> interpret some junk in a registers as a pointers to bootargs/etc
> which aren't set by anyone in case of JTAG using.
> 
> Try to make it much less possible by check magic number and
> 'U-boot - kernel' ABI revision number passed from U-boot.
> Ignore U-boot arguments if we got wrong magic number or unknown
> ABI revision.
> 
> Signed-off-by: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> ---
>  arch/arc/kernel/head.S  |  5 ++++-
>  arch/arc/kernel/setup.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arc/kernel/head.S b/arch/arc/kernel/head.S
> index 7095055bb874..3fb88ec62bc7 100644
> --- a/arch/arc/kernel/head.S
> +++ b/arch/arc/kernel/head.S
> @@ -92,10 +92,13 @@ ENTRY(stext)
>  
>  #ifdef CONFIG_ARC_UBOOT_SUPPORT
>  	; Uboot - kernel ABI
> +	;    r1 = bits [31:8] magic number, bits [7:0] uboot-kernel ABI revision
> +	; ABI revision 0:
>  	;    r0 = [0] No uboot interaction, [1] cmdline in r2, [2] DTB in r2
> -	;    r1 = magic number (board identity, unused as of now
>  	;    r2 = pointer to uboot provided cmdline or external DTB in mem
>  	; These are handled later in handle_uboot_args()
> +	st      r1, [@uboot_rev_magic]
> +	mov	r1, 0			; errase magic from the register
>  	st	r0, [@uboot_tag]
>  	st	r2, [@uboot_arg]
>  #endif
> diff --git a/arch/arc/kernel/setup.c b/arch/arc/kernel/setup.c
> index 7edb35c26322..868dda3d4b43 100644
> --- a/arch/arc/kernel/setup.c
> +++ b/arch/arc/kernel/setup.c
> @@ -36,6 +36,7 @@ unsigned int intr_to_DE_cnt;
>  
>  /* Part of U-boot ABI: see head.S */
>  int __initdata uboot_tag;
> +int __initdata uboot_rev_magic;
>  char __initdata *uboot_arg;
>  
>  const struct machine_desc *machine_desc;
> @@ -467,6 +468,10 @@ static inline bool is_kernel(unsigned long addr)
>  	return addr >= (unsigned long)_stext && addr <= (unsigned long)_end;
>  }
>  
> +#define UBOOT_MAGIC_VALUE		0x567890
> +#define UBOOT_MAGIC_GET(x)		(((x) & GENMASK(31, 8)) >> 8)
> +#define UBOOT_REVISION_GET(x)		((x) & GENMASK(7, 0))
> +
>  /* uboot_tag values for U-boot - kernel ABI revisions 0+; see head.S */
>  #define UBOOT_REV0P_TAG_NONE		0
>  #define UBOOT_REV0P_TAG_CMDLINE		1
> @@ -478,6 +483,25 @@ void __init handle_uboot_args(void)
>  	bool use_embedded_dtb = true;
>  
>  #ifdef CONFIG_ARC_UBOOT_SUPPORT
> +	/* check that we got correct magic */
> +	if (UBOOT_MAGIC_GET(uboot_rev_magic) != UBOOT_MAGIC_VALUE) {
> +		pr_warn("Invalid magic '%06lx' is passed from uboot, uboot args ingnored\n",
> +			UBOOT_MAGIC_GET(uboot_rev_magic));
> +
> +		goto ignore_uboot_args;
> +	}
> +
> +	/*
> +	 * check that we know this U-boot args ABI revision.
> +	 * as for today we only have one revision - '0'.
> +	 */
> +	if (UBOOT_REVISION_GET(uboot_rev_magic) != 0) {
> +		pr_warn("Unknown args revision '%02lx' is passed from uboot, uboot args ingnored\n",
> +			UBOOT_REVISION_GET(uboot_rev_magic));
> +
> +		goto ignore_uboot_args;
> +	}
> +

So you are effectively dropping support for older uboot here as above seems to
assume that r1 will have the new magic value now. The existing stock of HSDK
boards will continue to ship with older uboot.

I understand your idea, but the fact is we can't drop the old uboot support.

Also not sure how all of this allows us to eliminate CONFIG_ARC_UBOOT_SUPPORT, or
enable it unconditionally with old or new uboot.


>  	/* check that we know this tag */
>  	if (uboot_tag != UBOOT_REV0P_TAG_NONE &&
>  	    uboot_tag != UBOOT_REV0P_TAG_CMDLINE &&
> @@ -498,6 +522,8 @@ void __init handle_uboot_args(void)
>  
>  	if (uboot_tag == UBOOT_REV0P_TAG_CMDLINE)
>  		append_boot_cmdline = true;
> +
> +ignore_uboot_args:
>  #endif
>  
>  	if (use_embedded_dtb) {
> 

