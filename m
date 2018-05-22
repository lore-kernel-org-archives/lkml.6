Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751528AbeEVMdD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 08:33:03 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:7730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751192AbeEVMdC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 08:33:02 -0400
Subject: Re: [PATCH 31/33] ASoC: max98088: use match_string() helper
To: Andy Shevchenko <andy.shevchenko@gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com>
 <1526903890-35761-32-git-send-email-xieyisheng1@huawei.com>
 <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        "ALSA Development Mailing List" <alsa-devel@alsa-project.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <92b32dee-7ba9-ad6d-573b-9924453a69fb@huawei.com>
Date: Tue, 22 May 2018 20:30:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf2ZTf0w=Kg_w7CJ-9XdGqipe3UVS=E=aeRDxGt3BHM3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On 2018/5/22 6:24, Andy Shevchenko wrote:
> On Mon, May 21, 2018 at 2:58 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>> match_string() returns the index of an array for a matching string,
>> which can be used intead of open coded variant.
> 
>>  static int max98088_get_channel(struct snd_soc_component *component, const char *name)
>>  {
> 
>> +       int ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
> I would rather split this and move an assignment to the line before 'if'

hmm, you mean something like:

	int ret;

	ret = match_string(eq_mode_name, ARRAY_SIZE(eq_mode_name), name);
	if (ret < 0) /* Shouldn't happen */
		dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
	return ret;
>>
>>         /* Shouldn't happen */
> 
>> +       if (ret < 0)
>> +               dev_err(component->dev, "Bad EQ channel name '%s'\n", name);
> 
>>         return -EINVAL;
> 
> return ret;
Right, sorry for this big mistake.

Thanks
Yisheng
> 
> ?
> 
>>  }
>>
>> --
>> 1.7.12.4
>>
> 
> 
> 
