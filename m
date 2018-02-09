Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518168195; cv=none;
        d=google.com; s=arc-20160816;
        b=dAZacdb/16fOBrnrxMwHyrSFYHIzRGvaWFrizfU9CmwNXOQRAMxKZfNXAE8Pw8UM3X
         SNq91cfysLiabOu2XdgSkftg8dTjt19sGT6P7zzZNSMt3BqdFg/dCQzNQtm8E4hd/XZS
         +CUctQgpwuLjAZgJYGfn8vtLgRcTHLblzNRXXQgDYoWS83TwZUBrvcZ1GTFNrbGvoV68
         gU36iux0fBCefCta6VYMrjgmpoZhDxq/ss6Cs2MwFlCVP9R4gSyaP8eUntpWQbPdBDFW
         0NaE9qO2bTOlQdRYiKNrc+yeB/kdxz64OG2sZMGB8qiOpXudzjE0tjRbbEtuUWmCwtbL
         xxgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=gmkDcRQvk2lJEXmdf/TXcztwA2EvwK9RlCji6NxVIDU=;
        b=oug3cGRz/3BrOTv8veg6THyrMgXCNrdh5sjp4Axf67fPH53DJilAWqx/2HxIVtXqKR
         KhfGKLuLeR/6XqT3UDuOLjmcJxgibdMCXExkN7GX2+YQnwobo8fqNRO3RHTR51nzEoWq
         71TZSO0IAr7f0e51RyCKsaIZMOXxhpUYdd7I57jl6Gbk9yhfBLZ80kR/ytQz4j+msQBU
         Kh6fC/NBHjQBtZFPc4p2yDdRf/PYvbmcOTwXMQzKGBCzvWW2YzdR5/J3rH8KTVJ6MwcB
         885euDU23/+M2pP71rnEOeGAt/IjWTW23H30a+I4bvMDFTxtculP5ti3ck1lmmCOglrb
         3RsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=L8aJk8f4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=L8aJk8f4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x225m371+awypm8uCUXhLba5TX7aSS9Tcsbq+S545nbjNF5oXzuPdPWB9qG6yQpxKnIMXAcYSTKqBE72GuuDBBi0=
MIME-Version: 1.0
In-Reply-To: <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com>
References: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
 <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 9 Feb 2018 17:23:15 +0800
Message-ID: <CAMz4kuKb8g5dAu5WQ847CODtVgJQBa_svbeQGGDsYpCjipBp_g@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1591914734352609047?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 9 February 2018 at 14:39, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Feb 8, 2018 at 10:08 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> be triggered by level type.
>
> How do you stop the interrupt from re-triggering as long as the key
> stays pressed?

We will set the level type irq handler as handle_level_irq(), in this
function, it will mask and ack the irq firstly.

-- 
Baolin.wang
Best Regards
