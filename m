Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753363AbeCFJ1G (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:27:06 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54007 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753322AbeCFJ0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:26:44 -0500
X-Google-Smtp-Source: AG47ELs/Vo5z7eYcNjcBzFWp0CI0lxRt9XQy9dfBTuFeyl7BmhnDpVMTPNq2oTw1PdHlOIXqbGTUuQ==
Subject: Re: [PATCH v3 07/25] ASoC: qcom: qdsp6: Add support to Q6ADM
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-8-srinivas.kandagatla@linaro.org>
 <20180301212402.GT12864@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <bb87bd34-ab81-e297-3bd4-3e52f6859e34@linaro.org>
Date: Tue, 6 Mar 2018 09:26:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180301212402.GT12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 01/03/18 21:24, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:19PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +static struct copp *adm_find_copp(struct q6adm *adm, int port_idx,
>> +				  int copp_idx)
>> +{
>> +	struct copp *c;
>> +
>> +	spin_lock(&adm->copps_list_lock);
>> +	list_for_each_entry(c, &adm->copps_list, node) {
>> +		if ((port_idx == c->afe_port) && (copp_idx == c->copp_idx)) {
>> +			spin_unlock(&adm->copps_list_lock);
>> +			return c;
>> +		}
>> +	}
>> +
>> +	spin_unlock(&adm->copps_list_lock);
> 
> We've again got this use of spinlocks here but no IRQ safety - what
> exactly is going on with the locking?  In general all of the locking in
> this stuff is raising very serious alarm bells with me, I don't
> understand what is being protected against what and there's some very
> obvious bugs.  We could probably use some documentation about what the
> locking is supposed to be doing.
> 
I agree, there are locking issues here, Am revisiting them all before I 
send a next version.

>> +	case ADM_CMDRSP_DEVICE_OPEN_V5: {
> 
>> +		copp->id = open->copp_id;
>> +		wake_up(&copp->wait);
>> +	}
>> +	break;
>> +	default:
> 
> This indentation is confusing.
> 
I agree, will fix such instances in next version.

thanks,
srini
