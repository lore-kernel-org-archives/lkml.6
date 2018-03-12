Return-Path: <jeffy.chen@rock-chips.com>
X-Google-Smtp-Source: AG47ELvK+M9Kx8zn9n9uZd+QKLvQleYta+c13bNuhLT9Qt4EQfoYelad8VtctpUp/pOO02xbkBdF
ARC-Seal: i=1; a=rsa-sha256; t=1520851288; cv=none;
        d=google.com; s=arc-20160816;
        b=NqtpiV0iJ6jlp2vfIhdHJwEiC6rc1FuGp+i0CW+Fl2qWFFrb9UdBOT7c6yT8IY6DtE
         9ahZudGNQihkXIb/2eGlIGDTGWh+XK0yPzt8S4ZEsEdvM1Be5P7e9AiPtiTEac4jcyxE
         pK/CVuGRrlLPeO7sWdpUqExw7660HUgPPJPpioX6CjvjEoDe14B7ggdBnlsKNEtTdjKj
         aZnp0ugU+HDeu5MciRQR2tPenBAslqj+uQAATwzPgxbk62Nl4Ms6dcJMhihL4+fb6A7s
         09xsj4TD9FZ4rKjowBSQv9MtQ6IhZ2089Xw3+9hrUXyq1ODzSARQ4wkOb90zx8FaLyfb
         BV+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:references:subject:cc:to
         :mime-version:user-agent:from:date:message-id
         :arc-authentication-results;
        bh=D+SwsyI0LP8bkbxPhArxY7EQzSL7UywbN0KeHsWqnLc=;
        b=WXukrmMHSrMdmjPRsQQW5kntXCfPOsVgauxoXmu1D+iIWwI8YO7gpiys/konDoTZqc
         VbfPgaJlvZi7qvbieW7UF2Q8xey+sNEkkUkvpxc9D4v7L1Gv7lzslqWSqW9onazHCfeG
         F5Zp63w8QFlOToizU5J0fKtwuTXM5Lu1fFlNOo93lcac2scpSBjE1pCYXiHwBvx4Rey3
         t65vH7QFtqtcBp3r7zoq7bF4ime6jvqGqUdwDvf69CekgwyxhsXLl4yjKrNRgcXoYROI
         TK71MAXNm13ZzEf4tIJSUQv8JzsBpkOnBZmJXimsUr/e7AtI3GePhOc88GVItTPOdiUe
         YFbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.23 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeffy.chen@rock-chips.com designates 211.150.80.23 as permitted sender) smtp.mailfrom=jeffy.chen@rock-chips.com
X-263anti-spam: KSV:0;BIG:0;
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-KSVirus-check: 0
X-ADDR-CHECKED4: 1
X-ABS-CHECKED: 1
X-SKE-CHECKED: 1
X-ANTISPAM-LEVEL: 2
X-RL-SENDER: jeffy.chen@rock-chips.com
X-FST-TO: dmitry.torokhov@gmail.com
X-SENDER-IP: 103.29.142.67
X-LOGIN-NAME: jeffy.chen@rock-chips.com
X-UNIQUE-TAG: <17ae0c86732fcf0a53f11d02bce73a94>
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
Message-ID: <5AA65936.7040500@rock-chips.com>
Date: Mon, 12 Mar 2018 18:40:54 +0800
From: JeffyChen <jeffy.chen@rock-chips.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:19.0) Gecko/20130126 Thunderbird/19.0
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: linux-kernel@vger.kernel.org, briannorris@google.com,
 heiko@sntech.de, dtor@google.com, dianders@google.com,
 devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Thomas Gleixner <tglx@linutronix.de>,
 Joseph Lo <josephl@nvidia.com>, stephen lu <lumotuwe@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 linux-input@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH v5 1/3] Input: gpio-keys - add support for wakeup event
 action
References: <20180308073213.8419-1-jeffy.chen@rock-chips.com> <20180308073213.8419-2-jeffy.chen@rock-chips.com> <20180310181509.GB260013@dtor-ws>
In-Reply-To: <20180310181509.GB260013@dtor-ws>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593796398351218110?=
X-GMAIL-MSGID: =?utf-8?q?1594728160429085153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Dmitry,

Thanks for your reply.

On 03/11/2018 02:15 AM, Dmitry Torokhov wrote:>> +static int 
gpio_keys_enable_wakeup(struct gpio_button_data *bdata)
 > These new helpers need to be __maybe_unused in case we compile on system
 > without suspend support.
 >
 > I also wanted a bit more of error handling, so I ended up with the
 > version of the patch below. Can you please try it and let me know if I
 > broke it.

sure, the patch you sent works :)

Tested-by: Jeffy Chen <jeffy.chen@rock-chips.com>

 >
 > Thanks.
 >
 > -- Dmitry
 >
 > Input: gpio-keys - add support for wakeup event action
 >
 > From: Jeffy Chen <jeffy.chen@rock-chips.com>
 >
 > Add support for specifying event actions to trigger wakeup when using
 > the gpio-keys input device as a wakeup source.
 >
 > This would allow the device to configure when to wakeup the system. For
 > example a gpio-keys input device for pen insert, may only want to wakeup
 > the system when ejecting the pen.
 >
 > Suggested-by: Brian Norris <briannorris@chromium.org>
 > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
 > Reviewed-by: Rob Herring <robh@kernel.org>
 > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
