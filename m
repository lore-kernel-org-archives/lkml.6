Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 452C2C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7580213A2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 16:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="LNuRB0Rb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7580213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbeJAXDj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 19:03:39 -0400
Received: from mail-eopbgr80081.outbound.protection.outlook.com ([40.107.8.81]:59552
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725740AbeJAXDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 19:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL7w7QJbbVOr8bj9B0cLykJgzA8eC7efF8Ww53PSvMQ=;
 b=LNuRB0Rbb4aymjFJLnKbVJQi9XKZ5U3Sabnkz3ujoVc7WpnH+Zgv6aweG7QLrJP5HLyAqldzrjhPrLuUso+sigr9NN8MWD++0TNUqLIKXBM3fLDX1ngBHypwWGSfZlv7eXC/sS55IA1G0kc04t8LP5wImCTxutvcnlNbi8UTrf4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4661.eurprd04.prod.outlook.com (2603:10a6:20b:1b::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.20; Mon, 1 Oct 2018 16:24:55 +0000
Subject: Re: [PATCH v2 0/2] pwm: sysfs: fix exporting PWM channel
To:     Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com,
        gottfried.haider@gmail.com
Cc:     stefan.wahren@i2se.com, hsweeten@visionengravers.com,
        loic.pallardy@st.com, broonie@kernel.org, gohai@sukzessiv.net,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
References: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <517897d0-7320-253f-54d3-9447693e8876@ysoft.com>
Date:   Mon, 1 Oct 2018 18:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1538400237-28766-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR07CA0127.eurprd07.prod.outlook.com
 (2603:10a6:802:16::14) To AM6PR04MB4661.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7720b735-83dc-448d-4bf6-08d627ba6c86
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4661;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;3:P2uuuwccGjxL6a/cItetzZfp3sA//NmbMMEYlsH0Rt/58eq/a0BZv+heoVkGz1Fz1au404Fh1jtERxHqt/LBvCg2p2L/Xs7VZ6b6beJJJrG7dWHiEeqossg24YQOxoZMS73F9XKjBxVBvYEWwlGvdjD54NIXG1jr4uXHm/pA0nedk4ds576rPXkRdpmrYTA3MBqtcpuN8gQpmk+dEoICqIZQhFHAJSybJMGN9VK4T17zMihagW+eOeZAW7qe06qC;25:iRPUoiB5bgWbdri7aG7QMU+QQHH7V8+Ga4WYSrlyqggk4bpnfwsUdOWQeVyvSJS6a8HJ8bX1Yw8Xh0V2Ap68WHRn0BJS2P2ioAx3ZGVXF1pNISmUwyArC1VApAKEWXSR7QXWEIzrAH3toG/A0s4Ev5pSV3pP4T6wrofDz0xIJ1U6IJUu8y9G0uk8+v2yowR1nbMt0q67NWtTLbZ1DRQolabRGxaAvlSJRVOqkM8JMlMCSI9yraMHDvKRCVC9uSwS0mOC/Ojt+WfIvyxvdLq6EPxHsfYBoY21YyEFZSQw9UEeQfLKpybAPut9iFrHfHPuRc79TzLQdXGISl5hxe8cCg==;31:B6CDfPuyynWrop/72aqlyP3kNUP6VQmlmGB0ADZVpuAfs99ShXWJayHg9XxdvDQJQCZ2ZwVH42up9Dm0vFj1Z+pSxexYuq/cQrZWYqGr7/0X3FgK+m2L5eCRMhcwx7EXMoLyRnPOuvh/Byxx0PtXKC3F1uDIhWHddapauc+g9+91keM6BMa3NukDa2/BFKvTZbGcUeNOUMF6rXk70BcLKCeYG4JrlI1Oxq1wTsklMmA=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4661:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;20:ZQ6fErOfNecfpVhEK+Gj6Loa99qg6VfTpgInQnNCuBqzdTdvAkeAuT6sMvxjfquARBdt/QxwuS3aPv3V0INtC8gkmutLhzVnENSxoW6u0cXmX2u9oVKzX6sqy7PSqeGqmItwFDXz/ushOeuaNe1lHX2t+fCh2qD8KpIpWqs7UfARX8wzC+Wp6Seq+kUqRpZgsZXWjkcnKRI+HWZkbz0TGJL8iD9ASi0zgbAiTAsY75KQ9Q3nVlt6nr+Z1SGQuMbx;4:gjNi9LmDxmriYgC0PiVR8rrkd1JZkuSaQP1nD1ziohdYAWxiaQcdezrwBdUXAGnlUShI9rue+Z/ydu+beY8zw1bZuA8Jf5KuEl3hApUm9wzTCjPibG73j3JF1u5xcKrU8JHUBkWh0LoLCFvLoBqRxD8RxmDF9iRJ7prgbx+ALd+rWSWVhdlMIz+wBoPKFmREMWaVELyaWjlLtplNirJJAzyxkl1XpU3J7sYQJltjPKh6a7eMZZCYn3bd4WTr5FFGNI51W13roZq2XvAcSoeYiQ==
X-Microsoft-Antispam-PRVS: <AM6PR04MB46618130C3FF8787FE402C609EEF0@AM6PR04MB4661.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(201708071742011)(7699051);SRVR:AM6PR04MB4661;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4661;
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(396003)(346002)(366004)(376002)(39850400004)(199004)(189003)(51914003)(446003)(11346002)(68736007)(4326008)(6306002)(65826007)(5660300001)(64126003)(956004)(14444005)(7416002)(2616005)(476003)(47776003)(85182001)(39060400002)(966005)(6666003)(486006)(31686004)(478600001)(97736004)(77096007)(58126008)(8676002)(36756003)(575784001)(8936002)(305945005)(16526019)(65806001)(65956001)(72206003)(34290500001)(66066001)(6246003)(31696002)(86362001)(81166006)(25786009)(81156014)(186003)(230700001)(2486003)(52146003)(23676004)(229853002)(16576012)(7736002)(53546011)(52116002)(6116002)(3846002)(76176011)(26005)(386003)(316002)(6486002)(53936002)(50466002)(2906002)(67846002)(106356001)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4661;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjYxOzIzOkgva3REcnVyajZFWlFUd2lDb0lmcEF4TWhi?=
 =?utf-8?B?amU5TFFRbXM2VGh1azRHRFhYaDA5UHdmQk52bkRua1dSNHZtQkY3d0RodXE4?=
 =?utf-8?B?djNNeVYxNzJMZTZxUEpzdis1bG5kNHpUbTNhNVhTT2pkdjFSNFB6YXdCRnNS?=
 =?utf-8?B?Y1lNU2swUVdkR0F3OXFRVFYwY3lwUWVST2tpNVVLUlY5NlovRnF6dFluaHBH?=
 =?utf-8?B?T0s3Q05rWmhjYkV0eElUNjdWaE5uTnhleVRPTS9BZXRacWgvd25LQUFQQmts?=
 =?utf-8?B?ZXZ3cEg3eUJSR1ZDUmdaa2YzeENTZUwwTC9pTC9vL1JlZHFuVGd5R243c2RH?=
 =?utf-8?B?Sk1hRDNSUXJlUGtvamhuYVVwMXM4ajBsZFl4Q0tCayswYW5YN01DWUFKMDcv?=
 =?utf-8?B?SWpoNDdlZHRvNU14WVB5TkxLODF5djFzZkdrbzZDSmFodjZYVkF0MmhIZDIz?=
 =?utf-8?B?Vi9EN2xoMy9vNmhqdGdqSmh3Y09ENnZKSzFoRWdGenpoeUdlSVVGVDgvK0ta?=
 =?utf-8?B?NUVXMzFPaUtWOVlKSVBJbXZLQmFXWWc2TFNtdm01RWRjalN0em9JbUtwSE1M?=
 =?utf-8?B?M1J3WThLTTRPTk9qU3E4OHBJTEVzZ0p1TXViZDNqVUZLdEVhc0ZlQ3NCK2tG?=
 =?utf-8?B?K1M4eTZqQ2lhUVpDbHRLQnl5OXFGU3puZFVzWStPd0ZQOE1IbktHcE1FNzB3?=
 =?utf-8?B?THJDWXdiZXhHL0d3bHRDN0hHd3hDT2ZPM3pNcysrQUdDYUxhM1RLeVo5M3c4?=
 =?utf-8?B?YVdUSjJEcGUvMEc1cHVSSzFMT1BsZTNyc0NPek00bE5KSUJnM0E5QjlpL05L?=
 =?utf-8?B?bUZya291aVFRU0k0NkJxZiszZ3hsTEIxTWJFUUxORGpZcnhrbS92Z3lSSFVT?=
 =?utf-8?B?ZzJUOHI5ekt6alZKRkVVTXlEL2NwSHVKVjBYcVhMQm5hT09YeHdkUldob2o0?=
 =?utf-8?B?SmRVNFV3MjNucFVOb1ZsWTVGWXFNak1DMjdDdnhDOWNOYkF0UVkwdXNFeXNr?=
 =?utf-8?B?S3Z5WFV1eU5GZFkyb29VRzJka3UyM2REcm9NNW5ieWczbWRxaERLL2JKeG4z?=
 =?utf-8?B?THI1SjhMWHQ2Ymk2aU1udlNnY3BHWC8vckNReFNHZ0NZY2JiZmRycGJBUC9z?=
 =?utf-8?B?T3VzQ0Z2UTRzYVU2OUpiditycGp5UVlsRUszZEpsOVhySklISzhKRzJrbzJy?=
 =?utf-8?B?VUJYeVkwajl6eVRvY3NadzkzQ2VxRG0zSGRDTXdMbXJ2QVJYbG0vY0xjNU4x?=
 =?utf-8?B?NDFnWW5tSmRUa3hzYVU4S3ROVDEvRTRoQThCK0NxazV5bXlyT1B2TVhXanNU?=
 =?utf-8?B?ZERXbzhISUtiOGVSYnB3VUhMc0xDWTM1TnVBK0V2aTgxZnpnekZmWkI5WGpo?=
 =?utf-8?B?R01HQWRVQ3BkSnlwSndKVDgyd3RYSDI3MHhid21DQ0ZTTkdQMmxKU1h6ZGd2?=
 =?utf-8?B?a01wNTNMNll0SUpLWHBUTVFhQnppTFpaa1dEdTNZNlZyTWZyRVp1WTZ3M0JO?=
 =?utf-8?B?MjhqWVVWSDVrU21VVTRLVkFSaEJNVWZJZkN1UjNlVlBuVEhFaVpFQll3L3J4?=
 =?utf-8?B?UjZydXQ3emM2TXlsWXYzZW1BeVZyQnBQdldBSEt3dkNuVExoaUtiZE1KRWR4?=
 =?utf-8?B?SWN1RnhBbDBhUFdxOFJIa3ZJUlhKeVZUYlpIYnRPQ2dyQVg3MHV1aFdya3li?=
 =?utf-8?B?OHg0N1hVM2xHdFhuMFdwQ3Q3a1hkUVhaL0lnRkhaVFo1eHg3NWg3bzBsUTVC?=
 =?utf-8?B?TnFsVEdGZVl5b1UxeHE4Y0pHVnlhYjFIYms5SVdJZ2dDT240WkhuOUZva0tX?=
 =?utf-8?B?cVczQW5vZjhEd21kWnZxWXBaeXJuYmtITXJJdUkyY2c3TDNOOWNWRVJXNmpt?=
 =?utf-8?B?UXpJOG1DRStTNjRja2JyNTY3ckl6b0JIbVZTdW5uK0tHNXJjKzE0bGdicnNR?=
 =?utf-8?B?enpWSVBnTVVHd2VvaVJCNWZmY21seWI3TmZyU2RpaXgzZG5uOEsvdG5Pb1dJ?=
 =?utf-8?B?NUVoVml2MFBWZ0lVYlJrZXpJcEt3NkpIU0hZSEF5YzN1MVZhZlFHTGl1ZmtB?=
 =?utf-8?B?K3ZjNFB2U2NVaDh2ZHo5SjJ6YWFvandGOHlsSnArZFpKRnFaM1NsNHUwREk2?=
 =?utf-8?B?WHZjV2RkVE9TU2RSaGdRdEZkZy9IRUpCSGJhOENBcUJNRnR2YlIwTFpZd0Jl?=
 =?utf-8?B?NTdPTHFoZll6STdPbG5mK0VaQS9nPT0=?=
X-Microsoft-Antispam-Message-Info: 4AxXdPhlVTHByoDXC/hPZREM8uGBlzPBNs8Ya66inxcKBCIJyGFsckcBBHD4HJHH06Wqhw6IumydK/fX/Zx4oYqlU9T41qjgBOv7+zAdTFsTmUSBkz2SXQ98p/883Wh5iugnNZe48EhSnyBuZdu99oulXBaCeAmino33LAFZBwxJSnoRZTYNH/yt8150oG307iuYZ2Z8d7t9m9Zj2Y8gFMAYByz9bPr/4h5kSO0uvrbn6rTQbzWS4oKwm5H0Q/ZekoNUqsUQuQkc+M3IUhrwMeeuKlLKzn2VzXq+BIbKpDuiPolBtbW5ykzlkul1+tGM5timByECFKeXVrz4b75CTwchAuibfqshjcAcwlZFfo8=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4661;6:mWHp1HUqRsl2Zuyz/sUy9/0alxFPWjYh/e/fROxKSbnWcEgu4yvf61aJ9ewWq4RU19eA7f98gSQthlHmZH94BThWTo3IZFe3GggrsfrZ1UN/01QjS0U2CeEAG83r/LxMmm/4RWjemjtO94N07OFAFYAr8afx0wu+BS6yzzj8NexCamWZk9nrBkQzrSDBfE8eMFToNFbedjq4X1A9P2jIXqur6r0hIjbNLisLAJTPcqfEMKJbYw4xc5nHkEQT57ric9/vHdIAmiovHLNNIlcMBMj8ojhPYzWdKk0hpnESRMUPc9Ao9JItNKaAamQ3bcmc4bPGXA/pNyouVVlDjYFFhFA4gcxr8ZZJMqtfQ/VX9ObUy8gw6l47GV9awirDvNh1Myjy35sVwPmuyOz4WrYiQnmH9Hz0jrgEtbckchzT5CGIay37LiRCIlVLpqX01o01Mphl/arf6Dgd5O/q90ihXQ==;5:9JYrynedeR2l7absFRzQpOBodUqCO6Wli1Ibt80sq+iiWVVPs8xFmGq+OeKooXpXvnKvVqfWoRG6Bcr17hV6oOBcJ2FsuSteMx+7KlUXwIsqExMqtevnmDVHWfVD9gmDpuMjL+m10YJwrINxze8tBGMu3WoNFZpDoz+s0b+aRe0=;7:sJycfVZ1NkxviCbjNJiydAUZjJP0HqppozLCYA0fAO5w9OTcvCa9q6d+XKBHpXkwGyBch15gtphH35G9LB3Uru5lKSlbxd6CscEObIUKoYkqXBVqFI0W1pVpiie4x+bhHZLhRZguRN5YodCTHcT5ZeMAX4JCtSaN7AVxaCn6YubF4M4Tt1agkXDFBbbhBCjgMEhcM0vXASqPwf3qd5bZ267bJ7Ux1unjjNa1oThhlX/4ez2ZD3cZEb4kB1dBFaNc
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 16:24:55.2019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7720b735-83dc-448d-4bf6-08d627ba6c86
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4661
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.10.2018 15:23, Fabrice Gasnier wrote:
> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in sysfs")
> - it's not possible to export more than one PWM channel
> - ABI has changed, as a side effect. It may cause bad behavior as pwmchip
>    attributes are wrongly added to pwm channels and report wrong values.
> See [1] and [2].
> 
> One purpose of the original patch is to send uevents to udev, when exporting a
> PWM channel through the sysfs. This series:
> - Reverts the original patch.
> - Proposes a new way to send notifications to be used by udev rules.
> 
> - With this series:
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> $ ls /sys/class/pwm
> pwmchip0 pwmchip4
> 
> $ ls /sys/class/pwm/pwmchip0/pwm0/
> capture     enable      polarity    uevent
> duty_cycle  period      power
> 
> - Without this series:
> $ echo 0 > /sys/class/pwm/pwmchip0/export
> $ ls /sys/class/pwm
> pwm0 pwmchip0 pwmchip4
> 
> $ ls /sys/class/pwm/pwmchip0/pwm0/
> capture     duty_cycle  export      period      power       uevent
> device      enable      npwm        polarity    subsystem   unexport
> 
> - Backtrace when exporting a 2nd channel (0) on a separate pwmchip device:
> $ echo 0 > /sys/class/pwm/pwmchip4/export
> [   95.286558] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
> [   95.293630] CPU: 0 PID: 54 Comm: sh Not tainted 4.19.0-rc6-00013-g00b49b0 #151
> [   95.301344] Hardware name: STM32 (Device Tree Support)
> [   95.306833] [<0000c155>] (unwind_backtrace) from [<0000b273>] (show_stack+0xb/0xc)
> [   95.315136] [<0000b273>] (show_stack) from [<00092455>] (sysfs_warn_dup+0x31/0x48)
> [   95.323247] [<00092455>] (sysfs_warn_dup) from [<00092635>] (sysfs_do_create_link_sd+0x75/0x88)
> [   95.332539] [<00092635>] (sysfs_do_create_link_sd) from [<00125823>] (device_add+0x133/0x3b0)
> [   95.341694] [<00125823>] (device_add) from [<001059ed>] (export_store+0xb5/0x12c)
> [   95.349761] [<001059ed>] (export_store) from [<00091911>] (kernfs_fop_write+0x87/0xda)
> [   95.358150] [<00091911>] (kernfs_fop_write) from [<0005beb1>] (__vfs_write+0x1d/0xe0)
> [   95.366295] [<0005beb1>] (__vfs_write) from [<0005bfe7>] (vfs_write+0x4f/0x7c)
> [   95.374053] [<0005bfe7>] (vfs_write) from [<0005c0bf>] (ksys_write+0x33/0x70)
> [   95.381708] [<0005c0bf>] (ksys_write) from [<00009001>] (ret_fast_syscall+0x1/0x58)
> [   95.389682] Exception stack(0x01bcffa8 to 0x01bcfff0)
> [   95.394946] ffa0:                   00000000 00c4883c 00000001 00c4e590 00000002 00000004
> [   95.403639] ffc0: 00000000 00c4883c 00c4cbe8 00000004 00000002 00000020 00000000 00c4d008
> [   95.412223] ffe0: 00c29151 00c4cbe8 00c17833 00c13c0c
> -sh: write error: File exists
> 
> [1] https://lkml.org/lkml/2018/9/25/713
> [2] https://lkml.org/lkml/2018/9/25/447

The [2] report came from me. I tested both patches on my i.MX6 boards and
it works just fine. Thanks for the fix Fabrice!

Michal

> 
> ---
> Changes in v2:
> - update revert commit message
> - new patch 2/2 to propose uevent notification (change) on pwmchip
> 
> Fabrice Gasnier (2):
>    Revert "pwm: Set class for exported channels in sysfs"
>    pwm: send a uevent on the pwmchip device upon channel sysfs (un)export
> 
>   drivers/pwm/sysfs.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> 

