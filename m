Return-Path: <andresx7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524252820; cv=none;
        d=google.com; s=arc-20160816;
        b=QLORBgBVijedbBc2uUke+lMRliYtgcMisZpUhrhDjYrZtlhFJ7fpOxF05upzbZ4sP9
         xiTZ2YZ0OUdGowKCOsxVj9TjNMkBY0Sju2dUnVwmB1AopSfarvY+BteWM7RE63dDDhce
         6oaxMsMwvIMm8jKlz5oKY9oqvd2vu4AASp4RTnism13pMBhRgu+eP+h91NiACtfp0iyh
         8rZvvPYO7fWXhTy7lVhwQJfnYMUUrADPRo8/MO1o1b6BdBt58nRmqIbyK5Kk+rJN+2be
         cKUFZ/MYaEVsrOwzCHONXo1E5LR1zszPlpi+nqzpj7JNvOs7SPR6UlBWu7G4ZzbDUlB0
         v0gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:cc
         :dkim-signature:arc-authentication-results;
        bh=yaE+FLzWnxmIi8drVljdb4QTdBhdovCD+jrG3dfSCKc=;
        b=MwqoAdhNYZWrCC2vnefysr2FQTunw+/LFGMDAPme7TlRKQyH0lvlDBg/uCnjtvlrsK
         unjMrYWaFTMDnix8WD13jtUsGpglxPCZhR6GyiopUoKUokqpBpKP0jG4NV5QDoX1sRag
         jgss0UfxeRlCiUvRbdpawZjKrhLpxBa8Qaa+pL8sLQl9Qy44GbM8QqOUKeBYG0cUEHx6
         0qHf5eQI1myzw4c600kGIiv/TgEqEtJd1zqJo5LIPed3CUlRg5OA6xYUEcN6VNubFRzG
         rHruVjOrvx8IebR2jybfVnnwbzaRsEpyIwBA152vBOcdjTQW6tXtv6BxllNfySCYVi2M
         CpLw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U2KWjDXE;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=U2KWjDXE;
       spf=pass (google.com: domain of andresx7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andresx7@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpqyhEOzH9Zama5bt4na/GLF4jovCaEuVzpbJYDhl2C0t7FW/3jqqm5NYjB2jJWAtn+02ArtA==
Cc: andresx7@gmail.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org, mcgrof@kernel.org, alexdeucher@gmail.com,
 ckoenig.leichtzumerken@gmail.com, arend.vanspriel@broadcom.com,
 linux-wireless@vger.kernel.org
Subject: Re: [PATCH 9/9] brcmfmac: use request_firmware_nowait2 to load
 firmware without warnings
To: Kalle Valo <kvalo@codeaurora.org>
References: <20180417153307.3693-1-andresx7@gmail.com>
 <20180417153307.3693-10-andresx7@gmail.com>
 <87h8o6i36l.fsf@kamboji.qca.qualcomm.com>
From: Andres Rodriguez <andresx7@gmail.com>
Message-ID: <65954790-8579-66ee-9b67-d44e18b4abb3@gmail.com>
Date: Fri, 20 Apr 2018 15:33:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87h8o6i36l.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598008020626065507?=
X-GMAIL-MSGID: =?utf-8?q?1598294925189296746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018-04-20 06:26 AM, Kalle Valo wrote:
> Andres Rodriguez <andresx7@gmail.com> writes:
> 
>> This reduces the unnecessary spew when trying to load optional firmware:
>> "Direct firmware load for ... failed with error -2"
>>
>> Signed-off-by: Andres Rodriguez <andresx7@gmail.com>
>> ---
>>   drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> With wireless patches always CC linux-wireless list, please. Adding it
> now.
> 
>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> index 091b52979e03..26db3ebd52dc 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/firmware.c
>> @@ -503,8 +503,9 @@ static void brcmf_fw_request_code_done(const struct firmware *fw, void *ctx)
>>   		goto done;
>>   
>>   	fwctx->code = fw;
>> -	ret = request_firmware_nowait(THIS_MODULE, true, fwctx->nvram_name,
>> -				      fwctx->dev, GFP_KERNEL, fwctx,
>> +	ret = request_firmware_nowait(THIS_MODULE, true, false,
> 
> A perfect example why enums should be in function calls instead of
> booleans, that "true, false" tells nothing to me and it would be time
> consuming to check from headers files what it means. If you had proper
> enums, for example "FIRMWARE_MODE_FOO, FIRMWARE_STATE_BAR", it would be
> immediately obvious for the reader what the parameters are. Of course
> the first boolean was already there before, but maybe change the new
> boolean to an enum >

Anyone else got any feedback before I re-spin the _nowait() API. I'm on 
board for the boolean->enum change.


>> +				      fwctx->nvram_name, fwctx->dev,
>> +				      GFP_KERNEL, fwctx,
>>   				      brcmf_fw_request_nvram_done);
>>   
>>   	/* pass NULL to nvram callback for bcm47xx fallback */
>> @@ -547,7 +548,7 @@ int brcmf_fw_get_firmwares_pcie(struct device *dev, u16 flags,
>>   	fwctx->domain_nr = domain_nr;
>>   	fwctx->bus_nr = bus_nr;
>>   
>> -	return request_firmware_nowait(THIS_MODULE, true, code, dev,
>> +	return request_firmware_nowait2(THIS_MODULE, true, false, code, dev,
>>   				       GFP_KERNEL, fwctx,
>>   				       brcmf_fw_request_code_done);
>>   }
> 
> Also the number two in the function name is not really telling anything.
> I think that something like request_firmware_nowait_nowarn() would be
> better, even if it's so ugly.
> 

The 2 is meant to signify that this is an new version of the api with 
different parameters. I don't think we need to codify into the name what 
the new parameters mean (mostly because when a 2 version of an api is 
implemented, usage of the original version tends to be discouraged).

If we go for something like _nowait_nowarn(), then we would need to drop 
the warn parameter altogether.

Another alternative, drop both bool warn and bool uevent and expose take 
in enum fw_opt directly.

Any thought on exposing the enum directly Luis for _nowait(). I know you 
mentioned this was for some reason decided against for the rest of the API.

Regards,
Andres
