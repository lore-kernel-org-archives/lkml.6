Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 934EDC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674682089A
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 15:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674682089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbeKKBHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 20:07:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:40584 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726068AbeKKBHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 20:07:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A05EDADD8;
        Sat, 10 Nov 2018 15:22:31 +0000 (UTC)
Subject: Re: PLEASE REVERT URGENTLY: Re: [PATCH v5 2/3] x86/boot: add acpi
 rsdp address to setup_header
To:     "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-doc@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, corbet@lwn.net,
        boris.ostrovsky@oracle.com
References: <20181010061456.22238-1-jgross@suse.com>
 <20181010061456.22238-3-jgross@suse.com>
 <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
From:   Juergen Gross <jgross@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jgross@suse.com; prefer-encrypt=mutual; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNHkp1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmRlPsLAeQQTAQIAIwUCU4xw6wIbAwcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJELDendYovxMvi4UH/Ri+OXlObzqMANruTd4N
 zmVBAZgx1VW6jLc8JZjQuJPSsd/a+bNr3BZeLV6lu4Pf1Yl2Log129EX1KWYiFFvPbIiq5M5
 kOXTO8Eas4CaScCvAZ9jCMQCgK3pFqYgirwTgfwnPtxFxO/F3ZcS8jovza5khkSKL9JGq8Nk
 czDTruQ/oy0WUHdUr9uwEfiD9yPFOGqp4S6cISuzBMvaAiC5YGdUGXuPZKXLpnGSjkZswUzY
 d9BVSitRL5ldsQCg6GhDoEAeIhUC4SQnT9SOWkoDOSFRXZ+7+WIBGLiWMd+yKDdRG5RyP/8f
 3tgGiB6cyuYfPDRGsELGjUaTUq3H2xZgIPfOwE0EU4xwFgEIAMsx+gDjgzAY4H1hPVXgoLK8
 B93sTQFN9oC6tsb46VpxyLPfJ3T1A6Z6MVkLoCejKTJ3K9MUsBZhxIJ0hIyvzwI6aYJsnOew
 cCiCN7FeKJ/oA1RSUemPGUcIJwQuZlTOiY0OcQ5PFkV5YxMUX1F/aTYXROXgTmSaw0aC1Jpo
 w7Ss1mg4SIP/tR88/d1+HwkJDVW1RSxC1PWzGizwRv8eauImGdpNnseneO2BNWRXTJumAWDD
 pYxpGSsGHXuZXTPZqOOZpsHtInFyi5KRHSFyk2Xigzvh3b9WqhbgHHHE4PUVw0I5sIQt8hJq
 5nH5dPqz4ITtCL9zjiJsExHuHKN3NZsAEQEAAcLAXwQYAQIACQUCU4xwFgIbDAAKCRCw3p3W
 KL8TL0P4B/9YWver5uD/y/m0KScK2f3Z3mXJhME23vGBbMNlfwbr+meDMrJZ950CuWWnQ+d+
 Ahe0w1X7e3wuLVODzjcReQ/v7b4JD3wwHxe+88tgB9byc0NXzlPJWBaWV01yB2/uefVKryAf
 AHYEd0gCRhx7eESgNBe3+YqWAQawunMlycsqKa09dBDL1PFRosF708ic9346GLHRc6Vj5SRA
 UTHnQqLetIOXZm3a2eQ1gpQK9MmruO86Vo93p39bS1mqnLLspVrL4rhoyhsOyh0Hd28QCzpJ
 wKeHTd0MAWAirmewHXWPco8p1Wg+V+5xfZzuQY0f4tQxvOpXpt4gQ1817GQ5/Ed/wsDtBBgB
 CAAgFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAlrd8NACGwIAgQkQsN6d1ii/Ey92IAQZFggA
 HRYhBFMtsHpB9jjzHji4HoBcYbtP2GO+BQJa3fDQAAoJEIBcYbtP2GO+TYsA/30H/0V6cr/W
 V+J/FCayg6uNtm3MJLo4rE+o4sdpjjsGAQCooqffpgA+luTT13YZNV62hAnCLKXH9n3+ZAgJ
 RtAyDWk1B/0SMDVs1wxufMkKC3Q/1D3BYIvBlrTVKdBYXPxngcRoqV2J77lscEvkLNUGsu/z
 W2pf7+P3mWWlrPMJdlbax00vevyBeqtqNKjHstHatgMZ2W0CFC4hJ3YEetuRBURYPiGzuJXU
 pAd7a7BdsqWC4o+GTm5tnGrCyD+4gfDSpkOT53S/GNO07YkPkm/8J4OBoFfgSaCnQ1izwgJQ
 jIpcG2fPCI2/hxf2oqXPYbKr1v4Z1wthmoyUgGN0LPTIm+B5vdY82wI5qe9uN6UOGyTH2B3p
 hRQUWqCwu2sqkI3LLbTdrnyDZaixT2T0f4tyF5Lfs+Ha8xVMhIyzNb1byDI5FKCb
