Return-Path: <yamada.masahiro@socionext.com>
X-Google-Smtp-Source: AH8x227JL89lgRGUY23Kc/O3zBF4mMS8OXb4yMtTADrNSu42QvrdkKOy6Yk3tjU6ft+5eEtifPog
ARC-Seal: i=1; a=rsa-sha256; t=1517963019; cv=none;
        d=google.com; s=arc-20160816;
        b=Du+opn8sEK3tVdsVaXhiY2cMrAZs5aoDMI0hWDa6A/d3AoM7uhy21s/FbZCpRPYmQM
         OWKhQfws+k9xYz3jMzpgKSruxBVPA4NUEeGzo6SJVFpIkoDyJS9tkpXa5toSrYgZa3OD
         NjJ9Dy8MUk9GIAzHblmjivHpiJeJ6d0Z9H2N5/lV9YFcdEKi/ikKwnN1S/bDxzVLUCD6
         IIYCz46z9Bcw7JyCX7so7/Jo1m3R1VlxWqb909mfZTi6Q38hgNjMrUWuD3mXQnb7vN7R
         k0TJTvc+hmvRQN/n6SnZYnQaH08ykYeG0GNpTFgTuiqD4oAgYORWnnjQjFAdWkUuoaOB
         8XCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=lVyKPZBpXfSgmhutddcQuyA7IvvdO/Kx8l4zdJFpkAE=;
        b=gXFPH6auJuPG61Ic8rNAbpOUQz8FqtDRRBcLsej85EW00nf2NZHAHvaLhshOoaO7uw
         +OdMY35nIwEM0tcbcvbG2mqZKWnDCsQQLvvOG8d3zbP2JzDN/3rz1l8EeYCmigN4DKTS
         odiyDobLMY0LK8XD52wwwEkw4RWKcfDeYHV7wObCUIlH1KjkHKhmylG2i/zCqWlSx7N4
         WSTSqq6LayUmPpDRaUGTTmPR6K/6NyPt8ypnvHVGM+nli70fcaGpF0M9r9zPpTaCuoaC
         15isYig5Mgu1SpzdR72+j/zdXzfJE1fsLbYydcS7idnn5AldJCl1HaguKuFcTfFG+t5Z
         CVfQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mihgZX9n;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nifty.com header.s=dec2015msa header.b=mihgZX9n;
       spf=softfail (google.com: domain of transitioning yamada.masahiro@socionext.com does not designate 210.131.2.91 as permitted sender) smtp.mailfrom=yamada.masahiro@socionext.com
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w170NM5S019831
X-Nifty-SrcIP: [209.85.213.45]
MIME-Version: 1.0
In-Reply-To: <1517960811-21674-1-git-send-email-psodagud@codeaurora.org>
References: <CAK7LNAQ1d5t5-UHsF1ZJ9tNLpGgbMGnDoHdht9=wNy5kLDVyxw@mail.gmail.com>
 <1517960811-21674-1-git-send-email-psodagud@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 7 Feb 2018 09:22:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNASzk0awa4L6F_h9Lbyf7i0VbCkZ_O6Uuk64N_65N4e-5g@mail.gmail.com>
Message-ID: <CAK7LNASzk0awa4L6F_h9Lbyf7i0VbCkZ_O6Uuk64N_65N4e-5g@mail.gmail.com>
Subject: Re: [PATCH] kbuild: clang: disable unused variable warnings only when constant
To: Prasad Sodagudi <psodagud@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        segher@kernel.crashing.org, Greg Hackmann <ghackmann@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591697284772714302?=
X-GMAIL-MSGID: =?utf-8?q?1591699591050770058?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-02-07 8:46 GMT+09:00 Prasad Sodagudi <psodagud@codeaurora.org>:
> Currently, GCC disables -Wunused-const-variable, but not
> -Wunused-variable, so warns unused variables if they are
> non-constant.
>
> While, Clang does not warn unused variables at all regardless of
> the const qualifier because -Wno-unused-const-variable is implied
> by the stronger option -Wno-unused-variable.
>
> Disable -Wunused-const-variable instead of -Wunused-variable so that
> GCC and Clang work in the same way.
>
> Signed-off-by: Prasad Sodagudi <psodagud@codeaurora.org>
> Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to linux-kbuild/kbuild.   Thanks!


-- 
Best Regards
Masahiro Yamada
