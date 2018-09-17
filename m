Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29158ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B51208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 03:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="E6IWRQar"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8B51208AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbeIQJB0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 05:01:26 -0400
Received: from mail-eopbgr710081.outbound.protection.outlook.com ([40.107.71.81]:21184
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728852AbeIQJBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 05:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sFlcRPa5bSpY4lR8eBePsWmMOKQd2vo/lfCCg4K1KTA=;
 b=E6IWRQar/q7/p/YUO7S0bW2m2PP9ref4D1nKA/QJHpJ+Ee6K7tE46CaO0+/soDGB53F9TekGM3AbGnkZQQnHL1+B5WzHe5ggvwCIWXhU1KZWLWRdkmK4JraGc3fI8fq03PpUZN949Z7D8Nv6EUokCTaBp335pJINv9LbYkHLokk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1578.namprd03.prod.outlook.com (2a01:111:e400:529c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.18; Mon, 17 Sep
 2018 03:35:55 +0000
Date:   Mon, 17 Sep 2018 11:32:28 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        <linux-i2c@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: i2c: designware: add optional gpio
 recovery properties
Message-ID: <20180917113228.43c9b8dc@xhacker.debian>
In-Reply-To: <20180917112741.7c3d6514@xhacker.debian>
References: <20180917112633.252c591c@xhacker.debian>
        <20180917112741.7c3d6514@xhacker.debian>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: TYAPR04CA0001.apcprd04.prod.outlook.com
 (2603:1096:404:15::13) To CY1PR0301MB1578.namprd03.prod.outlook.com
 (2a01:111:e400:529c::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44448259-d774-438b-f8ab-08d61c4eaef5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1578;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;3:HzOQNIKHf0egO5mLYhlcfSKrjvY+Hn/Np6v/v9DxrCBpeSJlDBCoqRCZah5alm84CpS2iMXJpTCL+khoqNoDGy8iFZOsE0GvffbhwsS8xGRbLvLQ3alTVFkDmVAERjsUN5c50wJb01qUBDSRKQ9mejyTsgnczNPyCJMi9qYcRMqHOOTfeIn+6CiFQZ0sXN+dYKWFGU1t2mQSO3fiZm+dkUQ9ZAUBMTs6tClmowJbyK+r18id+GFDcg/WKqmeD3YR;25:2RD38nDsKbtqgME0IcN+dTbsYggNyunf2caL5cVKhvsM7wwWUp8x93acvj7zrbT7uDh/hXtYKDHv+zmvVZwvQJ4gf1XyH+EBBR7IRP46WnTJqpkKI5VrcGwODM3MwCGyjVBW3H7qlwjKKxHeY5hKCgmrMAV5mUBZ2qTrvaAILIolQjM0GV7FgaYiAgNe5utltojFf5Tzt001dsYTJAytDk1y2htiYuilPn/qnBGVbc3iTfr2GTRfHt02fgj3LN9XgVRIZwxa0x85LuZGrzI/Svnb1wrz+3CkKbZOSaw82J12e9+gLVofPAr75gSWGaAa/gI/7TGu3A/SkW46uGTWXA==;31:rPSdEb+Kn4KidNuuvz0HnfPJT6sdDO+EF7O5I3Run755JCEqyALffk5BE9uzGuBId/ptgVr2zFDnmaG4UJbaX6yVyTd5MHLYzxbEVMEkCrLtcLiIJLHHGdpSrtGp6/5BYEstwX1M8hpCSgl8QZF8eZHq7vyLoaGWoNCqyYN3ULEyJ3Hrn1dYcKgzu68gv4s7Ff5dW61i6rH0KQibeIH4o9peJl9v0A5dvPdKdDq/J20=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1578:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;20:iusehEFN6NpgpfLUc8QzL3hSRUz5WH6FguNHk0pohiWiDP+aoehlYmuvAI5ZfKCQm+on9fqUVroG1ELpJ8F/6lfNSs1gyhAQaPV51d0uj3sHxh0LTuk9XGjnIpSd6xjFUeAwCdxJyOvYVL4c3v06IRx6GVijV4Jt/JDYevc4df4HEvEyJ+YuqbYXn2KNohFxgshjuGm0RCf29aIWhj4J/b6QkmhHayhgdlJHCzWdNwlmLpGeMGLBdDYSBMzrVkwPIZ1mvce/2CvYoOP5YFHwUxVijkHjae/8iHZwjoHnyRNVqKTwS+nfeBMZ7xxCz5ATE6L4LyGcmpXTOFPoYyNI+Zz+zmu8yVMwPyMDiaTrLTKxhsRW32N82YkjyQlyF9Xfd23uWnADkYYxen0/X4lz26jCMX2Vk5Ktuypy2iCzI1JD1xGXFoPJkcHFyCfNI5ysKHoQrgatess6Q/6m+a/P8lBFWAALPKgdOMDObCfS0TcCKdhAa27RTRZpCahTbjn8;4:1pg0S5EQvAAYnU22jzztOiAkJ7d1AT8DV5/NlJ4V/Ex1Ep3oHN708N9wTMpDvenk5Ua6x+katJhSZKrkcZCVzUj2ecOqd5zGv80EWxsH+zWH15/L1TDgJlVaaANNuNoC+ukKhrKEHJsZHOE+y1BCOrnw6XnBXAHiOmZkxsZuHEXFHEwdPXjiakV+YD0h7efyJ310906QiKZHzFsqY2wCUhegdlo9MeD89gr0+GKYWJm4Cak6mNO9mbNLc/YI+PYBkxMjn8kdKlnWNv4N8prR7w==
X-Microsoft-Antispam-PRVS: <CY1PR0301MB15781EDF5DD8A7F4359B07ECED1E0@CY1PR0301MB1578.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:CY1PR0301MB1578;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1578;
X-Forefront-PRVS: 0798146F16
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(366004)(396003)(39850400004)(199004)(189003)(230700001)(7696005)(76176011)(33896004)(68736007)(52116002)(55016002)(7416002)(81166006)(54906003)(8936002)(50226002)(316002)(110136005)(81156014)(8676002)(6246003)(86362001)(7736002)(305945005)(575784001)(25786009)(1076002)(6116002)(3846002)(23726003)(4326008)(956004)(446003)(476003)(47776003)(50466002)(6666003)(386003)(6506007)(186003)(26005)(5660300001)(2906002)(229853002)(66066001)(106356001)(11346002)(9686003)(105586002)(97736004)(478600001)(72206003)(486006)(53936002)(16526019)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1578;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1578;23:3G9hSDy79C2K1jDgWB4jBpy5xCdLyP5jPGFPdoc?=
 =?us-ascii?Q?NRY99yLAo6TQgwQo+HbOQ5LIt5piNKEiu47tUBuyTTZvoCFOQHvnFx5J3BiX?=
 =?us-ascii?Q?eot1zIhnWqdzEwPKovGAqshoABPg9/bnnazQ0M25f3Q3LV6Q8z0An4lryO9H?=
 =?us-ascii?Q?j0e30cFN7Lhrt7YavsvRrEsZp8hr3pbaM/6JgWGO2MQ65Yamc3T9nzWZRw66?=
 =?us-ascii?Q?3VarhMREYbxFNdunPA7vMbm3uCOmjz0VHT+QWwC1wOIL6vkWUnNpee6kvZhP?=
 =?us-ascii?Q?xGyFzHyq8QIhPqaRqa2JArGJ9UWZbAg8yOvRNIvFEwjkivyG2uJx1rsTe9uY?=
 =?us-ascii?Q?4T9zQ1oYiLGx5fTTa8hrlsM6/SuDkpMrcpJ9tGzURlhj/tYGBuAU8y5oT79G?=
 =?us-ascii?Q?uh3oBrPsJB50hO+f8uQkPdncNqVEDj4DbAPl5dUdK5naUjf+Y+uRcmtj8AbJ?=
 =?us-ascii?Q?I3Ezvx2zqKefrMBm65wt+ls8HhkQBdk64MsnmYp7S7KyKqUQy9lhpxZ5vMlP?=
 =?us-ascii?Q?8i3QrGlTg6wPg1GZvsHPmeBmG/JamZhKV3uhIWYHgC8DPsJ7JURXe33IouCp?=
 =?us-ascii?Q?faV+VvWNr9eoc2xUU291g7z6UXx63KOZpegZ4vjarUWlYJ/JxDDSf++HdfXl?=
 =?us-ascii?Q?DabuY5JcnnXxfV8ug/8KmrbYbS9DhSW3s7dqlyCvDTT1HfB+Z3Mwvg8thXwQ?=
 =?us-ascii?Q?pFFLZ/Tn/YLls0KTDMaU9aa8hzfTC0840bFhw4PGd0MR00eicqt14zfcOwSV?=
 =?us-ascii?Q?hoKgGYX4wNoV6UtQDmk+HjbdY/vz7udm6bHNNFrZOzc1JuP2LCmaY2GU/N4J?=
 =?us-ascii?Q?bzIDjoxzjphSPg0rUatURE0lMA4bjDS2vylQGbuYRD0pMBkIa781P6pOSi+6?=
 =?us-ascii?Q?3tXDka//xXngg/NP6GfEbudeL0XeIhkPAkjJhJfTnevXqmPwdjM5vWnN9/zk?=
 =?us-ascii?Q?vFmFqME5gTncHn9ihu8IzEYW8guC4JfP8F6q4x/57jKvluJjdjI8KsZ0ZeWx?=
 =?us-ascii?Q?rqEtdkclWrec7QqScQxrq9UCuT3HX5QLMlykF8JRWI4GWDbxtE1dmyNAfnYI?=
 =?us-ascii?Q?k9BoO/ox4Ifs1KDx/SYlxTLz+8V09Wh1CIIT71j30DlMdpcfJuAOa3vefoi5?=
 =?us-ascii?Q?Tl2wcYYFeVDYELkVe5sH+fzc8icPHtb2PwHAmZtJCNLJV69VrfQWk+0tg7Nx?=
 =?us-ascii?Q?c2I+xxbO0QtILugJdgIrtQMys0uHa0d7nYmsaw/m8aUZfdvFYGQeLB4/sECQ?=
 =?us-ascii?Q?u90qUOVRQY47kFPpjPZsuRWwFlcUFQyBvfqmTEM1Jf1KZl9g1TTze77VEbKn?=
 =?us-ascii?Q?UOLNOUTYGA+q10jaOhBNUY4j9OYi3s/nenEEE2tO2QzS2?=
X-Microsoft-Antispam-Message-Info: X0/IN6QEdMptakuEE73DqXpZZYw1Sb1BeQnokKBV19NJkf6QSWJ1LtLe1uFwPweaHlYoZ8Qjke8pMplG7mCSqzeOJMnrGwkyC/2AtSkVHY02SwkM+og6V761E0fYNFyc9aGlBfpiC6PS5/uZYtFRzWnigmxxZ7wEWYusB2BNvjNkb7izm8pEaYvG7lAfijjCOGbURgEi/HXtkZHeHm0Y4rRcGY2r/ui76LzkVNmCmpYdZgaZJPiqmsDlxNET744S2uZKO/wREwoHNZZrJCLxfT2wN08kKKyX3cJPWjN385XPpZkUsTCtl9HVacHfzhY6yLc4mwxY35m19H7R7yE6nVVinZChALXIWakVFnM3MJI=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1578;6:bQBGPb7FtVcXorpb8KzjX+ErpYgxvJ2zTOoVCaTGanXTlLlvxLnzn5v4nDQO8YSSQ2eUmGLAXkeu7UQAUsq+Gpe0sdOeqdXwVmp8SbyuViWAYOzn971ifXwXwp3UThDSTiU32JkU8tkCPnW1qk/EMYcpEenaZOAkf0s7xyncLUbadE+OtoF5fZA61OERQxYEh0Q2bykoGheji1y2PR6AMqcYVI1p23y+cZWXmLdFb0m37RTkuSm983+TEDbljMvgQVQ1kfkFkokfGHsOZj9+Dy9EGzOT5ob2+KCLpeceAdjdbsewb40hE1np9w7Tnt6g3XnDZoHN/gsTs1FnNLN6a2cKwoNc6fXr5D6jozNAzr3xwWUsco64FQ2rKYmSWg1MzvroIx3J4USX5fzlivR6+9HwGyiN/ekydNM706xRg8W4gAP/NoOs8XxlPBPznRErpwwdoBZonCo4+rqr8NciRg==;5:s64F/Tco+2tiGSprzZfEOBgXhMIdTxRWMCGLOnL8w+0zJM9TZIMonoGMeXGbgkwWn3cuF2qSgioEzO22ayDloq+jm3z7Htcf3+Cc/4qVHf6iwgUFC+82oZniHzqmB40wJ07eCI4BdgweTo7X0FGbWMCxPvqQaZbQ1LQFMayMWXY=;7:Cn098IevFj6nrou4hBwypXsTwRlzHGrZMvEhioW2M9a84lXEIOSk8EqjYP+49a1YrBmFzt89fMCEPAuvu8+sHomqbEMnyfrEFgisX9Fdiez16hKZ9j6JqPME/RVTKusMwh/hfRfZ2YYP8mMaXM/ABRW0a58QXOMSvRDAnXhZWVpjwoPBCT+AJ1oXnwSldkGwJo5n/SL4cHg7rdHndjN7RFoxLFJkRbZbfnhUL9rG2b9l73PCH+zuNNSWQsdLYm/G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2018 03:35:55.8652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44448259-d774-438b-f8ab-08d61c4eaef5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1578
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ DT maintainers

On Mon, 17 Sep 2018 11:27:41 +0800
Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:

> Document the scl-gpios and sda-gpios properties for bus recovery.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  Documentation/devicetree/bindings/i2c/i2c-designware.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..1d6a6a8061ba 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -20,6 +20,10 @@ Optional properties :
>   - i2c-sda-falling-time-ns : should contain the SDA falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tHIGH period.
>  
> + - scl-gpios: specify the gpio of the SCL line for gpio recovery
> +
> + - sda-gpios: specify the gpio of the SDA line for gpio recovery
> +
>  Examples :
>  
>  	i2c@f0000 {
> @@ -42,6 +46,8 @@ Examples :
>  		i2c-sda-hold-time-ns = <300>;
>  		i2c-sda-falling-time-ns = <300>;
>  		i2c-scl-falling-time-ns = <300>;
> +		scl-gpios = <&gpio1 15 GPIO_ACTIVE_HIGH>;
> +		sda-gpios = <&gpio1 16 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	i2c@1120000 {

