Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A730C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18CF6214F1
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 04:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dA12UGYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18CF6214F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730771AbeKLOr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 09:47:58 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41444 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728145AbeKLOr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 09:47:58 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so7780860wrt.8
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 20:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=xu1IZuqA6faHEnkD5n1kGjqtwEl3Lta0WHrSPEEkIqE=;
        b=dA12UGYPdsjBRdT+3JUVzFJlSPgxz7ALQXMAWC/SAubevN+Hg09TaODcx6wb26WRof
         0xUb2out3G6B0/IYvVtLntGd/Zm0/nRtelDrft4hqZ9AQqOwyEw2K9q00ufXtsaZun8v
         rD578xAJ2pfUskKhnj0F3D/scjPsmSBB7jl3+ohQ3bT1VCniM8G7pTTMHa9fZa7g81lB
         93W2yVhBf772/+a4v5xIZUAex/CTCVlMlCaGMbZSX05Lu4lPlyaxtGNeJF7hKdrpMofb
         48veh1XwFX3bgkpliqlkHF10ObDFUXG8o3ZuqxA9r/p5Ny+llj4kHukE0/JQXW0gllLM
         x6pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=xu1IZuqA6faHEnkD5n1kGjqtwEl3Lta0WHrSPEEkIqE=;
        b=qq3ErMTewBtzyFF44hUqbpt6x527AWeb2BoeJnJwyndelVhm+VDO0cPi7A10x3cNAU
         FmF0eGgJiAMSxt4o5ylOFedu/K50vA+aj+gJ6jdKU3XFvsDX+C83xK9qrFclpYDV1PRR
         xvtt4vI72s3l85nfzcf/yEUzdqQu1mBPjvtDcb7yVik3Z/bVVLZoHv3QxyzmkhsgkkSL
         Ax5+VFoWM5vmyB6Xi7jXMevr6av3W9tUJ9/1lcgNd2N0wvn2mR5qXxsPCdS8g+b7bsR+
         JlHLXdLGN3F6tJjLAbCVCcXAnq/KBfWmpWEJvPG0Aso8oIATz/W8KKsZ1hE2KX/3TrEf
         pxVA==
X-Gm-Message-State: AGRZ1gIvn4dap5vN5Dm12d7frMWSEBatgV+UhkKhYYVaVf71y7IyfcV1
        eq/YXZb6RAk7oZv3V4DEtak=
X-Google-Smtp-Source: AJdET5dRr9PgCv/6wkWUznUTQOxXsNZoZsJAl4Tw2E2d9YQfEhxxs6yIf9XqNF/fw5fsRfgMtfkQHg==
X-Received: by 2002:a5d:4b4c:: with SMTP id w12-v6mr15873615wrs.85.1541998587551;
        Sun, 11 Nov 2018 20:56:27 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id y16-v6sm23395374wrn.18.2018.11.11.20.56.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 11 Nov 2018 20:56:26 -0800 (PST)
Date:   Mon, 12 Nov 2018 05:56:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Li Zhijian <zhijianx.li@intel.com>,
        Juergen Gross <jgross@suse.com>,
        Li Zhijian <lizhijian@cn.fujitsu.com>,
        Peter Maydell <peter.maydell@linaro.org>, x86@kernel.org,
        bp@alien8.de, mingo@redhat.com, tglx@linutronix.de,
        QEMU Developers <qemu-devel@nongnu.org>,
        Philip Li <philip.li@intel.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 1/3] i386: set initrd_max to 4G - 1
 to allow up to 4G initrd
Message-ID: <20181112045624.GA28219@gmail.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
 <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
 <CAFEAcA_47wyar3WNhuBmNPdr02RHx-wn_TeyFaajpjzvzG8j5Q@mail.gmail.com>
 <c50d103e-95c3-c44c-d852-b6d7f8114b3a@cn.fujitsu.com>
 <20181109072015.GA86700@gmail.com>
 <38905d35-29af-b522-1629-b13e98a47a42@intel.com>
 <d30b404d-624e-0497-879a-2d5df2eb9f31@suse.com>
 <b7b608dc-1743-5e1f-3b88-94d784c4cab2@intel.com>
 <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9c293bd-b43f-999c-55f1-3b90a6020065@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* H. Peter Anvin <hpa@zytor.com> wrote:

> On 11/9/18 5:40 AM, Li Zhijian wrote:
> > Just noticed that there is a field xloadflags at recent protocol
> >   60 Protocol 2.12:  (Kernel 3.8) Added the xloadflags field and
> > extension fields
> >   61                 to struct boot_params for loading bzImage and ramdisk
> >   62                 above 4G in 64bit.
> > [snip]
> >  617 Field name:     xloadflags
> >  618 Type:           read
> >  619 Offset/size:    0x236/2
> >  620 Protocol:       2.12+
> >  621
> >  622   This field is a bitmask.
> >  623
> >  624   Bit 0 (read): XLF_KERNEL_64
> >  625         - If 1, this kernel has the legacy 64-bit entry point at
> > 0x200.
> >  626
> >  627   Bit 1 (read): XLF_CAN_BE_LOADED_ABOVE_4G
> >  628         - If 1, kernel/boot_params/cmdline/ramdisk can be above 4G.
> >  629
> > 
> > maybe we can reuse this field and append a new Bit 5
> > XLF_INITRD_MAX_SIZE_4G and increase header version.
> > For the old protocol version 2.12+, if  XLF_CAN_BE_LOADED_ABOVE_4G is
> > set, we can also realize ~4GB initrd is allowed.
> > 
> > bootloader side:
> > if protocol >= 2.15
> >    if XLF_INITRD_LOAD_BELOW_4G
> >       support ~4G initrd
> >    fi
> > else if protocol >=2.12
> >    if XLF_CAN_BE_LOADED_ABOVE_4G
> >     support ~4G initrd
> >    fi
> > fi
> > 
> 
> The two are equivalent.  Obviously you have to load above 4 GB if you
> have more than 4 GB of initrd.  If XLF_CAN_BE_LOADED_ABOVE_4G is not
> set, then you most likely are on a 32-bit kernel and there are more
> fundamental limits (even if you were to load it above the 2 GB mark, you
> would be limited by the size of kernel memory.)
> 
> So, in case you are wondering: the bootloader that broke when setting
> the initrd_max field above 2 GB was, of course, Grub.
> 
> So just use XLF_CAN_BE_LOADED_ABOVE_4G. There is no need for a new flag
> or new field.

That's nice, and that's the best solution!

> Also note that the ext_ramdisk_image and ext_ramdisk_size are part of
> struct boot_params as opposed to struct setup_header, which means that
> they are not supported when entering via the 16-bit BIOS entry point,
> and I am willing to bet that there will be, ahem, "strangeness" if
> entered via the 32-bit entry point if at least the command line is
> loaded above the 4 GB mark; the initrd should be fine, though.
> 
> This is obviosly not an issue in EFI environments, where we enter
> through the EFI handover entry point.
> 
> The main reason these were not added to struct setup_header is that
> there are only 24 bytes left in that header and so space is highly
> precious. One way to deal with that if we really, really need to would
> be to add an initrd/initramfs type of setup_data.

Is there no way to extend that header by making an extended header part 
of the payload?

IIRC that header is small and fixed size to be part of a single sector at 
the very beginning of boot images, but accessing any extended header bits 
from the payload section shouldn't really be an issue for a modern 
bootloader to handle, right?

Such an extended header could use a more modern (self-extending) ABI as 
well.

Thanks,

	Ingo
