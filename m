Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeEAOcF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:32:05 -0400
Received: from mail-cys01nam02on0073.outbound.protection.outlook.com ([104.47.37.73]:59121
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755305AbeEAOcC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:32:02 -0400
Subject: Re: [alsa-devel] [PATCH v2] ASoC: da7219: read fmw property to get
 mclk for non-dts systems
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, djkurtz@chromium.org,
        Mark Brown <broonie@kernel.org>, Alexander.Deucher@amd.com,
        Adam.Thomson.Opensource@diasemi.com
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <cb0df61c-596b-b23c-fc34-52ac4b7830e8@linux.intel.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <43c7939d-e30b-27eb-59e4-c0e16248dad1@amd.com>
Date: Tue, 1 May 2018 20:01:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <cb0df61c-596b-b23c-fc34-52ac4b7830e8@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [106.200.239.203]
X-ClientProxiedBy: MAXPR0101CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::13) To SN1PR12MB2367.namprd12.prod.outlook.com
 (2603:10b6:802:25::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN1PR12MB2367;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;3:fxzpYbX8Ffzh4V1iPZGHiVHQ1APh9zd0MyUhQkIlhlK3v9uu/YNukRGhQjH4G9tsZQPUuUKO5rAL4pji3d5ge7K3urx11r5hc3RRm58Jm7LbwMkagdyrQ+vqtvPFACkIO3+C7EgCl1z7Ebx4P03xizD90aaZuw3yllexlkSl+iF2jyS5gmPEJIArTI+gOKP0rTxaaSFjO0dXbHwI0ZGU+2kEs5C0Uip++2PEvubIaa0i59v+UHhEm1TM0+KrzpRr;25:FNtGH94RULL+jg/l0QJy6v65kD9+UE3Z3uzjxhSo4Z0+L5uT21x5gYVBmKjdIY9xRFVer1U6w4U7jK0aenEihj7KPymersIZpmKcDoit1lHHXMyfJ+YiCDWXBpEtgKvE4vSHSOHhuS76rGeFGiaOsxViZGht07jTgmV8Kjo+E0ZyqlPG7z1Q381+414uzzvbNAMaLbSjdjmZ4uRJIKnKYOK+a9BfOWLGRZTwkytXZMK7Wa5NZBvoCsk/abBjwxcof9+Tg3ecAWPB1IhqHj8AjwoxyCx/Rw8SIaK4MK4+2KEM8SK1G0DIgOL5+bRPxaquwhIf1Y3tVqJAH/7xcYigIw==;31:k7v6YxrWyeaJ4TihoBN2bRIDSFbo+nQuOPsViveLtDzXPfSXUID2d7nZUEbQoIwZdiesiBlAImw3oBW4N+SJtKMgzSOBTvPo2j3oM2eO2L53jSHNreo0V5RCMUOQ9NIDeitoljpPIa+BgcSKZgUIK5SrzX2P2H/0SE5pgnGi+GayTHnX8ncZKnK1SgivtZQ3DdCD3OQSLvDzzvrR8w11ilvh/oZx/38ouEVfo9ICnzc=
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;20:0SLEkFxIreV+3TZmNaFvjg2TKVIn4XYha6A0r3x7vz2lN2N+vRaho+HKm2PvEGqneB2Jxk2Ys5jouuztSBD3hSjEjKm7CqawOMkzzpfWWTBiz3SqOUVxUhghOa1QrttNgu2ssgOqD6JceDAK8SDGYjZYe2SIucqMUUwov/vTyH3Opzg4ZLlmb+0mG5kQqG5GYiESQ+F3Hc+XVESJF1OLemBkKv6rWeUzJdyVNu+1t4q1+5PCcTQE4oTtnkuh/97FI+BsGFZjuArT0n9o61MiA8s8cNLshbvlXxw9mBNHVhBw0YNKMAl5pgMXyqCow0KaWHe8nFTIUHAt2XHPRElRzfcDYVOAiVHC3/SeRjT7dzr1XW4uBdoPx6hTz9VzSBU9a/Sanm3iE2LBNybKI0QMbOCx8LAB4nAgPOiiv2aoA+3+DzH8aIjv8O5TtEdXBOCV5uufaCiS8n6hlBB4SSwgp8L/cC1s8eC+kV5oDUZseR+HM6aAdnTyLZgFhwScaFOa;4:0eIOpwVm357zqYjdUeZiK65v3wqpXhtZUwnL5EsuEduxRBQHbNWU5AsVHbufYe2czbqga6KzL5J51A6yGCxwigttkQ2C6alw4sXt5AxOLhWOp/MGIz7ecK4VSt0rO2o9HUF6eJZfeHQ0vgCerLKb7prt+VX7aEeGK/Iedq2xH31LUfy9wGngIuaHqyJYYBItytPL58bRvJr9/OJj1/OpwD9f7EzoODWyf9UpE0xjsyg6FK5jHeyqAba6nqJw0iPAawnBdqVL7QWP98nMyASUwkfaEG5wWs1wmBpxbSAg176VQiI1E9O2oWJdErMcyxr6
X-Microsoft-Antispam-PRVS: <SN1PR12MB236700C956FDD1D009B7392DF8810@SN1PR12MB2367.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(6055026)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:SN1PR12MB2367;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB2367;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(396003)(39860400002)(39380400002)(189003)(199004)(25786009)(6486002)(2906002)(2870700001)(186003)(65826007)(5009440100003)(6246003)(16576012)(6116002)(39060400002)(4326008)(54906003)(58126008)(36756003)(53936002)(3846002)(6666003)(6916009)(316002)(106356001)(229853002)(68736007)(67846002)(2616005)(6346003)(105586002)(77096007)(65806001)(26005)(5660300001)(486006)(16526019)(31696002)(50466002)(47776003)(446003)(476003)(117156002)(956004)(65956001)(8676002)(305945005)(11346002)(64126003)(3260700006)(478600001)(59450400001)(8936002)(81166006)(97736004)(7736002)(72206003)(66066001)(53546011)(76176011)(86362001)(81156014)(2486003)(52146003)(31686004)(386003)(52116002)(23676004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB2367;H:[192.168.0.103];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIyMzY3OzIzOlBsRWNjSkNqWGs5VGNPaUxOdjNPSnIwRVhQ?=
 =?utf-8?B?WkhNOHNBZUtaaThRWDIveTdvTmNib0FlS0paQU8yQm1lcTVZUkJxRDdnY0dG?=
 =?utf-8?B?ZWhudjdKbXg1K0tZQmtmWmlnRUZMU2VPVUxEWFkvWXJ5eENwYVd6dDlkZEVW?=
 =?utf-8?B?MStpSGt2VUkyL1lVNElDWHNSNGRiZWpKOHptbXk5SmtscUFDZ1JiQ3czSkpE?=
 =?utf-8?B?bVJ2VG9CbjZlMEtZUVhvYk9pTld2dGtpUW9JR05zR2VDTXJLcTJFZ2RUbGNB?=
 =?utf-8?B?eDlnMEZ3WnRUcDJHazNqRzRJd0pYd2lldzZyOU5lVzF4ZkRPeXRDK2NtS09S?=
 =?utf-8?B?WnZEakpUVUhUZ3AyUkZBSUpVdVJwOEZWQUp5M2R6dDBwWmxhNGhkckYrN3BT?=
 =?utf-8?B?L2pNN05DNlR6ZjJXR3c0ck95NWZGaVphTERqancwWmhqbFdXSTdKNjNiS3J4?=
 =?utf-8?B?Y0dtWE9UTEVzbXRzNmJ6OVQ4a25MbXBzbW5rUEMvTEx0dldOUnJaMUtRQk91?=
 =?utf-8?B?aHRSbmFHM0ZJWGN1ZzlJOXJPNFFCVGtEN3VhTWJQN3BaeTROTisrOTNSeFRU?=
 =?utf-8?B?WHRGQThqVnNOc3ljZlZtM0FqTkg4WmxHckRyQTYrQmRtaUxsTWpiZXJIOVFB?=
 =?utf-8?B?SmNoNjF3Y1RXZlBuclFseStRZnlJYUlqL280bXNqVEhGZk1BM1NKamU4R2k0?=
 =?utf-8?B?S0F6cHVPOTBpaWlGTTBFaTJSd01TenZYb3VybkFZMDI5V2JaeSt4bFpjWThv?=
 =?utf-8?B?OE9YN1VvOTA3YlZ3WGZYVCtKbnlmNzZjU1p3ZFRzVkdJNnU2RHkzaURkcnpt?=
 =?utf-8?B?RmY1ZSt6YnFiWmJsN0RzQjBmaVdNRmJUQlI0Y3AreVZzdG5udEF5YWRSQ1Z2?=
 =?utf-8?B?NEFiUmROYjg4SXNaVUVBbFRZWENiTWZEazh4QkNadUY1NkFZMHpiMUNUYnNH?=
 =?utf-8?B?RElrUVRuaTZPaHdUamxNM2IyTEdwVUlTb1JPWXBRMlhtSDFNWHFrVDBwZ2lI?=
 =?utf-8?B?Uks1TzA3WWIxZEpWdGJoRGh4TVhnaWYrSzRpWmVrK0dLRXpkNWx1V2U3bnhW?=
 =?utf-8?B?a3NlcFZodGRiQVNrWkxKTmNWS3dLVUh2VlVNejFrZk9zNzVVM01PSEVFTGhm?=
 =?utf-8?B?b0diQWxVS0p4cXZ1dk41UUxYNTh3Y3JaQ3QybUR6U2lpbnlwSzhCa1l1S3ox?=
 =?utf-8?B?eW9mSGMwNVhXd1ZETDRYVFRLNG5mRklmWGttUUpOM3VhcCs5SE1uZW5COG5X?=
 =?utf-8?B?Y2NmQlJnSkx1TktkTGVPWDJscHl5TnJubmkxV216RUJGQmVGeUhNRWI3Q1Fy?=
 =?utf-8?B?b2xNajRiUWRoZUFadnAybUJEbHNtTk1jOTQxbjE3MGNteit6eW1EdmlnM3Fl?=
 =?utf-8?B?SFdVTVRlcDZlTWhRWlFkUGQ2dlgzenRmUXQydS9RcUxVdCtMMEdDNmNUSkR6?=
 =?utf-8?B?bVpzUHlDcjFWY1ZQWGtYSWVwZ1I3eW51d2JBbFZWc0N2aU1Qa0FDblY4dTR2?=
 =?utf-8?B?MmNibHkwVTF6U04wa3ZvUmlsWWtyd3VVUTZLVDdVdHZMVzJTR042N0VLSUxw?=
 =?utf-8?B?WXpsOGYyNzVEcFhabUdVeE9aTFBJa1M2RHpvaFVxTHBIWXI1M2JSM0s5ZElj?=
 =?utf-8?B?bHUwZHRaeFpmMVV3VUNQL3VxL0I5WHVPSDFWTVhndWlXZXA1Q0E1aVliMjBl?=
 =?utf-8?B?M3AxQXQzMmlEVmRvVko5WXNlVFV2UExaYy8yd3VQUER5SmZBMm9oanlNK3Zt?=
 =?utf-8?B?R0xURDJUSS9xcHBCL2VLLzVaSzc0aFk3d2RtSGFBeVhuNjBHODJnNmo4OGZM?=
 =?utf-8?B?aXBXOW9LSituUlEzU2lLZXo1OVRkTy9XYlFuM2ZvTGZtUWEvTjJMNkRycVRo?=
 =?utf-8?B?US9KK2I2SnB2L29zTXB3R2xydG9pUlpJOE1kNnNML1ZrMDVWOUdGaFMzcjQ4?=
 =?utf-8?B?RkhIQmpLM2tzeC9GTGhSRjByZjE3UVczM3lBVmlCRHpZK1prVk5PMzEvMWxt?=
 =?utf-8?B?YmpSZ01lUlo0bE5nSkY2Ym5qd0wyNVNoMno2Y1NzM0hMUE04Q1I1aGcvb0tW?=
 =?utf-8?B?QXV0Uy83Y2ZwZjh0czZPUG1Mb1NQTW9sdGZnbVMxOGZKRVVsUnNhQjVNUDdC?=
 =?utf-8?B?SDJteFExa0NBTUhBVFZ0NTh3bHU1UjJvNFQ1WHdzYlIycCtRYlJBWGN6TS9K?=
 =?utf-8?Q?eYoyRU8kmsPytOItkyWaelL3q0S95xVHDfEYekeudE=3D?=
X-Microsoft-Antispam-Message-Info: L02jrc0+3CS9shbF3emsQptgbr32xKzp0+HtKdGhtZuW4GTzuCJsZDjzGD4LTbbHxCOR698hS6uitqcZOPf5S5ZZFHkrovfy8CQKh6IvDTlmpzU21AVAHDLt4V2WxeQhdL0i90pG6TaNNq+wvxjeeB+Dqj5yxq43tZ1OvflM+QZYZkKaKrJbBsfs8U4Ws47G
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;6:CpDTEJt3YjUrUpY/epMtImkYsRQiL3WtdfBzUyc5AgwJdKiHKH+kzKIjrlTGBVfdUovAVNenefYygNGARZCNfHvjFw+TeNQZOypCrXvs4f9I7n0RkNijw58gFp6se7LT0kRXDQoFQ53NeYitrm3BtyOvTzkD7rjGo/x83o7UIEmzHHwv3wdD1eeRAisfBtrcRk325ChNnoxRJexjEqyHf1Q20VuQ56PUxLHBPDIx6WukGxGSzF/+V9mUDC6qe7IW8raBCGTk9KDfIXdiAzT9WUMpyrs6Ws34Dy+qp2JHp7qDRhOYDYj8+uGHtWTe/S0JDiHHNjANXPlVce8edHsRjmW4Uph1Go3pDwUz8Q+UhFX5sGnEK8zo/Tfdh6ci8zEHs9bdb8SDUXHXZC4oISTMaEw1Q45Hl5X3FBov9TloT73uhRgsRvfEbTR6RSTYgjPZOxUMS57bhB9BAXO4akQEyQ==;5:EtiqBTxA1OQWIDxFF+pLelvKuFj7wL67OOZ+Lax4wVfzveyHGqFmI6uJUJS5cDo83aHmkt7pcSiwwWFclD7eDxYb6q9T9xhRuvK5vnEdo0zBluqvgntPa0+B34B8vOJRx2yU38Wm+l09mqvfSnP/vyWRzEBW2lokq0+QRQ0HYuY=;24:j5KcGAoS1cPUxpgMqPqMVwNptrBjx9LW6gxw1o6LZDLbKZIxka4ccTrNIfiJIYWHO47gwrXsFYBwX3suD20zxsWlNvaI4mwVVLv9z088kLw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB2367;7:HD6DzK++sZxvMfJWKeE6foVJvshHhBUa4Du3N3JT5HLONg0IjX0hPKJSv73ST0NmQRqy8vemBcCfQV6YICeMIVr3dFwFQVPDv9pKk0mmeUJllOsuOLNY4MEApuoHGbmC52NDlp/4tKBBcOcAA/mpJyAorPcaPabHA0XENOq6Xahm2zrvmMrMA2eP7hP+b5L3YaRWslcNn0zivbDQXNrDLVNUHUEnVUvRSXJsujES0OZlNFaG2ektnoODd0EB1mDh;20:vPdfEyr0QTKFY32yiFdZu0sdB7f5tX9KIfL0FwVVcBuohK4qhLyEeF9aLAzyZwt7xoI5ZmKnDvdw9XShsiJHmvumnw2ipRMEbYF1zQwZQvDDAHDx84GuZ7FaM0JPHbK3wKATkg10Y8/unED+Y7U+q1cZ8kuXdiniGy0ceL7DqT4brov7dMU5wBGrw0EGCF1gzu3x7JygMLttQrWEsVt5Ym4wss3F5V2T3MqgyhD/mtnjLWfQsYV/82Bh3GErON67
X-MS-Office365-Filtering-Correlation-Id: 2efe1481-2ea9-495c-aa14-08d5af704cb3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 14:31:57.2708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efe1481-2ea9-495c-aa14-08d5af704cb3
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/30/2018 9:54 PM, Pierre-Louis Bossart wrote:
> On 4/30/18 4:23 AM, Akshu Agrawal wrote:
>> Non-dts based systems can use ACPI DSDT to pass on the mclk
>> to da7219.
>> This enables da7219 mclk to be linked to system clock.
>> Enable/Disable of the mclk is already handled in the codec so
>> platform drivers don't have to explicitly do handling of mclk.
>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: Fixed kbuild error
>>   include/sound/da7219.h    | 2 ++
>>   sound/soc/codecs/da7219.c | 7 ++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
>> index 1bfcb16..df7ddf4 100644
>> --- a/include/sound/da7219.h
>> +++ b/include/sound/da7219.h
>> @@ -38,6 +38,8 @@ struct da7219_pdata {
>>       const char *dai_clks_name;
>> +    const char *mclk_name;
>> +
>>       /* Mic */
>>       enum da7219_micbias_voltage micbias_lvl;
>>       enum da7219_mic_amp_in_sel mic_amp_in_sel;
>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>> index 980a6a8..aed68a4 100644
>> --- a/sound/soc/codecs/da7219.c
>> +++ b/sound/soc/codecs/da7219.c
>> @@ -1624,6 +1624,8 @@ static struct da7219_pdata 
>> *da7219_fw_to_pdata(struct snd_soc_component *compone
>>           dev_warn(dev, "Using default clk name: %s\n",
>>                pdata->dai_clks_name);
>> +    device_property_read_string(dev, "dlg,mclk-name", 
>> &pdata->mclk_name);
>> +
>>       if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) 
>> >= 0)
>>           pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
>>       else
>> @@ -1905,7 +1907,10 @@ static int da7219_probe(struct 
>> snd_soc_component *component)
>>       da7219_handle_pdata(component);
>>       /* Check if MCLK provided */
>> -    da7219->mclk = devm_clk_get(component->dev, "mclk");
>> +    if (da7219->pdata->mclk_name)
>> +        da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
>> +    if (!da7219->mclk)
>> +        da7219->mclk = devm_clk_get(component->dev, "mclk");
> 
> this looks weird, why are you using different clk functions depending on 
> the existence of a _DSD property? Why not just change the name and keep 
> the same flow, e.g something like
> 
> if(!da7219->pdata->mclk_name)
>      da7219->pdata->mclk_name = "mclk";
> da7219->mclk = devm_clk_get(component->dev, da7219->pdata->mclk_name);
> 
> 

We can't use devm_clk_get as the value of dev argument has to be NULL, 
which can not be used with devm_clk_get.
System clock which are linked to mclk are registered by a separate ACPI 
device. And this exposing of DSD property is for all those platforms 
which are non-dts based.

>>       if (IS_ERR(da7219->mclk)) {
>>           if (PTR_ERR(da7219->mclk) != -ENOENT) {
>>               ret = PTR_ERR(da7219->mclk);
>>
> 
