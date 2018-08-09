Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C283CC46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BF521D06
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 11:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75BF521D06
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730878AbeHINno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 09:43:44 -0400
Received: from www381.your-server.de ([78.46.137.84]:53618 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeHINno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 09:43:44 -0400
Received: from [78.46.172.2] (helo=sslproxy05.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1fniyG-0003jm-96; Thu, 09 Aug 2018 13:19:12 +0200
Received: from [2003:93:4e47:0:8200:bff:fe9b:6612]
        by sslproxy05.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <lars@metafoo.de>)
        id 1fniyG-000SVI-2r; Thu, 09 Aug 2018 13:19:12 +0200
Subject: Re: [alsa-devel] [PATCH] ASoC: adau1761: Mark expected switch
 fall-though
To:     Mark Brown <broonie@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
References: <20180808192213.GA27872@embeddedor.com>
 <20180809093100.GC6132@sirena.org.uk>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <4934d9ae-96df-288b-2a7c-76aaa89246fe@metafoo.de>
Date:   Thu, 9 Aug 2018 13:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180809093100.GC6132@sirena.org.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.100.1/24826/Thu Aug  9 10:45:05 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/2018 11:31 AM, Mark Brown wrote:
> On Wed, Aug 08, 2018 at 02:22:13PM -0500, Gustavo A. R. Silva wrote:
> 
>> @@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
>>  			ARRAY_SIZE(adau1761_jack_detect_controls));
>>  		if (ret)
>>  			return ret;
>> -	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
>> +		/* fall through */
>> +	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
>>  		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
>>  			ARRAY_SIZE(adau1761_no_dmic_routes));
>>  		if (ret)
> 
> Again, are you *sure* here?

Well, it says so in the comment next to it :)

Acked-by: Lars-Peter Clausen <lars@metafoo.de>
