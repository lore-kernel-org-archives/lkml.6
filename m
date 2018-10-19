Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1E7ECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E09321486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 11:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="rYUZi0+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E09321486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbeJSTZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 15:25:46 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24716 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbeJSTZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 15:25:45 -0400
X-IronPort-AV: E=Sophos;i="5.54,399,1534834800"; 
   d="scan'208";a="21941075"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 19 Oct 2018 04:20:07 -0700
Received: from NAM05-BY2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 19 Oct 2018 04:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CKDgLUd7PYs5mqmYHbgG6J02CmXbh3LIMhbyfX1iomE=;
 b=rYUZi0+SEbYrt3FHDJVobi5MV+B317CuRgYfSCe8GT/u0fCcJ7Th4AWpXiIwk68i9R6tc1avP4cQBnWQqIs9TJ4LhRGIDFiGR5t4L0zqCHpdK226xpG4Yxd65nrNtQ9a3uT53PLzClnP5N8d1GtFpOyh9fqScP/ffqTD2bReipE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
Received: from [10.145.4.38] (94.177.32.154) by
 BLUPR11MB0738.namprd11.prod.outlook.com (2a01:111:e400:594c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Fri, 19 Oct
 2018 11:18:35 +0000
Subject: Re: [RESEND PATCH v5 1/9] pwm: extend PWM framework with PWM modes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <mark.rutland@arm.com>, <linux-pwm@vger.kernel.org>,
        <alexandre.belloni@bootlin.com>, <shc_work@mail.ru>,
        <corbet@lwn.net>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <1535461286-12308-1-git-send-email-claudiu.beznea@microchip.com>
 <1535461286-12308-2-git-send-email-claudiu.beznea@microchip.com>
 <20181016122508.GH8852@ulmo>
 <139cc421-ac12-1262-bc32-763731528ccf@microchip.com>
 <20181018153250.GC6226@ulmo>
From:   Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <1e98ea6f-1ff8-9822-fa77-ffbedb8e2443@microchip.com>
Date:   Fri, 19 Oct 2018 14:18:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181018153250.GC6226@ulmo>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [94.177.32.154]
X-ClientProxiedBy: CWLP265CA0063.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:12::27) To BLUPR11MB0738.namprd11.prod.outlook.com
 (2a01:111:e400:594c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafa16ba-9f5b-4745-d8e9-08d635b49db7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BLUPR11MB0738;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR11MB0738;3:tf8Liw+OWL8mjTXhlmzU++WXZSDzf8E4L69GAvs/Zxij1OL7kyYfVHEPUtDhWX2UkEdA8fg53n1t6eCiKJoCoJDzvSkCHLZ/0d+S0hMsDiFQaflyp+9emMKhD+2dMWSvNKT65qsXDPxPHWr6GgvOSxsjRX2NpuyOkg9vAlCajo9KHDmTICz+gmmH+EEe1i/2nn+W5EhUfmVG7GzPRwY4ysDfNdV/AMce5pIYnLUlQ2YtoctViXp4rZNaUylm+6LC;25:eEuIP5RbDzTTzVD8utZ0TJlGNyE9XdIqDgbe9c3wLE/5YJMHojcfpvmMj8WiYCDJIg9oBjlWdc5TbOML2wYcVCZxdWXDE3zcZ+VeZ+P1ZkKwJSFTVcgYGGMUhcKS3RTtK7714f4OLD0S3JmcP2zRovbm1SWDffWh8hHNlTyE6+1fpSP474bgdQ1dRGhiCc4TeFKWBtBSg8VoTOVLs11sKqzwoFSNCQc39e2GzJndscTrs7FNhDeCWTc5FhPjti12qqf1I0UB6my3Op3bvuRReSE9njmdRztJoBiBKsdNkSed0qQ/HBCMsprXhIlSu+zpgmk/tbHZtXHIfZ8ma8ovt81YwdvA7KH+HdUfIV+i8BU=;31:ksOPnmn+8BPAP3tFfysRaHjV7zMpY3iTupdS7dNX6m4M3+ge2M1+BD7WieWh9NOepGiM93vpfrDSB6hdarpXW3ByYJXfDiSR83zUEhbebgzdtxx/zL1G0Ue5TVAbW7NHsemWdyR/uxec9hYgshpXO0N+9Y9K5feEr+437DIemXOZOZMHyWh6bV/i6OGFzjWTKSDLEuoGqljw9HZOxRbruvoaqkFlIIgdI/5onrNdnfY=
X-MS-TrafficTypeDiagnostic: BLUPR11MB0738:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR11MB0738;20:mu83EVaA7056V3Ri2EPhoz0JpSFu7ExHWnlPKuM/UGGzQ4qqREbU5GOr9eM7J5bU6bb/N2BfYfxlmQYpQkS/X+8fkCk8VYSB8OOpP+GM59nODVVD4jrfmn5ZUdHzr/xBLOg8/xpaXV+LZxL9Fj4sfLHUq22PKO7zOXE6mhZeYaol1Mc43idgC7WGZU1DGyY6J8y9sOBMv3/LpXApgMZvE7ftRJF2o7pRD9ORVu3xST4JifaXZn0cFm6XhWe4pZ6YLMoIuca/c3ytFa5CQeSjH4wiyROvCB+N/jPoVw5dufU6Lrdt0Gjpwj3kILMFlxORKFKYsEdcB8UKn2hAtcx/LrFNnWQ/SSbs7JaZ9Jx/JGL81KBRA1iEulHSdh8gnFIgY/VFi3RL+1JmtcyyL3qLXfBINY1qaRmuN1BUjDmKHmY=;4:j4yHT1SAX4XrLyTwBVDtFD0Rn2pU8NMBQ7uVihlNxhKizO59CT/CGFMVqVR2pHG9bIlfC6p1zTb5BFYqeMfkVHXvT3ENS3AbOaTDyNIj5BLugM/VS0KrcBIrhlJiDZAj9ChfgQmMHT3FqcLhdNwPwsBRcglJueBSkH1OX+UYXtpEoPuSis0w5o68PK7IkKvekA1nRN5dtRVTQ5z+wHHPuavwjLk4YbQOELU65uiI0LRw462JV2mxMBiTVbYLByh2MxE5P4hXB5RE3tdC8v4SWt+Uu8hOGByI6y5c2DwtpZnr4yTgfLpuAiXH8aKGkA3T
X-Microsoft-Antispam-PRVS: <BLUPR11MB07380FC2CE5D94F74D8B053087F90@BLUPR11MB0738.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211171220733660);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231355)(944501410)(4982022)(52105095)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BLUPR11MB0738;BCL:0;PCL:0;RULEID:;SRVR:BLUPR11MB0738;
X-Forefront-PRVS: 0830866D19
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(376002)(346002)(39830400003)(136003)(396003)(52314003)(189003)(199004)(97736004)(31686004)(8936002)(6666004)(16576012)(58126008)(316002)(68736007)(93886005)(6116002)(966005)(3846002)(478600001)(77096007)(8676002)(72206003)(26005)(16526019)(186003)(230700001)(6306002)(66066001)(65956001)(47776003)(65806001)(36756003)(2906002)(31696002)(86362001)(6246003)(53936002)(6486002)(25786009)(105586002)(106356001)(4326008)(446003)(11346002)(486006)(956004)(476003)(2616005)(305945005)(81156014)(81166006)(229853002)(50466002)(39060400002)(7736002)(7416002)(52116002)(217873002)(5660300001)(14444005)(65826007)(76176011)(53546011)(386003)(23746002)(6916009)(64126003);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR11MB0738;H:[10.145.4.38];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;BLUPR11MB0738;23:L+T99UK6TTAnMay+/suaEPKg5A4kYh31Tim/f?=
 =?Windows-1252?Q?PjbD6+NOm8HxDoW4wtAp74cQcvrQiXACR11LyxuVe4DYlQ3qo7SvyrMP?=
 =?Windows-1252?Q?97sYoJtUHul8EbdK4IvKg1tN7GC4y7499WyqDgUFNXdn5PesuQ81IH9w?=
 =?Windows-1252?Q?hYfyw5tRR4FsQjnP0k069xeQOhsTixTysQ36ejbjKYIy+S1EVCf1uehO?=
 =?Windows-1252?Q?VPuEwUSMTv3lCJWml8sD2JnnwnMsSS2S++NRQLv7D1kClxc1jMR6xQkh?=
 =?Windows-1252?Q?J+H1yoT+CAjIlyukx5/ihghpCMg9X3u7sYxFpDcmNIBGRWg131SXgh/S?=
 =?Windows-1252?Q?hP5pi0Dv9vgPYYDbvxJASMLlxLKgLCfXuMxlfjJOB95dN9lwZIL9UE4B?=
 =?Windows-1252?Q?CxLkVH8AyE7ZQ1ebVXt+zbByZTNhIrmPuBZEPUi72IHj0EqCNPlioNpF?=
 =?Windows-1252?Q?E+QVhTooeugyUZjSwu3RoCW/Z6kIwD4fJwMKhrkcrvLt4fsJSM8N0zd1?=
 =?Windows-1252?Q?CjAhTi025qPrDNHgTXfe/NVg7Qx6xwGaXcym+FbvxQagAy0wWn1PztJM?=
 =?Windows-1252?Q?uS5NbS79vybp4Cax9GKjFoinlEqVJyqZQ2BGwyZKrmZy9n4/Vs8extwS?=
 =?Windows-1252?Q?uWCrGJWUfkkNvv2selTwWx2Raqvt6lIxNo8nCjcLBldSnab0qSUoPGQW?=
 =?Windows-1252?Q?MfIwR+Adm5PbqqbrAAk7wkBIWjeo9EpVotqGZ0okKMe4g+ie4fdHbWI1?=
 =?Windows-1252?Q?WLyx9TT1l87aiTK8DGfEDoINsS0fMnt3qXjvbA8AQslzJVnVjNGK0DmT?=
 =?Windows-1252?Q?JezkKqDNShgSfZ3g07Yn/N5A5FdEtA9SfO6/77pXaE85KOaVf+lzMto5?=
 =?Windows-1252?Q?Y7QCgCWXDZj0W3pTYt4p0F9lYIuQub8bN9xHnEcvo+4h5IrGFi5BCae6?=
 =?Windows-1252?Q?Z+bVd/LzFBIeiBCqFaRBDZuKEhh0T+8XAzrrcDVg9PSPwuRy2F+U2CR/?=
 =?Windows-1252?Q?RPsubClPzONQcOfO9p3agEk+atW0rV6oJy0zL/7+Zy5kYyLFnetgLwkS?=
 =?Windows-1252?Q?e0wpgy1huwY4PaGkZesoIzVGexvzCsKmlGM8TaeKfO7dLo8XIFXLsC5J?=
 =?Windows-1252?Q?ayXMnYOrLRbiWmNmWFQLw/zCAnE92tw9Yc8Gfbmo7xIkEZfJo9ETR/qp?=
 =?Windows-1252?Q?IXUP3mhlavA6Kq0L7G3TFRRXdcxC36UL5C7xJ1ZJRedcuUdTC8gMhka4?=
 =?Windows-1252?Q?7yLGYHJd2jay6U4llhmDLVYzqBKbtE5AFomNYYgtA/iUvJrbTUzHh6lF?=
 =?Windows-1252?Q?JECweTp4wSxjwDgFmc+Grwmqmca30CF9N7SsQsYJScgxCjAsocknpCtT?=
 =?Windows-1252?Q?xiXKfZWN96sSaRpzAP19bTU5fJQ1BYrCFl7hdVu7h9DB4sPP2CgVxWqD?=
 =?Windows-1252?Q?k9kTgawpr8jPJSlr1ighv/LusaAos0kPjFjYFwwRRwep1PxYDERDJClZ?=
 =?Windows-1252?Q?ZZt3liT22mCvtYP+nH4/dTGIh7CM+IzKaNrN/v8ukH1yNE20KQWoyIzU?=
 =?Windows-1252?Q?ZsH9Xntamxs3FkzloDDPHBcnQii3m2xH3aK4auYGb4dSyGvLvPQ8wCUl?=
 =?Windows-1252?Q?Ax2mUujHBnyRJkGMByk4puGOaUsHog9sIAPT/cCOtf2sogfSAWYuGDpF?=
 =?Windows-1252?Q?Ywy60iHUQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: GGU6G0HkAzzJCEomQjbRvOoV4ytIPxr/lXwcDp1rG+rLQdv92htiwV1rzDOdX8CyjQneCRhjC+hP3yAHX9oT67F9mTq+/LeyJ+PJ+P1m/MAULMQIt9ELgIvnqV4m0DPkIRCfVsZHOUzhSowBWsPs/UtF3O3hgN90fDYwX/xNzQzPbmkXOST9ImVbLATzOA+3AGn6LLduLOCbmXbGX+8Z7zdpPcv/yVpUUevbhU+v6EVL12N/SbvoL9MW7w+NXxqjWkBAuxk9NPq7HjMtjAaN2toU6eBwHr+0PF/kyE5CGhV5U8p1O69vI/b3yEsFvuaoXe86xx/k1zzTuzoHMzfhbX7Q+vAxJtxQ41giPlKIVAI=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR11MB0738;6:5cX5l8yLTWvEvzCu2tq7czuyfOwi2wzuj5Nxmi6HYbztg6Tob8uAqquG02LTJUyyTGQ+M6yVlPt0rrekOW3fUia4zScdO4dVZ8y5j2CfT/l1WQN2ZwflplQxBR+qnbnfnd9/H80mg6vpmG1aeuu3+wByhBT9XXHZo5k42ymHPVT4TXiSYX+s/uzTE0JvA4HfafdJKhdCVpBDV8tk9I3M+Y/j4LjGIpVlnzl1HI1QNEfoUD/WJ6lJG8CdZicIWfvLkWotnzubtgs8gwanYfmF5tt3V2d8IEliPNRV83bsMvTgEYqMDXhaXDJV3ltnUpOYY2T3SCsKHhACanbFwCJQqwPhWUskvjvohi4jBYPQaiZD8ltmVOcbutTQGyIQ+CSENLGYozc1Mec6vwoPue2esv9emz/r4X4DYH3z9LN4feZsQnwpz0y+KoudY7fA7qNwcZ+ZCzeXrEQlxcatM8A0nw==;5:OpSHCOb1NhRra4NcY8A577V0f+HNoYB0SzMfyXvkuaEz3Re+oKW8A165elWxZ5KLw2BORalA+/9Rg/0Pk/a1GsD3rfbhwlN3b9hRaQJyn6bZWb30kAGCRe9cRiU+NRpLZiHFBSEfvINBL+Qyfn+pQSMWEybxChC5uUKHj7/tcjM=;7:hQninHbkjPUTlV1O0K/A35IzX+FsSg4tidY3YgH8GEOyjYxt05B7rLMcj/5n2KErn4GINZkT4qxC2QCH7cPtv4os8NNVMHZ6KPHyZuoQMUcuW8JFiaRhbKYlILC9j7OYktXW5y8fAW0IPVSor5T1lifOyqIaDZspUl8a6k3algMQgO4cQgzvVC0YNz0LyT4932nkfaOxJbTwt+kIg4fp1LfxuX9k2mf+GCVllDr5OTKz2BH1XNJ1KgS8l9A8VWJb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2018 11:18:35.2522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bafa16ba-9f5b-4745-d8e9-08d635b49db7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR11MB0738
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18.10.2018 18:32, Thierry Reding wrote:
> On Wed, Oct 17, 2018 at 12:42:00PM +0000, Claudiu.Beznea@microchip.com wrote:
>> On 16.10.2018 15:25, Thierry Reding wrote:
>>> On Tue, Aug 28, 2018 at 04:01:18PM +0300, Claudiu Beznea wrote:
> [...]
>>>> +const char *pwm_mode_desc(struct pwm_device *pwm, unsigned long mode)
>>>> +{
>>>> +	static const char * const modes[] = {
>>>> +		"invalid",
>>>> +		"normal",
>>>> +		"complementary",
>>>> +	};
>>>> +
>>>> +	if (!pwm_mode_valid(pwm, mode))
>>>> +		return modes[0];
>>>> +
>>>> +	return modes[ffs(mode)];
>>>> +}
>>>
>>> Do we really need to be able to get the name of the mode in the context
>>> of a given PWM channel? Couldn't we drop the pwm parameter and simply
>>> return the name (pwm_get_mode_name()?) and at the same time remove the
>>> extra "invalid" mode in there? I'm not sure what the use-case here is,
>>> but it seems to me like the code should always check for supported modes
>>> first before reporting their names in any way.
>>
>> Looking back at this code, the main use case for checking PWM mode validity
>> in pwm_mode_desc() was only with regards to mode_store(). But there is not
>> need for this checking since the same thing will be checked in
>> pwm_apply_state() and, in case user provides an invalid mode via sysfs the
>> pwm_apply_state() will fail.
>>
>> To conclude, I will change this function in something like:
>>
>> if (mode == PWM_MODE_NORMAL)
>> 	return "normal";
>> else if (mode == PWM_MODE_COMPLEMENTARY)
>> 	return "complementary";
>> else if (mode == PWM_MODE_PUSH_PULL)
>> 	return "push-pull";
>> else
>> 	return "invalid";
>>
>> Please let me know if it is OK for you.
> 
> Do we even have to check here for validity of the mode in the first
> place? Shouldn't this already happen at a higher level? I mean we do
> need to check for valid input in mode_store(), but whatever mode we
> pass into this could already have been validated, so that this would
> never return "invalid".

