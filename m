Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeEHKkC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 06:40:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59070 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbeEHKj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 06:39:58 -0400
Subject: Re: [PATCH][media-next] media: ddbridge: avoid out-of-bounds write on
 array demod_in_use
To: Daniel Scheller <d.scheller.oss@gmail.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180507230842.28409-1-colin.king@canonical.com>
 <20180508123836.0b5c2f7f@lt530>
From: Colin Ian King <colin.king@canonical.com>
Openpgp: preference=signencrypt
Autocrypt: addr=colin.king@canonical.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c7ea26b7-d743-f2bd-fd0d-41421ae2778d@canonical.com>
Date: Tue, 8 May 2018 11:39:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508123836.0b5c2f7f@lt530>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/18 11:38, Daniel Scheller wrote:
> Hi Colin,
> 
> Am Tue,  8 May 2018 00:08:42 +0100
> schrieb Colin King <colin.king@canonical.com>:
> 
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> In function stop there is a check to see if state->demod is a stopped
>> value of 0xff, however, later on, array demod_in_use is indexed with
>> this value causing an out-of-bounds write error.  Avoid this by only
>> writing to array demod_in_use if state->demod is not set to the stopped
>> sentinal value for this specific corner case.  Also, replace the magic
>> value 0xff with DEMOD_STOPPED to make code more readable.
>>
>> Detected by CoverityScan, CID#1468550 ("Out-of-bounds write")
>>
>> Fixes: daeeb1319e6f ("media: ddbridge: initial support for MCI-based MaxSX8 cards")
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>
>> ---
>>  drivers/media/pci/ddbridge/ddbridge-mci.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/media/pci/ddbridge/ddbridge-mci.c b/drivers/media/pci/ddbridge/ddbridge-mci.c
>> index a85ff3e6b919..1f5ed53c8d35 100644
>> --- a/drivers/media/pci/ddbridge/ddbridge-mci.c
>> +++ b/drivers/media/pci/ddbridge/ddbridge-mci.c
>> @@ -20,6 +20,8 @@
>>  #include "ddbridge-io.h"
>>  #include "ddbridge-mci.h"
>>  
>> +#define DEMOD_STOPPED	(0xff)
>> +
>>  static LIST_HEAD(mci_list);
>>  
>>  static const u32 MCLK = (1550000000 / 12);
>> @@ -193,7 +195,7 @@ static int stop(struct dvb_frontend *fe)
>>  	u32 input = state->tuner;
>>  
>>  	memset(&cmd, 0, sizeof(cmd));
>> -	if (state->demod != 0xff) {
>> +	if (state->demod != DEMOD_STOPPED) {
>>  		cmd.command = MCI_CMD_STOP;
>>  		cmd.demod = state->demod;
>>  		mci_cmd(state, &cmd, NULL);
>> @@ -209,10 +211,11 @@ static int stop(struct dvb_frontend *fe)
>>  	state->base->tuner_use_count[input]--;
>>  	if (!state->base->tuner_use_count[input])
>>  		mci_set_tuner(fe, input, 0);
>> -	state->base->demod_in_use[state->demod] = 0;
>> +	if (state->demod != DEMOD_STOPPED)
>> +		state->base->demod_in_use[state->demod] = 0;
>>  	state->base->used_ldpc_bitrate[state->nr] = 0;
>> -	state->demod = 0xff;
>> -	state->base->assigned_demod[state->nr] = 0xff;
>> +	state->demod = DEMOD_STOPPED;
>> +	state->base->assigned_demod[state->nr] = DEMOD_STOPPED;
>>  	state->base->iq_mode = 0;
>>  	mutex_unlock(&state->base->tuner_lock);
>>  	state->started = 0;
> 
> Thanks for the patch, or - better - pointing this out. While it's
> unlikely this will ever be an issue, I'm fine with changing the code
> like that, but I'd prefer to change it a bit differently (ie.
> DEMOD_STOPPED should be DEMOD_UNUSED, and I'd add defines for max.
> tuners and use/compare against them).

Sounds like a good idea.

> 
> I'll send out a different patch that will cover the potential
> coverityscan problem throughout the end of the week.

Great. Thanks!

> 
> Best regards,
> Daniel Scheller
> 
