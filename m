Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751262AbeEBBt7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 21:49:59 -0400
Received: from vern.gendns.com ([206.190.152.46]:52672 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751029AbeEBBt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 21:49:56 -0400
Subject: Re: [PATCH v9 03/27] clk: davinci: psc: allow for dev == NULL
To: Sekhar Nori <nsekhar@ti.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-4-david@lechnology.com>
 <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
From: David Lechner <david@lechnology.com>
Message-ID: <94d4cfc5-0ea7-e642-c7e3-8d549bdef8ce@lechnology.com>
Date: Tue, 1 May 2018 20:49:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 09:02 AM, Sekhar Nori wrote:
> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>> +static inline void *_devm_kzalloc(struct device *dev, size_t size, gfp_t flags)
>> +{
>> +	if (dev)
>> +		return devm_kzalloc(dev, size, flags);
>> +
>> +	return kzalloc(size, flags);
>> +}
> 
> I have the same question on the utility of this. A memory allocation
> error so early on is not going to result in a bootable system anyway.
> So, I wonder if its better to just BUG() in such cases. That will
> actually help faster debug than returning an error back. I know the push
> back on using BUG(), but clock drivers are special, and I think thats
> why its seems to be used quite a bit already.
> 

Same reply here as well. On DA850/DA830, you might not get a console,
but you will "boot" even if one of the PSC devices fails though.

WARN() is probably just as good as BUG() in this case too.
