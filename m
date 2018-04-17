Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQKpd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 06:45:33 -0400
Received: from www381.your-server.de ([78.46.137.84]:54655 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751270AbeDQKpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 06:45:31 -0400
Subject: Re: [PATCH 5/5] dmaengine: sprd: Add 'device_config' and
 'device_prep_slave_sg' interfaces
To: Baolin Wang <baolin.wang@linaro.org>, dan.j.williams@intel.com,
        vinod.koul@intel.com
Cc: eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5c951129-b167-3ed6-48f4-0a42cd2df28e@metafoo.de>
Date: Tue, 17 Apr 2018 12:45:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/10/2018 09:46 AM, Baolin Wang wrote:
[...]
> +static int sprd_dma_slave_config(struct dma_chan *chan,
> +				 struct dma_slave_config *config)
> +{
> +	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct sprd_dma_config *slave_cfg =
> +		container_of(config, struct sprd_dma_config, config);
> +

Please do not overload standard API with custom semantics. This makes the
driver incompatible to the API and negates the whole idea of having a common
API. E.g. this will crash when somebody passes a normal dma_slave_config
struct to this function.

> +	memcpy(&schan->slave_cfg, slave_cfg, sizeof(*slave_cfg));
> +	return 0;
> +}
