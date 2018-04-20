Return-Path: <kvalo@codeaurora.org>
X-Google-Smtp-Source: AIpwx4/m/At5FVV58ePfHzr2MnpoqKP/+29yFF4sRGYw1MGobhdmd0iqM0fZkItGTYMy89smXcb1
ARC-Seal: i=1; a=rsa-sha256; t=1524220008; cv=none;
        d=google.com; s=arc-20160816;
        b=YVF+MUZOf9BkkqkOWIJfd8FZWF1dAQ5oXk4lusnbMIMdEZVZv+tiwI6IHNAKarE+fr
         doa0OUNeooAUJgvA68pKemioO486nA3JXTYUvi++HDW8s1AtNDDTaN3cdyAVZQ2oEX3V
         JAeYO1AQ4FnFcFPoAmXgNzJKh744YzB73NZwOgDLRbjzP9+tcDUAw+4YGqBhs/OJTzUc
         aS/eG9RZr3PNczqLQiJAH3A5Sg8ztE4Y5rQEujAGUanljrFWGnf4j1xFbuau3qBKZMVs
         EJQG/JMRN6puLcn0ZFfTMHS63Wavbh7JkNBA+a6OxZakVT0AJ7zF1Z4vFykaISrxPNsF
         u9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=xg2KITv3vuhf3KFubv5sSA6mLV9cP2xCjrHxZ4jfEJE=;
        b=AMeZRq68dpKJ5UGcCMdwjULlkwP76CgWM+DmuuoUwRRhFktZ8uEWBzJEYUWA5Qldcx
         vGmuyjpYTw0R9QrBESRzkSpx3DDyZpLkQKwVKRUJHFJW7UNi7p5MayLoTg6I4602WdsE
         Egqc7NrrsHRHl7Q2gjarfilbKob5mipjbMqUJ5zo2AlsYaZSEKmqFE+kAFmTw3lKHjGE
         Og3rOetredyjLpJWTmKdSfvhUgm3jd3YDK98lFSdjhj29mq2RiohQsMN8+5BTAQvzBPX
         q6QXY5dTVjbiVyg9ijeI3zU/2ZMdBPzt5dOHKf5p5+3PQ/XyXCv15umU8pCVteESbsip
         CAGw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cvcltHLt;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cvcltHLt;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cvcltHLt;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=cvcltHLt;
       spf=pass (google.com: domain of kvalo@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=kvalo@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2769660264
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Andres Rodriguez <andresx7@gmail.com>
Cc: linux-kernel@vger.kernel.org,  gregkh@linuxfoundation.org,  mcgrof@kernel.org,  alexdeucher@gmail.com,  ckoenig.leichtzumerken@gmail.com,  arend.vanspriel@broadcom.com, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] brcmfmac: use request_firmware_nowait2 to load firmware without warnings
References: <20180417153307.3693-1-andresx7@gmail.com>
	<20180417153307.3693-10-andresx7@gmail.com>
Date: Fri, 20 Apr 2018 13:26:42 +0300
In-Reply-To: <20180417153307.3693-10-andresx7@gmail.com> (Andres Rodriguez's
	message of "Tue, 17 Apr 2018 11:33:07 -0400")
Message-ID: <87h8o6i36l.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008020626065507?=
X-GMAIL-MSGID: =?utf-8?q?1598260519291132381?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Andres Rodriguez <andresx7@gmail.com> writes:

> This reduces the unnecessary spew when trying to load optional firmware:
> "Direct firmware load for ... failed with error -2"
>
> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
> ---
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

With wireless patches always CC linux-wireless list, please. Adding it
now.

> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> index 091b52979e03..26db3ebd52dc 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
> @@ -503,8 +503,9 @@ static void brcmf_fw_request_code_done(const struct firmware *fw, void *ctx)
>  		goto done;
>  
>  	fwctx->code = fw;
> -	ret = request_firmware_nowait(THIS_MODULE, true, fwctx->nvram_name,
> -				      fwctx->dev, GFP_KERNEL, fwctx,
> +	ret = request_firmware_nowait(THIS_MODULE, true, false,

A perfect example why enums should be in function calls instead of
booleans, that "true, false" tells nothing to me and it would be time
consuming to check from headers files what it means. If you had proper
enums, for example "FIRMWARE_MODE_FOO, FIRMWARE_STATE_BAR", it would be
immediately obvious for the reader what the parameters are. Of course
the first boolean was already there before, but maybe change the new
boolean to an enum?

> +				      fwctx->nvram_name, fwctx->dev,
> +				      GFP_KERNEL, fwctx,
>  				      brcmf_fw_request_nvram_done);
>  
>  	/* pass NULL to nvram callback for bcm47xx fallback */
> @@ -547,7 +548,7 @@ int brcmf_fw_get_firmwares_pcie(struct device *dev, u16 flags,
>  	fwctx->domain_nr = domain_nr;
>  	fwctx->bus_nr = bus_nr;
>  
> -	return request_firmware_nowait(THIS_MODULE, true, code, dev,
> +	return request_firmware_nowait2(THIS_MODULE, true, false, code, dev,
>  				       GFP_KERNEL, fwctx,
>  				       brcmf_fw_request_code_done);
>  }

Also the number two in the function name is not really telling anything.
I think that something like request_firmware_nowait_nowarn() would be
better, even if it's so ugly.

-- 
Kalle Valo
