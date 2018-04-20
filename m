Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4+YTUuxiSTtp3KcowglzU3TP3vpfzkdGvqYgCgQ8yxv17Ch4BD2g01xN6cwxtDkSCGY5VFk
ARC-Seal: i=1; a=rsa-sha256; t=1524209444; cv=none;
        d=google.com; s=arc-20160816;
        b=trbazS1PBLgR26SXARMU+V3NwEjoiLCBnt26bITy6NN8QAIuANRTpOMMyzvwglcK9N
         s3LaDzc8d1ntVnGRuHfO43LDShfoNEAHCWcUS+tYfDZX2biQ2pgF/O7gDflDqqhRR/8Y
         jWT1PvlwceIDw4yOxuq2qqBWZNZpdCdwsCs/bYrht8Jxj6DnjCs0ymHSeS2OA+CfYFrx
         iXSSgdaX6o7mQij+BOrwaf3sLstuge9FqQN6V8Sia3nMDPI4M/1hi6HPnQTJp9MeBm0x
         fcW4odn22jABrdh+QHqZOgNqN+f/PERdfCKbY0l0NMqk54Ouf6dywF4gBs9u6kA/LH+x
         RT5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=CIcA0VnasMs0iRoFTNGjOHGkuvYWBHRihRg3PpfSB5c=;
        b=gGj0bWpsxjgUuTjM4pxIeFjo+zKqJ497Wc4BqmpbTxQXh1reQ1mtX4BPRm+h6v8bEu
         d7CVbehZjxMZkKvfXkf3FDDdT1IH2JIH0R5EYCByUP4j7Pk0zl4YM7RdukzUrdLMl7C9
         M2+gKwY/PZGIo+oPSqyerv0XKhW1iEMTaBz6kAr4I9F9iGERjVntXghTtuFcrZWp+kVU
         1ZG3yEEUP4qc02X/HPGgJ+idNMsjTRIZD2T0pKCX7e0KtcUqtUkpV3F3CaKtrjNcqSCK
         G2xL2ZqqFAe125ykKFIYyuK8jue16DiFYBjAcF63sAcCUrMovIvms2f8AYG/6pHHUhQV
         V3jQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=kdK8j1OI;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.2.95 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=kdK8j1OI;
       spf=pass (google.com: domain of peda@axentia.se designates 40.107.2.95 as permitted sender) smtp.mailfrom=peda@axentia.se
Subject: Re: [PATCH v2] usb: chipidea: Hook into mux framework to toggle usb
 switch
To: Peter Chen <peter.chen@nxp.com>, Yossi Mansharoff
 <yossim@codeaurora.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:CHIPIDEA USB HIGH SPEED DUAL ROLE CONTROLLER"
 <linux-usb@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Cc: "robh@kernel.org" <robh@kernel.org>,
 "swboyd@chromium.org" <swboyd@chromium.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Stephen Boyd <stephen.boyd@linaro.org>
References: <1523973148-2094-1-git-send-email-yossim@codeaurora.org>
 <HE1PR04MB14504981D8B409CD8F9E7B7D8BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1fd0df0a-3930-94c8-2973-2c90e0b07530@axentia.se>
