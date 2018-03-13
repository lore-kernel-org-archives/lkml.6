Return-Path: <kernel-hardening-return-12506-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELsFw2MlqjY0UHPIJ67cv106PPZrQavrx03wl73iqPlOYwGjBx0kxA0hwbZf6ffBKLK2V1V7
ARC-Seal: i=1; a=rsa-sha256; t=1520949029; cv=none;
        d=google.com; s=arc-20160816;
        b=rM0+SSEz964Sak3bYzimy54qP3PqDgcgcfmn60KH2NhlqZjHvvAQTMpfJn0DMtgVGG
         DcCv9sCOivnlK5N8ssEu77t4A/+2W+toCF8/l7UoQEOQVq/+xE4KhL0AtTUuoYvrv/md
         eyrYKRh+cQonW80YV8M6EUwR/gg1WuX0TTwO0fhYDALiuu9oacJ5ChfYRJWFP1B3xt+g
         5IXweZhXMnBN0aMzqbfEDsq0knQMoCqjZSYQV9nLrPLqYdxiqjy8ghqu2DA/OzFPRcW+
         BHNxnmPSwxnTP3ouYC3fm7f+qQYLCcoAdYfDocgcNcXouaz1kGl/dtRJpmko2yLa9UVt
         sQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=leJH7YYSo9Nh08QRb1M9U6e440VoCPQbtSdqZtm95c8=;
        b=QV8w4LAr7r5Ewq2npVPeKJFm9s9iwlOGpKCj72oOKShszzW9k4AzPFp1/BgnWlFaze
         4HumdrFdIjRLL14d3qQQeNsQNTyvaikGuzb/Y6wXW5gzhGszTPYpD22xlTPEfo8Npv0T
         VD5vQHyOREqegR3IKe6SFKYuKjYd4OG5I/6xqhX5tyPGCoT6hKxcj01aQRgYDjMZxzyh
         mVHtZS7dse0/OzVR/qU1Xvb3yA0xjT8k2NOfK3O2xtODb/HHko1YRlNVSjUn3otx7CZC
         B55AREQNHieDNyiiehOjyWeQjYCGapbrWDW/aHVamy74ObTcD1ZhVs02DiwOhG4THoix
         odFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ftE1qf5W;
       spf=pass (google.com: domain of kernel-hardening-return-12506-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12506-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ftE1qf5W;
       spf=pass (google.com: domain of kernel-hardening-return-12506-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12506-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180310001021.6437-1-labbott@redhat.com>
References: <20180310001021.6437-1-labbott@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 13 Mar 2018 10:42:51 +0100
Message-ID: <CACRpkdaJz-GL_XdkEv-6FpUkjhNKdp27P8p2KFtriVY8GMkrCQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] VLA removal from the GPIO subsystem
To: Laura Abbott <labbott@redhat.com>
Cc: Kees Cook <keescook@chromium.org>, Lukas Wunner <lukas@wunner.de>,
	Nandor Han <nandor.han@ge.com>, Semi Malinen <semi.malinen@ge.com>,
	Patrice Chotard <patrice.chotard@st.com>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com,
	Mathias Duckeck <m.duckeck@kunbus.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507290189676556?=
X-GMAIL-MSGID: =?utf-8?q?1594830649956541485?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 1:10 AM, Laura Abbott <labbott@redhat.com> wrote:

> For those who haven't seen it, there's an effort to remove VLAs from the
> kernel so we can turn on -Wvla in the name of security. See
> https://lkml.org/lkml/2018/3/7/621 for more details and discussion.

OK I read up on it, I'm on board! Less is more.

> This is a series to remove a few VLAs from the gpio subsystem. These are
> compile tested only so I'd appreciate reviews and tests from
> maintainers. When these get Acked, I expect these to just go through the
> GPIO tree like usual.

Sure I will just queue it up with ACKs, or if I just think it looks nice
and reliable.

Thank you for doing this!

Yours,
Linus Walleij
