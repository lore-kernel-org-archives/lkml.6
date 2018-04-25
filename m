Return-Path: <kernel-hardening-return-13131-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AB8JxZrZXJiFPaHgGH5lTbLPTGKQ1Y71aUu/Q2a1wtSz/9uIcZfA/PsHel4jhVc8J089Pj2xTDzL
ARC-Seal: i=1; a=rsa-sha256; t=1524641207; cv=none;
        d=google.com; s=arc-20160816;
        b=T269krkffENPrSIIDD/TbgODoKPYVtspp6jEWZ6Ok3i0dfjaOqJqnFcXOee8FQfo2m
         fHTwPkqrvGYiMgPOPGz7nkYPjyOBFS2G9PEFCuDG07PectHx7NNIoGl/41WT1yM/ehua
         doAq4zVhuFie6IJn7Oo8CFTsKPLmjtBECc6aZ3lwLGQEKe26wmgRgAM6NsyYc+JWno/e
         yQtdxOaW2f5uSl27KzVb/oIbzZVGcpEX4d3kZXnCu/3o/uM0iPwTiwCBh7flKeUxkCct
         R+lswuLlR7XaEtN02J+M+G4WsatEzmY8+vJM9o1FymZGgs9RqR1a+16/4qZ9Cku8ZRQf
         jFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=+feNnJxRb/peWK9HqfY3wgYVxeUZL0QXTDWD9QOFqA0=;
        b=DZrwqM0RvUeCcJfbQTSc+HQABDxgUyTSQ3/58VFMqaMxIsTDGG6DK7IdyzxWskfuUo
         UND0wkU5LJF80giS8UhCi65GVILJktS72kPkbrWrx31TNZHSWolIlvLfhemVmDG0SJeA
         Oe42s4Zh9Fk3vlSHxZC5DBpzcMIu5UXkmJwd7sc44cTNdn7nwuarGZqV6rWeFewANmqA
         zC59nFdSK1y2RXpScMKVdFDJQCxKzD7eu2H526vpXttx1M6X7F+KTGDURAI+kn4oKeXV
         DKiEPJtuTS7cKc1d9/DkQtgKwkvgM/eMZ6oKiG/woh5G3L1PzD1x1YpvgFgSObgnzPp+
         +yFg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bvnolrtZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eQae39jP;
       spf=pass (google.com: domain of kernel-hardening-return-13131-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13131-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bvnolrtZ;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=eQae39jP;
       spf=pass (google.com: domain of kernel-hardening-return-13131-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-13131-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4FAE2607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,  Rosen Penev <rosenp@gmail.com>,  Eric Dumazet <eric.dumazet@gmail.com>,  Joe Perches <joe@perches.com>,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,  kernel-hardening@lists.openwall.com,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ath9k: dfs: Remove VLA usage
References: <20180424235752.GA37317@beast>
Date: Wed, 25 Apr 2018 10:26:23 +0300
In-Reply-To: <20180424235752.GA37317@beast> (Kees Cook's message of "Tue, 24
	Apr 2018 16:57:52 -0700")
Message-ID: <87po2nagrk.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598673960782559388?=
X-GMAIL-MSGID: =?utf-8?q?1598702179041725308?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Kees Cook <keescook@chromium.org> writes:

> In the quest to remove all stack VLA usage from the kernel[1], this
> redefines FFT_NUM_SAMPLES as a #define instead of const int, which still
> triggers gcc's VLA checking pass.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Co-developed-by: Andreas Christoforou <andreaschristofo@gmail.com>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: replace FFT_NUM_SAMPLES as a #define (Joe)
> ---
>  drivers/net/wireless/ath/ath9k/dfs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c
> b/drivers/net/wireless/ath/ath9k/dfs.c
> index 6fee9a464cce..e6e56a925121 100644
> --- a/drivers/net/wireless/ath/ath9k/dfs.c
> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
> @@ -40,8 +40,8 @@ static const int BIN_DELTA_MIN		= 1;
>  static const int BIN_DELTA_MAX		= 10;
>  
>  /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
> -#define NUM_DIFFS 3
> -static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
> +#define NUM_DIFFS	3
> +#define FFT_NUM_SAMPLES	(NUM_DIFFS + 1)

I have already applied an almost identical patch:

ath9k: dfs: remove accidental use of stack VLA

https://git.kernel.org/pub/scm/linux/kernel/git/kvalo/ath.git/commit/?h=ath-next&id=9c27489a34548913baaaf3b2776e05d4a9389e3e

-- 
Kalle Valo
