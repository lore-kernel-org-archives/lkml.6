Return-Path: <richard@nod.at>
X-Google-Smtp-Source: AH8x224PqgDSMIZE4KSplN2MgyuceUKoUjWN/531IZNsMTdGtwN96uNRJ5GbFcKkqMFuS5dYIipq
ARC-Seal: i=1; a=rsa-sha256; t=1519145673; cv=none;
        d=google.com; s=arc-20160816;
        b=bBoWySUrN3nOfghRIZ64sR/NqNIeqd00d3jq0rm2OlNdLyzpfO/vAcSVAjHfLI9DzM
         YOWbHLAWlXHvIZCy9aSDM6/kXmSJpiVuEO/R/I0mWAq28pYlGeqXVJwlyNgGixoJO44t
         MN1wWhxSmet6qWdIofaiB3mhMaDs36Sk57BFVcmy4Nuc4K7AqiR4xvXDMeJxl5IVpCoY
         xUldDNstT3qwPNudHLYL4i7QPVamXMXfFixxhvYG1CZjkvk6CiJm2Pk+IJxpEnqewrdn
         +1vYvpjkgTqW4OIxH7HjbScOT81hRmhFYebCQ+58e2LHOrxqZA3tU0utwq5FB3wN+mRb
         gR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=7+Z/uOd+IoG0JTN+RdTmXXIbBA6cW1gq2MYj9TGxOlk=;
        b=Rrxigjd2fMZo46O6qnYSgdf9K73AjgetFa0ybL1t409wk9SJt7coj4wX7uJL24mgNX
         TVgZpbDn+aP5QCiG2jlw9o2+Z0IztqlzOcQyHK36J+bTCC4hNyC5AShkWavI5G4vsSjp
         TG1m4XhqTDuuie5q9jyO+rKtum8OjK+ij2MT/hoWXIXaP+/MDc9b05YAr5Gcd1ZkN/R5
         o9mr900zdjv/WMpJ3/P65sy1Z66jNlG9FhCAI934Okb7B4ROSu/tJCaFCZhbh4P0pywS
         ASrLurCDra3H9ae2A5KfxImD2Cw+aSjGMFDKFvsVCLkQNKC+pUyDo//46R2wJ//xrnvS
         N8rA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning richard@nod.at does not designate 109.75.188.150 as permitted sender) smtp.mailfrom=richard@nod.at
From: Richard Weinberger <richard@nod.at>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kate Stewart <kstewart@linuxfoundation.org>, Nicholas Piggin <npiggin@gmail.com>, Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, david@sigma-star.at, kbuild-all@01.org, Sam Ravnborg <sam@ravnborg.org>, Arnaud Lacombe <lacombar@gmail.com>, Nick Bowler <nbowler@elliptictech.com>, Michal Marek <mmarek@suse.cz>, Nicolas Pitre <nico@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2] kbuild: Don't source kernel config
Date: Tue, 20 Feb 2018 17:55:51 +0100
Message-ID: <2045626.ePW2a4dgOU@blindfold>
In-Reply-To: <CAK7LNARDG3TaMsSH__u9W_RmxcwrMZsrfn82L3Cf8Ec9N2jodg@mail.gmail.com>
References: <20180219092245.26404-1-richard@nod.at> <1919455.eZKeABUfgV@blindfold> <CAK7LNARDG3TaMsSH__u9W_RmxcwrMZsrfn82L3Cf8Ec9N2jodg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592820606337824892?=
X-GMAIL-MSGID: =?utf-8?q?1592939692987333898?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Dienstag, 20. Februar 2018, 17:30:10 CET schrieb Masahiro Yamada:
> > That way the conf tool will sanitize the .config before shell scripts will
> > source it.
> 
> This approach seems better.

Okay, let's go for it. :)
I went first for the ugly bash approach because it is a white list and not a 
black list filter.

Thanks,
//richard