Message-ID: <685b425b-c816-4f65-3393-b48e59d170d8@suse.com>
Date:   Sat, 10 Nov 2018 16:22:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f7c78ee7-b548-7f04-24da-7321b6c64c97@zytor.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 23:23, H. Peter Anvin wrote:
> I just noticed this patch -- I missed it because the cover message
> seemed far more harmless so I didn't notice this change.
> 
> THIS PATCH IS FATALLY WRONG AND NEEDS TO BE IMMEDIATELY REVERTED BEFORE
> ANYONE STARTS RELYING ON IT; IT HAS THE POTENTIAL OF BREAKING THE
> BOOTLOADER PROTOCOL FOR ALL FUTURE.
> 
> It seems to be based on fundamental misconceptions about the various
> data structures in the protocol, and does so in a way that completely
> breaks the way the protocol is designed to work.
> 
> The protocol is specifically designed such that fields are not version
> dependencies. The version number is strictly to inform the boot loader
> about which capabilities the kernel has, so that the boot loader can
> know if a certain data field is meaningful and/or honored.
> 
>> +Protocol 2.14:	(Kernel 4.20) Added acpi_rsdp_addr holding the physical
>> +		address of the ACPI RSDP table.
>> +		The bootloader updates version with:
>> +		0x8000 | min(kernel-version, bootloader-version)
>> +		kernel-version being the protocol version supported by
>> +		the kernel and bootloader-version the protocol version
>> +		supported by the bootloader.
> 
> [...]
> 
>>  **** MEMORY LAYOUT
>>
>>  The traditional memory map for the kernel loader, used for Image or
>> @@ -197,6 +209,7 @@ Offset	Proto	Name		Meaning
>>  0258/8	2.10+	pref_address	Preferred loading address
>>  0260/4	2.10+	init_size	Linear memory required during initialization
>>  0264/4	2.11+	handover_offset	Offset of handover entry point
>> +0268/8	2.14+	acpi_rsdp_addr	Physical address of RSDP table
> 
> NO.
> 
> That is not how struct setup_header works, nor does this belong here.
> 
> struct setup_header contains *initialized data*, and has a length byte
> at offset 0x201.  The bootloader is responsible for copying the full
> structure into the appropriate offset (0x1f1) in struct boot_params.
> 
> The length byte isn't actually a requirement, since the maximum possible
> size of this structure is 144 bytes, and the kernel will (obviously) not
> look at the older fields anyway, but it is good practice. The kernel or
> any other entity is free to zero out the bytes past this length pointer.
> 
> There are only 24 bytes left in this structure, and this would occupy 8
> of them for no valid reason.  The *only* valid reason to put a
> zero-initialized field in struct setup_header is if it used by the
> 16-bit legacy BIOS boot, which is obviously not the case here.
> 
> This field thus belongs in struct boot_params, not struct setup_header.

Would you be okay with putting acpi_rsdp_addr at offset 0x0cc (_pad4)?


Juergen