Ok, now I see your point. I agree, there is no need here for "invalid" here
neither since in mode_store there is a look through all the defined modes
and, anyway, if nothing valid matches with what user provides, yes, the:

+	if (modebit == PWMC_MODE_CNT)
+		return -EINVAL;

will return anyway.

And every place this pwm_mode_desc() is used, the mode has been already
checked and it is valid.

> 
> For example, you already define an enum for the PWM modes. I think it'd
> be best if we then used that enum to pass the modes around. That way it
> becomes easy to check for validity.

Ok.

> 
> So taking one step back, I think we can remove some of the ambiguities
> by making sure we only ever specify one mode. When the mode is
> explicitly being set, we only ever want one, right?

Right!

> The only point in
> time where we can store more than one is for the capabilities. So I
> think being more explicit about that would be useful.

Ok.

> That way we remove
> any uncertainties about what the unsigned long might contain at any
> point in time.
> 
>>>> +/**
>>>>   * pwmchip_add_with_polarity() - register a new PWM chip
>>>>   * @chip: the PWM chip to add
>>>>   * @polarity: initial polarity of PWM channels
>>>> @@ -275,6 +382,8 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>>>  
>>>>  	mutex_lock(&pwm_lock);
>>>>  
>>>> +	chip->get_default_caps = pwmchip_get_default_caps;
>>>> +
>>>>  	ret = alloc_pwms(chip->base, chip->npwm);
>>>>  	if (ret < 0)
>>>>  		goto out;
>>>> @@ -294,6 +403,7 @@ int pwmchip_add_with_polarity(struct pwm_chip *chip,
>>>>  		pwm->pwm = chip->base + i;
>>>>  		pwm->hwpwm = i;
>>>>  		pwm->state.polarity = polarity;
>>>> +		pwm->state.mode = pwm_mode_get_valid(chip, pwm);
>>>>  
>>>>  		if (chip->ops->get_state)
>>>>  			chip->ops->get_state(chip, pwm, &pwm->state);
>>>> @@ -469,7 +579,8 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>>>>  	int err;
>>>>  
>>>>  	if (!pwm || !state || !state->period ||
>>>> -	    state->duty_cycle > state->period)
>>>> +	    state->duty_cycle > state->period ||
>>>> +	    !pwm_mode_valid(pwm, state->mode))
>>>>  		return -EINVAL;
>>>>  
>>>>  	if (!memcmp(state, &pwm->state, sizeof(*state)))
>>>> @@ -530,6 +641,9 @@ int pwm_apply_state(struct pwm_device *pwm, struct pwm_state *state)
>>>>  
>>>>  			pwm->state.enabled = state->enabled;
>>>>  		}
>>>> +
>>>> +		/* No mode support for non-atomic PWM. */
>>>> +		pwm->state.mode = state->mode;
>>>
>>> That comment seems misplaced. This is actually part of atomic PWM, so
>>> maybe just reverse the logic and say "mode support only for atomic PWM"
>>> or something. I would personally just leave it away.
>>
>> Ok, sure. I will remove the comment. But the code has to be there to avoid
>> unassigned mode value for PWM state (normal mode means BIT(0)) and so to
>> avoid future PWM applies failure.
> 
> Oh yeah, definitely keep the code around. I was only commenting on
> the... comment. =)
> 
>> The legacy API has
>>> no way of setting the mode, which is indication enough that we don't
>>> support it.
>>>
>>>> diff --git a/include/linux/pwm.h b/include/linux/pwm.h
>>>> index 56518adc31dd..a4ce4ad7edf0 100644
>>>> --- a/include/linux/pwm.h
>>>> +++ b/include/linux/pwm.h
>>>> @@ -26,9 +26,32 @@ enum pwm_polarity {
>>>>  };
>>>>  
>>>>  /**
>>>> + * PWM modes capabilities
>>>> + * @PWMC_MODE_NORMAL_BIT: PWM has one output
>>>> + * @PWMC_MODE_COMPLEMENTARY_BIT: PWM has 2 outputs with opposite polarities
>>>> + * @PWMC_MODE_CNT: PWM modes count
>>>> + */
>>>> +enum {
>>>> +	PWMC_MODE_NORMAL_BIT,
>>>> +	PWMC_MODE_COMPLEMENTARY_BIT,
>>>> +	PWMC_MODE_CNT,
>>>> +};
>>>> +
>>>> +#define PWMC_MODE(name)		BIT(PWMC_MODE_##name##_BIT)
>>>
>>> Why the C in the prefix? Why not just PWM_MODE_* for all of the above?
>>
>> Well... PWM_MODE() macro was already took by pwm-sun4i.c driver at the time
>> I wrote this patch... So I choose to add extra C to this macro, "C" meaning
>> "constant" in my mind. I was not sure it was the best solution at that time
>> either.
> 
> We can always rename definitions in drivers if we want to use
> conflicting names in the core. In this particular case, and given what I
> said above regarding the PWM mode definitions, I think it'd be better to
> drop the _BIT suffix from the enum values, so that we get something like
> this:
> 
> 	enum pwm_mode {
> 		PWM_MODE_NORMAL,
> 		PWM_MODE_COMPLEMENTARY,
> 		PWM_MODE_COUNT
> 	};
> 
> Then in order to create the actual bitmasks we can use a macro that is
> explicit about creating bitmasks:
> 
> 	#define PWM_MODE_MASK(name) BIT(PWM_MODE_##name##)
> 
> With that, the conflict with pwm-sun4i conveniently goes away.