Date: Fri, 20 Apr 2018 09:30:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <HE1PR04MB14504981D8B409CD8F9E7B7D8BB40@HE1PR04MB1450.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: DB3PR0202CA0023.eurprd02.prod.outlook.com
 (2603:10a6:8:1::36) To DB6PR0202MB2776.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::22)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;3:4h5rYqbFpqesgHnFDdN1NCsc8S/vBDqW6ZjQMyXCOgOE54MgKSYJ6zzu65hxqqPhxmKHm916wXCHIy30+sw7y54fyZn4LJBheLreh0fVn3ZoODDpYJJUFOa1Z5aJloxbNQ7mY0PiVp3J5dOZIqh2dVnaZtj2UFaKce0bNKFEjMMhMVy1Je9pRfr7pKBt/u774L1PdaEi6pzvX0kCxWM1W8He6ALxfMm+qdN6skl7D4oMpqmZU9jGHG6vMsPgqHey;25:MzaIH0xAuLpG+AqQzNx9LesidrcGB34FwE+d/s5edTp86vS56yfy9SR1VkVT1akGKWAuU+cekiGzb8itWPG7l6yM1ldx7kClTygm6fuZYCUYawkSJReVBIl8M7uKh2mnRA6DQJ2TZ3T8W0UHmP+9SBvgFFEf2VmQ70MpbyJMhNcEtnMBrgBYlyzSgHZyrS/1SzibODTYLdyn8+5/rYNq1gps8Woh+XK6qfmXBRouVqYn7zj0DXm14l0POpCXG7sP36mZWCEzmS57aM7vwJOAF9sU7CDBxbHIcokwhzQjXZcrzVAlWcHfRaDKxfdmNECSdPE5hRThWQc0vmglnsj9vQ==;31:L173A8qJmy2qIFcIEUDfGVpB7+kFUjRxF1HW2sxle4t4krkZBnEB/lQlT+UNGIjZ6I5HupmLfiKVHqHE5r/gsHl0GPz9ciAqhxbyRNnMN23vgqWUvm1SgzsNfjEQWjR+0WhiUfFHTFF2eFiDOnlOoBtqWOvPCyJ6B+1iopdw0uszOg2m62axT22oP0rTctFRMWL85X6n1kz/k21idk/xxv2YDT/k7Nzhm1+qaU57hUE=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2776:
