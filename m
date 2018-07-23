Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE56ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F21720846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="taUlpPlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F21720846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388068AbeGWJ3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:29:18 -0400
Received: from mail-ve1eur01on0068.outbound.protection.outlook.com ([104.47.1.68]:37163
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387869AbeGWJ3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtKy5RMfQRcl3mSDn2/Hb1BsBCZlfVsKu8EgN5Gr/58=;
 b=taUlpPlHrMFECeYtooeeIRq5EnY+rFkz5cfbbCgkBvwTGmpKF7DHYZzoiefvASbZoEQHD7/xM6eb45+0xEOyyceA34JdTPAVj3zroLCCJU0zD+3pfNRoJkfVHKoWUB8SUUrHfgg5Aj+oluL9NbNIrrhCGt2TOOujLgBLXwvL7mU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 DB7PR04MB4666.eurprd04.prod.outlook.com (2603:10a6:5:37::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Mon, 23 Jul 2018 08:29:10 +0000
Subject: Re: [PATCH 3/5] mfd: dt-bindings: Add RK809 and RK817 device tree
 bindings document
To:     Tony Xie <tony.xie@rock-chips.com>
Cc:     heiko@sntech.de, broonie@kernel.org, lee.jones@linaro.org,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, chenjh@rock-chips.com,
        xsf@rock-chips.com, zhangqing@rock-chips.com,
        huangtao@rock-chips.com
References: <1532315945-1094-1-git-send-email-tony.xie@rock-chips.com>
 <1532315945-1094-4-git-send-email-tony.xie@rock-chips.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <4fa3dc0e-13bf-c226-92ba-981296509b3b@ysoft.com>
Date:   Mon, 23 Jul 2018 10:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1532315945-1094-4-git-send-email-tony.xie@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM0PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:208:1::23) To DB7PR04MB4666.eurprd04.prod.outlook.com
 (2603:10a6:5:37::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a06446fc-39e2-4b91-2f8d-08d5f0765d98
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600073)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4666;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;3:/fOOmgfRMz3EL9DthfAtIetAN+HAXQD87s8fo/DT3VFH0z4SBSrizZWFqXdkt/7OQhkWTg7I8RvxqtXH4jbC7dSOJFkFEBcc3dlvsae5S8BaTOkcoC5eGP2SK/EHWhIf9pTJF6qUBEwXykdIYQBoWWT4thjHtEZsqN2aWtCIuUG98Vgfxg7nUDW0uAinzEVUiCd9YYAvi315p3sWRelwur/g4dxeDonJqnvMzb53JpHDmgWIfxS+T3Xl8I+UgANh;25:3EIdaQiZvw6oFxDMp/yRuQsn4Tt7+vvhoFDXpg45Eai3ycUHnKl7RtP1S2yPNqyNzRzXksx+WvZhhRg/vJTFYzERZijUQJvUFz33zkhzr0WROGjEtWoBnhfPlvyUMPSJcaqrTy/49LkEoOTHlwB8u1xZLNlbIagNXC9qH3+Xfle/d39Dph0syVDmQKTvxWhebdvFTYrS7jmIwcD9ry+1lH9rHTJhLigTqdaTAWJvQPSOJIuZkCnfnezo5JbHjR8ltWg2J9hC2p8dSrsK9O4SZrLFrNTPIdmufxaIyMaCbmODbi54SD1FxlZUqQSXjwc+bQUPuQU9CcsTI13qYhhpVw==;31:1v3hFVMQZHLcXRjNeMr8ceddc01kjybAOw1MElRK8XJaV23A4ylzKjNe0ZcA4jxRlZPlA04s6sfdA4v2lIpxVlwO00yvODth5Pi0rOk3I7n6ywwsz1diWGhtifY1NjbTaXDkIRIcsW+tyXZmn3vrPNetugYeCOy0V5Kh9vJfrC5jlelrv9jblTSR0AvOeBIhOhGKXRLSizEov76sO6X3916D4K0u9MxKXSkItArO5w4=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4666:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;20:dqZmmo1gor2JUR4N4pBcEtQzazkEpHx3wiUQgoqDpVlHy/2JBUNYXJ2cbLbHR+arHXUqT3hHLByHq8Z05MZNCpxDty85x8Jm6xpR9opJP2SMUciHxzII/JFOtMgvCThtnxYNG4QkIUTM+KxkiOxXbz5Y+PE/+5zZabdykCp872d1Ea90JJKc42O5pwuuYKddhFfRtW/7lZWIuF0cDXjxD9YlstRm/bMEvriMIwPKGSsp/rbzDB5MxEFsL1HXc1We;4:8mfcojUKW6WF4n3+Han8H/yx++7+AyqrJB4MrZbgcpRFQGlYd3Rvl0nR9zF8sVnNZWL0dXJDIGEzRbpQqVcCriQuD8iHo/2e0A0fToF76h/RUlkeGkPcOjLLcwXJtziderEzSI27TH+Sp+q4hERUlL2M73Grk7oXX+4mFEr/Ha0pGFax5hreOHJbUGaZdZ3KKR5rULlI0okJWhwJMY4mhyUeE1mRYomLWnk/cEx5l5DymZO2Ze9618r/UX61Ue03/NzmyTnbcwWfNh9E1Z1Ot/sd5AjFYsdG9YDoz12Qp/IDnGstgR6Wt3w+MDkvgsDRk0Hj0q1cdP++O37I7sNkhZvEQx8fRJKBS7NZn4xcuA8=
X-Microsoft-Antispam-PRVS: <DB7PR04MB466644957ED571FCE958F73C9E560@DB7PR04MB4666.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(84791874153150)(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4666;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4666;
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(396003)(366004)(136003)(39840400004)(189003)(199004)(68736007)(6116002)(230700001)(3846002)(36756003)(6486002)(50466002)(2906002)(966005)(478600001)(72206003)(6916009)(6666003)(5660300001)(53936002)(25786009)(6246003)(305945005)(7736002)(4326008)(67846002)(64126003)(47776003)(316002)(16576012)(58126008)(85182001)(105586002)(446003)(11346002)(53546011)(386003)(106356001)(76176011)(52116002)(65826007)(26005)(8936002)(8676002)(97736004)(31696002)(81156014)(81166006)(77096007)(186003)(16526019)(52146003)(65806001)(66066001)(65956001)(229853002)(2486003)(23676004)(486006)(31686004)(86362001)(956004)(2616005)(6306002)(7416002)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4666;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY2OzIzOjhObXoyUkJpcnRTb1IzSm9ZOGRmbzE4ZmN3?=
 =?utf-8?B?OGhucDJHYTdRTkJpRTU2enNqQ1B6Mk9GOXhnUGFlQlpVMzAvdS9hK09FOWpa?=
 =?utf-8?B?ZUhRcDRUZGRETXRITWtyR0EvOSszRnFLcGIzV1RlVHFFcFVWVXcrZWduUzJY?=
 =?utf-8?B?bkEycXRZcTBtdjF3MFh2cEJpK0lDcHMrSERzV3A4a1NnVitsN3ZmVW90Y29G?=
 =?utf-8?B?WFdsRFZ5QnJwQzU0ZGxXYXpaU3BzQWcySi90S29aMlVwSmRLTUJrcTljdXNE?=
 =?utf-8?B?S3Y3L2hXTnBESURwamRsVTRsL29XcUgxbkc1WXRoZ3hZb1FLTlp1WkVXTmdn?=
 =?utf-8?B?b2pwSFhzeTlkN3RaZEd6N01uTE92WTRnLzlpUzQ1cTgyeXFFd1Z0TUJDTDIz?=
 =?utf-8?B?N0NQVXppaHYvazUybVk0VGRhbmFhMUJqNlRrWnVENVc5elZrYmlLcFpPM2kz?=
 =?utf-8?B?N3VqZzRDaFIxV0pJMVZVRkphamlaY0pIUXFyWGFLVnlKNzFkRDN0NUNTZGNG?=
 =?utf-8?B?MjBhalJFc2d1SFlCRC94S2p3bHJNSkZwZVBnc2dIWDhkN0UyRFVnb3YrMjVp?=
 =?utf-8?B?U3BLSUdYWXVNeDhhLzExMHdhQ3dza3J2ck9mb3VwQy9rSU85b2pXdUtObE55?=
 =?utf-8?B?WTN4RWorYVNEYzBpK05vMGM0ZWRYUFM4aHc5WXFhNmJidjVvNVZqOGEwR01t?=
 =?utf-8?B?K1BVVnJIalJzb0x6eDNDQ1QvR1Y4N1kxbzV2dGduaWE0Yk5kNGQyRHZ2b3Y1?=
 =?utf-8?B?M3IrNm5Bd3hvS1ErTjFrdGxYYWw4cHJ2Z1laczQzQW5UdEFKV2JSNUpWNWhu?=
 =?utf-8?B?eC9HR2RKR2tEL0RpbnRZdFZ0T3lpTU80SERFZ0dUOElwQXBYNDNxcjRRdm1F?=
 =?utf-8?B?MjV2dEMxd2tVdEg5SzExSjlPd2F0UXR0RDJnNEExM3JhUkp4R2R6Q0ltcmoz?=
 =?utf-8?B?NytsTjBhZFVUQjRTTlo2ZmdZa3IxMHpJKy9mRjF0SlE0K0MvV2V1L0V0SVpr?=
 =?utf-8?B?M1BoUmtEYVhlMmVOWjNMeFV4UENJRnFFTFRYeDNDdGUxODlteWxwT2ZIRlQ4?=
 =?utf-8?B?NTA1dnJZQmR6V09lZGdpUnFaNm5UK2h6R3Y0My9DbitWaFE0bUZvOGd6cEcx?=
 =?utf-8?B?ZEZITWlIN0pMbDlQNVFwS1JqVXhqbStIVityNzg5TEFMNmZidGpySWM1RWJs?=
 =?utf-8?B?bjcyb3lKVG5mMnZLUmNWc29JcDQxVHlnTW9QdHUvRVNJUUJnNmNhaytxVVor?=
 =?utf-8?B?amtGZ3lZdVdGVUl1ZzhadmN1akFZaXJGRTMwZmVuUmV5aDExWXY1c3Bqem5I?=
 =?utf-8?B?NEJBNHpWNmtsZ1hSV1IySGZGWVJxdi9WWVZoWk9JWERReVAycFBaQis0dmNI?=
 =?utf-8?B?aE9iQkpoWUV4ZFJFWUU4ek5hS0FHMVVxMVRMRlZwUDhCdGlTRnoyTkhFQ0x0?=
 =?utf-8?B?M1p0aDB6NkRqbU5iNWllT090RnFUTVVrWlRBVVhLU1VjRjVFWVk1b09WZjlH?=
 =?utf-8?B?M2hTaDRqbXhEWDkvSmlBNVRuTnViODZLUlhHd25KUkxZbU9IbHpHenNGWnRC?=
 =?utf-8?B?aEZmWm5GZUkzNjY3UGk5V0xhNkoxS1lUcEJlNG5iOFVnOFkzQS9nV1BFZDlW?=
 =?utf-8?B?NW1SWW1iUFlvMkUreFFoV2FQVXdNN3g0L0E3cm80UXNtOHdMZnFPL0dJSEZw?=
 =?utf-8?B?cDZFbWhvOTVvdDExU3NKeW9DRjVkakR5UUwrZVJTejJxOEk5YXFVZmZ3cmFI?=
 =?utf-8?B?ak1YTDlzRDRNclZzR1dibTFwZEF0NGcyeG5MdjZaOUEydGxDNlByVmUyMW9B?=
 =?utf-8?B?dkYvdEJ2SGloc2h3VzNTRHhIWXBCanVJNjd2NUkwTkE5Wjh6Y1VnL0RrNlVk?=
 =?utf-8?B?MFdraWdYZFprSS9TQjhPWnBBenF2N0JlQkhaRjg3MmlhbVNRdFdZTVJYTzFX?=
 =?utf-8?B?NndYR2tWbHR6a0tqZkprRDRqZFZPdytQaEZwajdKWEVYb3JwSngzZVJhRnl0?=
 =?utf-8?B?clpxRE5HZXM0Q0VHTHZ3aEhWTG9jKzJlYjY3QmU2Z3h1K2pjcmF2QWhtT3hh?=
 =?utf-8?Q?dLdOxcB8CQo0nE2l0bQkN4nW+?=
X-Microsoft-Antispam-Message-Info: p+qSwb868v9IpYLFPLBb02HHOciMU6m90vVqec8vtE1FY75yKc8IINQNve2LbXBNF4YQjJyQTgSsy0AqlOQOLBmy+wFHTDIgYfS97CRIzxz9oiHhsD59z/RYDlAC+Kqz/bC9DHHBqt4JhXI206/M7jgxSdXcKCv7rq8gJdR/8SeRtyFa5TdjEOUI5+0m+aHliWKYA27TzgR8XM1BbmBQuIoP7uwyOhl3rH2jTBdM6CZlYkwVyouJP1M0zNn4Q1us0SpLpK+YkHJ3aT2A5w/28qJOqt3kTFLQJFfZjnOSOqRCtlQedptQRm57/s5xH4iJkVpEekzlBcG/wu3o3tVOCTSIWnOeoZgSioLBPD0sxro=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4666;6:yu3tCkYQlLiRNCcyv2K+oUWp5mTgil7L1sRT5gMcNjO+XZKW43l038Absyu3K+anDS1LXr6YEyXBiKrxkhkB282VXpKfjw+3tEaV4tK5QBEThaJylsVqkADpRaBlXv/guTe8+hPWcQiRUCU+AaX8pNUc/UEbcnlO3kJtoQtp0XTUUKzAbIz3EAx16abg4S3gEy0R2NmLslVNt725HcQrAISKF8Uure+e0pIHO039qDdwwZa3f+xb2LguZjS9FXPP4FPgYjabmpvMkjAv1TTAS8d9EW7lLfP+NG6wIhszUkBeTMHeDH8RdCwCoIx0W89CJ7hDpL8FRkattTcMa8uDbRc+2f8FA/WodnDJrYKL4iZ5czDGtiqICCSxVtYDgX/8T5TsZDV2RsfD7r9Hk1gywxRmwY5fkMw4Lve3hxE9UtDK6X2SflDP50NAgUNgGu8MTeJlSAtN6m5QktjqRgt28A==;5:J3JOMaPworPxNnVbS/+gXfcsy4LEeo6giPW1EWYdFZeWqS0kaC2AeumKJPbgJ6dU6B9MzC0Es6E4eT1VzAn1SFSJSIu5qpPDAQTz1zOQvDB0NuctQtGFw1U7bbCVMBtsDqOCXR1e53GoPXDc/wxnOWGVRgpLeIKkIaCFzyfRYps=;7:49Jb3KONSglF7qm1h+hqxWGBR7unYNNt5kzmXGoT4QQnAlWN31OF5l9GRCjXUPgyqeNjx37x38EUsxwT6KgMssofI/WdthQe4TTh1nU1Gwn32PAyzEov4sGqV/IUZmgliDm7lDa/Y+pdqaWEHVmGoRzpZ0ShDJioaoOezUXHPn4qTFM4VctuQOkfV2YuSB7k3NTExuyG16NiKg0me9Sz7UlCVxIAQZI29uSKI7TIEvLYIPE4Zxf3bpazGCspWZTr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 08:29:10.0167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a06446fc-39e2-4b91-2f8d-08d5f0765d98
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4666
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.7.2018 05:19, Tony Xie wrote:
> Add device tree bindings documentation for Rockchip's RK809 & RK817 PMIC.
> 
> Signed-off-by: Tony Xie <tony.xie@rock-chips.com>
> ---
>   Documentation/devicetree/bindings/mfd/rk808.txt | 55 +++++++++++++++++++++++++
>   1 file changed, 55 insertions(+)
> 

Hi Tony,
Seems something went wrong with your series. The introductory email can be
found only in linux-arm-kernel list but nowhere else and I can not find
the fifth patch at all.

Formal notes to this patch.
- Documentation/binding patches should go first in your series.
- Subject line should be: "dt-bindings: mfd: ..."
- Try to avoid the words [documentation, device tree, bindings] in subject.

See this patch [1] from Rob and add him to the recipients for v2.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=44acf10587907ff77c28fd97906220b2d8eb4f05

Best regards,
Michal

> diff --git a/Documentation/devicetree/bindings/mfd/rk808.txt b/Documentation/devicetree/bindings/mfd/rk808.txt
> index 91b6522..31c9f3d 100644
> --- a/Documentation/devicetree/bindings/mfd/rk808.txt
> +++ b/Documentation/devicetree/bindings/mfd/rk808.txt
> @@ -3,11 +3,15 @@ RK8XX Power Management Integrated Circuit
>   The rk8xx family current members:
>   rk805
>   rk808
> +rk809
> +rk817
>   rk818
>   
>   Required properties:
>   - compatible: "rockchip,rk805"
>   - compatible: "rockchip,rk808"
> +- compatible: "rockchip,rk809"
> +- compatible: "rockchip,rk817"
>   - compatible: "rockchip,rk818"
>   - reg: I2C slave address
>   - interrupt-parent: The parent interrupt controller.
> @@ -46,6 +50,28 @@ Optional RK808 properties:
>     the gpio controller. If DVS GPIOs aren't present, voltage changes will happen
>     very quickly with no slow ramp time.
>   
> +Optional RK809 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +- vcc8-supply:  The input supply for SWITCH_REG1
> +- vcc9-supply:  The input supply for DCDC_REG5, SWITCH_REG2
> +
> +Optional RK817 properties:
> +- vcc1-supply:  The input supply for DCDC_REG1
> +- vcc2-supply:  The input supply for DCDC_REG2
> +- vcc3-supply:  The input supply for DCDC_REG3
> +- vcc4-supply:  The input supply for DCDC_REG4
> +- vcc5-supply:  The input supply for LDO_REG1, LDO_REG2, LDO_REG3
> +- vcc6-supply:  The input supply for LDO_REG4, LDO_REG5, LDO_REG6
> +- vcc7-supply:  The input supply for LDO_REG7, LDO_REG8, LDO_REG9
> +- vcc8-supply:  The input supply for BOOST
> +- vcc9-supply:  The input supply for OTG_SWITCH
> +
>   Optional RK818 properties:
>   - vcc1-supply:  The input supply for DCDC_REG1
>   - vcc2-supply:  The input supply for DCDC_REG2
> @@ -87,6 +113,28 @@ number as described in RK808 datasheet.
>   	- SWITCH_REGn
>   		- valid values for n are 1 to 2
>   
> +Following regulators of the RK809 PMIC block are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK808 datasheet.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 5.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9.
> +	- SWITCH_REGn
> +		- valid values for n are 1 to 2.
> +
> +Following regulators of the RK817 PMIC block are supported. Note that
> +the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
> +number as described in RK818 datasheet.
> +
> +	- DCDC_REGn
> +		- valid values for n are 1 to 4.
> +	- LDO_REGn
> +		- valid values for n are 1 to 9.
> +	- BOOST
> +	- OTG_SWITCH
> +
>   Following regulators of the RK818 PMIC block are supported. Note that
>   the 'n' in regulator name, as in DCDC_REGn or LDOn, represents the DCDC or LDO
>   number as described in RK818 datasheet.
> @@ -99,6 +147,13 @@ number as described in RK818 datasheet.
>   	- HDMI_SWITCH
>   	- OTG_SWITCH
>   
> +There are three pins needed to config, named "gpio_ts" "gpio_gt" "gpio_slp".
> +	The gpio_gt and gpio_ts pins support the gpio function.
> +	The gpio_slp pin is for controlling the pmic states, as below:
> +		- reset
> +		- power down
> +		- sleep
> +
>   Standard regulator bindings are used inside regulator subnodes. Check
>     Documentation/devicetree/bindings/regulator/regulator.txt
>   for more details
> 

