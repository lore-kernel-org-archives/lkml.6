Return-Path: <srirrama@codeaurora.org>
X-Google-Smtp-Source: AB8JxZqCAg5LRAiUVJkLBwvG9hg2i1LdZoorOMf3fzCZ1oKlUpFtgoFYTCnUFOBhrjNU3Mv7KHYS
ARC-Seal: i=1; a=rsa-sha256; t=1525132602; cv=none;
        d=google.com; s=arc-20160816;
        b=qsm1oZa+2cuRFlmFl5imhzt5NMHbVyYlkfDKe0IuaEQsBnY3GS3ZiuyW9aVEyD7+Mb
         rekPgkjuPA3OYMcSCdiFv7GZYxMTIUEIlxx7PKIy/+qxL8sgfK1XIiiREIrHB7P/OYnX
         /w6XDoa7F6zZgU6V8d8E66oTj2AaH9IreEUUqnl1rUL+j1JebwhqhZL5pOF4qb67rFER
         qlVJQPNtSqGhloAiIlauzXNH+UbluR/pRixS91IU06gWws9xPDEJcg21grW5nvWBewie
         q7bJfCzeyDUdY31qi29WV7088XBkGmDge5sT2G3u6If3tylwQLq+vBnEg8y2McHNlNBY
         Oiig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:message-id:references:in-reply-to:subject:cc:to:from
         :date:content-transfer-encoding:mime-version:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=wv1xGFJLEFvt+8tJQmSr28QE/h+/5jcmgBGRFzchTXc=;
        b=rbKHfTlzlqV/KR1+gfn6dgLLzu1rMNxBzn3GJSG1BV3zM1X1rxvPSpRhKbw85x/wYe
         qIstJUiLkP7isGAka9y0rOV/WGso72Uy44mLAIEcLae8I1jhraAJxVv89VGWY2JRTtHc
         KcbMWMrtnRnzGVdTnXXbN7IskQjwjlelSqy2dbGyzKUQyDU0gZejPI32MSfspASCsQbD
         LZQTVcww+Rtr5E5xpRgRGc0YzpHTzce0GLYop882u6ba5/NyYzMRwrIh/MPcN3+W/VA0
         nCb4wWyfa6HUF3QLTnDZtIgMh1uFsBVkqggL8dv4Tc2d2MYSJjBTAnIN0vqPvb1ppEZK
         4rVA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NifWNuIo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NifWNuIo;
       spf=pass (google.com: domain of srirrama@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=srirrama@codeaurora.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NifWNuIo;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=NifWNuIo;
       spf=pass (google.com: domain of srirrama@codeaurora.org designates 198.145.29.96 as permitted sender) smtp.mailfrom=srirrama@codeaurora.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 01 May 2018 05:26:41 +0530
From: Sriram R <srirrama@codeaurora.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Vasanthakumar
 Thiagarajan <vthiagar@qti.qualcomm.com>, Kalle Valo <kvalo@qca.qualcomm.com>
Subject: Re: [PATCH 4.4 44/44] ath10k: fix rfc1042 header retrieval in QCA4019
 with eth decap mode
In-Reply-To: <20180430190948.085407552@linuxfoundation.org>
References: <20180430190946.093694747@linuxfoundation.org>
 <20180430190948.085407552@linuxfoundation.org>
Message-ID: <454d05a202b8f44728e2660e3d6f95c2@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200420823969970?=
X-GMAIL-MSGID: =?utf-8?q?1599217443730737589?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-05-01 00:54, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me 
> know.
Hi Greg,

   This is a dependency patch to the actual fix ,
[PATCH 2/2 - linux-stable-4.4] ath10k: rebuild crypto header in rx data 
frames.

We would like both these patches to be upstreamed to 4.4 together.

As mentioned in cover, These patches depends on 3 other mac80211 patches 
so the below mac80211 commits needs to be picked first in the same order 
and then apply this patchset.

f980ebc058c2 : mac80211: allow not sending MIC up from driver for HW 
crypto
f631a77ba920 : mac80211: allow same PN for AMSDU sub-frames
cef0acd4d7d4 : mac80211: Add RX flag to indicate ICV stripped

These patches should be applied in that order(commit f980ebc058c2 first) 
and they should apply cleanly with --3-way merge.

Kindly revert if you face any issues.

Thanks,
Sriram.R

> 
> ------------------
> 
> From: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> 
> commit 2f38c3c01de945234d23dd163e3528ccb413066d upstream.
> 
> Chipset from QCA99X0 onwards (QCA99X0, QCA9984, QCA4019 & future)
> rx_hdr_status is not padded to align in 4-byte boundary. Define a
> new hw_params field to handle different alignment behaviour between
> different hw. This patch fixes improper retrieval of rfc1042 header
> with QCA4019. This patch along with "ath10k: Properly remove padding
> from the start of rx payload" will fix traffic failure in ethernet
> decap mode for QCA4019.
> 
> Signed-off-by: Vasanthakumar Thiagarajan <vthiagar@qti.qualcomm.com>
> Signed-off-by: Kalle Valo <kvalo@qca.qualcomm.com>
> Signed-off-by: Sriram R <srirrama@codeaurora.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/net/wireless/ath/ath10k/core.c |    8 ++++++++
>  drivers/net/wireless/ath/ath10k/core.h |    4 ++++
>  2 files changed, 12 insertions(+)
> 
> --- a/drivers/net/wireless/ath/ath10k/core.c
> +++ b/drivers/net/wireless/ath/ath10k/core.c
> @@ -67,6 +67,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA988X_BOARD_DATA_SZ,
>  			.board_ext_size = QCA988X_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA6174_HW_2_1_VERSION,
> @@ -85,6 +86,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA6174_BOARD_DATA_SZ,
>  			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA6174_HW_2_1_VERSION,
> @@ -103,6 +105,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA6174_BOARD_DATA_SZ,
>  			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA6174_HW_3_0_VERSION,
> @@ -121,6 +124,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA6174_BOARD_DATA_SZ,
>  			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA6174_HW_3_2_VERSION,
> @@ -140,6 +144,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA6174_BOARD_DATA_SZ,
>  			.board_ext_size = QCA6174_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA99X0_HW_2_0_DEV_VERSION,
> @@ -159,6 +164,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA99X0_BOARD_DATA_SZ,
>  			.board_ext_size = QCA99X0_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 1,
>  	},
>  	{
>  		.id = QCA9377_HW_1_0_DEV_VERSION,
> @@ -177,6 +183,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA9377_BOARD_DATA_SZ,
>  			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  	{
>  		.id = QCA9377_HW_1_1_DEV_VERSION,
> @@ -195,6 +202,7 @@ static const struct ath10k_hw_params ath
>  			.board_size = QCA9377_BOARD_DATA_SZ,
>  			.board_ext_size = QCA9377_BOARD_EXT_DATA_SZ,
>  		},
> +		.decap_align_bytes = 4,
>  	},
>  };
> 
> --- a/drivers/net/wireless/ath/ath10k/core.h
> +++ b/drivers/net/wireless/ath/ath10k/core.h
> @@ -670,6 +670,10 @@ struct ath10k {
>  			size_t board_size;
>  			size_t board_ext_size;
>  		} fw;
> +
> +		/* Number of bytes used for alignment in rx_hdr_status */
> +		int decap_align_bytes;
> +
>  	} hw_params;
> 
>  	const struct firmware *board;
