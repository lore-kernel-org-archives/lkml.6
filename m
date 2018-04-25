Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751259AbeDYDhR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 23:37:17 -0400
Received: from mail-co1nam03on0088.outbound.protection.outlook.com ([104.47.40.88]:33248
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDYDhP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 23:37:15 -0400
Subject: Re: [PATCH 2/3] ASoC: AMD: Move clk enable from hw_params/free to
 startup/shutdown
To: Daniel Kurtz <djkurtz@chromium.org>, Vijendar.Mukunda@amd.com
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524539088-9043-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524539088-9043-2-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omDr8Jiwx0faMWZpASPrTUCcj97xSvG01JQX5Cj16vEeQw@mail.gmail.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <4c8cfac4-e67a-4457-0e27-2beb34b3d0cc@amd.com>
Date: Wed, 25 Apr 2018 09:06:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omDr8Jiwx0faMWZpASPrTUCcj97xSvG01JQX5Cj16vEeQw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.56.249.162]
X-ClientProxiedBy: BM1PR0101CA0038.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::24) To MW2PR12MB2362.namprd12.prod.outlook.com
 (2603:10b6:907:7::33)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MW2PR12MB2362;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;3:1rb7uCDOyKRX3ikcUyA9zIMZkKQnM07uov/nhzS2WzRNYdeL+ha3y/w4ZOl5RrhAS/nTJWqLDomvMpEuTErhVKJn2ePVdqxHMSCloH8gHuwnXbouZ2DsH5Y8izHwDE0ZH3T9qTkvmsnOVtN9QTM9LZ9YHlJiPqDM7sL7wEa4/wRZhEQEsc2PRGSMVpERqnJs1XFtwOkcaz0oz/w0NwzrD4Xv1VcSbiNAqHYCwvV0NAzrW7ozZdeZAVhzrnb4olp1;25:SRLRY7oIXroR47nIMKfhbcCGSPoVhaP8sJiqSda+Je0OjpCSpwxmcQdfvLaExJyYbZY4B2HMeGcXO2LfwoucUKVsKWPMXITEEk9b18Q5YlrqUdGC+fRnFOaa6dZ5UGh22U+Ll+H7SR9WwN7cN+wcxqvKX42b8k4n0w7UlkE8Fl4l55UxqpTQmTv8jYR4VzdnNKlpiUNp8CFP0ecnEJYDuNlV6QBugyIJCmwrY1OBgRWSlz4OmCzFwHBvkV6im+/nk7HmKMm5yVMJYXMTOgLp7Cgl6ukM+fQZ5H7jyUahTT/kDUjPJOMdU+uFCfvb/7NVbTM9B3b79f3giA5ryxCfAA==;31:8qCYEQS3BOgTKiaW1AkQRayK21u+PVKbRSk2gh1p4TU8yRpDetvZTXkTmLkGMvwIzEwh/tCotBiGt9zj9f3mU4aMG2ZHSJpbTMXeL06lPkR4IUpWMClKovOz4lHQfZYj3VxIpGaCm0YaozougXkVibKXIoLsRp/W7hoMvNX3ubAzaICx6JqbPigvm1XO/BVKgRb35vydnUD0Kx71+unS1kwpjC3/IZ2GXVWOYthmPN4=
