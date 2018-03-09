Return-Path: <kernel-hardening-return-12318-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvNfz+YW6ZA4XRSmY0o9VhlhajufR6o0Ii2gl/A802DitDuPu26U3qY6s4fke77DAK2lHvb
ARC-Seal: i=1; a=rsa-sha256; t=1520600687; cv=none;
        d=google.com; s=arc-20160816;
        b=VOK3euQTUzn/8DN26VPOvusXEOspRvfAcWGUZjE3Kh3yEti3AT+CUkV+CkpXVMz3gi
         myHyoZQqC3VQlaCzVHpH14qGCQcSYvs/7NaTPzV4kz2vuB1SWnGhe+O7M7TPd4cSZiId
         p50SJTbv66/K67vOi79aW1nwhRETqFXq5b8PrUykgTTJgnMw9dJEVi1bN+sgS8BXY6+X
         c5MyBwQ4ynSSUHUZWn81f27HkxjyT9mj6BGd1AVBBDWQR6zjTSEdc5acIjYx1mRadJu1
         4cWkBjHesT2+CNtMjDPOIOiWYIlO0AWQX1iCaeH9fzE9t5DYrP3JlCewDuqN9NqHRpse
         /+0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature:delivered-to
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=4roMawmHVkWHMQkUhDc9pGvDbBjTTYou7GT5zEoKXqg=;
        b=E+p8fcdMtLcd+mxYa+UbtvOFMTNgDXIyyouMoYFNyAEry2rDMn+AGeU/o4ZKJ8lBB7
         nLeP5oDIuhZ+XKWHRXA+4gmDC8lDChgjR0LDI5lhuesPjJ0d+YZR/eENDyRsg8rkg/nW
         E4VVYQgpVtAprSPSTZNQrkskvsO/YboTPKe8i3KGcuobPbQvRuuehEyrUHWWLewDddi5
         M9BcyF0kE3S0rRyul3gSCoTuGJQ88Zqxn9m3I3FgmGhaoMNgNIrrMW5a6coFeScmW6yZ
         4frHjGbNOez/guUjOXrB+hZTK76QQWxTwGlOSMm/hokCDrm3o2TVHKsYzqxkxxkiGsTX
         MF/Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hCz8htSr;
       spf=pass (google.com: domain of kernel-hardening-return-12318-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12318-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hCz8htSr;
       spf=pass (google.com: domain of kernel-hardening-return-12318-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12318-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
Date: Fri, 9 Mar 2018 18:21:24 +0530
From: Himanshu Jha <morganfreeman6991@gmail.com>
To: Andreas Christoforou <andreaschristofo@gmail.com>
Cc: keescook@chromium.org, kernel-hardening@lists.openwall.com,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,
	Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
Message-ID: <20180309125124.GA17968@himanshu-Vostro-3559>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594465387137769315?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 02:30:12PM +0200, Andreas Christoforou wrote:
> The kernel would like to have all stack VLA usage removed.
> 
> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
> ---
>  drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
> index 6fee9a4..cfb0f84 100644
> --- a/drivers/net/wireless/ath/ath9k/dfs.c
> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
> @@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX		= 10;
>  
>  /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
>  #define NUM_DIFFS 3
> -static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);

Are you sure it is correct ?
Look for other users of "FFT_NUM_SAMPLES".

>  /* Threshold for difference of delta peaks */
>  static const int MAX_DIFF		= 2;
> @@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
>  				 int datalen, bool is_ctl, bool is_ext)
>  {
>  	int i;
> -	int max_bin[FFT_NUM_SAMPLES];
> +	int max_bin[NUM_DIFFS + 1];
>  	struct ath_hw *ah = sc->sc_ah;
>  	struct ath_common *common = ath9k_hw_common(ah);
>  	int prev_delta;

Always compile test the driver before sending a patch.
Also, patch title seems incorrect *ath9k*

himanshu@himanshu-Vostro-3559:~/linux-next$ git log --oneline drivers/net/wireless/ath/ath9k/dfs.c
626ab67 ath9k: dfs: use swap macro in ath9k_check_chirping
50c8cd4 ath9k: remove cast to void pointer
8fc2b61 ath9k: DFS - add pulse chirp detection for FCC
....

-- 
Thanks
Himanshu Jha
