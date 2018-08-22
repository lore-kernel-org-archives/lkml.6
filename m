Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB3C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CA98214C2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 07:03:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="iBYP96r5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CA98214C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeHVK0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 06:26:41 -0400
Received: from mail-he1eur01on0053.outbound.protection.outlook.com ([104.47.0.53]:10688
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbeHVK0l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 06:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tu87YeRyFYy6b3pYQu9idvefbk4OR9TUkpcmk0Bv5Ck=;
 b=iBYP96r5Ff1DMxAqkUHMpXw8gv+brDq3W3tJCXFeLQscIjqoQqTGsUEl3IQoJg/eqCYum3IsF6rS6knClRiRbLELpkZjuzedbML2/MjwhbtWxDUjKK0KWkJlmsx4PNq2UQdMoB3Q2kuLIcKaXo09Ovn4JhbOWxP7kyc7qHw3OxQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4658.eurprd04.prod.outlook.com (2603:10a6:208:75::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Wed, 22 Aug 2018 07:01:54 +0000
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM output
 between PWM and GPIO
To:     =?UTF-8?Q?Lothar_Wa=c3=9fmann?= <LW@KARO-electronics.de>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukasz Majewski <l.majewski@majess.pl>,
        Fabio Estevam <fabio.estevam@nxp.com>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
 <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
 <20180822081436.13d8f55b@ipc1.ka-ro>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
Date:   Wed, 22 Aug 2018 09:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822081436.13d8f55b@ipc1.ka-ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR0602CA0018.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::28) To AM0PR04MB4658.eurprd04.prod.outlook.com
 (2603:10a6:208:75::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2dbea44-9aab-45ca-8bb5-08d607fd24e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4658;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;3:EopnLNxegc3wCqlERUKA5AD9xPOVTFv1DHBQn2kNqHAyJ5/SK6P5VxC+HKkriOq0IgI6CwrpG/L16ec4cbOV01Uy4U8lmXuftWWIAnmCGOHuXHB8V+XodQHAeHj9HmwSB7YSMTvbpyeXeFLki1SMWYq1nxPItRtPkAh5xnmZF0A4mW4EtFAZZHKc7Q31EzFSFP7C+eKHhVvzgdeYwIhZB+Kc65gVy0sIbPWv98nNkGQjl3+Qn3TdxrXMk8nYHWFH;25:a3umouOk4ipK+sX0HNgU3u6m5sqxISs1Xu6eUJ2MFJglGrV9oX2By6mpY0PLMhlF19WR3BP214iBtKlk97XQilKPL0nzKNJvhc0IefluayyI0UpvtGp+qA0H70R9vxIZ4QMvXCEz7QyOzgb5i+JvCB4AQmUW/csofQ0oVqw5RjJ3nk7Sxer3wn8DWnSrk+ES8cAEWPMWlQBtfzrxC+JH1P5Ywg4cTmJvcTJuN8MgLgCqTdo1flv66b1RjQy58+D8b5k+v6Cp8osIdGZsubuMXRMxrV+8d3njVQfmFnYPyqYeO1P4IfQTlC0e5kjKWUgZ/3FNNvKe/ioWtm9CVwK9FA==;31:i0AXxtZPHYLm7Vj7Ehl47Bzab0u/gEEdWELjO0jGr5MH6nayhwm84382UnhQNOmUQsu0duDdFHitH0qTpgqmVICWk+qQtN7nlLJ9QxAiMy9kmJiFg3xvyVAemSSwK3PT2MHx8Xu63jDeUsgTckWjM487btCgEtoSsWulhHG5/ZJKHzQw6y2NnhZuQhu3b5cb+WhVpoQBLAcFslufiF1r380qaLqzVZNDrbkv+5R7O+s=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4658:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;20:94nSDbiK8MGs6cjnwrF2TJ2G5/ovyzNMH5Kz9E/1cYSfZ30uMYDjn3mgql/KimIa247uUSClu6AEpEca4N5/mHjcwn3EENpuG5mT6UIr3FFpVMjAAKkkmG6v3ntSJL4mzS4EJaUEGewUyMFhL+qmiJQC5WwiBWM0ORQRBfk/I84cJW4I7wrjGn0s0Y99NwB8yu32ihyK7coSz5cnc1csx2/QpJTgRhwpvXlJze0gcd5Tkp4aWn3boOnV+a9b4WVj;4:aQCbMdj17YBRh+NOgpB21XGIJZA/HAep9SPOLt6wlElltWPic/DkSGI+2hqJWzBwI4vl3RL2nlFCvP5DCku91419sQIopLkHAdZgj1B36wm7+6fEqyR8qL6F5oW7lK9a99nJCJokD3MstpZYEEoqsZ6ZwRv7qEc5PxsmcdXSKj5zXPuYVJBQddhcGg/15gLQcBU1MUEF70eNigil/AehDdWJkCWTBdkXIKzzbYrb6+cBk4fZKKHgXnDFWGEK4k2seOEuVdeWgn9CzR1+Px7VqA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB46589ACB3CAFF26868676FB99E300@AM0PR04MB4658.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR04MB4658;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4658;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39850400004)(366004)(396003)(136003)(199004)(189003)(4326008)(2906002)(956004)(65826007)(39060400002)(72206003)(386003)(5660300001)(229853002)(53546011)(81166006)(478600001)(6666003)(26005)(2616005)(8936002)(8676002)(23676004)(76176011)(77096007)(52146003)(68736007)(6916009)(66066001)(486006)(52116002)(53936002)(476003)(47776003)(7736002)(14444005)(2486003)(65956001)(6486002)(64126003)(97736004)(65806001)(25786009)(2870700001)(305945005)(6246003)(67846002)(50466002)(85182001)(316002)(217873002)(446003)(3846002)(86362001)(31696002)(54906003)(58126008)(36756003)(31686004)(106356001)(16576012)(105586002)(16526019)(81156014)(11346002)(186003)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4658;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU4OzIzOmYrclRBWTAwVHVTUlllT2hLLzkvT1k1THU3?=
 =?utf-8?B?MzNHYmxtQS92RVFYd2NCZmlkZk1RcFU5SWJ3ODNlQmIzR1hLa0Y1RFNMUEpx?=
 =?utf-8?B?RktSWEEvZVpiSDREZ3ZOMmU5MG9OMVgvdDdLT0NKbXN2UVRvanZKUUR3LzlG?=
 =?utf-8?B?bGNmdFA2UlMyRmo0d3J4THp4NTNYTUxNZTNQOWtoZXFxZjZWN0NJV2lyYkxu?=
 =?utf-8?B?REcyVE5zUTNLUmFtNW4wSXB2Yi9WUFd0VXVuay93Z2tXR1VPcWk4azFtYjEw?=
 =?utf-8?B?NWhGclJrM2xKeSswZ2xTSVgxTzNIQmFJKzVCSDUxcEZMclp0VDJpY21oSkQ5?=
 =?utf-8?B?ZFJGa2FVeHh1VFJoS3hlWVgyaXJIVCtuK20rcXhyVjM4WlQvU2U4QjFJQ3li?=
 =?utf-8?B?cm90RThTNzZvUjlSOXhzUVZKazBLeTBVZURSaDRjMzUrNnR4eTZDWmtxQVZG?=
 =?utf-8?B?R204amRMVGtXOUc3MXZHdndTSWNoZFZGNll5M21MQjdIRjg5eFBHeVFSWnBW?=
 =?utf-8?B?YUlqVHZUUTNUZGNSRTZXYzNmUFJ1Wko4MkkwMWdKN0FXNHB0MmJiaG1IdkRJ?=
 =?utf-8?B?dkJqNit5cjd0VUVWUHhPOWtwUnRvRmpiSXFSSUFGNzVOY1dncVdZS2lmV2xr?=
 =?utf-8?B?WTJEU2grR2xOaFV5N2xLV2VOL04vWkdsUERVZXl2REJGaitqV0ttTUVQUTlr?=
 =?utf-8?B?Z1NzN1c5SjQ5b3E2ZmlCeDJhMUIraEJZdTNucmVneXpkb3QzaHBYNHM2RFhs?=
 =?utf-8?B?Tm9Hb1NrckxzY2J6SEFCZC92RUxMZUROaS83MUp5MGN5c3BNZUxTZ0swOVVE?=
 =?utf-8?B?N043S3hzMGE4OHNqdkZ3aU0rWHAzdm00d3MxMnduS20yTkFHeGY4Z0NHd0Rh?=
 =?utf-8?B?NWg2R0dDNXdRbjZvbDJKWTMvZi8reDRlSnQ3WDRqZHNYbWJ6UG45Vkd5VjF1?=
 =?utf-8?B?TS9VYlUyN3VmZTFUQys5L2RuZ1Z5T2NocWJOU0FwNnJQR29zZXpsYlZtbFhF?=
 =?utf-8?B?S0Jock1VZWlhZnJEdEdFek5JdmJ0b0J6bEFabkd6aEhnL0Z1aXlCbGRCM3Vq?=
 =?utf-8?B?Q0c2Q2lML1UyckFic24rNmZpKzJ0OGxYUXdPaXNFTnBKcm9qV0RZQkRkclcy?=
 =?utf-8?B?WlVkUDBZOURqUTlvSEhWdzdreklvcUQ3c2xKM01MR1dpc1BGNisvdUk4bWVC?=
 =?utf-8?B?cTZneU1pSG1ycy9mWDNlQmFZcFRqTVJFcGpOYkhGRkppNnhEOG50VDJxdzRs?=
 =?utf-8?B?WVZwcDZCY2s0VWM2RURHLytCbVhTUktUVDQyZVVXYUNJa3NUUmNUMENQemc4?=
 =?utf-8?B?UEZ4Vk1wdnZ0TzFNbHFQbE9BSmF1QzBDblpTWGhvVWZwN0dRRHNjWi9mWDNo?=
 =?utf-8?B?SHMxTkk0SHVjaTBzOGwxeHNLUmhObExvdzltUVk4cWw4WnJZeGNILytIYlFm?=
 =?utf-8?B?N0FmZnVQZFlQN3B3K0crcHlkSjBGejA1NlozTjhicVZlZS9tNEIrekR3VEhy?=
 =?utf-8?B?bkdVSXpadll0cTNGcERud2xVdTlDZzhJNVNqZmtCWUNoQ0paeUZ1R2dZUC83?=
 =?utf-8?B?c0tmcVNscnVJcmUwZ0lEOUs3SThjNzJpWEEyZVkxT1kyOTZxOVFwZUJacUpn?=
 =?utf-8?B?dzNCVGlDSkw3UzJ4bzhPRUNtN0NMMFRwZ3dRUzlCcytQd0tVZDFUSXJHamVp?=
 =?utf-8?B?U0g5UDRDd0R2OTVFbUJUMmtRTXlQWmJHRTA0b0ZzZzIwdEZwZEpIeElMODNk?=
 =?utf-8?B?NzRTSVRiUVJ5dU54TWxBR3N1MEVIRmRzUzNobWY4RVFQazA0YThJYi84Zzhj?=
 =?utf-8?B?eGZtemdNUzRaU3ZpUE1HMGxGaHcwRG1nYy9JQXNWaXVPVmhWMk5UN0VHRjF0?=
 =?utf-8?B?NUkwOGttdWs1MG05UXpzUW1RRTJRQWp4bmFjNHhNNjZ6aFBncjBGbG1CMFdS?=
 =?utf-8?B?Slg0YWFZb0VZU0JEcWRhWHVHZExhSEZtREtwTTZJTlNFRkVGNGlUR3NPRnZZ?=
 =?utf-8?B?U3BjV1EwMW9VWE1PUXp1Y1lNa2tYUytMa1Y4MmFCVDZ1T21iOEg0RHppUnpG?=
 =?utf-8?B?WkNMM1czZXllZjNUVWYzTUt2RFRqblhweWVZTFdrRHJDYXdKNThwTUd3dDRQ?=
 =?utf-8?B?a1E9PQ==?=
X-Microsoft-Antispam-Message-Info: OPQ2wsoPLL/xvGvwkuU7FxjDGA6sM++NUfMnXP/ALbKVbo4UAC3j1G43mxihXGF94v4Rj5j4CQnSDJi6+I/CVQ/kMgevYfxU1CNHlTGMYJoycUrNcGbbpOTbd1Ip9OZeEenukAyQD+v99pr64QtOqEx3ihM2Ocgm3p3tvBbCJ0/j8Tj8nml86N5E9t92HL/MSDChfV3CI3z1U0/gqSmRWeU3iDF8o6BCfHhk+1BdDeguQ2sx5KDJsUfCHo2ixxhCZkLqJmsujovD9rdMVe5idq/IQ0q33ZMFxJlYMCOg3B4R40rGRWwE8wi3/BcZAq3OzSrCFZ0bmIq29e2wh9RDH4f0gEywPSSZz5jZ16HRQ0w=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4658;6:NVV2EcQy8cQd+E0le1WnyGRiP4TL6SxVOxogFJ846z2Ejkbca5RvkbRR5LGegbG7Yn1wr1bfujh/LIgO3keF5LEpN/pBwc7tCWQ5x9X58aX6zqV8hSNVbbY73QiEqfr/VdTMOYHdSejuFEKVCZ5jtkLf130xjq52mbTen0GuKVckPPKwHD0UXTmb/nS22xisbkUGYsUf2suQdQwHMdbs/ZA2yg6a/pmraGbWtBzrBlwz1tJP50tChZLiAiC5RK1EED6ZhP8gpu9wFRTOFQyPHmcon14Z9aY6RoU1oDJUya1VB0Pxk4E+ShAdPPkVtGrqLCzAbt8A1D4Tcpz2u61OzH0Gt0MVg3CZo/URi8vZXcNA56/HGBwIMFjnmKU/hENa8A6oBrTQGsgAKXsNtd3MgaTQL1KGthlnaMt+lvbyHH657iZw845dGyAR1qzZJGcMQv8RN5h44MWx3NAvZ/4GQg==;5:AVdCrztEaPq8avcJuchIB7oDr2KUZaF3XdUh6eoX0FIerzFqYcx8vU6Uz/dr+aqQigOz8ORVrGxC6mCm2KUR/f4dPXNKo8132VedRy89HxsNAdz1aNqI6rg06jB3U5IynsWv5g1LOMgAHgEDkC1JH+INjHv3/qiANW0UzWifcY4=;7:QRgPxagPDJa+qRN9g5p4+p5hxYDiwFgdeH0OyColDa8xHBaRu7aa9VX8o8a0jCEkbc1QhqMuLZo18gsd/KHWbgLs7xTWvEDohVT28twIFj2G4VyCagf4Pakbggxeerp+eSoYg7S7+tvD4zaVOJAFeIVkN9v8oOXGZ9tJNsStMUDINcL5B7348YGjZZ8gck7/Kj/KrjuxwGt2dnecFoQE8tF+0QmXFIQiUe04S8Io3WNY0uJdo+vGwiaC/doQNrrL
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 07:01:54.0644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2dbea44-9aab-45ca-8bb5-08d607fd24e4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4658
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.8.2018 08:14, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>> is disabled. This can caue issues when inverted PWM polarity is needed.
>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>> on the output. If the PWM is dissabled its output instantly goes to solid
>> zero which corresponds to duty cycle = 100%.
>>
>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>> with pull-up. Then switch the pad to PWM output whenever non-zero
>> duty cycle is needed.
>>
>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>> ---
>>   Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>   1 file changed, 44 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> index c61bdf8..3b1bc4c 100644
>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>   	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>   - interrupts: The interrupt for the pwm controller
>>   
>> +Optional properties:
>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>> +  pin to gpio function.  It allows control over the pin output level when the
>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>> +
>>   Example:
>>   
>>   pwm1: pwm@53fb4000 {
>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>   	clock-names = "ipg", "per";
>>   	interrupts = <61>;
>>   };
>> +
>> +Inverted PWM output
>> +-------------------
>> +
>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>> +output, the output level is always zero volts when the PWM block is disabled.
>> +The zero output level is actively driven by the output stage of the PWM block
>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>> +a PWM client (e.g. backlight) requested.
>> +
>> +To gain control of the PWM output level in disabled state two pinctrl states
>> +can be used. The "default" state and the "pwm" state. In the default state the
>>
> The "default" function of a PWM is to deliver a PWM signal. So it is
> more sensible to me to have the PWM function as "default" and a "gpio"
> function as alternative state.

Yes, I totally agree that using "default" for PWM and "gpio" as the
alternative function seems more sensible. That is actually how I started.
Then I realized that that way you end up with the PWM pad set to zero
until the first call of imx_pwm_apply_v2 where you can select the GPIO
function. On my system that first call is made by pwm-backlight more than
3s after pinctrl init.

I suggested to use the "default" state as a GPIO function as the only way
how to get a truly inverted PWM output all the time from power-up to
power-down.

In my opinion it is up to the DT author what pad configuration he uses for
each pinctrl function as he knows what the HW really needs. I see that this
approach is kind of controversial but I hope that with good documentation
this would not be a problem. And as I wrote in the intro, it is absolutely
optional. If you do not need it, you do not use it.

>> +PWM output is configured as a GPIO with pull-up. In the "pwm" state the output
>> +is configured as a PWM output. This setup assures that the PWM output is at
>> +the required level that corresponds to duty cycle = 0 when PWM is disabled.
>> +E.g. at boot.
>> +
>> +Example:
>> +
>> +&pwm1 {
>> +	pinctrl-names = "default", "pwm";
>> +	pinctrl-0 = <&pinctrl_backlight_gpio>;
>> +	pinctrl-1 = <&pinctrl_backlight_pwm>;
>> +}
>> +
>> +pinctrl_backlight_gpio: pwm1grp-gpio {
>> +	fsl,pins = <
>> +		/* GPIO with 22kOhm pull-up */
>> +		MX6QDL_PAD_GPIO_9__GPIO1_IO09	0xF008
>> +	>;
>> +};
>> +
>> +pinctrl_backlight_pwm: pwm1grp-pwm {
>> +	fsl,pins = <
>> +		/* PWM output */
>> +		MX6QDL_PAD_GPIO_9__PWM1_OUT	0x8
>> +	>;
>> +};
> 
> 
> 

