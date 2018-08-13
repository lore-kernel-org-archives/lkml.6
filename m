Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FBBC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5977021829
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 07:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="DMS+YTI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5977021829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbeHMKhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 06:37:48 -0400
Received: from mail-he1eur01on0089.outbound.protection.outlook.com ([104.47.0.89]:34848
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728286AbeHMKhs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 06:37:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9rzLQ7Y+9l6dcDQGtAoiNEM+oqXAJywCf2voIGIV8A=;
 b=DMS+YTI8Kmy75rNkybVRQrg6sZQUBu7POpsqR4EFMUkbrhBO7SbSCFmJFHFqbxKg2+PwxZcAzMsVqYJBKtwqthm+LGlfKzcU1Wn2FTfLPj1AR6wZT+gZgCqMBsPNDMEHeqj8kDSj2fA+8mo7mWtq/GkX7Hk2SUKL8TU6TykncOI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 VI1PR04MB4672.eurprd04.prod.outlook.com (2603:10a6:803:71::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.22; Mon, 13 Aug 2018 07:56:28 +0000
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
 <970132e2-63ec-da56-07a2-56858c5b01ce@ysoft.com>
 <653C916B-1891-4393-8C70-14617AC4CC7F@gmail.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <eff22e4d-2b3c-1636-f483-ddbe3cb38bbc@ysoft.com>
Date:   Mon, 13 Aug 2018 09:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <653C916B-1891-4393-8C70-14617AC4CC7F@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0202CA0019.eurprd02.prod.outlook.com
 (2603:10a6:209:15::32) To VI1PR04MB4672.eurprd04.prod.outlook.com
 (2603:10a6:803:71::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a1a3e1b-189c-4d7c-6ddc-08d600f246b5
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR04MB4672;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;3:x+G0w9buAlfGnz8qDixF36YpSvkOuxPpaBTdDACejUw+OmAWpfEQVv8o9S1Ks7AHJvGvWDrbmHSwYAGkleXmEwH12XnaFbRquZgMp0Npf2wnV7KloRBPllBWdxyMCw4VL/9KIO6eyP4/xU+jbAoKsIZ09KrHWoSjhzgAUT2ruVuZ9OuETdy0vqrUARXfrffM+nRGIEpzXhgafWI3MCJr6Tun9BJ69vrjWGjOqI98yI2HBNDUB4LHWQolbhlNajpt;25:YOx7imw8DM3QS/fIV+x9bCb74v01Y9twB1PdQ4+V/ndKQkdEgR/IuzQ2tGRPUOj+HKuUJ+g3+DlsdkaDLkYHPBjjkdecZZELv1xTvxfRErqs2t3WIHdI4ovCnBy1sv2zlsnZzK8KV4GEGYtMOF8ctPaqNsQWnTcsPITkZD816jq2bT2RsPx/FwlKJWzAw/uLJaUBH5DvwSsJCC1FyYVOFNja+VDyzQ3h+nq8DdWf7IGDvdtQo4CG7prNLvaJYrvdP76bZA6PYagty63te/hirMPv6+Q0Yibj7m5Os5AztbgYZwLTMYabJJCX7X+mM0ldmb8nJXodY6/do+G0lDpJfw==;31:Ut1uLmYPcZRzCuExbwOb0AxLSOR33giq4P9HA7EhoFmI/NdrzwWfiA7HqUy6E5vsY3WgWRq3SoJhPxL/GUGY5kWnFNZMjrdU8YH85W2zOdnRuLE3xu8qbjCv5KYdgUqvOqwpPHDSQIf8S87Ghg4cVr61RDoBdi7rloRH0lbLPoH/7V6KSure9soLFVTOz9MHB1zuahcg35d3foQm0+7edpOM9KhNFhpnPbwdHVgEKns=
X-MS-TrafficTypeDiagnostic: VI1PR04MB4672:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;20:9FOQnuvPdS3T8v+Jreq5Abiohqyrt08xHZga+ZpqaSWElOIMo4qyEbxk1k4IeYUAyn+e1OaS9MNUtKKCgm3SF/qxIaSppsGU4tXIPD3giwRwrGFIFD0bUsA3MXGNVypHnXySxvWNufsSwl8C/T1fgvbbVe8pc2oxH1nHIjxbnQ6o+eD474d8VP/cDxD/mYID6iN7qKceRWhXO2nbgT3Olt0mvZeUpFceZe0sY9q+xP+SzrEak1E0mEvHfUfTjavF;4:xXqvmp0hefhoktIpqj0VBI8/laATn57oMGt5kMX4+NtOslcNr5vyAUssQ3GxbXeAVWZq8jD0h8hIn8XBuo51n3QwFvMM1n6sQj7JK28cXdEWlHhgAROj8FmFGhTz6h5K3xU6+OFvZsWFR76fm6MGN25dpGRqlacib2uOfEJtGKU+brh4hB4DAcIu9/y/EraZhokm3ZHgBFei1OIQSkUr9roUwC/kRbk5mUO6gAIR1upJkN7hfHT8bl17r3PDpPBUxjEPXRaXxU3vk6yKv6sm5XtUu7s7zeDqGsT+WGYZ5upKM7UJsq0DQwABu3PY3l7D
X-Microsoft-Antispam-PRVS: <VI1PR04MB4672A5A70D2334AAA55FF9D29E390@VI1PR04MB4672.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:VI1PR04MB4672;BCL:0;PCL:0;RULEID:;SRVR:VI1PR04MB4672;
X-Forefront-PRVS: 07630F72AD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39840400004)(376002)(346002)(366004)(136003)(37524003)(199004)(189003)(76176011)(77096007)(52146003)(2486003)(23676004)(316002)(26005)(2906002)(229853002)(52116002)(2616005)(956004)(11346002)(68736007)(72206003)(7736002)(486006)(476003)(478600001)(16576012)(53546011)(39060400002)(36756003)(386003)(53946003)(64126003)(53936002)(6246003)(50466002)(446003)(2870700001)(58126008)(67846002)(6486002)(54906003)(8676002)(14444005)(5660300001)(3846002)(4326008)(305945005)(31696002)(86362001)(6666003)(16526019)(6116002)(65956001)(66066001)(85182001)(1411001)(47776003)(6916009)(81166006)(186003)(65826007)(105586002)(65806001)(106356001)(81156014)(8936002)(97736004)(25786009)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB4672;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjA0TUI0NjcyOzIzOmVGYmtmaGU0Sng4ZmZHTnRyb25BcGYyMEpZ?=
 =?utf-8?B?L1pSaGdob1dEeSs4ejF1NmtxSGhJVllFUm5DWlV3TXp4RzY0QVlZdkVxZ1Jl?=
 =?utf-8?B?T3cvL29Ca3RTZjlzQ1k1ZkdDSXo2YmZHempjWCtlaEJjWjZIOUNwNWx4U2V6?=
 =?utf-8?B?c2hDY3BzTWZIUEdyNUIrR29KU0tpdWd6TStoV0p6NmxvMkdxTWE5WUt0alJD?=
 =?utf-8?B?MUJMTkhqMUYxUlkxdGFwV1dIOFJhY09VNWxDQmFIbnlRYmxNT3RoNmJ0UzV3?=
 =?utf-8?B?SGR3Z2tuczM1OWtIK056SkhMR0NDQ1ZIcWQybGJJZ1kyaE1pL3d6RjlxSFZa?=
 =?utf-8?B?K0tHUktvaXpkM2s2V094R2Fyd0RwMzFXc2tmVnBoeVN3eGxLRFBrM0hkRHpm?=
 =?utf-8?B?c2dmMjdKSTlEUDkzb1VUeThUYUdpUlVrSlpuckg0L1kwSEdXN2NGamFJVjNp?=
 =?utf-8?B?b3RWaTltL2tNZmxQeFdoUXJ3MVFuZzBBNCtQMGNFNENLOTFDY2NOT2JVNnpR?=
 =?utf-8?B?S3FzaTh1VkpqZ3huUlExaXhOVUYzR2Fvajh4UkFSU0xlT0l4cXljUm1yeEZU?=
 =?utf-8?B?RThrUEtaOVJ2T0hFQU9WWWpZN1VtQkkwMEFoRUc0UTlxaGlHNTJtWmZkbUlD?=
 =?utf-8?B?ZVdONjRCT1hOZWNZQnVkc2JKM1NGMFBHMEVLc1V5ZzJWVy9WNHZSQUluQVFx?=
 =?utf-8?B?Vk9MZnoyTEExV3o5TXI2cnBEbkllWHJxR1F3Z1FpQlBFOW92bzFpUjJ4Z0dy?=
 =?utf-8?B?UHJaRzBkWEJaK1ZzUXNTK1ZWMzVHak1HaWhXYnJwc1ZPdjF3Z1pHbmNzOFA4?=
 =?utf-8?B?YmhCTmxpTGZFcWg2bklxb09hMVNXQS9SaTRmNlBlcURZeWdtai9TNHZkUmJi?=
 =?utf-8?B?NWJ2MzNLckpjTDJrOHdnY1VBU2U0UUZuK01CTWU0OThHN3hKTk0rZndXY1Vu?=
 =?utf-8?B?WnQ2Y3luZnZONWI0eEtjelc0c0tyM3EwWUJWL0UzMU5uNkxNNXZiZzF1Z3F6?=
 =?utf-8?B?TFBSUUM5NXFTWEZja0dsREdybFNHNlBuZC9PbmxzbzRNVFNJYUhMekRoNHQ1?=
 =?utf-8?B?TDcxbEw5WGZvL1BOTExYclA5aTN0cEljMVZXNVBKa0IxTmNuWWM5QnNpb0I1?=
 =?utf-8?B?S0NJSU5SZEM4VFNaVUlwL1cxS0NKSTRhUWFWTFN6YVVCNmYvQ3VxS2ZjYjJ5?=
 =?utf-8?B?emRscCtUSkhQKzNkM3B3bkVHRXl6d1JpV1VmS1ZhKytLOEdrVmwweHM0WWdt?=
 =?utf-8?B?S3JVNXhabXVIeFU0eC9wckJXdkkwbDlXSy9YV1BHMlNJcmVGUm8yWER3bHNY?=
 =?utf-8?B?UVl6MFhvcVN0OGhQTnRDZS9tTWh5N1FYM2dmQm1CWHc3Skd1UTI3ZHFNVURW?=
 =?utf-8?B?d0pkYlYyVG1lWWNMdjBXUytaYzhuRG9IL09tSitBTTdlUVNxRmdXMlpSMU5E?=
 =?utf-8?B?Q0dIOEF6UmI3VzZWbjNydVgrY1poSTR2V0o2RjlBMDR0ZWZZUUR4Uko3YUVT?=
 =?utf-8?B?N0NRU3hNenljY2ZmS3FndGQxU05wWWtlOU5tSkhVdHRVOURNUkF4bkk0WlIz?=
 =?utf-8?B?Ym10RzM0VVhzczY0MTJOM0JJN1ZMRi9wUmQ5T0hBZWY1MkcvOFkvTTE4WWxU?=
 =?utf-8?B?NnpZa04vZW1rZ0hiQkk3akhlR2xMSHZaWXRHcFluZ0ZDNFAwVUNOWStMeUFp?=
 =?utf-8?B?clkwYlpQMTZhdkNmRVFTK3NFTS9HMWNlOTFoNjJUYkNCSmdQbDdzaDdib2Vu?=
 =?utf-8?B?RXhQVlIyWG9oTkNFODEvckpqaXZSdmdlcGY1L3VNV0lVU21kbkhXbEdvRmVx?=
 =?utf-8?B?NTlYUTR1bFlsYm5LME5BRUIxZi83ejd6ZERGRkllTWxkWkNTMEZYeHh4UHJm?=
 =?utf-8?B?eDBZQ2d6VUQ0TWRyNXRNTU54SFc0UkhSWGhMUStuZ05WbGxGc09uUktOa2tj?=
 =?utf-8?B?TVVKcjNwUzdMM0VvQVRBaVZnWFNLTWJPYy8xOVJKRm5sVVVZZTcrRG9aVGo0?=
 =?utf-8?B?eGRLK2VJNGlFRllERzdCK2UzRkVSTDk1dEE1MjBnajBRQzg4OGtRU0ZEQ01m?=
 =?utf-8?B?WlZvZXcyTUJiWnFZTUxUT1Axam9BYzA0VlV6OE02Z0s0NFR6Q0Y4NDNGQkVQ?=
 =?utf-8?Q?slVQ5BSfXJ7RJnDUoSYDA0BQrtc9vNbzSfRGhTdXJqe5?=
X-Microsoft-Antispam-Message-Info: e8pI5T1g84kn2p0MkeWtG8iF/XyzfbK2PriX2bKcf276Wbb3eU688qYvZXf8Bj06FjDsYw1czK36pRYv0l1kB8UAkgzKh5ULBynvHHngv8G3yc2TJ4eLQn9IxAN36TlR2RjDkqkfTB5ASic6+NdenKOfQMHLUoTLGOWVfApQdXirXjdYTGPIktF9AAf7Wx9ocmDoBIA6FJfK4DF7HB8E4e1LpdMZCn/9Nh9UUMwaPi5VvCC1UCtHzfKSVofvFQe8VCs9KBnUdqNjm2zaeOfzQAwZe4nqNB27xCM23leL+J0Zqc3AMV4R1ZNi8aWCTfG7wu/OslvZq5Y7sGDYe6CGv7voqRTNlWQ/xq60OD4o4I4=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR04MB4672;6:nYQG+0wuXa0Oc2L7cQ4RmvduPCyGvpMMYWbOP995FQ8aSC5Zn0zwZTI0SsB0L5/JrGKVg/Jcfnb5/EpwZqdmK1pI4wdw9DyMSWLfWelKmIe50AF9ZmWVqAo87qZHgcgbGDUSyqYWSWCVuOo39pDzrIo/M3cKfdgbc4M1upU0XzhEvYUlg5UiCH48LiU8MiwrL6mjThgtmkX6BQ9spDVvULTOYx/iP3G7rGG4aU5/ISDD1vnr2uYx7Av8siNsqKK9KVpb4cuZu7VvDluRBpH2zn4+MEDH8MRVDRJA7fTbLHleFqWzIyTZZ/E2Vx6siDSaCgHAgLXV9XwwpCyCVMuQSKw0s/nt6glW+BLf0SI9UE5Swn1S4uvBqo7V7cjqC38Dzuq8lX25HyP5wf8Nm9HtamebobWasZfy7bBNGx6CkKXrRT64C0EUN92M8Xz0O4UFrSOMexP89b+vEJOYtHNxIQ==;5:X4Qk45EYqkYSSfuh6H54V2XDixOVkzt3qubLAYrKG6QSYdWWg0AhIRlqJIuwxC3Ol4Dz5zJfvbaAUPbdy3PaXPXS6+ehW73fBcxyfyBbZdVwv5d4HSTNN21JsABH4ej1I7YpTf00lF/CMnh5fOdA0EwQkm7q330f1iTo88x+S8A=;7:oIa3bJNm8u2X533dQM+s56WMlNGMh1etak07qPTmYp2jwmClf//YX/WesPzpGR4QcWdSSULy42ZdCiYDEge9Zpg5Lvy39eFsFHpTuMNrpIGOUX3MS587OczYINLssJTs6gj/7YAJve4Jw7GEdqJF0xcoK0ogm2wx0k5U/Oc+EwiF4r5povk0rR/8NrbTMk+DPYr9FOcXUJyIz55VjwMSqZ3meQumvdh8mQE/5yKu0ZPRlWVZ9X4Unb1NPT9XBrIx
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2018 07:56:28.2415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a3e1b-189c-4d7c-6ddc-08d600f246b5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4672
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.8.2018 09:36, Craig Tatlor wrote:
> 
> 
> On 13 August 2018 08:24:43 BST, "Michal Vokáč" <michal.vokac@ysoft.com> wrote:
>> Hi Craig,
>> On 12.8.2018 16:24, Craig Tatlor wrote:
>>> Add initial pinctrl driver to support pin configuration with
>>> pinctrl framework for sdm660.
>>> Based off CAF implementation.
>>>
>>> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
>>> ---
>>
>> The documentation portion should be a separate patch.
>> Please refer to
>> Documentation/devicetree/bindings/submitting-patches.txt
>>
>> It is easier for DT maintainers to review just the relevant part.
>> The binding patches are also rebased to a separate tree as they are not
>> Linux specific and can be re-used in other OSes
>>
>> Best regards,
>> Michal
> I know, just did this because it is basically exactly same as other qcom pinctrl docs and they also only had one patch.

OK, I see. Anyway to me it seems that at some point this practice should
change. Is it not better to prepare the patches how we want them to look
like than how they looked like in the past?

I see the same problems elsewhere where folks are copying commits from
each other. Like the messy SPDX license headers transformation..

> 
> Sorry if you got this multiple times, apparently my email client adds HTML to non inline replies
>>
>>> Changes from v1:
>>>     Adds gpio-ranges property to bindings
>>>
>>>
>>>    .../bindings/pinctrl/qcom,sdm660-pinctrl.txt  |  202 +++
>>>    drivers/pinctrl/qcom/Kconfig                  |   10 +
>>>    drivers/pinctrl/qcom/Makefile                 |    1 +
>>>    drivers/pinctrl/qcom/pinctrl-sdm660.c         | 1451
>> +++++++++++++++++
>>>    4 files changed, 1663 insertions(+)
>>>    create mode 100644
>> Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
>>>    create mode 100644 drivers/pinctrl/qcom/pinctrl-sdm660.c
>>>
>>> diff --git
>> a/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
>> b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
>>> new file mode 100644
>>> index 000000000000..801960ad2112
>>> --- /dev/null
>>> +++
>> b/Documentation/devicetree/bindings/pinctrl/qcom,sdm660-pinctrl.txt
>>> @@ -0,0 +1,202 @@
>>> +Qualcomm Technologies, Inc. SDM660 TLMM block
>>> +
>>> +This binding describes the Top Level Mode Multiplexer block found in
>> the
>>> +SDM660 platform.
>>> +
>>> +- compatible:
>>> +	Usage: required
>>> +	Value type: <string>
>>> +	Definition: must be "qcom,sdm660-pinctrl"
>>> +
>>> +- reg:
>>> +	Usage: required
>>> +	Value type: <prop-encoded-array>
>>> +	Definition: the base address and size of the TLMM register space.
>>> +
>>> +- interrupts:
>>> +	Usage: required
>>> +	Value type: <prop-encoded-array>
>>> +	Definition: should specify the TLMM summary IRQ.
>>> +
>>> +- interrupt-controller:
>>> +	Usage: required
>>> +	Value type: <none>
>>> +	Definition: identifies this node as an interrupt controller
>>> +
>>> +- #interrupt-cells:
>>> +	Usage: required
>>> +	Value type: <u32>
>>> +	Definition: must be 2. Specifying the pin number and flags, as
>> defined
>>> +		    in <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +- gpio-controller:
>>> +	Usage: required
>>> +	Value type: <none>
>>> +	Definition: identifies this node as a gpio controller
>>> +
>>> +- gpio-ranges:
>>> +	Usage: required
>>> +	Value type: <prop-encoded-array>
>>> +	Definition: Specifies the mapping between gpio controller and
>>> +		    pin-controller pins.
>>> +
>>> +- #gpio-cells:
>>> +	Usage: required
>>> +	Value type: <u32>
>>> +	Definition: must be 2. Specifying the pin number and flags, as
>> defined
>>> +		    in <dt-bindings/gpio/gpio.h>
>>> +
>>> +Please refer to ../gpio/gpio.txt and
>> ../interrupt-controller/interrupts.txt for
>>> +a general description of GPIO and interrupt bindings.
>>> +
>>> +Please refer to pinctrl-bindings.txt in this directory for details
>> of the
>>> +common pinctrl bindings used by client devices, including the
>> meaning of the
>>> +phrase "pin configuration node".
>>> +
>>> +The pin configuration nodes act as a container for an arbitrary
>> number of
>>> +subnodes. Each of these subnodes represents some desired
>> configuration for a
>>> +pin, a group, or a list of pins or groups. This configuration can
>> include the
>>> +mux function to select on those pin(s)/group(s), and various pin
>> configuration
>>> +parameters, such as pull-up, drive strength, etc.
>>> +
>>> +
>>> +PIN CONFIGURATION NODES:
>>> +
>>> +The name of each subnode is not important; all subnodes should be
>> enumerated
>>> +and processed purely based on their content.
>>> +
>>> +Each subnode only affects those parameters that are explicitly
>> listed. In
>>> +other words, a subnode that lists a mux function but no pin
>> configuration
>>> +parameters implies no information about any pin configuration
>> parameters.
>>> +Similarly, a pin subnode that describes a pullup parameter implies
>> no
>>> +information about e.g. the mux function.
>>> +
>>> +
>>> +The following generic properties as defined in pinctrl-bindings.txt
>> are valid
>>> +to specify in a pin configuration subnode:
>>> +
>>> +- pins:
>>> +	Usage: required
>>> +	Value type: <string-array>
>>> +	Definition: List of gpio pins affected by the properties specified
>> in
>>> +		    this subnode.  Valid pins are:
>>> +		    gpio0-gpio113,
>>> +		        Supports mux, bias and drive-strength
>>> +		    sdc1_clk, sdc1_cmd, sdc1_data sdc2_clk, sdc2_cmd, sdc2_data
>> sdc1_rclk,
>>> +		        Supports bias and drive-strength
>>> +
>>> +- function:
>>> +	Usage: required
>>> +	Value type: <string>
>>> +	Definition: Specify the alternative function to be configured for
>> the
>>> +		    specified pins. Functions are only valid for gpio pins.
>>> +		    Valid values are:
>>> +
>>> +		    blsp_uart1, blsp_spi1, blsp_i2c1, blsp_uim1, atest_tsens,
>>> +		    bimc_dte1, dac_calib0, blsp_spi8, blsp_uart8, blsp_uim8,
>>> +		    qdss_cti_trig_out_b, bimc_dte0, dac_calib1,
>> qdss_cti_trig_in_b,
>>> +		    dac_calib2, atest_tsens2, atest_usb1, blsp_spi10, blsp_uart10,
>>> +		    blsp_uim10, atest_bbrx1, atest_usb13, atest_bbrx0,
>> atest_usb12,
>>> +		    mdp_vsync, edp_lcd, blsp_i2c10, atest_gpsadc1, atest_usb11,
>>> +		    atest_gpsadc0, edp_hot, atest_usb10, m_voc, dac_gpio,
>> atest_char,
>>> +		    cam_mclk, pll_bypassnl, qdss_stm7, blsp_i2c8,
>> qdss_tracedata_b,
>>> +		    pll_reset, qdss_stm6, qdss_stm5, qdss_stm4, atest_usb2,
>> cci_i2c,
>>> +		    qdss_stm3, dac_calib3, atest_usb23, atest_char3, dac_calib4,
>>> +		    qdss_stm2, atest_usb22, atest_char2, qdss_stm1, dac_calib5,
>>> +		    atest_usb21, atest_char1, dbg_out, qdss_stm0, dac_calib6,
>>> +		    atest_usb20, atest_char0, dac_calib10, qdss_stm10,
>>> +		    qdss_cti_trig_in_a, cci_timer4, blsp_spi6, blsp_uart6,
>> blsp_uim6,
>>> +		    blsp2_spi, qdss_stm9, qdss_cti_trig_out_a, dac_calib11,
>>> +		    qdss_stm8, cci_timer0, qdss_stm13, dac_calib7, cci_timer1,
>>> +		    qdss_stm12, dac_calib8, cci_timer2, blsp1_spi, qdss_stm11,
>>> +		    dac_calib9, cci_timer3, cci_async, dac_calib12, blsp_i2c6,
>>> +		    qdss_tracectl_a, dac_calib13, qdss_traceclk_a, dac_calib14,
>>> +		    dac_calib15, hdmi_rcv, dac_calib16, hdmi_cec, pwr_modem,
>>> +		    dac_calib17, hdmi_ddc, pwr_nav, dac_calib18, pwr_crypto,
>>> +		    dac_calib19, hdmi_hot, dac_calib20, dac_calib21, pci_e0,
>>> +		    dac_calib22, dac_calib23, dac_calib24, tsif1_sync,
>> dac_calib25,
>>> +		    sd_write, tsif1_error, blsp_spi2, blsp_uart2, blsp_uim2,
>>> +		    qdss_cti, blsp_i2c2, blsp_spi3, blsp_uart3, blsp_uim3,
>> blsp_i2c3,
>>> +		    uim3, blsp_spi9, blsp_uart9, blsp_uim9, blsp10_spi, blsp_i2c9,
>>> +		    blsp_spi7, blsp_uart7, blsp_uim7, qdss_tracedata_a, blsp_i2c7,
>>> +		    qua_mi2s, gcc_gp1_clk_a, ssc_irq, uim4, blsp_spi11,
>> blsp_uart11,
>>> +		    blsp_uim11, gcc_gp2_clk_a, gcc_gp3_clk_a, blsp_i2c11,
>> cri_trng0,
>>> +		    cri_trng1, cri_trng, qdss_stm18, pri_mi2s, qdss_stm17,
>> blsp_spi4,
>>> +		    blsp_uart4, blsp_uim4, qdss_stm16, qdss_stm15, blsp_i2c4,
>>> +		    qdss_stm14, dac_calib26, spkr_i2s, audio_ref, lpass_slimbus,
>>> +		    isense_dbg, tsense_pwm1, tsense_pwm2, btfm_slimbus, ter_mi2s,
>>> +		    qdss_stm22, qdss_stm21, qdss_stm20, qdss_stm19, gcc_gp1_clk_b,
>>> +		    sec_mi2s, blsp_spi5, blsp_uart5, blsp_uim5, gcc_gp2_clk_b,
>>> +		    gcc_gp3_clk_b, blsp_i2c5, blsp_spi12, blsp_uart12, blsp_uim12,
>>> +		    qdss_stm25, qdss_stm31, blsp_i2c12, qdss_stm30, qdss_stm29,
>>> +		    tsif1_clk, qdss_stm28, tsif1_en, tsif1_data, sdc4_cmd,
>> qdss_stm27,
>>> +		    qdss_traceclk_b, tsif2_error, sdc43, vfr_1, qdss_stm26,
>> tsif2_clk,
>>> +		    sdc4_clk, qdss_stm24, tsif2_en, sdc42, qdss_stm23,
>> qdss_tracectl_b,
>>> +		    sd_card, tsif2_data, sdc41, tsif2_sync, sdc40, mdp_vsync_p_b,
>>> +		    ldo_en, mdp_vsync_s_b, ldo_update, blsp11_uart_tx_b,
>> blsp11_uart_rx_b,
>>> +		    blsp11_i2c_sda_b, prng_rosc, blsp11_i2c_scl_b, uim2, uim1,
>> uim_batt,
>>> +		    pci_e2, pa_indicator, adsp_ext, ddr_bist, qdss_tracedata_11,
>>> +		    qdss_tracedata_12, modem_tsync, nav_dr, nav_pps, pci_e1,
>> gsm_tx,
>>> +		    qspi_cs, ssbi2, ssbi1, mss_lte, qspi_clk, qspi0, qspi1, qspi2,
>> qspi3,
>>> +		    gpio
>>> +
>>> +- bias-disable:
>>> +	Usage: optional
>>> +	Value type: <none>
>>> +	Definition: The specified pins should be configued as no pull.
>>> +
>>> +- bias-pull-down:
>>> +	Usage: optional
>>> +	Value type: <none>
>>> +	Definition: The specified pins should be configued as pull down.
>>> +
>>> +- bias-pull-up:
>>> +	Usage: optional
>>> +	Value type: <none>
>>> +	Definition: The specified pins should be configued as pull up.
>>> +
>>> +- output-high:
>>> +	Usage: optional
>>> +	Value type: <none>
>>> +	Definition: The specified pins are configured in output mode,
>> driven
>>> +		    high.
>>> +		    Not valid for sdc pins.
>>> +
>>> +- output-low:
>>> +	Usage: optional
>>> +	Value type: <none>
>>> +	Definition: The specified pins are configured in output mode,
>> driven
>>> +		    low.
>>> +		    Not valid for sdc pins.
>>> +
>>> +- drive-strength:
>>> +	Usage: optional
>>> +	Value type: <u32>
>>> +	Definition: Selects the drive strength for the specified pins, in
>> mA.
>>> +		    Valid values are: 2, 4, 6, 8, 10, 12, 14 and 16
>>> +
>>> +Example:
>>> +
>>> +	tlmm: pinctrl@1010000 {
>>> +		compatible = "qcom,sdm660-pinctrl";
>>> +		reg = <0x1010000 0x300000>;
>>> +		interrupts = <0 208 0>;
>>> +		gpio-controller;
>>> +		gpio-ranges = <&tlmm 0 0 114>;
>>> +		#gpio-cells = <2>;
>>> +		interrupt-controller;
>>> +		#interrupt-cells = <2>;
>>> +
>>> +		uart_console_active: uart_console_active {
>>> +			mux {
>>> +				pins = "gpio4", "gpio5";
>>> +				function = "blsp_uart8";
>>> +			};
>>> +
>>> +			config {
>>> +				pins = "gpio4", "gpio5";
>>> +				drive-strength = <2>;
>>> +				bias-disable;
>>> +			};
>>> +		};
>>> +	};
>>> diff --git a/drivers/pinctrl/qcom/Kconfig
>> b/drivers/pinctrl/qcom/Kconfig
>>> index 195492033075..091beadb8a1c 100644
>>> --- a/drivers/pinctrl/qcom/Kconfig
>>> +++ b/drivers/pinctrl/qcom/Kconfig
>>> @@ -147,6 +147,16 @@ config PINCTRL_QCOM_SSBI_PMIC
>>>             which are using SSBI for communication with SoC. Example
>> PMIC's
>>>             devices are pm8058 and pm8921.
>>>    
>>> +config PINCTRL_SDM660
>>> +       tristate "Qualcomm Technologies Inc SDM660 pin controller
>> driver"
>>> +       depends on GPIOLIB && OF
>>> +       select PINCTRL_MSM
>>> +       help
>>> +         This is the pinctrl, pinmux, pinconf and gpiolib driver for
>> the
>>> +         Qualcomm Technologies Inc TLMM block found on the Qualcomm
>>> +         Technologies Inc SDM660 platform.
>>> +
>>> +
>>>    config PINCTRL_SDM845
>>>           tristate "Qualcomm Technologies Inc SDM845 pin controller
>> driver"
>>>           depends on GPIOLIB && OF
>>> diff --git a/drivers/pinctrl/qcom/Makefile
>> b/drivers/pinctrl/qcom/Makefile
>>> index 0c6f3ddc296d..9b08808a2f1c 100644
>>> --- a/drivers/pinctrl/qcom/Makefile
>>> +++ b/drivers/pinctrl/qcom/Makefile
>>> @@ -19,4 +19,5 @@ obj-$(CONFIG_PINCTRL_QCOM_SPMI_PMIC) +=
>> pinctrl-spmi-gpio.o
>>>    obj-$(CONFIG_PINCTRL_QCOM_SPMI_PMIC) += pinctrl-spmi-mpp.o
>>>    obj-$(CONFIG_PINCTRL_QCOM_SSBI_PMIC) += pinctrl-ssbi-gpio.o
>>>    obj-$(CONFIG_PINCTRL_QCOM_SSBI_PMIC) += pinctrl-ssbi-mpp.o
>>> +obj-$(CONFIG_PINCTRL_SDM660)   += pinctrl-sdm660.o
>>>    obj-$(CONFIG_PINCTRL_SDM845) += pinctrl-sdm845.o
>>> diff --git a/drivers/pinctrl/qcom/pinctrl-sdm660.c
>> b/drivers/pinctrl/qcom/pinctrl-sdm660.c
>>> new file mode 100644
>>> index 000000000000..ded56111f168
>>> --- /dev/null
>>> +++ b/drivers/pinctrl/qcom/pinctrl-sdm660.c
>>> @@ -0,0 +1,1451 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2016, The Linux Foundation. All rights reserved.
>>> + * Copyright (c) 2018, Craig Tatlor.
>>> + */
>>> +
>>> +#include <linux/module.h>
>>> +#include <linux/of.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/pinctrl/pinctrl.h>
>>> +
>>> +#include "pinctrl-msm.h"
>>> +
>>> +#define NORTH	0x00900000
>>> +#define CENTER	0x00500000
>>> +#define SOUTH	0x00100000
>>> +#define REG_SIZE 0x1000
>>> +
>>> +#define FUNCTION(fname)					\
>>> +	[msm_mux_##fname] = {		                \
>>> +		.name = #fname,				\
>>> +		.groups = fname##_groups,               \
>>> +		.ngroups = ARRAY_SIZE(fname##_groups),	\
>>> +	}
>>> +
>>> +
>>> +#define PINGROUP(id, base, f1, f2, f3, f4, f5, f6, f7, f8, f9)	\
>>> +	{					        \
>>> +		.name = "gpio" #id,			\
>>> +		.pins = gpio##id##_pins,		\
>>> +		.npins = (unsigned)ARRAY_SIZE(gpio##id##_pins),	\
>>> +		.funcs = (int[]){			\
>>> +			msm_mux_gpio, /* gpio mode */	\
>>> +			msm_mux_##f1,			\
>>> +			msm_mux_##f2,			\
>>> +			msm_mux_##f3,			\
>>> +			msm_mux_##f4,			\
>>> +			msm_mux_##f5,			\
>>> +			msm_mux_##f6,			\
>>> +			msm_mux_##f7,			\
>>> +			msm_mux_##f8,			\
>>> +			msm_mux_##f9			\
>>> +		},				        \
>>> +		.nfuncs = 10,				\
>>> +		.ctl_reg = base + REG_SIZE * id,	\
>>> +		.io_reg = base + 0x4 + REG_SIZE * id,		\
>>> +		.intr_cfg_reg = base + 0x8 + REG_SIZE * id,		\
>>> +		.intr_status_reg = base + 0xc + REG_SIZE * id,	\
>>> +		.intr_target_reg = base + 0x8 + REG_SIZE * id,	\
>>> +		.mux_bit = 2,			\
>>> +		.pull_bit = 0,			\
>>> +		.drv_bit = 6,			\
>>> +		.oe_bit = 9,			\
>>> +		.in_bit = 0,			\
>>> +		.out_bit = 1,			\
>>> +		.intr_enable_bit = 0,		\
>>> +		.intr_status_bit = 0,		\
>>> +		.intr_target_bit = 5,		\
>>> +		.intr_target_kpss_val = 3,	\
>>> +		.intr_raw_status_bit = 4,	\
>>> +		.intr_polarity_bit = 1,		\
>>> +		.intr_detection_bit = 2,	\
>>> +		.intr_detection_width = 2,	\
>>> +	}
>>> +
>>> +#define SDC_QDSD_PINGROUP(pg_name, ctl, pull, drv)	\
>>> +	{					        \
>>> +		.name = #pg_name,			\
>>> +		.pins = pg_name##_pins,			\
>>> +		.npins = (unsigned)ARRAY_SIZE(pg_name##_pins),	\
>>> +		.ctl_reg = ctl,				\
>>> +		.io_reg = 0,				\
>>> +		.intr_cfg_reg = 0,			\
>>> +		.intr_status_reg = 0,			\
>>> +		.intr_target_reg = 0,			\
>>> +		.mux_bit = -1,				\
>>> +		.pull_bit = pull,			\
>>> +		.drv_bit = drv,				\
>>> +		.oe_bit = -1,				\
>>> +		.in_bit = -1,				\
>>> +		.out_bit = -1,				\
>>> +		.intr_enable_bit = -1,			\
>>> +		.intr_status_bit = -1,			\
>>> +		.intr_target_bit = -1,			\
>>> +		.intr_raw_status_bit = -1,		\
>>> +		.intr_polarity_bit = -1,		\
>>> +		.intr_detection_bit = -1,		\
>>> +		.intr_detection_width = -1,		\
>>> +	}
>>> +
>>> +static const struct pinctrl_pin_desc sdm660_pins[] = {
>>> +	PINCTRL_PIN(0, "GPIO_0"),
>>> +	PINCTRL_PIN(1, "GPIO_1"),
>>> +	PINCTRL_PIN(2, "GPIO_2"),
>>> +	PINCTRL_PIN(3, "GPIO_3"),
>>> +	PINCTRL_PIN(4, "GPIO_4"),
>>> +	PINCTRL_PIN(5, "GPIO_5"),
>>> +	PINCTRL_PIN(6, "GPIO_6"),
>>> +	PINCTRL_PIN(7, "GPIO_7"),
>>> +	PINCTRL_PIN(8, "GPIO_8"),
>>> +	PINCTRL_PIN(9, "GPIO_9"),
>>> +	PINCTRL_PIN(10, "GPIO_10"),
>>> +	PINCTRL_PIN(11, "GPIO_11"),
>>> +	PINCTRL_PIN(12, "GPIO_12"),
>>> +	PINCTRL_PIN(13, "GPIO_13"),
>>> +	PINCTRL_PIN(14, "GPIO_14"),
>>> +	PINCTRL_PIN(15, "GPIO_15"),
>>> +	PINCTRL_PIN(16, "GPIO_16"),
>>> +	PINCTRL_PIN(17, "GPIO_17"),
>>> +	PINCTRL_PIN(18, "GPIO_18"),
>>> +	PINCTRL_PIN(19, "GPIO_19"),
>>> +	PINCTRL_PIN(20, "GPIO_20"),
>>> +	PINCTRL_PIN(21, "GPIO_21"),
>>> +	PINCTRL_PIN(22, "GPIO_22"),
>>> +	PINCTRL_PIN(23, "GPIO_23"),
>>> +	PINCTRL_PIN(24, "GPIO_24"),
>>> +	PINCTRL_PIN(25, "GPIO_25"),
>>> +	PINCTRL_PIN(26, "GPIO_26"),
>>> +	PINCTRL_PIN(27, "GPIO_27"),
>>> +	PINCTRL_PIN(28, "GPIO_28"),
>>> +	PINCTRL_PIN(29, "GPIO_29"),
>>> +	PINCTRL_PIN(30, "GPIO_30"),
>>> +	PINCTRL_PIN(31, "GPIO_31"),
>>> +	PINCTRL_PIN(32, "GPIO_32"),
>>> +	PINCTRL_PIN(33, "GPIO_33"),
>>> +	PINCTRL_PIN(34, "GPIO_34"),
>>> +	PINCTRL_PIN(35, "GPIO_35"),
>>> +	PINCTRL_PIN(36, "GPIO_36"),
>>> +	PINCTRL_PIN(37, "GPIO_37"),
>>> +	PINCTRL_PIN(38, "GPIO_38"),
>>> +	PINCTRL_PIN(39, "GPIO_39"),
>>> +	PINCTRL_PIN(40, "GPIO_40"),
>>> +	PINCTRL_PIN(41, "GPIO_41"),
>>> +	PINCTRL_PIN(42, "GPIO_42"),
>>> +	PINCTRL_PIN(43, "GPIO_43"),
>>> +	PINCTRL_PIN(44, "GPIO_44"),
>>> +	PINCTRL_PIN(45, "GPIO_45"),
>>> +	PINCTRL_PIN(46, "GPIO_46"),
>>> +	PINCTRL_PIN(47, "GPIO_47"),
>>> +	PINCTRL_PIN(48, "GPIO_48"),
>>> +	PINCTRL_PIN(49, "GPIO_49"),
>>> +	PINCTRL_PIN(50, "GPIO_50"),
>>> +	PINCTRL_PIN(51, "GPIO_51"),
>>> +	PINCTRL_PIN(52, "GPIO_52"),
>>> +	PINCTRL_PIN(53, "GPIO_53"),
>>> +	PINCTRL_PIN(54, "GPIO_54"),
>>> +	PINCTRL_PIN(55, "GPIO_55"),
>>> +	PINCTRL_PIN(56, "GPIO_56"),
>>> +	PINCTRL_PIN(57, "GPIO_57"),
>>> +	PINCTRL_PIN(58, "GPIO_58"),
>>> +	PINCTRL_PIN(59, "GPIO_59"),
>>> +	PINCTRL_PIN(60, "GPIO_60"),
>>> +	PINCTRL_PIN(61, "GPIO_61"),
>>> +	PINCTRL_PIN(62, "GPIO_62"),
>>> +	PINCTRL_PIN(63, "GPIO_63"),
>>> +	PINCTRL_PIN(64, "GPIO_64"),
>>> +	PINCTRL_PIN(65, "GPIO_65"),
>>> +	PINCTRL_PIN(66, "GPIO_66"),
>>> +	PINCTRL_PIN(67, "GPIO_67"),
>>> +	PINCTRL_PIN(68, "GPIO_68"),
>>> +	PINCTRL_PIN(69, "GPIO_69"),
>>> +	PINCTRL_PIN(70, "GPIO_70"),
>>> +	PINCTRL_PIN(71, "GPIO_71"),
>>> +	PINCTRL_PIN(72, "GPIO_72"),
>>> +	PINCTRL_PIN(73, "GPIO_73"),
>>> +	PINCTRL_PIN(74, "GPIO_74"),
>>> +	PINCTRL_PIN(75, "GPIO_75"),
>>> +	PINCTRL_PIN(76, "GPIO_76"),
>>> +	PINCTRL_PIN(77, "GPIO_77"),
>>> +	PINCTRL_PIN(78, "GPIO_78"),
>>> +	PINCTRL_PIN(79, "GPIO_79"),
>>> +	PINCTRL_PIN(80, "GPIO_80"),
>>> +	PINCTRL_PIN(81, "GPIO_81"),
>>> +	PINCTRL_PIN(82, "GPIO_82"),
>>> +	PINCTRL_PIN(83, "GPIO_83"),
>>> +	PINCTRL_PIN(84, "GPIO_84"),
>>> +	PINCTRL_PIN(85, "GPIO_85"),
>>> +	PINCTRL_PIN(86, "GPIO_86"),
>>> +	PINCTRL_PIN(87, "GPIO_87"),
>>> +	PINCTRL_PIN(88, "GPIO_88"),
>>> +	PINCTRL_PIN(89, "GPIO_89"),
>>> +	PINCTRL_PIN(90, "GPIO_90"),
>>> +	PINCTRL_PIN(91, "GPIO_91"),
>>> +	PINCTRL_PIN(92, "GPIO_92"),
>>> +	PINCTRL_PIN(93, "GPIO_93"),
>>> +	PINCTRL_PIN(94, "GPIO_94"),
>>> +	PINCTRL_PIN(95, "GPIO_95"),
>>> +	PINCTRL_PIN(96, "GPIO_96"),
>>> +	PINCTRL_PIN(97, "GPIO_97"),
>>> +	PINCTRL_PIN(98, "GPIO_98"),
>>> +	PINCTRL_PIN(99, "GPIO_99"),
>>> +	PINCTRL_PIN(100, "GPIO_100"),
>>> +	PINCTRL_PIN(101, "GPIO_101"),
>>> +	PINCTRL_PIN(102, "GPIO_102"),
>>> +	PINCTRL_PIN(103, "GPIO_103"),
>>> +	PINCTRL_PIN(104, "GPIO_104"),
>>> +	PINCTRL_PIN(105, "GPIO_105"),
>>> +	PINCTRL_PIN(106, "GPIO_106"),
>>> +	PINCTRL_PIN(107, "GPIO_107"),
>>> +	PINCTRL_PIN(108, "GPIO_108"),
>>> +	PINCTRL_PIN(109, "GPIO_109"),
>>> +	PINCTRL_PIN(110, "GPIO_110"),
>>> +	PINCTRL_PIN(111, "GPIO_111"),
>>> +	PINCTRL_PIN(112, "GPIO_112"),
>>> +	PINCTRL_PIN(113, "GPIO_113"),
>>> +	PINCTRL_PIN(114, "SDC1_CLK"),
>>> +	PINCTRL_PIN(115, "SDC1_CMD"),
>>> +	PINCTRL_PIN(116, "SDC1_DATA"),
>>> +	PINCTRL_PIN(117, "SDC2_CLK"),
>>> +	PINCTRL_PIN(118, "SDC2_CMD"),
>>> +	PINCTRL_PIN(119, "SDC2_DATA"),
>>> +	PINCTRL_PIN(120, "SDC1_RCLK"),
>>> +};
>>> +
>>> +#define DECLARE_MSM_GPIO_PINS(pin) \
>>> +	static const unsigned int gpio##pin##_pins[] = { pin }
>>> +DECLARE_MSM_GPIO_PINS(0);
>>> +DECLARE_MSM_GPIO_PINS(1);
>>> +DECLARE_MSM_GPIO_PINS(2);
>>> +DECLARE_MSM_GPIO_PINS(3);
>>> +DECLARE_MSM_GPIO_PINS(4);
>>> +DECLARE_MSM_GPIO_PINS(5);
>>> +DECLARE_MSM_GPIO_PINS(6);
>>> +DECLARE_MSM_GPIO_PINS(7);
>>> +DECLARE_MSM_GPIO_PINS(8);
>>> +DECLARE_MSM_GPIO_PINS(9);
>>> +DECLARE_MSM_GPIO_PINS(10);
>>> +DECLARE_MSM_GPIO_PINS(11);
>>> +DECLARE_MSM_GPIO_PINS(12);
>>> +DECLARE_MSM_GPIO_PINS(13);
>>> +DECLARE_MSM_GPIO_PINS(14);
>>> +DECLARE_MSM_GPIO_PINS(15);
>>> +DECLARE_MSM_GPIO_PINS(16);
>>> +DECLARE_MSM_GPIO_PINS(17);
>>> +DECLARE_MSM_GPIO_PINS(18);
>>> +DECLARE_MSM_GPIO_PINS(19);
>>> +DECLARE_MSM_GPIO_PINS(20);
>>> +DECLARE_MSM_GPIO_PINS(21);
>>> +DECLARE_MSM_GPIO_PINS(22);
>>> +DECLARE_MSM_GPIO_PINS(23);
>>> +DECLARE_MSM_GPIO_PINS(24);
>>> +DECLARE_MSM_GPIO_PINS(25);
>>> +DECLARE_MSM_GPIO_PINS(26);
>>> +DECLARE_MSM_GPIO_PINS(27);
>>> +DECLARE_MSM_GPIO_PINS(28);
>>> +DECLARE_MSM_GPIO_PINS(29);
>>> +DECLARE_MSM_GPIO_PINS(30);
>>> +DECLARE_MSM_GPIO_PINS(31);
>>> +DECLARE_MSM_GPIO_PINS(32);
>>> +DECLARE_MSM_GPIO_PINS(33);
>>> +DECLARE_MSM_GPIO_PINS(34);
>>> +DECLARE_MSM_GPIO_PINS(35);
>>> +DECLARE_MSM_GPIO_PINS(36);
>>> +DECLARE_MSM_GPIO_PINS(37);
>>> +DECLARE_MSM_GPIO_PINS(38);
>>> +DECLARE_MSM_GPIO_PINS(39);
>>> +DECLARE_MSM_GPIO_PINS(40);
>>> +DECLARE_MSM_GPIO_PINS(41);
>>> +DECLARE_MSM_GPIO_PINS(42);
>>> +DECLARE_MSM_GPIO_PINS(43);
>>> +DECLARE_MSM_GPIO_PINS(44);
>>> +DECLARE_MSM_GPIO_PINS(45);
>>> +DECLARE_MSM_GPIO_PINS(46);
>>> +DECLARE_MSM_GPIO_PINS(47);
>>> +DECLARE_MSM_GPIO_PINS(48);
>>> +DECLARE_MSM_GPIO_PINS(49);
>>> +DECLARE_MSM_GPIO_PINS(50);
>>> +DECLARE_MSM_GPIO_PINS(51);
>>> +DECLARE_MSM_GPIO_PINS(52);
>>> +DECLARE_MSM_GPIO_PINS(53);
>>> +DECLARE_MSM_GPIO_PINS(54);
>>> +DECLARE_MSM_GPIO_PINS(55);
>>> +DECLARE_MSM_GPIO_PINS(56);
>>> +DECLARE_MSM_GPIO_PINS(57);
>>> +DECLARE_MSM_GPIO_PINS(58);
>>> +DECLARE_MSM_GPIO_PINS(59);
>>> +DECLARE_MSM_GPIO_PINS(60);
>>> +DECLARE_MSM_GPIO_PINS(61);
>>> +DECLARE_MSM_GPIO_PINS(62);
>>> +DECLARE_MSM_GPIO_PINS(63);
>>> +DECLARE_MSM_GPIO_PINS(64);
>>> +DECLARE_MSM_GPIO_PINS(65);
>>> +DECLARE_MSM_GPIO_PINS(66);
>>> +DECLARE_MSM_GPIO_PINS(67);
>>> +DECLARE_MSM_GPIO_PINS(68);
>>> +DECLARE_MSM_GPIO_PINS(69);
>>> +DECLARE_MSM_GPIO_PINS(70);
>>> +DECLARE_MSM_GPIO_PINS(71);
>>> +DECLARE_MSM_GPIO_PINS(72);
>>> +DECLARE_MSM_GPIO_PINS(73);
>>> +DECLARE_MSM_GPIO_PINS(74);
>>> +DECLARE_MSM_GPIO_PINS(75);
>>> +DECLARE_MSM_GPIO_PINS(76);
>>> +DECLARE_MSM_GPIO_PINS(77);
>>> +DECLARE_MSM_GPIO_PINS(78);
>>> +DECLARE_MSM_GPIO_PINS(79);
>>> +DECLARE_MSM_GPIO_PINS(80);
>>> +DECLARE_MSM_GPIO_PINS(81);
>>> +DECLARE_MSM_GPIO_PINS(82);
>>> +DECLARE_MSM_GPIO_PINS(83);
>>> +DECLARE_MSM_GPIO_PINS(84);
>>> +DECLARE_MSM_GPIO_PINS(85);
>>> +DECLARE_MSM_GPIO_PINS(86);
>>> +DECLARE_MSM_GPIO_PINS(87);
>>> +DECLARE_MSM_GPIO_PINS(88);
>>> +DECLARE_MSM_GPIO_PINS(89);
>>> +DECLARE_MSM_GPIO_PINS(90);
>>> +DECLARE_MSM_GPIO_PINS(91);
>>> +DECLARE_MSM_GPIO_PINS(92);
>>> +DECLARE_MSM_GPIO_PINS(93);
>>> +DECLARE_MSM_GPIO_PINS(94);
>>> +DECLARE_MSM_GPIO_PINS(95);
>>> +DECLARE_MSM_GPIO_PINS(96);
>>> +DECLARE_MSM_GPIO_PINS(97);
>>> +DECLARE_MSM_GPIO_PINS(98);
>>> +DECLARE_MSM_GPIO_PINS(99);
>>> +DECLARE_MSM_GPIO_PINS(100);
>>> +DECLARE_MSM_GPIO_PINS(101);
>>> +DECLARE_MSM_GPIO_PINS(102);
>>> +DECLARE_MSM_GPIO_PINS(103);
>>> +DECLARE_MSM_GPIO_PINS(104);
>>> +DECLARE_MSM_GPIO_PINS(105);
>>> +DECLARE_MSM_GPIO_PINS(106);
>>> +DECLARE_MSM_GPIO_PINS(107);
>>> +DECLARE_MSM_GPIO_PINS(108);
>>> +DECLARE_MSM_GPIO_PINS(109);
>>> +DECLARE_MSM_GPIO_PINS(110);
>>> +DECLARE_MSM_GPIO_PINS(111);
>>> +DECLARE_MSM_GPIO_PINS(112);
>>> +DECLARE_MSM_GPIO_PINS(113);
>>> +
>>> +static const unsigned int sdc1_clk_pins[] = { 114 };
>>> +static const unsigned int sdc1_cmd_pins[] = { 115 };
>>> +static const unsigned int sdc1_data_pins[] = { 116 };
>>> +static const unsigned int sdc2_clk_pins[] = { 117 };
>>> +static const unsigned int sdc2_cmd_pins[] = { 118 };
>>> +static const unsigned int sdc2_data_pins[] = { 119 };
>>> +static const unsigned int sdc1_rclk_pins[] = { 120 };
>>> +
>>> +enum sdm660_functions {
>>> +	msm_mux_blsp_spi1,
>>> +	msm_mux_gpio,
>>> +	msm_mux_blsp_uim1,
>>> +	msm_mux_tgu_ch0,
>>> +	msm_mux_qdss_gpio4,
>>> +	msm_mux_atest_gpsadc1,
>>> +	msm_mux_blsp_uart1,
>>> +	msm_mux_phase_flag14,
>>> +	msm_mux_blsp_i2c2,
>>> +	msm_mux_phase_flag31,
>>> +	msm_mux_blsp_spi3,
>>> +	msm_mux_blsp_spi3_cs1,
>>> +	msm_mux_blsp_spi3_cs2,
>>> +	msm_mux_wlan1_adc1,
>>> +	msm_mux_atest_usb13,
>>> +	msm_mux_tgu_ch1,
>>> +	msm_mux_qdss_gpio5,
>>> +	msm_mux_atest_gpsadc0,
>>> +	msm_mux_blsp_i2c1,
>>> +	msm_mux_ddr_bist,
>>> +	msm_mux_atest_tsens2,
>>> +	msm_mux_atest_usb1,
>>> +	msm_mux_blsp_spi2,
>>> +	msm_mux_blsp_uim2,
>>> +	msm_mux_phase_flag3,
>>> +	msm_mux_bimc_dte1,
>>> +	msm_mux_wlan1_adc0,
>>> +	msm_mux_atest_usb12,
>>> +	msm_mux_bimc_dte0,
>>> +	msm_mux_blsp_i2c3,
>>> +	msm_mux_wlan2_adc1,
>>> +	msm_mux_atest_usb11,
>>> +	msm_mux_dbg_out,
>>> +	msm_mux_wlan2_adc0,
>>> +	msm_mux_atest_usb10,
>>> +	msm_mux_blsp_spi4,
>>> +	msm_mux_pri_mi2s,
>>> +	msm_mux_phase_flag26,
>>> +	msm_mux_qdss_cti0_a,
>>> +	msm_mux_qdss_cti0_b,
>>> +	msm_mux_qdss_cti1_a,
>>> +	msm_mux_qdss_cti1_b,
>>> +	msm_mux_pri_mi2s_ws,
>>> +	msm_mux_phase_flag27,
>>> +	msm_mux_blsp_i2c4,
>>> +	msm_mux_phase_flag28,
>>> +	msm_mux_blsp_uart5,
>>> +	msm_mux_blsp_spi5,
>>> +	msm_mux_blsp_uim5,
>>> +	msm_mux_phase_flag5,
>>> +	msm_mux_blsp_i2c5,
>>> +	msm_mux_blsp_spi6,
>>> +	msm_mux_blsp_uart2,
>>> +	msm_mux_blsp_uim6,
>>> +	msm_mux_phase_flag11,
>>> +	msm_mux_vsense_data0,
>>> +	msm_mux_blsp_i2c6,
>>> +	msm_mux_phase_flag12,
>>> +	msm_mux_vsense_data1,
>>> +	msm_mux_phase_flag13,
>>> +	msm_mux_vsense_mode,
>>> +	msm_mux_blsp_spi7,
>>> +	msm_mux_blsp_uart6_a,
>>> +	msm_mux_blsp_uart6_b,
>>> +	msm_mux_sec_mi2s,
>>> +	msm_mux_sndwire_clk,
>>> +	msm_mux_phase_flag17,
>>> +	msm_mux_vsense_clkout,
>>> +	msm_mux_sndwire_data,
>>> +	msm_mux_phase_flag18,
>>> +	msm_mux_blsp_i2c7,
>>> +	msm_mux_phase_flag19,
>>> +	msm_mux_vfr_1,
>>> +	msm_mux_phase_flag20,
>>> +	msm_mux_blsp_spi8_cs1,
>>> +	msm_mux_blsp_spi8_cs2,
>>> +	msm_mux_m_voc,
>>> +	msm_mux_phase_flag21,
>>> +	msm_mux_phase_flag22,
>>> +	msm_mux_blsp_i2c8_a,
>>> +	msm_mux_blsp_i2c8_b,
>>> +	msm_mux_phase_flag23,
>>> +	msm_mux_pwr_modem,
>>> +	msm_mux_phase_flag24,
>>> +	msm_mux_qdss_gpio,
>>> +	msm_mux_cam_mclk,
>>> +	msm_mux_pwr_nav,
>>> +	msm_mux_qdss_gpio0,
>>> +	msm_mux_qspi_data0,
>>> +	msm_mux_pwr_crypto,
>>> +	msm_mux_qdss_gpio1,
>>> +	msm_mux_qspi_data1,
>>> +	msm_mux_agera_pll,
>>> +	msm_mux_qdss_gpio2,
>>> +	msm_mux_qspi_data2,
>>> +	msm_mux_jitter_bist,
>>> +	msm_mux_qdss_gpio3,
>>> +	msm_mux_qdss_gpio7,
>>> +	msm_mux_mdss_vsync0,
>>> +	msm_mux_mdss_vsync1,
>>> +	msm_mux_mdss_vsync2,
>>> +	msm_mux_mdss_vsync3,
>>> +	msm_mux_qdss_gpio9,
>>> +	msm_mux_atest_usb2,
>>> +	msm_mux_cci_i2c,
>>> +	msm_mux_pll_bypassnl,
>>> +	msm_mux_atest_tsens,
>>> +	msm_mux_atest_usb21,
>>> +	msm_mux_pll_reset,
>>> +	msm_mux_atest_usb23,
>>> +	msm_mux_qdss_gpio6,
>>> +	msm_mux_qspi_cs,
>>> +	msm_mux_qdss_gpio10,
>>> +	msm_mux_qdss_gpio11,
>>> +	msm_mux_cci_async,
>>> +	msm_mux_qdss_gpio12,
>>> +	msm_mux_qdss_gpio13,
>>> +	msm_mux_qspi_clk,
>>> +	msm_mux_phase_flag30,
>>> +	msm_mux_qdss_gpio14,
>>> +	msm_mux_qspi_resetn,
>>> +	msm_mux_phase_flag1,
>>> +	msm_mux_qdss_gpio15,
>>> +	msm_mux_phase_flag2,
>>> +	msm_mux_phase_flag9,
>>> +	msm_mux_qspi_data3,
>>> +	msm_mux_phase_flag15,
>>> +	msm_mux_qdss_gpio8,
>>> +	msm_mux_phase_flag16,
>>> +	msm_mux_phase_flag6,
>>> +	msm_mux_phase_flag29,
>>> +	msm_mux_phase_flag25,
>>> +	msm_mux_phase_flag10,
>>> +	msm_mux_atest_usb20,
>>> +	msm_mux_gcc_gp1,
>>> +	msm_mux_phase_flag4,
>>> +	msm_mux_atest_usb22,
>>> +	msm_mux_gcc_gp2,
>>> +	msm_mux_atest_char,
>>> +	msm_mux_mdp_vsync,
>>> +	msm_mux_gcc_gp3,
>>> +	msm_mux_atest_char3,
>>> +	msm_mux_cri_trng0,
>>> +	msm_mux_atest_char2,
>>> +	msm_mux_cri_trng1,
>>> +	msm_mux_atest_char1,
>>> +	msm_mux_audio_ref,
>>> +	msm_mux_cri_trng,
>>> +	msm_mux_atest_char0,
>>> +	msm_mux_blsp_spi8_a,
>>> +	msm_mux_blsp_spi8_b,
>>> +	msm_mux_sp_cmu,
>>> +	msm_mux_nav_pps_a,
>>> +	msm_mux_nav_pps_b,
>>> +	msm_mux_nav_pps_c,
>>> +	msm_mux_gps_tx_a,
>>> +	msm_mux_gps_tx_b,
>>> +	msm_mux_gps_tx_c,
>>> +	msm_mux_adsp_ext,
>>> +	msm_mux_ssc_irq,
>>> +	msm_mux_isense_dbg,
>>> +	msm_mux_phase_flag0,
>>> +	msm_mux_phase_flag7,
>>> +	msm_mux_phase_flag8,
>>> +	msm_mux_tsense_pwm1,
>>> +	msm_mux_tsense_pwm2,
>>> +	msm_mux_mss_lte,
>>> +	msm_mux_uim2_data,
>>> +	msm_mux_uim2_clk,
>>> +	msm_mux_uim2_reset,
>>> +	msm_mux_uim2_present,
>>> +	msm_mux_uim1_data,
>>> +	msm_mux_uim1_clk,
>>> +	msm_mux_uim1_reset,
>>> +	msm_mux_uim1_present,
>>> +	msm_mux_uim_batt,
>>> +	msm_mux_pa_indicator,
>>> +	msm_mux_ldo_en,
>>> +	msm_mux_ldo_update,
>>> +	msm_mux_qlink_request,
>>> +	msm_mux_qlink_enable,
>>> +	msm_mux_prng_rosc,
>>> +	msm_mux__,
>>> +};
>>> +
>>> +static const char * const gpio_groups[] = {
>>> +	"gpio0", "gpio1", "gpio2", "gpio3", "gpio4", "gpio5", "gpio6",
>> "gpio7",
>>> +	"gpio8", "gpio9", "gpio10", "gpio11", "gpio12", "gpio13", "gpio14",
>>> +	"gpio15", "gpio16", "gpio17", "gpio18", "gpio19", "gpio20",
>> "gpio21",
>>> +	"gpio22", "gpio23", "gpio24", "gpio25", "gpio26", "gpio27",
>> "gpio28",
>>> +	"gpio29", "gpio30", "gpio31", "gpio32", "gpio33", "gpio34",
>> "gpio35",
>>> +	"gpio36", "gpio37", "gpio38", "gpio39", "gpio40", "gpio41",
>> "gpio42",
>>> +	"gpio43", "gpio44", "gpio45", "gpio46", "gpio47", "gpio48",
>> "gpio49",
>>> +	"gpio50", "gpio51", "gpio52", "gpio53", "gpio54", "gpio55",
>> "gpio56",
>>> +	"gpio57", "gpio58", "gpio59", "gpio60", "gpio61", "gpio62",
>> "gpio63",
>>> +	"gpio64", "gpio65", "gpio66", "gpio67", "gpio68", "gpio69",
>> "gpio70",
>>> +	"gpio71", "gpio72", "gpio73", "gpio74", "gpio75", "gpio76",
>> "gpio77",
>>> +	"gpio78", "gpio79", "gpio80", "gpio81", "gpio82", "gpio83",
>> "gpio84",
>>> +	"gpio85", "gpio86", "gpio87", "gpio88", "gpio89", "gpio90",
>> "gpio91",
>>> +	"gpio92", "gpio93", "gpio94", "gpio95", "gpio96", "gpio97",
>> "gpio98",
>>> +	"gpio99", "gpio100", "gpio101", "gpio102", "gpio103", "gpio104",
>>> +	"gpio105", "gpio106", "gpio107", "gpio108", "gpio109", "gpio110",
>>> +	"gpio111", "gpio112", "gpio113",
>>> +};
>>> +static const char * const blsp_spi1_groups[] = {
>>> +	"gpio0", "gpio1", "gpio2", "gpio3", "gpio46",
>>> +};
>>> +static const char * const blsp_uim1_groups[] = {
>>> +	"gpio0", "gpio1",
>>> +};
>>> +static const char * const tgu_ch0_groups[] = {
>>> +	"gpio0",
>>> +};
>>> +static const char * const qdss_gpio4_groups[] = {
>>> +	"gpio0", "gpio36",
>>> +};
>>> +static const char * const atest_gpsadc1_groups[] = {
>>> +	"gpio0",
>>> +};
>>> +static const char * const blsp_uart1_groups[] = {
>>> +	"gpio0", "gpio1", "gpio2", "gpio3",
>>> +};
>>> +static const char * const phase_flag14_groups[] = {
>>> +	"gpio5",
>>> +};
>>> +static const char * const blsp_i2c2_groups[] = {
>>> +	"gpio6", "gpio7",
>>> +};
>>> +static const char * const phase_flag31_groups[] = {
>>> +	"gpio6",
>>> +};
>>> +static const char * const blsp_spi3_groups[] = {
>>> +	"gpio8", "gpio9", "gpio10", "gpio11",
>>> +};
>>> +static const char * const blsp_spi3_cs1_groups[] = {
>>> +	"gpio30",
>>> +};
>>> +static const char * const blsp_spi3_cs2_groups[] = {
>>> +	"gpio65",
>>> +};
>>> +static const char * const wlan1_adc1_groups[] = {
>>> +	"gpio8",
>>> +};
>>> +static const char * const atest_usb13_groups[] = {
>>> +	"gpio8",
>>> +};
>>> +static const char * const tgu_ch1_groups[] = {
>>> +	"gpio1",
>>> +};
>>> +static const char * const qdss_gpio5_groups[] = {
>>> +	"gpio1", "gpio37",
>>> +};
>>> +static const char * const atest_gpsadc0_groups[] = {
>>> +	"gpio1",
>>> +};
>>> +static const char * const blsp_i2c1_groups[] = {
>>> +	"gpio2", "gpio3",
>>> +};
>>> +static const char * const ddr_bist_groups[] = {
>>> +	"gpio3", "gpio8", "gpio9", "gpio10",
>>> +};
>>> +static const char * const atest_tsens2_groups[] = {
>>> +	"gpio3",
>>> +};
>>> +static const char * const atest_usb1_groups[] = {
>>> +	"gpio3",
>>> +};
>>> +static const char * const blsp_spi2_groups[] = {
>>> +	"gpio4", "gpio5", "gpio6", "gpio7",
>>> +};
>>> +static const char * const blsp_uim2_groups[] = {
>>> +	"gpio4", "gpio5",
>>> +};
>>> +static const char * const phase_flag3_groups[] = {
>>> +	"gpio4",
>>> +};
>>> +static const char * const bimc_dte1_groups[] = {
>>> +	"gpio8", "gpio10",
>>> +};
>>> +static const char * const wlan1_adc0_groups[] = {
>>> +	"gpio9",
>>> +};
>>> +static const char * const atest_usb12_groups[] = {
>>> +	"gpio9",
>>> +};
>>> +static const char * const bimc_dte0_groups[] = {
>>> +	"gpio9", "gpio11",
>>> +};
>>> +static const char * const blsp_i2c3_groups[] = {
>>> +	"gpio10", "gpio11",
>>> +};
>>> +static const char * const wlan2_adc1_groups[] = {
>>> +	"gpio10",
>>> +};
>>> +static const char * const atest_usb11_groups[] = {
>>> +	"gpio10",
>>> +};
>>> +static const char * const dbg_out_groups[] = {
>>> +	"gpio11",
>>> +};
>>> +static const char * const wlan2_adc0_groups[] = {
>>> +	"gpio11",
>>> +};
>>> +static const char * const atest_usb10_groups[] = {
>>> +	"gpio11",
>>> +};
>>> +static const char * const RCM_MARKER_groups[] = {
>>> +	"gpio12", "gpio13",
>>> +};
>>> +static const char * const blsp_spi4_groups[] = {
>>> +	"gpio12", "gpio13", "gpio14", "gpio15",
>>> +};
>>> +static const char * const pri_mi2s_groups[] = {
>>> +	"gpio12", "gpio14", "gpio15", "gpio61",
>>> +};
>>> +static const char * const phase_flag26_groups[] = {
>>> +	"gpio12",
>>> +};
>>> +static const char * const qdss_cti0_a_groups[] = {
>>> +	"gpio49", "gpio50",
>>> +};
>>> +static const char * const qdss_cti0_b_groups[] = {
>>> +	"gpio13", "gpio21",
>>> +};
>>> +static const char * const qdss_cti1_a_groups[] = {
>>> +	"gpio53", "gpio55",
>>> +};
>>> +static const char * const qdss_cti1_b_groups[] = {
>>> +	"gpio12", "gpio66",
>>> +};
>>> +static const char * const pri_mi2s_ws_groups[] = {
>>> +	"gpio13",
>>> +};
>>> +static const char * const phase_flag27_groups[] = {
>>> +	"gpio13",
>>> +};
>>> +static const char * const blsp_i2c4_groups[] = {
>>> +	"gpio14", "gpio15",
>>> +};
>>> +static const char * const phase_flag28_groups[] = {
>>> +	"gpio14",
>>> +};
>>> +static const char * const blsp_uart5_groups[] = {
>>> +	"gpio16", "gpio17", "gpio18", "gpio19",
>>> +};
>>> +static const char * const blsp_spi5_groups[] = {
>>> +	"gpio16", "gpio17", "gpio18", "gpio19",
>>> +};
>>> +static const char * const blsp_uim5_groups[] = {
>>> +	"gpio16", "gpio17",
>>> +};
>>> +static const char * const phase_flag5_groups[] = {
>>> +	"gpio17",
>>> +};
>>> +static const char * const blsp_i2c5_groups[] = {
>>> +	"gpio18", "gpio19",
>>> +};
>>> +static const char * const blsp_spi6_groups[] = {
>>> +	"gpio49", "gpio52", "gpio22", "gpio23",
>>> +};
>>> +static const char * const blsp_uart2_groups[] = {
>>> +	"gpio4", "gpio5", "gpio6", "gpio7",
>>> +};
>>> +static const char * const blsp_uim6_groups[]
> 

