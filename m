Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751160AbeCGHEe (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 02:04:34 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:57127 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750994AbeCGHEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 02:04:32 -0500
Subject: Re: [PATCH v6] mmc: Export host capabilities to debugfs.
To: Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "andriy.shevchenko@linux.intel.com"
        <andriy.shevchenko@linux.intel.com>
CC: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Vladimir_Zapolskiy@mentor.com" <Vladimir_Zapolskiy@mentor.com>
References: <1520401051-11135-1-git-send-email-harish_kandiga@mentor.com>
 <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
From: Harish Jenny K N <harish_kandiga@mentor.com>
Message-ID: <af726c5a-edd4-94f9-7789-4527e9aff93d@mentor.com>
Date: Wed, 7 Mar 2018 12:34:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM5PR04MB10857D9F0177C760047100D1FCD80@DM5PR04MB1085.namprd04.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 07 March 2018 12:10 PM, Avri Altman wrote:
>
>> -----Original Message-----
>> From: Harish Jenny K N [mailto:harish_kandiga@mentor.com]
>> Sent: Wednesday, March 07, 2018 7:38 AM
>> To: ulf.hansson@linaro.org; linus.walleij@linaro.org;
>> adrian.hunter@intel.com; shawn.lin@rock-chips.com; Avri Altman
>> <Avri.Altman@wdc.com>; andriy.shevchenko@linux.intel.com
>> Cc: linux-mmc@vger.kernel.org; linux-kernel@vger.kernel.org;
>> harish_kandiga@mentor.com; Vladimir_Zapolskiy@mentor.com
>> Subject: [PATCH v6] mmc: Export host capabilities to debugfs.
>>
>> This patch exports the host capabilities to debugfs
>>
>> This idea of sharing host capabilities over debugfs came up from Abbas Raza
>> <Abbas_Raza@mentor.com> Earlier discussions:
>> https://lkml.org/lkml/2018/3/5/357
>> https://www.spinics.net/lists/linux-mmc/msg48219.html
>>
>> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>
>> ---
>>
>>
>> +static int mmc_caps_show(struct seq_file *s, void *unused) {
>> +	struct mmc_host *host = s->private;
>> +	u32 caps = host->caps;
>> +
>> +	seq_puts(s, "\nMMC Host capabilities are:\n");
>> +	seq_puts(s,
>> "=============================================\n");
>> +	seq_printf(s, "Can the host do 4 bit transfers :\t%s\n",
>> +		   ((caps & MMC_CAP_4_BIT_DATA) ? "Yes" : "No"));
> Maybe use a more compact form, and just call a macro with the applicable (stringified) bit?

Something like this ?

#define YN(bit) ((caps & bit) ? "Yes" : "No")
and then call
seq_printf(s, "Can the host do 4 bit transfers :\t%s\n", YN(MMC_CAP_4_BIT_DATA));



Thanks,
Harish Jenny K N
