Return-Path: <kernel-hardening-return-12327-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvZ6WyW/vnp6uflRgc9RrZ+K5d3kTsOMGX2jTJftVkUmREAMF4zE9XAasUpnuy1y2E3gIK8
ARC-Seal: i=1; a=rsa-sha256; t=1520606944; cv=none;
        d=google.com; s=arc-20160816;
        b=nnbVXYVkVAgKSc3sGhzkCmGWiL3FEAjQ7J5czyiQX92eQ5CaG8WlcurYFXsPjYlJTm
         dMqoHpvQLVbjqJHpO5s3sMyUC56lIqBhxzvkTRkR43757edei8VaFbueuH9rTKjy2z5R
         KC/LC1uKSOCIp5457dQjnTEk6CqUOxSU37lkTmzNKPcwruh8O6d3e1qRjfKi1vxqxVPm
         S7vXuqgoKchGA+QyQ0wPuz35u/+vb58YA1bLfWDz03/Z2YWHw8aGeEgSNIHoirAzbqQO
         e9qnMtS5ipnufj6XdZtHQdNmZTCQkFYtYyVwCFzMLWmneWoCBEZ3c3kGItpPNhwIdbKt
         vD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:dmarc-filter:dkim-signature:dkim-signature
         :delivered-to:list-id:list-subscribe:list-unsubscribe:list-help
         :list-post:precedence:mailing-list:arc-authentication-results;
        bh=0EyKHaJqIbvN3c7t276CVODCXJ8yfR3M8hSCWafcV94=;
        b=znKoowleewq9RdsgoEPg4Kubu6c5X55oUuvZ+X7UTxvsIQW7nkhQyiRQHJSFbhtDVK
         Mh2XWCdSwCS5KbXROJjhfRRcVLhBC7ZbScqJD0q5gytCZcbxcTd2unzaRXDiBs2FrjX5
         /PpXkwBFNPoxLwl1cj6+16rN9Jv1krHgTd2DhjDQtWtIYslHnE80CrLTNIcn3o4kGYm8
         SP6OWLPnMZVXm88ceZrtEsC/MANH1CXPHrUgSiNKDWjJ13xsXABDmA/cjPxMFXWeDOrm
         0yWnFohKFUin3k2ICkmo096yx1Um3FxnkWbPuCgd5QAKPywh3N1LU6tSOKWLudIIO4aD
         UExQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TQJkIfRj;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TQJkIfRj;
       spf=pass (google.com: domain of kernel-hardening-return-12327-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12327-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TQJkIfRj;
       dkim=pass header.i=@codeaurora.org header.s=default header.b=TQJkIfRj;
       spf=pass (google.com: domain of kernel-hardening-return-12327-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12327-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5FB276053B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From: Kalle Valo <kvalo@codeaurora.org>
To: Himanshu Jha <morganfreeman6991@gmail.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,  keescook@chromium.org,  kernel-hardening@lists.openwall.com,  QCA ath9k Development <ath9k-devel@qca.qualcomm.com>,  linux-wireless@vger.kernel.org,  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com>
	<20180309125124.GA17968@himanshu-Vostro-3559>
Date: Fri, 09 Mar 2018 16:48:41 +0200
In-Reply-To: <20180309125124.GA17968@himanshu-Vostro-3559> (Himanshu Jha's
	message of "Fri, 9 Mar 2018 18:21:24 +0530")
Message-ID: <874llpe246.fsf@kamboji.qca.qualcomm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594471948247704481?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Himanshu Jha <morganfreeman6991@gmail.com> writes:

> On Fri, Mar 09, 2018 at 02:30:12PM +0200, Andreas Christoforou wrote:
>> The kernel would like to have all stack VLA usage removed.
>> 
>> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
>> ---
>>  drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>> 
>> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c
>> b/drivers/net/wireless/ath/ath9k/dfs.c
>> index 6fee9a4..cfb0f84 100644
>> --- a/drivers/net/wireless/ath/ath9k/dfs.c
>> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
>> @@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX		= 10;
>>  
>>  /* we need at least 3 deltas / 4 samples for a reliable chirp detection */
>>  #define NUM_DIFFS 3
>> -static const int FFT_NUM_SAMPLES	= (NUM_DIFFS + 1);
>
> Are you sure it is correct ?
> Look for other users of "FFT_NUM_SAMPLES".
>
>>  /* Threshold for difference of delta peaks */
>>  static const int MAX_DIFF		= 2;
>> @@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc, u8 *data,
>>  				 int datalen, bool is_ctl, bool is_ext)
>>  {
>>  	int i;
>> -	int max_bin[FFT_NUM_SAMPLES];
>> +	int max_bin[NUM_DIFFS + 1];
>>  	struct ath_hw *ah = sc->sc_ah;
>>  	struct ath_common *common = ath9k_hw_common(ah);
>>  	int prev_delta;
>
> Always compile test the driver before sending a patch.
> Also, patch title seems incorrect *ath9k*
>
> himanshu@himanshu-Vostro-3559:~/linux-next$ git log --oneline
> drivers/net/wireless/ath/ath9k/dfs.c
> 626ab67 ath9k: dfs: use swap macro in ath9k_check_chirping
> 50c8cd4 ath9k: remove cast to void pointer
> 8fc2b61 ath9k: DFS - add pulse chirp detection for FCC
> ....

Yeah, just "ath9k:" is enough as the prefix, no need to have full
directory path in the title.

-- 
Kalle Valo
