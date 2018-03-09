Return-Path: <kernel-hardening-return-12322-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELuWSQO2PsLdz8EKzpzpnt1ZLHfKTaKQCAi81U+mAih/o7S/5rFRW+S0SgSLsAZiRchYBBpv
ARC-Seal: i=1; a=rsa-sha256; t=1520602191; cv=none;
        d=google.com; s=arc-20160816;
        b=sxkfnIB4IJE97YOInD+Ga1/JaPdxU7XzDQgd+Z/RTkhjghP+7bP5KVt0zzv60LHOT8
         vHR4JG/DMe5EFtTvS/Q12PJ2k/JYhcbI7CNzIrIDzaIe8c/FL+Fk3QFaBngZbQbLEjG+
         RWzzhHDgq3/tqbeJ9CGeyUDvalZxqnjmK4NjzgzlGPehAKkSO1eNAEkybvJZXTZkazYo
         iFZL0hrf1JnvFDe5MrWg0dRJNyD+Swc13EhaNcQLuup/xGDFMvhVRFhYLdAWuOb7x7Dc
         S2pVuyY4+9T6Ezht2bOn3kvUyfUBd1PtfrVgqUd5fOEaVeH3VK5+YXmMzPW2Z7BcUf+S
         f2yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:delivered-to:list-id:list-subscribe
         :list-unsubscribe:list-help:list-post:precedence:mailing-list
         :arc-authentication-results;
        bh=ZeQMth7nHdFpsIqawfT84AobiyrxO6PAeFUTY/ANpF4=;
        b=djB7SKTnY5iNAqc0vwBz00tp38knSFUx1VJBC21tvVwesdDrn8nkAvGSyraVBbuAbk
         C6ZHX8TID3VM75AONuwcvM9RjY8znqCM9P6TLEwdBx9byYJp3qUiD5m4fPxc1LpsAmVU
         qUOTXt4uxJVQh9jp0TB8rdYtazXkkOse4KxF/swfrDX/4fzVFlaU7JjSz5FLL9N8c2xL
         EPonUtLoEvrcmuj7ALV8EXdAcWBYK9/hL5CwF1X46MByIYt0NHHtliZP8a17BvhHjZ6R
         x5R0Y3r1p/YhYP2lYydA169vQZyvgorQ0SzlQsL+LkjA25rtttWSdlomuW3ouXq7mFfP
         GI9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12322-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12322-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12322-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12322-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::,RULES_HIT:41:355:379:541:599:960:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3867:3871:4250:4321:4605:5007:6119:10004:10400:10848:11026:11232:11473:11657:11658:11914:12043:12296:12438:12740:12760:12895:13069:13311:13357:13439:14659:14721:21080:21451:21627:30054:30070:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:20,LUA_SUMMARY:none
X-HE-Tag: hate49_18ea46b768124
X-Filterd-Recvd-Size: 2219
Message-ID: <1520602169.26370.1.camel@perches.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9k: dfs: remove VLA
 usage
From: Joe Perches <joe@perches.com>
To: Andreas Christoforou <andreaschristofo@gmail.com>, keescook@chromium.org
Cc: kernel-hardening@lists.openwall.com, QCA ath9k Development
	 <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Date: Fri, 09 Mar 2018 05:29:29 -0800
In-Reply-To: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
References: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594466629940454496?=
X-GMAIL-MSGID: =?utf-8?q?1594466964272537045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-03-09 at 15:23 +0200, Andreas Christoforou wrote:
> The kernel would like to have all stack VLA usage removed.
> This is the correct patch.
[]
> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
[]
> @@ -101,7 +101,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
>  				 int datalen, bool is_ctl, bool is_ext)
>  {
>  	int i;
> -	int max_bin[FFT_NUM_SAMPLES];
> +	int max_bin[NUM_DIFFS + 1];
>  	struct ath_hw *ah = sc->sc_ah;
>  	struct ath_common *common = ath9k_hw_common(ah);
>  	int prev_delta;

why not just change FFT_NUM_SAMPLES to a #define
or get rid if FFT_NUM_SAMPLES altogether?

$ git grep -w FFT_NUM_SAMPLES
drivers/net/wireless/ath/ath9k/dfs.c:static const int FFT_NUM_SAMPLES   = (NUM_DIFFS + 1);
drivers/net/wireless/ath/ath9k/dfs.c:   int max_bin[FFT_NUM_SAMPLES];
drivers/net/wireless/ath/ath9k/dfs.c:           if (num_fft_packets < (FFT_NUM_SAMPLES)) {
drivers/net/wireless/ath/ath9k/dfs.c:           for (i = 0; i < FFT_NUM_SAMPLES; i++)
drivers/net/wireless/ath/ath9k/dfs.c:           if (num_fft_packets < (FFT_NUM_SAMPLES)) {
drivers/net/wireless/ath/ath9k/dfs.c:           for (i = 0; i < FFT_NUM_SAMPLES; i++)
