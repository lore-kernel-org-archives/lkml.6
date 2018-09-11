Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7514C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF0A20866
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 18:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdRm+DfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF0A20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728219AbeIKXWu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 19:22:50 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44389 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbeIKXWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 19:22:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id k21-v6so12622476pff.11;
        Tue, 11 Sep 2018 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CRHC2tW1MQsd8iJifE1lmuhOkbWJdHdtx/M/CTrek7Q=;
        b=jdRm+DfEewdJ8y0HbKZHK3e2mRCn+VZ0I5ynX9CmVdSIAnSPGH8PBth64Z77hats8L
         pCJy6f9wcIB4Vk8SBnIaOmO/o1fWD+A08cgH8HFN6aMdnKPHCemdOy2irKaxVk6b0WXN
         868INtME4hC8ivuFMaENq7KV7iIL2YYC1zk2+iqyh25yR6JAV3J0MsOvAl7JpBe/aUcO
         NXcpLmXiw9gobZjehiLNRC/ILUJDVG9YenFFD/COH4yhMrAEmPLVKP6wHD3Eeawj8lh/
         AIz8RU20A0V4MPwv6WhS4aFCeO645ONlj1Q2vvfrmTZqlnAJSF4otqFo96gHY3H2U0t4
         osXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=CRHC2tW1MQsd8iJifE1lmuhOkbWJdHdtx/M/CTrek7Q=;
        b=Zo1amz/kEH5P6kpl3NfcMxfdCS48Gzq/iqyhaWB6WS2ytP6y8q7FOvyz7khltlrulW
         mFL6O8OIBxQfVQ+HB9BwBv3H/E8laW7aVEjG9hVMq6plcrawUwS5GvbKWr8VkJwzrsku
         X5phXhMD11PgOU29jgeiFtrfROTGD3VcI4jmmrPa/xpzTEG8TaYB4lCLrJFlWYzDRcbY
         WoNKT/wxNNbOgezPiylgvAyiI1vgy/S2BT9j0QDW9ZpAKJ5/8RJnyLQy3jreze78sCXE
         Xe0xjoQbAap1hQac7/ya9Q9Jx8A/unQo35POb6g+9IU1Lz4ZZSJpODychvNNlm+tgbRu
         vCww==
X-Gm-Message-State: APzg51Cy+7Y8G1T8VzkcgBVixhZrG+1DozVK/WNaMaA11QGA2FmXDTFu
        ROKiQcO1+2lftl5um/9634c=
X-Google-Smtp-Source: ANB0VdaOFXX9+Y+ayWccsfJURqGP+RyhJwiMzm0B1L2R2dpn/RpKzxEmDpb02OryX5bmYGknYeIWqA==
X-Received: by 2002:a63:481:: with SMTP id 123-v6mr30293808pge.129.1536690138491;
        Tue, 11 Sep 2018 11:22:18 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id n79-v6sm48123770pfh.2.2018.09.11.11.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 11:22:17 -0700 (PDT)
Date:   Tue, 11 Sep 2018 11:22:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
Subject: Re: Random crashes with i386 and efi boots
Message-ID: <20180911182216.GA21160@roeck-us.net>
References: <20180910215659.GA17966@roeck-us.net>
 <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
 <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
 <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
 <20180911174158.7qu6f4vfnfzqqrcf@suse.de>
 <51FDF5AF-2FE8-4817-9A5C-8CE4A8BC23AB@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51FDF5AF-2FE8-4817-9A5C-8CE4A8BC23AB@amacapital.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 11, 2018 at 11:05:25AM -0700, Andy Lutomirski wrote:
> 
> 
> > On Sep 11, 2018, at 10:41 AM, Joerg Roedel <jroedel@suse.de> wrote:
> > 
> > On Tue, Sep 11, 2018 at 09:36:51AM -0700, Andy Lutomirski wrote:
> >>>   save_pgd = efi_call_phys_prolog();
> >>>   local_irq_save(flags);
> >>>   status = efi_call_phys(...);
> >>>       local_irq_restore(flags);
> >>> 
> >>>       efi_call_phys_epilog(save_pgd);
> >>> 
> >>> So, yes, interrupts are very much enabled.
> >> 
> >> Does fixing that solve the problem?  It seems more robust.
> > 
> > The problem is still that in efi_call_phys_prolog() we load the gdt with
> > its physical address, and when we reload the %cr3 in _epilog from
> > initial_page_table to swapper_pg_dir again the gdt is no longer mapped.
> > Blocking interrupts is more robust, but we can't block NMIs that way
> > that would also trigger the issue, no?
> > 
> > So I am in favor of changing the order in efi_call_phys_epilog() too.
> > 
> 
> I’m rather confused here.  We’re loading CR3 with page tables that don’t have the fixmap mapped?  With interrupts on?  And we expect it to work?  This is *nuts*.
> 
> There are IMO only three sane fixes here:
> 
> 1. Load the fixmap, cpu_entry_area, etc into the EFI page table.  Drop the GDT reload entirely.
> 
> 2. Do this whole virtual map dance earlier so we don’t have IRQs and NMIs and such. Maybe while we’re still using the initial page table?
> 
> 3. Just identity map all the EFI regions. Make EFI page tables that literally map them at their physical addresses *and* map the entire kernel, just like we do for normal user mms.
> 
> Sure, as a stopgap, turning off IRQs and applying Guenter’s patch seems okay, but this code is not okay.

I submitted a patch with the diff I suggested above; it seems to be the
least invasive solution and addresses the immediate problem.

I am way out of league regarding the other suggested changes. I'll be happy
to test the code if someone is willing to rearrange the code accordingly,
but I don't think it would make sense to even try doing it myself.

Thanks,
Guenter
