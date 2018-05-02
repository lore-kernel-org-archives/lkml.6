Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525255738; cv=none;
        d=google.com; s=arc-20160816;
        b=nLhUF4AvHQ9DgKxctuBSDk1W0/UPYnoBvW/d9nhGrSTvw3JsQEt7IZsMWtENDQ8mF8
         72ezXhY4mD4eFSTZZXh5hlw+D6/igeHiL754USddMxst/sJXsEkwhGf9bFQL7qoYPXxY
         oxVdB9Jy6CBX+x+nfAnopsZg85Zqg/Lun+moFkL/i+mNL0Vz40Xq7G5G9LToIFXS75+u
         nlUQxf4jIgnE4ZSPnVzx2VZBJYD6rMt2wClsqtxmbUEcW1OmW/b22Eln4qr6YNjeJJfK
         k+/4yLKlUqRt5oZiOkItXxYSehOVguFKsTkIa+guIWuFMhd01kbRVuUOyIELwi3sLdNB
         3S3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=xc/X5Yrft0eA0Gh2w+WkQV51b6sLRLSONYJUn6OZua0=;
        b=Cf4bWTl+4sNDVouzZhJpGqWepmY6PqhOLCz5DCJKHJuNotb+ijqigWhpQRBICOl91X
         /L/NFcMaZZISUbIShfZmo8uqDpPCnfr85ipG1ZU9bwnbOyNAFJpkVmYz35OWDgXQ5Q0X
         wGzyJWbi2VOfA5LpmYNvNVgImzHD5tsok8VgDrGp8eVrslElvDwRfSiwjJ73koeunlLL
         WrpC12a+n5GyfrlNA9gonbXUvAF+L5m7OlONOGXL+WI8DvNmkadQm7HpwZNJyXDrspsS
         fXhbWmIp/afp+xhpx0WBDZxExEJ3NHDAmRA6GU0DjNMJElX86K/ASRBUFUUtPZLAUkrD
         VbOA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QyWEYrK5;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=QyWEYrK5;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZpk5MhmdzHXwrC87SzIqBZ7+v96XGeFCz+hKyJjaC1iz5t0KXFrNpS4bty3u4poNLX0fPZhGRSoNTIAIlJh8Xk=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180428001526.22475-1-mcgrof@kernel.org>
References: <20180428001526.22475-1-mcgrof@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 2 May 2018 12:08:57 +0200
X-Google-Sender-Auth: zcLxxUpcsqILuXlleyTQrOG-W_U
Message-ID: <CAMuHMdUpc6=j62E7Xrcid6tKU5FRUZsiSVK7J=KD09epQ=9xfA@mail.gmail.com>
Subject: Re: [PATCH] mm: provide a fallback for PAGE_KERNEL_RO for architectures
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg KH <gregkh@linuxfoundation.org>,
	Linux-Arch <linux-arch@vger.kernel.org>, Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	Linux MM <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946836077947117?=
X-GMAIL-MSGID: =?utf-8?q?1599346560735796570?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Luis,

On Sat, Apr 28, 2018 at 2:15 AM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> Some architectures do not define PAGE_KERNEL_RO, best we can do
> for them is to provide a fallback onto PAGE_KERNEL. Remove the
> hack from the firmware loader and move it onto the asm-generic
> header, and document while at it the affected architectures
> which do not have a PAGE_KERNEL_RO:
>
>   o alpha
>   o ia64
>   o m68k
>   o mips
>   o sparc64
>   o sparc
>
> Blessed-by: 0-day
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

I believe the "best we can do" is to add the missing definitions for the
architectures where the hardware does support it?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
