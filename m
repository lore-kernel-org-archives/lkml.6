Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB1DC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B42214FF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 13:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="g4gb/wU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02B42214FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbeHVQpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 12:45:24 -0400
Received: from mail-eopbgr80052.outbound.protection.outlook.com ([40.107.8.52]:19456
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728886AbeHVQpY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 12:45:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YaEW7uqRPBQKiyslfJFshCLosPnWPP306wH1+cAyv9w=;
 b=g4gb/wU8g2uqlI9bpeto3fo5l9FgcHXKms3d+mqCUGN6GcA5M8gkdwqOKBqy7Ybr+CTICismtMV1AOwncG9tSHOnMqvnXw6brLFw+5Unbk2wC8ML4EQ7nl2v+nzMJ56meyFFqYZ5XaQjkhXb5X1ymwbnNewM+Dm8hgB626Pdcok=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4660.eurprd04.prod.outlook.com (2603:10a6:208:75::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.13; Wed, 22 Aug 2018 13:20:23 +0000
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
 <175003bc-eae7-1b30-ebfe-b56ffc58705e@ysoft.com>
 <20180822131758.162d5351@ipc1.ka-ro>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <18b4a847-bc59-4450-331a-0b17f27c97a8@ysoft.com>
Date:   Wed, 22 Aug 2018 15:20:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180822131758.162d5351@ipc1.ka-ro>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM0PR05CA0006.eurprd05.prod.outlook.com
 (2603:10a6:208:55::19) To AM0PR04MB4660.eurprd04.prod.outlook.com
 (2603:10a6:208:75::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cf18586-f02e-438f-a634-08d608320485
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4660;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;3:3DUebfq56F2PvAqeqVQx/xZXVD4JILIjGf+qS2HdSgCbI9XO8Qy/3i9+A9JJePJyEu4WsoVmjU16ewJPNv8B2JaucuthN24TqouT8CcvmHbl/pG3E+jz7UIj6rnKbWY2GE74RvXGbJKDecXNSqJfVUwsbQ97f7CJkV+jccwxdYaX1mittcy8IusVJVGzAPXo+B3di5BKIRcee2Z1VWa8bwEhmV2ANZGc5EZuyQb4SXG2A8N+573/poJHa8Df3f7z;25:SC5UaHEQYhKu01rDBN/7NJmW940UiH/reNbIOzfBWbu+pVRfN1EI8sS52aZgQgnucyiGN0V8oqiHXz75Vi48QSJAy6irlR228+Fkvjh3ckq0pf8tzmxu3ccLg9IotzewW4kAOkduNT/G/Og8xG8DgrlVO+cpW6Qnvg8rJmCblgpi2OK3RHQ/pTjROkIDOMw1k8iRSEJ3DcGhKGHk4D7dnL0GzDYuUXb5mcqdRFNwS+6APnoRTMbWp+RG3qqZqtAHmBteVUlR4QvzOEQEoScp4I2Kllo/Lo/Gc9ep4wRHiK8A4wgpXuLGn/kTyoFk7Z4iba1zuNqlqLMSqMuufkn2fA==;31:kuLyWNSFsL6NaUTo0kPp5aAEEYmkUSCdprxmhICD3FhC96YZZWyyJ4ckZMc3zJRBBKvnO1Zv3m4QHYTF3IdiMi6m+1RG+G0cbOWhN145AropA93PDkjvBvh3M4Te64dGj3w88HxWdXQ5EUkUfwbCccl/Hj8c+xefY6afg0LBffvNekOjqMJizkJmHqK6fs4Txpr64y3POpBpq/162mngwSxhCVyksrDbjcbz20EID+k=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4660:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;20:G1PjsM74J85j1VrVnpxqzWDR7HWEGsG+ooil1Z0QLTuFs4NxkMfukG97jCS9RVhwpiltxLYThJtELQ5drQvtgi/wqC8Lid12TzGv5LhPmxW09qQEpb7ysern2xzQaSO8sGO1chWXCkozzcY0LfDV4ST05B693Bgn/1w6XExvZo8KBk6ew5v3ZnOkTINpbICNf28OIAQps1NbRt1OSrSQ3qhOgc4KeWkDY2t0s0xyk2Xqky3c9NYenl8cHE3JsXWh;4:L4Ij9fadYYf2pzB9LtLOXa9FmU6yspjlheu5EJ5fGj2lliSDCiSMFyPeYG4P75wjBtaEq12DMyKR5sNTYvLooh4cV16DD8J3h9gSMjKBa/X9LUo4+7P85Y36h1gjWcJVZ5zyM9mDKZ7u4YSbqovPzWME8Dvlio8XccV6INW4IBRvZbAYXPD3g6VGzZNLv/4iu4pOntKqVExz12mPnomsS3i2fLIFv60FF4zXGDZYFout8TN+2wE9iBt8u1QuhwR6ufGtLd9q/EuYma6QmyF1rA==
X-Microsoft-Antispam-PRVS: <AM0PR04MB466073046F3E1480126324FD9E300@AM0PR04MB4660.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM0PR04MB4660;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4660;
X-Forefront-PRVS: 0772E5DAD5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(376002)(396003)(366004)(346002)(136003)(85664002)(189003)(199004)(54906003)(16576012)(486006)(316002)(386003)(93886005)(53546011)(26005)(186003)(106356001)(16526019)(58126008)(64126003)(67846002)(77096007)(5660300001)(23676004)(2486003)(6916009)(105586002)(446003)(31686004)(52146003)(52116002)(76176011)(229853002)(956004)(11346002)(65826007)(2616005)(68736007)(8676002)(305945005)(6246003)(85182001)(7736002)(72206003)(39060400002)(36756003)(6486002)(2906002)(2870700001)(53936002)(31696002)(6116002)(4326008)(476003)(66066001)(65806001)(97736004)(47776003)(65956001)(8936002)(3846002)(217873002)(14444005)(25786009)(478600001)(50466002)(81156014)(81166006)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4660;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjYwOzIzOnVsU0NHcnAwMkgzKytURU5iTzZPVFlDRVZK?=
 =?utf-8?B?amdGdjBNSm1WNkFueFZiYUMzMmZjRW50S0h6TzBQRFhoV0dWNWtOZXZhMkxj?=
 =?utf-8?B?V01YcnNVSUhyQ1RONllWVlZneHJUUkMwaXdPTCtFc1BUdlBaZ3FOdVh5dGV6?=
 =?utf-8?B?L0hiVGJHODQ2dTN0OFp1aFJHUGVBd1RvVGdhTWxmeDVuU3F3aTJ1NnE4SVJS?=
 =?utf-8?B?R2dJUkVjcEZoQ1ZGSnRGUXVTWTlZb1JmZko1TEREbjAwczFXbnNlVEdLMy9I?=
 =?utf-8?B?c0Y5cGlPNldTdEcrajBDTURPaHJkcE10ZS9qWFpoZ1JES2NiVm8yTzlEY3JD?=
 =?utf-8?B?ekoydDNWSVBGcVpmOXpXaHRSb3lzY2NxdjJnREVuVmt1S0xRalkyS21rTnBi?=
 =?utf-8?B?WTk1T1B2cDNRbEMvR1VlN3BGNTJMUWttRW1ubm1QaFJHNFY0bTY0azFmS01M?=
 =?utf-8?B?d1YxZ0JTY0JQRTFrU0ZMWXI3N0R0aVlRdG5Bb1RodzBNR2pmZ1Z1ZzlJMUF4?=
 =?utf-8?B?MTRJQ1pvc2VwWE4yYVVSYmU3Z2l4NzRqRWlBQUlWMmMvWS9pM0R4bmdhak1V?=
 =?utf-8?B?QTJrS3lVVEk1S3hmQitZZEswQnBjV1cvU1kzYnFQQWJDTkZqZUlFNG56VVFa?=
 =?utf-8?B?TzJzQm8zRm0reERjSERDdVRRSkwybGVSY3VJZEM5ZnV2eXJNQ3FGWUpwVGNT?=
 =?utf-8?B?NjlBeGF1ckorOWZQYkExRnc5aXVjdG91M1owNVZ4ZHRmZlJlcEl1eUJ0clc4?=
 =?utf-8?B?ZFF5eEgrNTd1WUNlNWRGdnlKM1JGS2VhVElKM2FtVFhTNkU0RERlNFNVbXN0?=
 =?utf-8?B?NXVxcUdoM0xiYVIrTDhZVHB1OWxVVWhYeEhYWUJPSXEvMjh2ZWM3MWNXbWFL?=
 =?utf-8?B?OGFEL3QySThpenREampEZ3hwUkVpWmJRT3ZUS2pnZDZvZUE0NXU2UEttTkYw?=
 =?utf-8?B?bG9FTlVvbk9LVlkyK0FmWTF6UzNVSURvc21menoyRVhabW1UZUhJaG5RTy9X?=
 =?utf-8?B?K0tWSm1MNzlSZXVqbGN3MXZiV2lOczZOSUlWTkdOWW9Bb3duQ2xwRk12bTRZ?=
 =?utf-8?B?MlFEZVY3d3RaU1ZWeEtvOWhvK0dSNjRtY2tHSjNySDdBZWxCQndPZGhxQktU?=
 =?utf-8?B?amJQUysvNUJYWkt6UzZBZ0dxWlZ1NEZkY1p0NFpDVXBBVTF2OUQyeVhmeDhP?=
 =?utf-8?B?VkxVRjBIMVlHc1dkVDk4VTFPWHAyMi9oWmgwcm9meTRaN0ZGcnB0cG1obGN6?=
 =?utf-8?B?SkV3alM2cjBMTFA1bVFrTTV2WDVFMDFMMXpBKzNwYmxTaEc4d1hCQm5ySDd3?=
 =?utf-8?B?OU9XRkpFNXFVckJsRW9jMTJIQjVtQ1IvR0QvRGYzalpPNmpsQ295R1ZDVUhK?=
 =?utf-8?B?YTVVeWlRelFXWm00V3A1VUM2dnp1SjdNeFNlK1lnR1ZiRkVIRHJNZ1FWSkh2?=
 =?utf-8?B?czNiQWxRTjBNVlVBVzZHSzhISTNwM2dUekIyVHphZk5GaUpmZmxZaFVnRm9B?=
 =?utf-8?B?ay9SZnFoWHNYbGVjMjN5eW1acVFMdUlQMEcwcElKM21EMmxDbkcrbDYrWmxG?=
 =?utf-8?B?ZW9mYzMxZVBacU5sOCtiY3NLekxGYzlHaDVIRVJlaVhEamlkd282SExGQVRr?=
 =?utf-8?B?Znp3ZVNlZkpoNFhjclJNeWdESHZyK3ZpRGtORCtEeGNHeUI1bXpkS1IwQ0hv?=
 =?utf-8?B?Z1lCSFRQOTE5ZFdxQW5uaVdHT0hqYVg4akw3d2o2MnhYSlJtbDc3U1VkOWRl?=
 =?utf-8?B?a28zd0xKWStrTytjLzhFWFQxN2FlT1lhcU94OW50MnZPMW1BWWl2M1FjUDZt?=
 =?utf-8?B?aTFxQXg0WXlnSmZyRFdXc3VVN3M2cVpTUzMvR29MSC9ULzZmVmdJOWpkbEph?=
 =?utf-8?B?a3dqWDNuUkFWSHNiMndmL0dJL0JoMm1pWXRYYXpnTm12MytQL3JlbEtGNWFP?=
 =?utf-8?B?S25JL0I3U2xjdlV0b0xNY3Z3cy9VZndzbjB2cEk1b2xaQml0SWRtUkRBMmtp?=
 =?utf-8?B?NnZGdG5wWDFoaDdLcGNkS0htNURxblpkNTlsTmNub2J2aXM0NUpWUXNOSlJq?=
 =?utf-8?B?VlhtZSt1cVBkaFE1QTUvbGU2NXVIWHQxc3B0SlEyTDkzRjRnTmcxdkJDd0pW?=
 =?utf-8?Q?rLYwMGTphtktxKwZhyl3LtkxornlzuGdlmSp9E+dn+Ob?=
X-Microsoft-Antispam-Message-Info: Ov3VUNr8CRYjNxRZJF+M2MOaQai4X7mDRLKeBiiVEFfYJ/PkMesE3C4DuQFhPLwcIlK6nl2YFmAzvfeBK2R/TWs950GoPupkDFnKHYZa9nKKoVQiU//JB0k6HZJdy0ulWOWzHVB44UUvlh4CxVjCs+/Wp8RH+lqKCLcqZwYzcuBQra7eN+DRn5BGaf36myCsGrjvV2gcP5lUWPYUJWwiZBeYKWyO74VBcLsWsL6ZeMw56I99QUlmGN/WKB/k95ImDY7gvIYVXv1HUJPZVo1uhqxOU6UpcZNt/f0k1bhV03keEcDb6upEUZqvXeNvjo6kYRYJDV+DHTcc3L86D6GF/RRbrWIPd1VlWkLqoEQRwSw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4660;6:0JTS6VRE9B937o4XCzli6OrEgLHyokBZZoFjk11JGytcMv+UM7KairHGDT3GakgqI+lyucOK8Vx2xdLey89rPt+XE0KDDQ2q/sCIFtFH73/kaEAduuIfjVoCDChU8DX+imEXjHrLGFaVJuYBvfp7lt7FbJROWXQqd8QB4/7A9vw4MR/GHzCSe1i8q7h2/BhiIZyFSb4YvBua8hYpUHSG1ykkqBSd2DkDpb7Fr1Cr10IWPc9DDyRqisSjcNPo6NQbqnY4EfLBmENFKb5L4uSNcPX6dqpInog1PeH4ZNH7bwJOrX7xY1V3TakH/7w6HaAF8IWxxHt00xXiwKYHiS4QqvGHTjfDM+1roTxTp4LZLqOZ2fT/TpbAJ1pkFjne0aAoRPZRR84j4yzb/sjU9poagfnqwv0liFwzCxNQYAOmQn1CwJY+d9GoQyp6+6hGK+mrqHuo1p88Zy9jMcrBIM7C0g==;5:s85QQ0eTTMvDgUNj7oHnUwmeilthQ0F+tmW6MltUHGDR+KNH3h6iHaQ55Gnq6h+rMzO0oWzPgjU4UrHYxBmqBCn2mNv/FTW+3WiUPpa+JIyDU5U+FLJlSBuPXP0TSAZ9altULsU2MKw7bMJLX+nz3aLFz/a/q5DnBhPdeFsWlVo=;7:xBVzGepJxxgxaCIfPZRT14DWZVjU5LnsmrIskOfUUbwrje5EEeoDCS/rnJkWkvhWF48IKnE7CF7YwfZ70FyBEzTnURE5J6WPxbRuUOZrmqiuanBAx/Va5ETNbQ4RXplpKp1CEyzn2kFhQWykQuT8AaGvkzOqfz5SZYwfLLcoIV+xmF+Jg6r+zDTDhtkFsswBOMN2pwN7Bmf59b8buSQkp5wf2BZGiUBZLjmmKerx+lpTWd3rEV8qinwccIWBAsKm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2018 13:20:23.3321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf18586-f02e-438f-a634-08d608320485
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4660
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.8.2018 13:17, Lothar Waßmann wrote:
> Michal Vokáč <michal.vokac@ysoft.com> wrote:
> 
>> On 22.8.2018 08:14, Lothar Waßmann wrote:
>>> Michal Vokáč <michal.vokac@ysoft.com> wrote:
>>>    
>>>> Output of the PWM block of i.MX SoCs is always zero volts when the block
>>>> is disabled. This can caue issues when inverted PWM polarity is needed.
>>>> With inverted polarity a duty cycle = 0% corresponds to solid high level
>>>> on the output. If the PWM is dissabled its output instantly goes to solid
>>>> zero which corresponds to duty cycle = 100%.
>>>>
>>>> To have a trully inverted PWM output configure the PWM pad as a GPIO
>>>> with pull-up. Then switch the pad to PWM output whenever non-zero
>>>> duty cycle is needed.
>>>>
>>>> Signed-off-by: Michal Vokáč <michal.vokac@ysoft.com>
>>>> ---
>>>>    Documentation/devicetree/bindings/pwm/imx-pwm.txt | 44 +++++++++++++++++++++++
>>>>    1 file changed, 44 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/pwm/imx-pwm.txt b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>> index c61bdf8..3b1bc4c 100644
>>>> --- a/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>> +++ b/Documentation/devicetree/bindings/pwm/imx-pwm.txt
>>>> @@ -14,6 +14,12 @@ See the clock consumer binding,
>>>>    	Documentation/devicetree/bindings/clock/clock-bindings.txt
>>>>    - interrupts: The interrupt for the pwm controller
>>>>    
>>>> +Optional properties:
>>>> +- pinctrl: For i.MX27 and newer SoCs. Add extra pinctrl to configure the PWM
>>>> +  pin to gpio function.  It allows control over the pin output level when the
>>>> +  PWM block is disabled. This is meant to be used if inverted polarity of the
>>>> +  PWM signal is required. See "Inverted PWM output" section bellow.
>>>> +
>>>>    Example:
>>>>    
>>>>    pwm1: pwm@53fb4000 {
>>>> @@ -25,3 +31,41 @@ pwm1: pwm@53fb4000 {
>>>>    	clock-names = "ipg", "per";
>>>>    	interrupts = <61>;
>>>>    };
>>>> +
>>>> +Inverted PWM output
>>>> +-------------------
>>>> +
>>>> +The i.MX SoC has such limitation that whenever a pad is configured as a PWM
>>>> +output, the output level is always zero volts when the PWM block is disabled.
>>>> +The zero output level is actively driven by the output stage of the PWM block
>>>> +and can not be overridden by pull-up. It also does not matter what PWM polarity
>>>> +a PWM client (e.g. backlight) requested.
>>>> +
>>>> +To gain control of the PWM output level in disabled state two pinctrl states
>>>> +can be used. The "default" state and the "pwm" state. In the default state the
>>>>   
>>> The "default" function of a PWM is to deliver a PWM signal. So it is
>>> more sensible to me to have the PWM function as "default" and a "gpio"
>>> function as alternative state.
>>
>> Yes, I totally agree that using "default" for PWM and "gpio" as the
>> alternative function seems more sensible. That is actually how I started.
>> Then I realized that that way you end up with the PWM pad set to zero
>> until the first call of imx_pwm_apply_v2 where you can select the GPIO
>> function. On my system that first call is made by pwm-backlight more than
>> 3s after pinctrl init.
>>
>> I suggested to use the "default" state as a GPIO function as the only way
>> how to get a truly inverted PWM output all the time from power-up to
>> power-down.
>>
>> In my opinion it is up to the DT author what pad configuration he uses for
>> each pinctrl function as he knows what the HW really needs. I see that this
>> approach is kind of controversial but I hope that with good documentation
>> this would not be a problem. And as I wrote in the intro, it is absolutely
>> optional. If you do not need it, you do not use it.
>>
> This is OK so far.
> But the approach with the pin being driven high via the pullup
> configuration has a fundamental flaw:
> The pwm polarity is specified by the PWM client (e.g: the pwm-backlight
> driver:
> 	pwms = <&pwm0 0 PWM_POLARITY_INVERTED>;
> )
> The pinconfig is defined in the pinctrl of the PWM driver.
> 
> If you have clients that may use the same PWM instance and require
> different polarity, there is no way to set the pullup/-down
> configuration in accordance with the clients needs.

Hmm, I did not think about more than one PWM client. Is it even possible
to design such board? Do you have an example of such usage? It would mean
that the single PWM output would be routed to more than one circuit.
E.g. a LED driver and a FAN controller. Those would be two separate
clients of the same PWM controller. Each of the clients requires different
PWM polarity and different frequency. In this case do not you also need
additional "enable" GPIO to enable/disable a client to ignore the PWM
signal that is meant for the other client?

IMO you have any additional option how to disable PWM clients, then you do
not need to care about the state of the PWM output in disabled state. If
you do not have that option and the PWM signal is the only one to control
the circuit then you can have only one client. But I may misunderstood
your point.
> 
> IMO the PWM driver should actively set the pin to the 'INACTIVE' state
> according to the polarity specified by the current client using the PWM.

This at least allows me to do what is currently not possible - to actually
disable the circuit by disabling PWM from the client. So I can potentially
live with that.

What I find distracting is the fact that the logic changes some time
during boot. You start with the circuit disabled from bootloader. When
pinctrl driver is initialized the circuit is enabled because the PWM pad
default function is PWM output and its state is zero volts when PWM is
disabled. Some time later, when a PWM client driver is initialized, first
call to the PWM controller driver is made to disable the PWM. PWM is
actually already disabled. What now? You check that even though PWM is
already disabled, the client operates with inverted polarity and the
pinctrl is not set accordingly. So you switch the pad to the GPIO function
and just now you really disabled the circuit.

So for a single client this seems unnecessarily late and for more clients
you would need other means to disable them anyway. But I am sure I may be
missing some important things.

Thanks,
Michal
