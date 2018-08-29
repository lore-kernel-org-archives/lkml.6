Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577A1C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE792064E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 16:59:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxUwaW71"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBE792064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeH2U5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 16:57:25 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:46312 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbeH2U5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 16:57:24 -0400
Received: by mail-oi0-f66.google.com with SMTP id y207-v6so10341123oie.13;
        Wed, 29 Aug 2018 09:59:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XXO5gIdr3OjiR6S02XZJ6gMS+ckd4hcKuNUkjOa1fwE=;
        b=JxUwaW71WdVrgrTBVzC9Mo5SkUCYkuNhc/16uCJvTodsmOedv0HWDze1b/elk8MkEP
         VaDVBlaLmfGSAxD+xjgGHh/rlIThlCpPrbJOCwlp7gd5u8bRVmLk53APEzL8bm0nVZa3
         7Nigk2/L+80sQ2a5wxfgWY+z9f7+GsjAUOMf72t7l9NNmQLPbCdyU7Y4CaApRS/Hi9p4
         CXdMC2dH+aCInN5kT1Kr3jcpzIA9S72y0wH9fZ4YrvvXY4Q6yyBqz4R78QrZMDF9oYCb
         G/FB4RHFto6pHjddR95uc35GyDNyr8hFboQl6PmfdZPLWYRKPmLjhmy1KHe4FVvoe4Oe
         1oTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XXO5gIdr3OjiR6S02XZJ6gMS+ckd4hcKuNUkjOa1fwE=;
        b=Sjw2y6usLusi/Tsu0ELPJEUXTcJac+k+XvsCrVOsDCai1VdntZpKwkQSaxIbHSmNSS
         gIHY/VgrrqjZMYBq5l+z8PH+ReFbRgB8FGbleqtfuJM6jiN71+7dgYbDRZdpmtSiIiIb
         Vtv/WaaUHXccIXqZiXoUHWTH94RWrN7fcqxaqQ1wWG03QWxYSmWCMHc3iUtyOYHh1wIb
         d9/cWVTNBYm9YK0os2nBOcNgTH4idIn2y3/SgRM6AxSge9BKP6S6F9VFs3T4mlNH3FRj
         +w7uu8KBb8vHYgQ02ENex0kdjGSrj02bAjX46TydJgfXjm5F3bOXDNokjfEiFd2Qdkcl
         HFpg==
X-Gm-Message-State: APzg51A2iEA6vwJPL4+cVwFx+9qhHa47lHES6NGek1Oz5NgTK2XfO2Pd
        fN4+LzsDSgrIQ8qGjjLUFxPC+6UXmNY=
X-Google-Smtp-Source: ANB0VdYLpHDBqa6AUCFo66hL5V+K0VrolL9VyIDcVs8to9qM+9tU3hLs0wcyJoegO20TDx9vg3j57Q==
X-Received: by 2002:aca:d44a:: with SMTP id l71-v6mr3757597oig.199.1535561975304;
        Wed, 29 Aug 2018 09:59:35 -0700 (PDT)
Received: from nuclearis2-1.gtech (c-98-195-139-126.hsd1.tx.comcast.net. [98.195.139.126])
        by smtp.gmail.com with ESMTPSA id t141-v6sm6141987oif.18.2018.08.29.09.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 09:59:34 -0700 (PDT)
Subject: Re: [PATCH] PCI/MSI: Don't touch MSI bits when the PCI device is
 disconnected
To:     linux-pci@vger.kernel.org, bhelgaas@google.com
Cc:     keith.busch@intel.com, alex_gagniuc@dellteam.com,
        austin_bolen@dell.com, shyam_iyer@dell.com, Narendra_K@Dell.com,
        Stuart_Hayes@Dell.com, lukas@wunner.de,
        linux-kernel@vger.kernel.org
References: <20180730212146.31909-1-mr.nuke.me@gmail.com>
From:   "Alex G." <mr.nuke.me@gmail.com>
Message-ID: <d0b5fa66-e16d-8686-79e2-4d7177cd4806@gmail.com>
Date:   Wed, 29 Aug 2018 11:59:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180730212146.31909-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Should I resubmit this rebased on 4.19-rc*, or just leave this patch as is?

Alex

On 07/30/2018 04:21 PM, Alexandru Gagniuc wrote:
> When a PCI device is gone, we don't want to send IO to it if we can
> avoid it. We expose functionality via the irq_chip structure. As
> users of that structure may not know about the underlying PCI device,
> it's our responsibility to guard against removed devices.
> 
> irq_write_msi_msg is already guarded. pci_msi_(un)mask_irq are not.
> Guard them for completeness.
> 
> For example, surprise removal of a PCIe device triggers teardown. This
> touches the irq_chips ops some point to disable the interrupts. I/O
> generated here can crash the system on machines with buggy firmware.
> Not triggering the IO in the first place eliminates the problem.
> 
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
> 
> There's another patch by Lukas Wunner that is needed (not yet published)
> in order to fully block IO on SURPRISE!!! removal. The existing code only
> sets the PCI_DEV_DISCONNECTED bit in an unreasonably narrow set of
> circumstances. Lukas' patch fixes that.
> 
> However, this change is otherwise fully independent, and enjoy!
> 
>   drivers/pci/msi.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
> index 4d88afdfc843..5f47b5cb0401 100644
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -227,6 +227,9 @@ static void msi_set_mask_bit(struct irq_data *data, u32 flag)
>   {
>   	struct msi_desc *desc = irq_data_get_msi_desc(data);
>   
> +	if (pci_dev_is_disconnected(msi_desc_to_pci_dev(desc)))
> +		return;
> +
>   	if (desc->msi_attrib.is_msix) {
>   		msix_mask_irq(desc, flag);
>   		readl(desc->mask_base);		/* Flush write to device */
> 
