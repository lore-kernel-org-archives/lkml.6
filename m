Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753308AbeCFJ0l (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:26:41 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34904 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753232AbeCFJ0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:26:37 -0500
X-Google-Smtp-Source: AG47ELvPUfd/jmkjMYSRyULqtjblqcjqRoP5N1WOF2Su6RRQyeqZ3KI6JtboQqgTQNbduvYv7+uM/w==
Subject: Re: [PATCH v3 11/25] ASoC: qcom: q6asm: add support to audio stream
 apis
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-12-srinivas.kandagatla@linaro.org>
 <20180301213356.GV12864@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <d76a271d-707c-3f5c-9327-d7f43da3cc92@linaro.org>
Date: Tue, 6 Mar 2018 09:26:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180301213356.GV12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review comments.

sorry for delay, for some reason these emails endup in my SPAM folder.

On 01/03/18 21:33, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:23PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>>   	uint32_t used;
>> @@ -131,7 +191,7 @@ static int q6asm_apr_send_session_pkt(struct q6asm *a, struct audio_client *ac,
>>   
>>   	rc = wait_event_timeout(a->mem_wait, (a->mem_state <= 0), 5 * HZ);
>>   	if (!rc) {
>> -		dev_err(a->dev, "CMD timeout \n");
>> +		dev_err(a->dev, "CMD timeout\n");
>>   		rc = -ETIMEDOUT;
>>   	} else if (a->mem_state < 0) {
>>   		rc =  q6dsp_errno(a->mem_state);
> 
> This should be folded into whatever patch is being fixed.
> 

My Bad, I will fix this in next version.

>> +	open.hdr.opcode = ASM_STREAM_CMD_OPEN_WRITE_V3;
>> +	open.mode_flags = 0x00;
>> +	open.mode_flags |= ASM_LEGACY_STREAM_SESSION;
> 
> What is a legacy stream and why are we using it in new code?

This is basically Ensures backward compatibility to the original 
behavior of ASM_STREAM_CMD_OPEN_WRITE_V2 command.

I will take a closer look and see if its possible to remove this in the 
first place.

thanks,
srini

> 
