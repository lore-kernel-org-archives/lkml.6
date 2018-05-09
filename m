Return-Path: <mchehab+samsung@kernel.org>
X-Google-Smtp-Source: AB8JxZpwjyBJJf3glQ1oI2oj3hZfZxe6Kw84+jVYwhAIjUv5B+9HMpxXLaresBMvGGI9mOHrQilq
ARC-Seal: i=1; a=rsa-sha256; t=1525872093; cv=none;
        d=google.com; s=arc-20160816;
        b=LLjSxMq6z4qTouVLPqqBu/DveMvQc+jGv7RDjL/yz+emng9mpZ5lBJcWS/W9kW71TF
         mZHxpT8KEriJyBLqXRuk8Hxdt6DX3XuSyR79ak+IFao/OtVwXbOjS5jm5YC2TIQ4WBzk
         Zfu3fijpm6WQ1S7H7OyNGYYRiW6mVoXWj6NMW5FP2S8ve5y+1ZNJT0H/26uCaoJh9aMf
         tFXMEb/qOaqnsUcRAqwVUp+C0jJt+ed44/bsk9zruGwbB3ChQY9ujVkxYer/iSPiU+s8
         Ad2GqM4bPZEVKlwI55F/KMKg4aLV4btNA3vCfshg+LvJ+WaK35uveOsuJkNeG38ob7UW
         UI4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=fWp43Pnk3W4qgYR7qBobzgG0SgLd0Fyon1I8O+aNlyI=;
        b=ts8zhTczAXK/P5iaT/2Lf46knjiiZC/gOHSrvL9e4BNs44gwxh/LNmGLHqwfXH/qkx
         lsUuppCGI8mE9CCu5OksVXOpDdCfs+qZ9eWfoz006T5AhLmStGuFy3TWK8dCJBwXHZhd
         m9+sxcpvfUh0RAlDySuyHNJngftTJApfmP4zM9RZPgu4gen4hEohUG6aPlmQ4/ifOz4U
         lswNWKxh75xoBxnSLp720TV8pxb3q+YCzTGYJ0AwsDHJFlydgu6JBZzeeY1Af+0cet9l
         d6kJaU8FlTwHt1oT/3puwlgJMiguILvB/yyeQ+j7f0EpDYc9whzPrj3KqyHZXAOnHI6i
         9MDA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Qia8o8kE;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Qia8o8kE;
       spf=softfail (google.com: domain of transitioning mchehab+samsung@kernel.org does not designate 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=mchehab+samsung@kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org
Date: Wed, 9 May 2018 10:21:08 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: gregkh@linuxfoundation.org, akpm@linux-foundation.org,
 keescook@chromium.org, josh@joshtriplett.org, maco@android.com,
 andy.gross@linaro.org, david.brown@linaro.org, bjorn.andersson@linaro.org,
 teg@jklm.no, wagi@monom.org, hdegoede@redhat.com, andresx7@gmail.com,
 zohar@linux.vnet.ibm.com, kubakici@wp.pl, shuah@kernel.org,
 mfuzzey@parkeon.com, dhowells@redhat.com, pali.rohar@gmail.com,
 tiwai@suse.de, kvalo@codeaurora.org, arend.vanspriel@broadcom.com,
 zajec5@gmail.com, nbroeking@me.com, markivx@codeaurora.org,
 broonie@kernel.org, dmitry.torokhov@gmail.com, dwmw2@infradead.org,
 torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
 jewalt@lgsinnovations.com, oneukum@suse.com, cantabile.desu@gmail.com,
 ast@fb.com, hare@suse.com, jejb@linux.vnet.ibm.com,
 martin.petersen@oracle.com, khc@pm.waw.pl, davem@davemloft.net,
 arve@android.com, tkjos@android.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 13/13] Documentation: clarify firmware_class
 provenance and why we can't rename the module
Message-ID: <20180509102108.7049f7a9@vento.lan>
In-Reply-To: <20180508181247.19431-14-mcgrof@kernel.org>
References: <20180508181247.19431-1-mcgrof@kernel.org>
	<20180508181247.19431-14-mcgrof@kernel.org>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599920608674205681?=
X-GMAIL-MSGID: =?utf-8?q?1599992856102477260?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Em Tue,  8 May 2018 11:12:47 -0700
"Luis R. Rodriguez" <mcgrof@kernel.org> escreveu:

> Clarify the provenance of the firmware loader firmware_class module name
> and why we cannot rename the module in the future.
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  .../driver-api/firmware/fallback-mechanisms.rst          | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> index a39323ef7d29..a8047be4a96e 100644
> --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> @@ -72,9 +72,12 @@ the firmware requested, and establishes it in the device hierarchy by
>  associating the device used to make the request as the device's parent.
>  The sysfs directory's file attributes are defined and controlled through
>  the new device's class (firmware_class) and group (fw_dev_attr_groups).
> -This is actually where the original firmware_class.c file name comes from,
> -as originally the only firmware loading mechanism available was the
> -mechanism we now use as a fallback mechanism.
> +This is actually where the original firmware_class module name came from,
> +given that originally the only firmware loading mechanism available was the
> +mechanism we now use as a fallback mechanism, which which registers a
> +struct class firmware_class. Because the attributes exposed are part of the
> +module name, the module name firmware_class cannot be renamed in the future, to
> +ensure backward compatibilty with old userspace.

Ah, now the explanation makes a lot more sense to me :-)

Reviewed-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

>  
>  To load firmware using the sysfs interface we expose a loading indicator,
>  and a file upload firmware into:



Thanks,
Mauro
