Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526025473; cv=none;
        d=google.com; s=arc-20160816;
        b=AEZqaESB3U5TJtVrekLuRXPts/GhJ+G8/ZJpE+U6iPazz/i0TPe2sra2xY7IEqGwRI
         GEE4t1Pal3TKogiKLMmvpRsGheoaIqabN2wzPFYSutDWYxLR89qp5mtbr06PGc8ytBkY
         idmB3/x55nnAaLOdJvzY6Aq1TVXiHgq0EZoDZpXgKJ6N4mZonl/XF4GcmcevPorMoR3+
         gKE/yqboNsGb/+I0QKkSVL0pC30CSBNrryaixB/Zkmys6hBYS88gk6kbJF9na02rz9ak
         y4bTK1IAZb0Utp+hBKmnfGbJg7ke/dXAXzLeu6UocJh/Sh15YKs193SNbPAfHcnBTyrY
         hYKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=eimcDA1SNeF1AS1CQiQwFp4ajV80fGsJhJsEd7BWPCY=;
        b=bm3qCSxS8Wx/qV0HKsruYMHS6cN9AnF/SfdqlVbHyTDZZrDXLzWfR5x3lNdJrdChOh
         K2EAD3101dhcxK7sOijGJnWpfqQ9roai5GQNz4C0d4mOhjIebw5uOUtvLwVTi3+ezw9h
         6ePqrJh7YDdKXXxF7jbEoin6GZGEXL/qSnRB1v1TOKGp5fqh7cU4oVOWLXymo4NlLQO5
         AQ090Fss+WR0HnLuMCEMqZPvzxBxMev8XKhLRJ6NDrIJpJLjuUkNrqI2/Lq88M72Nvq6
         1mMRkK/7CbFJZTinHgrwdFZuSl4Vqqe6cWZhNgdjBQ0Bzy8FziAjZLCtHDiPjWlfurx8
         zcYw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=chef7CkU;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=chef7CkU;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AB8JxZrkyBba2j9hcwebK6wgPQyzc17WD4qlLDQJ+cSVM6KP2xJ2P/FpUaYJVibopgYBfx5rei7d+mBp3XDZy6Mt4wQ=
MIME-Version: 1.0
In-Reply-To: <201805060540.zjwonWcp%fengguang.wu@intel.com>
References: <20180504195728.72932-1-maco@android.com> <201805060540.zjwonWcp%fengguang.wu@intel.com>
From: Martijn Coenen <maco@android.com>
Date: Fri, 11 May 2018 09:57:52 +0200
Message-ID: <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
To: kbuild test robot <lkp@intel.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: kbuild-all@01.org, John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599564783998052037?=
X-GMAIL-MSGID: =?utf-8?q?1600153686417259173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 5, 2018 at 2:10 PM, kbuild test robot <lkp@intel.com> wrote:
>    drivers/android/binder.o: In function `binder_thread_write':
>>> binder.c:(.text+0x6a16): undefined reference to `__get_user_bad'

Looks like m68k doesn't support 64-bit get_user(). I could just have
binder depend on !CONFIG_M68K, but there may be other architectures
still that don't support this. Another alternative would be to
whitelist the architectures Android supports - eg arm, arm64, x86,
x86_64. But I'm not sure if arch-limited drivers are considered bad
form. Does anybody have suggestions for how to deal with this?

Thanks,
Martijn

>    binder.c:(.text+0x6c9a): undefined reference to `__get_user_bad'
>    binder.c:(.text+0x701e): undefined reference to `__get_user_bad'
>    binder.c:(.text+0x7414): undefined reference to `__get_user_bad'
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
