Return-Path: <rohitkr@codeaurora.org>
X-Google-Smtp-Source: AB8JxZrgy5qtT6ZRGavxEfq2ADz83luNU2w1WkZAb+L5NIqAzUYzUILtj5m0zBqQsMHPt1cXq/Zk
ARC-Seal: i=1; a=rsa-sha256; t=1525417936; cv=none;
        d=google.com; s=arc-20160816;
        b=y0VJN1zU5wfensDdSN/uR90mgM/h6Qw3+QE4nafuZdQxb6tmdhlpZpl5nx+nvdxaYD
         0OlZZs2HU09iroTBEU2QTN39ZbIlp8u3/w33i6x5dB3XnitXRUCNHxhOq/Puy39iMmoL
         NlKPBV+dG/oXASe607UYHC2pZjfeqymDU+TQK61IwQ8cMzyDvTWoVTMw6l1js2g5YeCO
         P8YGNghRrUpQ6Ivmbwu4hh+Ym+4l9YtHXfOzfCO4t/bHX5m5av+HH8XN9iINAGPl9r2n
         yVV12X0QAEPaSI2rUeGkPRAibj39eEiGUirn58+ooQU74vDnLgG+Y4bSpkhdwBaTPpBm
         6s9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=9867Z6L1/uUGY7VmpBnqdh3CA1Zo9dms85GO1ooW5MU=;
        b=l9uDPY2D0614PudixjOHEmGWBvISOZ8z8yCSQ+hfh3BnT2ZQJrRJUBYLQXNEFH9+Gs
         /AeCxE2BUbQkt+SB6jE1g9ze07ESUSlDijhfO/W/+saQG9nOwSlXt3VBykBM134NLaiR
         6tbdBcYDjrkYc14GmroGjnTXuoWCouzd8NiQ72olVhU7/znMbBHNlya4980OPZlGgSzY
         TY07KHDhNB+VxHGKLAWJ9POMkPNUJJav1o/PXj0XN3VeOomCXeCN3VmF0LcT+bRYgPTU
         W4nECL7tOFz6eEzYs9vdYT2OCL/HKCpagnERZ8Z5ejkDUr+DLWdceGykyRwpQU4yJUZe
         z1hQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZghoulE3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZghoulE3;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZghoulE3;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=ZghoulE3;
       spf=pass (google.com: domain of rohitkr@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=rohitkr@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDC9A607A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=rohitkr@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v7 16/24] ASoC: qdsp6: q6asm: Add support to
 audio stream apis
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 andy.gross@linaro.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, robh+dt@kernel.org, bgoswami@codeaurora.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 rohkumar@qti.qualcomm.com, gregkh@linuxfoundation.org, plai@codeaurora.org,
 tiwai@suse.com, lgirdwood@gmail.com, david.brown@linaro.org,
 linux-arm-kernel@lists.infradead.org, spatakok@qti.qualcomm.com,
 linux-kernel@vger.kernel.org
References: <20180501120820.11016-1-srinivas.kandagatla@linaro.org>
 <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
From: Rohit Kumar <rohitkr@codeaurora.org>
Message-ID: <f3b3d90b-6504-328e-c9f4-a3b3f085d9dc@codeaurora.org>
Date: Fri, 4 May 2018 12:41:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180501120820.11016-17-srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599263628693117168?=
X-GMAIL-MSGID: =?utf-8?q?1599516637793656321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 5/1/2018 5:38 PM, Srinivas Kandagatla wrote:
> +static int __q6asm_run(struct audio_client *ac, uint32_t flags,
> +	      uint32_t msw_ts, uint32_t lsw_ts, bool wait)
> +{
> +	struct asm_session_cmd_run_v2 *run;
> +	struct apr_pkt *pkt;
> +	int pkt_size, rc;
> +	void *p;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*run);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
Should be GFP_ATOMIC as this API is also called from interrupt context
> +	if (!p)
> +		return -ENOMEM;
> +
[..]
> +int q6asm_read(struct audio_client *ac)
> +{
> +	struct asm_data_cmd_read_v2 *read;
> +	struct audio_port_data *port;
> +	struct audio_buffer *ab;
> +	struct apr_pkt *pkt;
> +	int pkt_size;
> +	int rc = 0;
> +	void *p;
> +
> +	if (!(ac->io_mode & ASM_SYNC_IO_MODE))
> +		return 0;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*read);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
same here. GFP_ATOMIC
> +	if (!p)
> +		return -ENOMEM;
[..]
> +int q6asm_write_async(struct audio_client *ac, uint32_t len, uint32_t msw_ts,
> +		       uint32_t lsw_ts, uint32_t flags)
> +{
> +	struct asm_data_cmd_write_v2 *write;
> +	struct audio_port_data *port;
> +	struct audio_buffer *ab;
> +	struct apr_pkt *pkt;
> +	int pkt_size;
> +	int rc = 0;
> +	void *p;
> +
> +	pkt_size = APR_HDR_SIZE + sizeof(*write);
> +	p = kzalloc(pkt_size, GFP_KERNEL);
GFP_ATOMIC
> +	if (!p)
> +		return -ENOMEM;
>
Thanks,
Rohit

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
