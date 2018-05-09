Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqdWCal6m0VqDQHCyJ9B7KGKiC/vrgl+3TssXqajH1dU1zR1Q551KFNFwPEcxAh3hESD+Pk
ARC-Seal: i=1; a=rsa-sha256; t=1525853407; cv=none;
        d=google.com; s=arc-20160816;
        b=e1xtxJxxCFtZ4hQH96P3b6bukdDOYnKFZO4/BERu0TTibXBnCoDTmNaFRv24uaNJdf
         APcIVmHauoJdAOWMD6Ub7y/+2fN8X9gI9FZaI7PO+aqGkXFaKFyV6c8qShVfQY6gb9hd
         5Whghm50FD3DSv3iveUH6Drrr0JxhSWrrQnuBK76cpwFsePORxyJxcBF5O0NkJtYYYet
         s0878GfwAeBnrkJEHc5/Lc2+QQ4WrYCWLuZjHMA96ZDr4Vyfps6Z7pROYtCQL0KIi/qg
         zJ8++uSdfHol987rNMz9Ika1r5GLlPFIWQNDnOspWH+4zo/Z2kJwRFF2RYSNI+syR1kP
         GOoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=r6NzBBf07sp7OusWGnK0+/RnxuB7AC3GaCOPR12yT1I=;
        b=SE37LPIRqlwMBPbWV1V1Jh+H7oF98hYdzBRRxlT9/k0jZiOqqy6MPAbvJtxfXyQtuz
         eHvLQm/d5aWJw+i7Dw3/z37DZoSarBaQ5eSBrXDdyLzuCVOD0tZJFteXG/HVbdv8wnzm
         L2GR6hcOBDFFGI7jdFjFEcZ/jjnSK1Eq6IBrxcdFhG2heppZlbxVij/MAdanEgMq7m2C
         Q3iszu8aZxw5dPPaYDTfQcDMVq8Fen80CiFXpaNARzRAxK81lQme3vsIUAiEjMcmLCBt
         NfzBK5KNp2YEhAOTrsCP8ityXLso4y8e+D4WCtRwK8k5CZaeGbFn5+G2tXvBPqYJAgoR
         HTzQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GuIFPvz6;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UAvUkid2;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=GuIFPvz6;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=UAvUkid2;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8A6460386
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 14/24] ASoC: qdsp6: q6asm: Add q6asm driver
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <3e7601d4-0304-3aa1-66cc-617b99727567@codeaurora.org>
Date: Wed, 9 May 2018 01:10:03 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-15-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263625649235845?=
X-GMAIL-MSGID: =?utf-8?q?1599973262151752691?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds basic support to Q6 ASM (Audio Stream Manager) module on
> Q6DSP. ASM supports up to 8 concurrent streams. each stream can be setup
> as playback/capture. ASM provides top control functions like
> Pause/flush/resume for playback and record. ASM can Create/destroy encoder,
> decoder and also provides POPP dynamic services.
>
> This patch adds support to basic features to allow hdmi playback.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/Kconfig        |   4 +
>   sound/soc/qcom/qdsp6/Makefile |   1 +
>   sound/soc/qcom/qdsp6/q6asm.c  | 215 ++++++++++++++++++++++++++++++++++++++++++
>   sound/soc/qcom/qdsp6/q6asm.h  |  15 +++
>   4 files changed, 235 insertions(+)
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm.c
>   create mode 100644 sound/soc/qcom/qdsp6/q6asm.h
>
> diff --git a/sound/soc/qcom/Kconfig b/sound/soc/qcom/Kconfig
> index 971127edbc23..941774abd94f 100644
> --- a/sound/soc/qcom/Kconfig
> +++ b/sound/soc/qcom/Kconfig
> @@ -53,6 +53,9 @@ config SND_SOC_QDSP6_AFE
>   config SND_SOC_QDSP6_ADM
>   	tristate
>   
> +config SND_SOC_QDSP6_ASM
<snip>
> +static const struct of_device_id q6asm_device_id[]  = {
> +	{ .compatible = "qcom,q6asm" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, q6asm_device_id);
> +
> +static struct apr_driver qcom_q6asm_driver = {
> +	.probe = q6asm_probe,
> +	.remove = q6asm_remove,
> +	.callback = q6asm_srvc_callback,
> +	.driver = {
> +		.name = "qcom-q6asm",
> +		.of_match_table = of_match_ptr(q6asm_device_id),
> +	},
> +};
> +
> +module_apr_driver(qcom_q6asm_driver);
> +MODULE_DESCRIPTION("Q6 Audio Stream Manager driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/sound/soc/qcom/qdsp6/q6asm.h b/sound/soc/qcom/qdsp6/q6asm.h
> new file mode 100644
> index 000000000000..92cc0efaa2c8
> --- /dev/null
> +++ b/sound/soc/qcom/qdsp6/q6asm.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __Q6_ASM_H__
> +#define __Q6_ASM_H__
> +
> +#define MAX_SESSIONS	16
MAX_SESSIONS should be 8?

Otherwise LGTM.
Once addressed about, add acked-by-
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
