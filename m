Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4E7C43143
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:08:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E89C8206B8
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 02:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="DBk2wlk0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E89C8206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=synaptics.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727396AbeI2Iez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 04:34:55 -0400
Received: from mail-eopbgr690075.outbound.protection.outlook.com ([40.107.69.75]:19418
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727328AbeI2Iez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 04:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector1-synaptics-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPdpWCvhTpTSX8vS9r+xAxVvYIZbTSiFs6ZWAHPQ3UU=;
 b=DBk2wlk01RNtc1QjHylnrIlAQ2ZwWlKhrENGewjal3XgElrdVnAc0eJangpGHl8gUN3qDRtZ5p8RCujueNOf+8trChAJboo9ZXf+Pj+u6gjZnLMGhiXSmzGnyntwBA8mzCeQH77t6bq3vuMHrbhLanP2C6o7gW7+MpunoSTgyms=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Jisheng.Zhang@synaptics.com; 
Received: from xhacker.debian (124.74.246.114) by
 CY1PR0301MB1579.namprd03.prod.outlook.com (2a01:111:e400:529c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Sat, 29 Sep
 2018 02:08:19 +0000
Date:   Sat, 29 Sep 2018 10:04:36 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Joe Perches <joe@perches.com>
Cc:     <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: Bad MAINTAINERS pattern in section 'ARM/Synaptics Berlin SoC
 support'
Message-ID: <20180929100436.08f931df@xhacker.debian>
In-Reply-To: <20180928215132.28867-1-joe@perches.com>
References: <20180928215132.28867-1-joe@perches.com>
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.74.246.114]
X-ClientProxiedBy: KAWPR01CA0063.jpnprd01.prod.outlook.com
 (2603:1096:402:b::23) To CY1PR0301MB1579.namprd03.prod.outlook.com
 (2a01:111:e400:529c::17)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb050d90-6256-4849-e1bd-08d625b06dd6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:CY1PR0301MB1579;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;3:UDny6Ta9apdmVTVyizpuXAkdKp4/BeyFI73s06xwht+EoALGpxSfFo4AMH5J8bjkZhtlM2KZN0x5DVni5q9DZKdWabfkPJ9QMNrVUglfrf6yr09rSnTUCRzdCJZoHVFZCPPsoDbIvq+7nt7M7DOvtOz9QwhYcEGrU8T/+qv7eTTQaLM1YqHL1bYXJ1DQuCgEQrnM1GPbWUt6YpW5LkMto80JuzPHPRXZFDJJkqdGWQ9TAsg7gIpfz4SyLF5anP12;25:S9r0BFN+/3MUqI7yR+mlfYXgK8E2oQ/1BdLR0OYT+aoP/sDcNNiVQ6DOkAEfhUABvIKktARWovujyaoIA54NOQqC6lkaKzrJzg34Ef1yzaA63pftFJVOIIpukSSNg84vyGpLwdEIf06KuQ6fYafqPB9RXf6Q8dlaueno3eYWXCF5U09ZaWuDrI++Z7eGwEZC2gKG4a0dyJh/PQ1/3RNa9vd0Pey838xe36QhafCagCt0WHbye1J3e9dguQ49xOFWoALlafzdflkmNUAJahrcOza0+Io7YmEeeN5aVO/W42Htixx5yaZ+GlkNGrsuo0It+Nf/6QpL13+/gVNm8B3IOQ==;31:/0fM3BCGI4Y+Xv7cVvDfMhfZJJKpEPdITTnDctKNY0IxOomYWmzzFhwU+YvSnO8/CjkyRBbZi3UTsdnq3swMloHEXcPzqRTccrdnO0P5wesvD7r1KFfQxD6Rcj431pcez0XBkj8hN9vmUFDGi3H8IqKobxbNPSmzT+jhQY0zY1/djB0saEl9kjwniG0EYADC12MMoNB1ZuCvVQLw38377HN6o4W1pbIwFwl5Q4hLQIU=
X-MS-TrafficTypeDiagnostic: CY1PR0301MB1579:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;20:pz6YRpjfFKqoNUdoNfuumgx4it6DTqWDs6ciLSnoljLoRGg53Xoa+LW5M4Gd+6LQdRtCW4TIg4q6dGoG6yr228CXVtijh0bZj8lJ9EyHLzbq4/7OYqtw7y5bII6E98DA2bx1Wzuh1rwloDIkGhcse+94qCi+jX3Wyno96eGL1XwmyJq82suWcm1b9mZV8ZnTRS+Y57WOXB5hz3LmZbfXMO/5RiUgs1kcsBzIe/RwUoF4pTyA8B0aoUn6zKIep3Nu6+Hiq3rtWWLnbxtC9aN5XY5N1+wyc/G9IF2oVK0P5/gLQpm7kNNsY9qzVZrx0dsILnA9WcOFs122JK0MsSi2W0SPqbm0GZYLQvwBgk7DY+dzsc80xj0Klryk9HnLjRNtNKpQy4LM+h6nZMtPpPAgfbrlbiKfI35xOPY2GXskUwrewuB+EPAadHfm8ill/JUMprRV3AAXX+RqRTnDzHcoIIxCtCUCmL0NW76LCeLJhmL3gAkbZd6h4Prb4xtPJpeW;4:18tol+St4mDJBpivlXRsu3W4K3I0/EHgU7l+mmUHovLMtvpg/kY0I3ZAbmTyLpVb3qLxsIOHoOWSMHrM3FbgniHQHUGgphZ79cYzKkmnrVOLjmFlyEtE+rZbeLgvic8jQEWA5FESn1soKs9KDWKC6zB6AtH3wCobUAABBrivgz6FwWLp/6W1ZZQ9IfKbQmihGaAgvwXCoeEhAth2ZnTprQyXrXSeKZtHfcuyhOEFoabZt3BuxNI2ZU8juoes4MxqlpbRoWZcobLagd2+ISRFSKkJKYvQWgnpd+3DO6yPJtCJd6CQ0yy38/sWVUr5C9hRmRcGbdUoFMSATSs/bPXtUspT922NFKiSYadOKIeRPC4=
X-Microsoft-Antispam-PRVS: <CY1PR0301MB157954E7A3EDA0F14D830706EDED0@CY1PR0301MB1579.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051);SRVR:CY1PR0301MB1579;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0301MB1579;
X-Forefront-PRVS: 0810818DA0
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(366004)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(39060400002)(50226002)(16526019)(8676002)(52116002)(476003)(956004)(478600001)(2906002)(5660300001)(34290500001)(50466002)(186003)(53936002)(316002)(55016002)(106356001)(81166006)(229853002)(54906003)(11346002)(7696005)(97736004)(72206003)(105586002)(14444005)(1076002)(446003)(8936002)(9686003)(25786009)(4326008)(81156014)(305945005)(3846002)(66066001)(7736002)(386003)(6116002)(6306002)(6506007)(966005)(76176011)(86362001)(33896004)(486006)(6246003)(575784001)(6666003)(6916009)(68736007)(230700001)(23726003)(26005)(47776003)(39210200001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0301MB1579;H:xhacker.debian;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: synaptics.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0301MB1579;23:xr7a1wJvtcjA2z78ZOhgvnMAZmDlek8HELdLWRM?=
 =?us-ascii?Q?oriNRGEU0rtLqHphoUJukkxqgcbsWG+fxdEhmN4KhqvYF5+OeLzCw0NjRtMM?=
 =?us-ascii?Q?XJnMAyTvd/mhRAlG+KjfaD8VpI6EBP2yqL2LB6TD/3ZDsYfDBmQdWrpJbdHn?=
 =?us-ascii?Q?lorfv51gRuSAgBNIKIK34/1zOLHSPqQzZNA02AKHyU1xnJJ2Yp5pcM0sKIaD?=
 =?us-ascii?Q?qOBhxYmTzWgVcf0i9r7EoAoB2F0CBsgHPRXQ93LkDDzEaFjaCsVsxxfWwZuW?=
 =?us-ascii?Q?1eu7zg7b/2oTc1QiEDYfIvB6aee3TQwQmZ/qYIFN0hW4yxT1tFKHJ7j6/To0?=
 =?us-ascii?Q?p3Kc95vPSmh0aqUqkoUH0zm5WMfbyte5mqtZIzX0L8skwnzq0teG84qJDOiE?=
 =?us-ascii?Q?/N+xTyS35oNEgjy3b+FVJ00Iza5DZIFPl68byQI44xloTC8o/AgaKS+xtrr3?=
 =?us-ascii?Q?439WolmkSf8QptgG0fQFyrxS165iIUucOpH68mYOBEb2fBDB8lmLgI9DpqR1?=
 =?us-ascii?Q?dW2hn4cDl9znPCJdF+HIPgOt3JQg+2S++rhS00a7is4vYI+CoYsUKeB5vXAq?=
 =?us-ascii?Q?zXSAtwejDg+YO42NY7y1rBQq2q5zIPUIlJPRhozyMsimqqCF3zf4cYND2m4J?=
 =?us-ascii?Q?AINwiuhD96Vrv4I42a8hMYhTWuTXwfjdjDBjpJof+dqcv4hTuKLa2q2CP9Gw?=
 =?us-ascii?Q?M4rMCeJ0H9I+qOzsfd/wbedvAMsJ1FOlFoOwo4W6G0S1A65LNcUwPV+/Uoxj?=
 =?us-ascii?Q?2UddnTXHLJgh/DU9N+ngduwO8xCL8hBXLhd4ODE65OopObN2NbI7jim/yY4n?=
 =?us-ascii?Q?nP16DxmPCUn52LRYX1M7VpNKmWv9g3HEsgk5nvGbis4BD3+9OunV7KJBh9Kc?=
 =?us-ascii?Q?tc9hqEeXlE7sYGLSa6+dMZbPR0PZAcDk4fJwXpPpmrsbGtRwbYbeemsOIZko?=
 =?us-ascii?Q?eCMDNmh8no2TdFUJTNi7zDHS3T07sB3A+pPZ17YWW5+yBmBdSz6jG8QC/qgm?=
 =?us-ascii?Q?5kxVxw716vxdqgSq63t7hvhzh6M/B88m2qBqTKxPo96tc6Jjfl7dE8DxOD5x?=
 =?us-ascii?Q?gceHu6FiOd/Nj4Tx9r7BSlrpsEa/itxU2pTtUeXtamKc7N01Nu+eOkD2+g8z?=
 =?us-ascii?Q?p1euPOWOsv6Bxlo2Ukvv/HesdGYpyXjnsd/doAW1zAnpCxejo5E3KYYE08po?=
 =?us-ascii?Q?R7bsgCbdc5xmV+y/64qUhGeqnxDhHPtFE5RwXFe/PU3aCuKyTsE4NBANTElE?=
 =?us-ascii?Q?SSJO+bgk+ivrzbrYgXn6xzl4AQVVpZNITgg+LneXPQwqQpPipaC9tED+ives?=
 =?us-ascii?Q?4ZP73Zs4urF8DhYHKPgnuk9/y9PG/qYNIEZGTNamuGhrTqJ+777IP9096vL2?=
 =?us-ascii?Q?ldaBiXZdQusiqXv6Yb/w5xOzpK0fd/35mbYwLrTrCD9ENu0mO+sm1UKHSBZP?=
 =?us-ascii?Q?PnRXL50DHLQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: PXEaBH1qnGgU5RjxvGDSe2nt7FFytdGMyAFeS1ZHmuCrGzNXnVvEqsxwHZLZVSXSEiNcGqYgZmVxDWo3wtP3eR9L/OySQOfkhZOvph6tEnD3w59/asamZEeJIZfuwSE1ZmkKUATIwS3G+hknpnkjfwvMxWyuY0VXbCT4KC0HO8BSnPeLrM593XC/ymOoxkL6kM+Jb77Kt3xFP9gBLOV0/8fllLMkKQ53bAVfIRKpqAGzJptwsGTI92K38CLhwZqFQWk2Iuyme1MLNj4Jv40pY0wkwqEzA0u3vTw+B+jchC0Nd3Lnk9uAA0ayohn/7PbSDWGW8eLzypmgdo+qgZRe00VkjcKpCC/UuIvDfnmw6jQ=
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0301MB1579;6:hn/nGoOFsJC9ukZ0oPoPPI/GSeHni6Y79ud89WGM9fmh1dqUp9XNNDbxCJf5oc9F3le2CTl32fjyeYeuRuuHMI2T2h7TTzU22WkrOvDQsIOxc/Wc4aXegxaaGl8kPz79g0JH4BIhzeifcqOd9SNmnzZgVffcILfJ4c9JrRTejZ5DvFae3K0uFFUH0U9u5+nka4J+blnAbRP8lsID3Sihj2J0vQLttyLEqQnewtgAeKMAC/H0pWlWBmeSe/88oS5OBE2NVND5V4ET1ZybN7F1sOuipznTMDj5HDmAHElBKioWYdZdUbcxTOHH8Or+90vd5I28rXi13iz25meiQqn3JSgdBKLBhf9Ttwu+MVyuUV5Qmr3FxqFNadjKLMVECOhhYkX2SL59KVapVdML1Sgxw9h3MaVUb2i7B68AnpsDzc8QOyzyimKYk4OlW8iWdgaehd1tabmIhR9jqHyQfEjrIA==;5:KF+vu690eA8fw8iwM/3YT4WXKm4B4hPksZ9ROptzqW1kUriwU5S5wgoutPOaiWV8d9HCSVpAyw9etCkHlsHkpEWcUxVVP3lOz6mwNd44JNyNELpY9F4+S6CIaBwGuCuDsvPe+hAIliMwFKe3EdpAIhDfNEKytSrdCs8BOGGM9xA=;7:KQnE+LYaLZgHm4UScG2dRKMJxcXVSJWeWNxbwV2b48RQ+tPk5WFHvnzkRdXUNHgf4B2FnK+UtFJY426d2DYhTXgIhm6rQRzFwHOycnB499uC5Ch9tsihCWZH0ey5FXwB4C0BmjD6mMblrJn1YiWZamiane97P6A20EnMwYCpmv/T72/HVIuw81C8GVAVK0dDKeDuUamMQYGKzBcy/R58hzGKV0m/tXRTQvItpeFOBvlXd4clsbSzgyjA8TXTg1lm
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 02:08:19.4430 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb050d90-6256-4849-e1bd-08d625b06dd6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0301MB1579
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Sep 2018 14:51:32 -0700 Joe Perches <joe@perches.com> wrote:

> Please fix this defect appropriately.
> 
> linux-next MAINTAINERS section:
> 
> 	2111	ARM/Synaptics Berlin SoC support
> 	2112	M:	Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 	2113	M:	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 	2114	L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> 	2115	S:	Maintained
> 	2116	F:	arch/arm/mach-berlin/
> 	2117	F:	arch/arm/boot/dts/berlin*
> -->	2118	F:	arch/arm64/boot/dts/marvell/berlin*  

Thanks so much. I will fix it soon.

> 
> Commit that introduced this:
> 
> commit bc52497a595d2246923749177d99e4216703b0f4
>  Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>  Date:   Fri Mar 30 11:02:11 2018 +0800
>  
>      MAINTAINERS: update entry for ARM/berlin
>      
>      Synaptics has acquired the Multimedia Solutions Business of Marvell[1].
>      So change the berlin entry name and move it to its alphabetical
>      location. We move to ARM/Synaptics instead of ARM/Marvell.
>      
>      This patch also updates my email address from marvell to synaptics.
>      
>      [1] https://www.synaptics.com/company/news/conexant-marvell
>      
>      Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
>      Reviewed-by: Andrew Lunn <andrew@lunn.ch>
>      Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>  
>   MAINTAINERS | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> Last commit with arch/arm64/boot/dts/marvell/berlin*
> 
> commit 031106ce95a201f6dd4c5ebf35abb900cf34e2ba
> Author: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Date:   Wed May 16 17:43:28 2018 +0800
> 
>     arm64: dts: move berlin SoC files from marvell dir to synaptics dir
>     
>     Move device tree files as part of transition from Marvell berlin to
>     Synaptics berlin.
>     
>     Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> 
>  arch/arm64/boot/dts/Makefile                                 | 1 +
>  arch/arm64/boot/dts/marvell/Makefile                         | 4 ----
>  arch/arm64/boot/dts/synaptics/Makefile                       | 4 ++++
>  arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-dmp.dts | 0
>  arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct-stb.dts | 0
>  arch/arm64/boot/dts/{marvell => synaptics}/berlin4ct.dtsi    | 0
>  6 files changed, 5 insertions(+), 4 deletions(-)

