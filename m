Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753350AbeCFJ0q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 04:26:46 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:52490 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753305AbeCFJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 04:26:41 -0500
X-Google-Smtp-Source: AG47ELvS2txYxF1y/X0Y4yRT9mJ/cmBAWwJOlUnLG5FH/kLHmw9eQCT6HMTbh7SmYYl+EZYT1wxngA==
Subject: Re: [PATCH v3 10/25] ASoC: qcom: q6asm: Add support to memory map and
 unmap
To: Mark Brown <broonie@kernel.org>
Cc: andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com,
        plai@codeaurora.org, bgoswami@codeaurora.org, perex@perex.cz,
        tiwai@suse.com, linux-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        rohkumar@qti.qualcomm.com, spatakok@qti.qualcomm.com
References: <20180213165837.1620-1-srinivas.kandagatla@linaro.org>
 <20180213165837.1620-11-srinivas.kandagatla@linaro.org>
 <20180301212844.GU12864@sirena.org.uk>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <58bce0b7-f7bc-59d7-bf75-503d95e13671@linaro.org>
Date: Tue, 6 Mar 2018 09:26:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180301212844.GU12864@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review,

On 01/03/18 21:28, Mark Brown wrote:
> On Tue, Feb 13, 2018 at 04:58:22PM +0000, srinivas.kandagatla@linaro.org wrote:
> 
>> +	num_regions = is_contiguous ? 1 : periods;
>> +	buf_sz = is_contiguous ? (period_sz * periods) : period_sz;
> 
> Please write normal if statements, it's much easier to read.
> 

Sure, will fix it in next version.
>> +	buf_sz = PAGE_ALIGN(buf_sz);
> 
> I don't understand what this is doing, buf_sz is a length not an address
> so why are we attempting to align it?

Yes, this is a requirement form the DSP side that the size is multiple 
of 4KB. I will fix this properly in next version.

thanks,
srini
> 
