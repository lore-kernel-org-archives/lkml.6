Return-Path: <dmitry.torokhov@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518158341; cv=none;
        d=google.com; s=arc-20160816;
        b=Cau3PG2AKDk5fvR30tzkYFXylPmZYNB6gTJ+mSXvTHjOgmFrmDhVtxFQ+oHd0Tn0tu
         b8HduxfW4va7e5q8MCfkMee52uN0E0fB5OrrM0LDEhq7emo6jjECxqokZvxecKOkjt9o
         Ae0PuT1/D6UDebegHx54Yi0VDoQhjuzGDah7UKa5F7FISj/EsJs+caLPeH4XC5IjYFES
         9mbtI8Cj0msr2x3/a/NCLKQnilqv9setHaUFrgT0avcmLIqwbxSBbBrwe+F8mUgJByKp
         eGzTgM0yNFNpMzGwZd6icCqnOGaTOdyRqtEZoSo0sYVd04dluIWtUpIlRbP7ox5V3yHO
         bICA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=DqzNaXiF0tOKPlESU7GG1UWB1GmybpgrdjLoBjJk72Q=;
        b=dorkDs5uceJMnPzEJg7vf1P3pfoJQVrKbrBOpCZPVltaiM9J4f5krE2XmKCmsLGGto
         G05+N8HxgjvFWocpFXnESSCtoa+ZRG7rm5wYF+vTtETenXodVmf4Cz/Ho3Kqf9Nsv6K/
         FLwo5k5TE1ftfMNLD0vV8l7ePKBBWk2EMXV3VvVcmQy5HJ5sUYJ5/Io7fy9/+Vc2zOMF
         TKutn9sDDSGucv04VviDR1k9jpMqLT3ScGOIwwsxeIgsBJQfW3CkumemZpxfWcjRhQb7
         Pdd0ND2GSji9CtOjnoPSVOrl0tFSzAawd931ySbaC8NvHXuGBmPr+CcxUSPhW/V+imC5
         tVuw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZHir73pT;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZHir73pT;
       spf=pass (google.com: domain of dmitry.torokhov@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=dmitry.torokhov@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x226LRzLCDYbFWWdy+CvisFodJ7m/xFyS+IskQ8DvUOmz9v7kPvNK+7RTCrbRILmxaVZBxC8qQwBJEy85N+DB/MM=
MIME-Version: 1.0
In-Reply-To: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
References: <6c53b9ccfd4a56fc1b00e243bb9e7cae9e124932.1518155780.git.baolin.wang@linaro.org>
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 8 Feb 2018 22:39:00 -0800
Message-ID: <CAKdAkRQ6+9=GUJfoMT_gtwS8DqWKeH9FAqPG2BFzL9GPbPNB4w@mail.gmail.com>
Subject: Re: [PATCH] Input: gpio_keys: Add level trigger support for GPIO keys
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stephen lu <lumotuwe@gmail.com>,
	Arvind Yadav <arvind.yadav.cs@gmail.com>, Joseph Lo <josephl@nvidia.com>,
	Kate Stewart <kstewart@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591902511604872416?=
X-GMAIL-MSGID: =?utf-8?q?1591904400797946706?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 10:08 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
> On some platforms (such as Spreadtrum platform), the GPIO keys can only
> be triggered by level type.

How do you stop the interrupt from re-triggering as long as the key
stays pressed?

Thanks.

-- 
Dmitry
