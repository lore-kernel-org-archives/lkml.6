Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967491AbeEXPlJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 11:41:09 -0400
Received: from asavdk3.altibox.net ([109.247.116.14]:50174 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967064AbeEXPlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 11:41:06 -0400
Date: Thu, 24 May 2018 17:41:01 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Ulf Magnusson <ulfalizer@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Michal Marek <michal.lkml@markovi.net>
Subject: Re: [RFC PATCH 1/1] kconfig: drop localization support
Message-ID: <20180524154101.GA12927@ravnborg.org>
References: <20180522194928.GA29900@ravnborg.org>
 <CAK7LNAQUF6YbHRTJOtQ9F91M-iqF1U+PemDAbsdx3qzcqg4Ufw@mail.gmail.com>
 <CAK7LNAQWHeR71=H5Z94jAMjRjE-kmjFaPrQy6_cd5=G_WHEpUw@mail.gmail.com>
 <20180523044609.GA23800@ravnborg.org>
 <CAK7LNARata6s_Dm_ykVNX2o15psE0LyuFvXQFESa7=n58s+nxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARata6s_Dm_ykVNX2o15psE0LyuFvXQFESa7=n58s+nxg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=ddpE2eP9Sid01c7MzoqXPA==:117 a=ddpE2eP9Sid01c7MzoqXPA==:17
        a=kj9zAlcOel0A:10 a=06aqjJ_2AAAA:8 a=pZinbwrU84Ecyjas8O4A:9
        a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro

> 
> When I applied this, I added the following fix-up.
> 
> 
> 
> diff --git a/scripts/kconfig/.gitignore b/scripts/kconfig/.gitignore
> index 54266f3..0aabc1d 100644
> --- a/scripts/kconfig/.gitignore
> +++ b/scripts/kconfig/.gitignore
> @@ -2,7 +2,6 @@
>  # Generated files
>  #
>  *.moc
> -*.mo
> 
>  #
>  # configuration programs
> 
> 
> 
> 
> .mo is no longer generated.
> 
> It was added by
> commit c26dd719a5b9d94d12211f2d101bd7dffb7f9f1f
> 
> 
> 
> Please double-check if it is OK.

I left it as I was not sure where the .mo extension came from.
And trying out the different frontends did not generate
any .mo files (I tried with a kernel before my patches).

So I assume the .mo extension was added because it is
often seen in combination with .pot files,
and not because the kernel actually generated such file.

See https://make.wordpress.org/polyglots/handbook/glossary/#mo-files
for a short description of the .mo files.

In other words - the fixup is correct. Thanks!

	Sam
