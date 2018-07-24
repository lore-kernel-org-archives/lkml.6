Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD804ECDE5F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C3920874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 00:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=wavesemi.onmicrosoft.com header.i=@wavesemi.onmicrosoft.com header.b="MuW+257S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73C3920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mips.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388196AbeGXBKe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 21:10:34 -0400
Received: from mail-bl2nam02on0106.outbound.protection.outlook.com ([104.47.38.106]:33920
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388124AbeGXBKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 21:10:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=wavesemi.onmicrosoft.com; s=selector1-wavecomp-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVPZTPosgJDC5IkRHS0LdY3oDk/GFCXzshnF4zAZM1M=;
 b=MuW+257S5NVYjqAD32P0CDjCfpJdeq1AxV6SkcWuSzAqfYWFC3o+5tuSy0ZH3g1kSvxqyRC5etGmn7zgc6Pp84Bsp4vo+Y3bGgmjfPNd7jRFqNK/REUjezDNXsxtiiSnzdgSvViYNBmMipD+dX8FZQELxbFdPQJxHhhqWgam/TI=
Received: from localhost (4.16.204.77) by
 BYAPR08MB4933.namprd08.prod.outlook.com (2603:10b6:a03:6a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.21; Tue, 24 Jul 2018 00:06:51 +0000
Date:   Mon, 23 Jul 2018 17:06:47 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-kernel@vger.kernel.org,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>,
        James Hartley <james.hartley@sondrel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Harry Morris <h.morris@cascoda.com>,
        Stefan Schmidt <stefan@osg.samsung.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 06/15] MIPS: dts: img: pistachio_marduk: Add 6Lowpan node
Message-ID: <20180724000647.okbjmghv4w66bl7u@pburton-laptop>
References: <20180722212010.3979-1-afaerber@suse.de>
 <20180722212010.3979-7-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180722212010.3979-7-afaerber@suse.de>
User-Agent: NeoMutt/20180716
X-Originating-IP: [4.16.204.77]
X-ClientProxiedBy: MWHPR1201CA0008.namprd12.prod.outlook.com
 (2603:10b6:301:4a::18) To BYAPR08MB4933.namprd08.prod.outlook.com
 (2603:10b6:a03:6a::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d86a2ef4-fb93-4ce8-94e7-08d5f0f95b46
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600073)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BYAPR08MB4933;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;3:V945FRq4A6O/959koEbGxNfiK6peQrzmqev1sf+GZZXrXXOgHOquaAIxYmbcNcfpdd53RVzQt4nhbG7fFP33mdAW1kfbDflXVo6ImkbCuPJKrmAMIViKqxNpwu1GRRlbeCioBZKJi430k+snkWceCKey4b2KZ0RyuKux05Na9Opmqg7tHw0+W9jCXJ7JMCmMW+i73f0PiLA2RVQRKuEppvYgE+HAaSS3bmzTbixsjAVaGLHVHnChES3UkfFo8qk2;25:MuJRoSYcB0Cso8m2uoOgRl6G2WMyOzQacm3DSBgpP8JBuhyEg4gGyT6ATItX4LcwlKHqtjS2x2/1kO4OKPm3Uz//phA8uEavCv7n3cACmG++h7ZEVMsTBagSjybQbyZSDJDvNWGFkkrJKMeuvpele/T6MjlDKvwJAbv8UVnuwBhx/UtztsIXNqWZ6kvbMhSOrX06tASbao7ujEHhN7jk/e+cgR4apesPHTl0hA+5qzmMiHwlGfTQ2a0WIhDcIgz3cRcoO160EoL4V73Ul7jvgVjC6mVVfHZww+0lnAqqw/uGqthRZ0/vkfi9TMuZpSNWpTKiN2KGts+HodF1YyBnMg==;31:wH7OQcbDCkxbxQg8zzT768QgdPZyRla+HcnO3Ov3ACeUNOjyd8gWXRMc5/GqH7b1SPlbDrorSMPDmhCd6fIFBdzcPzuRblWqrUG/f+lmPHMihmXypwiOD8h7/ZD4Jh/7vHcGvJhMLwwary1va6DukU6VDtFGGnBhEI8LQ9XVytLJr8nnfqA49S74EiWINTtheV0Qe4lPWAyI//NI60CLidgM2QsGUvUmVi/HU81Hw0Y=
X-MS-TrafficTypeDiagnostic: BYAPR08MB4933:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=pburton@wavecomp.com; 
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;20:bNMSSdJwHjIlVOf1/HTOXZBdmLqXZxsM62Sc2HwiOcqZn+CW/MWaKV/rE2G2GLhdlk5BEdQTl5aWT2kmnz4saWPQyAXVBC1TIEUFHBs4mDxJWBWDDeAq7eDS0D3UXhGUGdtugunhdwYCQiNlf1qnVVgVBvfRAnDinCQUzAmAI7RSXD3tBcOD+dVqj9/WJzemj/pKkROgNuyBSKB75R4Hdz42+IWbd06AmmtQvKm2CN7LgmCggDsECP/V7CfcRPfG;4:8usTkkAO5NwR+JovuW94/K632tolyq/0kG1LnCeFpEiWPVoDwS+jqIFYBtcHo7v825ID/dDUcwXauJhKODbiiF+Pktz/OrdxEZ/ArrW3XpMJPrKY7xH3GFOXFVAqKomEiFxH3AqxklH38DkyW7mq8AsMN028iT96jYa9vrgNrv89w9XXKBXz8/hTm39fUM8ilmc5s+VfymoZlcywCVR3y3NaDUl8RLYddP5+OLxT/ap6mosiHEyGELx5hp3x24gdFSmEoCk/pYpFRq65lPW1Jg==
X-Microsoft-Antispam-PRVS: <BYAPR08MB493350CC99A7EE27AF2B90C7C1550@BYAPR08MB4933.namprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(93006095)(10201501046)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(2016111802025)(6043046)(6072148)(201708071742011)(7699016);SRVR:BYAPR08MB4933;BCL:0;PCL:0;RULEID:;SRVR:BYAPR08MB4933;
X-Forefront-PRVS: 0743E8D0A6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(7916004)(366004)(376002)(396003)(346002)(39840400004)(136003)(199004)(189003)(2870700001)(54906003)(42882007)(575784001)(476003)(33716001)(2906002)(26005)(68736007)(110136005)(97736004)(39060400002)(305945005)(446003)(486006)(58126008)(186003)(956004)(11346002)(14444005)(1076002)(3846002)(5660300001)(6116002)(44832011)(23756003)(478600001)(316002)(16526019)(76176011)(25786009)(106356001)(6496006)(53936002)(105586002)(66066001)(7416002)(9686003)(47776003)(52116002)(4326008)(229853002)(8936002)(7736002)(76506005)(6666003)(6246003)(386003)(81166006)(33896004)(8676002)(81156014)(6486002)(50466002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR08MB4933;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: wavecomp.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?iso-8859-1?Q?1;BYAPR08MB4933;23:qvfDseIpGpcov33wfyUpZm/6f6W6wBpargkuJOR?=
 =?iso-8859-1?Q?DJTyFs0U1GUNydb8vDPq2v6r318wk+Mrz6FueveA7QhiGI0J/twgXwlYDr?=
 =?iso-8859-1?Q?G6bhPpUZm8hvXISULOuvfCds2zvpSWrD4iakmqn8ERIxnjCuyGXMHkniNo?=
 =?iso-8859-1?Q?Z5230pGATa1gPNzn1Sbd6Lk+5Fx9gBXtuTFPhYyjtm8iLMeuP8kvexhELi?=
 =?iso-8859-1?Q?Fb0wsJR8gxW6PUzjUqPIlsAbuNcSsf3eZensmOufd8G2LHWYqJQ9MsziF6?=
 =?iso-8859-1?Q?SkesqeqyiaoG5y0PggW5A1U18HyRXlwmweZDzBNgKM0da9BhLxTonB7B99?=
 =?iso-8859-1?Q?OMJ1fZF0TWKEWaKItOG/poZ0UQnbHnEWhoj+hqpx0fe6yyDZbfFwSUGM6X?=
 =?iso-8859-1?Q?XR/c8u2ak3wj12WAUCIaMhuluahNlrxb0lwjyS+FAieeY0bOAYrDYb7qw9?=
 =?iso-8859-1?Q?AsfV5g22DDxW8Thci9DcBPMxjYc84pANzVcHgljveXKOfLsP6NvNUa/yr1?=
 =?iso-8859-1?Q?j3KZ/G4lxuGNSBTkEo2u0Qxg9Ml5CKdbgmm0OIYmE4UlEGvSQsAnSv7SpC?=
 =?iso-8859-1?Q?rzIaCTLgZNcumwNSRd0LQhm2c+4HF0cdbyUAsDz/VSheSpg0mrwOC3VUHa?=
 =?iso-8859-1?Q?pKlRbeTPn4dy01HjJZZ+C+OQxpt5v0FsXYD3rzj54HT79+gFZeMCHYhTdF?=
 =?iso-8859-1?Q?UPGRxYK87geP1SjVYW8Y8jFebMWEZUcmR49NIXDOUXJGL9wEKJv439o/WR?=
 =?iso-8859-1?Q?vQNcEeYtBnDlNA41D5gJipnUO9vWh8FtnaAbwvOm2yljLBDrwBguQjcPWn?=
 =?iso-8859-1?Q?3I1BWCZHxP9pIbhLElsVxuujsRyhGnh/nOfAo6OFKiQN3x6nlmnN9oMLRF?=
 =?iso-8859-1?Q?Pq2RJQtbLc9J1T8GYY3UySnOuHF84OjISgJZ6MiCAXMYF6Td+LEKnyGgLm?=
 =?iso-8859-1?Q?xlMVLUTSDbFcJGGOkvw2TUPz/QgtGn40udvXwipOzq0NcJbZ4ME5Hm7IId?=
 =?iso-8859-1?Q?vYa18agSUMNWprTdB0Z/wYZ8tC1r9+J0boejiOQwRWe+GAgwf/MPY+3dlS?=
 =?iso-8859-1?Q?+wr1rHi9apv1sMEwkQdYsLTdlL+0kSg3H/KHJbCdehuYkC1yM/lugNQFXL?=
 =?iso-8859-1?Q?DCjNy9FpYrqjnKH0aUI10Nv2nH0h+bqrLvwU6CwXNyLTDHNEf00MN+mItA?=
 =?iso-8859-1?Q?zO5y8Bv0Lbs6ROsAuSc9627R3xgQ2gB2C2eddH+iEbdRC/XuXrpafW3H0R?=
 =?iso-8859-1?Q?ZM6dbFeD3qECd6DkXpUVshgDis7HO18nvXLSyCZd7oc85HSFennUKo19z5?=
 =?iso-8859-1?Q?Mh1CnVaJJBXwGpndcFQ+ltzRnAGgXSCS7I4R3J0Q6+5jrm/51JieLSpq/C?=
 =?iso-8859-1?Q?bL2tIcppad5GuF7mwvOnm5msARl/FYjVYn1xi7hd+CEFSQfRXCSTX/YXuU?=
 =?iso-8859-1?Q?wLealJU+VPh4LL2qPSued/by9QzLMYVPid0?=
X-Microsoft-Antispam-Message-Info: DMX5TPOgIiXw1VuwjIcZFYsBIESelWej6jzbfzgBVfDR5Svb9Xrl1pnJppmxVUbvkBy5NVYz4q95+N0349LxREtXsOl1OVvxXREgE4vMIexCTyHuGzopQrLrWcHwelNNtOfazFt5ze/qgxqYqenz4BHZgh8PlxR4EDzc3bcHC6M3gtby22qwbIGbkRLkDA8+ov920WkW4K37EZRzOXbh+QKCC61TF9xipABbE//QgLzNzxPnJ8KlKWBmcd+343Jjrer6GX/H8kSMxHAbwOo6LR3/9omU4k1vRKr6YdYN3l7cSW/JMDSzeAKFF0x0GZuGEs3pUZkAFyQX4xgOoDj+wRyvLTv9fBcJKrDSfGmh8XI=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR08MB4933;6:MWP5BYaMC33H9n8uZVZNFvmz2QZoPYrqD7ZyvtqnIZ8DCL8yQDpTuhYLWJmE7g1Mco+Yk52haXQytF8jeRfumSnLHvw4FbKaXV0QxA/oYok6Sv4x/bLaVws4yxrurGJMxcyp9AP3YsKHkn+a51YUyvyc1QqNutiKBo7tPuG128OhRf4lOeJP5+eoA58cLnkf6bqG7L9NY/OjIef2J8DnPoTpjaeDO4XtFbAbDvPvH8LrAzaM+lnvpEf4TaWqa6g4nh4+qKd7l2pM3QXdSdEJsmZIJES6PTt1Ffk4vYzReXUbth/Kv20qvMBSqC8bmBNRxK6ozsBKIYLye0NgOsr1yNgQ9wVKl1qtQ6BEcSnBZZAHdNRzMJRO19GeLNgk5BlZBhgM9dgHzE/HfMSjA8GKkcIy1SfL7Mk/EVQIG7iYA4YuVI/wC78NkCP+1mbcyPeM1hiLZS46Bqf1oIWDbjBh0w==;5:+NorMbFNNF/3CypQ6VlxgAMr5aVB9JnJkXC7s4SnJjchV0kHM51gX73XOPyFjj+Gomh6OxbYyN6hhSrVuukslW6h45Ygd+mFu4oXmg7NAD7H/SJwoKncLGjOM2UpS7Mp+7KX21LyFy9mZCeYD6A51mw2kofUMCpUuKsQk6jOI7A=;7:iSEXFNYSlVCxb20+WXb5y4agw8dt5VkpL8pE37cYTnuYxiYExZ0k8gtpVSwJiF7mojHDYGgoy+5fmHs2Uf+MmZ6Vc8M+rV91CtUM7rcnvrv/WoqfyEUNWoVVCtAKHW0DBDMtIYOhS9pXjK9gQbWGa4HATLCa3GqoGA5UdtZ+2A0iMBYSDWbCXOkF7ey6wa4eNCiKUSIPSdFkYpCuQRgT083nLmAH4UyfTn3VUo2LXblQh8Ixr3iZdEI7EJJID6LS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: mips.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 00:06:51.0497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d86a2ef4-fb93-4ce8-94e7-08d5f0f95b46
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 463607d3-1db3-40a0-8a29-970c56230104
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR08MB4933
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Sun, Jul 22, 2018 at 11:20:01PM +0200, Andreas Färber wrote:
> diff --git a/arch/mips/boot/dts/img/pistachio_marduk.dts b/arch/mips/boot/dts/img/pistachio_marduk.dts
> index d723b68084c9..b0b6b534a41f 100644
> --- a/arch/mips/boot/dts/img/pistachio_marduk.dts
> +++ b/arch/mips/boot/dts/img/pistachio_marduk.dts
> @@ -158,6 +158,20 @@
>  		   <&gpio1 12 GPIO_ACTIVE_HIGH>,
>  		   <&gpio1 13 GPIO_ACTIVE_HIGH>,
>  		   <&gpio1 14 GPIO_ACTIVE_HIGH>;
> +
> +	ca8210: sixlowpan@4 {
> +		compatible = "cascoda,ca8210";
> +		reg = <4>;
> +		spi-max-frequency = <3000000>;
> +		spi-cpol;
> +		reset-gpio = <&gpio0 12 GPIO_ACTIVE_HIGH>;
> +		irq-gpio = <&gpio2 12 GPIO_ACTIVE_HIGH>;
> +
> +		extclock-enable;
> +		extclock-freq = <16000000>;
> +		extclock-gpio = <2>; /* spiuart_clk */
> +		#clock-cells = <0>;
> +	};

dtc complains about the extclock-gpio property because it expects a
property named *-gpio to contain a gpio-list:

    DTC     arch/mips/boot/dts/img/pistachio_marduk.dtb
  arch/mips/boot/dts/img/pistachio_marduk.dtb: Warning (gpios_property):
    /spi@18100f00/sixlowpan@4: Missing property '#gpio-cells' in node
    /clk@18144000 or bad phandle (referred from extclock-gpio[0])

Rob, perhaps this should be added as a second false-positive case in
dtc's prop_is_gpio()?

Thanks,
    Paul
