Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeBHBAe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 20:00:34 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:38916 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751548AbeBHBAd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 20:00:33 -0500
X-Google-Smtp-Source: AH8x224VoFrpRLdTyGpYbmjc2/BV76osf6Z1+ojjr6oeAy2Mbq7pst/PIrIMXZLlBaRm8pcoc6jm1g==
Date: Wed, 07 Feb 2018 17:00:31 -0800 (PST)
X-Google-Original-Date: Wed, 07 Feb 2018 17:00:27 PST (-0800)
Subject: Re: [PATCH] tile/pci_gx: Make setup_pcie_rc_delay __init
In-Reply-To: <20180117034505.26667-1-douly.fnst@cn.fujitsu.com>
CC: linux-kernel@vger.kernel.org, douly.fnst@cn.fujitsu.com,
        bhelgaas@google.com, cmetcalf@mellanox.com, akpm@linux-foundation.org
From: Palmer Dabbelt <palmer@dabbelt.com>
To: douly.fnst@cn.fujitsu.com
Message-ID: <mhng-c0eb9b65-5e20-4217-be8d-cd26b79a2724@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jan 2018 19:45:05 PST (-0800), douly.fnst@cn.fujitsu.com wrote:
> The early_param() is only called during kernel initialization, So Linux
> marks the functions of it with __init macro to save memory.
>
> But it forgot to mark setup_pcie_rc_delay(). So, Make it __init as well.
>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Chris Metcalf<cmetcalf@mellanox.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
> ---
>  arch/tile/kernel/pci_gx.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/tile/kernel/pci_gx.c b/arch/tile/kernel/pci_gx.c
> index 9aa238ac7b35..9a874e98b1cc 100644
> --- a/arch/tile/kernel/pci_gx.c
> +++ b/arch/tile/kernel/pci_gx.c
> @@ -617,7 +617,7 @@ static void fixup_read_and_payload_sizes(struct pci_controller *controller)
>  	}
>  }
>
> -static int setup_pcie_rc_delay(char *str)
> +static int __init setup_pcie_rc_delay(char *str)
>  {
>  	unsigned long delay = 0;
>  	unsigned long trio_index;

Sorry this sat in my inbox for a while.  I talked to Chris and he's not 
maintaining Linux any more.  I maintain the RISC-V port, so I'm not actually 
sure how this got to me, but I don't mind collecting Tilera patches and 
submitting them to Linus.  Note that I don't have any TileGx hardware or even a 
compiler, so it'd be a very low bar for maintenance.

If that's OK with everyone there then I can submit something that's more of a 
direct question to the mailing list.
