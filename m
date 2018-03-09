Return-Path: <kernel-hardening-return-12330-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELu0pSP0jRrqTuixS+71EQi6FOESawBpCtnHw+rbSiVz84a6XhDIjc6KFUHyfc09n5iYFEpt
ARC-Seal: i=1; a=rsa-sha256; t=1520612513; cv=none;
        d=google.com; s=arc-20160816;
        b=wX/2LazTujfZGOGbD2+uyFfHKt8X5TEuuO5lypCw8FPepKn3uy4wSfg2dgcLEa1s6g
         hxNfohHWrimBBPm/q8P3fTFi66jh4TtC6ZBLA/K5/+ZAxc8BiuDpPMC1JAkSmVgh3au8
         8kiuIy091pqWJ5EALFF8gM3sbAqOVXhl9Tl8HwweEbYuXV1xJmWgN+js7L0beG/EtGEe
         8h1bCIm9ROsx1VOTsn0TJn4kl9zt2O+u04lz5fSYBdWg9FGcMhRcCLWLjMA1g4N8jfRf
         gRlPOVB4P5mrjN3tqFBrIPH1V2PDWH5u7w/zND/MCksQW9MpDA6qkcwpS42Rd8to8OX0
         9/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:delivered-to:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=2xVbmy7S2QLBNeOx/6XnLifIgazOJD3/fyKLTFjHF98=;
        b=E45VpEJNc6CXJMEM9gU9oxnEDPYTURwAI5jeT/ZznWNx1WzFueYm2nLOwejvLdM+ht
         mQI9mzf79dEon3e2fyVfhukhF95tpNHsJc9Jq8moJbtc0o1UKZAAOx2Dxv99vX6tDa2R
         1k4U+HL/2CDosqSHKJ72oU+tlmBDQj/E9nI95Q0jDjH2Y7xFhGaJyVxuj4eYNR1Ne6W9
         1vwDXZcbVD9tD2LQ0gdb5ACJ2XiZIcqI84kemYuVLIwjjTDICGwiWjrCcnNWG1DoiY+s
         bs/5REEzglQKt+hg9OmU3cfJqdfx5vDRC7jlxj4pG3Ds5RA2n7QKNhvAIviEpSKSLOEE
         yVWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AmRzlxzi;
       spf=pass (google.com: domain of kernel-hardening-return-12330-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12330-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=AmRzlxzi;
       spf=pass (google.com: domain of kernel-hardening-return-12330-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12330-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
In-Reply-To: <1520602169.26370.1.camel@perches.com>
References: <1520601833-4952-1-git-send-email-andreaschristofo@gmail.com> <1520602169.26370.1.camel@perches.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 9 Mar 2018 07:42:02 -0800
Message-ID: <CAKxU2N8wULJyidq9BiU_87o7csS=HcKjAa7DCX7vuGRiLJdbcw@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9k: dfs: remove VLA usage
To: Joe Perches <joe@perches.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>, keescook@chromium.org,
	kernel-hardening@lists.openwall.com,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594466629940454496?=
X-GMAIL-MSGID: =?utf-8?q?1594477787383991903?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 9, 2018 at 5:29 AM, Joe Perches <joe@perches.com> wrote:
> On Fri, 2018-03-09 at 15:23 +0200, Andreas Christoforou wrote:
>> The kernel would like to have all stack VLA usage removed.
>> This is the correct patch.
> []
>> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c b/drivers/net/wireless/ath/ath9k/dfs.c
> []
>> @@ -101,7 +101,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
>>                                int datalen, bool is_ctl, bool is_ext)
>>  {
>>       int i;
>> -     int max_bin[FFT_NUM_SAMPLES];
>> +     int max_bin[NUM_DIFFS + 1];
>>       struct ath_hw *ah = sc->sc_ah;
>>       struct ath_common *common = ath9k_hw_common(ah);
>>       int prev_delta;
>
> why not just change FFT_NUM_SAMPLES to a #define
> or get rid if FFT_NUM_SAMPLES altogether?
>
I did the former yesterday. Never submitted.
> $ git grep -w FFT_NUM_SAMPLES
> drivers/net/wireless/ath/ath9k/dfs.c:static const int FFT_NUM_SAMPLES   = (NUM_DIFFS + 1);
> drivers/net/wireless/ath/ath9k/dfs.c:   int max_bin[FFT_NUM_SAMPLES];
> drivers/net/wireless/ath/ath9k/dfs.c:           if (num_fft_packets < (FFT_NUM_SAMPLES)) {
> drivers/net/wireless/ath/ath9k/dfs.c:           for (i = 0; i < FFT_NUM_SAMPLES; i++)
> drivers/net/wireless/ath/ath9k/dfs.c:           if (num_fft_packets < (FFT_NUM_SAMPLES)) {
> drivers/net/wireless/ath/ath9k/dfs.c:           for (i = 0; i < FFT_NUM_SAMPLES; i++)
