Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752481AbeEOJoR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 05:44:17 -0400
Received: from mail-by2nam03on0047.outbound.protection.outlook.com ([104.47.42.47]:11586
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752129AbeEOJoO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 05:44:14 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v3] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Adam.Thomson.Opensource@diasemi.com, Alexander.Deucher@amd.com,
        Support.Opensource@diasemi.com, perex@perex.cz, tiwai@suse.com,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1525334313-28661-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1EA102@SW-EX-MBX01.diasemi.com>
 <e17e2c9e-923d-fea6-26be-5f14c99a45cb@amd.com>
 <CAGS+omATdiURdKFTZAeCW=7R0kB7z8vW-Wj05j_-RoJhAq=FHg@mail.gmail.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <516fabd6-264d-a7bd-bf11-40d02154b1ef@amd.com>
Date: Tue, 15 May 2018 15:13:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omATdiURdKFTZAeCW=7R0kB7z8vW-Wj05j_-RoJhAq=FHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: MA1PR0101CA0046.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::32) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:2UsrmtNTq8ZXlnXTc0n7rYtTW8po7g5QUykWhQ9Ad689+QYfQhX2BU7qgK5dmbrjeAO7enUzws7Um3zZQ6ytNfZJncg4BVBH0Nd10hYmMI25iq/YRaRzZTaLv1ZHnaYr2p5yu/1fpwRpwoGYPBudbsqeYxrzRErTE0s2wXB7I/iMZg6rdqBlZaPxR+CJH7KjZsm+XI+ZIHQEzWwa8dUZDHGqZnODUK0FuxDhPUgIlN+H0NLZx0Zmzpst6Lgt1jBF;25:CJohdsM0M4FsmGRu+8Djtt3RucNwW3GO0AgqqBvR/PojGRHYwMs8iLFrezXKP9QH2VZimtP+W/QGddM1JQsqodoxoTqaHfWUyvzTwd72B6I7tP9E/yUw38zYt+LI4O9S9VHCySkho5YGpIbMrhSTdl0W5EWYGH3eJZw8pnC3rucnrSV0oZWLylW/P0uMAhkfDKOaemKw9mzL3+uLtMM8EICm7/7RA2UjU0cCCfdg+Xwq2nhVBZbT68vQF2CCErM9uRdS7ckABVtG+TcZ/3yypKv5DMx6hWaFkUBZVO7CwtIlZqjSqlwuFjh1kyCR4BdH3sj0/vzq40D3Guw23VoKcg==;31:DXZioxnSAF9+Tlv05WGcDnS/dcCCmwwxs5Sylhhh1366hCCV6vAtHuSWMuE+bAYoJ5FD1alhpUq2SyBVBeqZkzGqdJLQPvVwld6MWXlbXxyLuP/4rMisjqUi1ssbmGQpGoULZM91UosabDetXD4NweXVq1jlqpmfYSid2DZ7zyIxyC7qXQ6q/Mh36PgW78BFudXWyASPi6ewVbnphFh0C59CHAqxD18P0pyMUDbSANc=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:K0IJ6KxCH8kgB58mffWJ4WTzwvWwC5HlazfYlHraaDo3AMO3iL5XQ1l5wjaaUOUzICNQoHEVGZi8o7XG0SDHvRFg5VzuITiMjBk1S9tTwqeSpy7EwDtN0B+wPYtUtu2CjTeGLukO6CPlTSvrZA2++MnuArpQ+LKxn5huET81B469hG39Ano0PtZ5aEE69jWkwt56zhzPpm1aR/mu5fcvXt55AdeR/6/lqp9/vDU0Xu0KEkKN0eWPzP5VOnjed8CwEVeaEMWCvqcHJtaL/mC8vAcKOi6W/JJlyRJmebQo7q9OT3nwjtZxMZB6HEhLOF/NGyTCTX9gvuGK7ySYjYNwHAntjcN1HHc+vWGMjwkwJW1iVEbpe1ovC+u5Nfm7HJoMl4OgqB4BP02cA3wG18Zx+qeQ4F0U2k6e/RR7CRYuNQWFjGuxIEkjWO3DGKAj8C75ANxQU8Oif3FkZJPRatN2YU5UhuovSm+HVzvP6ru5lQr7w/ufmp2jI0sdmVawDDfw;4:fZ6MVh309YlA6fRIZ7mzanv5vpf3kw50fS2mgkEgT/PGCozAycqGlJ/tScLKn1lt/peRpvwsSFVDkkfwuvM/MIvV84pxa0bmO2DCrdybzqbJ+xp6K556iPE4BcPs7jIKu1ZIxi+c0+iNxmm9VK64gP1SlvZOM29mvx1jT90VNnO9BrxCL+dJXsc6aviBhUb893ZpXPxgLj84dtKY8UO/kXmXaebJPl5a7TaSw8lVv0UCDdCqMUPXKcKggJ7Dv289orkYRrENGz1zEYh4DxRpE9DEXnh2J93KNFE5NJDmQQC56/+WNi5dRCpYIshkHa+C
X-Microsoft-Antispam-PRVS: <DM5PR12MB23595296FAD35E734D502A58F8930@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 0673F5BE31
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(39380400002)(366004)(396003)(376002)(199004)(189003)(97736004)(956004)(59450400001)(52146003)(23676004)(2486003)(476003)(386003)(53546011)(106356001)(2616005)(81156014)(31686004)(105586002)(68736007)(446003)(11346002)(52116002)(6246003)(86362001)(8676002)(486006)(36756003)(39060400002)(26005)(54906003)(77096007)(31696002)(50466002)(8936002)(76176011)(81166006)(4326008)(64126003)(65956001)(58126008)(53936002)(66066001)(65806001)(186003)(6916009)(16526019)(6666003)(16576012)(316002)(47776003)(6306002)(3846002)(3260700006)(2906002)(25786009)(93886005)(305945005)(229853002)(230700001)(478600001)(6116002)(6486002)(966005)(7736002)(72206003)(5660300001)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:3;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU5OzIzOlF3MER3cnhZVmd4M1p5RmhuU1p5VHZuRE5t?=
 =?utf-8?B?NTIrNzRxVmZrbUdqb0pLV0E3SnFINUs0UDRMZks5ZXNJclZidFpBa2N3cS9O?=
 =?utf-8?B?YjZXNUtkNFZjbmFPZUtuZjczSUdSTGFaQ1UwWnVkK0syOWxBMGtkUmpxaXhk?=
 =?utf-8?B?bVpaVDZoZkM4Rzk5dlM5WkphbGJrZmNkaU40a1hRUDBWcENMTHg4bkJJUkJY?=
 =?utf-8?B?dm93QkJjRDVHckFPZkJucUVLMnJwUVI0SkRwRWdKWXlzeXRubkttMGtkd0hR?=
 =?utf-8?B?RzZxV1dBYjFka1plVkx2QXh5Y0NPcnVkekdKRmZHYWRIUGs4NHBVWHJxTWs1?=
 =?utf-8?B?QzMvc3dhb1RVMXZBN0d2MkYwRDhvMGU0d09jc003djVlb084bFE4cjlUM0xU?=
 =?utf-8?B?bmxCc21RUWtSQ0VyRGNqQjc4eFJCejNrT21hN1pJZk80SCs3Q01jKzNRLzZS?=
 =?utf-8?B?UG84T1FHMUxtb2tWWXJVU3lERjNoNk1LUUF5OC9VQkU3WjNhWGZWMVBaOHln?=
 =?utf-8?B?MExiQlFxL2ZKcUNFSVRYNW95T2IrZVlKMEdDSDRmTUxqazZ4UnhNS29VSHQz?=
 =?utf-8?B?dzRrM1BDVTFTVzU1cTlzRHJrZ1lOTTdpcSsxbTd2YmN2Mk9Uc1MxL1NRblU4?=
 =?utf-8?B?THRNRXNvRFpEM1dQcUpsd291K2RkT0dNeU1KTk5hS2Qxbkw2YkZrbFR0K2hH?=
 =?utf-8?B?VG9HTUFiZlpEUDdEdCsrTWNGNG5lL3doSytwV2tHOSs4VWJDSzhsZFBRampB?=
 =?utf-8?B?VmNjNElzNW9SaXRFclpCWU1ZU3pEM0dQWkV4eWFDT044NXVIeWV1UWtNMDhy?=
 =?utf-8?B?UXpTc0NVQjhrWmwreXg1S3kvNkZSenp2dHFjOE1LbVRXWmZweStxL2V5eng2?=
 =?utf-8?B?OER2UTZFczBaS1pieU82Yzk3bzhTYUUyTytIZHNMT1I3aHh3ZGJhNkhIaHFI?=
 =?utf-8?B?bHBnKzJwbnlXVmE0NVl0RVp3NmY1TlNCZDdDR1NlSU9Gd0RyNVVvTUp0RStQ?=
 =?utf-8?B?SFJPYmhRdkprZGtodU42SDdYbjRvSHJFTXNPMjMxZnJrdDI5M1ZDb0dIaHc4?=
 =?utf-8?B?RVdwVjYyVkp1dTFKVUJRNlptaDEzMy9SZldxdVVURDYwNHlRVURyM255NUNt?=
 =?utf-8?B?dXdPdEh4b3VQRVBiczIxTVVwU0tBbnI1Tkc1eGE1L0tTYVkyck9pZkxIN3hC?=
 =?utf-8?B?a3djWTNnUTF6TFNkSFVKM3graEZrbUo3aTVOYmlUVWp3Wm9WUWx3WTN5Mk03?=
 =?utf-8?B?elFzS2E4OXIzb2NFRXB4WjZ4a1lVQytQSmpPUnpUSkhNaWtMUXpXS3RMWFNE?=
 =?utf-8?B?NVFRVHgrRUNycWtycGtNSW5sVWpyaUtYbHJaWC9ZSzI2SzFCelBKNldHbWQv?=
 =?utf-8?B?M215cXJDTTAwOW5wQ1R0TkkzeExnL0JzZldKUGdSY3ljWjlVakVkVkdqekFE?=
 =?utf-8?B?ZFBhRkhsVDJWWG9QNFJXU2swQ1FicCtyRHkzajdpOC95MTRKYUI1SStocTlp?=
 =?utf-8?B?bVdIWHNsYkQrVmdwOU8wMUtpWlN1d1NhU0JQTGRLbXdmZEJXVlcwTFdkOE1V?=
 =?utf-8?B?aUVGZXZsTlZWQkV6YjVHa29lM2IrT3M2cmZLbFl5aUFiY21kVUJkM0lFazM3?=
 =?utf-8?B?bmttdGYyajl3dkRHL3crRzJJbFNuNHhIUmh0OGRrcUNyVit6R1RlR3RsWG9R?=
 =?utf-8?B?bXpwMXRxS3NrWUZtQXRScURiM1Q4TGhHRlF6MnFLYWtVMjJTK2t5N0ZLWUJO?=
 =?utf-8?B?RWp6ciswclp1NHk2eVg4eEc0QkMzK3pDWTBQRFNjelRzYitLWkFONEF3OUox?=
 =?utf-8?B?UUg3WnFSQ3RuWC9iZGZ5NGR1N2hyb3huQzdDMTRjckxyMUNEZlNsRVBVTlpF?=
 =?utf-8?B?WFZMYmc3cFlyM0lWUkxjazJSM015TVg1c3JZT21XQ25ibXBxYzdEQmFtZjFp?=
 =?utf-8?B?ZWtoaXVicldrTlJYVTZDdVNaUFhnKzJOYkxUMHlVdXQ4U2ZoL3Foc1JhMEty?=
 =?utf-8?B?RkFqV0puTmtnS0UwZzkreGJxb0tKSk4vY3lzUnJoRmVJTU9RdG9meFVTZFBZ?=
 =?utf-8?B?bDVXSWphRWlEN1hkbEFMQmhTdldRc1dkVWx6Rjc1WEtuZitZOTRHOEdHR1dl?=
 =?utf-8?Q?UZhxipsXGomKMK4lBDom/SJi5y22jj5DUb3GlZrf8w0P?=
