Return-Path: <kernel-hardening-return-12388-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvf0A7JoCAN5u3IBNf+LIlukgAQyULIcDqTyFM90hQzm9V8SXDVCu0ycCcPPk86FJhdmFws
ARC-Seal: i=1; a=rsa-sha256; t=1520723185; cv=none;
        d=google.com; s=arc-20160816;
        b=EiB9geFvS2wepgBi1GxSsmHhfmmJ/F6wvEQGWBSsBZuPCi0WRDZmay8DgVFJ/MCwY+
         fRGDhdwgWd949kp2ASbes0iZTwpumQ9/goWO3Qx2QtLpUUxD4owGc1fSq9/I7Kq72x2B
         KR7pDDfFKSl/SgedwP794W7Vtm3Pc+a06Ww40v3xUQ4vWH2E9i15bhVUWhpYpuSR1wbn
         CemdIiYDvj/q9zRTWolY5Kqmjq34M7kgIEZyE32ba3XXLsJcjJCUeJ3UJm9aHxgNZvVS
         Vw2/2JTr+RpVktriGram0EHVlMDT7IYNJDA3bRmCCGgOAjkGB15LnqHka8aqq8TsI3ma
         Uqxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=DK9VLqTRRWq2hN9EglAZso4hp+E8gUFJlhzN4IGGzSk=;
        b=nk/An5qSKltf7TdBVCjpbsAw5rdhYdae/Sb5BMgOdUJS/SKq5/nX7UOxpuxzo2WtGz
         MQ3AODgrXhuwwVsiDGSsPrIk7AFla9i8REwzGM3D+0vmlEfn+X6Prlt7EpbuH9UuKU45
         QBHTtkFNP1cTiMbGprz7fg4nnTMjUwDJxy11LfF5JSzZSG/EByXiVZ2sXcNZnvwMtOaL
         Hcj0YamDC8i85SE8vjHl+71maKfKg3glS8I1oSghq5xwXWATfoLZKjD6X6jm9C/FdCTW
         nG20HIQuUSG2xbBATs/MU9IiRacX7zS5oiAow668/UPym1Ql9eddxHiflV6h10Cz4oq9
         6wUw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=LEV3B5Uq;
       spf=pass (google.com: domain of kernel-hardening-return-12388-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12388-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@broadcom.com header.s=google header.b=LEV3B5Uq;
       spf=pass (google.com: domain of kernel-hardening-return-12388-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12388-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=QUARANTINE sp=QUARANTINE dis=NONE) header.from=broadcom.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: Andreas Christoforou <andreaschristofo@gmail.com>, keescook@chromium.org
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
Cc: kernel-hardening@lists.openwall.com,
 QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
 Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
From: Arend van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <5AA464DE.90100@broadcom.com>
Date: Sun, 11 Mar 2018 00:06:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594593834672771810?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/2018 1:30 PM, Andreas Christoforou wrote:
> The kernel would like to have all stack VLA usage removed.

I think there was a remark made earlier to give more explanation here. 
It should explain why we want "VLA on stack" removed.

> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> ---
>   drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
> index 6fee9a4..cfb0f84 100644
> --- a/drivers/net/wireless/ath/ath9k/dfs.c
> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
> @@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX		= 10;
>
>   /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
>   #define NUM_DIFFS 3
> -static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
>
>   /* Threshold for difference of delta peaks */
>   static const int MAX_DIFF		= 2;
> @@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
>   				 int datalen, bool is_ctl, bool is_ext)
>   {
>   	int i;
> -	int max_bin[FFT_NUM_SAMPLES];
> +	int max_bin[NUM_DIFFS + 1];

Just wondering. Is this actually a VLA. FFT_NUM_SAMPLES was static const 
so not really going to show a lot of variation. This array will always 
have the same size on the stack.

Regards,
Arend
