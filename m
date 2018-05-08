Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525805624; cv=none;
        d=google.com; s=arc-20160816;
        b=rPJxDm0KGKLekeStf5xwHm8HbwG/msL/8itxATOE33vlmRjG6JO2LtHo9FHOTlyJnE
         pxfu4/UVK02BTQU5MaQN6vkjhiZuJ0/ltCNCBRX0WICGttPFuXM4RjHmbHXVR4uKjtmS
         hSCyZvarZp8RA5ltXvCa8j3tRPnkxOBvFmbnXPsNdmRzV1Mq8D+ThLyMY4f8BtMYe3Wp
         wCeWaetgA3gh1TJIg/z6kGTiHuA/6u+4A5kCbAcBW/9nORDNfOKktognzhJ09iAIbQlB
         +GpoKazzqkUjw4yFvcbN/dr4f0vyIjf3WlLRmIvb7+OJYmaE6znUBLrpWSe+mBchGm3O
         PtCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:cc
         :dkim-signature:arc-authentication-results;
        bh=2bjSg1L5xcqD10nFoDAVMLyoc6zOammPwOiz/FKvI1E=;
        b=stmMGcQrptrQzCZRkXdTSp7pbedsRssZxbeQW04Q28F16xrNPlYJJuSMWC7E97wX5B
         S7H9mMcRgxOZcT51pvQvJ0/7kqpvL4Q2q1bwM0sG7gV0DfssKQ9aGnqb5utEshZWoyo1
         f+X6+vgGu+zrNvk7J5JZgzTLOzPELc6zY8Upg7tCTlcxZQNyDVY30Hhg2zoyIKixu9rn
         +n5Mu6Jiq4jcLBWnZ+FS/J+Y3eVinJVWCDK9Z2He+xWBDw97Fsv6TXIxMBHivMVlqV/G
         +a/6O5vRa3g2FqrU4uCz6JM78Az3B+tTEKoVo9GBiqCJTBASUboTvgTOzrh4MLbW7HYT
         857A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nGJy/toz;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=nGJy/toz;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZqQAPiDjSElEiedd3RUJMUvma9J5lqHRZfsK7qoruAXyJMHgAZzGDtIlzREMq2B5vP2WXgugg==
Cc: andresx7@gmail.com, akpm@linux-foundation.org, keescook@chromium.org,
 josh@joshtriplett.org, maco@android.com, andy.gross@linaro.org,
 david.brown@linaro.org, bjorn.andersson@linaro.org, teg@jklm.no,
 wagi@monom.org, hdegoede@redhat.com, zohar@linux.vnet.ibm.com,
 kubakici@wp.pl, shuah@kernel.org, mfuzzey@parkeon.com, dhowells@redhat.com,
 pali.rohar@gmail.com, tiwai@suse.de, kvalo@codeaurora.org,
 arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
 markivx@codeaurora.org, broonie@kernel.org, dmitry.torokhov@gmail.com,
 dwmw2@infradead.org, torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
 jewalt@lgsinnovations.com, oneukum@suse.com, cantabile.desu@gmail.com,
 ast@fb.com, hare@suse.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, khc@pm.waw.pl, davem@davemloft.net,
 arve@android.com, tkjos@android.com, corbet@lwn.net,
 mchehab+samsung@kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 13/13] Documentation: clarify firmware_class provenance
 and why we can't rename the module
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, gregkh@linuxfoundation.org
References: <20180508181247.19431-1-mcgrof@kernel.org>
 <20180508181247.19431-14-mcgrof@kernel.org>
From: Andres Rodriguez <andresx7@gmail.com>
Message-ID: <10c2aa7d-eaa5-80f9-f831-7e31762ff149@gmail.com>
Date: Tue, 8 May 2018 14:53:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508181247.19431-14-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920608674205681?=
X-GMAIL-MSGID: =?utf-8?q?1599923158407235247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-05-08 02:12 PM, Luis R. Rodriguez wrote:
> Clarify the provenance of the firmware loader firmware_class module name
> and why we cannot rename the module in the future.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>   .../driver-api/firmware/fallback-mechanisms.rst          | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> index a39323ef7d29..a8047be4a96e 100644
> --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> @@ -72,9 +72,12 @@ the firmware requested, and establishes it in the device hierarchy by
>   associating the device used to make the request as the device's parent.
>   The sysfs directory's file attributes are defined and controlled through
>   the new device's class (firmware_class) and group (fw_dev_attr_groups).
> -This is actually where the original firmware_class.c file name comes from,
> -as originally the only firmware loading mechanism available was the
> -mechanism we now use as a fallback mechanism.
> +This is actually where the original firmware_class module name came from,
> +given that originally the only firmware loading mechanism available was the
> +mechanism we now use as a fallback mechanism, which which registers a

Just a tiny repeated word here, "which which".

-Andres


> +struct class firmware_class. Because the attributes exposed are part of the
> +module name, the module name firmware_class cannot be renamed in the future, to
> +ensure backward compatibilty with old userspace.
>   
>   To load firmware using the sysfs interface we expose a loading indicator,
>   and a file upload firmware into:
> 