Authentication-Results: outbound.protection.outlook.com; spf=skipped
 (originating message); dkim=none (message not signed) header.d=none;
 dmarc=none action=none header.from=axentia.se;
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2776B9FC5AA4F82E2A94A1A0BCB40@DB6PR0202MB2776.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231232)(944501391)(52105095)(93006095)(93001095)(10201501046)(3002001)(6041310)(20161123564045)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:DB6PR0202MB2776;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2776;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;4:nCZKSV+BUaelLL0uIFLRge7Cc5ioez71fUPuBzhbBLhcBxbyGjWEwx4JdK3T7XxKzocEY7xJM4vSNQifgXIOMXC2dzSi7QcG2F/vdVH43clzcxnzUlrkjtScmIfYyz0VvFRtIG94VcDpYMW1aeWmP05dQxurTmNbkXg0y0Jv41j7uw9EkfbITRunxjd8vnVTq9458xluhKSmyaCALDXLpIGNH1K+pBy512jrZ+wwnVWI5Xl+zi8MEnS25WFRvjeTfk0B/2jq7lagshye4U53iQ==
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(366004)(39380400002)(376002)(396003)(52314003)(377424004)(8936002)(11346002)(23676004)(305945005)(74482002)(6246003)(4326008)(77096007)(6666003)(8676002)(186003)(81166006)(16526019)(6486002)(36916002)(65826007)(53546011)(52146003)(229853002)(2486003)(86362001)(386003)(52116002)(26005)(76176011)(5660300001)(31696002)(31686004)(6116002)(47776003)(446003)(3846002)(230700001)(110136005)(8656006)(50466002)(476003)(956004)(117156002)(3260700006)(316002)(2616005)(25786009)(478600001)(36756003)(53936002)(54906003)(7736002)(16576012)(2906002)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2776;H:[192.168.13.3];FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzY7MjM6aTAwSExqYW5yUy9sMWtmRTc1N3dDS0xF?=
 =?utf-8?B?VUFNT0xQSTJhV1Y0TDlSeUE5dHFScUhQamZyaE81VWVnVkk1eWI3U2lPRmFm?=
 =?utf-8?B?eHZLSUpmQWttQmFPUWkvTUFvTkZKWHlkeTRJWlh5amZkVjd4aHkwUlY1MjdK?=
 =?utf-8?B?ZVc3UVRLWE56TlRkUWk3aGxwOEJaNU1iOVVIb3hRNDhZQkVmdXY0bDV2L1BS?=
 =?utf-8?B?U3kvYjVVQk51YVdROFlxSFh4UVZyMGt4R2VwSFZYc2J1Yk90aEthVHZ1SDBt?=
 =?utf-8?B?aitVelN0aVpDUCtKMFpNUUgwZFRvbXlMUGxDbjhvM2Y1Qm83TC9ydklGdUhs?=
 =?utf-8?B?b2dBMmF6RGdhNFk3Q21Cc0RTMkFtb1lKaFJ2eHo2aDhYSEVTLytQRmN1QmtJ?=
 =?utf-8?B?eFg5ZkpmVmFoaGJ1L1hNeklkMnQ5ajNRS0lFeXYyN1QzcU5UZkhDc0dubjda?=
 =?utf-8?B?Zk1zNEY2R01Kays2ejVkdEVxMEhOR2VVQWNNWEgvUHFCYWFqcW9IK3laL1pI?=
 =?utf-8?B?bjgzRnBsekc3aXZzN0E1Z3NpeDExaEZvMmJXNkVTME1GdFJ6MkdmK2c4MExY?=
 =?utf-8?B?aFE2eG9GZ2dCaUs5aklwWWVYbkJTQzl5V0lQOStqSXR6cVd6Q25pT2IrS1N1?=
 =?utf-8?B?REkvSVVmcC9PdHZTcTg0Zy9kbzhtU3BleHlyVjRiQ0hLbStYRGNmRkRvRStR?=
 =?utf-8?B?WkhoOHhWejUzY2xZLzd4ZklFRGNWZHJSTUdscUxRTzMwdURhd2hXMzNFYkxw?=
 =?utf-8?B?ZG1kaThhZGVYdjVJWVpQVDV1bVNOdllwVHFkbFZMYlo1WkV6dmFqaS9EYlp6?=
 =?utf-8?B?R2xYTGhRNXpEclB0eUEzZ3RVUVRzdnJSajVFUzlXUHpyTWpSUCs5WHhqNDFS?=
 =?utf-8?B?QWpuQmRyUmFDd3VtMXpsSENsbkU3ampKYlZjR3VpZXArd3hod2xlbHJXcnpI?=
 =?utf-8?B?Q1UzSUFJcFRQREFySmV1RXNvZEtFVWk5cWxVcDJZcURrRnpCZ2lLY2V3cThw?=
 =?utf-8?B?VFVpeGx0TVdRRENkNUFiSzYzOUprZlVtVHZWa1B0dGdYbGh6MjVyNHorZDdP?=
 =?utf-8?B?d1I4c0hvRzJiZXgwalpkUGsxS2w1c1d6aDlJbWxBYy92elBIOHNhMmxaS2Z6?=
 =?utf-8?B?SDVwc1BsSWhhWmorQ0JaR2ZHQnBhM2U2WXdkSVlLVjk4cDNtdUVwRnZYUXlq?=
 =?utf-8?B?YXMrOXRFeVdQci9kNHVObjB6bWYwbExFck5ObEcvVEg2bmpsaGVCb3JKcnBy?=
 =?utf-8?B?MVQ3Rm9NNVRNaXBmbmVLOHZSbGRzTjFNYnUrWW52MDNCK2dPMzJlWDY2NGxD?=
 =?utf-8?B?WHBwU2RUNVZJbVZNWkp3eUg3YUJ3RE1HVzJidGlxanZRdU5Zc2V0V0gydEM4?=
 =?utf-8?B?Q2dMbFY3RmJrOTZ4bm1kaVNxQjd0UmFTN2VrYmpMYXlicENsTHlza3Y5Y01U?=
 =?utf-8?B?em1Ya2JLYlN4U1Vkemc2bUZ2dkxhM2RKbjJWZDBSNGNFUkhMZEpacjlIVHQz?=
 =?utf-8?B?dDhCelpTcFk3K2psK0JKQjJRVDlSRVZxOGpCV1ltVFpZYUtTR3lqRlcyZzM5?=
 =?utf-8?B?c3pnTHRTWVl1eGphdlFuV3h6dldLTytSS2dUbXJmcjZuczZ1ZU83RHZrNWxk?=
 =?utf-8?B?S2tEVXRmbnJYaGYrUlV0a3d6bHVqVXRtR1h3a2duV253aFJweVB3ajB5VmV4?=
 =?utf-8?B?V29xS3luUHNUeDVqZUNpUnlRcDdLNzhZRFgzM2FmWmtsWTBVU000ZWtGZFQ5?=
 =?utf-8?Q?NAn8b31HICkSllNHgzK/CMAIOUE8tLJO3QJGqR4=3D?=
