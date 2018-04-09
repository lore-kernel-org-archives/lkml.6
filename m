Return-Path: <rohitkr@codeaurora.org>
X-Google-Smtp-Source: AIpwx49e1PwqP4VpMmN5ZMWV8DMi4v2yVAAGfLj8JL7FaKDDlTJcHYlZxuqqdkcngFNZO0wXvQsP
ARC-Seal: i=1; a=rsa-sha256; t=1523274863; cv=none;
        d=google.com; s=arc-20160816;
        b=MB8NAZFhDLzCE8FLhJsrCBqb5IkvT+YU4HH3t+wnDsYuBzISIwywbMMy0bLjC7T/0C
         BlNlFKLQ3LixiKnZCNzzqKHdErLghyYIPdY8HFkxnvp7NjeFPFa0DKks9ByiRx8jEWf3
         uxqIEl/xhs8hFCwX7J9EcYYFJZzfyK6YosMVZCH0LhYHabAgPbONxPmDK1zBZqKhHvCn
         pxk3oXiak5LrWjcpP/6eDQ7f8ps0uas47bLSzZyjj4oN7XKhW6Y5mHzdgH1AwnyaHuRO
         E2refUpBKgPiNTgq+i1/D3ECl9YZp5x78Bva1gf24n5n/NpO4wc6CI/0sD5sXErNdXIE
         4C4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=roLR/07Qsen+JC9CJghK4W/Pt7bLJvijztsDObqzli8=;
        b=NPMEW5wNxHqG9u3qhEsXPduRwl8nLMoM1+NQDP+zNpQYQaHhnsOkORKUMG6bx8dbzj
         HteVCXH9EmAN5zt0Scqt5AHiFLA6PQccgWvETwatApmLQwPmIHdNMOHeNi9TXKIRWG2g
         +2IQoHLTi9k7UxP5uI4EtbD/7DzRaQ+43AKfqXAIltXJCKUnbbT9R/2p9JIoclWBbRlF
         Muk+QAI2fcyOb3T+IPCf2WfelSakgfTDypZdEAf+CfgSmF3B+UKhNag0qxl6GPqsm3GL
         UwKfZHDmn1GDOHB/alUNAYKxfdrQtDSdRqOIlFNkuvqdiPu/FPMOoVfKoWMSTVVFuW1W
         at0g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dU6hyE7c;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPdA+qVt;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=dU6hyE7c;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=nPdA+qVt;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 720F66076A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 14/24] ASoC: qdsp6: q6asm: Add support to
 audio stream apis
To: srinivas.kandagatla@linaro.org, andy.gross@linaro.org,
 broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 bgoswami@codeaurora.org, rohkumar@qti.qualcomm.com,
 gregkh@linuxfoundation.org, plai@codeaurora.org, lgirdwood@gmail.com,
 tiwai@suse.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180310022456.26739-1-srinivas.kandagatla@linaro.org>
 <20180310022456.26739-15-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <3661b4c5-c79d-d73e-5e95-57e849775517@codeaurora.org>
Date: Mon, 9 Apr 2018 17:23:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310022456.26739-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594515920555563949?=
X-GMAIL-MSGID: =?utf-8?q?1597269462522330313?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 3/10/2018 7:54 AM, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>
> This patch adds support to open, write and media format commands
> in the q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Reviewed-and-Tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 744 ++++++++++++++++++++++++++++++++++++++++++-
>   sound/soc/qcom/qdsp6/q6asm.h |  49 +++
>   2 files changed, 792 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 8a2ca2ff9ce8..ddbf526358bd 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -9,6 +9,8 @@
>   #include <linux/device.h>
>   #include <linux/spinlock.h>
>   #include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <uapi/sound/asound.h>
>   #include <linux/delay.h>
>   #include <linux/slab.h>
>   #include <linux/mm.h>
> @@ -17,10 +19,36 @@
>   #include "q6dsp-errno.h"
>   #include "q6dsp-common.h"
>   
> +#define ASM_STREAM_CMD_CLOSE			0x00010BCD
> +#define ASM_STREAM_CMD_FLUSH			0x00010BCE
> +#define ASM_SESSION_CMD_PAUSE			0x00010BD3
> +#define ASM_DATA_CMD_EOS			0x00010BDB
> +#define ASM_DEFAULT_POPP_TOPOLOGY		0x00010BE4
Use NULL topology instead of default topology.
#define ASM_NULL_POPP_TOPOLOGY                     0x00010C68
> +#define ASM_STREAM_CMD_FLUSH_READBUFS		0x00010C09
> +#define ASM_STREAM_CMD_SET_ENCDEC_PARAM		0x00010C10
[..]
> +	q6asm_add_hdr(ac, &open.hdr, sizeof(open), true, ac->stream_id);
> +
> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
> +	open.mode_flags = 0x00;
> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
> +
> +	/* source endpoint : matrix */
> +	open.sink_endpointype = ASM_END_POINT_DEVICE_MATRIX;
> +	open.bits_per_sample = bits_per_sample;
> +	open.postprocopo_id = ASM_DEFAULT_POPP_TOPOLOGY;
  open.postprocopo_id = ASM_NULL_POPP_TOPOLOGY;
> +
> +	switch (format) {
> +	case FORMAT_LINEAR_PCM:
> +		open.dec_fmt_id = ASM_MEDIA_FMT_MULTI_CHANNEL_PCM_V2;
> +		break;
> +	default:
> +		dev_err(ac->dev, "Invalid format 0x%x\n", format);
> +		return -EINVAL;
> +	}
> +
> +	rc = q6asm_ac_send_cmd_sync(ac, &open);
> +	if (rc < 0)
> +		return rc;
> +
> +	ac->io_mode |= ASM_TUN_WRITE_IO_MODE;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(q6asm_open_write);
