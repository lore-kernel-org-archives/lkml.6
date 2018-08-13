Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D1C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BD921797
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="4a0S148C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BD921797
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeHMKGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:06:06 -0400
Received: from mail-eopbgr50041.outbound.protection.outlook.com ([40.107.5.41]:22081
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726577AbeHMKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:06:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCnB0xIDh002FyuPaBNeouAWEgVo8D67fqpGuzBavks=;
 b=4a0S148CvjR+PXYGWsC1rcPFRkxUeB0OD+3bGXurWup0dSvv7hAFwHi/e1uerwpH7dgAW9r856bNDfb0PCjH5DBM4BWjfreno04S360m0RLyP15MQudc5nRn4n99gt6xJNEhavhb6paDYj0pCrTkahgR4rHeWkYrvTiR4kxrUIY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 DB7PR04MB4665.eurprd04.prod.outlook.com (2603:10a6:5:37::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Mon, 13 Aug 2018 07:24:46 +0000
Subject: Re: [PATCH v2] pinctrl: qcom: Add sdm660 pinctrl driver
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180812142413.20856-1-ctatlor97@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <970132e2-63ec-da56-07a2-56858c5b01ce@ysoft.com>
Date:   Mon, 13 Aug 2018 09:24:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180812142413.20856-1-ctatlor97@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0102CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::30) To DB7PR04MB4665.eurprd04.prod.outlook.com
 (2603:10a6:5:37::11)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4b84800-36c0-4f8c-10c3-08d600edd900
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4665;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4665;3:iJZQNu/SJCmEUNjq7jpPqz6gZRboU9Epi/34jI387o87gz8wrzn4COZeuV9LT0owiBAjeK2+lsrCYFPlim08XYlXBMbWnAg0if4IozofwoVaMXKUGBR4oc3BR6gP3O3uWZIFMrWnuu2ABYk2KjSDxts5ewjUwYuejVvhzguMqtySyYqjePfFpELcBgxKV0CfwQm/ZM4pC29fUwwk8xabGhTlFp4TAr/uRjKq8F/HHG+zSE2MMT8wUunFg0OyCHzg;25:qxftswetDOfXMemGreKHfoRlURq/ArZ8DGsrQqXQONOdOay3N2cUumziX5fe5ep5J+MotmBYXeFpzV+bBEr66mZ6mB8JOH7KqJTurN6wqLdwn4KXiHwFhIbNn96vDhmKMXcA4UePZgLzg0tVEHdYTWBEkCNMB2QnHxQpo79I7U8HEa1sjhGnl1X8g4f8tZf1X/gUbHQXjmHSLjo3Nfc8qDTUvFm2eHpwReWgyaESvKSpatYr5t3qJ6dMYuMYjvboM+QVBlZ9HScBfQCI9n0GG5eaNmfX/Zo7AFzq5awnSf5t1fI+FOfh7GfovbDNu+cXiAOt6MkvhXde5WYWh6z/jQ==;31:xUjwGf2GLiI9OO72E0hudEGiYPH0FEVLYL6UqX681LUkMW3EBDUDIi5zGFVLGxULOEXdl4IyvGg2VM5QsmUKj06/eWlQAiA26HoYW1BDcTpjfzyrqmE9DkyA7D914LOBIAkpZ/zwxOo7TuNElETWX0ISF9Jugl+J1pSkSXJ8m9K1x27SkuUsk/v0NiUkC5r9EOOxKcLf2g79L23zRghjeKmm/9Jyszswdf/GGg7Fekk=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4665:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4665;20:Nhxi8+zloTHt378S/cXRzDte8RplTwDfYs9h5Wf5AcUidUc/+oTr38mLTl5XXXpwtlHxIGl6Iwi0CsMnwmFnFneKy51LWaPraDn1o/MuonyfLqA1LvfLssIyyO7cFzqROOtzZnlF4n48M1cN3cDyfIJm8kT5iVhvD03VNGZJUUy4GsRcC0DQ9L5E6j8UvXxiLPJS1HOxKLjFfNTk2jdqcZN2ywWuSDloOxuvbGBcUEPPu5PqSTuQrI2RUUHyHHL+;4:heQhEcg2Y3D99gHHc8sTq0Xf6Ct+2jG9dea9iI4MuR/EOzV57RQsj32mR7PhxKKCZswZ/B4YfIGt7aVZGEM3KFAHMcqvIydcrWWIZzP9MvYFKkn3z8HHOM8VS3ZjazJ7yd0nRxo2lIyJWhEUfxIgXhz/RXYkc267RvO8RmVTc0t5lbKHwqQSP+YuaWkscPrz2jxHEPQnL3myYbeCE4Ze5pZ2aAZ7mRBcdPWzOQkUGDId0ZNbJ0bpvcFEjMut7/Y2NclAdLjNWsIZ3IotfcGg1od0VM3Mu4clrs9TZnyu5Jme0nmhzcH0SReCl3AmsA7U
X-Microsoft-Antispam-PRVS: <DB7PR04MB46651AED0A0A5FC38C3D73A69E390@DB7PR04MB4665.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB7PR04MB4665;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4665;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39840400004)(346002)(396003)(366004)(136003)(376002)(37524003)(199004)(189003)(53946003)(446003)(11346002)(54906003)(39060400002)(53936002)(81166006)(81156014)(6246003)(8676002)(58126008)(316002)(16576012)(305945005)(64126003)(67846002)(7736002)(25786009)(8936002)(2906002)(3846002)(72206003)(31686004)(4326008)(97736004)(478600001)(68736007)(6116002)(1411001)(16526019)(186003)(106356001)(26005)(6486002)(77096007)(65826007)(6916009)(53546011)(229853002)(2870700001)(6666003)(52116002)(5660300001)(50466002)(486006)(65956001)(65806001)(76176011)(85182001)(36756003)(2616005)(956004)(2486003)(52146003)(66066001)(23676004)(105586002)(476003)(14444005)(386003)(47776003)(31696002)(86362001)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4665;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY1OzIzOkIwTUd0S0NaaCtkSDJCVTQyK1A1RDcyUXJw?=
 =?utf-8?B?MGMvVlJYa2VSRjFSQmYvZWFYNGRBVWRnSG9hUURzT2N4eUxtOTFXNlFTbUIy?=
 =?utf-8?B?UFY3YzJlaTBhcFREVEFTQ1NTbzZWK2dEWllVOEFIZkNLVVBQME80UDI2L2dC?=
 =?utf-8?B?QVQ1WUkyYTVnMkRFOW1hY1lOL2x2Lzcrc3BhZjZ2S2tKZk9BRmNqNTR0SFBT?=
 =?utf-8?B?V0ZrU1h1WWJ0aHBwYlpFRi82QkJnNGZQZ0tHZlV6akY1QnJ3WFBzQm1YcUxD?=
 =?utf-8?B?bDRYZ09sRXhCN3o1cjV1ZmtqRmpHeGk3SkcwWEU3R21vYTlqVGlNek1PU0pa?=
 =?utf-8?B?YXBRZHVlaE8yVE90Tm1mbU1rcks3OFJ4MlZDLzJpTG5OeGFjTGtwc2JrU3c2?=
 =?utf-8?B?RUFrcGMwNWN3WWR4YTZkNklWZXVlZTd2MTZaQmY0M29MV0t2YlE3MzhaeERt?=
 =?utf-8?B?Q0NpOC9kQTJjU1BTMDJKa3ozR0UrcnAzWU15cDdtQlZlVXV1NnR5QUUwUnc2?=
 =?utf-8?B?UGlvYXNFWGQxSWpUcTY1bGZnTFV6LzE2TlpzUGVkVzlVVm42OWh6bHlBbjE3?=
 =?utf-8?B?dDZ0MXlWemVtM1BLQmdpcFJubVMvenVaSWtXTjZSSkUyM1JVWVlxdFU5RVpa?=
 =?utf-8?B?bm0zTzZpTFdMbkY4dWs4d2tySE9IM0U4ZFBnT1pOb2hQQlhGVDAzN3I2eWs1?=
 =?utf-8?B?em9GeGZMK0dHb012STdiQzV1TXcvckRIaTd3ZzhDZlR6amczVWRrTmE1NFN5?=
 =?utf-8?B?dWFFMW1oRitja2tzbm9WTlBqdUlrRi9NaVoxT1ZWSzdkNHFOY0djWjhGbXVq?=
 =?utf-8?B?WWdDQ2NCek5nZ0pqRThTcXRJSSszdXR6L3VubjN0cFNOdzZ6OVo2NUxSN2Q2?=
 =?utf-8?B?Q3orL0hSZFVLWm9IWnF4QzhFenR0OXdSZmdPQVJaK1JZb2dpRzBHTDAzbmk4?=
 =?utf-8?B?K25QKzFQakFHNUZuZjhRclFiTElEcktabWV6L3ZzMEk2ZkVjWXVkWmVOOUg0?=
 =?utf-8?B?OTlreW84K2JCdlJTSHcrSE5ERm45dStwbTRSb3Avd0FsdmZHRjRHSmJENWk2?=
 =?utf-8?B?M2c5NFo3eWdUTVIyTnMvNzBIWUhsZ2FqdzQ3MU40NVFxbG51SUg0bnJZMWhP?=
 =?utf-8?B?cE91NEtUS1NybEtMVitIdTJkMmsyQmwzcyt5L1RnZ3JCcWZHUWdwL0xhcm1U?=
 =?utf-8?B?YUwvS2FFNTB3c3c4dkI3OXBsc2NnVzA4d2FXbVJ2VE4yTEJWZ2E5L2kwbks5?=
 =?utf-8?B?U1dXV1UzRUY2Nm9DMUNmK3lrVzRnRVNaTWJUQkxLYzFPdXU4VmlSazZRODJm?=
 =?utf-8?B?TmgyODRUMUh4V1RwTXV1dDc1MFVkYmJROUt3cFVCUzhXS1BSSCt1L0tVL05M?=
 =?utf-8?B?ZHJoZitVdkRBc1hCTlR2QU5tUDJIR2JSUHJ0M1ZUMlBNU1ROdW1NVCtpVEpq?=
 =?utf-8?B?UkcrTlpKdUF4RGpBVXRNS2JidWJvNkNSMG1US1M4QkY5TW9XSDBEbUVZZ1ZK?=
 =?utf-8?B?RDVnT2l4MzlGNlpSaStWVE9QYXNlWDJHTjc2STZ1R0ZQdE45RUNWNWdtQ0RM?=
 =?utf-8?B?ZVhPL2tHdi8vY3IwaXhIbTFYR1EwVUNpSHRubUZoVmQyNCsvVUVtcEN6MVB3?=
 =?utf-8?B?ZlFKQ0Q0Sy9sNnpJOXdIWlIwL3dkUC9SYnl6eUVvRzhNTE9rV01peUU2Wmxp?=
 =?utf-8?B?N0pta0N3SGMreDh4Qkx2Yk80MisxSGtoaTQxdHFXa2hUSnV1T0ZHV25CYk1F?=
 =?utf-8?B?QkN0b3MxUkJmcWhldjhxSi9zS0dTaG9oYlp2czZSL1UvVUt1ZHV0VmJEcE9l?=
 =?utf-8?B?MXVJcHp4MXQzVEcrNzZjWTA5ZXp3VTJ2TTlwU1ZpNkcyOUc1V1hTRlZGUjA1?=
 =?utf-8?B?c2lPOS9xNzExQmsxNkhEWTRjaUR2ZXlra2xsQ25uSVBpcUlJbW5CcG9qSjBX?=
 =?utf-8?B?U0IybGJsZ3MwWEh1KzY3M0o0T0dweS9NWGpyRmJvZDZQWGl5WGFQN0FoUkIx?=
 =?utf-8?B?NCtLK0Q4V05iL1NSSEdQby9NalJyRWFaSUhMYlh3K0llaDh2U2NKQ0dkVE5W?=
 =?utf-8?B?SEdrZ3N0Y0JvTzU1UWFSWE51NFdQSWpxRnMyTitjRG9YUzRkaGJwcEV3cmZL?=
 =?utf-8?B?dG92SEpaOXJQeGdhMnpjcklxblVKR0NHZGVtU2RhaElZdTJuRXhnQTgrOVkz?=
 =?utf-8?Q?fBqF47Z2zhlEQWKZSIsQ3Q+61oxBcH0zOKTlmal9ik=3D?=