X-MS-TrafficTypeDiagnostic: MW2PR12MB2362:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;20:QeRM5/7/+3fkBxCgYewXwSBi9+LFd6WGPNPWs6zbRXBlnfD9/xZILP+JVTY+lviVdQqXorq16ksXwZn31N2zP82gZZJ6sCNXVh85Pj4gMt2nq5jyB59fXeKALrJzHTDk0pCwfytN3rwIavTJDAkugUIIuICNzEsdHF3bTWqvh+rgasaK9CjwQtclpLQZ6Hgq4Q4A13ZRtvcK+6Si3wb7hXzTRGoIaXeusbL87Q9UROecLDtBjtJ/6GNvjRIz5eZX/5giQEfL5IwxcUJbky2Id2Y3g2uQhT0C6T0sDQCHWVx+PvbQOMRfNq5SwuDtCC24sTQsvdoQcsypoZD8weCrO27tdoVKYG2784EGGl+osac0JIzoI5xbssND4ygGaWmXadyWN4950qtIsznDpZQVkAISUOriXQoQAH4mY/bCzLEK35viSsmlfYW5VG8hKnFnJ5T6cVCXtUecSiTDPZelH1bYtPmTznNkgII2JKgObwEMsDUOB1wLtJih0wMNpWNW;4:SDM3bQlUg9vl+PQHXt55YJJZT4gEcCbubQhQ7c/Lk01tJHJG/qEbqCXgMWxRxXaW/oAgu7ywzm87zcZ269F8wqoai66PJljHXojv20gPnJG4cd0y9ZTyxBO8BBrM2vJ6Ael6QTh/LEs9dLYyuTa3wIYcePaHWTuK6C7y2uyMiNWY2wHRMY1/kIl3fdE9fFGehnhGHSFwqeYVW1RnJpBGcWMHU6QgKKbNuguBZk+w9gQh3/OWrHT4grq5gmmlv4sU1fhxEs89QVOa4PUXc4+JEatd1BZbSx1oFIUme9R6ej6RxGlv8o51yXEcWX9pnVaa
X-Microsoft-Antispam-PRVS: <MW2PR12MB2362DE8EB5B2AB64599F688CF88F0@MW2PR12MB2362.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:MW2PR12MB2362;BCL:0;PCL:0;RULEID:;SRVR:MW2PR12MB2362;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(396003)(39860400002)(366004)(346002)(376002)(189003)(199004)(39060400002)(956004)(6246003)(67846002)(65806001)(47776003)(68736007)(16576012)(316002)(36756003)(66066001)(386003)(58126008)(72206003)(65956001)(52116002)(478600001)(64126003)(76176011)(2906002)(53936002)(4326008)(97736004)(25786009)(3260700006)(31686004)(53546011)(8936002)(8676002)(54906003)(6486002)(5660300001)(16526019)(305945005)(6116002)(7736002)(81166006)(105586002)(106356001)(3846002)(86362001)(81156014)(446003)(26005)(486006)(11346002)(2486003)(6666003)(2616005)(476003)(230700001)(186003)(31696002)(229853002)(6636002)(50466002)(23676004)(77096007)(52146003)(65826007);DIR:OUT;SFP:1101;SCL:1;SRVR:MW2PR12MB2362;H:[10.136.128.133];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNVzJQUjEyTUIyMzYyOzIzOmIwNXduNjU5ekJvUnJoM3VLZkhwc0ZnWWo5?=
 =?utf-8?B?MklJU1h6L0dnWEFHem4rRG4xdzR1U2ovUFhHRHdLcmY3ZjlWdFdPTHhXaDRZ?=
 =?utf-8?B?ZjMzendoRElnYXNCb3FIM2Z3VEVWN2ZCZktITXoxeXJHVnpqWWdrcVdLZnU1?=
 =?utf-8?B?Z1Z4QzI4NDhEOGEyM3UyNllseG1PMlpzcDRxNGxLcExERStWVjM0Z2tHV2RK?=
 =?utf-8?B?MkpQR05hWXA4anVMVDUwWDVMYWhGOUo2M0NvcUo5M0RmUFBMd0xiVDgyb1Bx?=
 =?utf-8?B?WWdwVGNvdmJ3NWJvUityOU11NFcyN0dQczE4M3ZUK2t2ZlpvZWNvRlpDNXpD?=
 =?utf-8?B?RmFPZnc4SE1OTkNsTTExdDZMblBhYjE4OTd6VHAvQlI5NzhFZHRPQ2Y4RGhR?=
 =?utf-8?B?MWhxd1QyeTNyUjIwQnAzdy8yWDI3bUEreUdDbzZNZ0xsb0hRak5FbG0wRktD?=
 =?utf-8?B?eDAzOXNjS1pQUEFoL1VlWnU1RDdYbzU3dDdWdVNUODhtekhkbUVvVGE5NUI0?=
 =?utf-8?B?OEcvREdtcUU0WEJtZEN0NlYxQ1VCQW5FS200Y09zVS9BNUVpbmc3NXZqamxy?=
 =?utf-8?B?Q3hmeEs4VkF4TnAzTmhoNGxsTnhTZEp3R0xPQnFCQTFGeit4Wk13UFNJbUpy?=
 =?utf-8?B?Wk9DRlk0NERPVDB3d25Za3Q3cjRCWDN2TjdCYUdZMzlVbmFxRjhGd0ZGSVhN?=
 =?utf-8?B?K0hoRmRaVVI2STFNL1pINEk5WE0vN29aN3NDcTRKOHlLRFR0TDhOYjRhNzFR?=
 =?utf-8?B?V3kxTmw5WGZvMUdPOUVWTnUrYlMvU1JtUVZ4RDk5Q2d5S1UzbldCUzRnSG5v?=
 =?utf-8?B?cnZsNHFGN0c3YkZKMUptVWVXckY1S3JTeFlQQ3hkT0wxL2k5Tkxla05MSVFr?=
 =?utf-8?B?Rm5JM0xwN1BVcnBzY0NCc3ZFZCttcit6cTJTY1c5RlU2Mk1jTjZqVWlNV3ZX?=
 =?utf-8?B?bWsxTDVFbm1qZjZjU2Q0Mk9Od08wVGorNmNldVZzUE41aGoxTGpQY0xMWFVZ?=
 =?utf-8?B?TnVwMFRueWZmeEF4M2hURHh1aTZLbzlFT0tTRkpQTURCK3o2S0dlL25wOEhO?=
 =?utf-8?B?U1hjdmswZW94c1dNUGR0cmxSWlgzelZ6TmVSN245c0lSZjZtNEhLc3g5UU5Q?=
 =?utf-8?B?NnNrOThJK2F3VVp4NzZSR2JOMlB2emt4YXVQRWNkYS9RWTFGK211OFZVa3dC?=
 =?utf-8?B?TFhId2dyb3I4bCtCZ1dWM0ZXU3J0aEoyY0F4azNjYlBSYlQ2Wm9zaHN3N0wz?=
 =?utf-8?B?M0VwUWNnRUlDbWkxYzVNaWxBWXdWMzVBOVVtYkcvUFhUeHYzWWFWQUx0dG1D?=
 =?utf-8?B?NjdJZDlUT3N0MTJPK0JwNG44QWJsVUpxeU5uUDJKT3dvSCs2UVZnelBxVkNa?=
 =?utf-8?B?bFFtVW1KbnhzMU1vVyt3azhvMUtBR0x2MnRHZmlYYjNJbkR2eWc1U0NKOTdJ?=
 =?utf-8?B?elBvWmVudjJsamhDa1FLQThEcnMyUU1OOHpOYXpaY1BMWVdsMDFENHBGU09r?=
 =?utf-8?B?czBQdmIvQTZoREpqd0hoSW9VS2NqMmxNa3EwYWt0VVZxZTVQTm1xYzJnbXhN?=
 =?utf-8?B?dEJzNEtCbWxsQ0xKbUE0ajJYSm1Kak44aVJDdlQ2WG1lU2hGcTk4T0RHRkk2?=
 =?utf-8?B?bjF3MUd2ZnhncGQvMnFuT2I5QXFMRjVaOTBJWFhyM3UvQkQ1QlMzZStPTXNW?=
 =?utf-8?B?b3Vzd2grcm5oaVdiSXRxLzVMRFlaSjg4ZFpOQUZWc2VqQm0wYnNpZ25DaU9s?=
 =?utf-8?B?bXdiMTQwVjdFOTRpamRuUVZQZE5TdGhzNjdtMDZIK2RmQlY2VlJRWHQrcmx5?=
 =?utf-8?B?aVYyb3NPSk9LT1BqanlqUFJsYlJyc0V4VW9OeGRoK3dsSk1wQTd2RlNtSWxv?=
 =?utf-8?B?OUJYYWhhK2Q3OXhBSW0vbXBDdmdReTdEMTgzWWpnV3Z5eW1rb3lyeThYcVpq?=
 =?utf-8?B?Y0drN0gyaEVZMUNHM3ZmQTJvbEdSNGxsOTJIOHlEa2lqQzlieDBMM1AzT1Yr?=
 =?utf-8?B?T0pWOERzWW53bDVYRzNOcGFueGJaYVU4cEpBM2NjMWZzYWx5eFY1MThTbVd6?=
 =?utf-8?Q?IGLOaIrIYJkgNciqhXzO1zdUS?=