X-Microsoft-Antispam-Message-Info: sTA2dK90hkZIavOTzHzvX5D6IiQIy1JrNbhy94J9QZtWGCVUIWcjEDNi2c2xhgCyrPn2ZRDrFYRAvX7KYjjWmzYvlJ3DKmEDfmLVMWMBLGz5LFEu6Qhp+EzM10qsaK6XXUbEe557aFsQ/TiJTqmyLmb8K5N1cvqtDfB4AeyzhfowlqN9ASTYmWc0jj9g0kyo
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;6:CLAIzC4nEm89f9rp4sazAS4nXWZqVE1D4BU9ydHO24765iB5DHJ9iG6C5xtPHCCkrqD0WexlvGNzFKfQZxT4fqmx512qlPsbd0jkEwaSGkMn/dCLDMk5H9bXEMfr+tZOMlVdGv87W1jFFZGT0K4QB7ro5YN1wnPc97zQZyS01YFQhTCJINvzYiQt7JhwOZiKTsgUqAkPsD+td4Yknm6BG+XBA+0M1XLzqKTzssh8ONj6FHUAqajmP8uv49h7YDjF0tl+o7IgruQm6YwnYc64x7ix7ibyuCUmBfyC6zZOsQ1KP2lgAqXmc117/BTQnzSGhMTzWiYeQULwhrvhv6Hnfy6sXiBDlzC/CjOkDrDKcnf6qcAu8hvtXHAqNzCCNxE3uU9B2CDtxNzF4nM5Ik5YA+KGPs+zmLqHOANaXwqFUWxH2auFB8uyyxXR3HXAVNTGGZ//BdL4m4l8yKI6FjZGXg==;5:jXS1e97R2hFKcMh9XkDKiqw/s9ipMXNM8US0IAcTgvrQODeP/rH9qZR7nXTKRL/EwZkL6jYCbl2FUvJqLW5Lso5he89iar5RAX2IO+wtfz2RrXMhV/UiDdMfyJI5yvMp8RjR46oNom11AXHkrl9kAT2iUNTctLVuF6+yJrgHZnA=;24:nSrBg/cP+bw3UazSWan2C1W4AEMWd9AanUkFVffyWnnWhX7v2tYuHISaknGQfp3c6O7cq/0Nj96wsKM3Ni3DJAf2CFY412D5QqiboBnlysE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2776;7:JZavE3scxOsyUg2NdVWjvOKJcEZkkUVnKJkaAjjCgplTQtYQ62LJT/HChPzLgEH+Wsl98ECJtoNHp1nta+2/2accjKidWgV/FKf0bSDnY6bSX+QitHubU1aJE6+QcBj8Ot9pqbFcBuqqOZrtEEVWr50DKT1IuX0GdZjzBzZQceelNU8hTrjr1YqqyX2GxiAEzkyMucdyLGtZqpRjqTwr7xgfjBg0Hv6fa9spJ30IofVROBGiaWjj/QNJwoHeEfpe
X-MS-Office365-Filtering-Correlation-Id: 5d107556-0fb4-4f71-01e9-08d5a6909eb4
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:30:40.5266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d107556-0fb4-4f71-01e9-08d5a6909eb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2776
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592995743032653066?=
X-GMAIL-MSGID: =?utf-8?q?1598249443364952508?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-20 04:00, Peter Chen wrote:
>  
>  
>> --- a/drivers/usb/chipidea/Kconfig
>> +++ b/drivers/usb/chipidea/Kconfig
>> @@ -3,6 +3,8 @@ config USB_CHIPIDEA
>>  	depends on ((USB_EHCI_HCD && USB_GADGET) || (USB_EHCI_HCD
>> && !USB_GADGET) || (!USB_EHCI_HCD && USB_GADGET)) && HAS_DMA
>>  	select EXTCON
>>  	select RESET_CONTROLLER
>> +	select MULTIPLEXER
>> +	select MUX_GPIO
> 
> The above two configurations are only used at your specific platforms, please add
> them at either your platform defconfig or the related hardware driver's Kconfig. 