X-Microsoft-Antispam-Message-Info: 4hk176GTT65vqBiNoQX67cOwj2sC3UopfsZwIVL1bnHkbe08sViiQ9vXdOH9uN9aJ/0h+yWUpIMC9YtHwgGlgUk44Kgij+thPU7uiK2Jy7LWQIkFUT9gHtI7OnsHsXNijlgccV+J3uF/RLLC+aqvIHUVVUzahoSmZwyV0bSJ7Pu+5xxMazRGOi2UFKbdDW0iXhJTJOu6Xhm2vuK4JVdXIdmL/HV2ryenkdIxwjz+A0jCmxYhQ5OcTQsz6Hx43A+dX4TfffVmEQ0ALnMnRQlqchlcJDl51WvtUUcBnTRdXFMtlZdSGVKtX4ZElXwxu94po7VLw4DYJ1OFDW+tndc+7Q3vh8uPsCTTaqc5LvpPSpI=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4665;6:VUx1l5K/Ok1mzoCvwagGq5CGwFNHjef4tUaIBtExm0f1JlDejs2gCMbSoKuWkpYVi/zuC0kwnwmh0f0EUWJ+jt35h2+zlUpzcLlPpLnjrlGg8jgLpDDDaH+kfFXiPobseOOBUcUURf5Q1zyJ4SRe94cBKkzC1kajnI9k6uI1Gq3JrRzIj1mkjC40bJVezz9xcD0IUKc5fBNswxmmD61rOk+HKD/AkoOdN+leOEBV5RDi5AWZcB72b5jK3pyD0rHVK3rJuQZXz/yTQswAfdZlndNCwhJx4zqdSW0X1Mc9b1V2aV4WBIEaVV8XGA162TR5JLcb3+lmc/ZdRosHH+/YBV7WzatRY1QIEarlL0pn+WY/gplKxueUir+ucP6lJ2E0gAzuFN+FonhtRYSASVR+TP2WH+3Z3edw9wJg3FC23FSa3cbSaV9IBxuhOxRQ5ym5ka5TdM0qD99y/gS4Re/kHw==;5:fmKjblLywE8dD9FWWHYrLRWhZsnRAJTk+5l+w6bIatxSOq0CtjWZ/++qfzQCOWbXx9CCKb2c12O1XZO5d4vFKixodRQzNXRZZ8RMh3gUMu+lW83UeACQeoU7yhxOrEkL1oygchNcAqIUt2qdx4wXKZIkHEH+7mFcUBl+S3cNlqM=;7:mxSl1vHue9K7IumBgb2dAVMs5mMBBGzqf8jfTV+grxhA5tSSyxazO8O3bdrJ9D8EKo/sRXkzGMhaIQ8YVi1fXRla14tmbTT/KZ7KjSdfZ+RNwh3m6BIsS/maVa+eJ8kdHnj/2KnKAUwONjTuc1juZ1fvESpUWc321hL0zaOfUdRd0gfjmau5lWH96SQghtCrxVKiOtYOhRI2PomWguUOti3dysJKcnPjBUuSzYQkovQIWihO9CPq2Q61l61/wvL0
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 07:24:46.1889 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b84800-36c0-4f8c-10c3-08d600edd900
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4665
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,
On 12.8.2018 16:24, Craig Tatlor wrote:
> Add initial pinctrl driver to support pin configuration with
> pinctrl framework for sdm660.
> Based off CAF implementation.
> 
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
> ---

The documentation portion should be a separate patch.
Please refer to Documentation/devicetree/bindings/submitting-patches.txt

It is easier for DT maintainers to review just the relevant part.
The binding patches are also rebased to a separate tree as they are not
Linux specific and can be re-used in other OSes

Best regards,
Michal

