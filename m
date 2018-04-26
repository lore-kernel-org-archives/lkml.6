Return-Path: <tbaicar@codeaurora.org>
X-Google-Smtp-Source: AIpwx48Yk8fR/qDhymCNh5YYaps+8T/Vps3rzQlQOHJiOA3aBYK6Q+aI2OBeUFR9Q6z0JZUsM8v+
ARC-Seal: i=1; a=rsa-sha256; t=1524763670; cv=none;
        d=google.com; s=arc-20160816;
        b=twBDNMwcRnbuEudxd2qi1Udgv8KsF/ysoIDq1ca289rJSmYgMWnbWBrNeQg5CLSgw8
         57V4HYCBPq0QD0ytuUO2VqQx/9hFL8MWg5CfO4+A8FTKQCSyufZeYUu1Pj7S1gsCDbp7
         eergKvq8NBFyLzSNsKkR33/ohemONpSZ1JNqS7M7w6k5Mjm22NWOxupChvIZqHqKANB3
         eGWayEwmWC1ENEDBeWdJpQc3+HgdWCQ6VhdoGZe8MMKhZjm5vMxozOG4FgFUr0Ze+63x
         u3gkYEKLHSmuPrwyxLaNLEz6V7SWrjRWBwwf4Dj2Q63RW2Qmk0Bw/jWJwJmECnmULFbe
         HyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dmarc-filter:dkim-signature:dkim-signature
         :arc-authentication-results;
        bh=ExaoLP6BzlUaofr04NmtWm2AD6PQO0u2W6PQJ/rpFxo=;
        b=Z8E7SdUfpagv1xXVUfaZHovXu7dY7tMT6mWlZrMId2pibtYhdr2c3OEDHfaR1eGtSw
         rGmiLSYwPK4rx4RttTcxUmJS6yYap6KYPX0QAaM1Zr/z7hptRiFm9g92DNJubo+jUXOa
         1YT//i6jGFMI6rgMErg2g66dDrdNEhhaRHQe5DkpV5OLIj5YTjyx13blAIJb7JW6eKmP
         LWnuFZv3cGmaed7N7eJcUiIg7Eze1l4klWndGVHmPxmkmb99x2IGqvG2BzjSpHKr6gvK
         MBhVjDq04Br9h3ORwKtXW7h7MviBXHI1Amd8NKw4iMr73vgb04yXQP1orwb0kiCnGsUp
         oMwg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XNNpWcFX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WXO4jM1Z;
       spf=pass (google.com: domain of tbaicar@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=tbaicar@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=XNNpWcFX;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=WXO4jM1Z;
       spf=pass (google.com: domain of tbaicar@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=tbaicar@codeaurora.org
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB35760C64
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=tbaicar@codeaurora.org
Subject: Re: [PATCH RESEND] PCI/AER: Use a common function to print AER error
 bits
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>, bhelgaas@google.com,
 linux-pci@vger.kernel.org
Cc: gregkh@linuxfoundation.org, fred@fredlawl.com,
 linux-kernel@vger.kernel.org, alex_gagniuc@dellteam.com,
 austin_bolen@dell.com, keith.busch@intel.com
References: <20180417170943.1767-1-mr.nuke.me@gmail.com>
From: Tyler Baicar <tbaicar@codeaurora.org>
Message-ID: <ab79f650-180f-24b4-f3d6-c07d10e5318c@codeaurora.org>
Date: Thu, 26 Apr 2018 13:27:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417170943.1767-1-mr.nuke.me@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598014086120567687?=
X-GMAIL-MSGID: =?utf-8?q?1598830591050080996?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/17/2018 1:09 PM, Alexandru Gagniuc wrote:
> On errors reported from CPER, cper_print_bits() was used to log the
> AER bits. This resulted in hard-to-understand messages, without a
> prefix. Instead use __aer_print_error() for both native AER and CPER
> to provide a more consistent log format.
>
> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Thanks!
> ---
>   drivers/pci/pcie/aer/aerdrv_errprint.c | 16 +++++++++-------
>   1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer/aerdrv_errprint.c b/drivers/pci/pcie/aer/aerdrv_errprint.c
> index cfc89dd57831..cfae4d52f848 100644
> --- a/drivers/pci/pcie/aer/aerdrv_errprint.c
> +++ b/drivers/pci/pcie/aer/aerdrv_errprint.c
> @@ -216,28 +216,30 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   void cper_print_aer(struct pci_dev *dev, int aer_severity,
>   		    struct aer_capability_regs *aer)
>   {
> -	int layer, agent, status_strs_size, tlp_header_valid = 0;
> +	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> -	const char **status_strs;
> +	struct aer_err_info info;
>   
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
> -		status_strs = aer_correctable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_correctable_error_string);
>   	} else {
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
> -		status_strs = aer_uncorrectable_error_string;
> -		status_strs_size = ARRAY_SIZE(aer_uncorrectable_error_string);
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>   	}
>   
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>   	agent = AER_GET_AGENT(aer_severity, status);
>   
> +	memset(&info, 0, sizeof(info));
> +	info.severity = aer_severity;
> +	info.status = status;
> +	info.mask = mask;
> +	info.first_error = 0x1f;
> +
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	cper_print_bits("", status, status_strs, status_strs_size);
> +	__aer_print_error(dev, &info);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>   		aer_error_layer[layer], aer_agent_string[agent]);
>   

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
