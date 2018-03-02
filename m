Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519960232; cv=none;
        d=google.com; s=arc-20160816;
        b=ss3X8ZJVV4em8fyjB9uSTNE7mVaTLMDpYsee5JBHNh0WVY+OtvkF1JMCQVhoUq5mm/
         ZsVU3qTYOMooKpADMMhE9zkFiBZ6ahlaboFWeqHtwBTfnKGNqhXSBX+RwcT8kOQVnTLO
         mRKS6LO8kTaa9wtFhcWVhPW8TiizOGXAB+lOuf82cfP6xR2p2ATFp5rdUXyxj8GJkvaC
         pmSsT99DBoe0+6DmkSDdUsnXHDSuOHR9C6/Ctn7/E0e8WtppePyNFQ7II53Hi9IQ41tX
         8VeoHoZDsZ7GONmzpqw+paldkPg3UBoFNSvmv5ZFTSnqh1MTEMhLqDo0VKaiN5U/574G
         VVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=ZhOHLPEWWr105dwlMrEyxo/6Mh+DbifvlqrLVLXHVSg=;
        b=sQdCeAvPnYX+rgznqOWsUGaBSdWaQbwiU0ucGqlZxUWkfzyDRxZ162TV97585V+wzH
         //d/srohtTQ2dNZZlnOsW3zfatjVd10mV7dLVg2as+uYKLBB+x2J3yhP6mvAw8bwQCeZ
         PypjmmHi3ZZPDVovcs5zqDJJG+F1hiinwrgsehsL0oLbUuAhGV1JLUFL3mwU3LWoxtdw
         q1l7wnHUrFs2aWjHe5FiNghl7iZey7JERx2CdpBLVbhPqzYpU9VbQQ5cNzrc44y2wY1e
         vnUzEX7vW6dfTxvY0NW6P6IFIGVMT1R5p2umIByXnL5Qv98CX1zDTaJhEn0okKQvbn5T
         F0HA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kI6602bW;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=kI6602bW;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtURqQ8J2nigOMQVtwPcTdqspJe69mm7xN7+4qPWccRck1CHqiLntjefeXKnNaBjV4Xq5ZwqeRmGMURdpzf4rg=
MIME-Version: 1.0
In-Reply-To: <20180302004404.GA242226@dtor-ws>
References: <826093167e8fb24723f474b0272f3dcab1b6a97e.1519821626.git.baolin.wang@linaro.org>
 <CAK8P3a1v2GanneaFKpXWjWLt1YzibJ9Bh7vUcd_SH-4jGN_1+A@mail.gmail.com>
 <CAMz4kuLNbsZjDPW19V96yL3DzY-bJsjRR=o+w0x4PGyxZFZ0dg@mail.gmail.com> <20180302004404.GA242226@dtor-ws>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 2 Mar 2018 11:10:31 +0800
Message-ID: <CAMz4ku+Ruz=O9NE4x+cm4tFXR+en7mKX4D0aP841qKrdRMMP6Q@mail.gmail.com>
Subject: Re: [PATCH v3] Input: gpio_keys: Add level trigger support for GPIO keys
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh+dt@kernel.org>,
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
X-GMAIL-MSGID: =?utf-8?q?1593793820282667886?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2 March 2018 at 08:44, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Thu, Mar 01, 2018 at 03:35:23PM +0800, Baolin Wang wrote:
>> On 28 February 2018 at 22:44, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wed, Feb 28, 2018 at 1:44 PM, Baolin Wang <baolin.wang@linaro.org> wrote:
>> >> On some platforms (such as Spreadtrum platform), the GPIO keys can only
>> >> be triggered by level type. So this patch introduces one property to
>> >> indicate if the GPIO trigger type is level trigger or edge trigger.
>> >>
>> >> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> >> ---
>> >> Changes since v2:
>> >>  - Use 'interrupt' property to indicate the irq type.
>> >>
>> >> Changes since v1:
>> >>  - Diable the GPIO irq until reversing the GPIO level type.
>> >
>> > I've looked at your patch in more detail now, and given it a bit more thought.
>> >
>> > I wonder if you could move that logic into your gpiochip/irqchip driver instead.
>> > It seems that what you do in the gpio-keys driver is to emulate edge triggered
>> > behavior on a level triggered irqchip.
>> >
>> > If you put the same logic into the gpio driver, you could simply make it
>> > pretend to support an edge trigger on both edges and call into the interrupt
>> > handler whenever the state changes.
>> >
>>
>> That is really a good suggestion, which can avoid duplicate level
>> reverse logic in different drivers. So this patch can be simplified
>> just adding one trigger_type to indicate the interrupt type (not
>> always edge trigger). Thanks for your suggestion.
>
> No, there is no need to add trigger type. The gpio-keys driver expects
> trigger with both edges, falling and rising. If your GPIO chip does not
> support it natively, you need to emulate edge trigger via level
> interrupts by reprogramming trigger from active low to active high and
> back on the fly. This should be done in the gpiochip/irqchip driver.
> There is no need to change gpio-keys driver.

Yes, you are right, It can work on my platform after modifying my GPIO
driver like you and Arnd's suggestion. Thanks for all your help.

-- 
Baolin.wang
Best Regards
