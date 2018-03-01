Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519889723; cv=none;
        d=google.com; s=arc-20160816;
        b=JcEQwQ7DNvFbPX8YNa4MRbsHBpXS7f/OtymgfiFDKRf9aMUAnEmbQnKis6MXdCVOWX
         dnAiJrRyu/zrL4txI5i12xUNRhAOg5Dc0VgcIK76qbzwv71VvwEpahASubG6nqjhjxDe
         jHmsp2aeLYWcv0jbLKmNxnQ7orXJsFXrpzoR3xqFfFpOA//bKta4MedoJPWKlU1ud1a6
         4rzBeOr2Ccgd6Ay1v+MsrVwFeEtoqq4zxKmIcYozq6Guh4+wUKfIAsEf0BTKTcdJE2Br
         TEfkWAJiQRf2yho79D671X9RFZyLGuDUst0VfPv/NvJY8bKDuHKd/VYvFLd43bCtgD9P
         o81g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Z6UpImDyA4g/B8MjeHRc5jNnU3PylRTyjo6Xd2J+cFs=;
        b=KubXsUdgd1TL2d4dvdZ/nLvBrIZcTrgw1feEDf6teszwErsdKCvEcHjXf4PaF2L5+z
         b2fsXtG1v37y0WENfguCzRoIAnFyE5ryoi9WLyEqrbcLonlVtWYgBJBwcZmH4yD0OaBW
         gomDLRoll68SyWaxvXJZ8AP4tQ7vKibxUfiTdHFPp/VYXO3D9HyqhjBM/a3fU4acKBMd
         5/O/qXapX1ycFssAQJ/TmiRnc0gFjD/XM0+W9Zpn8tosTFebVfucoNCBIhm/d5ceZ8cM
         QoH1ZgWf5uUP8WsXkF1luS9mdjnNP2gq/wimXI4KN6+HjN3mZbQQw4DTehExxjmKXgmK
         ajCw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GXcj6ZzY;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GXcj6ZzY;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsnL6qq6I7Ui3UX6pcdSLCtBNlCC1v2sujPulk5xX1hIQvXOArQPbpuCOWy4Ufjms20Z6a3JSCQOd1nAoV5Fk0=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
 <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 1 Mar 2018 15:35:23 +0800
Message-ID: <CAMz4kuLNbsZjDPW19V96yL3DzY-bJsjRR=o+w0x4PGyxZFZ0dg@mail.gmail.com>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
To: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, gregkh <gregkh@linuxfoundation.org>,
	stephen lu <lumotuwe@gmail.com>, Arvind Yadav <arvind.yadav.cs@gmail.com>,
	Joseph Lo <josephl@nvidia.com>, Kate Stewart <kstewart@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>,
	"open list:HID CORE LAYER" <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593648786277200792?=
X-GMAIL-MSGID: =?utf-8?q?1593719887527613011?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 28 February 2018 at 22:44, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> be triggered by level type. So this patch introduces one property to
>> indicate if the GPIO trigger type is level trigger or edge trigger.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes since v2:
>>  - Use 'interrupt' property to indicate the irq type.
>>
>> Changes since v1:
>>  - Diable the GPIO irq until reversing the GPIO level type.
>
> I've looked at your patch in more detail now, and given it a bit more thought.
>
> I wonder if you could move that logic into your gpiochip/irqchip driver instead.
> It seems that what you do in the gpio-keys driver is to emulate edge triggered
> behavior on a level triggered irqchip.
>
> If you put the same logic into the gpio driver, you could simply make it
> pretend to support an edge trigger on both edges and call into the interrupt
> handler whenever the state changes.
>

That is really a good suggestion, which can avoid duplicate level
reverse logic in different drivers. So this patch can be simplified
just adding one trigger_type to indicate the interrupt type (not
always edge trigger). Thanks for your suggestion.

-- 
Baolin.wang
Best Regards
