Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524144554; cv=none;
        d=google.com; s=arc-20160816;
        b=G7ZlPEQd5kqa1U62Bs8aBILJWvLd6lIcGnX4z9Hd30CtJZStm7V2vt0YAv7ZNf8kU+
         8S6K2/1jU8JRHu0T28thFwFytDnqZRnvpFpJBK20w79vhQDbj6zJKNNNgt+1Hl6lft0m
         m6Fmh4i30dJUolgPTe1e0RkdGkLX5NsWeaz6BgKGCzt5tTS2drJABfAmPQZt80DMl2VI
         kFvViCesUV2N38uyv0YGUV2r/LIy1MUfvrJt7k3VSlHG0ONzMY6SKWw1YYNOdtEHt1fU
         S3EX8vheOiORYZVO+z59xjKXdOKu9VXOL8L4HmmLmNzce6sgmbPxFDfgNG57n77sCXYi
         2wLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=+0ltMUsvwhOcpfIBuT6vlmvTGAQ4jAD5WcY0M9Cv6G4=;
        b=X/h7IE7I3UXp+vCW/Qm39qJrTKEBSVFmgv7mrswz1eL35k0kg4N7/f/ljiFbGfDXDQ
         5aIos4vDVKgncnZuGqeNc2M9uhAfvq2M2DMERz+yRwJ6CfXyLiTICdlnRpLYsiOd4Bjj
         iMiLF5uZUEhZ4yx2FXHmO+KgEjWxO6u49Pt39cmMlzJSHsdInUaKoYH45T3E3sjRzzLn
         Cbgs7r4qJ+1uUKXn/1UtnAqG6A3InnSVmDyOmibBBwYXdyd6x3yNWDQ08S7aapwCYq8H
         HBN3ewr8STOOjibvkfUSf4xIsDmvirZXqbN7z8mA8xPCpFOoYJaYjJk2T5fJz6L1FsPL
         dOiA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EGUknzp+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=EGUknzp+;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AB8JxZp42nmS+N+rnePUrAsY/hoBcgiMnHaLKCMr4/rsF1UVvwu96i0uh0tapFnoyiGPlQNQ3zQpEhsw7NSkARVShvc=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <026e9f13-7201-57a5-a4b3-8c48a89bf134@huawei.com>
References: <1524138946-136701-1-git-send-email-john.garry@huawei.com>
 <CAK8P3a1nen_EoyZ63p_EfSu51wUAbLigzbrv3K4byS2gUo9CjQ@mail.gmail.com> <026e9f13-7201-57a5-a4b3-8c48a89bf134@huawei.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 19 Apr 2018 15:29:13 +0200
X-Google-Sender-Auth: W72jGEyKA_pILajOe3lZrFSTmr8
Message-ID: <CAK8P3a2rfFvQdSaGjqtk=kz75tW9JNFdqeUiX6JBWJdM658T2Q@mail.gmail.com>
Subject: Re: [PATCH] HISI LPC: Add Kconfig MFD_CORE dependency
To: John Garry <john.garry@huawei.com>
Cc: "xuwei (O)" <xuwei5@huawei.com>, Geert Uytterhoeven <geert+renesas@glider.be>,
	Simon Horman <horms+renesas@verge.net.au>, gregkh <gregkh@linuxfoundation.org>,
	Paul Gortmaker <paul.gortmaker@windriver.com>, Robin Murphy <robin.murphy@arm.com>,
	Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>, bogdan.purcareata@nxp.com,
	Tony Lindgren <tony@atomide.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linuxarm <linuxarm@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Olof Johansson <olof@lixom.net>, Kevin Hilman <khilman@kernel.org>, tanxiaojun@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598175575431248949?=
X-GMAIL-MSGID: =?utf-8?q?1598181399851644618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 19, 2018 at 3:08 PM, John Garry <john.garry@huawei.com> wrote:
> On 19/04/2018 13:00, Arnd Bergmann wrote:
>>
>> On Thu, Apr 19, 2018 at 1:55 PM, John Garry <john.garry@huawei.com> wrote:
>>>
>>> For ACPI support of the HiSilicon LPC driver we depend
>>> on MFD_CORE config.
>>>
>>> Currently the HiSi LPC Kconfig entry does not define this
>>> dependency, so add it.
>>>
>>> Fixes: e0aa1563f894 ("HISI LPC: Add ACPI support")
>>> Reported-and-tested-by: Tan Xiaojun <tanxiaojun@huawei.com>
>>> Signed-off-by: John Garry <john.garry@huawei.com>
>>
>>
>> Can you explain the specific dependency? Normally MFD_CORE gets
>> selected by an MFD driver but not other drivers.
>>
>
> For each device on the LPC bus we create an MFD.
>
> The reason we do this is that we need to set the resources of the derived
> MFD, as we should not modify the original ACPI device created in ACPI scan.
> Details are in the log for e0aa1563f894.
>
> Shall I update commit message updated with this info? Or were you just
> interested in the motivation for using MFD?

I think it would be good to update the description. I had missed the part
where an LPC device becomes a platform_device through an mfd_cell
rather than becoming a device with bus_type=&isa_bus_type as I think
was the case in earlier versions of your patch series.

     Arnd
