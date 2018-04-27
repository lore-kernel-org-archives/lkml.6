Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757360AbeD0GK3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:10:29 -0400
Received: from mail-sn1nam02on0066.outbound.protection.outlook.com ([104.47.36.66]:24736
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeD0GK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:10:26 -0400
Subject: Re: [RFC PATCH 1/3] of: base: Introduce of_alias_check_id() to check
 alias IDs
To: Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Alexander Graf <agraf@suse.de>, <devicetree@vger.kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
References: <cover.1524751696.git.michal.simek@xilinx.com>
 <6045807691c310ccdd57ab16524b7525f26a1dc1.1524751696.git.michal.simek@xilinx.com>
 <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <ba081812-f532-5ebd-b052-cdeb1f02bff1@xilinx.com>
Date: Fri, 27 Apr 2018 08:10:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+69p1GstFua1-27LGv9MKT8dtbd1ytcq+GuvQ=VcEHKg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(39380400002)(346002)(2980300002)(438002)(199004)(189003)(43544003)(6246003)(316002)(81156014)(9786002)(31696002)(126002)(65826007)(5660300001)(6666003)(229853002)(356003)(230700001)(305945005)(86362001)(186003)(44832011)(446003)(11346002)(26005)(76176011)(336012)(81166006)(426003)(2616005)(476003)(2906002)(23676004)(486006)(59450400001)(106466001)(6346003)(63266004)(47776003)(36756003)(36386004)(65956001)(8936002)(4326008)(65806001)(2486003)(478600001)(77096007)(8676002)(110136005)(64126003)(31686004)(39060400002)(50466002)(58126008)(54906003)(106002)(53546011)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB2044;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT030;1:loDQaX+0m5Wrhe/q2SVqZPBPjxuhpLFm1DIeVuVN66zp7X5H/KJ9UUb5KhtgvSX1yUR5b0b9Yw6hl4sbtTrGsNUUvPsH3MEQjiKD7fQ8ygjDN8YPZT3kmoPttqj5fYQz
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY1PR02MB2044;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2044;3:wRhSmXa+OnJjk7T4SuUzbGqcyixYcuvH1aiaSsUkNFR8pwMtEzzJjc0Bj8t4MLcOFE9EJNjLiArX6vVULCfAk9rd1C+YKXpWbikmoYYmeXBiTNJdj6KsQ/l3KBylFxBeMAjzpfXlL5M304PUb76AonWWOYoYaowPrHQzwpuIZpaA1fkcQWBf1ljXPMJZoKDBkG6/q9IZIB/rRKTXt2aE5c1TBmeVKlliOk1FAiwXSKn74AIRoeR4fiwNVLTJoJKKzs5e3HXeHV+G5z800P5hSzr18uk/jGQ0cYBDI4IwlXoHfTVWu3JBx9JkRDz4zX7XA5v1tI5TZgSeqgu8caLHu7ai5D3SrZmuwSUt22Alrig=;25:lOoHevHbn9RQoR7cNqsg/W7n87zVIoWfHEFbGyWuOKuKfzEhjhEj6vZPxqAWSCL9sS9G2HxOZsIRVpdzRqXn/Ygc+FUSa0j0+wFkpmGAqE8MOlZ+9J1y5DpjAjAT2RBNXuWaeocc1BjAdGdDZKVfp88DvC1oUik3CFj/XNApU8dOn8G+rp8pw8BpOvSbLVoayCichBXDlcZNACpPzKZ2RL+Xqm3qdm8LchIDK2TIv2/1a2EYyI9ZyTf5OTHEGClIOtFWnTzbGZkUiDDNnu4u44UF1Fe7YLD1CeSmNFEvyE5nzS7OmSmFWdvOgG0QdUpJL+Bm7a6swEc/XWOkhjzDyA==
X-MS-TrafficTypeDiagnostic: CY1PR02MB2044:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2044;31:tQPqo+O370nkz8VSKvbP0rbdVKYm2c9ViQSHPMdWgNqZZazKQHuSVj3B8BLO/SRkNPDYqYl6JtXeh/JmYrRz89Zith6xjTygXG9/LBaLi9Z5DILuzf8Vwj+Wjat52q9aMRsxPc19XfqzSTMEFaauIC087/iFj96iwqvztSlI9D3sLeTJm1z7X39AHrWTVeTpe1NpmcLJe5ouXyG1bEnoKZ1caokLWY5xwMXuZaROkIM=;20:GtUZ/25VQP8fT7lOxHxXtAWPqHkUsi/hCV0l1jkclX2IsU/oyw4sZp9i5D/hITUzw6N2svRhlbxPl4M6Fgt2aeoyr64WMFXnVBAoFOgA3VPIoYKXdrYYXcaYv1rsWSMdBrmNwTvoJdmoK9i4NNXVLGMnpsgrwKcMPd53iV9mEojrzzxMiddSjOtvCNJEnGOzfV9cfEKf8qZoDKJs5dDgshX4e+IFbME5RspYsRoLVbRE4LePIKd3o7QODQEBzLHT/wMI7Jfm47TwUul4T43emIJWgDwecrQMaIXIHXaPNVDt9bVOzKL/AEhDWiy4MIrxPupswl0s2l7jWFjHFJQb+rYWBg6CNBVjcpwouPsMOZpVLv4sXLKOI1V6Uk3C7MW86vrqT/gk+ci+5qlzeazhbzO9d6TB3Yc2soJSudc0j6xFTjPUXFGt1VfCEroZeQHc5rneNPXJR5XjUOkNRAylWJRC4jSq0N0SReATIm3QV9t2iANtbdtBQyDVROy5JNR5
X-Microsoft-Antispam-PRVS: <CY1PR02MB2044D1448C8040C6812B669BE28D0@CY1PR02MB2044.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93004095)(3002001)(3231232)(944501410)(52105095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR02MB2044;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB2044;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2044;4:QANKND7/cpQotID+NKG45x8zz9ionFTcKaFDF1bze0DyyFZ5OdOiEi6/ECnwcL49U+uUfb3xtOUdJrIAuYldyyffdREO13/txhzLQMrtUzKkCcL3lBGGLr+8ApGG7TPZKfLvlSwwiR5y1dOi7OKV0ax18fYed1DzWMK3zHtMRMCz0esPfAWEv0RehMMS5iRg99kzrlzOtJYhVtiNzBjbX9aeH8F4Hh2KqY2XntOz4iQEZ9xKJXA8GwcFctfxQSdrhDgayTVe2JWL03DRvFrDCgBT0qV9oB+NdDQRG5CN7h4CIbJZz5R750u4xzCk64Rc
X-Forefront-PRVS: 0655F9F006
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIyMDQ0OzIzOmNMMFN5SGh1QzdnanB2eTRudzFPRHYxTko2?=
 =?utf-8?B?eVgyK0g4ZU5TTlpZR1oxTkNzM2lCYjFBN2xhV3pLL0tLNlBmSDVxSUJDdEtQ?=
 =?utf-8?B?WlZuNlFnbnlEaFRzSzFIUnJacjljNXFaNGdydUNBVE14SFptR0piSDdmdGt0?=
 =?utf-8?B?bEpIeko1MXNsMGlGZDl3cXJPTmxoRzl5WkM1QTgyYlEwQkVlY2JaQVZHMEk4?=
 =?utf-8?B?T2JsamU5NVlrVlhzMDJUdHZMckhiZ1VTUUt5T01ROXJqaW1OVDA4eEp4TUh0?=
 =?utf-8?B?bWs0UHFydXlwTWJyeDRablVrK29ISWFRRWZkWExOOGdKQU5Yd1g5R0g2Y2pv?=
 =?utf-8?B?NEhWT2xaOWNSRE1LQVVqT2xIUGNhbWcyNnNxeVF5WWc3NWY4eHBJZkl5QVA0?=
 =?utf-8?B?M0V3dFAvTjMzeW1VVXczSXJ0UU9JVGk5MXJvbVNXOE5xa3N3cWlzeU9tTksy?=
 =?utf-8?B?bkxNM3l3ZHp5R3FYcGc5bjk1a2RwdExoVW5hT1NDMHl2WkMySXB5bzFzekdJ?=
 =?utf-8?B?NjRoRDA4cU5oWUFwK2owUC9TQVlyempKSzlHK3BaWGtzR3FCOVFBOE5vMnJw?=
 =?utf-8?B?bHNnb2NmRWo0dzBicjErN2lRYVNXMTdYYnI2RFN1azBhMk96anlrN2lSQ2s4?=
 =?utf-8?B?Zkh2TkRPcnI2RDRSYXhPMjUxZUR0clI4ZVlBUFc3QWNRaXNiUERTMDJVWHZV?=
 =?utf-8?B?MXErK0krZ1ltOWl2NWZvRGhJcnYxZzFya1o0U0YyZUh4bVpvQ0VFejhNK0Ey?=
 =?utf-8?B?LytkNG9aUE5BUmFxUmROdVlzd3VvZWpoalpmbDM3QldMYmZndGc5cy9iZVo4?=
 =?utf-8?B?YnBPZUR5ZjNuMnppZ3pubXJJQkhQaGF0TjVUV00rNmNNT2x0Y0JjVEUrVXN2?=
 =?utf-8?B?ZExrRDRrSkM4L2hLUTloU0wxZWpFR0w0MHVmcjZjUE9XTlNhNWJqWStaVEVB?=
 =?utf-8?B?WndQNEQrTFZuOG0yckx5YVpXVS8yVWQ5THBabGJudHo4eHJaSjlOSU9IaEVD?=
 =?utf-8?B?OTZKRk1lbGZSNm9sSU9vRTRwbDNOQ25QWnNaRDhWRWZZL2lBaU5wWnRGREcw?=
 =?utf-8?B?VSt6bTRDd0Y3d3cwaTFmSkIyMUVvSm9CdFpBNDJiNlNJV0pGb0pmRmZTcnJ1?=
 =?utf-8?B?TERDN3RTOUcwdHJ2TWpQenovUTI4cklBb3ZNbnFDS08yOWg5UTNIc0cxZURX?=
 =?utf-8?B?dSs1RWxRMmhvMGEyRUJYakxMdmQxWVA5QWkwN0IwNHZrOW9TYjQ3M3VSOWRt?=
 =?utf-8?B?UEp1SHVVOStkRUNlOEtyb2tlYlY4MFhHUGFoV2xTY3lYcUdKTm1JdmpaWVdR?=
 =?utf-8?B?T1ZuZEw5Y25SVTRvZjYrdWlkVHMzUkFNbzhyRDFETjcrS2grUzhWQ2RqTm91?=
 =?utf-8?B?emw4VkRsbStscGcycExyanNpV1Vobkpya0NKYTlDWWJ6YW1aRzIxazhaYjJp?=
 =?utf-8?B?R1I2NG1DLzBxYkcyR3QwdWc2Y1RjTDRybUdTaS9GRlVDUXY5UlBINGJTVUZX?=
 =?utf-8?B?cCtsZG1uTFBneGtLOG1xdU9aVkIreE45L2lkdGhLc2hUUHBBSW5BQXlVTWdi?=
 =?utf-8?B?VVhKY1B4dE5uYU90L2JEN3N3UVVCVS8wV0l3c3JFUnRaRGhvZU5UeU52SG50?=
 =?utf-8?B?eU1JL0YwUkdYSHQvSGVqVW1FQktEZXJiaFJPM2ZTZGJldkVVUitYQXV4Z24r?=
 =?utf-8?B?eVJ6SmNKT0hJR215V2tBMWpTcmYzS0laY2NHY3BHRTJ3aTdtNWVadW15S1A5?=
 =?utf-8?B?MTZRUTNoU21rMC8vS2Z3cmhyeDF3VWdNNFN1ZVA2cW14dUdPcUIvL0ttY0NC?=
 =?utf-8?B?dUhja1Q1YjB5YVVkOUhBRWQ4VksrZzE4d2FLZEZTOTAvNzZyNGNEbXdaaWZK?=
 =?utf-8?B?QlJJNTdrQWRlQy9zaDJVSW42aFpmVGR0MUszamJnL0JoNVFTaWhmbWpZZG5W?=
 =?utf-8?B?VENUZEMzdy9paXFzMEhNckwvcm5wQkVobWY5MGRoUU10Z0xuUDNTTFFsblhE?=
 =?utf-8?Q?R9Oewp?=
X-Microsoft-Antispam-Message-Info: UgG9ojeyaD0XHXvTg5DfXwN5ri7a5Kjy8vnju/AWqQRraPy7hCqupgI55hWaWwMG4Q4+/PDdC5HaqoCT/z4AV6kN+mz5pHcC/hMBpISV3+qilAlA26EU0Mlhu2LhYSYPM4J5RxZE6Pyx78/24qA9X6VS5UVlOwaBelJsJtVbaEAPdqGLkq29UZPj+iC87/0R
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2044;6:j/UDgk1eHpNDmH69oVI1qRxbtWkz3zOHD/8ZoJlS9hOqJ2hxmuuH8tF+tp5+T1mI2YZwdk3PdTBfQuw87h51uM2lNyTtKjZIHNOqVW+af3VacmnLESwZOXIkEovQkCIDjBouD368On0kR3nKP0Z0sIfdW9KkgRGRgHaK4HiLiwmRvaqSDM9cvpyZF7jHNKcDFDGjWsWjsJ16lM9xr4ElNhzFYMAU2t0zFCCQbKnl0EQpq6rL16r8XqjocUNVyD2Pvt/UQtuBVH2Hd+iNCP8i+suNI5bXdsVKKGiKFUvF3nuhffHxdceBiMo1hhNEM97yNgsA5MmJTtI6guFN7HdR7PaKblcSSaWlmJ0aI3/PXkHPJf9QxAvNZ/bNSLNbuEidWG/KYHMbSOW7P9qZBvpGVvrz605RgGctyQBqYsJoTonAX0Utj4Mh8e3/u2tohygY6etI646GvM6Vb2XJmZK7Uw==;5:jjo+dSqmsUzmxyN6ECYsRtVdWYi/WM4kpDzGOUd9V2mU8QyLklJTW32GZ5RzXQrQxcm4wvdpbb8mU92h+Yjls1TfmEECiDz/CLC9D/EG1I7lqfVvEfgudc9Bz4nZGdPfHdCcVH1BGO7KY0iHsuxT2g8Ct/zm3Mke5rZ0/WBWFpQ=;24:snmwOQEG8j02cnH7Gp6T9UCmEVscZr1Ta716hPleVKHwPw4/dxfGEumeoxO0bv+IqZ/kRwUSCTRm52Aa452VHh2EqDDaxgkiBBeHMfLPhVg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB2044;7:/yVhv2egOpTAS72RDZzxdYn7HtFwYgIucfemkcaYFUG44zGOu+WjM1u2lNAY2sMNv4moAUcBMrzzFQgoaixRTGj5YW/i/DtC9YGr6DrSwwZtJANZXK7OlGeBDPZpCFOccL9QDx+a6MO4WMtK+AmCkb7cXv7aulRzYvB7Rxi+KL2EmM1U6D0hFrWeSTac6Jl9ZAaOGW3viPWblMwtiGHDpHCtofnDOcRjyzIDsck4TKLL5ZSnXj9shqbGwpv1hoyt
X-MS-Office365-Filtering-Correlation-Id: c5470cfb-7a76-4fe1-bf37-08d5ac058f61
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2018 06:10:22.0342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5470cfb-7a76-4fe1-bf37-08d5ac058f61
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB2044
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.4.2018 04:39, Rob Herring wrote:
> On Thu, Apr 26, 2018 at 9:08 AM, Michal Simek <michal.simek@xilinx.com> wrote:
>> The function travers the lookup table to check if the request alias
>> id is compatible with the device driver match structure.
>> This function will be used by serial drivers to check if requested alias
>> is allocated or free to use.
>>
>> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
>> ---
>>
>>  drivers/of/base.c  | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>>  include/linux/of.h |  2 ++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index 848f549164cd..382de01acc72 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -1892,6 +1892,55 @@ int of_alias_get_id(struct device_node *np, const char *stem)
>>  }
>>  EXPORT_SYMBOL_GPL(of_alias_get_id);
>>
>> +/**
>> + * of_alias_check_id - Check alias id for the give compatibility
>> + * @matches:   Array of of device match structures to search in
>> + * @stem:      Alias stem of the given device_node
>> + * @id:                Alias ID for checking
>> + *
>> + * The function travers the lookup table to check if the request alias id
>> + * is compatible with the device driver match structure
>> + *
>> + * Return true if ID is allocated, return false if not
>> + */
>> +bool of_alias_check_id(const struct of_device_id *matches, const char *stem,
>> +                      int id)
> 
> Wouldn't it be simpler to just return a bitmap of all allocated ids
> that match rather than trying to build that up 1 bit at a time?

Is alias list stable or can dt overlay change it?

What should be the expected flow? Find out maximum number of aliases of
the same kind and allocate bitmap and return it with length.

Anyway if you look at that patches I sent then I call in the driver
of_alias_get_highest_id("serial") which doesn't take care if alias match
with actual driver. It means having information about max alias ID which
match actual driver that would be helpful but I am not quite sure what
should be the flow.

Any link to similar function would be good to understand how the flow is
supposed to work.

Thanks,
Michal
