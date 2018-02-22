Return-Path: <re.emese@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519325443; cv=none;
        d=google.com; s=arc-20160816;
        b=AU79V5gAx85MyJkjcnAPCMTa4tef3/xcgbOaEISyy7mspoaTl5O6KAh0I2Ni0FvCjz
         t1nfnEK8zSq26Zkkpih8zymbqxDiOFJQawK/FXyhBbw/ghU47Ppwp8eQsttMrIrcmN7e
         Psc/Pw9puBrYlM8fmwZ27o65W/1HZk+Owovtfut7jfBK4cxFSIMqba5c8rhlBXh3mucq
         4H5zmzAr0jaM4RcvOflVqVyLW/9K+EsrrOEFs38FBjCTUyI+fy8tQuff0T8fITwZUnJL
         +X28sFDZWS2GSxn3d4kwYran0agYEUvZV1DR6muR1hETbV0BDiKJtWP/3eHT/hAseW6/
         Q8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=A76T9X87eggiI7wPmER3QcsewSP23sak9LMb/SXQn5o=;
        b=t2VH1w65FmYW3hAZ3hXkQ8ucV2Ih/Fj13daTocV7+vohqT50FGWAUIxnqwhpYTDTiU
         4Vu0vt8utMKNyoB7tWrEOapNkaC21ZAbWS6hf5QueAXMRZ/Agms+UEasIQ/cnEKPekIR
         QVNtkiZf4kbJUV/ZyMqx+Kfsz7uAjSU5ndDY00Okm90YN7e1MW173AbqjIB8hpQY8HcM
         ks756yk0VFKWP3LNn0YvACa/G9xq3+85i9f4VLUnLE/llxnpBYk9fXy7+G7lY7HfZIep
         SR5FhsuzfJUxP9azTwdwCny8K+7B88ztoknxrPzkTP9vDY/FwZ1nW6pOsdCNX8HDP+3L
         NdLQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VxppnIq9;
       spf=pass (google.com: domain of re.emese@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=re.emese@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=VxppnIq9;
       spf=pass (google.com: domain of re.emese@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=re.emese@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt+q1dmJnwBItxGDmiB3AjWHKXRTh6CuNHdXJ1FEWJS3RUYZm3Lgns5Pk8hJ6zRvS3qYnainQ==
Date: Thu, 22 Feb 2018 19:45:41 +0100
From: Emese Revfy <re.emese@gmail.com>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-kbuild@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Kees Cook
 <keescook@chromium.org>, Randy Dunlap <rdunlap@infradead.org>, Ulf
 Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal
 Marek <michal.lkml@markovi.net>, kernel-hardening@lists.openwall.com,
 linux-kernel@vger.kernel.org, keescook@chromium.org,
 kernel-hardening@lists.openwall.com
Subject: Re: [PATCH 20/23] gcc-plugins: always build plugins with C++
Message-Id: <20180222194541.35076c5b2166879a8d5d234a@gmail.com>
In-Reply-To: <1518806331-7101-21-git-send-email-yamada.masahiro@socionext.com>
References: <1518806331-7101-1-git-send-email-yamada.masahiro@socionext.com>
	<1518806331-7101-21-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592583935376722462?=
X-GMAIL-MSGID: =?utf-8?q?1593128196163317142?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Feb 2018 03:38:48 +0900
Masahiro Yamada <yamada.masahiro@socionext.com> wrote:

> If the target compiler is GCC 4.8 or newer, plugins are compiled with
> HOSTCXX.  Otherwise, gcc-plugin.sh will select HOSTCC or HOSTCXX.
> 
> To simpily things, let's decide GCC 4.8 is the requirement for GCC
> pulgins.  With this, plugins are always built with HOSTCXX.  This is a
> feature of advanced users, so this requirement whould not be not a big
> issue.

I disagree with such a decision. I think the gcc plugins should compile
with older version because the kernel can be compiled with them too.
The distros use these older versions as well and I can very well imagine
that new plugins will extend these with backported features such as
my sancov plugin.

-- 
Emese
