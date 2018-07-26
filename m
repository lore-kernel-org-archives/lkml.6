Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E90C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A85F62083F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 07:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="Vk0X5/Cv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85F62083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cern.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728943AbeGZImZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 04:42:25 -0400
Received: from mail-eopbgr10041.outbound.protection.outlook.com ([40.107.1.41]:18688
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbeGZImY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 04:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f5IMUzNnw2JJ9Zg2FX4hsip+H9UgN2P3DoK382zSDmI=;
 b=Vk0X5/CvmHPKqjtR00s2wtrDQd0AABAke+zVYaKLayuQm+h1oAy3IGDhtX6xJDOAylipw7X0XPxFHLrT+7qeSoOkKmMeB/TvhDupU8Z9Z9WC5BpbLZZtzPSWx70tkDuXo8GT7nPJq8A1SEowKhrm7QG+EpOYlsejC+b74lr7tSk=
Received: from AM0PR06CA0040.eurprd06.prod.outlook.com (2603:10a6:208:aa::17)
 by DB6PR0601MB2470.eurprd06.prod.outlook.com (2603:10a6:4:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.16; Thu, 26 Jul
 2018 07:26:49 +0000
Received: from AM5EUR02FT024.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::200) by AM0PR06CA0040.outlook.office365.com
 (2603:10a6:208:aa::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Thu, 26 Jul 2018 07:26:49 +0000
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT024.mail.protection.outlook.com (10.152.8.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.12 via Frontend Transport; Thu, 26 Jul 2018 07:26:47 +0000
Received: from cernfe06.cern.ch (188.184.36.49) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.399.0; Thu, 26 Jul
 2018 09:26:35 +0200
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.399.0;
 Thu, 26 Jul 2018 09:26:35 +0200
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Alan Tull <atull@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     Moritz Fischer <mdf@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: Re: [PATCH 1/2] fpga: Document when fpga_blah_free functions should be used
Date:   Thu, 26 Jul 2018 09:26:33 +0200
Message-ID: <3092191.aOBZP6MEga@pcbe13614>
In-Reply-To: <20180725181514.3501-1-atull@kernel.org>
References: <20180725181514.3501-1-atull@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0601MB2470;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 354ef03d-f6ab-4e22-9a2b-08d5f2c92698
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4608076)(5565046)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB6PR0601MB2470;
X-MS-TrafficTypeDiagnostic: DB6PR0601MB2470:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2470;20:I2RUn71MF5+yw+kcjRZabPRgx9Qsr1mkjLNHb1UCHQmVMXnIsTIRrmPLR+WT0CSACf8wNl87flbfV38JwiqUrMQp9sO1whlRyHweslNQbsJtwTJUsCeKZuPwuH04ytZYg17fInDuL+RB6UZUbCFToh94oGVonlA7Q44HmJFwnboKdDJNnXmDnDaEsm8RssgM6595ZaUxQemK9UTyI3l4rzdDaAec5hhwomO2XLt2yCeAwCLyrtp8TETGDPv43iCadu77LrL5eqaFl7CYDIxejNPzFzXk8flJqrbxW5/W370rFgTyDnJOtMah8J9etYJyG48vQ5/xvVdvIJby4h1Nxiu6r1x6ywun5krCaxu8zn07S1Nl7oUnEgG+LHRaBLlU/ZdlSv6Uwhrtnjgr7NCQ3RTfQFk+EMZWNqAIGscFwtvO4lZWXonRyx2rBRSVve85XOEPyWs9BrJ2HVEkdw7JesGyYemVygTaiSByJFjDOx5zRiKADwQA8Nu2JqZcNHgJ;4:hO4yOSywMIJg40zoQGKaqTwmqoxKba3ymLfT1tzlQRwILR/4Z6e+7mBiyVgCbPWvJVp9zm20sQ0ty5W3qp9qPSEBqYMB+lvV+mf/Rp7tfraNxe09YCpDslm+M/FL5mjOHnX46ysRoNphXF/ygH7CDruOdAM9SRKmByaqk91vkJQRx2prFS8jf5Sjtcji6vfe8cmL/V15xumqv0JCzjpO8fg1EIpg4jW2q3GdQGaFhDguAOGRa5POgaQOqYQkdpp2uFSKRwhNffF7EdbvWjrxf+oLR1DQXeG6+kqQBQ2tyxHHIyl/b4wyHeSKzNXvETkl
X-Microsoft-Antispam-PRVS: <DB6PR0601MB24702BE288CEC95C69C9A7D5EF2B0@DB6PR0601MB2470.eurprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(7700054)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016)(7701012);SRVR:DB6PR0601MB2470;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0601MB2470;
X-Forefront-PRVS: 07459438AA
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2470;23:+6EdNBBjAB1ZdUZNvMKwUTNpER72fHhwbpFUzlIy4DVfZqGDJGe3altkkwF/w3Ue9eu1wyxySfkA42MfAqtrQX/pZSWIZ/oX66+lm85ErjlW6YZnxIMvAt1lOV/9qUtRCdLRr6UGG5Es9Fktk+fj41NQ2gZpSKFu8vBurEFChu3aQjXbD7g4w93Lnv88PuEI;6:eWdEJ4LQUZcxpJihuChtkCDNDOfXpL1fMEHnFTR4EqCh0j+JlbPPwBEhNESkqa8oTto4Lj9NX7PYxhEvj6HjFcxgKI88eAo7U552/ucsL2waKGIG2nGEUT2e7jHyn/Daxl70JmPBeZ2YwxnBYCbK9wRfEDStV7RJP87t8e5xJBDE3HZD8kh7gdwcMHlsFrQ5nT+7ZFYLOCijCikdhgMHYvB9FNiGBzr0cSQox+yvoxw/opQ5E7GaimXiEt3Vp7C5uAownix6Y0HXaez+jDBLpFujDhsRoFbdc7zFeBtM3N2h1VxJJyFPXijaoPs73afad+PtTBSExwI2R8/QIHA5yoSjbIFH/10w7jSECtQemejMK0xMer3zV4iB3AB4awjhD5vPgN4nOE44Aq87aTOZjmh/wrtqwr/es2PVNGVu2d/jLITdKmzJqewCrYLWOqUQYShcp93ahhD8UT4/FVbcWbzjCoGWt0Oyz/NL54Asr2zJU2d5ri3eEgkDlNi9AW20;5:T0aH0Vvd38/mO93KeTKBxmTRHV0hEcPXFGdZHVQckXX6uVv3xutBM2IpVBwYI1EISmwA2BnRcAR4exdyxfKJ0YMuO/n/yDDn7LbrlUPYJqE8oH75MRgFd9pH6fnozKivzZWjge7XIzePmyRxxeTiV5bGkUK8b21hIB2Hxqk7SGU=
X-Microsoft-Antispam-Message-Info: sTaO/MuS5rL2KMWSJQvBXielymWVVuK3GAr3aauOtjiJBiKx/dr2xyT/mkfKexoQZyL6uAMtdIeOeKv0M34Vng2xQlYBkMD2SEi4OCNy7UEz/sgt7fTdEgNDFlUlM7fjE5sRXkfrQUcTmNc+c8GjWTI3kZ4pp/2yRn647nSGZyFZ7ko9Xaq+T54PqE+UUKU/ph0PiUSP3rT46+KlTDvdMkPGYyUzLmjUCWatB4trnRuKagylcQMyReFEXHUkB6yVwTPxurloX+TtvgT/BbZ9XWvQy95UxJ0bisZKIvNqromlhSS6bhfWnpKfYdvTG3Ty4Ylyi/r5Ogkwi4oTY1t/RELKHqQqAs7/9ymiPQ+riafvd061ae9AWW61NOlE7r4EFU3VImhB8I0+mFiH1hWKq06KSMDTEea1MrMe2xjSQUOvmFdXMiZJshUDbN/MPMp5DsEwPTfzFVrPQXhV3XL1LJgn/RbfbQ86NXraohIh0CY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0601MB2470;7:OUsGHVEFqnnILjUf07hnwIPSSorRIrzldhXUNoX9gAipMPQTDez4DzBwRcCvaRK69YX6iuZPpZtSfeqBbdsl36lh5HTwjtMII3ukmKOzR/DGW6xV9+4fCsMMYTuKkwo+NL1+Cbi81ccLf9AAWB0KmfkrncEYGfjjAZyTUNYtcECqJL+FUx/zrHs8ihl3EcjDg6RjqxEo7yQuLYQOGL5ArOSnEOYv4NPQF11KleDX0N/jgbupBGk2eW/ymj1XpR/D
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 07:26:47.4395
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 354ef03d-f6ab-4e22-9a2b-08d5f2c92698
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0601MB2470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

have you considered the possibility of having something like devm_fpga_[mgr|
bridge|region]_[create|free]() ? Like this, it will be obvious that 'struct 
fpga_mgr' will be released automatically without reading any comment (but the 
comment is still good), and you use devm_*_free() only to handle error 
conditions. 

