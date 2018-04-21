Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AIpwx48ZOssj/9r2ELC0TN/unn3MdnEYgaImDKIqglUitJSVv28Y2PQaor0SX7mldAOa/URfZvAj
ARC-Seal: i=1; a=rsa-sha256; t=1524319045; cv=none;
        d=google.com; s=arc-20160816;
        b=CjIwVi/fK+rt3Y9BDpZ53cUtNm0ZWtKEJJrO2ErQJu2VJVXOB2Ddyg/QNuU2Fhe52D
         rgbgwIq01WgWPggpHcKwhzZUBmp/PyX4+8lOfBEDj85cAieVtDJEkxPlzGUqf4Pu04tw
         Gaa6vJI8SURoXC2hj+3VNESJ1JRwSbyHid4x74m/iOLMpSqXiGes1w8AqQCmpiyE6wJm
         Nh8L0UT1u4EeZ8rXJEM8slBTAsLnlZS6cHXcIYM7uFMbUAutWutxG9gweInAMyVdtQEQ
         UZRxGZ3iZ8FnfCr9xXVqCMmQPXeHIgSG2TcQM4ndg3gM375szumVASSsWEGhKrp0BRup
         ys1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=K4TUijuLJBoX+aGAenl/bcQfJo+boa4kWUAjscUgAdg=;
        b=P5yqd4l0WDZmyIp4phzaMGw0FUmUSsX7BCaKN3PvdLyTjUY7KEDbo13hhhksPaEXjp
         0kGDKJ07sIyIL8MfBcO+gVCSXW2kau4u5CaHQp493XknSWgu9/keWAWmkybldUGjod2J
         Xb9FvjIwX4v+G35O5zNg/UyCKGtjBOLV/HuAnXFFHpU0OxB3GwA/+huCXEXqbPZ/lA9L
         czt/6qP30nw7JODKY9MWlkiR43tr3lU9Jf4LfXSa5rlLSLFf1UFSwqo6Nf3ss0J6ZgTQ
         cFBoSHUmiwxVPUsEAFqPEyU66fBrSHV9jwpRRqHclyRtZmczKnacVErbId9qjKpFazRn
         qZiw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Sat, 21 Apr 2018 15:57:23 +0200
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	mcgrof@kernel.org, alexdeucher@gmail.com,
	ckoenig.leichtzumerken@gmail.com, kvalo@codeaurora.org,
	arend.vanspriel@broadcom.com
Subject: Re: [PATCH 2/9] firmware: wrap FW_OPT_* into an enum
Message-ID: <20180421135723.GO14440@wotan.suse.de>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-3-andresx7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417153307.3693-3-andresx7@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008012071756488?=
X-GMAIL-MSGID: =?utf-8?q?1598364367148072920?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 17, 2018 at 11:33:00AM -0400, Andres Rodriguez wrote:
> This should let us associate enum kdoc to these values.
> 
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
> diff --git a/drivers/base/firmware_loader/firmware.h b/drivers/base/firmware_loader/firmware.h
> index d11d37db370b..957396293b92 100644
> --- a/drivers/base/firmware_loader/firmware.h
> +++ b/drivers/base/firmware_loader/firmware.h
> @@ -10,13 +10,14 @@
>  
>  #include <generated/utsrelease.h>
>  
> -/* firmware behavior options */
> -#define FW_OPT_UEVENT			(1U << 0)
> -#define FW_OPT_NOWAIT			(1U << 1)
> -#define FW_OPT_USERHELPER		(1U << 2)
> -#define FW_OPT_NO_WARN			(1U << 3)
> -#define FW_OPT_NOCACHE			(1U << 4)
> -#define FW_OPT_NOFALLBACK		(1U << 5)
> +enum fw_opt {
> +	FW_OPT_UEVENT =         (1U << 0),
> +	FW_OPT_NOWAIT =         (1U << 1),
> +	FW_OPT_USERHELPER =     (1U << 2),
> +	FW_OPT_NO_WARN =        (1U << 3),
> +	FW_OPT_NOCACHE =        (1U << 4),
> +	FW_OPT_NOFALLBACK =     (1U << 5),
> +};

Please use BIT(i) and include linux/bitops.h instead.

  Luis
