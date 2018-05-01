Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755434AbeEAOlY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 10:41:24 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:56842
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755171AbeEAOlW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 10:41:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Akshu.Agrawal@amd.com;
Subject: Re: [PATCH v2] ASoC: da7219: read fmw property to get mclk for
 non-dts systems
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: "djkurtz@chromium.org" <djkurtz@chromium.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "moderated list:SOUND" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525080203-18947-1-git-send-email-akshu.agrawal@amd.com>
 <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Message-ID: <f541727a-ff8b-8945-898d-3d331f2762f2@amd.com>
Date: Tue, 1 May 2018 20:10:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1E93BC@SW-EX-MBX01.diasemi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [106.200.239.203]
X-ClientProxiedBy: MAXPR0101CA0065.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:e::27) To DM5PR12MB2359.namprd12.prod.outlook.com
 (2603:10b6:4:b4::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB2359;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;3:g5OZqfg5uZIomybNradjUQcC0AcL4fJnDC0tsyFhHfWK8IkVXplL7ZVKKZaK/uBwEgbZysnsjcaxRYm/sE6cbx7DX6QfsFo/VaL1Rb/3o6P5BeOZmBbdjhqS1v+YctMfoM9B9YS/ZAq9k3OLgqnohyIOC9KdglEqdpEFwAvZe6c+Ag5xNiOsnieaZn6tiHK5sTCvhdax5L91Qlr6rv6+jZV7B4Qv1SHaxDw4mkNuKUd+FSQDr84Q54v1TJ7KMHgN;25:WFvF1Fk5/Di4M0fQlbc++/IzU/y3FksIZ0fWtccEijfMMPimwKHNr+I4S2KPz/HIE8c60pmiTfY1ptiGSPwBHA4TnjLJgOq/Nd/gzZo8RdXFUOOJmMi2ksKx2phcgPSAPQO+pdF4+1+hCaZzvxBxKmWAKwbF+Pq7xC69PIXvs6JYaLn1rxiLKS2Dc6ZShvl0KIKxNvpUmjFsJQZGZ3SA9rMQQcBRYOeakU9l80JDRcaHEN+GEX2alGxdM07YEw00Yo5X7RWFd7LKCucAFa11diiUo7SL8IxvgF+LdVyax2iTRafUg3HIMC6KSjVpTWkUSLL+zZ1DkxV7bmZhSDSDgg==;31:kacySZzRObyBeZ4YngOpuXWOUq7QUaZ/ZM5S6Wc6OjT29Knk+d1Wk07wTbdCdwKJ/2DJzZefMpqI+EL/i5r/i6pxRtwPIVVXRbpR0sTMl0wx151DpRFDi05uwE5vOGvrkdHXg/mCTyQ34emI1t7KiJKomcF8AXlMoxttcdU33ktPjr7cUfiqnyHfbggb3pde0b2xaAn3B3UT7hLdyYR7Ms53ks2L7Gj3iqdzpiLkWws=
X-MS-TrafficTypeDiagnostic: DM5PR12MB2359:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;20:OL7GjCbdTpz7jp7k0NTnK0aPu3Ie3Olbv/GfdQGgzJq936DtUiSq8lklmQ2qwjjWV1wwblj32kzAtwb49pxkFSByJuGnxZqSpERrfoSPiUgtN2EEOSoBoR3wX37ikvYyBJsDIQGHQrZM8NkZhmJB7U8ZxAzNGzjn7p5Z87B0aDcFgDsD18pXVZV3zdsUVn1fSgv65Hsp156FxsfhoF0Hn1gs4bYIFf5K4Irwok0wVaQA+efOjZSodjPG+otJY5P+MAubdR7TFVeXx0D77xkJP8U2Z0LDw2UDBEdfjqsfABLS0x5Og+XQCMxWbyw3IPiUiI/WKVRi77ItT8vP8tlhxBPCrS8176YJ+HCFCJbHq/OoQfvUtXJPiZ6/3YZBImdgXEp6ITWmYSHhSHdrTHE4WJ0n9h8kr346dJD80SdpKEHULr6f5y5pokqaqzudDj4ks4ENbw8oumXuxQsfJOfhq7ln4CLFeS/SYM1tfvGUkATFCuxg+KqH16GUoCmPr/bY;4:Wj8hrut/KXjj1AGBPP4KjcPF1GL07Uk73SzIFIpGt1BIT4VJ4dQA8pctiZe/jwUfzxpbTHIUUTq9TCd/ehOKWfq3Ys44lEw2+UcEN+HaEXGAezLoEbhco7uQWU+jw8m5UqRSQZFKlz37CjD7gbCcLA73ID2uthpGCbZNskmeqhbKl0OR+hoPwb9zn5Rw+YeuTLBYqoHCmoZx63gkGFdRvgUufTpNU3iGTCEWR/7FXbvE0K89SzoGudT/WsQntL1Wgds+By2fhrBjTdjQF4Ry0ptE+KUTr0EBugkLHoXyRh+KaH+v5X+HRpERN1L23sNN
X-Microsoft-Antispam-PRVS: <DM5PR12MB23593B067EF68018406F82EFF8810@DM5PR12MB2359.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB2359;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB2359;
X-Forefront-PRVS: 06592CCE58
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(366004)(346002)(39860400002)(376002)(199004)(189003)(81166006)(5009440100003)(2486003)(478600001)(23676004)(106356001)(52116002)(117156002)(386003)(486006)(67846002)(97736004)(6486002)(186003)(25786009)(36756003)(59450400001)(66066001)(50466002)(8936002)(81156014)(5660300001)(72206003)(53546011)(16526019)(3260700006)(39060400002)(65826007)(2906002)(65806001)(8676002)(65956001)(58126008)(3846002)(229853002)(76176011)(446003)(54906003)(52146003)(77096007)(64126003)(47776003)(53936002)(68736007)(16576012)(31686004)(6246003)(6116002)(316002)(11346002)(230700001)(476003)(4326008)(105586002)(6916009)(26005)(2616005)(7736002)(6666003)(86362001)(31696002)(305945005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB2359;H:[192.168.0.103];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIyMzU5OzIzOkNQSHk5WlJZdStkVmdDSk1iQk1WUWtwMjFQ?=
 =?utf-8?B?SDVTbU9WNmFOekRwMWJ2bk9ad0dFSnBiWXRuVVkySUFZMVU1OG5UVWRHSVFa?=
 =?utf-8?B?TFEwWm5qZFQ1aGlnOVBiMEF6a1Mwb3dGbWFvYzJaTGFBZ0xFdXRoU3FGelIy?=
 =?utf-8?B?MWFEYjlvNWdvSXlIUHUvNyt2c3NiRWxNQkp2alNqMlhGNEk1M1pLcGRsZlg4?=
 =?utf-8?B?b1BHWk0xcFJVRkUweUJGbVpDS2toUXJIQ2FISFBOd0JTVElhdy9qOVlOTEpv?=
 =?utf-8?B?NXMzczBnZEFVY0kwWjdLSU1Md3VuTHBjb1pINVlBcU5BTWVlWDJ3VEZzMmNN?=
 =?utf-8?B?ajZKeDVqS2FrNjlzc2JjbkR4QjRGZFdhaXQvUVIwWlZTcUFESzhjSWU3RnFw?=
 =?utf-8?B?Nkk5dURab25RR2cxYlAwWnBONngrbzFtWlF6SWhYcnR4cTd1N3hxbERnNVF6?=
 =?utf-8?B?eE5xT3BkWmd4REE2NUo2N1ptRUwvdFJUL3VOZURuVDB1djFYaml6L2pXNlcy?=
 =?utf-8?B?NmJIdnlHYTVEcmplb1pJSUpacm1XR05EVjhiaFRLUnVua05uRWRFbXR6STZm?=
 =?utf-8?B?Q01SQm00cERMam4xV3RrYml4cDExeURWZE1MRnYxQk01RVRqM0J1Q242QlBT?=
 =?utf-8?B?R21WeFNKTUtyL0xiaGxNYmZkVWZ1dUpOTzk4QVg2ZUtsdVZNb1JtV2h0ckYr?=
 =?utf-8?B?akc5cHA4Wk05TkIraDUvb05sYlFRdVo5bGhIYXBNemw0dndoOFFNbzF4aWcz?=
 =?utf-8?B?bWV5NVJnWDFQakQwYzNBMHJwbERSSDRwWGFRNFFiNG4yZWNhMkwzVW45a0ZX?=
 =?utf-8?B?bGt6bGRBUkpXMGRQQzRncUZtNmJ6TWl1NGxWNzBmRUR6NWVDNHRCZStUZmZ0?=
 =?utf-8?B?aDc5VlJydTJ0c0VPMHEvVllzOTlJdkR5cjZhL1VpalhVYWlZVGNOaHR1SUJs?=
 =?utf-8?B?TkNJOEpEOGdhSWJjZVUwNHJFOC9NeFFuSHVqRlR5VjF6L0I5czF4eU1ValhY?=
 =?utf-8?B?cE00bE5qUzhZZFpwbmw2N0U2cElxejVORzVaWjRwUlViMDlqdlZZbW1PbmVM?=
 =?utf-8?B?NFpTdUdOclBaa0hIWUNTYVZvejhXOHpocm5ZWTdZaUd0Wno2Ny9Za1RCdG5h?=
 =?utf-8?B?OW9sVk52YzZWQmt5bEVuazMxWFIzekdpMHQ4c1FpeTU2MkZhZ1NSSnkraDBS?=
 =?utf-8?B?N3I1NHVSZ1pKWWprT0V5NlRITE9sdDhNSWFKSWRjTE0xOW4vVktCbHlkOUI1?=
 =?utf-8?B?RE1ha3NIaWQ5OU84bmVjZmRIS0ZOT3FFV2tpVG5MbmNhT05jVVlONEtEejl1?=
 =?utf-8?B?djF2RkdDL2tId20wK3ZUN3o2WWFsSVN4M3ZTN1hOWm1ZUXp0NHJlRnQ0VFdp?=
 =?utf-8?B?cnFVbzRrMXVMLzlQWkd2ZFI1bXJZeUZGcERVelRmUTh2M09JTW1NRTJCTU8y?=
 =?utf-8?B?c2l0dnZmWDVLYUVSdWZBaURWMGRRYWZQckZFUm1wN1p5U1RPZHFYL25ZQjVH?=
 =?utf-8?B?Z25hN00yNk5kOG9jNktUMVZQUzh1ZnpWY1hZUHVJa0VKcVdDbENZMENLb1RR?=
 =?utf-8?B?ZVpZTDkzM3Nja2JXK1RIQU0rdDR2ZFhKaSsraEFPai9sSHpYazlNcXlWTExS?=
 =?utf-8?B?ZE0wbnc5L2h6cDJYYWR1RVdubTZzZUFmNjUrUDZrT3ZBdnNZbEUyV2xvN0dQ?=
 =?utf-8?B?TFR2VUVlOVVzRW14d0pucEFQblROZ2VQQnplL1hNeExVL1E1aFI1MU9WdlYv?=
 =?utf-8?B?SDBaNnh0VnFDelFVcHpNUVNmWGdPRTdaTWl2bW5DbFUwejNPbGlub3piRy9F?=
 =?utf-8?B?K1hXNC8xTVVwT0JEMjB0NmRrM2g3WUY0bkN4bWMxVDZWVExjR3lyRGdQOEpP?=
 =?utf-8?B?YnhHL3k2bnM4RnVqUmRIcDVPYkgzNzZDeW16a0M4NUZheXpkVnFtcGlUT1Qr?=
 =?utf-8?B?TVNpU3VrSXBvaFN3VlZJT1FlVmhVNkZYYnlzUVIyWjdMZ1ZhRWpsc1dxcmZw?=
 =?utf-8?B?d0IwL2tLK1lSN0JEMFhZWE42a0ltY0RsVC9rR1A5R2xnV0dTeU5HZFNFWmdl?=
 =?utf-8?B?OGd2NkkrY3RMYjQxK0dGN1greEVBOGtvSkg0a1JsdEZyVmUwTHVUWVRQS0tG?=
 =?utf-8?B?NzMzakk0SWNCNk1nZGlCbWtVT2tRLzhjM1o3YTIvMjVDVUVNdWdpOGlwRitF?=
 =?utf-8?B?eE9FWEpKWEVybGl0VTJOUElVb21BPT0=?=
X-Microsoft-Antispam-Message-Info: f2uJVUvMvBMK1Hkz6/cPx5TdtMvThcmrKYynFhrtLO8IBDnyEfOzSbs4I1Wn77THg7Pg0eVHhnaSrfrh/KakAdyZwZqwnAKFJOPKg5PXE6fZo+TGSwjTfkm3EKbDjSxcMQkMYuLjz2Y7PuOAFvxz3FLU+cECi8Jb1gTYUOY4ocPhY+65KJvj0UXUeA8LJfrv
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;6:D8TaWLIGvLjjBmazNR3nTFiTDam3tp0wJGaS16YeUfpZR7nqLGNHGr9T4vtDL6VYk74UWAt2kmWIvMbn8aUWaSXqvmjWCasLnYkAA70Ci2E+SmRdhoWpL9AV3l/TkKwcv76m8SJI3jPhaQMnQb/IPe+uoXPfth2DEL/XkrnE1E6KbgzVRWsxozqsSzeCpEeAVphnNCsIPUD99cgWLGML/rIHg1BxjsXANbdMdXjQqLiF1kxR6ZbAMwpC3YrtKzytP9+fENPl7kX44YfrBt4/SDG09bLF1t1Tbo3UZAjupGd+MEqODPurmt3BKGXVfGUZUY3wZUQeIUXlAwSDT0tE+P2RpKXs+OeGjCgnjsGUJ8paOm7CL+vc18LqdwTIVGetLa+OQTyuSSxjPnih/Fn5YDIA8KhCfl6jxTMvnxfjQLNl/mBJRF2VhrgI0khmAm7cXq1lOScReAQ381lCIIJvvg==;5:0fjL9BS4zMAqZH4T7vtnUjo2mZP0CyMA7eSxD3rzMuM9eQWYyxcdk4i8aUL/5w/mB2URshWx2NzzDTJIBOYKzFHwCKhPUOFbyyoYdkif2VA1k2VltMWaPenqIBeeRpMYTpyndgnSUT/8IJ/L3BQqZbcINiZKbt5do8JclM0qIYc=;24:FMkj9HJQcYHwbCgydeSYe58GG6oJeBfBvYq3MBIsZV211CN0G35KPNnkySRae3Ps3/eiaxe+NGxl4nJdfnmmK9itnvDTubWGphAPyZnsEJ8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB2359;7:XgbCw3h23kpCBBCXkzGIKFO1oaAvi2OBqlgtRRIRmwOtIR/BWsw1l+2iimbU2qFvvFz4Vsj/vBj1E1Xup/If+FfXsz2CpDPf1O+Vvn+iGntu2+wmhYQi2Trfuw1EvzAMBVtho2lsrxLJPyv783GTOHSCD79qMnzevY0JpIAWj5kJ1oJvgvQay+0P5xYjtcLhWAapwe1jh5IsgQ3Hf3hNElsLcAUGvJLAIpp6BrN8a8jhsCw9myQPEGpxSaOX4YXN;20:ycTc7Sfh0aZ+KmH6rKP01SlcYCIlFVulVFkZIeVhJtoPLy8q9WYB+iCJOsb8z/EmTe+hrrHFYIKBfu4KYxLDHTkhRIewQ+sSGwVDaMWyB/1FLkpHoJxP7fn8bJznuIPNeNdMcpsRl4WPLPDddAxLCbanLll2YvTSj9vW5YlK8a8meClQOoUEQGok+thJ9JnXLPicfs1X0cdLalNoJ4NXlQLaYqnQ3jFcnjsqccqLjakW6blhLbN3QOBlQ74N2lfC
X-MS-Office365-Filtering-Correlation-Id: 02277a58-6213-477e-d9a4-08d5af719abe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2018 14:41:17.4063 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02277a58-6213-477e-d9a4-08d5af719abe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2359
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/1/2018 12:35 AM, Adam Thomson wrote:
> On 30 April 2018 10:23, Akshu Agrawal wrote:
> 
>> Non-dts based systems can use ACPI DSDT to pass on the mclk
>> to da7219.
>> This enables da7219 mclk to be linked to system clock.
>> Enable/Disable of the mclk is already handled in the codec so
>> platform drivers don't have to explicitly do handling of mclk.
> 
> There is already a means via DT to specify the MCLK for a device using the
> generic clock DT bindings, and this driver already uses that. Should ACPI not
> have something similar to that which is generic, rather than adding device
> specific bindings/properties to achieve the same? There will be other drivers
> that will want to do the same.
> 

IMO for all non-dts based ACPI systems, DSDT would be the best and 
simplest way to link system clock to mclk. Currently, machine audio 
drivers handles the clock and this can be avoided by having this property.

>>
>> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
>> ---
>> v2: Fixed kbuild error
>>   include/sound/da7219.h    | 2 ++
>>   sound/soc/codecs/da7219.c | 7 ++++++-
>>   2 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/sound/da7219.h b/include/sound/da7219.h
>> index 1bfcb16..df7ddf4 100644
>> --- a/include/sound/da7219.h
>> +++ b/include/sound/da7219.h
>> @@ -38,6 +38,8 @@ struct da7219_pdata {
>>
>>   	const char *dai_clks_name;
>>
>> +	const char *mclk_name;
>> +
>>   	/* Mic */
>>   	enum da7219_micbias_voltage micbias_lvl;
>>   	enum da7219_mic_amp_in_sel mic_amp_in_sel;
>> diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
>> index 980a6a8..aed68a4 100644
>> --- a/sound/soc/codecs/da7219.c
>> +++ b/sound/soc/codecs/da7219.c
>> @@ -1624,6 +1624,8 @@ static struct da7219_pdata *da7219_fw_to_pdata(struct
>> snd_soc_component *compone
>>   		dev_warn(dev, "Using default clk name: %s\n",
>>   			 pdata->dai_clks_name);
>>
>> +	device_property_read_string(dev, "dlg,mclk-name", &pdata->mclk_name);
>> +
>>   	if (device_property_read_u32(dev, "dlg,micbias-lvl", &of_val32) >= 0)
>>   		pdata->micbias_lvl = da7219_fw_micbias_lvl(dev, of_val32);
>>   	else
>> @@ -1905,7 +1907,10 @@ static int da7219_probe(struct snd_soc_component
>> *component)
>>   	da7219_handle_pdata(component);
>>
>>   	/* Check if MCLK provided */
>> -	da7219->mclk = devm_clk_get(component->dev, "mclk");
>> +	if (da7219->pdata->mclk_name)
>> +		da7219->mclk = clk_get(NULL, da7219->pdata->mclk_name);
> 
> By doing this you would need an associated 'clk_put()' whereas the devm call
> avoids this.
>

Agreed, would add a corresponding clk_put call.

Thanks,
Akshu

>> +	if (!da7219->mclk)
>> +		da7219->mclk = devm_clk_get(component->dev, "mclk");
>>   	if (IS_ERR(da7219->mclk)) {
>>   		if (PTR_ERR(da7219->mclk) != -ENOENT) {
>>   			ret = PTR_ERR(da7219->mclk);
>> --
>> 1.9.1
