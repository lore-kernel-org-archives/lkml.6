Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752268AbeBHVob (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 16:44:31 -0500
Received: from mail-by2nam01on0069.outbound.protection.outlook.com ([104.47.34.69]:10793
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751756AbeBHVo3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 16:44:29 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Harry.Wentland@amd.com;
Subject: Re: [PATCH v3 4/4] amdgpu/dc/calcs: Support clang option for stack
 alignment
From: Harry Wentland <harry.wentland@amd.com>
To: Matthias Kaehlcke <mka@chromium.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Cc: Craig Bergstrom <craigb@chromium.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Justin TerAvest <teravest@chromium.org>, amd-gfx@lists.freedesktop.org,
        Guenter Roeck <groeck@chromium.org>
References: <20180208205316.93330-1-mka@chromium.org>
 <20180208205316.93330-4-mka@chromium.org>
 <953daf8c-b195-e983-ecc4-4b369515e9ac@amd.com>
Message-ID: <dc344f23-663e-0e61-0b89-c4e358811e23@amd.com>
Date: Thu, 8 Feb 2018 16:44:21 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <953daf8c-b195-e983-ecc4-4b369515e9ac@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: BN4PR10CA0010.namprd10.prod.outlook.com (2603:10b6:403::20)
 To DM5PR1201MB2473.namprd12.prod.outlook.com (2603:10b6:3:e3::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25ae8d9c-6066-46a9-a366-08d56f3d20e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR1201MB2473;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2473;3:czjcd1dZIN1KejRDPSUUUyaMM3nhlwNb+XYyL3jlisjNF7kpmC8LtwBTC+42X5sNg/j5dOwfoJE4opkfHFwoYvlQlJinaqMmnME77taAjhoUdrSTObhv9ZTel1sKhvVJbPyiuKU5VuQ8U5bHYC8/1KmkK+W9mfP7zPwj2UueiPGnPZA/UgnHDRIy12KNRyKNKqgnJwWWVkow4JfRabhbnVvx65sKti6tFgACOjIqkJLEnUidPLB514FfzeYsMMwe;25:d4sQsDA7xFUEqnfRTQolXkf9Y9Gk5SVVJbyj6JLqm6/c2C2BEg08PO3TGtVE53KQTYMatHp8bT18LZq9uEnQB7Sv60RBOGCbCVSiQ7DdeQ7BPnYmBgi2oGVSA5c73OnCUJu4H7Ba86thOCH5y12MmDhcVDLSbH+tXrzVR4bjNnsmhv6fLxUDzIRLl/y+tH1grFKX7/23AMBWG4Dk5mdJlXGbwoiTk324MsRAvvugG1PwHjMC515lhDIkw9IqTwWgQ6Ltv9/CGBfm5imGaogZC5DB1LFf0wd9KqstarS7mkc1IMsSpk6O0ZBnbqoS2rQqdN7Rin0+pCZNBjxYRFRWpg==;31:yUCbQb/mnAaDZaZ/vsq7H2YubMZuUNfr0TG0yRB5iDxe4sMAoKOxdMG2ktoxh7hA64u+ReKTsrQLGrUaUYbtu4YveNDV/KMyMDr/tnjcIbXJhKxm6BBzSRIeXs15zZBV2fPrqNiVco2WACGoMhP5XQgTGsrTyzDttILM3POUmxV6U61kp313dieCFDJbWeAdwFwdv0FLxrTCQIPFa9MsvVvgee5We2V7IsaL1litXgc=
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2473:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2473;20:q4OkSrDx3/MAgQIa4VPdsDGiWRDv868S2ss3Qvxd+1lrwIWUH5U2HOpqt561U4w7TcFttWykMEfEgSxADLXSC4MGIRWILo8BOq/70hZBQ2Syy6LZ4h4SUnuSs5Tj6zxPA0LtUySh5aTxqpG2IFnpjSJD3Aodik6cVWp6Ap6rRaT7OvvpGhb76A5OnrHx/s+KhcDj+ofiaskEEu6m00UxJhL9+lyhUhD7wYSrlptCxHqtqmB831t+ew36n++ktcc3WBnyppBEKyTIBIE6eOxDbR3xNina+fZkng4X5iiz6FRN59oG3TzKCyzJvt2V/4VSwEX8KTUVyEoDm9724FBmScMfhHFq1Xj6kJA/o4CourWba29fCMbIYR2xngBKlWXbaLhM9PXM1QZ2fYAFiBtzpIqKtP5kJ1V7XhGRGeAHH/Ck76yenmcRB6o793aALYVLsMPbyhGlvUjgXx4EWsZnZjbW1+ZokYZyQ8fUdMlWjUj+8MinCaJZjbPTnDc0Gz6u;4:BsBT2R6Q5KOJmuLqfdAfWW2rLRuRG0qxjafMtbqpPDkevuZIKtCaTk5YLOWsZKxygZkDFqD4WKq8mHjJJRGwF0Y5kxZPgO4adKIb+/UJPXKpKY+ENEDdt+NR7LpwMvGM/R5dG5Hs9cmB7pAv1sXrd59iFYtQSmGR5/PHMFMZEKWLKbJmyH9YnkbmAKjmEDfQPR/cPJhO8+MMkA8JSq+rBpTr/fxnQ5v0Gmjx/rcaH0D8x/Os3eKuiZrpGFaH1aC6iXoF7SKdf1ReV8Xt76nE3L8ASSuSMd2bPgCF4PZvivcdls7/hfwuhMYIxJYzy/nnt2kWL/VKvvo2QH2B8TCEJw==
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2473A64A67DBBB1D0E8503518CF30@DM5PR1201MB2473.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110)(217544274631240);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(2400082)(944501161)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041288)(20161123562045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR1201MB2473;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1201MB2473;
X-Forefront-PRVS: 0577AD41D6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39860400002)(39380400002)(366004)(396003)(189003)(199004)(377424004)(386003)(65826007)(106356001)(6306002)(105586002)(53936002)(31696002)(16576012)(58126008)(316002)(5660300001)(4326008)(110136005)(229853002)(68736007)(77096007)(2950100002)(47776003)(26005)(54906003)(6636002)(6116002)(6666003)(2870700001)(97736004)(478600001)(76176011)(3846002)(65806001)(2906002)(83506002)(66066001)(65956001)(16526019)(64126003)(50466002)(59450400001)(8676002)(25786009)(81166006)(36756003)(966005)(31686004)(81156014)(72206003)(186003)(52116002)(7736002)(575784001)(53546011)(2486003)(52146003)(86362001)(6246003)(23676004)(6486002)(8936002)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR1201MB2473;H:[172.29.157.161];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyMDFNQjI0NzM7MjM6Y3F0Nm14SzBkVzFrSmJqQWpUS2pESUZE?=
 =?utf-8?B?TUxYRnp2N2FqeitZMzNjVkc3TWhobmQxSDlTdnZzOFQ1RzBNMVVGNFR2T05s?=
 =?utf-8?B?TFJ2M3FLWVdsRjdVT2o4Nm5mM25sWVY2Umo3bVRaS1NHR2hWMEFoVzhBWDdo?=
 =?utf-8?B?RzdEdFMyV01MYjNjTjVrVFlsZENUQUlMVEVNdzVBajZRT2EvZzE4SnQyTWhK?=
 =?utf-8?B?bGRNenpsL1ZteHlTc2M4TC9tdU0yQVRkNzlhQW1pRVh0VWJZZDUvNHphVVRv?=
 =?utf-8?B?T1Y2aU9IRGdyOTRWT1hDcGhBcS81WC9adGo3d3dFSmM1SG5jd3UrSEJkTlhK?=
 =?utf-8?B?M1NnWSt0UlhlRnJ2MHp3T1VyNnVITDQxandsSXNmN1dGV2tVMm1PS25FejI0?=
 =?utf-8?B?QmtpaVovd0svMFY3cTQ0MERhWUYrYmcyRmZCc2FabHlDZ1UvMjBHWUMweHdr?=
 =?utf-8?B?QklhbHhteTFXVm02cTI5T0xRRXEyYmFRM0NGbGk2MEI1eDFXNjBuanBWUVNM?=
 =?utf-8?B?RldQWlR3SzBRQzBuUFN2NnlSVFViTXNaWjdqMFFFREZ0cktpUEVjcFNWRDFo?=
 =?utf-8?B?Z05QNW53T2xBSm85UE1oaW9IU0E3MHh3KzQzVEJCcGtWd0d2VFdwMVJ6TEpn?=
 =?utf-8?B?UmNJNFlVbWg4eDluOU5QTm5LNVVuL2F0b1VDSVdubFFmaS9UQjNEaEROT0RW?=
 =?utf-8?B?T2liV0dhd1BoMzBmNnMwQ2t1NGhBR05MTTVYTEltSFFJOWpXWXZzdDErYkll?=
 =?utf-8?B?SlM2WEpUT0ovajE1MFhhZ29jb1NaNTUvdXFBc09tVWxpWW9RM2piR1Q3cGc3?=
 =?utf-8?B?MnFDSE12MWdvQnN0WExzakkvTzdZdGlJUDBrN3Z6T0ZQeDNjaEVEbmkxbXcr?=
 =?utf-8?B?dm85WnBVc0VxRHVyMkZCUnJFQU1WcEhBMnBJbFllNFNyNU82akVFSlhFdlJ0?=
 =?utf-8?B?Mmg4RzRNVHZNNEFjanlFT1dwRnpqcFpCOG9hRjRIVklVbTZUSHJ1dU5XempE?=
 =?utf-8?B?RSttSUZxdDRkL0VnYk4zanhTS1V3cE1NejBTTXlyYUEvMEFaNUlndDl0LzNw?=
 =?utf-8?B?Q3FtUVlDQjlXV05LaXMrZzIzS2tJLzNsUXhxZkhndE1wNkV4VmcwdFU1VXR5?=
 =?utf-8?B?eThHR01CcElPVW9IaHVPajZEMWowUHEwZ2J2eGRqbkNwNkZGRjRFUzV4eHht?=
 =?utf-8?B?Yy80eWJLMmpxUjl0eHVyV0JhZTRQZFJsZDFXZzNEM1FFajJFUUtUUi93c0RE?=
 =?utf-8?B?aHhTVytHYUhLQXB3YlpLbVI2cThXcklya1BQakNJVWdhUnpOUTVRaUlkeEwz?=
 =?utf-8?B?bFdUcHd0MGZvdVM0OUNuRmhjb0IwMTZyWFdaZDlUTUxGbFhhL2JMclAxMTF0?=
 =?utf-8?B?NkQ3RVpyTWZHZjJjYk1FaHFLTTFOMStIc01IdUh0ZUdidkI4b2RaV2FieUND?=
 =?utf-8?B?WU9XY2V2VXJrVVdKNjZJaU1TNW9xRmo1em5YbHJqdCtkL1pBdk42eVNobTNS?=
 =?utf-8?B?NlNqK3BTOVN6Z3hjcnY0NC9LdENpd05GdFJFMjlvc0tCcjMvQVRiSFl1cGFE?=
 =?utf-8?B?M1ZkVDI3MnJSOHZJblk3RjRsM091N3pOVE1EVERZTk1wU1FRaENhM1BCVWtj?=
 =?utf-8?B?YTNxZVJ4NmsrRWR6Q1EreFZMTnI5WFZ3aEVHRGwzRDdSaG1HWXFVT1VJZ1ZO?=
 =?utf-8?B?Tm5RK2U1L05iNkszV3JhaXJFcWtzcFZZWWdYS3FWalNLOUl0MHl5MENmRyt2?=
 =?utf-8?B?Y0kwMTFuU2ErUmRzK2NUd1NkQnl4NzcxZlhYOXEzUjZYNHU4MXhiR2x1aDhU?=
 =?utf-8?B?SDBFdWx4QW5RcGVaa3hpVHJpa0xmbTkxdmU0cVB6a2ZjdUErd1NJa01XOVNn?=
 =?utf-8?B?R1F3VTBzUmtkQmM0dkJqZDFkWEorbklzak45NWRUNDJ4TndWMFFHdWZ4UUJa?=
 =?utf-8?B?RzU0UmpIMFdEQ0NvRHN0YTd5K0pncnQ0U21rOUJIYmFubDJwczFoRTQ2dGtP?=
 =?utf-8?B?S29qRzEwYThWc3U0SlNIUUlmTkIyeElkVkQ2ZWhLSWxZNlduZ01jdzlSaFBS?=
 =?utf-8?Q?nRdjyYNz0wHzix51yOj3KN5nfFr?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2473;6:EnH51B/BDlxdJRt4v/4nMyJYZw+iRWSvJXk43JYWFvPy14LFJ5faUcF8YPjT3MqM87Uqy6eWDZ4h85fbTGNq8i8yrOxzaApbI72dVC4dyyJVGlrWZSTz9xLykZOLv0d82eNcROkQEK9iINrVDWcOh/OUbwsY79TU5BXqVwYJ4qsYkZsd00SBjiotXBIv3+BPD8RxP7LTFlDbklBmvMGrH3I5hrItdIpLIRi8F/kUU+gU4md7ypXhmKFDobeH08l0v7xIU14+GfwyqtSuk4Brq6jSfqB2pfhzIM0/421WzT4Q9d6E1bjhnvhava4bOk/h8H1MQ51bmFgH9m6009i95pxXlWRdTD608gr78bKedWI=;5:/WcLwKD8OPxnIs/pHwxVveB8wN4aAc+jgQhuhyDzrHKKdWbdEAY8+9yBpzzFGH67UIDERVz6/v5iPqTxoDibkfRH+ClulJrO27pQxjCQ5qQ8A/9VLEZDkvNWKa5dJWAweGXA5OADFMWcb3AziQMpNWqYuHW4Y/oSKDWlLTcWK84=;24:DBHo8DNu3zCGmi5vZSpuppSNtGh9wo9gslNtfMDeXufS5xvg6fra56szju8p8EO/F8PpoD0Gl4fCW83OPZzHssLUmZpLb5LE0m785D+d5E0=;7:z7Y51ZpL+iI+2EgGOGm8VAm/8K/l0Is+eh3xhpBzHWiKTEbFCAgfwYBWK4nRfzuwL+MKvsAkO15a8egayN3WmOrRo3f7oFx/1tudOqmEh6DQ62rAV2Cj8Yql+/0K/B9rNSlPexuir6x+wEsSv98CU2gmQPtjbDGt2c+7TjHUFhfT57edIzs2vI4FRK3JCgWus53glgqH8uvbjvvSJ7ELMqy2cs9g8yoOW8rEhYsfVwQMtMMgm3pS0JZk+itdhnM3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1201MB2473;20:1E4MlYbPTAxJrpumuPZaheAU++F0WVxJAlPN3ErERJyscO8rGbedmkuitwO4bynT8cTzz4is+Nyukz6BWoNLeu+d293cLkcq1RbDZ/NgkzMbwqckK4zcPcy8FhEFkl8slXIvNWqnNhEHgNMg+CKc+eiSAGgp6alNj+GIdecpGnzS3W5cqyrD8qB3Iyt87eA5+v6V5DnI/mXt9us7/WHxgHBP3Czpd/xghvGT6ZDbSuDtmG/x/lY6SYQ65zhRmbzN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2018 21:44:25.8976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ae8d9c-6066-46a9-a366-08d56f3d20e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2473
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-08 04:03 PM, Harry Wentland wrote:
> On 2018-02-08 03:53 PM, Matthias Kaehlcke wrote:
>> calcs uses the compiler option -mpreferred-stack-boundary=4 to configure
>> a stack alignment of 16 bytes. Clang uses the option -mstack-alignment
>> instead, which expects as parameter the alignment in bytes, and not a
>> power of two like -mpreferred-stack-boundary.
>>
>> Probe for both compiler options and use the correct one, similar to
>> what is done in arch/x86/Makefile.
>>
>> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> 
> Series is
> Reviewed-by: Harry Wentland <harry.wentland@amd.com>

... and merged to amd-staging-drm-next.

I had to resolve a small conflict with patches 1 & 2. Not a big deal but curious what development branch you use. We normally use this for amd-gfx development: https://cgit.freedesktop.org/~agd5f/linux/log/?h=amd-staging-drm-next (although it might be a bit behind our internal dev tree).

Harry

> 
> Harry
> 
>> ---
>> Changes in v3:
>> - patch added
>>
>> Note to self: if this patterns proliferates further we probably want to
>> put the evaluation of the correct compiler flag in some common place.
>>
>>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> index af0f452f3c9f..95f332ee3e7e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
>> @@ -24,7 +24,13 @@
>>  # It calculates Bandwidth and Watermarks values for HW programming
>>  #
>>  
>> -calcs_ccflags := -mhard-float -msse -mpreferred-stack-boundary=4
>> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
>> +	cc_stack_align := -mpreferred-stack-boundary=4
>> +else ifneq ($(call cc-option, -mstack-alignment=16),)
>> +	cc_stack_align := -mstack-alignment=16
>> +endif
>> +
>> +calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>>  
>>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
