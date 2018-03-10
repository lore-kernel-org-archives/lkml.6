Return-Path: <kernel-hardening-return-12389-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELvHT5Fr/nUcJckGnoAax66aL+X3wwVlvjil8hXfRHXcN8zGxhD6znIW3aJ7IwsXRIE4Hrod
ARC-Seal: i=1; a=rsa-sha256; t=1520723580; cv=none;
        d=google.com; s=arc-20160816;
        b=DTf8mUJ0nbX8Bk2HVxGlg0ewTMziL/EkztESrQcP65+lGSM/8Wo3b9fhC9NY1F4K5+
         wbfFt268xH+u8JG7tbJe6EuggWezSk4Fo6Qf6AAhtnl6ObDRJb8GUxjxIWCWfxubCJHB
         05RzS2coUe3Ud1ps9RqY4MEBckDVabesUAL6R731Rb7euhIsAJOwlPmP/Bk3l+/A+QrB
         5+1tlERjHNw7HUM7ymDJyujIn/CuGmItrXTcfKPXp4PcmtxATJLIc7gomIO7XkbFykny
         C7Lz6aoIsp2YT/xNmk3YFGgjdCSjMNPn7M7RBgV7WdMQwn/Vnsu+wH50KwZtDqESS4/N
         ShZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:dkim-signature:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=brPXyLVV865NUR34/T+PtQOHdWfl7OUcJN20tmRgXz8=;
        b=PXOnlanJV+1TOrAQi8BD/m0c/KJ51CfHug36940jlqyxTSTThZudRL17ga8v6YFKH5
         JVGMwpizUBIhWRZBJeYaKI8XlAUOrOd1MV2Yhd8mbv4wuRUH7cA3opcIQVObh45nHRpv
         LXJw+c7UwBiD8EJGL5aiPXCSy/9nBRyq4iAKlDZRCozWjN8UY6NWVIkS2iYXoTU+XDBl
         O15M3sJYvH2wZhKv6DEwpg8/d1/ZbIup3usoyr8wkgtoO/JUib59dx5A6JPjqFubIm7C
         16fO2ukL5VkUc0lb4cFlzKdnyIGfArTHdfVRWPZMB7LFIwRzvFeD39QjkYNYZjPncETY
         a9FQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NUN4RGbb;
       dkim=pass header.i=@chromium.org header.s=google header.b=XN+m1Ibh;
       spf=pass (google.com: domain of kernel-hardening-return-12389-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12389-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=NUN4RGbb;
       dkim=pass header.i=@chromium.org header.s=google header.b=XN+m1Ibh;
       spf=pass (google.com: domain of kernel-hardening-return-12389-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12389-gregkh=linuxfoundation.org@lists.openwall.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=chromium.org
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
MIME-Version: 1.0
Sender: keescook@google.com
In-Reply-To: <5AA464DE.90100@broadcom.com>
References: <1520598613-3641-1-git-send-email-andreaschristofo@gmail.com> <5AA464DE.90100@broadcom.com>
From: Kees Cook <keescook@chromium.org>
Date: Sat, 10 Mar 2018 15:12:40 -0800
X-Google-Sender-Auth: PWrOqVjT1Oxi5WIpUTGq-C4elkc
Message-ID: <CAGXu5jKDA=L5E6Cu_oRe-M=ouuhrccCZHyM+z6_UMAUqe9xnRQ@mail.gmail.com>
Subject: Re: [PATCH] drivers: net: wireless: ath: ath9: dfs: remove VLA usage
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Andreas Christoforou <andreaschristofo@gmail.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	QCA ath9k Development <ath9k-devel@qca.qualcomm.com>, Kalle Valo <kvalo@codeaurora.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Network Development <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594463764603415966?=
X-GMAIL-MSGID: =?utf-8?q?1594594249103869153?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 3:06 PM, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
> On 3/9/2018 1:30 PM, Andreas Christoforou wrote:
>>
>> The kernel would like to have all stack VLA usage removed.
>
>
> I think there was a remark made earlier to give more explanation here. It
> should explain why we want "VLA on stack" removed.
>
>> Signed-off-by: Andreas Christoforou <andreaschristofo@gmail.com>
>> ---
>>   drivers/net/wireless/ath/ath9k/dfs.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath9k/dfs.c
>> b/drivers/net/wireless/ath/ath9k/dfs.c
>> index 6fee9a4..cfb0f84 100644
>> --- a/drivers/net/wireless/ath/ath9k/dfs.c
>> +++ b/drivers/net/wireless/ath/ath9k/dfs.c
>> @@ -41,7 +41,6 @@ static const int BIN_DELTA_MAX                = 10;
>>
>>   /* we need at least 3 deltas / 4 samples for a reliable chirp detection
>> */
>>   #define NUM_DIFFS 3
>> -static const int FFT_NUM_SAMPLES       = (NUM_DIFFS + 1);
>>
>>   /* Threshold for difference of delta peaks */
>>   static const int MAX_DIFF             = 2;
>> @@ -101,7 +100,7 @@ static bool ath9k_check_chirping(struct ath_softc *sc,
>> u8 *data,
>>                                  int datalen, bool is_ctl, bool is_ext)
>>   {
>>         int i;
>> -       int max_bin[FFT_NUM_SAMPLES];
>> +       int max_bin[NUM_DIFFS + 1];
>
>
> Just wondering. Is this actually a VLA. FFT_NUM_SAMPLES was static const so
> not really going to show a lot of variation. This array will always have the
> same size on the stack.

The problem is that it's not a "constant expression", so the compiler
frontend still yells about it under -Wvla. I would characterize this
mainly as a fix for "accidental VLA" or "misdetected VLA" or something
like that. AIUI, there really isn't a functional change here.

-Kees

-- 
Kees Cook
Pixel Security
