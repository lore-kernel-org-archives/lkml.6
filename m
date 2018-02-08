Return-Path: <ulfalizer@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518049009; cv=none;
        d=google.com; s=arc-20160816;
        b=WxpSlOSQGDTahUibgKYqzKADXdcr2ASt2pLSyif8i4G5ri7IpuxdTW1b41qnHVNk7R
         zZP6aVkr45Ysfeekq+7HmqpcIS7HaK9qsC8QNwxkw3Tvs/vbMnTxpiSM5AfdQp06m5zm
         Esypr7V9HwGBFROduOLJGw/SHXO6kJG2gm+U+nmJFpxc1mxz4zVfm6rGXCqCQfSI++sl
         57YdgM3bRXFRvGU9Vqq5W71O8ggSmB24O5bvTsmWSLRZX1buDzzhZKZv4/6Pa/1SrGwT
         Kv2PCFc6GeKQrto3hL72AJWx6yf580zbpBSx/038ovOfu/mmBA+lDGK2Ya8RYe1r8/jY
         3nRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=h4P+DXkDzofwetB0X0Gfo6pmDtgOrYbS7m8kphFEzsQ=;
        b=f8D9Trvi9tmj2C0Fcm8ch5yfTmlb0TSNUK3oI3IVYHMup7gSDgjq+zermOVafHHE57
         xzCrGQeL+A1bMA5FDmVOoWqLQRGe3xY7VThNsKBJ9TMFktIuwIqsvWqRHFYhLf41TsL8
         pZqmabQ4CM8/sMBGgbp3QG90DA9pqNmfPrwCr85Ly1assA/n1OCp8MiJFPMqn+OPXhgN
         n/wEGjL2mn7ZH84eRJ6Muh95Mfgf3a44uN6ksC4GOlSQ+GonAAGDYTHcsCFqpt6YYJes
         /qzQjMGXVAracGcqlGI5rQu/BLoUzhEtxrFS5MOKTT0KkxLwtil11BS/k8/DG6hWxASJ
         OhYQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RhXBjZj7;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=RhXBjZj7;
       spf=pass (google.com: domain of ulfalizer@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=ulfalizer@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x227GGn0P873C/MXwUTRFri4RICmkpSxl8yf3dmutC2hQcWiD2vZgzXgihGAo9cGri1u2P/wdIdzZcpEBb3AbXUs=
MIME-Version: 1.0
In-Reply-To: <1517877294-4826-15-git-send-email-yamada.masahiro@socionext.com>
References: <1517877294-4826-1-git-send-email-yamada.masahiro@socionext.com> <1517877294-4826-15-git-send-email-yamada.masahiro@socionext.com>
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Thu, 8 Feb 2018 01:16:49 +0100
Message-ID: <CAFkk2KSA3=Mt1=jssDLju0scGw42teyarRX6yF3+FtgjnXYuwA@mail.gmail.com>
Subject: Re: [PATCH 14/14] kconfig: test: check if recursive inclusion is detected
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>,
	Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>, Sam Ravnborg <sam@ravnborg.org>,
	Michal Marek <michal.lkml@markovi.net>, Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591609808664876806?=
X-GMAIL-MSGID: =?utf-8?q?1591789758450830849?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 6, 2018 at 1:34 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> If recursive inclusion is detected, it should fail with error messages.
> Test this.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  scripts/kconfig/tests/err_recursive_inc/Kconfig         |  1 +
>  scripts/kconfig/tests/err_recursive_inc/Kconfig.inc     |  1 +
>  scripts/kconfig/tests/err_recursive_inc/__init__.py     | 10 ++++++++++
>  scripts/kconfig/tests/err_recursive_inc/expected_stderr |  4 ++++
>  4 files changed, 16 insertions(+)
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/__init__.py
>  create mode 100644 scripts/kconfig/tests/err_recursive_inc/expected_stderr
>
> diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig b/scripts/kconfig/tests/err_recursive_inc/Kconfig
> new file mode 100644
> index 0000000..3ce7a3f
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig
> @@ -0,0 +1 @@
> +source "Kconfig.inc"
> diff --git a/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
> new file mode 100644
> index 0000000..1fab1c1
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/Kconfig.inc
> @@ -0,0 +1 @@
> +source "Kconfig"
> diff --git a/scripts/kconfig/tests/err_recursive_inc/__init__.py b/scripts/kconfig/tests/err_recursive_inc/__init__.py
> new file mode 100644
> index 0000000..1dae64f
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/__init__.py
> @@ -0,0 +1,10 @@
> +"""
> +Detect recursive inclusion error
> +================================
> +
> +If recursive inclusion is detected, it should fail with error messages.
> +"""
> +
> +def test(conf):
> +    assert conf.oldaskconfig() != 0
> +    assert conf.stderr_contains('expected_stderr')
> diff --git a/scripts/kconfig/tests/err_recursive_inc/expected_stderr b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
> new file mode 100644
> index 0000000..b256c91
> --- /dev/null
> +++ b/scripts/kconfig/tests/err_recursive_inc/expected_stderr
> @@ -0,0 +1,4 @@
> +Kconfig:1: recursive inclusion detected. Inclusion path:
> +  current file : 'Kconfig'
> +  included from: 'Kconfig.inc:1'
> +  included from: 'Kconfig:3'
> --
> 2.7.4
>

Reviewed-by: Ulf Magnusson <ulfalizer@gmail.com>