> Changes from v1:
>    Adds gpio-ranges property to bindings
> 
> 
>   .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  |  202 +++
>   drivers/pinctrl/qcom/Kconfig                  |   10 +
>   drivers/pinctrl/qcom/Makefile                 |    1 +
>   drivers/pinctrl/qcom/pinctrl-sdm660.c         | 1451 +++++++++++++++++
>   4 files changed, 1663 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
>   create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm660.c
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> new file mode 100644
> index 000000000000..801960ad2112
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
> @@ -0,0 +1,202 @@
> +Qualcomm Technologies, Inc. SDM660 TLMM block
> +
> +This binding describes the Top Level Mode Multiplexer block found in the
> +SDM660 platform.
> +
> +- compatible:
> +	Usage: required
> +	Value type: <string>
> +	Definition: must be "qcom,sdm660-pinctrl"
> +
> +- reg:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: the base address and size of the TLMM register space.
> +
> +- interrupts:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: should specify the TLMM summary IRQ.
> +
> +- interrupt-controller:
> +	Usage: required
> +	Value type: <none>
> +	Definition: identifies this node as an interrupt controller
> +
> +- #interrupt-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 2. Specifying the pin number and flags, as defined
> +		    in <dt-bindings/interrupt-controller/irq.h>
> +
> +- gpio-controller:
> +	Usage: required
> +	Value type: <none>
> +	Definition: identifies this node as a gpio controller
> +
> +- gpio-ranges:
> +	Usage: required
> +	Value type: <prop-encoded-array>
> +	Definition: Specifies the mapping between gpio controller and
> +		    pin-controller pins.
> +
> +- #gpio-cells:
> +	Usage: required
> +	Value type: <u32>
> +	Definition: must be 2. Specifying the pin number and flags, as defined
> +		    in <dt-bindings/gpio/gpio.h>
> +
> +Please refer to ../gpio/gpio.txt and ../interrupt-controller/interrupts.txt for
> +a general description of GPIO and interrupt bindings.
> +
> +Please refer to pinctrl-bindings.txt in this directory for details of the
> +common pinctrl bindings used by client devices, including the meaning of the
> +phrase "pin configuration node".
> +
> +The pin configuration nodes act as a container for an arbitrary number of
> +subnodes. Each of these subnodes represents some desired configuration for a
> +pin, a group, or a list of pins or groups. This configuration can include the
> +mux function to select on those pin(s)/group(s), and various pin configuration
> +parameters, such as pull-up, drive strength, etc.
> +
> +
> +PIN CONFIGURATION NODES:
> +
> +The name of each subnode is not important; all subnodes should be enumerated
> +and processed purely based on their content.
> +
> +Each subnode only affects those parameters that are explicitly listed. In
> +other words, a subnode that lists a mux function but no pin configuration
> +parameters implies no information about any pin configuration parameters.
> +Similarly, a pin subnode that describes a pullup parameter implies no
> +information about e.g. the mux function.
> +
> +
> +The following generic properties as defined in pinctrl-bindings.txt are valid
> +to specify in a pin configuration subnode:
> +
> +- pins:
> +	Usage: required
> +	Value type: <string-array>
> +	Definition: List of gpio pins affected by the properties specified in
> +		    this subnode.  Valid pins are:
> +		    gpio0-gpio113,
> +		        Supports mux, bias and drive-strength
> +		    sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd, sdc2_data sdc1_rclk,
> +		        Supports bias and drive-strength
> +
> +- function:
> +	Usage: required
> +	Value type: <string>
> +	Definition: Specify the alternative function to be configured for the
> +		    specified pins. Functions are only valid for gpio pins.
> +		    Valid values are:
> +
> +		    blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
> +		    bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
> +		    qdss_cti_trig_out_b, bimc_dte0, dac_calib1, qdss_cti_trig_in_b,
> +		    dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
> +		    blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0, atest_usb12,
> +		    mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
> +		    atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio, atest_char,
> +		    cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8, qdss_tracedata_b,
> +		    pll_reset, qdss_stm6, qdss_stm5, qdss_stm4, atest_usb2, cci_i2c,
> +		    qdss_stm3, dac_calib3, atest_usb23, atest_char3, dac_calib4,
> +		    qdss_stm2, atest_usb22, atest_char2, qdss_stm1, dac_calib5,
> +		    atest_usb21, atest_char1, dbg_out, qdss_stm0, dac_calib6,
> +		    atest_usb20, atest_char0, dac_calib10, qdss_stm10,
> +		    qdss_cti_trig_in_a, cci_timer4, blsp_spi6, blsp_uart6, blsp_uim6,
> +		    blsp2_spi, qdss_stm9, qdss_cti_trig_out_a, dac_calib11,
> +		    qdss_stm8, cci_timer0, qdss_stm13, dac_calib7, cci_timer1,
> +		    qdss_stm12, dac_calib8, cci_timer2, blsp1_spi, qdss_stm11,
> +		    dac_calib9, cci_timer3, cci_async, dac_calib12, blsp_i2c6,
> +		    qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib14,
> +		    dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
> +		    dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
> +		    dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
> +		    dac_calib22, dac_calib23, dac_calib24, tsif1_sync, dac_calib25,
> +		    sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
> +		    qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3, blsp_i2c3,
> +		    uim3, blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
> +		    blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
> +		    qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11, blsp_uart11,
> +		    blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a, blsp_i2c11, cri_trng0,
> +		    cri_trng1, cri_trng, qdss_stm18, pri_mi2s, qdss_stm17, blsp_spi4,
> +		    blsp_uart4, blsp_uim4, qdss_stm16, qdss_stm15, blsp_i2c4,
> +		    qdss_stm14, dac_calib26, spkr_i2s, audio_ref, lpass_slimbus,
> +		    isense_dbg, tsense_pwm1, tsense_pwm2, btfm_slimbus, ter_mi2s,
> +		    qdss_stm22, qdss_stm21, qdss_stm20, qdss_stm19, gcc_gp1_clk_b,
> +		    sec_mi2s, blsp_spi5, blsp_uart5, blsp_uim5, gcc_gp2_clk_b,
> +		    gcc_gp3_clk_b, blsp_i2c5, blsp_spi12, blsp_uart12, blsp_uim12,
> +		    qdss_stm25, qdss_stm31, blsp_i2c12, qdss_stm30, qdss_stm29,
> +		    tsif1_clk, qdss_stm28, tsif1_en, tsif1_data, sdc4_cmd, qdss_stm27,
> +		    qdss_traceclk_b, tsif2_error, sdc43, vfr_1, qdss_stm26, tsif2_clk,
> +		    sdc4_clk, qdss_stm24, tsif2_en, sdc42, qdss_stm23, qdss_tracectl_b,
> +		    sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
> +		    ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b, blsp11_uart_rx_b,
> +		    blsp11_i2c_sda_b, prng_rosc, blsp11_i2c_scl_b, uim2, uim1, uim_batt,
> +		    pci_e2, pa_indicator, adsp_ext, ddr_bist, qdss_tracedata_11,
> +		    qdss_tracedata_12, modem_tsync, nav_dr, nav_pps, pci_e1, gsm_tx,
> +		    qspi_cs, ssbi2, ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2, qspi3,
> +		    gpio
> +
> +- bias-disable:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as no pull.
> +
> +- bias-pull-down:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as pull down.
> +
> +- bias-pull-up:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins should be configued as pull up.
> +
> +- output-high:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    high.
> +		    Not valid for sdc pins.
> +
> +- output-low:
> +	Usage: optional
> +	Value type: <none>
> +	Definition: The specified pins are configured in output mode, driven
> +		    low.
> +		    Not valid for sdc pins.
> +
> +- drive-strength:
> +	Usage: optional
> +	Value type: <u32>
> +	Definition: Selects the drive strength for the specified pins, in mA.
> +		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
> +
> +Example:
> +
> +	tlmm: pinctrl@1010000 {
> +		compatible = "qcom,sdm660-pinctrl";
> +		reg = <0x1010000 0x300000>;
> +		interrupts = <0 208 0>;
> +		gpio-controller;
> +		gpio-ranges = <&tlmm 0 0 114>;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +
> +		uart_console_active: uart_console_active {
> +			mux {
> +				pins = "gpio4", "gpio5";
> +				function = "blsp_uart8";
> +			};
> +
> +			config {
> +				pins = "gpio4", "gpio5";
> +				drive-strength = <2>;
> +				bias-disable;
> +			};
> +		};
> +	};
> diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
> index 195492033075..091beadb8a1c 100644
> --- a/drivers/pinctrl/qcom/Kconfig
> +++ b/drivers/pinctrl/qcom/Kconfig
> @@ -147,6 +147,16 @@ config PINCTRL_QCOM_SSBI_PMIC
>            which are using SSBI for communication with SoC. Example PMIC's
>            devices are pm8058 and pm8921.
>   
> +config PINCTRL_SDM660
> +       tristate "Qualcomm Technologies Inc SDM660 pin controller driver"
> +       depends on GPIOLIB && OF
> +       select PINCTRL_MSM
> +       help
> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for the
> +         Qualcomm Technologies Inc TLMM block found on the Qualcomm
> +         Technologies Inc SDM660 platform.
> +
> +
>   config PINCTRL_SDM845
>          tristate "Qualcomm Technologies Inc SDM845 pin controller driver"
>          depends on GPIOLIB && OF
> diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
> index 0c6f3ddc296d..9b08808a2f1c 100644
> --- a/drivers/pinctrl/qcom/Makefile
> +++ b/drivers/pinctrl/qcom/Makefile
> @@ -19,4 +19,5 @@ obj-$(CONFIG_PINCTRL_QCOM_SPMI_PMIC) += pinctrl-spmi-gpio.o
>   obj-$(CONFIG_PINCTRL_QCOM_SPMI_PMIC) += pinctrl-spmi-mpp.o
>   obj-$(CONFIG_PINCTRL_QCOM_SSBI_PMIC) += pinctrl-ssbi-gpio.o
>   obj-$(CONFIG_PINCTRL_QCOM_SSBI_PMIC) += pinctrl-ssbi-mpp.o
> +obj-$(CONFIG_PINCTRL_SDM660)   += pinctrl-sdm660.o
>   obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> new file mode 100644
> index 000000000000..ded56111f168
> --- /dev/null
> +++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
> @@ -0,0 +1,1451 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2018, Craig Tatlor.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/pinctrl/pinctrl.h>
> +
> +#include "pinctrl-msm.h"
> +
> +#define NORTH	0x00900000
> +#define CENTER	0x00500000
> +#define SOUTH	0x00100000
> +#define REG_SIZE 0x1000
> +
> +#define FUNCTION(fname)					\
> +	[msm_mux_##fname] = {		                \
> +		.name = #fname,				\
> +		.groups = fname##_groups,               \
> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
> +	}
> +
> +
> +#define PINGROUP(id, base, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
> +	{					        \
> +		.name = "gpio" #id,			\
> +		.pins = gpio##id##_pins,		\
> +		.npins = (unsigned)ARRAY_SIZE(gpio##id##_pins),	\
> +		.funcs = (int[]){			\
> +			msm_mux_gpio, /* gpio mode */	\
> +			msm_mux_##f1,			\
> +			msm_mux_##f2,			\
> +			msm_mux_##f3,			\
> +			msm_mux_##f4,			\
> +			msm_mux_##f5,			\
> +			msm_mux_##f6,			\
> +			msm_mux_##f7,			\
> +			msm_mux_##f8,			\
> +			msm_mux_##f9			\
> +		},				        \
> +		.nfuncs = 10,				\
> +		.ctl_reg = base + REG_SIZE * id,	\
> +		.io_reg = base + 0x4 + REG_SIZE * id,		\
> +		.intr_cfg_reg = base + 0x8 + REG_SIZE * id,		\
> +		.intr_status_reg = base + 0xc + REG_SIZE * id,	\
> +		.intr_target_reg = base + 0x8 + REG_SIZE * id,	\
> +		.mux_bit = 2,			\
> +		.pull_bit = 0,			\
> +		.drv_bit = 6,			\
> +		.oe_bit = 9,			\
> +		.in_bit = 0,			\
> +		.out_bit = 1,			\
> +		.intr_enable_bit = 0,		\
> +		.intr_status_bit = 0,		\
> +		.intr_target_bit = 5,		\
> +		.intr_target_kpss_val = 3,	\
> +		.intr_raw_status_bit = 4,	\
> +		.intr_polarity_bit = 1,		\
> +		.intr_detection_bit = 2,	\
> +		.intr_detection_width = 2,	\
> +	}
> +
> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
> +	{					        \
> +		.name = #pg_name,			\
> +		.pins = pg_name##_pins,			\
> +		.npins = (unsigned)ARRAY_SIZE(pg_name##_pins),	\
> +		.ctl_reg = ctl,				\
> +		.io_reg = 0,				\
> +		.intr_cfg_reg = 0,			\
> +		.intr_status_reg = 0,			\
> +		.intr_target_reg = 0,			\
> +		.mux_bit = -1,				\
> +		.pull_bit = pull,			\
> +		.drv_bit = drv,				\
> +		.oe_bit = -1,				\
> +		.in_bit = -1,				\
> +		.out_bit = -1,				\
> +		.intr_enable_bit = -1,			\
> +		.intr_status_bit = -1,			\
> +		.intr_target_bit = -1,			\
> +		.intr_raw_status_bit = -1,		\
> +		.intr_polarity_bit = -1,		\
> +		.intr_detection_bit = -1,		\
> +		.intr_detection_width = -1,		\
> +	}
> +
> +static const struct pinctrl_pin_desc sdm660_pins[] = {
> +	PINCTRL_PIN(0, "GPIO_0"),
> +	PINCTRL_PIN(1, "GPIO_1"),
> +	PINCTRL_PIN(2, "GPIO_2"),
> +	PINCTRL_PIN(3, "GPIO_3"),
> +	PINCTRL_PIN(4, "GPIO_4"),
> +	PINCTRL_PIN(5, "GPIO_5"),
> +	PINCTRL_PIN(6, "GPIO_6"),
> +	PINCTRL_PIN(7, "GPIO_7"),
> +	PINCTRL_PIN(8, "GPIO_8"),
> +	PINCTRL_PIN(9, "GPIO_9"),
> +	PINCTRL_PIN(10, "GPIO_10"),
> +	PINCTRL_PIN(11, "GPIO_11"),
> +	PINCTRL_PIN(12, "GPIO_12"),
> +	PINCTRL_PIN(13, "GPIO_13"),
> +	PINCTRL_PIN(14, "GPIO_14"),
> +	PINCTRL_PIN(15, "GPIO_15"),
> +	PINCTRL_PIN(16, "GPIO_16"),
> +	PINCTRL_PIN(17, "GPIO_17"),
> +	PINCTRL_PIN(18, "GPIO_18"),
> +	PINCTRL_PIN(19, "GPIO_19"),
> +	PINCTRL_PIN(20, "GPIO_20"),
> +	PINCTRL_PIN(21, "GPIO_21"),
> +	PINCTRL_PIN(22, "GPIO_22"),
> +	PINCTRL_PIN(23, "GPIO_23"),
> +	PINCTRL_PIN(24, "GPIO_24"),
> +	PINCTRL_PIN(25, "GPIO_25"),
> +	PINCTRL_PIN(26, "GPIO_26"),
> +	PINCTRL_PIN(27, "GPIO_27"),
> +	PINCTRL_PIN(28, "GPIO_28"),
> +	PINCTRL_PIN(29, "GPIO_29"),
> +	PINCTRL_PIN(30, "GPIO_30"),
> +	PINCTRL_PIN(31, "GPIO_31"),
> +	PINCTRL_PIN(32, "GPIO_32"),
> +	PINCTRL_PIN(33, "GPIO_33"),
> +	PINCTRL_PIN(34, "GPIO_34"),
> +	PINCTRL_PIN(35, "GPIO_35"),
> +	PINCTRL_PIN(36, "GPIO_36"),
> +	PINCTRL_PIN(37, "GPIO_37"),
> +	PINCTRL_PIN(38, "GPIO_38"),
> +	PINCTRL_PIN(39, "GPIO_39"),
> +	PINCTRL_PIN(40, "GPIO_40"),
> +	PINCTRL_PIN(41, "GPIO_41"),
> +	PINCTRL_PIN(42, "GPIO_42"),
> +	PINCTRL_PIN(43, "GPIO_43"),
> +	PINCTRL_PIN(44, "GPIO_44"),
> +	PINCTRL_PIN(45, "GPIO_45"),
> +	PINCTRL_PIN(46, "GPIO_46"),
> +	PINCTRL_PIN(47, "GPIO_47"),
> +	PINCTRL_PIN(48, "GPIO_48"),
> +	PINCTRL_PIN(49, "GPIO_49"),
> +	PINCTRL_PIN(50, "GPIO_50"),
> +	PINCTRL_PIN(51, "GPIO_51"),
> +	PINCTRL_PIN(52, "GPIO_52"),
> +	PINCTRL_PIN(53, "GPIO_53"),
> +	PINCTRL_PIN(54, "GPIO_54"),
> +	PINCTRL_PIN(55, "GPIO_55"),
> +	PINCTRL_PIN(56, "GPIO_56"),
> +	PINCTRL_PIN(57, "GPIO_57"),
> +	PINCTRL_PIN(58, "GPIO_58"),
> +	PINCTRL_PIN(59, "GPIO_59"),
> +	PINCTRL_PIN(60, "GPIO_60"),
> +	PINCTRL_PIN(61, "GPIO_61"),
> +	PINCTRL_PIN(62, "GPIO_62"),
> +	PINCTRL_PIN(63, "GPIO_63"),
> +	PINCTRL_PIN(64, "GPIO_64"),
> +	PINCTRL_PIN(65, "GPIO_65"),
> +	PINCTRL_PIN(66, "GPIO_66"),
> +	PINCTRL_PIN(67, "GPIO_67"),
> +	PINCTRL_PIN(68, "GPIO_68"),
> +	PINCTRL_PIN(69, "GPIO_69"),
> +	PINCTRL_PIN(70, "GPIO_70"),
> +	PINCTRL_PIN(71, "GPIO_71"),
> +	PINCTRL_PIN(72, "GPIO_72"),
> +	PINCTRL_PIN(73, "GPIO_73"),
> +	PINCTRL_PIN(74, "GPIO_74"),
> +	PINCTRL_PIN(75, "GPIO_75"),
> +	PINCTRL_PIN(76, "GPIO_76"),
> +	PINCTRL_PIN(77, "GPIO_77"),
> +	PINCTRL_PIN(78, "GPIO_78"),
> +	PINCTRL_PIN(79, "GPIO_79"),
> +	PINCTRL_PIN(80, "GPIO_80"),
> +	PINCTRL_PIN(81, "GPIO_81"),
> +	PINCTRL_PIN(82, "GPIO_82"),
> +	PINCTRL_PIN(83, "GPIO_83"),
> +	PINCTRL_PIN(84, "GPIO_84"),
> +	PINCTRL_PIN(85, "GPIO_85"),
> +	PINCTRL_PIN(86, "GPIO_86"),
> +	PINCTRL_PIN(87, "GPIO_87"),
> +	PINCTRL_PIN(88, "GPIO_88"),
> +	PINCTRL_PIN(89, "GPIO_89"),
> +	PINCTRL_PIN(90, "GPIO_90"),
> +	PINCTRL_PIN(91, "GPIO_91"),
> +	PINCTRL_PIN(92, "GPIO_92"),
> +	PINCTRL_PIN(93, "GPIO_93"),
> +	PINCTRL_PIN(94, "GPIO_94"),
> +	PINCTRL_PIN(95, "GPIO_95"),
> +	PINCTRL_PIN(96, "GPIO_96"),
> +	PINCTRL_PIN(97, "GPIO_97"),
> +	PINCTRL_PIN(98, "GPIO_98"),
> +	PINCTRL_PIN(99, "GPIO_99"),
> +	PINCTRL_PIN(100, "GPIO_100"),
> +	PINCTRL_PIN(101, "GPIO_101"),
> +	PINCTRL_PIN(102, "GPIO_102"),
> +	PINCTRL_PIN(103, "GPIO_103"),
> +	PINCTRL_PIN(104, "GPIO_104"),
> +	PINCTRL_PIN(105, "GPIO_105"),
> +	PINCTRL_PIN(106, "GPIO_106"),
> +	PINCTRL_PIN(107, "GPIO_107"),
> +	PINCTRL_PIN(108, "GPIO_108"),
> +	PINCTRL_PIN(109, "GPIO_109"),
> +	PINCTRL_PIN(110, "GPIO_110"),
> +	PINCTRL_PIN(111, "GPIO_111"),
> +	PINCTRL_PIN(112, "GPIO_112"),
> +	PINCTRL_PIN(113, "GPIO_113"),
> +	PINCTRL_PIN(114, "SDC1_CLK"),
> +	PINCTRL_PIN(115, "SDC1_CMD"),
> +	PINCTRL_PIN(116, "SDC1_DATA"),
> +	PINCTRL_PIN(117, "SDC2_CLK"),
> +	PINCTRL_PIN(118, "SDC2_CMD"),
> +	PINCTRL_PIN(119, "SDC2_DATA"),
> +	PINCTRL_PIN(120, "SDC1_RCLK"),
> +};
> +
> +#define DECLARE_MSM_GPIO_PINS(pin) \
> +	static const unsigned int gpio##pin##_pins[] = { pin }
> +DECLARE_MSM_GPIO_PINS(0);
> +DECLARE_MSM_GPIO_PINS(1);
> +DECLARE_MSM_GPIO_PINS(2);
> +DECLARE_MSM_GPIO_PINS(3);
> +DECLARE_MSM_GPIO_PINS(4);
> +DECLARE_MSM_GPIO_PINS(5);
> +DECLARE_MSM_GPIO_PINS(6);
> +DECLARE_MSM_GPIO_PINS(7);
> +DECLARE_MSM_GPIO_PINS(8);
> +DECLARE_MSM_GPIO_PINS(9);
> +DECLARE_MSM_GPIO_PINS(10);
> +DECLARE_MSM_GPIO_PINS(11);
> +DECLARE_MSM_GPIO_PINS(12);
> +DECLARE_MSM_GPIO_PINS(13);
> +DECLARE_MSM_GPIO_PINS(14);
> +DECLARE_MSM_GPIO_PINS(15);
> +DECLARE_MSM_GPIO_PINS(16);
> +DECLARE_MSM_GPIO_PINS(17);
> +DECLARE_MSM_GPIO_PINS(18);
> +DECLARE_MSM_GPIO_PINS(19);
> +DECLARE_MSM_GPIO_PINS(20);
> +DECLARE_MSM_GPIO_PINS(21);
> +DECLARE_MSM_GPIO_PINS(22);
> +DECLARE_MSM_GPIO_PINS(23);
> +DECLARE_MSM_GPIO_PINS(24);
> +DECLARE_MSM_GPIO_PINS(25);
> +DECLARE_MSM_GPIO_PINS(26);
> +DECLARE_MSM_GPIO_PINS(27);
> +DECLARE_MSM_GPIO_PINS(28);
> +DECLARE_MSM_GPIO_PINS(29);
> +DECLARE_MSM_GPIO_PINS(30);
> +DECLARE_MSM_GPIO_PINS(31);
> +DECLARE_MSM_GPIO_PINS(32);
> +DECLARE_MSM_GPIO_PINS(33);
> +DECLARE_MSM_GPIO_PINS(34);
> +DECLARE_MSM_GPIO_PINS(35);
> +DECLARE_MSM_GPIO_PINS(36);
> +DECLARE_MSM_GPIO_PINS(37);
> +DECLARE_MSM_GPIO_PINS(38);
> +DECLARE_MSM_GPIO_PINS(39);
> +DECLARE_MSM_GPIO_PINS(40);
> +DECLARE_MSM_GPIO_PINS(41);
> +DECLARE_MSM_GPIO_PINS(42);
> +DECLARE_MSM_GPIO_PINS(43);
> +DECLARE_MSM_GPIO_PINS(44);
> +DECLARE_MSM_GPIO_PINS(45);
> +DECLARE_MSM_GPIO_PINS(46);
> +DECLARE_MSM_GPIO_PINS(47);
> +DECLARE_MSM_GPIO_PINS(48);
> +DECLARE_MSM_GPIO_PINS(49);
> +DECLARE_MSM_GPIO_PINS(50);
> +DECLARE_MSM_GPIO_PINS(51);
> +DECLARE_MSM_GPIO_PINS(52);
> +DECLARE_MSM_GPIO_PINS(53);
> +DECLARE_MSM_GPIO_PINS(54);
> +DECLARE_MSM_GPIO_PINS(55);
> +DECLARE_MSM_GPIO_PINS(56);
> +DECLARE_MSM_GPIO_PINS(57);
> +DECLARE_MSM_GPIO_PINS(58);
> +DECLARE_MSM_GPIO_PINS(59);
> +DECLARE_MSM_GPIO_PINS(60);
> +DECLARE_MSM_GPIO_PINS(61);
> +DECLARE_MSM_GPIO_PINS(62);
> +DECLARE_MSM_GPIO_PINS(63);
> +DECLARE_MSM_GPIO_PINS(64);
> +DECLARE_MSM_GPIO_PINS(65);
> +DECLARE_MSM_GPIO_PINS(66);
> +DECLARE_MSM_GPIO_PINS(67);
> +DECLARE_MSM_GPIO_PINS(68);
> +DECLARE_MSM_GPIO_PINS(69);
> +DECLARE_MSM_GPIO_PINS(70);
> +DECLARE_MSM_GPIO_PINS(71);
> +DECLARE_MSM_GPIO_PINS(72);
> +DECLARE_MSM_GPIO_PINS(73);
> +DECLARE_MSM_GPIO_PINS(74);
> +DECLARE_MSM_GPIO_PINS(75);
> +DECLARE_MSM_GPIO_PINS(76);
> +DECLARE_MSM_GPIO_PINS(77);
> +DECLARE_MSM_GPIO_PINS(78);
> +DECLARE_MSM_GPIO_PINS(79);
> +DECLARE_MSM_GPIO_PINS(80);
> +DECLARE_MSM_GPIO_PINS(81);
> +DECLARE_MSM_GPIO_PINS(82);
> +DECLARE_MSM_GPIO_PINS(83);
> +DECLARE_MSM_GPIO_PINS(84);
> +DECLARE_MSM_GPIO_PINS(85);
> +DECLARE_MSM_GPIO_PINS(86);
> +DECLARE_MSM_GPIO_PINS(87);
> +DECLARE_MSM_GPIO_PINS(88);
> +DECLARE_MSM_GPIO_PINS(89);
> +DECLARE_MSM_GPIO_PINS(90);
> +DECLARE_MSM_GPIO_PINS(91);
> +DECLARE_MSM_GPIO_PINS(92);
> +DECLARE_MSM_GPIO_PINS(93);
> +DECLARE_MSM_GPIO_PINS(94);
> +DECLARE_MSM_GPIO_PINS(95);
> +DECLARE_MSM_GPIO_PINS(96);
> +DECLARE_MSM_GPIO_PINS(97);
> +DECLARE_MSM_GPIO_PINS(98);
> +DECLARE_MSM_GPIO_PINS(99);
> +DECLARE_MSM_GPIO_PINS(100);
> +DECLARE_MSM_GPIO_PINS(101);
> +DECLARE_MSM_GPIO_PINS(102);
> +DECLARE_MSM_GPIO_PINS(103);
> +DECLARE_MSM_GPIO_PINS(104);
> +DECLARE_MSM_GPIO_PINS(105);
> +DECLARE_MSM_GPIO_PINS(106);
> +DECLARE_MSM_GPIO_PINS(107);
> +DECLARE_MSM_GPIO_PINS(108);
> +DECLARE_MSM_GPIO_PINS(109);
> +DECLARE_MSM_GPIO_PINS(110);
> +DECLARE_MSM_GPIO_PINS(111);
> +DECLARE_MSM_GPIO_PINS(112);
> +DECLARE_MSM_GPIO_PINS(113);
> +
> +static const unsigned int sdc1_clk_pins[] = { 114 };
> +static const unsigned int sdc1_cmd_pins[] = { 115 };
> +static const unsigned int sdc1_data_pins[] = { 116 };
> +static const unsigned int sdc2_clk_pins[] = { 117 };
> +static const unsigned int sdc2_cmd_pins[] = { 118 };
> +static const unsigned int sdc2_data_pins[] = { 119 };
> +static const unsigned int sdc1_rclk_pins[] = { 120 };
> +
> +enum sdm660_functions {
> +	msm_mux_blsp_spi1,
> +	msm_mux_gpio,
> +	msm_mux_blsp_uim1,
> +	msm_mux_tgu_ch0,
> +	msm_mux_qdss_gpio4,
> +	msm_mux_atest_gpsadc1,
> +	msm_mux_blsp_uart1,
> +	msm_mux_phase_flag14,
> +	msm_mux_blsp_i2c2,
> +	msm_mux_phase_flag31,
> +	msm_mux_blsp_spi3,
> +	msm_mux_blsp_spi3_cs1,
> +	msm_mux_blsp_spi3_cs2,
> +	msm_mux_wlan1_adc1,
> +	msm_mux_atest_usb13,
> +	msm_mux_tgu_ch1,
> +	msm_mux_qdss_gpio5,
> +	msm_mux_atest_gpsadc0,
> +	msm_mux_blsp_i2c1,
> +	msm_mux_ddr_bist,
> +	msm_mux_atest_tsens2,
> +	msm_mux_atest_usb1,
> +	msm_mux_blsp_spi2,
> +	msm_mux_blsp_uim2,
> +	msm_mux_phase_flag3,
> +	msm_mux_bimc_dte1,
> +	msm_mux_wlan1_adc0,
> +	msm_mux_atest_usb12,
> +	msm_mux_bimc_dte0,
> +	msm_mux_blsp_i2c3,
> +	msm_mux_wlan2_adc1,
> +	msm_mux_atest_usb11,
> +	msm_mux_dbg_out,
> +	msm_mux_wlan2_adc0,
> +	msm_mux_atest_usb10,
> +	msm_mux_blsp_spi4,
> +	msm_mux_pri_mi2s,
> +	msm_mux_phase_flag26,
> +	msm_mux_qdss_cti0_a,
> +	msm_mux_qdss_cti0_b,
> +	msm_mux_qdss_cti1_a,
> +	msm_mux_qdss_cti1_b,
> +	msm_mux_pri_mi2s_ws,
> +	msm_mux_phase_flag27,
> +	msm_mux_blsp_i2c4,
> +	msm_mux_phase_flag28,
> +	msm_mux_blsp_uart5,
> +	msm_mux_blsp_spi5,
> +	msm_mux_blsp_uim5,
> +	msm_mux_phase_flag5,
> +	msm_mux_blsp_i2c5,
> +	msm_mux_blsp_spi6,
> +	msm_mux_blsp_uart2,
> +	msm_mux_blsp_uim6,
> +	msm_mux_phase_flag11,
> +	msm_mux_vsense_data0,
> +	msm_mux_blsp_i2c6,
> +	msm_mux_phase_flag12,
> +	msm_mux_vsense_data1,
> +	msm_mux_phase_flag13,
> +	msm_mux_vsense_mode,
> +	msm_mux_blsp_spi7,
> +	msm_mux_blsp_uart6_a,
> +	msm_mux_blsp_uart6_b,
> +	msm_mux_sec_mi2s,
> +	msm_mux_sndwire_clk,
> +	msm_mux_phase_flag17,
> +	msm_mux_vsense_clkout,
> +	msm_mux_sndwire_data,
> +	msm_mux_phase_flag18,
> +	msm_mux_blsp_i2c7,
> +	msm_mux_phase_flag19,
> +	msm_mux_vfr_1,
> +	msm_mux_phase_flag20,
> +	msm_mux_blsp_spi8_cs1,
> +	msm_mux_blsp_spi8_cs2,
> +	msm_mux_m_voc,
> +	msm_mux_phase_flag21,
> +	msm_mux_phase_flag22,
> +	msm_mux_blsp_i2c8_a,
> +	msm_mux_blsp_i2c8_b,
> +	msm_mux_phase_flag23,
> +	msm_mux_pwr_modem,
> +	msm_mux_phase_flag24,
> +	msm_mux_qdss_gpio,
> +	msm_mux_cam_mclk,
> +	msm_mux_pwr_nav,
> +	msm_mux_qdss_gpio0,
> +	msm_mux_qspi_data0,
> +	msm_mux_pwr_crypto,
> +	msm_mux_qdss_gpio1,
> +	msm_mux_qspi_data1,
> +	msm_mux_agera_pll,
> +	msm_mux_qdss_gpio2,
> +	msm_mux_qspi_data2,
> +	msm_mux_jitter_bist,
> +	msm_mux_qdss_gpio3,
> +	msm_mux_qdss_gpio7,
> +	msm_mux_mdss_vsync0,
> +	msm_mux_mdss_vsync1,
> +	msm_mux_mdss_vsync2,
> +	msm_mux_mdss_vsync3,
> +	msm_mux_qdss_gpio9,
> +	msm_mux_atest_usb2,
> +	msm_mux_cci_i2c,
> +	msm_mux_pll_bypassnl,
> +	msm_mux_atest_tsens,
> +	msm_mux_atest_usb21,
> +	msm_mux_pll_reset,
> +	msm_mux_atest_usb23,
> +	msm_mux_qdss_gpio6,
> +	msm_mux_qspi_cs,
> +	msm_mux_qdss_gpio10,
> +	msm_mux_qdss_gpio11,
> +	msm_mux_cci_async,
> +	msm_mux_qdss_gpio12,
> +	msm_mux_qdss_gpio13,
> +	msm_mux_qspi_clk,
> +	msm_mux_phase_flag30,
> +	msm_mux_qdss_gpio14,
> +	msm_mux_qspi_resetn,
> +	msm_mux_phase_flag1,
> +	msm_mux_qdss_gpio15,
> +	msm_mux_phase_flag2,
> +	msm_mux_phase_flag9,
> +	msm_mux_qspi_data3,
> +	msm_mux_phase_flag15,
> +	msm_mux_qdss_gpio8,
> +	msm_mux_phase_flag16,
> +	msm_mux_phase_flag6,
> +	msm_mux_phase_flag29,
> +	msm_mux_phase_flag25,
> +	msm_mux_phase_flag10,
> +	msm_mux_atest_usb20,
> +	msm_mux_gcc_gp1,
> +	msm_mux_phase_flag4,
> +	msm_mux_atest_usb22,
> +	msm_mux_gcc_gp2,
> +	msm_mux_atest_char,
> +	msm_mux_mdp_vsync,
> +	msm_mux_gcc_gp3,
> +	msm_mux_atest_char3,
> +	msm_mux_cri_trng0,
> +	msm_mux_atest_char2,
> +	msm_mux_cri_trng1,
> +	msm_mux_atest_char1,
> +	msm_mux_audio_ref,
> +	msm_mux_cri_trng,
> +	msm_mux_atest_char0,
> +	msm_mux_blsp_spi8_a,
> +	msm_mux_blsp_spi8_b,
> +	msm_mux_sp_cmu,
> +	msm_mux_nav_pps_a,
> +	msm_mux_nav_pps_b,
> +	msm_mux_nav_pps_c,
> +	msm_mux_gps_tx_a,
> +	msm_mux_gps_tx_b,
> +	msm_mux_gps_tx_c,
> +	msm_mux_adsp_ext,
> +	msm_mux_ssc_irq,
> +	msm_mux_isense_dbg,
> +	msm_mux_phase_flag0,
> +	msm_mux_phase_flag7,
> +	msm_mux_phase_flag8,
> +	msm_mux_tsense_pwm1,
> +	msm_mux_tsense_pwm2,
> +	msm_mux_mss_lte,
> +	msm_mux_uim2_data,
> +	msm_mux_uim2_clk,
> +	msm_mux_uim2_reset,
> +	msm_mux_uim2_present,
> +	msm_mux_uim1_data,
> +	msm_mux_uim1_clk,
> +	msm_mux_uim1_reset,
> +	msm_mux_uim1_present,
> +	msm_mux_uim_batt,
> +	msm_mux_pa_indicator,
> +	msm_mux_ldo_en,
> +	msm_mux_ldo_update,
> +	msm_mux_qlink_request,
> +	msm_mux_qlink_enable,
> +	msm_mux_prng_rosc,
> +	msm_mux__,
> +};
> +
> +static const char * const gpio_groups[] = {
> +	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6", "gpio7",
> +	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
> +	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20", "gpio21",
> +	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27", "gpio28",
> +	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34", "gpio35",
> +	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41", "gpio42",
> +	"gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48", "gpio49",
> +	"gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55", "gpio56",
> +	"gpio57", "gpio58", "gpio59", "gpio60", "gpio61", "gpio62", "gpio63",
> +	"gpio64", "gpio65", "gpio66", "gpio67", "gpio68", "gpio69", "gpio70",
> +	"gpio71", "gpio72", "gpio73", "gpio74", "gpio75", "gpio76", "gpio77",
> +	"gpio78", "gpio79", "gpio80", "gpio81", "gpio82", "gpio83", "gpio84",
> +	"gpio85", "gpio86", "gpio87", "gpio88", "gpio89", "gpio90", "gpio91",
> +	"gpio92", "gpio93", "gpio94", "gpio95", "gpio96", "gpio97", "gpio98",
> +	"gpio99", "gpio100", "gpio101", "gpio102", "gpio103", "gpio104",
> +	"gpio105", "gpio106", "gpio107", "gpio108", "gpio109", "gpio110",
> +	"gpio111", "gpio112", "gpio113",
> +};
> +static const char * const blsp_spi1_groups[] = {
> +	"gpio0", "gpio1", "gpio2", "gpio3", "gpio46",
> +};
> +static const char * const blsp_uim1_groups[] = {
> +	"gpio0", "gpio1",
> +};
> +static const char * const tgu_ch0_groups[] = {
> +	"gpio0",
> +};
> +static const char * const qdss_gpio4_groups[] = {
> +	"gpio0", "gpio36",
> +};
> +static const char * const atest_gpsadc1_groups[] = {
> +	"gpio0",
> +};
> +static const char * const blsp_uart1_groups[] = {
> +	"gpio0", "gpio1", "gpio2", "gpio3",
> +};
> +static const char * const phase_flag14_groups[] = {
> +	"gpio5",
> +};
> +static const char * const blsp_i2c2_groups[] = {
> +	"gpio6", "gpio7",
> +};
> +static const char * const phase_flag31_groups[] = {
> +	"gpio6",
> +};
> +static const char * const blsp_spi3_groups[] = {
> +	"gpio8", "gpio9", "gpio10", "gpio11",
> +};
> +static const char * const blsp_spi3_cs1_groups[] = {
> +	"gpio30",
> +};
> +static const char * const blsp_spi3_cs2_groups[] = {
> +	"gpio65",
> +};
> +static const char * const wlan1_adc1_groups[] = {
> +	"gpio8",
> +};
> +static const char * const atest_usb13_groups[] = {
> +	"gpio8",
> +};
> +static const char * const tgu_ch1_groups[] = {
> +	"gpio1",
> +};
> +static const char * const qdss_gpio5_groups[] = {
> +	"gpio1", "gpio37",
> +};
> +static const char * const atest_gpsadc0_groups[] = {
> +	"gpio1",
> +};
> +static const char * const blsp_i2c1_groups[] = {
> +	"gpio2", "gpio3",
> +};
> +static const char * const ddr_bist_groups[] = {
> +	"gpio3", "gpio8", "gpio9", "gpio10",
> +};
> +static const char * const atest_tsens2_groups[] = {
> +	"gpio3",
> +};
> +static const char * const atest_usb1_groups[] = {
> +	"gpio3",
> +};
> +static const char * const blsp_spi2_groups[] = {
> +	"gpio4", "gpio5", "gpio6", "gpio7",
> +};
> +static const char * const blsp_uim2_groups[] = {
> +	"gpio4", "gpio5",
> +};
> +static const char * const phase_flag3_groups[] = {
> +	"gpio4",
> +};
> +static const char * const bimc_dte1_groups[] = {
> +	"gpio8", "gpio10",
> +};
> +static const char * const wlan1_adc0_groups[] = {
> +	"gpio9",
> +};
> +static const char * const atest_usb12_groups[] = {
> +	"gpio9",
> +};
> +static const char * const bimc_dte0_groups[] = {
> +	"gpio9", "gpio11",
> +};
> +static const char * const blsp_i2c3_groups[] = {
> +	"gpio10", "gpio11",
> +};
> +static const char * const wlan2_adc1_groups[] = {
> +	"gpio10",
> +};
> +static const char * const atest_usb11_groups[] = {
> +	"gpio10",
> +};
> +static const char * const dbg_out_groups[] = {
> +	"gpio11",
> +};
> +static const char * const wlan2_adc0_groups[] = {
> +	"gpio11",
> +};
> +static const char * const atest_usb10_groups[] = {
> +	"gpio11",
> +};
> +static const char * const RCM_MARKER_groups[] = {
> +	"gpio12", "gpio13",
> +};
> +static const char * const blsp_spi4_groups[] = {
> +	"gpio12", "gpio13", "gpio14", "gpio15",
> +};
> +static const char * const pri_mi2s_groups[] = {
> +	"gpio12", "gpio14", "gpio15", "gpio61",
> +};
> +static const char * const phase_flag26_groups[] = {
> +	"gpio12",
> +};
> +static const char * const qdss_cti0_a_groups[] = {
> +	"gpio49", "gpio50",
> +};
> +static const char * const qdss_cti0_b_groups[] = {
> +	"gpio13", "gpio21",
> +};
> +static const char * const qdss_cti1_a_groups[] = {
> +	"gpio53", "gpio55",
> +};
> +static const char * const qdss_cti1_b_groups[] = {
> +	"gpio12", "gpio66",
> +};
> +static const char * const pri_mi2s_ws_groups[] = {
> +	"gpio13",
> +};
> +static const char * const phase_flag27_groups[] = {
> +	"gpio13",
> +};
> +static const char * const blsp_i2c4_groups[] = {
> +	"gpio14", "gpio15",
> +};
> +static const char * const phase_flag28_groups[] = {
> +	"gpio14",
> +};
> +static const char * const blsp_uart5_groups[] = {
> +	"gpio16", "gpio17", "gpio18", "gpio19",
> +};
> +static const char * const blsp_spi5_groups[] = {
> +	"gpio16", "gpio17", "gpio18", "gpio19",
> +};
> +static const char * const blsp_uim5_groups[] = {
> +	"gpio16", "gpio17",
> +};
> +static const char * const phase_flag5_groups[] = {
> +	"gpio17",
> +};
> +static const char * const blsp_i2c5_groups[] = {
> +	"gpio18", "gpio19",
> +};
> +static const char * const blsp_spi6_groups[] = {
> +	"gpio49", "gpio52", "gpio22", "gpio23",
> +};
> +static const char * const blsp_uart2_groups[] = {
> +	"gpio4", "gpio5", "gpio6", "gpio7",
> +};
> +static const char * const blsp_uim6_groups[] = {
> +	"gpio20", "gpio21",
> +};
> +static const char * const phase_flag11_groups[] = {
> +	"gpio21",
> +};
> +static const char * const vsense_data0_groups[] = {
> +	"gpio21",
> +};
> +static const char * const blsp_i2c6_groups[] = {
> +	"gpio22", "gpio23",
> +};
> +static const char * const phase_flag12_groups[] = {
> +	"gpio22",
> +};
> +static const char * const vsense_data1_groups[] = {
> +	"gpio22",
> +};
> +static const char * const phase_flag13_groups[] = {
> +	"gpio23",
> +};
> +static const char * const vsense_mode_groups[] = {
> +	"gpio23",
> +};
> +static const char * const blsp_spi7_groups[] = {
> +	"gpio24", "gpio25", "gpio26", "gpio27",
> +};
> +static const char * const blsp_uart6_a_groups[] = {
> +	"gpio24", "gpio25", "gpio26", "gpio27",
> +};
> +static const char * const blsp_uart6_b_groups[] = {
> +	"gpio28", "gpio29", "gpio30", "gpio31",
> +};
> +static const char * const sec_mi2s_groups[] = {
> +	"gpio24", "gpio25", "gpio26", "gpio27", "gpio62",
> +};
> +static const char * const sndwire_clk_groups[] = {
> +	"gpio24",
> +};
> +static const char * const phase_flag17_groups[] = {
> +	"gpio24",
> +};
> +static const char * const vsense_clkout_groups[] = {
> +	"gpio24",
> +};
> +static const char * const sndwire_data_groups[] = {
> +	"gpio25",
> +};
> +static const char * const phase_flag18_groups[] = {
> +	"gpio25",
> +};
> +static const char * const blsp_i2c7_groups[] = {
> +	"gpio26", "gpio27",
> +};
> +static const char * const phase_flag19_groups[] = {
> +	"gpio26",
> +};
> +static const char * const vfr_1_groups[] = {
> +	"gpio27",
> +};
> +static const char * const phase_flag20_groups[] = {
> +	"gpio27",
> +};
> +static const char * const NFC_INT_groups[] = {
> +	"gpio28",
> +};
> +static const char * const blsp_spi8_a_groups[] = {
> +	"gpio28", "gpio29", "gpio30", "gpio31",
> +};
> +static const char * const blsp_spi8_b_groups[] = {
> +	"gpio40", "gpio41", "gpio44", "gpio52",
> +};
> +static const char * const m_voc_groups[] = {
> +	"gpio28",
> +};
> +static const char * const phase_flag21_groups[] = {
> +	"gpio28",
> +};
> +static const char * const phase_flag22_groups[] = {
> +	"gpio29",
> +};
> +static const char * const blsp_i2c8_a_groups[] = {
> +	"gpio30", "gpio31",
> +};
> +static const char * const blsp_i2c8_b_groups[] = {
> +	"gpio44", "gpio52",
> +};
> +static const char * const phase_flag23_groups[] = {
> +	"gpio30",
> +};
> +static const char * const NFC_ESE_groups[] = {
> +	"gpio31",
> +};
> +static const char * const pwr_modem_groups[] = {
> +	"gpio31",
> +};
> +static const char * const phase_flag24_groups[] = {
> +	"gpio31",
> +};
> +static const char * const qdss_gpio_groups[] = {
> +	"gpio31", "gpio52", "gpio68", "gpio69",
> +};
> +static const char * const cam_mclk_groups[] = {
> +	"gpio32", "gpio33", "gpio34", "gpio35",
> +};
> +static const char * const pwr_nav_groups[] = {
> +	"gpio32",
> +};
> +static const char * const qdss_gpio0_groups[] = {
> +	"gpio32", "gpio67",
> +};
> +static const char * const qspi_data0_groups[] = {
> +	"gpio33",
> +};
> +static const char * const pwr_crypto_groups[] = {
> +	"gpio33",
> +};
> +static const char * const qdss_gpio1_groups[] = {
> +	"gpio33", "gpio63",
> +};
> +static const char * const qspi_data1_groups[] = {
> +	"gpio34",
> +};
> +static const char * const agera_pll_groups[] = {
> +	"gpio34", "gpio36",
> +};
> +static const char * const qdss_gpio2_groups[] = {
> +	"gpio34", "gpio64",
> +};
> +static const char * const qspi_data2_groups[] = {
> +	"gpio35",
> +};
> +static const char * const jitter_bist_groups[] = {
> +	"gpio35",
> +};
> +static const char * const qdss_gpio3_groups[] = {
> +	"gpio35", "gpio56",
> +};
> +static const char * const qdss_gpio7_groups[] = {
> +	"gpio39", "gpio71",
> +};
> +static const char * const mdss_vsync0_groups[] = {
> +	"gpio42",
> +};
> +static const char * const mdss_vsync1_groups[] = {
> +	"gpio42",
> +};
> +static const char * const mdss_vsync2_groups[] = {
> +	"gpio42",
> +};
> +static const char * const mdss_vsync3_groups[] = {
> +	"gpio42",
> +};
> +static const char * const qdss_gpio9_groups[] = {
> +	"gpio42", "gpio76",
> +};
> +static const char * const atest_usb2_groups[] = {
> +	"gpio35",
> +};
> +static const char * const cci_i2c_groups[] = {
> +	"gpio36", "gpio37", "gpio38", "gpio39",
> +};
> +static const char * const pll_bypassnl_groups[] = {
> +	"gpio36",
> +};
> +static const char * const atest_tsens_groups[] = {
> +	"gpio36",
> +};
> +static const char * const atest_usb21_groups[] = {
> +	"gpio36",
> +};
> +static const char * const pll_reset_groups[] = {
> +	"gpio37",
> +};
> +static const char * const atest_usb23_groups[] = {
> +	"gpio37",
> +};
> +static const char * const qdss_gpio6_groups[] = {
> +	"gpio38", "gpio70",
> +};
> +static const char * const qspi_cs_groups[] = {
> +	"gpio43", "gpio50",
> +};
> +static const char * const qdss_gpio10_groups[] = {
> +	"gpio43", "gpio77",
> +};
> +static const char * const qdss_gpio11_groups[] = {
> +	"gpio44", "gpio79",
> +};
> +static const char * const cci_async_groups[] = {
> +	"gpio45",
> +};
> +static const char * const qdss_gpio12_groups[] = {
> +	"gpio45", "gpio80",
> +};
> +static const char * const qdss_gpio13_groups[] = {
> +	"gpio46", "gpio78",
> +};
> +static const char * const qspi_clk_groups[] = {
> +	"gpio47",
> +};
> +static const char * const phase_flag30_groups[] = {
> +	"gpio47",
> +};
> +static const char * const qdss_gpio14_groups[] = {
> +	"gpio47", "gpio72",
> +};
> +static const char * const qspi_resetn_groups[] = {
> +	"gpio48",
> +};
> +static const char * const phase_flag1_groups[] = {
> +	"gpio48",
> +};
> +static const char * const qdss_gpio15_groups[] = {
> +	"gpio48", "gpio73",
> +};
> +static const char * const phase_flag2_groups[] = {
> +	"gpio49",
> +};
> +static const char * const phase_flag9_groups[] = {
> +	"gpio50",
> +};
> +static const char * const qspi_data3_groups[] = {
> +	"gpio51",
> +};
> +static const char * const phase_flag15_groups[] = {
> +	"gpio51",
> +};
> +static const char * const qdss_gpio8_groups[] = {
> +	"gpio51", "gpio75",
> +};
> +static const char * const phase_flag16_groups[] = {
> +	"gpio52",
> +};
> +static const char * const phase_flag6_groups[] = {
> +	"gpio53",
> +};
> +static const char * const phase_flag29_groups[] = {
> +	"gpio54",
> +};
> +static const char * const phase_flag25_groups[] = {
> +	"gpio55",
> +};
> +static const char * const phase_flag10_groups[] = {
> +	"gpio56",
> +};
> +static const char * const atest_usb20_groups[] = {
> +	"gpio56",
> +};
> +static const char * const gcc_gp1_groups[] = {
> +	"gpio57", "gpio78",
> +};
> +static const char * const phase_flag4_groups[] = {
> +	"gpio57",
> +};
> +static const char * const atest_usb22_groups[] = {
> +	"gpio57",
> +};
> +static const char * const gcc_gp2_groups[] = {
> +	"gpio58", "gpio81",
> +};
> +static const char * const atest_char_groups[] = {
> +	"gpio58",
> +};
> +static const char * const mdp_vsync_groups[] = {
> +	"gpio59", "gpio74",
> +};
> +static const char * const gcc_gp3_groups[] = {
> +	"gpio59", "gpio82",
> +};
> +static const char * const atest_char3_groups[] = {
> +	"gpio59",
> +};
> +static const char * const cri_trng0_groups[] = {
> +	"gpio60",
> +};
> +static const char * const atest_char2_groups[] = {
> +	"gpio60",
> +};
> +static const char * const cri_trng1_groups[] = {
> +	"gpio61",
> +};
> +static const char * const atest_char1_groups[] = {
> +	"gpio61",
> +};
> +static const char * const audio_ref_groups[] = {
> +	"gpio62",
> +};
> +static const char * const cri_trng_groups[] = {
> +	"gpio62",
> +};
> +static const char * const atest_char0_groups[] = {
> +	"gpio62",
> +};
> +static const char * const blsp_spi8_cs1_groups[] = {
> +	"gpio64",
> +};
> +static const char * const blsp_spi8_cs2_groups[] = {
> +	"gpio76",
> +};
> +static const char * const sp_cmu_groups[] = {
> +	"gpio64",
> +};
> +static const char * const nav_pps_a_groups[] = {
> +	"gpio65",
> +};
> +static const char * const nav_pps_b_groups[] = {
> +	"gpio98",
> +};
> +static const char * const nav_pps_c_groups[] = {
> +	"gpio80",
> +};
> +static const char * const gps_tx_a_groups[] = {
> +	"gpio65",
> +};
> +static const char * const gps_tx_b_groups[] = {
> +	"gpio98",
> +};
> +static const char * const gps_tx_c_groups[] = {
> +	"gpio80",
> +};
> +static const char * const adsp_ext_groups[] = {
> +	"gpio65",
> +};
> +static const char * const ssc_irq_groups[] = {
> +	"gpio67", "gpio68", "gpio69", "gpio70", "gpio71", "gpio72", "gpio74",
> +	"gpio75", "gpio76",
> +};
> +static const char * const isense_dbg_groups[] = {
> +	"gpio68",
> +};
> +static const char * const phase_flag0_groups[] = {
> +	"gpio68",
> +};
> +static const char * const phase_flag7_groups[] = {
> +	"gpio69",
> +};
> +static const char * const phase_flag8_groups[] = {
> +	"gpio70",
> +};
> +static const char * const tsense_pwm1_groups[] = {
> +	"gpio71",
> +};
> +static const char * const tsense_pwm2_groups[] = {
> +	"gpio71",
> +};
> +static const char * const mss_lte_groups[] = {
> +	"gpio81", "gpio82",
> +};
> +static const char * const uim2_data_groups[] = {
> +	"gpio83",
> +};
> +static const char * const uim2_clk_groups[] = {
> +	"gpio84",
> +};
> +static const char * const uim2_reset_groups[] = {
> +	"gpio85",
> +};
> +static const char * const uim2_present_groups[] = {
> +	"gpio86",
> +};
> +static const char * const uim1_data_groups[] = {
> +	"gpio87",
> +};
> +static const char * const uim1_clk_groups[] = {
> +	"gpio88",
> +};
> +static const char * const uim1_reset_groups[] = {
> +	"gpio89",
> +};
> +static const char * const uim1_present_groups[] = {
> +	"gpio90",
> +};
> +static const char * const uim_batt_groups[] = {
> +	"gpio91",
> +};
> +static const char * const pa_indicator_groups[] = {
> +	"gpio92",
> +};
> +static const char * const ldo_en_groups[] = {
> +	"gpio97",
> +};
> +static const char * const ldo_update_groups[] = {
> +	"gpio98",
> +};
> +static const char * const qlink_request_groups[] = {
> +	"gpio99",
> +};
> +static const char * const qlink_enable_groups[] = {
> +	"gpio100",
> +};
> +static const char * const prng_rosc_groups[] = {
> +	"gpio102",
> +};
> +
> +static const struct msm_function sdm660_functions[] = {
> +	FUNCTION(blsp_spi1),
> +	FUNCTION(gpio),
> +	FUNCTION(blsp_uim1),
> +	FUNCTION(tgu_ch0),
> +	FUNCTION(qdss_gpio4),
> +	FUNCTION(atest_gpsadc1),
> +	FUNCTION(blsp_uart1),
> +	FUNCTION(phase_flag14),
> +	FUNCTION(blsp_i2c2),
> +	FUNCTION(phase_flag31),
> +	FUNCTION(blsp_spi3),
> +	FUNCTION(blsp_spi3_cs1),
> +	FUNCTION(blsp_spi3_cs2),
> +	FUNCTION(wlan1_adc1),
> +	FUNCTION(atest_usb13),
> +	FUNCTION(tgu_ch1),
> +	FUNCTION(qdss_gpio5),
> +	FUNCTION(atest_gpsadc0),
> +	FUNCTION(blsp_i2c1),
> +	FUNCTION(ddr_bist),
> +	FUNCTION(atest_tsens2),
> +	FUNCTION(atest_usb1),
> +	FUNCTION(blsp_spi2),
> +	FUNCTION(blsp_uim2),
> +	FUNCTION(phase_flag3),
> +	FUNCTION(bimc_dte1),
> +	FUNCTION(wlan1_adc0),
> +	FUNCTION(atest_usb12),
> +	FUNCTION(bimc_dte0),
> +	FUNCTION(blsp_i2c3),
> +	FUNCTION(wlan2_adc1),
> +	FUNCTION(atest_usb11),
> +	FUNCTION(dbg_out),
> +	FUNCTION(wlan2_adc0),
> +	FUNCTION(atest_usb10),
> +	FUNCTION(blsp_spi4),
> +	FUNCTION(pri_mi2s),
> +	FUNCTION(phase_flag26),
> +	FUNCTION(qdss_cti0_a),
> +	FUNCTION(qdss_cti0_b),
> +	FUNCTION(qdss_cti1_a),
> +	FUNCTION(qdss_cti1_b),
> +	FUNCTION(pri_mi2s_ws),
> +	FUNCTION(phase_flag27),
> +	FUNCTION(blsp_i2c4),
> +	FUNCTION(phase_flag28),
> +	FUNCTION(blsp_uart5),
> +	FUNCTION(blsp_spi5),
> +	FUNCTION(blsp_uim5),
> +	FUNCTION(phase_flag5),
> +	FUNCTION(blsp_i2c5),
> +	FUNCTION(blsp_spi6),
> +	FUNCTION(blsp_uart2),
> +	FUNCTION(blsp_uim6),
> +	FUNCTION(phase_flag11),
> +	FUNCTION(vsense_data0),
> +	FUNCTION(blsp_i2c6),
> +	FUNCTION(phase_flag12),
> +	FUNCTION(vsense_data1),
> +	FUNCTION(phase_flag13),
> +	FUNCTION(vsense_mode),
> +	FUNCTION(blsp_spi7),
> +	FUNCTION(blsp_uart6_a),
> +	FUNCTION(blsp_uart6_b),
> +	FUNCTION(sec_mi2s),
> +	FUNCTION(sndwire_clk),
> +	FUNCTION(phase_flag17),
> +	FUNCTION(vsense_clkout),
> +	FUNCTION(sndwire_data),
> +	FUNCTION(phase_flag18),
> +	FUNCTION(blsp_i2c7),
> +	FUNCTION(phase_flag19),
> +	FUNCTION(vfr_1),
> +	FUNCTION(phase_flag20),
> +	FUNCTION(blsp_spi8_cs1),
> +	FUNCTION(blsp_spi8_cs2),
> +	FUNCTION(m_voc),
> +	FUNCTION(phase_flag21),
> +	FUNCTION(phase_flag22),
> +	FUNCTION(blsp_i2c8_a),
> +	FUNCTION(blsp_i2c8_b),
> +	FUNCTION(phase_flag23),
> +	FUNCTION(pwr_modem),
> +	FUNCTION(phase_flag24),
> +	FUNCTION(qdss_gpio),
> +	FUNCTION(cam_mclk),
> +	FUNCTION(pwr_nav),
> +	FUNCTION(qdss_gpio0),
> +	FUNCTION(qspi_data0),
> +	FUNCTION(pwr_crypto),
> +	FUNCTION(qdss_gpio1),
> +	FUNCTION(qspi_data1),
> +	FUNCTION(agera_pll),
> +	FUNCTION(qdss_gpio2),
> +	FUNCTION(qspi_data2),
> +	FUNCTION(jitter_bist),
> +	FUNCTION(qdss_gpio3),
> +	FUNCTION(qdss_gpio7),
> +	FUNCTION(mdss_vsync0),
> +	FUNCTION(mdss_vsync1),
> +	FUNCTION(mdss_vsync2),
> +	FUNCTION(mdss_vsync3),
> +	FUNCTION(qdss_gpio9),
> +	FUNCTION(atest_usb2),
> +	FUNCTION(cci_i2c),
> +	FUNCTION(pll_bypassnl),
> +	FUNCTION(atest_tsens),
> +	FUNCTION(atest_usb21),
> +	FUNCTION(pll_reset),
> +	FUNCTION(atest_usb23),
> +	FUNCTION(qdss_gpio6),
> +	FUNCTION(qspi_cs),
> +	FUNCTION(qdss_gpio10),
> +	FUNCTION(qdss_gpio11),
> +	FUNCTION(cci_async),
> +	FUNCTION(qdss_gpio12),
> +	FUNCTION(qdss_gpio13),
> +	FUNCTION(qspi_clk),
> +	FUNCTION(phase_flag30),
> +	FUNCTION(qdss_gpio14),
> +	FUNCTION(qspi_resetn),
> +	FUNCTION(phase_flag1),
> +	FUNCTION(qdss_gpio15),
> +	FUNCTION(phase_flag2),
> +	FUNCTION(phase_flag9),
> +	FUNCTION(qspi_data3),
> +	FUNCTION(phase_flag15),
> +	FUNCTION(qdss_gpio8),
> +	FUNCTION(phase_flag16),
> +	FUNCTION(phase_flag6),
> +	FUNCTION(phase_flag29),
> +	FUNCTION(phase_flag25),
> +	FUNCTION(phase_flag10),
> +	FUNCTION(atest_usb20),
> +	FUNCTION(gcc_gp1),
> +	FUNCTION(phase_flag4),
> +	FUNCTION(atest_usb22),
> +	FUNCTION(gcc_gp2),
> +	FUNCTION(atest_char),
> +	FUNCTION(mdp_vsync),
> +	FUNCTION(gcc_gp3),
> +	FUNCTION(atest_char3),
> +	FUNCTION(cri_trng0),
> +	FUNCTION(atest_char2),
> +	FUNCTION(cri_trng1),
> +	FUNCTION(atest_char1),
> +	FUNCTION(audio_ref),
> +	FUNCTION(cri_trng),
> +	FUNCTION(atest_char0),
> +	FUNCTION(blsp_spi8_a),
> +	FUNCTION(blsp_spi8_b),
> +	FUNCTION(sp_cmu),
> +	FUNCTION(nav_pps_a),
> +	FUNCTION(nav_pps_b),
> +	FUNCTION(nav_pps_c),
> +	FUNCTION(gps_tx_a),
> +	FUNCTION(gps_tx_b),
> +	FUNCTION(gps_tx_c),
> +	FUNCTION(adsp_ext),
> +	FUNCTION(ssc_irq),
> +	FUNCTION(isense_dbg),
> +	FUNCTION(phase_flag0),
> +	FUNCTION(phase_flag7),
> +	FUNCTION(phase_flag8),
> +	FUNCTION(tsense_pwm1),
> +	FUNCTION(tsense_pwm2),
> +	FUNCTION(mss_lte),
> +	FUNCTION(uim2_data),
> +	FUNCTION(uim2_clk),
> +	FUNCTION(uim2_reset),
> +	FUNCTION(uim2_present),
> +	FUNCTION(uim1_data),
> +	FUNCTION(uim1_clk),
> +	FUNCTION(uim1_reset),
> +	FUNCTION(uim1_present),
> +	FUNCTION(uim_batt),
> +	FUNCTION(pa_indicator),
> +	FUNCTION(ldo_en),
> +	FUNCTION(ldo_update),
> +	FUNCTION(qlink_request),
> +	FUNCTION(qlink_enable),
> +	FUNCTION(prng_rosc),
> +};
> +
> +static const struct msm_pingroup sdm660_groups[] = {
> +	PINGROUP(0, SOUTH, blsp_spi1, blsp_uart1, blsp_uim1, tgu_ch0, _, _, qdss_gpio4, atest_gpsadc1, _),
> +	PINGROUP(1, SOUTH, blsp_spi1, blsp_uart1, blsp_uim1, tgu_ch1, _, _, qdss_gpio5, atest_gpsadc0, _),
> +	PINGROUP(2, SOUTH, blsp_spi1, blsp_uart1, blsp_i2c1, _, _, _, _, _, _),
> +	PINGROUP(3, SOUTH, blsp_spi1, blsp_uart1, blsp_i2c1, ddr_bist, _, _, atest_tsens2, atest_usb1, _),
> +	PINGROUP(4, NORTH, blsp_spi2, blsp_uim2, blsp_uart2, phase_flag3, _, _, _, _, _),
> +	PINGROUP(5, SOUTH, blsp_spi2, blsp_uim2, blsp_uart2, phase_flag14, _, _, _, _, _),
> +	PINGROUP(6, SOUTH, blsp_spi2, blsp_i2c2, blsp_uart2, phase_flag31, _, _, _, _, _),
> +	PINGROUP(7, SOUTH, blsp_spi2, blsp_i2c2, blsp_uart2, _, _, _, _, _, _),
> +	PINGROUP(8, NORTH, blsp_spi3, ddr_bist, _, _, _, wlan1_adc1, atest_usb13, bimc_dte1, _),
> +	PINGROUP(9, NORTH, blsp_spi3, ddr_bist, _, _, _, wlan1_adc0, atest_usb12, bimc_dte0, _),
> +	PINGROUP(10, NORTH, blsp_spi3, blsp_i2c3, ddr_bist, _, _, wlan2_adc1, atest_usb11, bimc_dte1, _),
> +	PINGROUP(11, NORTH, blsp_spi3, blsp_i2c3, _, dbg_out, wlan2_adc0, atest_usb10, bimc_dte0, _, _),
> +	PINGROUP(12, NORTH, blsp_spi4, pri_mi2s, _, phase_flag26, qdss_cti1_b, _, _, _, _),
> +	PINGROUP(13, NORTH, blsp_spi4, _, pri_mi2s_ws, _, _, phase_flag27, qdss_cti0_b, _, _),
> +	PINGROUP(14, NORTH, blsp_spi4, blsp_i2c4, pri_mi2s, _, phase_flag28, _, _, _, _),
> +	PINGROUP(15, NORTH, blsp_spi4, blsp_i2c4, pri_mi2s, _, _, _, _, _, _),
> +	PINGROUP(16, CENTER, blsp_uart5, blsp_spi5, blsp_uim5, _, _, _, _, _, _),
> +	PINGROUP(17, CENTER, blsp_uart5, blsp_spi5, blsp_uim5, _, phase_flag5, _, _, _, _),
> +	PINGROUP(18, CENTER, blsp_uart5, blsp_spi5, blsp_i2c5, _, _, _, _, _, _),
> +	PINGROUP(19, CENTER, blsp_uart5, blsp_spi5, blsp_i2c5, _, _, _, _, _, _),
> +	PINGROUP(20, SOUTH, _, _, blsp_uim6, _, _, _, _, _, _),
> +	PINGROUP(21, SOUTH, _, _, blsp_uim6, _, phase_flag11, qdss_cti0_b, vsense_data0, _, _),
> +	PINGROUP(22, CENTER, blsp_spi6, _, blsp_i2c6, _, phase_flag12, vsense_data1, _, _, _),
> +	PINGROUP(23, CENTER, blsp_spi6, _, blsp_i2c6, _, phase_flag13, vsense_mode, _, _, _),
> +	PINGROUP(24, NORTH, blsp_spi7, blsp_uart6_a, sec_mi2s, sndwire_clk, _, _, phase_flag17, vsense_clkout, _),
> +	PINGROUP(25, NORTH, blsp_spi7, blsp_uart6_a, sec_mi2s, sndwire_data, _, _, phase_flag18, _, _),
> +	PINGROUP(26, NORTH, blsp_spi7, blsp_uart6_a, blsp_i2c7, sec_mi2s, _, phase_flag19, _, _, _),
> +	PINGROUP(27, NORTH, blsp_spi7, blsp_uart6_a, blsp_i2c7, vfr_1, sec_mi2s, _, phase_flag20, _, _),
> +	PINGROUP(28, CENTER, blsp_spi8_a, blsp_uart6_b, m_voc, _, phase_flag21, _, _, _, _),
> +	PINGROUP(29, CENTER, blsp_spi8_a, blsp_uart6_b, _, _, phase_flag22, _, _, _, _),
> +	PINGROUP(30, CENTER, blsp_spi8_a, blsp_uart6_b, blsp_i2c8_a, blsp_spi3_cs1, _, phase_flag23, _, _, _),
> +	PINGROUP(31, CENTER, blsp_spi8_a, blsp_uart6_b, blsp_i2c8_a, pwr_modem, _, phase_flag24, qdss_gpio, _, _),
> +	PINGROUP(32, SOUTH, cam_mclk, pwr_nav, _, _, qdss_gpio0, _, _, _, _),
> +	PINGROUP(33, SOUTH, cam_mclk, qspi_data0, pwr_crypto, _, _, qdss_gpio1, _, _, _),
> +	PINGROUP(34, SOUTH, cam_mclk, qspi_data1, agera_pll, _, _, qdss_gpio2, _, _, _),
> +	PINGROUP(35, SOUTH, cam_mclk, qspi_data2, jitter_bist, _, _, qdss_gpio3, _, atest_usb2, _),
> +	PINGROUP(36, SOUTH, cci_i2c, pll_bypassnl, agera_pll, _, _, qdss_gpio4, atest_tsens, atest_usb21, _),
> +	PINGROUP(37, SOUTH, cci_i2c, pll_reset, _, _, qdss_gpio5, atest_usb23, _, _, _),
> +	PINGROUP(38, SOUTH, cci_i2c, _, _, qdss_gpio6, _, _, _, _, _),
> +	PINGROUP(39, SOUTH, cci_i2c, _, _, qdss_gpio7, _, _, _, _, _),
> +	PINGROUP(40, SOUTH, _, _, blsp_spi8_b, _, _, _, _, _, _),
> +	PINGROUP(41, SOUTH, _, _, blsp_spi8_b, _, _, _, _, _, _),
> +	PINGROUP(42, SOUTH, mdss_vsync0, mdss_vsync1, mdss_vsync2, mdss_vsync3, _, _, qdss_gpio9, _, _),
> +	PINGROUP(43, SOUTH, _, _, qspi_cs, _, _, qdss_gpio10, _, _, _),
> +	PINGROUP(44, SOUTH, _, _, blsp_spi8_b, blsp_i2c8_b, _, _, qdss_gpio11, _, _),
> +	PINGROUP(45, SOUTH, cci_async, _, _, qdss_gpio12, _, _, _, _, _),
> +	PINGROUP(46, SOUTH, blsp_spi1, _, _, qdss_gpio13, _, _, _, _, _),
> +	PINGROUP(47, SOUTH, qspi_clk, _, phase_flag30, qdss_gpio14, _, _, _, _, _),
> +	PINGROUP(48, SOUTH, _, phase_flag1, qdss_gpio15, _, _, _, _, _, _),
> +	PINGROUP(49, SOUTH, blsp_spi6, phase_flag2, qdss_cti0_a, _, _, _, _, _, _),
> +	PINGROUP(50, SOUTH, qspi_cs, _, phase_flag9, qdss_cti0_a, _, _, _, _, _),
> +	PINGROUP(51, SOUTH, qspi_data3, _, phase_flag15, qdss_gpio8, _, _, _, _, _),
> +	PINGROUP(52, SOUTH, _, blsp_spi8_b, blsp_i2c8_b, blsp_spi6, phase_flag16, qdss_gpio, _, _, _),
> +	PINGROUP(53, NORTH, _, phase_flag6, qdss_cti1_a, _, _, _, _, _, _),
> +	PINGROUP(54, NORTH, _, _, phase_flag29, _, _, _, _, _, _),
> +	PINGROUP(55, SOUTH, _, phase_flag25, qdss_cti1_a, _, _, _, _, _, _),
> +	PINGROUP(56, SOUTH, _, phase_flag10, qdss_gpio3, _, atest_usb20, _, _, _, _),
> +	PINGROUP(57, SOUTH, gcc_gp1, _, phase_flag4, atest_usb22, _, _, _, _, _),
> +	PINGROUP(58, SOUTH, _, gcc_gp2, _, _, atest_char, _, _, _, _),
> +	PINGROUP(59, NORTH, mdp_vsync, gcc_gp3, _, _, atest_char3, _, _, _, _),
> +	PINGROUP(60, NORTH, cri_trng0, _, _, atest_char2, _, _, _, _, _),
> +	PINGROUP(61, NORTH, pri_mi2s, cri_trng1, _, _, atest_char1, _, _, _, _),
> +	PINGROUP(62, NORTH, sec_mi2s, audio_ref, _, cri_trng, _, _, atest_char0, _, _),
> +	PINGROUP(63, NORTH, _, _, _, qdss_gpio1, _, _, _, _, _),
> +	PINGROUP(64, SOUTH, blsp_spi8_cs1, sp_cmu, _, _, qdss_gpio2, _, _, _, _),
> +	PINGROUP(65, SOUTH, _, nav_pps_a, nav_pps_a, gps_tx_a, blsp_spi3_cs2, adsp_ext, _, _, _),
> +	PINGROUP(66, NORTH, _, _, qdss_cti1_b, _, _, _, _, _, _),
> +	PINGROUP(67, NORTH, _, _, qdss_gpio0, _, _, _, _, _, _),
> +	PINGROUP(68, NORTH, isense_dbg, _, phase_flag0, qdss_gpio, _, _, _, _, _),
> +	PINGROUP(69, NORTH, _, phase_flag7, qdss_gpio, _, _, _, _, _, _),
> +	PINGROUP(70, NORTH, _, phase_flag8, qdss_gpio6, _, _, _, _, _, _),
> +	PINGROUP(71, NORTH, _, _, qdss_gpio7, tsense_pwm1, tsense_pwm2, _, _, _, _),
> +	PINGROUP(72, NORTH, _, qdss_gpio14, _, _, _, _, _, _, _),
> +	PINGROUP(73, NORTH, _, _, qdss_gpio15, _, _, _, _, _, _),
> +	PINGROUP(74, NORTH, mdp_vsync, _, _, _, _, _, _, _, _),
> +	PINGROUP(75, NORTH, _, _, qdss_gpio8, _, _, _, _, _, _),
> +	PINGROUP(76, NORTH, blsp_spi8_cs2, _, _, _, qdss_gpio9, _, _, _, _),
> +	PINGROUP(77, NORTH, _, _, qdss_gpio10, _, _, _, _, _, _),
> +	PINGROUP(78, NORTH, gcc_gp1, _, qdss_gpio13, _, _, _, _, _, _),
> +	PINGROUP(79, SOUTH, _, _, qdss_gpio11, _, _, _, _, _, _),
> +	PINGROUP(80, SOUTH, nav_pps_b, nav_pps_b, gps_tx_c, _, _, qdss_gpio12, _, _, _),
> +	PINGROUP(81, CENTER, mss_lte, gcc_gp2, _, _, _, _, _, _, _),
> +	PINGROUP(82, CENTER, mss_lte, gcc_gp3, _, _, _, _, _, _, _),
> +	PINGROUP(83, SOUTH, uim2_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(84, SOUTH, uim2_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(85, SOUTH, uim2_reset, _, _, _, _, _, _, _, _),
> +	PINGROUP(86, SOUTH, uim2_present, _, _, _, _, _, _, _, _),
> +	PINGROUP(87, SOUTH, uim1_data, _, _, _, _, _, _, _, _),
> +	PINGROUP(88, SOUTH, uim1_clk, _, _, _, _, _, _, _, _),
> +	PINGROUP(89, SOUTH, uim1_reset, _, _, _, _, _, _, _, _),
> +	PINGROUP(90, SOUTH, uim1_present, _, _, _, _, _, _, _, _),
> +	PINGROUP(91, SOUTH, uim_batt, _, _, _, _, _, _, _, _),
> +	PINGROUP(92, SOUTH, _, _, pa_indicator, _, _, _, _, _, _),
> +	PINGROUP(93, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(94, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(95, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(96, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(97, SOUTH, _, ldo_en, _, _, _, _, _, _, _),
> +	PINGROUP(98, SOUTH, _, nav_pps_c, nav_pps_c, gps_tx_b, ldo_update, _, _, _, _),
> +	PINGROUP(99, SOUTH, qlink_request, _, _, _, _, _, _, _, _),
> +	PINGROUP(100, SOUTH, qlink_enable, _, _, _, _, _, _, _, _),
> +	PINGROUP(101, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(102, SOUTH, _, prng_rosc, _, _, _, _, _, _, _),
> +	PINGROUP(103, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(104, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(105, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(106, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(107, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(108, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(109, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(110, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(111, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(112, SOUTH, _, _, _, _, _, _, _, _, _),
> +	PINGROUP(113, SOUTH, _, _, _, _, _, _, _, _, _),
> +	SDC_QDSD_PINGROUP(sdc1_clk, 0x99a000, 13, 6),
> +	SDC_QDSD_PINGROUP(sdc1_cmd, 0x99a000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc1_data, 0x99a000, 9, 0),
> +	SDC_QDSD_PINGROUP(sdc2_clk, 0x99b000, 14, 6),
> +	SDC_QDSD_PINGROUP(sdc2_cmd, 0x99b000, 11, 3),
> +	SDC_QDSD_PINGROUP(sdc2_data, 0x99b000, 9, 0),
> +	SDC_QDSD_PINGROUP(sdc1_rclk, 0x99a000, 15, 0),
> +};
> +
> +static const struct msm_pinctrl_soc_data sdm660_pinctrl = {
> +	.pins = sdm660_pins,
> +	.npins = ARRAY_SIZE(sdm660_pins),
> +	.functions = sdm660_functions,
> +	.nfunctions = ARRAY_SIZE(sdm660_functions),
> +	.groups = sdm660_groups,
> +	.ngroups = ARRAY_SIZE(sdm660_groups),
> +	.ngpios = 114,
> +};
> +
> +static int sdm660_pinctrl_probe(struct platform_device *pdev)
> +{
> +	return msm_pinctrl_probe(pdev, &sdm660_pinctrl);
> +}
> +
> +static const struct of_device_id sdm660_pinctrl_of_match[] = {
> +	{ .compatible = "qcom,sdm660-pinctrl", },
> +	{ },
> +};
> +
> +static struct platform_driver sdm660_pinctrl_driver = {
> +	.driver = {
> +		.name = "sdm660-pinctrl",
> +		.of_match_table = sdm660_pinctrl_of_match,
> +	},
> +	.probe = sdm660_pinctrl_probe,
> +	.remove = msm_pinctrl_remove,
> +};
> +
> +static int __init sdm660_pinctrl_init(void)
> +{
> +	return platform_driver_register(&sdm660_pinctrl_driver);
> +}
> +arch_initcall(sdm660_pinctrl_init);
> +
> +static void __exit sdm660_pinctrl_exit(void)
> +{
> +	platform_driver_unregister(&sdm660_pinctrl_driver);
> +}
> +module_exit(sdm660_pinctrl_exit);
> +
> +MODULE_DESCRIPTION("QTI sdm660 pinctrl driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DEVICE_TABLE(of, sdm660_pinctrl_of_match);
> 

