Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525938357; cv=none;
        d=google.com; s=arc-20160816;
        b=RdxvXMlkEEKS8+XVX2t3XOBstHLlf8MOgmpBIikIcG/ScH2ftDFNMRpVwYLPChApZn
         m3aSzsy5zczk6HwIBtjER4KmclHrs0TwzlLlulTQTpL6Gbs+23WW7+70+A1oJW9PnW3n
         rkq1dEMeb4e57/wxuAtZfAAYu2ERVsFgSque7yDXSDh5dz5fYBVjpDrMgm32SuMPatxe
         XZzfT82br5Y9CmLFJ/i8R4MhV5izeynm7M+7YhFXpchbWORUmUA7ttS8tF99xmYlo716
         xTvWuM011k6Axg/w996ZLhIVLF1QMblWzTs7rYM+ZigP10aOxNlSL0Vs+27UdBZ2O1Jx
         NZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=FWpyBe68tWBbdphKbspjC1JFmW2kdnVynLcPyRA8rg0=;
        b=DN+3iM19bYGw7e1v4p7qxNe+S5qoBV8tov4JfCT2DndZboTbg0QCfYPMtbOiMbkODs
         mt5joBr11gCSfeEhaNtLjz+NJKkEK9r/teUy5acVsuZYCSx+3QDZcbXQC2wZShKF99KZ
         Ax7xcmWDVzhcaCWLDhqAPVOOV7OKjJgQc90pWb/9+FvXxscll4KaOOz0pdr6Mk9E5LT0
         rG0XXr8tSrpA/3rCm0jUuZysIyIEI0sDWnzIhgEI620wX3XMr29f2uiFs3wxbEXgX2Vb
         Et8MKGJbg6Ubve/B/8etgqCej4ppNS9pBW8zCTQfKdJF1XVmGrpfMLb9Bsp9YQioEnIw
         UOfw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lcK5W3tD;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lcK5W3tD;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZpqWA/X+xpChQEXuGf7IVym5TxdnJpDYApJ+eFb7Ty4VtXS/Q7VD99yxJKigkuA5Cw2BSgh7ZB+adDMRPh/T6E=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180510014447.15989-3-mcgrof@kernel.org>
References: <20180510014447.15989-1-mcgrof@kernel.org> <20180510014447.15989-3-mcgrof@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 May 2018 09:45:56 +0200
X-Google-Sender-Auth: hIzYKB9M6wj25e1V8FEX4uWFuXs
Message-ID: <CAMuHMdUJTKqqWzFi594_y_F1HdONr3+FOSTzg-n0ogoroFUqpA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: provide a fallback for PAGE_KERNEL_EXEC for architectures
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>,
	Linux-Arch <linux-arch@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600039619823069048?=
X-GMAIL-MSGID: =?utf-8?q?1600062339943713366?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Luis,

On Thu, May 10, 2018 at 3:44 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Some architectures just don't have PAGE_KERNEL_EXEC. The mm/nommu.c
> and mm/vmalloc.c code have been using PAGE_KERNEL as a fallback for years.
> Move this fallback to asm-generic.
>
> Architectures which do not define PAGE_KERNEL_EXEC yet:
>
>   o alpha
>   o mips
>   o openrisc
>   o sparc64

The above list seems to be far from complete?

> Suggested-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