X-Microsoft-Antispam-Message-Info: Sl1baXxFt+6szL6cZ/BnFr9Hwrg2ehd8UlkvrcCCHDYBeX9dfQugi0tQ4OtEbSDnTv8K/oxcIY1PDIar7UImcjTjXIy5v92jzRLlo9T8nZzB/45NJ4hFemrnFqXOCgyG25jYlUvgCHWfs2Gg+Bo/PcPe+7ALJK/ztM7q2sJrhGfSo8jnw+AZPBQ9qIh5qNRJ
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:T3F+J1HcQes7qRimWA0zC+C02R9rxzYNFTHfExWgeY95gPDDbTUgRFtJf4n7Qkg212XyZGV2LZlXWPPbiS1k4vrOJMXlQdBnid+Ht1YM2pVflJWRcsP/Hm9/nd10EGZx4qs4IqnFfzRwFv1P6UbBykbK+bAtAAJwibLl4nzax4SgLcuHSgZgX+4QuY5bodtpMsgfgTCf+tITMZ2VwCF4WyXDIemWsF5ajEsm4tWULfkk/hIXANpJ2wKaDGzb3fOoLVNtJkOjuJW2DVJtY8B2X3HekSF0d6nDqqgNjGHgnMKUw7f489YYJHbh2HcN4+Cli/Om8ort4Hhe99z1gGDcMmh/d7Xr3pklcHpb5zx4kDnlr738QL68nhcQwsejN0aC8NITvqiULHAXTg01cuqpsfxku3LzUyD8hPxl46oAIAvs6DmREQEY/FYb5H7neRnemYKuIhJPHjTmKO3rdINZ8A==;5:ce5HCEHJUs91zQjzdU7fLPxQweNW9FR60KI6tNYWO3VnSV/kS4/rMRjV0WTyTEUtdu4XO9ea5Amp1uIoybBanP1g9O5V72F5nDBX5y4OiZapYfWlIIN00omxsT7vS/6AMJ3Pjwl3NOqHQ+Hsws/JPU3jn4L6Tru5xqhRyOVisnk=;24:fKlFduXI/QlKBEdc1jMs5lGE8NjfToXHp7rVMlvqj0RZJe8wa+AbQFmOY5UzxLrWGuG36k4gD6LawJKFr9nU+D5fLBAaHVFjxGXezqL81M0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:512SvKUqwWvmxMzWS6VElUCAJLwD13cjeDr7uCACTgs2cczOzx5vfOp7cA0m6yB59NaNt74QTa9hk7DZPuVeGcVVehhtThtyvNc5jK6MKHgdS6e5Ye2JL3Bunec0ioNRTZ7My8an9T+neANGxCb37Zw8bgyi2gRr+1TlNJglS2bTGhglcih1N0x0ngoOR6PM4RU3MqBdMiX04O5T4o9zQ0B8nGV477nR/mwc7rrROFZAQbrwbIOEt1R0/qFbQY2p;20:z94ZApyjrvB3wBVOLBAcrdk372B4Kg2woZGD6sSDsK3MNsnTrB6ivc5XSRgs21Mn6HOl1RUunr4qbQ1ryFV6Ix68EXJNgnreSchJK9QHbcaH2IVbeR307JKV8/fAxnElof+HR4EnE23X4JP8ny7ljc4diN/P3vC01t7zJyTt68wJN9/pudrJ0WYjrDFdTIBH0BZmRlar6J0PS9okt93knlC2DwtFAY1m0pMNvo4nxt0j8oOfB/FiMYdsH/OpitK8
X-MS-Office365-Filtering-Correlation-Id: e2409e2c-d169-45f9-7054-08d5ba486935
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2018 09:44:07.7689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2409e2c-d169-45f9-7054-08d5ba486935
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/2018 12:09 PM, Daniel Kurtz wrote:
> On Sun, May 6, 2018 at 10:50 PM Agrawal, Akshu <Akshu.Agrawal@amd.com>
> wrote:
> 
> 
> 
>> On 5/4/2018 2:45 PM, Adam Thomson wrote:
>>> On 03 May 2018 08:59, Akshu Agrawal wrote:
>>>
>>>> Non-dts based systems can use ACPI DSDT to pass on the mclk
>>>> to da7219.
>>>> This enables da7219 mclk to be linked to system clock.
>>>> Enable/Disable of the mclk is already handled in the codec so
>>>> platform drivers don't have to explicitly do handling of mclk.
>>>>
>>>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>>>> ---
>>>> v2: Fixed kbuild error
>>>> v3: Add corresponding clk_put for clk_get
>>>>  include/sound/da7219.h    |  2 ++
>>>>  sound/soc/codecs/da7219.c | 10 +++++++++-
>>>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
>>>> index 1bfcb16..df7ddf4 100644
>>>> --- a/include/sound/da7219.h
>>>> +++ b/include/sound/da7219.h
>>>> @@ -38,6 +38,8 @@ struct da7219_pdata {
>>>>
>>>>      const char *dai_clks_name;
>>>>
>>>> +    const char *mclk_name;
>>>> +
>>>>      /* Mic */
>>>>      enum da7219_micbias_voltage micbias_lvl;
>>>>      enum da7219_mic_amp_in_sel mic_amp_in_sel;
>>>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>>>> index 980a6a8..ecd46fc 100644
>>>> --- a/sound/soc/codecs/da7219.c
>>>> +++ b/sound/soc/codecs/da7219.c
>>>> @@ -1624,6 +1624,8 @@ static struct da7219_pdata
> *da7219_fw_to_pdata(struct
>>>> snd_soc_component *compone
>>>>              dev_warn(dev, "Using default clk name: %s\n",
>>>>                       pdata->dai_clks_name);
>>>>
>>>> +    device_property_read_string(dev, "dlg,mclk-name",
> &pdata->mclk_name);
>>>> +
>>>
>>> Personally am still not keen on this. To me the use of a
> device_property_*
>>> function suggests the same property resides in both DT and ACPI, but
> here we're
>>> only using this for the ACPI case. DT has no want or need for this. I
> still feel
>>> we should look at something more generic in the clock framework,
> although I do
>>> agree with Mark that this should be properly specced.
>>>
> 
>> I am not an expert in field of ACPI, IMO forming a Spec and changing
>> ACPI to have DT like clock framework is good to have but a bigger change
>> which should be taken up later.
> 
>> The current code of handling of mclk in the driver is usable only by DT.
>> The device_property (though ACPI specific) makes this code, a common
>> code for DT and ACPI based devices.
> 
>> https://www.kernel.org/doc/Documentation/acpi/DSD-properties-rules.txt
>> "....Still, for the sake of code re-use, it may make sense to provide as
>> much of the configuration data as possible in the form of device
>> properties and complement that with an ACPI-specific mechanism suitable
>> for the use case at hand......"
> 
> This sounds like a pretty reasonable justification for addressing the issue
> using DSD to me.
> For what its worth, you can add:
> 
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>
> 
>

Hi Mark,

If you are Ok with this patch can you please take this.

Thanks,
Akshu