X-Microsoft-Antispam-Message-Info: ++Aw37HD81yCFGMXl8cQhSptlOc90bYiKLpGcQi4I6vt05bgOTsznxHuxvLNjwqd7HuUlF3X1DfobzUye48pK1QcSTWgiy+enD8z6Cy3Ufm3v2b2oYNplT9bt6QTOr91+kOMsJ6FIXb3vNJW45tzu2Yt4mcz1lJm3igbEbbCFoeBHaLELN+guSvPESI8BP51
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;6:2oTMMjRHrnex5k9wReJjdvQVnAqwy1vb3QwJ2o2lFYbAiPnAxd1xtg/XNTxkLVtXHUQo3+t1NhdwDQO0eR3o90RyDoIc8x90ynzGDr4Jv8zuMHZj5VTIkPRsYzCaNZcGuIlqgig/Dc5t9fC03I4QSha+qdT+yR/HLBNAjZksbe+7Q18XTzEEnWBdd3I1ka3SF6KMKtbz2Qt3bZxLk7J/kkLhV2+dtDuLPoGLSb//IyL3/aggxr9NeplnIavKQS/1AJv43W6yPlylo9u0aPzyPFMftY0H9kn8sGrXpAIdJ6K7XN5+xkRdirMRiHDHSym8wxZEIbRR31tD4EUaL6a94rfukrkzN8JU2cdupMaM1SFJicXz92Ius4H+jR5bgtL82JkQD7s6YLLoMY54yLQ5xpMdXvDhXQ3Nh6WZ4h5VmiloJkrLEMXNuIWsR31LMAJxlQgY+o89PFjyMFynibvF+A==;5:tOP/JNiSxVc2nHS0WQGmxPmTc3Ha8cShnSpEwivjPo/QOB4eag7kYa3ErcxvsiHwoMe+ZfD6Ev3zZV9wQcklDTnRT1uDYNZ5yE/6lrGVoce06oHjhxKL3XCOuD3LTBKlmq/OwK41Y514C90HKLFLKuVH/wIp9mlsWOWSLrK1ax4=;24:yBzRtncEmkl+95s2mHmdJ7wpHmO4zoOpFMkCrIAJNLfmmIZ4CSRGp2r8Rs+GDMGRxcXurnA5uJKpBg7LtnhPb6oQNLsIk3jF2FS/BVdR8r0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MW2PR12MB2362;7:qKrMwIhp0N0KZ16J+UcdptWpr1u/WuVEpPtDJ2DqVr5dU3w0WSKsTZARWAehBnq1rX5eUd25Z7H7wL4UtP1qxggI5fuva3AnxvOlCL94M5AaQL88Ya5B2xSjXIyhyB3DRQjc8iaiS/QXxVtZNOzap0XTdQSlynJQYAINqiMbz5jZTRGD4vESoSn/B1eiokDYlatmjmU8g2+nf1329i1TBH80Z+z7Ib+T2BzRbopKXfysCufeZN8on/8dLqmH42TQ;20:li/oJquN+nmiv/6WKp5DVW0gWkefK03fOXvguceCv5VYhqrU4Dw3ehWLHTnK/ND7U6aN7+o4aggJXDNKu0D6GJQsRc5qjYm7O8ELUR96nmaYNjbkkzAziJ1ZA1XjEJqOCXgA9gBXlFf2R25hUIjFbeiGZfu3prMLZh5/RFvjKsE1oVLW8ToAcqHivmF25guvB33a/5c2+Nnt7fGX+qDCexDo5D7RsGIBpXabe/c8zaRTf+QhklJM3Y+vPK6c0fde
X-MS-Office365-Filtering-Correlation-Id: 2eea56e0-e8a8-40a6-f747-08d5aa5dd4cf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 03:37:08.8591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eea56e0-e8a8-40a6-f747-08d5aa5dd4cf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2362
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/2018 10:06 PM, Daniel Kurtz wrote:
> On Mon, Apr 23, 2018 at 9:03 PM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> From: Akshu Agrawal <akshu.agrawal@amd.com>
> 
>> hw_param can be called multiple times and thus we can have
>> more clk enable. The clk may not get diabled due to refcounting.
>> startup/shutdown ensures single clk enable/disable call.
> 
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
>> ---
>>    sound/soc/amd/acp-da7219-max98357a.c | 54
> ++++++++++++++++++++++++------------
>>    1 file changed, 37 insertions(+), 17 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
> b/sound/soc/amd/acp-da7219-max98357a.c
>> index b205c78..0f16f6d 100644
>> --- a/sound/soc/amd/acp-da7219-max98357a.c
>> +++ b/sound/soc/amd/acp-da7219-max98357a.c
>> @@ -38,8 +38,7 @@
>>    #include "../codecs/da7219.h"
>>    #include "../codecs/da7219-aad.h"
> 
>> -#define CZ_PLAT_CLK 24000000
>> -#define MCLK_RATE 24576000
>> +#define CZ_PLAT_CLK 25000000
>>    #define DUAL_CHANNEL           2
> 
>>    static struct snd_soc_jack cz_jack;
>> @@ -62,7 +61,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>           }
> 
>>           ret = snd_soc_dai_set_pll(codec_dai, 0, DA7219_SYSCLK_PLL,
>> -                                 CZ_PLAT_CLK, MCLK_RATE);
>> +                                 CZ_PLAT_CLK, DA7219_PLL_FREQ_OUT_98304);
> 
> These are unrelated fixes that should be in their own patch.
> 
Accepted. Will split it.

