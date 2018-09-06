Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F740C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E772064D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 09:51:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E772064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernkonzept.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbeIFO0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 10:26:07 -0400
Received: from serv1.kernkonzept.com ([88.99.87.17]:47297 "EHLO
        mx.kernkonzept.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbeIFO0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 10:26:07 -0400
X-Greylist: delayed 1768 seconds by postgrey-1.27 at vger.kernel.org; Thu, 06 Sep 2018 10:26:05 EDT
Received: from ip5f5b9406.dynamic.kabel-deutschland.de ([95.91.148.6] helo=localhost.localdomain)
        by mx.kernkonzept.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
        id 1fxqUG-0000xv-Ot; Thu, 06 Sep 2018 11:22:04 +0200
From:   Philipp Eppelt <philipp.eppelt@kernkonzept.com>
Openpgp: preference=signencrypt
Autocrypt: addr=philipp.eppelt@kernkonzept.com; prefer-encrypt=mutual;
 keydata=
 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
 khuLCBwcsLPhxbjZ6s1AXffYGA==
Subject: x86/apic: MSI address malformed for "flat" driver
To:     linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>
Message-ID: <d407ee89-3d6c-b55d-d633-abf7644e9766@kernkonzept.com>
Date:   Thu, 6 Sep 2018 11:22:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe the x86/APIC implementation does not behave according to the
Intel SDM specification, when it comes to composing MSI messages for the
"flat" APIC driver as of a31e58e129f73ab5b04016330b13ed51fde7a961 .


APIC "flat" driver and MSI address composing from the current master
(2018-09-02, 60c1f89241d49bacf71035470684a8d7b4bb46ea):

  static struct apic apic_flat __ro_after_init = {
  ...
	.irq_delivery_mode		= dest_Fixed,
	.irq_dest_mode			= 1, /* logical */
  ...
	.calc_dest_apicid		= apic_flat_calc_apicid,
  };


  static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg
*msg) {
  ...
	msg->address_lo =
		MSI_ADDR_BASE_LO |
		((apic->irq_dest_mode == 0) ?
			MSI_ADDR_DEST_MODE_PHYSICAL :
			MSI_ADDR_DEST_MODE_LOGICAL) |
		MSI_ADDR_REDIRECTION_CPU |
		MSI_ADDR_DEST_ID(cfg->dest_apicid);
  ...
  }

The "flat" driver defines the MSI addressing scheme to be used as
logical addressing in flat mode. The MSI msg address is composed
accordingly, but sets MSI_ADDR_REDIRECTION_CPU which is a zero at bit[3].

The intel SDM states for the MSI address format (SDM vol.3 10.11):
31-20  0xfee
19-12  Destination ID (DID)
11-4   Reserved
3      Redirection Hint (RH)
2      Destination Mode (DM)
1-0    XX

The relation of RH and DM is, if RH is 0, DM is ignored and the DID
field is interpreted the same as are bits [63:56] in the IO-APIC,
meaning as local APIC ID.

If RH is 1 and DM is 0, physical addressing is used (see the
apic_physflat driver).
If RH is 1 and DM is 1, logical addressing is used which splits up into
flat and cluster mode determined by the APICs DFR and LDR using the
logical APIC address.


Currently, irq_msi_compose_msg composes for the "flat" driver an address
like 0xfee0'1004 for a 64-bit single-core system without IO-APIC and MSI
remapping and no ACPI (a virtual system).

That's incorrect because RH == 0 means the DID should show a local APIC
ID, but it shows a logical APIC ID for logical flat addressing (DM == 1,
DFR[31:28] == 0).
The LDR register is correctly set up as well, so the behavior is
consistent, but completely ignores the RH value.

The DID calculation producing the local APIC ID should be done by
"apic_default_calc_apicid", when the RH bit is not set.


That's my analysis I want to put up for discussion.

I hope to have included all necessary information on my setup, please
let me know if I missed something.


I don't have an overview over all affected parts in and around the APIC,
so I am currently not able to produce a patch (besides just changing
.calc_dest_apicid which makes the "flat" driver inconsistent).


Cheers,
Philipp


p.s. I am on vacation the next three weeks starting Saturday, so forgive
me for not answering in the meantime.


Kernel config: x86_64_defconfig
+
CONFIG_KERNEL_XZ=y
CONFIG_BLK_DEV_INITRD=y
CONFIG_CC_STACKPROTECTOR_REGULAR=y
CONFIG_PCI_MSI=y
CONFIG_OF=y
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_SIZE=16384
CONFIG_VIRTIO_BLK=y
CONFIG_SERIO_RAW=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_VIRTIO_CONSOLE=y
CONFIG_HW_RANDOM_VIRTIO=y
CONFIG_VIRTIO_PCI=y
# CONFIG_VIRTIO_PCI_LEGACY is not set
CONFIG_VIRTIO_INPUT=y
CONFIG_EXT3_FS=y
CONFIG_TMPFS=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=7
CONFIG_DEBUG_FS=y
CONFIG_STACKTRACE=y
CONFIG_MEMTEST=y


virtual System:
x86-64 64-bit UP, 128MB RAM, no ACPI, no MSI remapping, no IO-APIC

-- 
philipp.eppelt@kernkonzept.com - Tel. 0351-41 883 221
http://www.kernkonzept.com