Ok, thanks!

> 
>>>> +struct pwm_caps {
>>>> +	unsigned long modes;
>>>> +};
>>>> +
>>>> +/**
>>>>   * struct pwm_args - board-dependent PWM arguments
>>>>   * @period: reference period
>>>>   * @polarity: reference polarity
>>>> + * @mode: reference mode
>>>
>>> As discussed in my reply to the cover letter, what is the use for the
>>> reference mode? Drivers want to use either normal or some other mode.
>>> What good is it to get this from board-dependent arguments if the
>>> driver already knows which one it wants or needs?
>>
>> For the moment, no, there is no in-kernel user. Only sysfs. I was thinking
>> I would also adapt, e.g., the pwm-regulator driver to also make use of this
>> features in setups like the one described in [1], page 2126
>> (Figure 56-13: Half-Bridge Converter Application: No Feedback Regulation).
>> But, for the moment there is no in-kernel user.
>>
>> [1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
> 
> Okay, so that means we don't have any use-cases where we even need the
> mode in DT? If so, I don't think we should add that code yet.

Agree!

> We'd be
> adding an ABI that we don't know how it will be used or if it is even
> sufficient. Granted, as long as nobody uses it we could probably just
> silently drop it again, but why risk if it's just dead code anyway.

I agree with you. My bad that I added without having a user. I've just had
in mind that I will work with it around PWM regulator.

> 
> If I understand the half-bridge converter application correctly you
> would want to model that with pwm-regulator and instead of using a
> regular PWM (normal mode) you'd use a PWM_MODE_PUSH_PULL instead. 

Yes, that was the idea.

> Is
> that really all there is to support this?

Than and the the variation at page 2127, same datasheet [1] (figure
Figure 56-14: Half-Bridge Converter Application: Feedback Regulation).
Also, complementary could also be used in motor control applications.

[1] http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf

> Does the voltage output of
> the half-bridge converter vary linearly with the duty-cycle?

That's my understanding.

> I suppose
> one could always combine the push-pull PWM with a voltage table to make
> it work. I'm not opposed to the idea, just trying to figure out if the
> pwm-regulator driver would be viable or whether there are other things
> we need to make these setups work.

Till now I didn't do any changes on PWM regulator to check how it the
current behavior with push-pull mode.

Thank you,
Claudiu Beznea

> 
> Thierry
> 
