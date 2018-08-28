Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1B8BC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 666982086A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 08:31:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="dstT5i6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666982086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbeH1MVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 08:21:55 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:27552
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726954AbeH1MVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 08:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdxUnsvokFmjFysgrwGAYPpcQw+oOmxs47Mv058RdfY=;
 b=dstT5i6cGNp+6MeoJejsgy1l7K3La2KrkmGQfv+LyR056FSQZ76wffkP0wy8uPNPUP/uSucxFjgXnPbSY8FX0dnmqG4sUDGYgvsJWTstJgFzPfO7ih5jiapO2ZMxf/lO7cTcYURT229zSfZySMFa8keCj7T4ljJJ6nEdmtTJw6U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 AM6PR04MB4664.eurprd04.prod.outlook.com (2603:10a6:20b:1b::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.17; Tue, 28 Aug 2018 08:31:18 +0000
Subject: Re: [PATCH v5 1/2] devicetree/bindings: display: Add document for
 rockchip RGB output
To:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de, robh@kernel.org,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1535443954-38806-1-git-send-email-hjc@rock-chips.com>
 <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <2858027f-69f5-57ee-d14a-2f0b329e8e0e@ysoft.com>
Date:   Tue, 28 Aug 2018 10:31:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1535443954-38806-2-git-send-email-hjc@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR06CA0020.eurprd06.prod.outlook.com
 (2603:10a6:20b:14::33) To AM6PR04MB4664.eurprd04.prod.outlook.com
 (2603:10a6:20b:1b::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a79f9e6-bec2-4d1d-0d16-08d60cc0a0c0
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:AM6PR04MB4664;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;3:ufDcah4AWdZRzcn52AfyHIUUtPSwH77EUvbuu/5hFU0jC6gabBaQ5PcXgpPRMGo7ArB8ojWlYQ/Z2tB7ga7aUqeAm7vRqNNbnWncgWYzYt6Bx7bhjAp8MKoqXSIncAxqni478tuc5nJ5kVV3/PA3l9JgBkAdP4+3lbepT3sDusfRgvSXlEsT+iphVU4Yu3lHH+7Lmts8f3w4zu4+dtml2zETrSEefsx4tsAISCFUrFFd9EcB3Hc57cu18J3Zwmd0;25:+rTnwNyrMY4Z2HFf5R/M81I9d/XmiKH+56XDwyTImu6IjbNIPHNzgI/lrCaMCRAFX0kjXWAFU8RtWlIdoNd2cVDlEhuZNqP+PE3AB2OrQEyP8lcY937zBw3fQPldXx3l2dZJ2vwNnUOGfKftIGa2lX9+0uUdVpvJhutnhMvs0PH/oFi2hZ9OlTd99r8Z28vP2mAhRV/brTieUg/dv3zvHlezpu4dJHEXTMMbQ3VwtgFrfyPNEUcy78ak0l8ssBOm/1qMK8y4KZM6FSY/fuN0Xj4s7nqf95xogIDUNJMoQdUjdaTXq++lTKJKHiimpfFwptuB7QfHE9FZRIg9OFfp2w==;31:7tJdZaublQeOiA3XkuSAa4EV9nT/X8fWEQKrHioYq0ZqfSzssECGfw7mMaxv0r3s08/Et9/I6tPCayDQLJzwbSSUPYhgwH1WdDauh8mxcBo0ZGnkVXcKhFmGbqg076eyE0NPPKZHqh7sxVOAQTIs/5doaSvoaM0lFDYCu5JjQ5cFQ9W83KSBDIcjxwp6+WqxF0+NpSB3oPUM+mr9TLjZ3RgHrUC/ssl+2DI0F9u2yuM=
X-MS-TrafficTypeDiagnostic: AM6PR04MB4664:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;20:BeuVbanORSptRjPh9PB2BXZQuRuqCW63b1c+drPrNtHLj++6gfNNjikNxnON6AGP6KUFEunZ58a2qwC/PbPrhLoLFY7NUeI5KnjOOvSf+KlIQyabIDDupLu4BXJxbj/0uOj+ktsXGyhRARltW1yuZLkgffbU5Wtb9Gu4JYIMaSPVcPl8jUEa2p25thhyXBsNkXhu7AP/OcfapgxkbsJH49yywEPq7g74c3Bc9GJB8hVXyiCYG88EoJeBI9AZAO0X;4:Jags87H1iaLOXcJmfjrNS50Hd6WZMhMnjp0NrT/06DWtprjjAHyIa2E5O93IDYfhKhQKm3nbmml4Ow9qwnOXdu6mJFCCubdFpYvFx8FjuFbjHh4yYBLhYvTyYVVvden4HuJYPkIyTgXX6zhRgwMDM/UsJS4hUB+uALzOedHMr1EVYKbdZKChzJdbF5/sfN2AmXpnLUD79rH1y9b28oXcOm5CtRfW5ore9+8B9AFxh1U6HRQVlr6kUVUXDwcflg0t1YF7vkZWVtq0PBObIxYC/A==
X-Microsoft-Antispam-PRVS: <AM6PR04MB4664CE278C2EB197C7753AD99E0A0@AM6PR04MB4664.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:AM6PR04MB4664;BCL:0;PCL:0;RULEID:;SRVR:AM6PR04MB4664;
X-Forefront-PRVS: 077884B8B5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39850400004)(136003)(366004)(396003)(376002)(199004)(189003)(58126008)(47776003)(5660300001)(81156014)(486006)(65826007)(81166006)(97736004)(305945005)(8676002)(68736007)(7736002)(106356001)(446003)(64126003)(476003)(956004)(230700001)(2616005)(229853002)(36756003)(2486003)(52146003)(6116002)(6486002)(67846002)(6306002)(52116002)(16526019)(31686004)(50466002)(7416002)(386003)(2906002)(53546011)(72206003)(76176011)(85182001)(23676004)(26005)(966005)(105586002)(11346002)(478600001)(77096007)(110136005)(186003)(3846002)(4326008)(6246003)(25786009)(16576012)(65806001)(65956001)(6666003)(66066001)(53936002)(31696002)(316002)(8936002)(86362001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB4664;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA0TUI0NjY0OzIzOlJrU2dQWmU4QUljbUhwOTc3SW1jSkhKcnJv?=
 =?utf-8?B?UnFuVDVlUkI4TUt4bHpGdVBIVElOakFRY3ViTEUxOXJsVXhHaUxVSmhxeFpQ?=
 =?utf-8?B?TEVyYjFaRUNPS1Z3SU5KaWduQ1kweDBCRnFPdWJUVW9FSjdYNURmTFhMNTh6?=
 =?utf-8?B?UExxZFA4bEN2V0RvMG1jOWVwc25tVURSODA3akJ4dFdHek5sajdJVzRoUFNn?=
 =?utf-8?B?MXU3aHdvdWhBMlczdTF3WDd0cW1IL1lzeHkzMDhoR0Z2TkhtMytzc241TGlC?=
 =?utf-8?B?QkFYdGVsdUJPWDcrOW9OYmFoV3Yrd2FRSHlQUTJyMVFLUjU3WUp2UG4yNnNy?=
 =?utf-8?B?UkxQc1RVQWduM2NwNGY3MGlSODhnWEhiOXp0V1VYZm1xbDV0MDNIZ2srMnZo?=
 =?utf-8?B?R0VpU0xVeER1eC9iNGNrZm0reW42NkJ6QWZuc1RsWkpWRG9PQmtWSEZkMjBl?=
 =?utf-8?B?SnhkOG9rc0hUd1FGWGhua21pY3BXTmZHbENxYnlBOEN1bDV4QlM0ZjlzaWVr?=
 =?utf-8?B?dW1FTEVzMExjRTdySFFGSmsyM1drRjV2c2M3SDc3VkNFUG1hT29sVmNHMGJI?=
 =?utf-8?B?L1dxc1JkdVorT2wvUFUvNTZDdjVGV285Yk84MEttZkVBK3FuSXRmdndKTUVk?=
 =?utf-8?B?V29BcThBZXFqN1VqblNXQlZnZUV2S2hDK2xzeGRDKzlScDVnU1N3bHE1VC9V?=
 =?utf-8?B?MUNiY2ZibllZRUZocDExMXNKb3N0bkFnV2dEVVMyR0l0b0s1VTU1Uk43dVd1?=
 =?utf-8?B?bm9udjJONUpObFAzK3h2WFhNdHoxTnMzZnpVUkxmM1d6MFB0WFBIYWMrcUN1?=
 =?utf-8?B?K0N5ay9JdVY4VUVFVUlJRFFRQ0tZQmFOSU5sbG9XQkw0Z1lVc3hsaDBleTFH?=
 =?utf-8?B?ZVVuaE03R1duYWg1d0gwNzYrTFhaalBVOXp0MzduYU5WSER1bzNrM1kwMHVj?=
 =?utf-8?B?Y2lTb1p2MmhJdXBSenVGMmNVc0grN254YjNQaFlVL1NwQW1Pd01PNkMzS1dP?=
 =?utf-8?B?Y0RUYVBLK21wZUgyeVpHWkRLbWVndFpudE5FSi90VHRHOHk2dEhmczZQUG1R?=
 =?utf-8?B?ZGk4RWFBWVZuNTVBTWlmbUNxaHhXd0cyM0VPTFhqNCtSQStzeU1oVnV0ck9X?=
 =?utf-8?B?MTJRTmhQM0JFNFM2Q0JocmtBZFpWSjRXbGRHSzdhMk9VSGdtZTNtTkwrK2N5?=
 =?utf-8?B?YVF4VFg3SHFWRG9HbFNUUy85bnVvYlZ0eVJvWTE3UlFMQnNXblQyVWJqKzdG?=
 =?utf-8?B?eTl6dTVUcDNUZkRXVUJMRmZQclRKa0FMdTdXQVZPSkpYdGVSSjBpMXdXV0Nj?=
 =?utf-8?B?NzVQMDVzZksxNXQ1dFlzTEljSkZxM2ZUNHd4UXpYMXJWUmk2ckJHcCs2aXI0?=
 =?utf-8?B?cmh6eUZTL2pZOGE3VGVlaGVuTFV2Y1RPbzhvVnoyOFpnMndzdUx4RG5zWWhB?=
 =?utf-8?B?WGx0eXlzL0tqWTdHUnh1S0hma3BGSTZRcUUrNHNnUkh6ZFZ0KysvY0ZDd2lZ?=
 =?utf-8?B?Kzh0bEE5blFiTFhsN1hFZVlJaVlaRDFRMTRpcmQzNGZtSVdZL3BObGQ3Rlgx?=
 =?utf-8?B?RlpIUmdzSFc5QUc2d1I4WXJJNnppU0NheTBFTFcyeCtBT0I3UG9HNHg3dWEw?=
 =?utf-8?B?V2dnVHFjYkM3UGxIOGN4cWhXQ2ptSEdqY1B0Y2dRMDZRVGI5dCtCN3NHZXJv?=
 =?utf-8?B?bEdZVUtkQ3BWWDIzZldvTi9oVUVHQk9kUkxBQXMyNi9wTFN5SS9ML0N4eGl3?=
 =?utf-8?B?cXBQRjIvNE5nV2JuMkJJMm5DZ3VPNGtscC9NVnRQQVNiOEx4TXk0WEMyR0NZ?=
 =?utf-8?B?Y3A5L1FPRHRMT0ZNSUgyeXA2dHhPTW9HSTVURXJKR05Cek1uWkw0MWt2enND?=
 =?utf-8?B?SmtYUTdtaXRBMDFvOGVoeTFMcGh5cmRoZWVKcnkvOTBzUUtBKzRHK054WjMz?=
 =?utf-8?B?ZFZjZDdYODdRSzlSblFUMUxzK3prVFdBTXIzZjRCQi9WY0FMZElOUUVPS2o5?=
 =?utf-8?B?U2h4YWZsbGVQeFh3SncwTVpDK214dVlrb0FpN0xCY0dXR1doK2htRndCakJt?=
 =?utf-8?Q?ipQCAmOkPR4SlyD1OBrCRA+Z1?=
X-Microsoft-Antispam-Message-Info: bmqLMbA44tyKBytMrPERzzftompKrIBRzQ/hvdxgjpX23vaikaN5tYr2swL0jZTwXY1sQG1pgzxO09278w0Me4NplzXPYhoNbCzKVkumFrnW137haAw4GTe+6t5DuKtIKE+vZjYxOEB4X92psZsmmRnbwZwVwUomJUcUHLtm2wBqWkHc3ye+AXAzvUGmP6C3yzUvNHZ9y6k4l+o3tY/pjwU+PrvbHQ7jev0QLGjGdffkmPJl/Cg1EP9TD2obCg3wUsYF7Sro7ai9Dr0x0V3bDtLaE+Cw1hILwmIsoy6Me4yZfzWZPnaqaAm4g3fTzhWwHp0RnYdLGSx8YT8jIakvgO6CkqA9vDZHXyTVNoBgDT4=
X-Microsoft-Exchange-Diagnostics: 1;AM6PR04MB4664;6:nAaAiA3wZPuNeuu4hOlvFcEmlf5U3EjmcHhyduZ1RScnMFLlKiweiHhuQFTU+XOM4jaNO4FrFaxPLd1lpAF5fX9kcIcYRDA4bqkzY0nrBhQCzDi2mRNtdYp9STyYYftZP2YuQATCvdIRB0V1rnjrD6inanW6cOufmnlBllsrdsZInD6m6sRmqYYYijJM0sOVkMPImLI/nKcoHsoQ91NIDAOTGfNBHflimaeUDT8Xkl5PoHh2MW884Ndt3B6Cv8ss8tV5FMJVhHQwTdoaDIe3QKjKqv7SDUyHrL2K6QmusrcSeJJ8WRHsQlPmM6G/1ySwvf4pk8Jnqo4hQbDmRd8X9OHEtSFe6FSiquobuJyxSBocdVvcCXOkytp1RcPdx8po35SbOEF5x/kpdJEIYLotCJDWEUTuZ8OuIvZ9kTJMyTNqB/jujexJfh3yKLx+HUahKIHNUE7TjeF/BV/sZ4fHpQ==;5:PU92SFqyA7ch4yPRHEVXCmFZUldmA0puoix8L4eILY+d4675Ae08sfREkLn76SbbgC1lpZzG8HJiOJG2MM2YIWrUbxI36qH+CGeZs57HqMt4ZOtG7EvYRqAeLKhQxpOUKDH2VIgKtpn4OWiMTzIxHG9zAoHSw42OgpV8tVwN55Y=;7:Cp1LGJDPkiTUzj1p72DxcySLObUVcJTdYa+hSApcPiTI591m6xpiQCTrxxvwBhcuxxuHEpmQk0c11WiN4Y/Yc0AzMRGjIM/nHaUwnubSjqNaTk85jfoNj0jOfSIZtEPArhgViYwZ0j4Br4Yx71nfabSIEhImTA9I+MtCwWOpO3L30LDa7EbPdgIdD3pXlBB4o4ObQzdMF2iSw54xceLBEpPtxudqwtcTBFUVhLAQwsrC0He43wBj99CWfQjwkcMF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2018 08:31:18.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a79f9e6-bec2-4d1d-0d16-08d60cc0a0c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4664
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.8.2018 10:12, Sandy Huang wrote:
> This path add support rv1108 and px30 rgb output interface driver.

Hi Sandy,
Seems like you forgot to address Rob's comment regarding the "driver" word.
Also fix the typo: s/path/patch
The subject could be improved as well: s/devicetree\/bindings/dt-bindings

Best regards, Michal
> 
> Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/1509522765-118759-1-git-send-email-hjc@rock-chips.com
> ---
>   .../bindings/display/rockchip/rockchip-rgb.txt     | 70 ++++++++++++++++++++++
>   1 file changed, 70 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> new file mode 100644
> index 0000000..1f4909c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-rgb.txt
> @@ -0,0 +1,70 @@
> +Rockchip RV1108 RGB interface
> +================================
> +
> +Required properties:
> +- compatible: matching the soc type:
> +	- "rockchip,px30-rgb";
> +	- "rockchip,rv1108-rgb";
> +
> +Optional properties:
> +- pinctrl-names: should be a "lcdc" entry or a "default" entry.
> +- pinctrl-0: pin control group to be used for this interface.
> +
> +The rgb has two video ports described by:
> +	Documentation/devicetree/bindings/media/video-interfaces.txt
> +Their connections are modeled using the OF graph bindings specified in
> +	Documentation/devicetree/bindings/graph.txt.
> +
> +- video port 0 for the VOP input, the remote endpoint maybe vopb/vopl/vop
> +- video port 1 for either a panel or subsequent encoder
> +
> +the panel described by:
> +	Documentation/devicetree/bindings/display/panel/simple-panel.txt
> +Panel other required properties:
> +- ports for remote rgb output.
> +
> +Example:
> +
> +panel: panel {
> +	compatible = "auo,b101ean01";
> +	enable-gpios = <&gpio7 21 GPIO_ACTIVE_HIGH>;
> +
> +	ports {
> +		panel_in_rgb: endpoint {
> +			remote-endpoint = <&rgb_out_panel>;
> +		};
> +	};
> +};
> +
> +For Rockchip RV1108:
> +
> +	rgb: rgb {
> +		compatible = "rockchip,rv1108-rgb";
> +		pinctrl-names = "lcdc";
> +		pinctrl-0 = <&lcdc_ctl>;
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rgb_in: port@0 {
> +				reg = <0>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				rgb_in_vop: endpoint {
> +					remote-endpoint = <&vop_out_rgb>;
> +				};
> +			};
> +
> +			rgb_out: port@1 {
> +				reg = <1>;
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				rgb_out_panel: endpoint {
> +					remote-endpoint = <&panel_in_rgb>;
> +				};
> +			};
> +		};
> +	};
> 

