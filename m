Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521512516; cv=none;
        d=google.com; s=arc-20160816;
        b=SyY/PcKKDOaR5x76+qhPFt88eItGGYEs+I8TUwDmz7cPTZRmQorDCqS/9nL0dBU91Y
         2nqTRqQvHDf85EiJyaUOnHwT/jE+ClqZILq0/O7+O7L57XAQEJUZg2irz43UBcxE2w6V
         FW6KaUPm8OSb676QRNbLswUi13DLuLkRdBUAzPUhx4x7T4pwGxeptn/KptVgdlcW8zlI
         PpyuAelr+LfcUE36UjXhzKEisASFm9V1wU1krqGphzbW8x9bhKzmGUMmiV7HwTaM4QKr
         5DkJ067QO9sEGAvji/X1nuiGsau4IVYNYnsD2AznBFI2uxSZj7UgP5GyfOdJwn0H3mh+
         TU0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:cc
         :dkim-signature:arc-authentication-results;
        bh=Gu8qwfI1bs/rZE4x7rcz6YH/m1s3rwM/l4VkQOde37M=;
        b=zui2Cpwj0z0OgdibQyaNrE/XPW0dHfuiiPyASySbLohBZDt1BQZe4ButDtOFlUzpwV
         uuGCWLcwdsmmjPnNXGp54VasMeaFq2/Ray76E7vuUT2DeZGKDLDr4ttDeBKU+B2cm4Ha
         c4hBIUcqvnb5kQaVCU8aamHyH6Nt3L8miUXTPHol/OHAhE3cQcUhM1fwQ477wUa1yObf
         tpaGZPQPcezz8VnTJCEHr1K1gTSp8vj8N0Xn4DGXUOB9EFvPC4rCfqzb/st0n3WC1Cvx
         9t9MQIY3mZ1TtUFjXFtnZf9+glzV81kWG3iTpkqdBk1CGvE99Eqa+jZb/zBESvYj50Q7
         w8hg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a88gnUA0;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a88gnUA0;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELssdOWXaHwT0rsvOa1TZsBmmAkqauMCxsdidDZy9MqVC4yFvOpe+h0gEdprMJsM88BcKOJVUA==
Cc: andresx7@gmail.com, Arend van Spriel <arend.vanspriel@broadcom.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-wireless <linux-wireless@vger.kernel.org>,
 Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: [PATCH] firmware: add a function to load optional firmware v2
To: "Luis R. Rodriguez" <mcgrof@kernel.org>, Kalle Valo <kvalo@codeaurora.org>
References: <20180309221243.15489-2-andresx7@gmail.com>
 <20180309230925.3573-1-andresx7@gmail.com>
 <CAB=NE6VY62KqmhzD=zT8od=PhgPi3rGKKKxKz_zad-ZrYW-97A@mail.gmail.com>
 <CAB=NE6XpY4LuDwnakCa6gZ_HjjhZDnu=gDeHwmpNRaSkqQOB2g@mail.gmail.com>
 <bbdc304f-edd5-38df-ea88-012fefc54b90@gmail.com>
 <5AA5B777.5020106@broadcom.com> <20180312192704.GX4449@wotan.suse.de>
 <87r2oo9jsk.fsf@kamboji.qca.qualcomm.com>
 <20180313163842.GF4449@wotan.suse.de>
From: Andres Rodriguez <andresx7@gmail.com>
Message-ID: <cd73c8d1-ab2e-9dec-f48e-142d71ff1308@gmail.com>
Date: Mon, 19 Mar 2018 22:21:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180313163842.GF4449@wotan.suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594503439621024078?=
X-GMAIL-MSGID: =?utf-8?q?1595421508821072831?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-03-13 12:38 PM, Luis R. Rodriguez wrote:
> On Tue, Mar 13, 2018 at 03:39:23PM +0200, Kalle Valo wrote:
>> "Luis R. Rodriguez" <mcgrof@kernel.org> writes:
>>
>>> On Mon, Mar 12, 2018 at 12:10:47AM +0100, Arend van Spriel wrote:
>>>> On 3/11/2018 5:05 PM, Andres Rodriguez wrote:
>>>>>> Your patch series then should also have the driver callers who you
>>>>>> want to modify to use this new API. Collect from the 802.11 folks the
>>>>>> other drivers which I think they wanted changed as well.
>>>>>
>>>>> Arend, Kalle, would love to hear your feedback.
>>>>
>>>> I am not sure if it was ath10k, but Kalle will surely know. The other driver
>>>> firing a whole batch of firmware requests is iwlwifi. These basically try to
>>>> get latest firmware version and if not there try an older one.
>>>
>>> Ah I recall now. At least for iwlwifi its that it requests firmware with a
>>> range of api files, and we don't need information about files in the middle
>>> not found, given all we need to know if is if at lest one file was found
>>> or not.
>>>
>>> I have future code to also enable use of a range request which would replace
>>> the recursive nature of iwlwifi's firmware API request, so it simplifies it
>>> considerably.
>>>
>>> Once we get this flag to be silent in, this can be used later. Ie, the new
>>> API I'd add would replace the complex api revision thing for an internal set.
>>
>> TBH I doubt we would use this kind of "range" request in ath10k,
> 
> Well it doesn't have the form to use a range either so it wouldn't make sense.
> 
>> the
>> current code works just fine only if we can get rid of the annoying
>> warning from request_firmware(). Unless if it's significantly faster or
>> something.
> 
> Thanks, I see ath10k uses the sync request_firmware() call, so indeed it
> would be a trivial conversion.
> 
> Andres can you roll that in for your patch series?
> 

Can do, although it will take a while. Kidney stone woes and other life 
things are keeping me busy for the following weeks.

Sorry for the delay.

Kind Regards,
Andres

>    Luis
> 
