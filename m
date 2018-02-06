Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1517930690; cv=none;
        d=google.com; s=arc-20160816;
        b=UexzNtV7KKuL7nKAOrNV7Ubjfz2jsAXRi1r1g1WwBAtf+MRIOJPYfhxVMxL2Y3QEQh
         m9YgCqp1n4d0ESODfQqlacXyiNvN7NVGEC+pNhzYnqbauhM3Asrke52q5HZBlkwMGsD4
         SqvJSM0WoAiildzsLrKoxgc/V1JIbdwI/0gyOUlu4P/cIVoR5hIrWmquieiBOZwub4OH
         LKsbtqeY/rylcRNhLiIXDLT3nXFscUUVKUzYDwGJzvA0nXe1M65meUVgMANPhjZ77ZpY
         QY637TfKXMBWs+thb44ML9pV9pbXanpAaNIDZFPH6lCbqonCGy1RLEIecWNuwxfe724b
         o67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eL5iE1Soc64QVLlhmLSiDFrKYvxR+Zi2aKHDql6n9m4=;
        b=B1aNooyFQek5WZrFX1ffuvzkK1kQHhm1Ie7WJifUqyaoQcWY3HhcJXSkafyKXxOmZl
         L5WGsZ61TlWeyGZIaGCeYeK2COYe16lgFry9qhnTw/IDlVEH8YZPdrTLtwfRntoJrEwj
         Rt5krQFjdHo1HnmSCgfASWILNDbmAjSx7EuvbzU5Uyb0H25x1HFROYsBRoArZ2isMNAC
         5noatKummkO/j4OalD212f87rmBFDpM65dBYtXjNzNR8ENwPJfhutKijcwFlpgQYbK6q
         eG6z3rgjxvl92o/rn/dKBZ11FiyXgtGHmK9UHQrNxWp/T9vk/46GyEzHSRGtsF/klfpx
         0zLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M0VXiKiE;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=M0VXiKiE;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AH8x226V727tdTLdfbCzhg6TLEIPqTtNusXNBrhp4Ciz8ploL2ZFS6gOhox+7IR30Xhmbc2a7FcijcYhTy9Dk8L87Bc=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <c68d8b8b-dc46-2066-0341-558f57ad113f@arm.com>
References: <1517912092-15470-1-git-send-email-geert@linux-m68k.org> <c68d8b8b-dc46-2066-0341-558f57ad113f@arm.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 6 Feb 2018 16:24:49 +0100
X-Google-Sender-Auth: TKKlXZa1eJ-w_G6U6B9_VonB5Gc
Message-ID: <CAK8P3a1K+N54DeTcq4CL76GTD0Nb3WwozN3YoNdnrQW_2oC6jA@mail.gmail.com>
Subject: Re: [PATCH/RFC 0/6] Allow compile-testing NO_DMA
To: Robin Murphy <robin.murphy@arm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Mark Brown <broonie@kernel.org>,
	Richard Weinberger <richard@nod.at>, Felipe Balbi <balbi@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>, linux-usb@vger.kernel.org,
	linux-scsi <linux-scsi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591646200835555929?=
X-GMAIL-MSGID: =?utf-8?q?1591665691462375768?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 2:05 PM, Robin Murphy <robin.murphy@arm.com> wrote:
>
> It looks like we have only one real arch (score) without IOMEM, and two
> (s390 and tile) where it is possible to configure out, so it does seem like
> a reasonable feature to assume. Maybe we could have something like
> asm-generic/no-io.h to provide an "unimplemented" version of those
> interfaces.

Agreed, there is no use trying to optimize for any of those three cases:

For s390, all new machines come with PCI, so distros will enable it all
the time. Few users run their own kernels even on older machines.

score has been de-facto unmaintained for a few years, and tile has
recently been orphaned with the hardware platform being abandoned by
Mellanox.

      Arnd
