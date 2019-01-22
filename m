Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D33C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A1E20861
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 05:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="W9V6IdLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfAVF2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 00:28:05 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:26719 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbfAVF2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 00:28:04 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20190122052800epoutp03b6be32c1b5548688aa5dd0af9125f24e~8FHifx0-e1290612906epoutp03Q
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 05:28:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20190122052800epoutp03b6be32c1b5548688aa5dd0af9125f24e~8FHifx0-e1290612906epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548134880;
        bh=R3pUExYcaoBJ5sB51cnSP0dOi3eJsDIuQR52CY5g6GM=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=W9V6IdLHc9bK6a2l6J9ycueJGUhgBsLq4osQG5is8aLeap9YXaxhV9PcLW4CDV8JP
         GT9TTJorQ9AnbK3theddc0LCo0FGUT35Z/LmTbXCayG7rgIi4M4eUgSioNHcCP/Bb0
         a22Yhog2ZTKBfGO5LRN9Ds3X7vpqKVFfIQOnL+VQ=
Received: from epsmges1p3.samsung.com (unknown [182.195.40.158]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190122052757epcas1p34efd2a4d51b7cf5616f1c8a9efb074c6~8FHf_cHIx1483914839epcas1p3_;
        Tue, 22 Jan 2019 05:27:57 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.84.04069.8D9A64C5; Tue, 22 Jan 2019 14:27:52 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190122052752epcas1p276d141f6a9e691b7d5f8172fa1c3f1ba~8FHbHM1792171421714epcas1p2v;
        Tue, 22 Jan 2019 05:27:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190122052752epsmtrp1cd7404a17789821a7ee5463c423558ae~8FHbGYXo-3225932259epsmtrp1S;
        Tue, 22 Jan 2019 05:27:52 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-d9-5c46a9d8fe23
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        A6.B7.03971.8D9A64C5; Tue, 22 Jan 2019 14:27:52 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190122052752epsmtip268346af80e12ed7b163ce565760536ec~8FHa59XaN1365513655epsmtip2n;
        Tue, 22 Jan 2019 05:27:52 +0000 (GMT)
Subject: Re: [PATCH] drivers: extcon: Add support for ptn5150
To:     Vijai Kumar K <vijaikumar.kanagarajan@gmail.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        myungjoo.ham@samsung.com
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <a86ad49c-bcad-1b84-190b-6d0ee9e09c37@samsung.com>
Date:   Tue, 22 Jan 2019 14:27:51 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190122044216.GA23297@chikyu>
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuplk+LIzCtJLcpLzFFi42LZdlhTX/fGSrcYg+5POhbHrk9ktri8aw6b
        xe3GFWwWL/dPZ3Vg8bi/l91j56y77B59W1YxenzeJBfAEpVtk5GamJJapJCal5yfkpmXbqvk
        HRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0UUmhLDGnFCgUkFhcrKRvZ1OUX1qSqpCR
        X1xiq5RakJJTYFmgV5yYW1yal66XnJ9rZWhgYGQKVJiQnfFh1XbGguXRFV+aP7M2MDY4dzFy
        ckgImEgcWH2FpYuRi0NIYAejxN2mq2wgCSGBT4wSSw7lQyS+MUqsWf+SCaZjbucFNojEXkaJ
        aT/2MkE47xkluu99B8pwcAgL2Eq8f5UF0iAC1LCu5TgzSJhZwF9i9Rt5kDCbgJbE/hc3wJbx
        CyhKXP3xmBHE5hWwkzi99RRYOYuAqkTjNH6QsKhAhETH/dVsECWCEidnPmEBsTkFdCQ+Hv0B
        ZjMLiEvcejKfCcKWl2jeOpsZ5DIJgTNsEvO3r2KHuN9F4vz7x1C2sMSr41ugbCmJl/1tUHa1
        xMqTR9ggmjsYJbbsv8AKkTCW2L90MhPEL5oS63fpQyzjk3j3tYcVJCwhwCvR0SYEUa0scfnB
        XWiwSUosbu9kg7A9JI7+mM08gVFxFpJ3ZiF5YRaSF2YhLFvAyLKKUSy1oDg3PbXYsMAYOao3
        MYKTopb5DsYN53wOMQpwMCrx8HKcc40RYk0sK67MPcQowcGsJMIrOMctRog3JbGyKrUoP76o
        NCe1+BCjKTCwJzJLiSbnAxN2Xkm8oamRsbGxhYmhmamhoZI473oH5xghgfTEktTs1NSC1CKY
        PiYOTqkGxo43UrdWxUtUp0zb0yhh0jbRVJL70V2LORxmPnfeiR5KnqfWpBDxhnvRpl33npyM
        8nB/t+Q206IHAV9ZrmTdCf9rJH91jUbm55iaNHNWzm4hH43Mt7Mm+U52e1PzO0r+TmtP634t
        FnbzoLdyq54p6SakF75Nqbnt/HdWlUHbtDyti8fcs1P8lFiKMxINtZiLihMBMTjqHqADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBLMWRmVeSWpSXmKPExsWy7bCSvO6NlW4xBiuXcVocuz6R2eLyrjls
        FrcbV7BZvNw/ndWBxeP+XnaPnbPusnv0bVnF6PF5k1wASxSXTUpqTmZZapG+XQJXxodV2xkL
        lkdXfGn+zNrA2ODcxcjJISFgIjG38wJbFyMXh5DAbkaJQ3evM0MkJCWmXTwKZHMA2cIShw8X
        Q9S8ZZS4evUeK0hcWMBW4v2rLJByEaA561qOg7UyC/hKzJzziRXEFhL4zihx/g9YnE1AS2L/
        ixtsIDa/gKLE1R+PGUFsXgE7idNbT4GtYhFQlWicxg8SFhWIkDj7ch1UiaDEyZlPWEBsTgEd
        iY9Hf7BArFKX+DPvEtRacYlbT+YzQdjyEs1bZzNPYBSehaR9FpKWWUhaZiFpWcDIsopRMrWg
        ODc9t9iwwDAvtVyvODG3uDQvXS85P3cTIzg+tDR3MF5eEn+IUYCDUYmHl+Oca4wQa2JZcWXu
        IUYJDmYlEV7BOW4xQrwpiZVVqUX58UWlOanFhxilOViUxHmf5h2LFBJITyxJzU5NLUgtgsky
        cXBKNTAur0iWPXpuxyWFZzo8DQyn5HZsktpzds07tYO8EYV8OhI65z/NLDr7egLT9CbnRPXl
        0+uvV3wr/hIsX70gI/T9SYftxxuPuiTkuB7euv3iro0V9/qq4maWByxftSdeUJj1U4d9/E+X
        HXNtORkesi7fFSgf8iXN+MAy1crIOnbh0vkdji9qIz8qsRRnJBpqMRcVJwIAEfhT2YsCAAA=
X-CMS-MailID: 20190122052752epcas1p276d141f6a9e691b7d5f8172fa1c3f1ba
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20190122044312epcas1p1c504c01c0cdcead92203f3dccabc7406
References: <1548061749-15950-1-git-send-email-vijaikumar.kanagarajan@gmail.com>
        <201901220830.8kqj0YjW%fengguang.wu@intel.com>
        <CGME20190122044312epcas1p1c504c01c0cdcead92203f3dccabc7406@epcas1p1.samsung.com>
        <20190122044216.GA23297@chikyu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vijai,

On 19. 1. 22. 오후 1:42, Vijai Kumar K wrote:
> Hi Chanwoo Choi,
> 
> This is the first time I am sending a driver to LKML. I have a few doubts. Can
> you please clarify them when you are free?
> 
> 1. I have developed and tested this patch on 4.14.89 kernel. When trying to 
> mainline the driver should I rebase and send the patch on top of current tree(v5.0-rc2)?

You better to rebase your patch on extcon-next branch (v5.0-rc1).
because the extcon.git[1] keep the v5.0-rc1 version. But, if you use over v5.0-rc1 version,
it doesn't matter. Maybe, this patch doesn't get the any impact from the modification
of v5.0-rcX.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git

> 
> 2. Is there any specific git on which I should test this driver on? Like below?
> https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git

Yes.

> 
> Thanks,
> Vijai Kumar K
> 
> On Tue, Jan 22, 2019 at 08:05:33AM +0800, kbuild test robot wrote:
>> Hi Vijai,
>>
>> Thank you for the patch! Yet something to improve:
>>
>> [auto build test ERROR on chanwoo-extcon/extcon-next]
>> [also build test ERROR on v5.0-rc2]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>>
>> url:    https://github.com/0day-ci/linux/commits/Vijai-Kumar-K/drivers-extcon-Add-support-for-ptn5150/20190122-041153
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git extcon-next
>> config: sh-allyesconfig (attached as .config)
>> compiler: sh4-linux-gnu-gcc (Debian 8.2.0-11) 8.2.0
>> reproduce:
>>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>         chmod +x ~/bin/make.cross
>>         # save the attached .config to linux build tree
>>         GCC_VERSION=8.2.0 make.cross ARCH=sh 
>>
>> All error/warnings (new ones prefixed by >>):
>>
>>    drivers//extcon/extcon-ptn5150.c: In function 'ptn5150_irq_work':
>>>> drivers//extcon/extcon-ptn5150.c:93:5: error: implicit declaration of function 'extcon_set_state_sync'; did you mean 'extcon_get_state'? [-Werror=implicit-function-declaration]
>>         extcon_set_state_sync(info->edev,
>>         ^~~~~~~~~~~~~~~~~~~~~
>>         extcon_get_state
>>    drivers//extcon/extcon-ptn5150.c: In function 'ptn5150_i2c_probe':
>>>> drivers//extcon/extcon-ptn5150.c:255:15: error: implicit declaration of function 'devm_extcon_dev_allocate'; did you mean 'extcon_get_state'? [-Werror=implicit-function-declaration]
>>      info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
>>                   ^~~~~~~~~~~~~~~~~~~~~~~~
>>                   extcon_get_state
>>>> drivers//extcon/extcon-ptn5150.c:255:13: warning: assignment to 'struct extcon_dev *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>>      info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
>>                 ^
>>>> drivers//extcon/extcon-ptn5150.c:262:8: error: implicit declaration of function 'devm_extcon_dev_register'; did you mean 'devm_pinctrl_register'? [-Werror=implicit-function-declaration]
>>      ret = devm_extcon_dev_register(info->dev, info->edev);
>>            ^~~~~~~~~~~~~~~~~~~~~~~~
>>            devm_pinctrl_register
>>    cc1: some warnings being treated as errors
>>
>> vim +93 drivers//extcon/extcon-ptn5150.c
>>
>>     51	
>>     52	static void ptn5150_irq_work(struct work_struct *work)
>>     53	{
>>     54		struct ptn5150_info *info = container_of(work,
>>     55				struct ptn5150_info, irq_work);
>>     56		int ret = 0;
>>     57		unsigned int reg_data;
>>     58		unsigned int port_status;
>>     59		unsigned int vbus;
>>     60		unsigned int cable_attach;
>>     61		unsigned int int_status;
>>     62	
>>     63		if (!info->edev)
>>     64			return;
>>     65	
>>     66		mutex_lock(&info->mutex);
>>     67	
>>     68		ret = regmap_read(info->regmap, PTN5150_REG_CC_STATUS, &reg_data);
>>     69		if (ret) {
>>     70			dev_err(info->dev,
>>     71				"failed to read CC STATUS %d\n", ret);
>>     72			mutex_unlock(&info->mutex);
>>     73			return;
>>     74		}
>>     75		/* Clear interrupt. Read would clear the register */
>>     76		ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &int_status);
>>     77		if (ret) {
>>     78			dev_err(info->dev,
>>     79				"failed to read INT STATUS %d\n", ret);
>>     80			mutex_unlock(&info->mutex);
>>     81			return;
>>     82		}
>>     83	
>>     84		if (int_status) {
>>     85			cable_attach = int_status & PTN5150_REG_INT_CABLE_ATTACH_MASK;
>>     86			if (cable_attach) {
>>     87				port_status = ((reg_data &
>>     88						PTN5150_REG_CC_PORT_ATTACHMENT_MASK) >>
>>     89						PTN5150_REG_CC_PORT_ATTACHMENT_SHIFT);
>>     90	
>>     91				switch (port_status) {
>>     92				case PTN5150_DFP_ATTACHED:
>>   > 93					extcon_set_state_sync(info->edev,
>>     94							      EXTCON_USB_HOST, false);
>>     95					gpiod_set_value(info->vbus_gpiod, 0);
>>     96					extcon_set_state_sync(info->edev, EXTCON_USB,
>>     97							      true);
>>     98					break;
>>     99				case PTN5150_UFP_ATTACHED:
>>    100					extcon_set_state_sync(info->edev, EXTCON_USB,
>>    101							      false);
>>    102					vbus = ((reg_data &
>>    103						PTN5150_REG_CC_VBUS_DETECTION_MASK) >>
>>    104						PTN5150_REG_CC_VBUS_DETECTION_SHIFT);
>>    105					if (vbus)
>>    106						gpiod_set_value(info->vbus_gpiod, 0);
>>    107					else
>>    108						gpiod_set_value(info->vbus_gpiod, 1);
>>    109	
>>    110					extcon_set_state_sync(info->edev,
>>    111							      EXTCON_USB_HOST, true);
>>    112					break;
>>    113				default:
>>    114					dev_err(info->dev,
>>    115						"Unknown Port status : %x\n",
>>    116						port_status);
>>    117					break;
>>    118				}
>>    119			} else {
>>    120				extcon_set_state_sync(info->edev,
>>    121						      EXTCON_USB_HOST, false);
>>    122				extcon_set_state_sync(info->edev,
>>    123						      EXTCON_USB, false);
>>    124				gpiod_set_value(info->vbus_gpiod, 0);
>>    125			}
>>    126		}
>>    127	
>>    128		/* Clear interrupt. Read would clear the register */
>>    129		ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS,
>>    130					&int_status);
>>    131		if (ret) {
>>    132			dev_err(info->dev,
>>    133				"failed to read INT REG STATUS %d\n", ret);
>>    134			mutex_unlock(&info->mutex);
>>    135			return;
>>    136		}
>>    137	
>>    138	
>>    139		mutex_unlock(&info->mutex);
>>    140	}
>>    141	
>>    142	
>>    143	static irqreturn_t ptn5150_irq_handler(int irq, void *data)
>>    144	{
>>    145		struct ptn5150_info *info = data;
>>    146	
>>    147		schedule_work(&info->irq_work);
>>    148	
>>    149		return IRQ_HANDLED;
>>    150	}
>>    151	
>>    152	static int ptn5150_init_dev_type(struct ptn5150_info *info)
>>    153	{
>>    154		unsigned int reg_data, vendor_id, version_id;
>>    155		int ret;
>>    156	
>>    157		ret = regmap_read(info->regmap, PTN5150_REG_DEVICE_ID, &reg_data);
>>    158		if (ret) {
>>    159			dev_err(info->dev, "failed to read DEVICE_ID %d\n", ret);
>>    160			return -EINVAL;
>>    161		}
>>    162	
>>    163		vendor_id = ((reg_data & PTN5150_REG_DEVICE_ID_VENDOR_MASK) >>
>>    164					PTN5150_REG_DEVICE_ID_VENDOR_SHIFT);
>>    165		version_id = ((reg_data & PTN5150_REG_DEVICE_ID_VERSION_MASK) >>
>>    166					PTN5150_REG_DEVICE_ID_VERSION_SHIFT);
>>    167	
>>    168		dev_info(info->dev, "Device type: version: 0x%x, vendor: 0x%x\n",
>>    169				    version_id, vendor_id);
>>    170	
>>    171		/* Clear any existing interrupts */
>>    172		ret = regmap_read(info->regmap, PTN5150_REG_INT_STATUS, &reg_data);
>>    173		if (ret) {
>>    174			dev_err(info->dev,
>>    175				"failed to read PTN5150_REG_INT_STATUS %d\n",
>>    176				ret);
>>    177			return -EINVAL;
>>    178		}
>>    179	
>>    180		ret = regmap_read(info->regmap, PTN5150_REG_INT_REG_STATUS, &reg_data);
>>    181		if (ret) {
>>    182			dev_err(info->dev,
>>    183				"failed to read PTN5150_REG_INT_REG_STATUS %d\n", ret);
>>    184			return -EINVAL;
>>    185		}
>>    186	
>>    187		return 0;
>>    188	}
>>    189	
>>    190	static int ptn5150_i2c_probe(struct i2c_client *i2c,
>>    191					 const struct i2c_device_id *id)
>>    192	{
>>    193		struct device *dev = &i2c->dev;
>>    194		struct device_node *np = i2c->dev.of_node;
>>    195		struct ptn5150_info *info;
>>    196		int ret;
>>    197	
>>    198		if (!np)
>>    199			return -EINVAL;
>>    200	
>>    201		info = devm_kzalloc(&i2c->dev, sizeof(*info), GFP_KERNEL);
>>    202		if (!info)
>>    203			return -ENOMEM;
>>    204		i2c_set_clientdata(i2c, info);
>>    205	
>>    206		info->dev = &i2c->dev;
>>    207		info->i2c = i2c;
>>    208		info->int_gpiod = devm_gpiod_get(&i2c->dev, "int", GPIOD_IN);
>>    209		if (!info->int_gpiod) {
>>    210			dev_err(dev, "failed to get INT GPIO\n");
>>    211			return -EINVAL;
>>    212		}
>>    213		info->vbus_gpiod = devm_gpiod_get(&i2c->dev, "vbus", GPIOD_IN);
>>    214		if (!info->vbus_gpiod) {
>>    215			dev_err(dev, "failed to get VBUS GPIO\n");
>>    216			return -EINVAL;
>>    217		}
>>    218		ret = gpiod_direction_output(info->vbus_gpiod, 0);
>>    219		if (ret) {
>>    220			dev_err(dev, "failed to set VBUS GPIO direction\n");
>>    221			return -EINVAL;
>>    222		}
>>    223	
>>    224		mutex_init(&info->mutex);
>>    225	
>>    226		INIT_WORK(&info->irq_work, ptn5150_irq_work);
>>    227	
>>    228		info->regmap = devm_regmap_init_i2c(i2c, &ptn5150_regmap_config);
>>    229		if (IS_ERR(info->regmap)) {
>>    230			ret = PTR_ERR(info->regmap);
>>    231			dev_err(info->dev, "failed to allocate register map: %d\n",
>>    232					   ret);
>>    233			return ret;
>>    234		}
>>    235	
>>    236		if (info->int_gpiod) {
>>    237			info->irq = gpiod_to_irq(info->int_gpiod);
>>    238			if (info->irq < 0) {
>>    239				dev_err(dev, "failed to get INTB IRQ\n");
>>    240				return info->irq;
>>    241			}
>>    242	
>>    243			ret = devm_request_threaded_irq(dev, info->irq, NULL,
>>    244							ptn5150_irq_handler,
>>    245							IRQF_TRIGGER_FALLING |
>>    246							IRQF_ONESHOT,
>>    247							i2c->name, info);
>>    248			if (ret < 0) {
>>    249				dev_err(dev, "failed to request handler for INTB IRQ\n");
>>    250				return ret;
>>    251			}
>>    252		}
>>    253	
>>    254		/* Allocate extcon device */
>>  > 255		info->edev = devm_extcon_dev_allocate(info->dev, ptn5150_extcon_cable);
>>    256		if (IS_ERR(info->edev)) {
>>    257			dev_err(info->dev, "failed to allocate memory for extcon\n");
>>    258			return -ENOMEM;
>>    259		}
>>    260	
>>    261		/* Register extcon device */
>>  > 262		ret = devm_extcon_dev_register(info->dev, info->edev);
>>    263		if (ret) {
>>    264			dev_err(info->dev, "failed to register extcon device\n");
>>    265			return ret;
>>    266		}
>>    267	
>>    268		/* Initialize PTN5150 device and print vendor id and version id */
>>    269		ret = ptn5150_init_dev_type(info);
>>    270		if (ret)
>>    271			return -EINVAL;
>>    272	
>>    273		return 0;
>>    274	}
>>    275	
>>
>> ---
>> 0-DAY kernel test infrastructure                Open Source Technology Center
>> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
> 
> 
> 
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
