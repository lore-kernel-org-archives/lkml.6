Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753970AbeBPTWT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 14:22:19 -0500
Received: from vern.gendns.com ([206.190.152.46]:37654 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932093AbeBPTWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 14:22:11 -0500
Subject: Re: [PATCH 1/6] nand: davinci: rename the platform driver
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Boris Brezillon <boris.brezillon@free-electrons.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
References: <20180216164712.25898-1-brgl@bgdev.pl>
 <20180216164712.25898-2-brgl@bgdev.pl> <20180216201923.16bfca7f@bbrezillon>
From: David Lechner <david@lechnology.com>
Message-ID: <93fd5120-28c6-96c7-4a0d-a4bd065f5ae6@lechnology.com>
Date: Fri, 16 Feb 2018 13:22:20 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180216201923.16bfca7f@bbrezillon>
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

On 02/16/2018 01:19 PM, Boris Brezillon wrote:
> On Fri, 16 Feb 2018 17:47:07 +0100
> Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> 
>> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>
>> Commit d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock
>> lookup table") broke the nand support in board file mode for
>> da850-based boards. Instead of reverting it and breaking the DT users
>> in the process (due to clock lookup), rename the driver to match the
>> clock table before renaming the users.
>>
>> Fixes: d8e22fb4ccac ("ARM: da850: add the nand dev_id to the clock lookup table")
>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>> ---
>>   drivers/mtd/nand/davinci_nand.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/mtd/nand/davinci_nand.c b/drivers/mtd/nand/davinci_nand.c
>> index ccc8c43abcff..4fb143bf1872 100644
>> --- a/drivers/mtd/nand/davinci_nand.c
>> +++ b/drivers/mtd/nand/davinci_nand.c
>> @@ -865,7 +865,7 @@ static struct platform_driver nand_davinci_driver = {
>>   	.probe		= nand_davinci_probe,
>>   	.remove		= nand_davinci_remove,
>>   	.driver		= {
>> -		.name	= "davinci_nand",
>> +		.name	= "davinci-nand",
> 
> Another side-effect of this change you should be aware of: by doing
> that you also break all users that were defining partitions through the
> cmdline using mtdparts=davinci_nand.0:<part-layout>.
> 
> Not sure this is a good idea ;-).

Also, once we move to the common clock framework, the AUXDATA that causes
the DT clock lookup breakage you are trying to avoid will go away, so that
won't be a reason for changing this either.