On Wednesday, July 25, 2018 8:15:13 PM CEST Alan Tull wrote:
> Clarify when fpga_(mgr|bridge|region)_free functions should be used.
> The class's dev_release will handle cleanup when the device is released
> so once the mgr/brige/region has been successfully registered, it
> would be a bug to call fpga_(mgr|bridge|region)_free.
> 
> Signed-off-by: Alan Tull <atull@kernel.org>
> Suggested-by: Florian Fainelli <f.fainelli@gmail.com>
> Suggested-by: Federico Vaga <federico.vaga@cern.ch>
> ---
>  drivers/fpga/fpga-bridge.c | 10 +++++++++-
>  drivers/fpga/fpga-mgr.c    | 10 +++++++++-
>  drivers/fpga/fpga-region.c | 10 +++++++++-
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/fpga/fpga-bridge.c b/drivers/fpga/fpga-bridge.c
> index 24b8f98..528d2149 100644
> --- a/drivers/fpga/fpga-bridge.c
> +++ b/drivers/fpga/fpga-bridge.c
> @@ -379,7 +379,11 @@ EXPORT_SYMBOL_GPL(fpga_bridge_create);
> 
>  /**
>   * fpga_bridge_free - free a fpga bridge and its id
> - * @bridge:	FPGA bridge struct created by fpga_bridge_create
> + * @bridge:	FPGA bridge struct created by fpga_bridge_create()
> + *
> + * Free a FPGA bridge.  This function should only be called for
> + * freeing a bridge that has not been registered yet (such as in error
> + * paths in a probe function).
>   */
>  void fpga_bridge_free(struct fpga_bridge *bridge)
>  {
> @@ -414,6 +418,10 @@ EXPORT_SYMBOL_GPL(fpga_bridge_register);
>  /**
>   * fpga_bridge_unregister - unregister and free a fpga bridge
>   * @bridge:	FPGA bridge struct created by fpga_bridge_create
> + *
> + * Unregister the bridge device.  The class's dev_release will handle
> + * freeing the bridge struct when the device is released so don't
> + * call fpga_bridge_free() after calling fpga_bridge_unregister().
>   */
>  void fpga_bridge_unregister(struct fpga_bridge *bridge)
>  {
> diff --git a/drivers/fpga/fpga-mgr.c b/drivers/fpga/fpga-mgr.c
> index a41b07e..9632cbd 100644
> --- a/drivers/fpga/fpga-mgr.c
> +++ b/drivers/fpga/fpga-mgr.c
> @@ -619,7 +619,11 @@ EXPORT_SYMBOL_GPL(fpga_mgr_create);
> 
>  /**
>   * fpga_mgr_free - deallocate a FPGA manager
> - * @mgr:	fpga manager struct created by fpga_mgr_create
> + * @mgr:	fpga manager struct created by fpga_mgr_create()
> + *
> + * Free a FPGA manager struct.  This function should only be called
> + * for freeing a manager that has not been registered yet (such as in
> + * error paths in a probe function).
>   */
>  void fpga_mgr_free(struct fpga_manager *mgr)
>  {
> @@ -663,6 +667,10 @@ EXPORT_SYMBOL_GPL(fpga_mgr_register);
>  /**
>   * fpga_mgr_unregister - unregister and free a FPGA manager
>   * @mgr:	fpga manager struct
> + *
> + * Unregister the manager device.  The class's dev_release will handle
> + * freeing the manager struct when the device is released so don't
> + * call fpga_mgr_free() after calling fpga_mgr_unregister().
>   */
>  void fpga_mgr_unregister(struct fpga_manager *mgr)
>  {
> diff --git a/drivers/fpga/fpga-region.c b/drivers/fpga/fpga-region.c
> index 0d65220..7335fa9 100644
> --- a/drivers/fpga/fpga-region.c
> +++ b/drivers/fpga/fpga-region.c
> @@ -231,7 +231,11 @@ EXPORT_SYMBOL_GPL(fpga_region_create);
> 
>  /**
>   * fpga_region_free - free a struct fpga_region
> - * @region: FPGA region created by fpga_region_create
> + * @region:  FPGA region created by fpga_region_create()
> + *
> + * Free a FPGA region struct.  This function should only be called for
> + * freeing a region that has not been registered yet (such as in error
> + * paths in a probe function).
>   */
>  void fpga_region_free(struct fpga_region *region)
>  {
> @@ -255,6 +259,10 @@ EXPORT_SYMBOL_GPL(fpga_region_register);
>  /**
>   * fpga_region_unregister - unregister and free a FPGA region
>   * @region: FPGA region
> + *
> + * Unregister the region device.  The class's dev_release will handle
> + * freeing the region so don't call fpga_region_free() after calling
> + * fpga_region_unregister().
>   */
>  void fpga_region_unregister(struct fpga_region *region)
>  {




