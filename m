Return-Path: <kernel-hardening-return-12981-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AIpwx49LNL7BJgP3LxhisxKKNwBox0G2okhlg5I+Bm1X5CUXhtbN2FLdXrOiXRmoFB39TRFyTQUH
ARC-Seal: i=1; a=rsa-sha256; t=1523521047; cv=none;
        d=google.com; s=arc-20160816;
        b=qUye48spscx+EsydrfrG/EnPnJSKChNOeaReS+FNwYAoe6MqPfzGgupb05DfmKWLxQ
         caOpGEP9vvAuidqRe/HuFbfuRQMUmr4emOGWDEtbppLnkIfn+N23JXjiJmiOFQKN2O3K
         pr9vpCJ2m+9D0pT/zYY8F5e3V47n/R1WFa/4AjGvXGlKmQSD+z4Na3V8zkEhKm8CtlCR
         58r86d7Hls/bNXuKqV93eFrNr2nld98CzCnEiryQ57A4kqsHJs1fTa4TWHUZdTbEqI/t
         fQvL4raiaYMuohScCaZ9crc+hjReJPy13supi1uWMgTHq8wLNm3gEdJp8ESgcPtC/ygZ
         rEkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=IURQ81cta5VQlVf1GELBFBSIt+xe0d6TZhB2Enl9/TY=;
        b=VRKvj8XdkSVvMgyA5wIKG3BNss0WY8Gzb5swRJjcaEntFzgoD1Zinez8khiPUgwBlk
         cQ/CIVYk6eiDkI9DJum2cyU+CfBgdn5hKqAcuPVb8NZMXIDZteTYmjMhxXV0h4O/+eVU
         U/0VlPts4wCrV4JPeCvpqtZ/T/EEZPZi5zAIANtVXnK5dN3bHy1UHuduJFmSSWVUqSqo
         ozpuskCpwRMsTl5plDIzybYjsveiaXVqInSJ27Wuk7aaNlOVzEMhkDSuPHDAtjBmK1K9
         2xl1em9g2wer3sAFTrGuQ8SFOt7BeUO7zdueX6jEWK50Mzjn3z1MwGgBk1ts0SODOCNs
         M8FA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BCwg3FPz;
       spf=pass (google.com: domain of kernel-hardening-return-12981-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12981-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=BCwg3FPz;
       spf=pass (google.com: domain of kernel-hardening-return-12981-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12981-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <20180409210717.3852-1-labbott@redhat.com>
References: <20180409210717.3852-1-labbott@redhat.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 12 Apr 2018 10:17:05 +0200
Message-ID: <CACRpkdYFTcEssOX+Tdof9LVa1x5wFGvMXzmojLKTvrz7=QqA8Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: xra1403: Switch to a fixed upper bound for registers
To: Laura Abbott <labbott@redhat.com>
Cc: Nandor Han <nandor.han@ge.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <keescook@chromium.org>,
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, kernel-hardening@lists.openwall.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304277503728499?=
X-GMAIL-MSGID: =?utf-8?q?1597527605640393893?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 9, 2018 at 11:07 PM, Laura Abbott <labbott@redhat.com> wrote:

> Geert Uytterhoeven pointed out that the number of register was a
> fixed upper bound so there's no need to use a dynamically allocated
> array in place of a VLA. Use the defined upper bound.
>
> Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Patch applied for v4.18!

Yours,
Linus Walleij
