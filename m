Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFECEC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0BBA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:05:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732851AbfAPWFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:05:09 -0500
Received: from mx2.freebsd.org ([8.8.178.116]:31623 "EHLO mx2.freebsd.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732820AbfAPWFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:05:07 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Jan 2019 17:05:06 EST
Received: from mx1.freebsd.org (mx1.freebsd.org [IPv6:2610:1c1:1:606c::19:1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mx1.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx2.freebsd.org (Postfix) with ESMTPS id C24CF922E8;
        Wed, 16 Jan 2019 21:58:17 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Received: from smtp.freebsd.org (smtp.freebsd.org [96.47.72.83])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         server-signature RSA-PSS (4096 bits)
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "smtp.freebsd.org", Issuer "Let's Encrypt Authority X3" (verified OK))
        by mx1.freebsd.org (Postfix) with ESMTPS id D3EBC8932A;
        Wed, 16 Jan 2019 21:58:16 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Received: from freefall.freebsd.org (static-71-168-218-4.cmdnnj.fios.verizon.net [71.168.218.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        (Authenticated sender: jkim/mail)
        by smtp.freebsd.org (Postfix) with ESMTPSA id 84EB11214E;
        Wed, 16 Jan 2019 21:58:16 +0000 (UTC)
        (envelope-from jkim@FreeBSD.org)
Subject: Re: [PATCH 2/2] x86, kexec_file_load: make it work with efi=noruntime
 or efi=oldmap
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        Dave Young <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
References: <20190109064727.27936-1-kasong@redhat.com>
 <20190115084213.GA6468@dhcp-128-65.nay.redhat.com>
 <CF6A88132359CE47947DB4C6E1709ED53C560C62@ORSMSX122.amr.corp.intel.com>
From:   Jung-uk Kim <jkim@FreeBSD.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jkim@FreeBSD.org; prefer-encrypt=mutual; keydata=
 mQENBFJBztUBCAChqNyGqmFuNo0U7MBzsD+q/G6Cv0l7LGVrOAsgh34M8wIWhD+tztDWMVfn
 AhxNDd0ceCj2bYOe67sTQxAScEcbt2FfvPOLp9MEXb9qohZj172Gwkk7dnhOhZZKhVGVZKM4
 NcsuBDUzgf4f3Vdzj4wg6WlqplnTZo8lPE4hZWvZHoFIyunPTJWenybeV1xnxK7JkUdSvQR0
 fA59RfTTECMwTrSEfYGUnxIDBraxJ7Ecs/0hGQ7sljIj8WBvlRDU5fU1xfF35aw56T8POQRq
 F4E6RVJW3YGuTpSwgtGZOTfygcLRhAiq3dFC3JNLaTVTpM8PjOinJyt9AU6RoITGOKwDABEB
 AAG0Hkp1bmctdWsgS2ltIDxqa2ltQEZyZWVCU0Qub3JnPokBPQQTAQoAJwUCUkHO1QIbAwUJ
 E0/POwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRB8n5Ym/NvxRqyzB/wL7QtsIpeGfGIA
 ZPMtgXMucM3NWzomyQMln2j2efUkDKthzh9jBxgF53TjOr7imwIt0PT2k1bqctPrq5IRqnu9
 mGroqaCLE3LG2/E3jEaao4k9PO6efwlioyivUo5NrqIQOQ4k3EAXw7d2y0Dk1VpTgdMrnUAB
 hj7lGlLqS4ydcrf24DdbCRGdEQwqd9DBeBgbWynxAJMgbZBhYVEyIHuQKkJ8qY0ibIPXXuF0
 KYDeH0qUHtWV2K3srNyPtymUkBQD84Pl1GWRYx05XdUHDmnX0JV3lg0BfYJZgZv0ehPQrMfY
 Fd9abTkf9FHQYz1JtsC8wUuRgqElRd6+YAGf8Tt9uQENBFJBztUBCADLtSrP44El2VoJmH14
 OFrlOgxzZnbn+Y/Gf1k12mJBiR+A+pBeRLD50p7AiTrjHRxO3cHcl9Dh0uf1VSbXgp8Or0ye
 iP/86fZPd4k5HXNmDTLL0HecPE08SCqGZ0W8vllQrokB1QxxRUB+fFMPJyMCjDAZ7P9fFTOS
 dTw1bJSTtOD8Sx8MpZUa9ti06bXFlVYDlaqSdgk181SSx+ZbSKkQR8CIMARlHwiLsa3Z9q9O
 EJr20HPyxe0AlTvwvFndH61hg7ds63eRvglwRnNON28VXO/lvKXq7Br/CiiyhFdKfINIx2Z5
 htYq22tgGTW7mBURbIKoECFBTX9Lv6BXz6w9ABEBAAGJASUEGAEKAA8FAlJBztUCGwwFCRNP
 zzsACgkQfJ+WJvzb8UZcJQf+IsTCxUEqY7W/pT84sMg5/QD3s6ufTRncvq14fEOxCNq1Rf4Q
 9P+tOFa8GZfKDGB2BFGIrW7uT5mlmKdK1vO6ZIA930y5kUsnCmBUEBJkE2ciSQk01aB/1o62
 Q3Gk/F6BwtNY9OXiqF7AcAo+K/BMIaqb26QKeh+IIgK1NN9dQiq3ByTbl4zpGZa6MmsnnRTu
 mzGKt2nkz7vBzH6+hZp1OzGZikgjjhYWVFoJo1dvf/rv4obs0ZJEqFPQs/1Qa1dbkKBv6odB
 XJpPH0ssOluTY24d1XxTiKTwmWvHeQkOKRAIfD7VTtF4TesoZYkf7hsh3e3VwXhptSLFnEOi
 WwYofg==
Message-ID: <ef9bb8d4-4ac0-8887-65cd-34321d7d440c@FreeBSD.org>
Date:   Wed, 16 Jan 2019 16:58:05 -0500
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C560C62@ORSMSX122.amr.corp.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="JayVUwV80EyeDMxL7BWbW9QB8TamJgw0w"
X-Rspamd-Queue-Id: D3EBC8932A
X-Spamd-Bar: --
Authentication-Results: mx1.freebsd.org
X-Spamd-Result: default: False [-2.96 / 15.00];
         local_wl_from(0.00)[FreeBSD.org];
         NEURAL_HAM_MEDIUM(-1.00)[-0.999,0];
         NEURAL_HAM_SHORT(-0.97)[-0.965,0];
         ASN(0.00)[asn:11403, ipnet:96.47.64.0/20, country:US];
         NEURAL_HAM_LONG(-1.00)[-0.999,0]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JayVUwV80EyeDMxL7BWbW9QB8TamJgw0w
Content-Type: multipart/mixed; boundary="mieEiLY0mmroyULfkOB9Qb5qQ9GgyAIYK";
 protected-headers="v1"
From: Jung-uk Kim <jkim@FreeBSD.org>
To: "Schmauss, Erik" <erik.schmauss@intel.com>, Dave Young
 <dyoung@redhat.com>, Kairui Song <kasong@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "tglx@linutronix.de" <tglx@linutronix.de>,
 "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
 "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "Moore, Robert" <robert.moore@intel.com>,
 "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
 "lenb@kernel.org" <lenb@kernel.org>
Message-ID: <ef9bb8d4-4ac0-8887-65cd-34321d7d440c@FreeBSD.org>
Subject: Re: [PATCH 2/2] x86, kexec_file_load: make it work with efi=noruntime
 or efi=oldmap
References: <20190109064727.27936-1-kasong@redhat.com>
 <20190115084213.GA6468@dhcp-128-65.nay.redhat.com>
 <CF6A88132359CE47947DB4C6E1709ED53C560C62@ORSMSX122.amr.corp.intel.com>
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C560C62@ORSMSX122.amr.corp.intel.com>

--mieEiLY0mmroyULfkOB9Qb5qQ9GgyAIYK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19. 1. 16., Schmauss, Erik wrote:
>> -----Original Message-----
>> From: Dave Young [mailto:dyoung@redhat.com]
>> Sent: Tuesday, January 15, 2019 12:42 AM
>> To: Kairui Song <kasong@redhat.com>
>> Cc: linux-kernel@vger.kernel.org; tglx@linutronix.de;
>> mingo@redhat.com; bp@alien8.de; hpa@zytor.com; x86@kernel.org;
>> akpm@linux-foundation.org; Moore, Robert
>> <robert.moore@intel.com>; Schmauss, Erik
>> <erik.schmauss@intel.com>; Wysocki, Rafael J
>> <rafael.j.wysocki@intel.com>; lenb@kernel.org
>> Subject: Re: [PATCH 2/2] x86, kexec_file_load: make it work with
>> efi=3Dnoruntime or efi=3Doldmap
>>
>> On 01/09/19 at 02:47pm, Kairui Song wrote:
>>> When efi=3Dnoruntime or efi=3Doldmap is used, EFI services won't be
>>> available in the second kernel, therefore the second kernel will not
>>> be able to get the ACPI RSDP address from firmware by calling EFI
>>> services and won't boot. Previously we are expecting the user to set
>>> the acpi_rsdp=3D<addr> on kernel command line for second kernel as
>> there
>>> was no way to pass RSDP address to second kernel.
>>>
>>> After commit e6e094e053af ('x86/acpi, x86/boot: Take RSDP address
>> from
>>> boot params if available'), now it's possible to set a acpi_rsdp_addr=

>>> parameter in the boot_params passed to second kernel, this commit
>> make
>>> use of it, detect and set the RSDP address when it's required for
>>> second kernel to boot.
>>>
>>> Tested with an EFI enabled KVM VM with efi=3Dnoruntime.
>>>
>>> Suggested-by: Dave Young <dyoung@redhat.com>
>>> Signed-off-by: Kairui Song <kasong@redhat.com>
>>> ---
>>>  arch/x86/kernel/kexec-bzimage64.c | 21 +++++++++++++++++++++
>>>  drivers/acpi/acpica/tbxfroot.c    |  3 +--
>>>  include/acpi/acpixf.h             |  2 +-
>>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/x86/kernel/kexec-bzimage64.c
>>> b/arch/x86/kernel/kexec-bzimage64.c
>>> index 53917a3ebf94..0a90dcbd041f 100644
>>> --- a/arch/x86/kernel/kexec-bzimage64.c
>>> +++ b/arch/x86/kernel/kexec-bzimage64.c
>>> @@ -20,6 +20,7 @@
>>>  #include <linux/mm.h>
>>>  #include <linux/efi.h>
>>>  #include <linux/verification.h>
>>> +#include <linux/acpi.h>
>>>
>>>  #include <asm/bootparam.h>
>>>  #include <asm/setup.h>
>>> @@ -255,8 +256,28 @@ setup_boot_parameters(struct kimage
>> *image, struct boot_params *params,
>>>  	/* Setup EFI state */
>>>  	setup_efi_state(params, params_load_addr, efi_map_offset,
>> efi_map_sz,
>>>  			efi_setup_data_offset);
>>> +
>>> +#ifdef CONFIG_ACPI
>>> +	/* Setup ACPI RSDP pointer in case EFI is not available in
>> second kernel */
>>> +	if (!acpi_disabled && (!efi_enabled(EFI_RUNTIME_SERVICES)
>> || efi_enabled(EFI_OLD_MEMMAP))) {
>>> +		/* Copied from acpi_os_get_root_pointer accordingly
>> */
>>> +		params->acpi_rsdp_addr =3D
>> boot_params.acpi_rsdp_addr;
>>> +		if (!params->acpi_rsdp_addr) {
>>> +			if (efi_enabled(EFI_CONFIG_TABLES)) {
>>> +				if (efi.acpi20 !=3D
>> EFI_INVALID_TABLE_ADDR)
>>> +					params->acpi_rsdp_addr =3D
>> efi.acpi20;
>>> +				else if (efi.acpi !=3D
>> EFI_INVALID_TABLE_ADDR)
>>> +					params->acpi_rsdp_addr =3D
>> efi.acpi;
>>> +			} else if
>> (IS_ENABLED(CONFIG_ACPI_LEGACY_TABLES_LOOKUP)) {
>>> +				acpi_find_root_pointer(&params-
>>> acpi_rsdp_addr);
>>> +			}
>>> +		}
>>> +		if (!params->acpi_rsdp_addr)
>>> +			pr_warn("RSDP is not available for second
>> kernel\n");
>>> +	}
>>>  #endif
>>>
>>> +#endif
>>>  	/* Setup EDD info */
>>>  	memcpy(params->eddbuf, boot_params.eddbuf,
>>>  				EDDMAXNR * sizeof(struct edd_info));
>> diff --git
>>> a/drivers/acpi/acpica/tbxfroot.c b/drivers/acpi/acpica/tbxfroot.c
>>> index 483d0ce5180a..dac1e34a931c 100644
>>> --- a/drivers/acpi/acpica/tbxfroot.c
>>> +++ b/drivers/acpi/acpica/tbxfroot.c
>>> @@ -108,8 +108,7 @@ acpi_status acpi_tb_validate_rsdp(struct
>> acpi_table_rsdp *rsdp)
>>>   *
>>>
>>>
>> ******************************************************
>> ****************
>>> ********/
>>>
>>> -acpi_status ACPI_INIT_FUNCTION
>>> -acpi_find_root_pointer(acpi_physical_address *table_address)
>>> +acpi_status acpi_find_root_pointer(acpi_physical_address
>>> +*table_address)
>>>  {
>>>  	u8 *table_ptr;
>>>  	u8 *mem_rover;
>>> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h index
>>> 7aa38b648564..869d75ecaf7d 100644
>>> --- a/include/acpi/acpixf.h
>>> +++ b/include/acpi/acpixf.h
>>> @@ -474,7 +474,7 @@
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>> ACPI_INIT_FUNCTION
>> ACPI_EXTERNAL_RETURN_STATUS(acpi_status ACPI_INIT_FUNCTION
>>>  			    acpi_reallocate_root_table(void))
>>>
>>> -ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>> ACPI_INIT_FUNCTION
>>> +ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>=20
> @JK
>=20
> Do you see any issues with this? Does free BSD use ACPI_INIT_FUNCTION?

No, FreeBSD doesn't use ACPI_INIT_FUNCTION.

Jung-uk Kim

>> acpi_find_root_pointer(acpi_physical_address
>>>  						   *rsdp_address))
>>>  ACPI_EXTERNAL_RETURN_STATUS(acpi_status
>>> --
>>> 2.20.1
>>>
>>
>> Kairui, thanks for the patches, did a test, it works for me.
>>
>> Seems the two patches are not in a thread, can you resend them
>> together?


--mieEiLY0mmroyULfkOB9Qb5qQ9GgyAIYK--

--JayVUwV80EyeDMxL7BWbW9QB8TamJgw0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEl1bqgKaRyqfWXu/CfJ+WJvzb8UYFAlw/qPcACgkQfJ+WJvzb
8UaTUAf/d659OuS0Ee3fdUfkLGEsjoeeyHNBx5FDoHOOkemCYI9/jiEdveBSP1c8
XxGTUQGcnk+HHISp97lwC7+sQ1hGOlpUZJGp+N6mAA1U6wJfBDCGnb63diwT6+Uo
gKm1Hs5rO3aX5TFRX6/LRuXBSA/5PaMLntFjmMnKcUCRO2qwUjvvg5lJmSZn4trY
24A4eQOpUcJ6RpLFeCL50fKeFOr/6H7VLCRlXofrl6spaVf2lgPxZJ+8EZJN3om+
W+yEuJ1WE0Kc4Wowa9MV8qMtcZ7HW4tBcdEIgRuIPGXSRCkdh39IrTf9qmMNo8Fw
s53Dz+ZdJV+dK7IyPqrsAs+3R9Af6A==
=4Yc5
-----END PGP SIGNATURE-----

--JayVUwV80EyeDMxL7BWbW9QB8TamJgw0w--
