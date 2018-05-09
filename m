Return-Path: <bgoswami@codeaurora.org>
X-Google-Smtp-Source: AB8JxZprOoGZEfJOcXkNbfJ3OiZ830pf5XudA+POnxFMnVeGse27ahvalm7uHDaVhn7n8JONKxPc
ARC-Seal: i=1; a=rsa-sha256; t=1525861018; cv=none;
        d=google.com; s=arc-20160816;
        b=GoRW31Mfy16BPk/JFdCk5b0yefJus1qTMKYqrLXYZ1lePckSilnS/7qDgirD2mJITW
         hmlTNHAYuKhG24vuMyvbOa/OeRnSHTXCadsV5ZHwme7ZwM7JLiVWyJ/pzs2I84oXGz7A
         o1T1oJkxadOm76SxX+6z0YFml2+hJzQfc96kyyIUkKrKOx5Lh/QdnAk63BahqITvO8LA
         ojL2NoDiQNj5AtRs3Vmi3IQ0qKIaG9MNgYICKwNSZ+E5zfHxP3HF+sWckGjz6hPLxC/d
         f7Yuw6r0aw74ybXEHGvtvEdf/ardDBsT0PmBZCYiqkCNlg+CgnCNg6qxkKWjzjm2gItd
         x8JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=Njh0dw6G+LUuqN6mPmAXverJT1D5Jhji+aENqEAokiw=;
        b=KLLQI+wiX7uLo8roYQ/MleHKEwTyE+qG9N6PPSpSrjvlOFQPVTA+86QheoBUxv8I2P
         oRZ9u9nKkOvG5X2WSqJYR91Wn96nCNdh/3STawJqKq+DgEbbbekBQyy/e8HEqreD5iEb
         sIF7/KN3HwJS4+wSKi3PAZlYqIXUXYtpFl5hIqphrMYjvH5qVP9q98kyfVQFZXCwltDs
         rmgESMGC08ciGtfw6isBknafb2oKoeqd72OgEuMzt/ypsCYLP3Id22+ZEuaP1jNEYBU5
         yFoYKVVQhuGruI1L4/kWa14qks+KuiOoZ3R5Q5oqmrbpSDo7XGIlPFodwBj/Vzs6TRHg
         +Ubw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YILUx45Y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bTDuJjsR;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=YILUx45Y;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=bTDuJjsR;
       spf=pass (google.com: domain of bgoswami@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=bgoswami@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0AF1C60F6B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=bgoswami@codeaurora.org
Subject: Re: [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to audio stream
 apis
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org
Cc: gregkh@linuxfoundation.org, david.brown@linaro.org, mark.rutland@arm.com,
 lgirdwood@gmail.com, plai@codeaurora.org, tiwai@suse.com, perex@perex.cz,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, rohkumar@qti.qualcomm.com,
 spatakok@qti.qualcomm.com
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
From: Banajit Goswami <bgoswami@codeaurora.org>
Message-ID: <3296bc93-8790-3780-064c-d87422c644a9@codeaurora.org>
Date: Wed, 9 May 2018 03:16:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263628693117168?=
X-GMAIL-MSGID: =?utf-8?q?1599981243897883458?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 5/1/2018 5:08 AM, Srinivas Kandagatla wrote:
> This patch adds support to open, write and media format commands
> in the q6asm module.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reviewed-and-tested-by: Rohit kumar <rohitkr@codeaurora.org>
> ---
>   sound/soc/qcom/qdsp6/q6asm.c | 839 ++++++++++++++++++++++++++++++++++++++++++-
>   sound/soc/qcom/qdsp6/q6asm.h |  49 +++
>   2 files changed, 887 insertions(+), 1 deletion(-)
>
> diff --git a/sound/soc/qcom/qdsp6/q6asm.c b/sound/soc/qcom/qdsp6/q6asm.c
> index 5a573e927a5e..a3073de235e1 100644
> --- a/sound/soc/qcom/qdsp6/q6asm.c
> +++ b/sound/soc/qcom/qdsp6/q6asm.c
> @@ -10,6 +10,8 @@
<snip>
>   EXPORT_SYMBOL_GPL(q6asm_audio_client_alloc);
>   
> +static int q6asm_ac_send_cmd_sync(struct audio_client *ac, struct apr_pkt *pkt)
> +{
> +	struct apr_hdr *hdr = &pkt->hdr;
> +	int rc;
> +
> +	mutex_lock(&ac->lock);
> +	ac->result.opcode = 0;
> +	ac->result.status = 0;
> +
> +	rc = apr_send_pkt(ac->adev, pkt);
> +	if (rc < 0)
> +		goto err;
> +
> +	rc = wait_event_timeout(ac->cmd_wait,
> +				(ac->result.opcode == hdr->opcode), 5 * HZ);
> +	if (!rc) {
> +		dev_err(ac->dev, "CMD timeout\n");
> +		rc =  -ETIMEDOUT;
> +		goto err;
> +	}
else set rc to 0 to avoid returning >0 value.

LGTM otherwise.
Acked-by: Banajit Goswami <bgoswami@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