>>           if (ret < 0) {
>>                   dev_err(rtd->dev, "can't set codec pll: %d\n", ret);
>>                   return ret;
>> @@ -85,8 +84,7 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime
> *rtd)
>>           return 0;
>>    }
> 
>> -static int cz_da7219_hw_params(struct snd_pcm_substream *substream,
>> -                            struct snd_pcm_hw_params *params)
>> +static int da7219_clk_enable(struct snd_pcm_substream *substream)
>>    {
>>           int ret = 0;
>>           struct snd_soc_pcm_runtime *rtd = substream->private_data;
>> @@ -100,11 +98,9 @@ static int cz_da7219_hw_params(struct
> snd_pcm_substream *substream,
>>           return ret;
>>    }
> 
>> -static int cz_da7219_hw_free(struct snd_pcm_substream *substream)
>> +static void da7219_clk_disable(void)
>>    {
>>           clk_disable_unprepare(da7219_dai_clk);
>> -
>> -       return 0;
>>    }
> 
>>    static const unsigned int channels[] = {
>> @@ -127,7 +123,7 @@ static const struct snd_pcm_hw_constraint_list
> constraints_channels = {
>>           .mask = 0,
>>    };
> 
>> -static int cz_fe_startup(struct snd_pcm_substream *substream)
>> +static int cz_da7219_startup(struct snd_pcm_substream *substream)
>>    {
>>           struct snd_pcm_runtime *runtime = substream->runtime;
> 
>> @@ -141,23 +137,47 @@ static int cz_fe_startup(struct snd_pcm_substream
> *substream)
>>           snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
>>                                      &constraints_rates);
> 
>> -       return 0;
>> +       return da7219_clk_enable(substream);
>> +}
>> +
>> +static void cz_da7219_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +       da7219_clk_disable();
>> +}
>> +
>> +static int cz_max_startup(struct snd_pcm_substream *substream)
>> +{
>> +       return da7219_clk_enable(substream);
>> +}
>> +
>> +static void cz_max_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +       da7219_clk_disable();
>> +}
>> +
>> +static int cz_dmic_startup(struct snd_pcm_substream *substream)
>> +{
>> +       return da7219_clk_enable(substream);
>> +}
>> +
>> +static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
>> +{
>> +       da7219_clk_disable();
>>    }
> 
> This is ok, or you could combine the common cz_max_* & cz_dmic_*.
> 
> 
Need to be separate as they have different cpu dai.

>>    static struct snd_soc_ops cz_da7219_cap_ops = {
> 
> I think these should all be "static const struct snd_soc_ops"  (please fix
> in a separate patch).
> 

Accepted. Will post another patch for same.

>> -       .hw_params = cz_da7219_hw_params,
>> -       .hw_free = cz_da7219_hw_free,
>> -       .startup = cz_fe_startup,
>> +       .startup = cz_da7219_startup,
>> +       .shutdown = cz_da7219_shutdown,
>>    };
> 
>>    static struct snd_soc_ops cz_max_play_ops = {
>> -       .hw_params = cz_da7219_hw_params,
>> -       .hw_free = cz_da7219_hw_free,
>> +       .startup = cz_max_startup,
>> +       .shutdown = cz_max_shutdown,
>>    };
> 
>>    static struct snd_soc_ops cz_dmic_cap_ops = {
>> -       .hw_params = cz_da7219_hw_params,
>> -       .hw_free = cz_da7219_hw_free,
>> +       .startup = cz_dmic_startup,
>> +       .shutdown = cz_dmic_shutdown,
>>    };
> 
>>    static struct snd_soc_dai_link cz_dai_7219_98357[] = {
>> --
>> 2.7.4

Thanks,
Akshu
