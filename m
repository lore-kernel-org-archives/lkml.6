Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D39C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D83A2089A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BQHKWZ1u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D83A2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbeGZHN7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 03:13:59 -0400
Received: from mail-bl2nam02on0045.outbound.protection.outlook.com ([104.47.38.45]:22815
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726326AbeGZHN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 03:13:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1MZOjXkdKFG+IyDKH0wskkvlIZ6PMvGLVOkS/wMXAFc=;
 b=BQHKWZ1u5r8TesOLC34n2/cU9tNESSVR7+tvZxeX5I/GNL+CF18WoATmByVB1MYCZIgjuwJ6k3pwGpVKQ6vi5Confj0k5gxZooUMMYEHUNtRNwSM9LgZZQRx6xqQFUXTy49dYiBz3BGR+W35HpXSiI6+ScKBcVE448kMC7O01fg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com; 
Received: from [10.136.129.116] (202.56.249.162) by
 SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:25::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Thu, 26 Jul 2018 05:58:43 +0000
Subject: Re: linux-next: build warning after merge of the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180726121942.0ab69aac@canb.auug.org.au>
From:   "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <ebe278ff-becc-429f-f72b-3d1b6d9698a5@amd.com>
Date:   Thu, 26 Jul 2018 11:28:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180726121942.0ab69aac@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR01CA0089.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::29) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:25::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c514d5fe-08a5-4c65-229f-08d5f2bcd8e7
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4618075)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2368;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;3:JSCOuqTOP5K8SFwyim3YRNeRTu7Cw/UV2Wez0IlnmrnHlHDPOhiMYdPqrGaD/3nH0628UWGxXfioQSwzyWiAKGf6qss7bifXq3t2MvEPc1WlMUvZAoN6/Ji6IvLZFlqarEQ542E448FaLyb7nlb0UVYi6DBik61SGN97Qujku3Zcryqm2L1f9OlYz+8F4a3TaCRr7PhRtpwiqHKgJpbxcs43TxdlgjCMc0MdZMEIMmPPPi2pbiWXu1M3TAVG28f6;25:hq2uEUtp5ksJaCtrxEJMl3TjMeBgPrWihIEtyGWMs7Ha/cj3VQWyBS4ZAg4+uBgfknSEuq7RhssQxMpT6Dj1Ftu/eXFCkhwhiPT8en57i6z8xnFHsdk43/0p+UF0DJXTNn9oI/u0Mbr5ddslAcSVeAG5eQjDWNEMdVqjX7a5EkD1qzQ9ZHoypBI04K/e/sV/jAX0e8TWxndzrcSgO2MwSe53r76a51/3McdGB/h7VEJEbq0X/VVu6Ih+12w8J5+2znFkMMFW26xxXFASZMDn/GAJhkPxnhGQ6mjKOIeyf7xOmstgFAYoQuZ8fp9qhfSbEP8hkVLDonFfxxenatYCcA==;31:XACl+5E/2x6HxhA0IyaMOhwNiNT8jz+F7f4/NZN/rsBZrXwF13O14z/hkdfqvrznsfg60r52nxEIMWfdM61V/4jbNOTH3Bdsq5d3z6zWl02JbZJUS7j25W8KWjlirFCnOOvNE51s/foOANrH8yrICkRNORwRQ7Xc5vjjVnn7Tb+1C839m+/NxYICZEoS+REtwU3u9Ul+CEXzhdl4OqaBOWIciThEEVIP4MxrWZvSe7g=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:hKvIBypA6ujZe0+o2SLDKO6XXDTvrrIJbcHHxO91/HlELWtqIxDGS80j7q0+ogQdHN5QVIrtxkHkerriGfCtMNYI7RQmnywuLoUWfZ/HXIpb0VtAPI8gu7deAR0V1vvY50daJUBhnPkgocvcryXNy/SKMgswTBnOhnaf3FP0um6rXfCBzRYndJ1cF1zkcDGDrU655RLFzp4GCzh1hM+FZ6rxnTkcyahOLeIxdR5AWmENYgwi8v4Jre+ZPRKukbUwkui2zZypOUtCkdvHti/GowzqDPw6D7x/2yZaqiL8Ymz2JJ+g3XY/QmoY71Wz8+Ki6vcI0g+jHOg01x2or0rHlWKDnNGGswExI54aRvvMHktuKGMdqcT8GgLojXUoGqwhG+c3OsVHrhaEY2FmCQHHj60v3zjLqk9mEqWYuG1rs1IUvtQJ8Yijc4O7IQlbIakF6a8+lhN0nPmDGNpL+n+/PZOh8ilkTOgxp10tn5wX9cDeimccQWeY9+33GQ60b3c/;4:1d/25sp8YnFJI0swGK1R5dY9QItXr9gEGjqh5j3zmrG8JGaKLXgpLOVL2I56lOjX7Gkip+4g+aScAxrwLdAPNdCYfFqPj2fZvJGw5Y0WKUm78WQ0YKjhUd/SCowION+EJgwEfJ68V9coy6zaCPOSvXIe1h96umw9t6rZJEziTLu2K1c1HhbKt9v5zoqlr2hNUOnikTedKSqVPoPcvCWdhi6yyxBqegw66b0vxGdEmQeG4G1xJkWVN1nmQJpbNAEsdaqpknxR5BuU0w08KzKk4g==
X-Microsoft-Antispam-PRVS: <SN1PR12MB2368CB25B771506492589B25F82B0@SN1PR12MB2368.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN1PR12MB2368;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2368;
X-Forefront-PRVS: 07459438AA
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(376002)(366004)(346002)(39860400002)(136003)(199004)(53754006)(189003)(6306002)(26005)(31696002)(53546011)(50466002)(386003)(66066001)(77096007)(65826007)(54906003)(81166006)(81156014)(68736007)(53936002)(58126008)(110136005)(316002)(105586002)(446003)(186003)(23746002)(76176011)(229853002)(52116002)(8936002)(16576012)(4326008)(6246003)(230700001)(97736004)(106356001)(31686004)(72206003)(39060400002)(6116002)(36756003)(65806001)(6486002)(64126003)(7736002)(8676002)(2616005)(3846002)(6666003)(478600001)(16526019)(3260700006)(305945005)(14444005)(966005)(65956001)(86362001)(486006)(5660300001)(25786009)(476003)(956004)(11346002)(2906002)(47776003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2368;H:[10.136.129.116];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;SN1PR12MB2368;23:QCz+9jakDnB/VHIKY5out+UUkyiexEJ0Oj5/S?=
 =?Windows-1252?Q?xOYsqPWNl3Xg13LbiMp0JIgSk4VX7KvLSpiz3OmetMW0pwpZboa75OJs?=
 =?Windows-1252?Q?5Qaxc9QQ/7iRYSBpA5PQLbHzeu7uAkYMaxSjWfV2Vy+0B9QExh1vdH3u?=
 =?Windows-1252?Q?uk8qKHST7K13XqTc85A/GxFL/J0/DosVCCYC11S9cZuAK86yg/bFuYcb?=
 =?Windows-1252?Q?WJdWpfepnyvZSNNwiYCbIkjpLG13nOGfHCmj/UbglEoH4VLRQOtNxmLb?=
 =?Windows-1252?Q?DkxUKx90EDOSVtkKwXDx7rUmVdA/zmxWa3/sYzEnwVsNsHSchDIy6lWY?=
 =?Windows-1252?Q?Skvyf2PfGALWvbFqZXlxTFEfYwqD/2diAPWuARzTVz88dzbagkhSIN4p?=
 =?Windows-1252?Q?5vybh18DyogrW/BZOzpqlXmYJbsqYyRVKK50fucYl3uJLUv9N07K28cB?=
 =?Windows-1252?Q?BvmVtnFuKNVan7nK97YVwv8ermCol35MQfZe+Jlb4Z9QB+NTAEnUR28s?=
 =?Windows-1252?Q?EEaxeywBLe5HCIWxmlc1331E7ooz8KccUpr+PKRAZbU7Sn2W80YI3j2P?=
 =?Windows-1252?Q?NKx5NJVQ/6M8YHJFpuaWxfpeVCPxBLfVyoXMnRXYW2+hHYXJfj3zKjpK?=
 =?Windows-1252?Q?e9Q5Y8gNiRn7eqB09mKh96JrXiueBHlJDkdKQ1g7NsU3ggB9ITvdubuw?=
 =?Windows-1252?Q?qwzl2/qQQH8Rp8wChViUvt0i3YYCoHv1Lc1FYWCptSl6nynuJhKY0cCj?=
 =?Windows-1252?Q?9Lufq60C8zj+17IbHsqN08+OXOXYOMjO7u30ZvPTb4bc/HIhwkZFSC3k?=
 =?Windows-1252?Q?T7Lctf9BUiXlVj2Dlocl80pFxuC0jwBSsT4I5j4RePPZb+OnGllgw9di?=
 =?Windows-1252?Q?n6EUTHzlxaBI2Mx8g618JG9pMFFm3qNzGZ6YFAWhacGmaLUkiVOfc+XN?=
 =?Windows-1252?Q?JDpXck2vx7lbRjmjEu8iaX2wlTjB8+oRS1nIqBxMtFtij6tsA6/4fH50?=
 =?Windows-1252?Q?rSZ/QuSKfGXI/54txtpANWIjYCzWd6b5hIz+tzvTVj2kV9ZluxulS23K?=
 =?Windows-1252?Q?jJpjpeMR+mLSU/CaGMlk6ZgtNcQFiREULy7v7xTxD/fcWiQdB9tQXHUB?=
 =?Windows-1252?Q?aWhRwc1b/erTIbVLELguL4cZda6jErAAQO8b80ZlKnmeIy7++eLPv69p?=
 =?Windows-1252?Q?WSMXokf3e0zfDrAOSTaFK6tk7NV5jOq3LCVBoFO1uevTi/iQ9VxSI8Jh?=
 =?Windows-1252?Q?XxR8b4ezAwcnAlYn5z6kqn+qeR1byf2hvSEJufMKvQsPnhOAg94DNFra?=
 =?Windows-1252?Q?mc9QLZ8lT8HFIylQ6MH6GZYDxgTsVm7HgP8ZLr7Oy0mhg7R9BAQdh8KL?=
 =?Windows-1252?Q?F1/Vj22IFmSJOHr0XsJ5EnArzdE7JkepshHqA/OfS0DoUtpGG7FtNstP?=
 =?Windows-1252?Q?bt4TikJF2hrn31dXwXZIzN0msfuy/7gSJzfx56o+cujOY2VhEvLJUU0V?=
 =?Windows-1252?Q?3FYZG7dwf53HyTwH4XoHUERp/uOiFr2xR0DT/znqEb7y2e1mDaLo6q5d?=
 =?Windows-1252?Q?yiJi+bOCVvJ7R4ryv/CWFDfz8Uve7so8nLrIxBjTpSUl32aM89hQq5JL?=
 =?Windows-1252?Q?NgNAgzPowRZahoekq5VQZ5EGjsVsbD7yxjLSI0vJK4S?=
X-Microsoft-Antispam-Message-Info: B2oFiMra/mb/C5+D0gKIbgU6BpzN8ox9Yiv0CyOVZOEooQ4r3ch7NfHyY/eBb/wDKlkG7uC4ptff9c8+u/6Lv0Ej6spyVvumm0TREcmRB4qEnOL0MuO+fyW/D3k9tu6BPNmquV992R55GP/yj0wcXanN1a87Ey5vIDeGmXgWmsj6evLBUoxucYymP6sdrvTytsMPOKvfOV1C0amM5btttkYddeUmAuQGfeK8KYjl6NHrQmaM2SVitOBteTRtlT3xFKMw/OQYC8t2DGxK1j+4eDABJjCn3/URL/+c3Sb4A8pZYUhi2erbT/yCu2tAodA48Q/yGoACd8dqU9UnKqKJMZAGtNW0eZblynearMpmHtY=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;6:KQ/yUtXM4Pp54pMGSvE4J5MgstIKkHjXEWQM1JisDszX31AAZbkfSkRwitczQKLMhJ6k4Ks+LcBVhe9E77xv9YK2C/kvvdzPvdMFolISsUzaYRSlpsQQHAa0YotzQQJoNs/CiCzBCGYxgm4gz0E8r5Ln7o88IaMR8sIJPa5o5zbvACUiJqQEZ/7zISoE6z7lSVVlv67IRAdPkS/hDi+Pm8kzTpYMfQqi8BDk55ByTVCMc2jLXL2KpMU1gsRmoSxhgk55gYIA+H5DDKKyCk2TG3EqmQUivpBrZrh/AfipcFGNkD6wOLJ21sfbMjeNnOSeEBpTEpD/txKp2SDvmVxsK3oUDkeJQpmqmJ6G1ilJM2/M4aSgOiMy4dZIKLJANTmoegdXKX4eeuAY0/xFxqCjbgIHfforOrx98xR65Y3Gs4DqQumg6k6b5aZoQaEYhx6w8XQ3E8PcbKcAvYIkSsbNDA==;5:0cWDcxkbUy775iUnJ9TSFDrr/0Nx3wC1ug3kY4kuuVZZrekf4lbKTLAahFbWyuzYp2tDkj+dt15o6OxngtkSHT2pG56rcx8Rk/ApMauCUxYFUJo0/Hk9plek1FycWAIuOUNe3w7JZUNGT7NxdPr3Hi6Y4DAt55FrOYj6IUbNgGg=;7:bFDzaGq3/EUlIDZFXXyyjhuUqU9mdBtZ/RDE892uYIhEVgavcFSpa/e+bEUjZnZil3vkfHYYmbfBrjctvrh8FTyIp0MPQeHYzhYTRFJ3MZh/9fD+LT1QRleK3AceYy5s0zPhBWatnlCueqcVuFe0ZX/zJE0CQZlH+Oa7OGpdIdwcfYqTstBvo4a7BOM7OTxHFtjWs/uUgYPYB5MyTGtOR6I3YW8xtbdTvTCgpPuDHGsR9zMaaAZl1Yp7O/2V1oRd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2368;20:dtkUunb2cwEedQiDsOtfax0T+aA9lDVG1JMYUM9hc36uY6r15rKclmekOA2mQxR09msha+lNjUPJNhJnSuc0aGReRgi+EkBOOlLa4dEjYcAcY89PZHO/MhHELrlHPRFu8pzin+ZbiG9jx96Loy949K8r3emGN2oaZIIZqqjbpvG2B8RspYNmfVPY+hZBOvxv+mCEzfhw9HvKya9oBxDWq73cjbPsNh9csKQwWOX619Z59xOXFcxauUbkvwT9daE7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2018 05:58:43.1936 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c514d5fe-08a5-4c65-229f-08d5f2bcd8e7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/26/2018 7:49 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the sound-asoc tree, today's linux-next build (x86_64
> allmodconfig) produced this warning:
> 
> sound/soc/amd/acp-da7219-max98357a.c: In function 'cz_probe':
> sound/soc/amd/acp-da7219-max98357a.c:367:3: warning: 'ret' may be used uninitialized in this function [-Wmaybe-uninitialized]
>    dev_err(&pdev->dev, "Failed to register regulator: %d\n",
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     ret);
>     ~~~~
> 
> Introduced by commit
> 
>   7b5317aa809f ("ASoC: AMD: Add a fix voltage regulator for DA7219 and ADAU7002")
> 
> This is a real bug.
> 
Posted the fix for the above warning message:
https://patchwork.kernel.org/patch/10545235/

Thanks,
Akshu
