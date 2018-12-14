Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C2EC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD719206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jcline.org header.i=@jcline.org header.b="UZ/nhB+6";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="CxOZL6As"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730229AbeLNRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:03:24 -0500
Received: from a8-62.smtp-out.amazonses.com ([54.240.8.62]:60506 "EHLO
        a8-62.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729409AbeLNRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:03:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=jdcmspyxk3papgv75oy2heb62hybqlxr; d=jcline.org; t=1544807002;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding;
        bh=1fpTGc2ZiANBHJ0RVybG6CQqXUXCwvdhwqbmeNm/NH0=;
        b=UZ/nhB+6tQkb2XmrvMiFLwIHydRfIFI/OZJaoghpO0xUv+whdLhb3mbVAso1o6E9
        uk4QXtEogIOQ603uFiYb9OdKCYL8DtLGEsotPUyjHiF5yAR/lGxViiV4itCLbDZuECp
        uHz3xfdtMUIt1wD/H+lLTL2cYAkAsw68RYmKoKy8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ug7nbtf4gccmlpwj322ax3p6ow6yfsug; d=amazonses.com; t=1544807002;
        h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
        bh=1fpTGc2ZiANBHJ0RVybG6CQqXUXCwvdhwqbmeNm/NH0=;
        b=CxOZL6As1fca3I08jXQB+EkUHsHF4BJdnidaA89Kq8j1kBiqD2RwS0Yz5Tzm8aB7
        itSat14+JmoWWzpau9M1Cw73GjkpFGmZppLxbs2QxatW2zN1Z706bEF4r973fiTzdjI
        w3/e4QWutWLHtYZKuDwWDM1j12F7Re9v+0ldFPF4=
X-Virus-Scanned: amavisd-new at jcline.org
Subject: Re: [PATCH 4.19 061/110] ACPICA: AML interpreter: add region
 addresses in global list during initialization
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Jean-Marc Lenoir <archlinux@jihemel.com>,
        Erik Schmauss <erik.schmauss@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jean Delvare <jdelvare@suse.de>,
        Michael J Gruber <mjg@fedoraproject.org>
References: <20181129135921.231283053@linuxfoundation.org>
 <20181129135923.722829835@linuxfoundation.org>
From:   Jeremy Cline <jeremy@jcline.org>
Openpgp: preference=signencrypt
Autocrypt: addr=jeremy@jcline.org; prefer-encrypt=mutual; keydata=
 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
Message-ID: <01000167adac3130-02698b6b-48d9-4496-9ce5-ee5316f5f82c-000000@email.amazonses.com>
Date:   Fri, 14 Dec 2018 17:03:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181129135923.722829835@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SES-Outgoing: 2018.12.14-54.240.8.62
Feedback-ID: 1.us-east-1.z18Isoc/FaoPOvCyJyi1mnTt8STwoRuibXVNoUcvG6g=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

On 11/29/18 9:12 AM, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Erik Schmauss <erik.schmauss@intel.com>
> 
> commit 4abb951b73ff0a8a979113ef185651aa3c8da19b upstream.
> 
> The table load process omitted adding the operation region address
> range to the global list. This omission is problematic because the OS
> queries the global list to check for address range conflicts before
> deciding which drivers to load. This commit may result in warning
> messages that look like the following:
> 
> [    7.871761] ACPI Warning: system_IO range 0x00000428-0x0000042F conflicts with op_region 0x00000400-0x0000047F (\PMIO) (20180531/utaddress-213)
> [    7.871769] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
> 
> However, these messages do not signify regressions. It is a result of
> properly adding address ranges within the global address list>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=200011
> Tested-by: Jean-Marc Lenoir <archlinux@jihemel.com>
> Signed-off-by: Erik Schmauss <erik.schmauss@intel.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Jean Delvare <jdelvare@suse.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> ---
>  drivers/acpi/acpica/dsopcode.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> --- a/drivers/acpi/acpica/dsopcode.c
> +++ b/drivers/acpi/acpica/dsopcode.c
> @@ -417,6 +417,10 @@ acpi_ds_eval_region_operands(struct acpi
>  			  ACPI_FORMAT_UINT64(obj_desc->region.address),
>  			  obj_desc->region.length));
>  
> +	status = acpi_ut_add_address_range(obj_desc->region.space_id,
> +					   obj_desc->region.address,
> +					   obj_desc->region.length, node);
> +
>  	/* Now the address and length are valid for this opregion */
>  
>  	obj_desc->region.flags |= AOPOBJ_DATA_VALID;
> 
>
Fedora has received a couple of reports[0] of boot failures on v4.19
kernels:

kernel: BUG: unable to handle kernel paging request at 00000036000000b6
kernel: PGD 0 P4D 0
kernel: Oops: 0000 [#1] SMP NOPTI
kernel: CPU: 0 PID: 108 Comm: kworker/0:3 Not tainted
4.19.8-300.fc29.x86_64 #1
kernel: Hardware name: Hewlett-Packard HP Compaq 6715b/30C2, BIOS 68YTT
Ver. F.07 07/16/2007
kernel: Workqueue: events work_for_cpu_fn
kernel: RIP: 0010:acpi_ns_build_normalized_path+0x76/0x108
kernel: Code: 31 c0 48 85 ff 74 de 31 d2 49 89 f8 31 c0 4c 39 05 ff 5b
57 01 74 61 4c 39 c7 74 0e 39 c2 76 08 41 89 c1 42 c6 04 0e 2e ff c0
<45> 8b 48 0c 41 89 ca 44 89 4c 24 04 45 31 c9 46 8a 5c 0c 07 45 84
kernel: RSP: 0018:ffffb68740a1fce0 EFLAGS: 00010207
kernel: RAX: 000000000000000a RBX: 0000000000000001 RCX: 0000000000000001
kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9dd2360e7168
kernel: RBP: 0000000000000000 R08: 00000036000000aa R09: fffffffffffffffc
kernel: R10: 0000000000000000 R11: 00000000000000d2 R12: 0000000000008200
kernel: R13: ffff9dd2360e7168 R14: ffff9dd2706980c0 R15: 0000000000000001
kernel: FS:  0000000000000000(0000) GS:ffff9dd275c00000(0000)
knlGS:0000000000000000
kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
kernel: CR2: 00000036000000b6 CR3: 000000007137e000 CR4: 00000000000006f0
kernel: Call Trace:
kernel:  acpi_ns_get_normalized_pathname+0x1f/0x6d
kernel:  acpi_ut_check_address_range+0x8f/0x118
kernel:  acpi_check_address_range+0x40/0x59
kernel:  acpi_check_resource_conflict+0x3a/0x50
kernel:  acpi_check_region+0x61/0x80
kernel:  piix4_probe+0x144/0x658 [i2c_piix4]
kernel:  local_pci_probe+0x41/0x90
kernel:  work_for_cpu_fn+0x16/0x20
kernel:  process_one_work+0x1a1/0x3a0
kernel:  worker_thread+0x30/0x380
kernel:  ? pwq_unbound_release_workfn+0xd0/0xd0
kernel:  kthread+0x112/0x130
kernel:  ? kthread_create_worker_on_cpu+0x70/0x70
kernel:  ret_from_fork+0x35/0x40
kernel: Modules linked in: i2c_piix4(+) parport_pc wmi tpm_infineon
parport ssb hp_accel lis3lv02d mmc_core input_polldev video radeon
i2c_algo_bit drm_kms_helper ttm drm firewire_ohci firewire_core
ata_generic serio_raw pata_acpi yenta_socket crc_itu_t pata_atiixp
kernel: CR2: 00000036000000b6
kernel: ---[ end trace 9c88eedaaeca7db0 ]---

I reverted this patch on v4.19.8 and at least one user (Michael, Cc'd)
reported that fixed the regression.

This patch appears to have been included in v4.19.2 (commit
22083c028d0b), reverted in v4.19.3 (commit 8ef305fbc50d), and finally
included again here in v4.19.6 (commit 87403e35bc56). I couldn't find
a discussion about bringing it back, so maybe it happened accidentally?

[0] https://bugzilla.redhat.com/show_bug.cgi?id=1659225

Thanks,
Jeremy