"select MUX_GPIO" is indeed questionable and should be somewhere else because
this driver will work with any other mux as well. It's simply something else
that requires it. If it was the case that MUX_GPIO is indeed required then the
whole use of the mux subsystem is questionable and the thing controlled might
as well be controlled directly with the GPIO line. The mux subsystem is good
when a single mux "controller" is shared between several unrelated drivers
utilizing different muxes controlled by that same mux "controller" (think
several muxes controlled by the same GPIO line/lines). The mux subsystem is
also useful when the driver does not want to handle/know how the specific mux
is controlled. That said, it's of course not wrong to use the mux subsystem
in cases like this either, but I think it might be much easier and direct to
just twiddle the single GPIO line directly here?

Or do you expect some future HW variant that will use some other means to
control this mux?

>>  	help
>>  	  Say Y here if your system has a dual role high speed USB
>>  	  controller based on ChipIdea silicon IP. It supports:
>> diff --git a/drivers/usb/chipidea/core.c b/drivers/usb/chipidea/core.c index
>> 33ae87f..8fa0991 100644
>> --- a/drivers/usb/chipidea/core.c
>> +++ b/drivers/usb/chipidea/core.c
>> @@ -61,6 +61,7 @@
>>  #include <linux/of.h>
>>  #include <linux/regulator/consumer.h>
>>  #include <linux/usb/ehci_def.h>
>> +#include <linux/mux/consumer.h>
>>
>>  #include "ci.h"
>>  #include "udc.h"
>> @@ -687,6 +688,10 @@ static int ci_get_platdata(struct device *dev,
>>  	if (of_find_property(dev->of_node, "non-zero-ttctrl-ttha", NULL))
>>  		platdata->flags |= CI_HDRC_SET_NON_ZERO_TTHA;
>>
>> +	platdata->usb_switch = devm_mux_control_get_optional(dev, "usb_switch");
>> +	if (IS_ERR(platdata->usb_switch))
>> +		return PTR_ERR(platdata->usb_switch);
>> +
>>  	ext_id = ERR_PTR(-ENODEV);
>>  	ext_vbus = ERR_PTR(-ENODEV);
>>  	if (of_property_read_bool(dev->of_node, "extcon")) { diff --git
>> a/drivers/usb/chipidea/host.c b/drivers/usb/chipidea/host.c index af45aa32..d9d2d00
>> 100644
>> --- a/drivers/usb/chipidea/host.c
>> +++ b/drivers/usb/chipidea/host.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/usb/hcd.h>
>>  #include <linux/usb/chipidea.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/mux/consumer.h>
>>
>>  #include "../host/ehci.h"
>>
>> @@ -161,6 +162,10 @@ static int host_start(struct ci_hdrc *ci)
>>  		if (ci_otg_is_fsm_mode(ci)) {
>>  			otg->host = &hcd->self;
>>  			hcd->self.otg_port = 1;
>> +		} else {
>> +			ret = mux_control_select(ci->platdata->usb_switch, 1);
>> +			if (ret)
>> +				goto disable_reg;
> 
> What will happen if ci->platdata->usb_switch  is NULL?

What has not been mentioned in this patch is that it depends on another
patch which is not yet upstream. You can google for

mux: add mux_control_get_optional() API

to get an idea (it's also in linux-next). Anyway, with that patch this
is not a problem.

>>  		}
>>  	}
>>
>> @@ -181,6 +186,8 @@ static void host_stop(struct ci_hdrc *ci)
>>  	struct usb_hcd *hcd = ci->hcd;
>>
>>  	if (hcd) {
>> +		if (!ci_otg_is_fsm_mode(ci))
>> +			mux_control_deselect(ci->platdata->usb_switch);
> 
> Ditto.
> 
>>  		if (ci->platdata->notify_event)
>>  			ci->platdata->notify_event(ci,
>>  				CI_HDRC_CONTROLLER_STOPPED_EVENT);
>> diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c index
>> 9852ec5..209d3f6 100644
>> --- a/drivers/usb/chipidea/udc.c
>> +++ b/drivers/usb/chipidea/udc.c
>> @@ -19,6 +19,7 @@
>>  #include <linux/usb/gadget.h>
>>  #include <linux/usb/otg-fsm.h>
>>  #include <linux/usb/chipidea.h>
>> +#include <linux/mux/consumer.h>
>>
>>  #include "ci.h"
>>  #include "udc.h"
>> @@ -1965,16 +1966,26 @@ void ci_hdrc_gadget_destroy(struct ci_hdrc *ci)
>>
>>  static int udc_id_switch_for_device(struct ci_hdrc *ci)  {
>> +	int ret = 0;
>> +
>>  	if (ci->is_otg)
>>  		/* Clear and enable BSV irq */
>>  		hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE,
>>  					OTGSC_BSVIS | OTGSC_BSVIE);
>>
>> -	return 0;
>> +	if (!ci_otg_is_fsm_mode(ci))
>> +		ret = mux_control_select(ci->platdata->usb_switch, 0);
>> +
> 
> Ditto
> 
>> +	if (ci->is_otg && ret)
>> +		hw_write_otgsc(ci, OTGSC_BSVIE | OTGSC_BSVIS,
>> OTGSC_BSVIS);
>> +
>> +	return ret;
>>  }
>>
>>  static void udc_id_switch_for_host(struct ci_hdrc *ci)  {
>> +	mux_control_deselect(ci->platdata->usb_switch);
>> +
>>  	/*
>>  	 * host doesn't care B_SESSION_VALID event
>>  	 * so clear and disbale BSV irq
>> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h index
>> 07f9936..9ea55a1 100644
>> --- a/include/linux/usb/chipidea.h
>> +++ b/include/linux/usb/chipidea.h
>> @@ -10,6 +10,7 @@
>>  #include <linux/usb/otg.h>
>>
>>  struct ci_hdrc;
>> +struct mux_control;
>>
>>  /**
>>   * struct ci_hdrc_cable - structure for external connector cable state tracking @@ -
>> 76,6 +77,7 @@ struct ci_hdrc_platform_data {
>>  	/* VBUS and ID signal state tracking, using extcon framework */
>>  	struct ci_hdrc_cable		vbus_extcon;
>>  	struct ci_hdrc_cable		id_extcon;
>> +	struct mux_control		*usb_switch;
>>  	u32			phy_clkgate_delay_us;
>  
> If CONFIG_USB_CHIPIDEA_HOST is not defined, it may cause build error

How is that related? There is a forward declaration above?

Cheers,
peda
