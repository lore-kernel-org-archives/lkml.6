Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756909AbeDBTIq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 15:08:46 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:41651 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756782AbeDBTIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 15:08:44 -0400
X-ME-Sender: <xms:u3_CWsnkcyaEqsLvgY74k8oHuPH7jknoxJT97JZYz4u4_83Hi9IwIw>
Date: Mon, 2 Apr 2018 16:08:37 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Alexander Kappner <agk@godking.net>
Cc: ibm-acpi@hmh.eng.br, dvhart@infradead.org, andy@infradead.org,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add Second Fan Support for Thinkpad P50
Message-ID: <20180402190837.mlwkviu2syhv6re6@khazad-dum.debian.net>
References: <1522693621-3124-1-git-send-email-agk@godking.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522693621-3124-1-git-send-email-agk@godking.net>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Apr 2018, Alexander Kappner wrote:
> The Thinkpad P50 has 2 fans. Add the 2FAN quirk so the tpacpi driver
> properly reports both fan speeds.
> Because the P50 doesn't report the version of its EC controller, we need to
> identify it by BIOS version (N1).
> 
> Signed-off-by: Alexander Kappner <agk@godking.net>

I assume you tested this on real hardware?  If so:

Acked-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index d5eaf3b1..ebdc300 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -8699,16 +8699,24 @@ static const struct attribute_group fan_attr_group = {
>  	  .ec = TPID(__id1, __id2),		\
>  	  .quirks = __quirks }
>  
> +#define TPACPI_FAN_QL_BIOS(__id1, __id2, __quirks)	\
> +	{ .vendor = PCI_VENDOR_ID_LENOVO,	\
> +	  .bios = TPID(__id1, __id2),		\
> +	  .ec = TPACPI_MATCH_ANY,		\
> +	  .quirks = __quirks }
> +
>  static const struct tpacpi_quirk fan_quirk_table[] __initconst = {
>  	TPACPI_FAN_QI('1', 'Y', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '8', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '6', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QI('7', '0', TPACPI_FAN_Q1),
>  	TPACPI_FAN_QL('7', 'M', TPACPI_FAN_2FAN),
> +	TPACPI_FAN_QL_BIOS('N', '1', TPACPI_FAN_2FAN) // Thinkpad P50 has 2 fans
>  };
>  
>  #undef TPACPI_FAN_QL
>  #undef TPACPI_FAN_QI
> +#undef TPACPI_FAN_QL_BIOS
>  
>  static int __init fan_init(struct ibm_init_struct *iibm)
>  {

-- 
  Henrique Holschuh
