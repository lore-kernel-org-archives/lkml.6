Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbeEUTOG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:14:06 -0400
Received: from mail-db5eur01on0068.outbound.protection.outlook.com ([104.47.2.68]:23488
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750773AbeEUTOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:14:00 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com;
Subject: Re: [Xen-devel] [RFC 1/3] xen/balloon: Allow allocating DMA buffers
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        jgross@suse.com, konrad.wilk@oracle.com
Cc: daniel.vetter@intel.com, matthew.d.roper@intel.com,
        dongwon.kim@intel.com
References: <20180517082604.14828-1-andr2000@gmail.com>
 <20180517082604.14828-2-andr2000@gmail.com>
 <6a108876-19b7-49d0-3de2-9e10f984736c@oracle.com>
 <9541926e-001a-e41e-317c-dbff6d687761@gmail.com>
 <218e2bf7-490d-f89e-9866-27b7e3dbc835@oracle.com>
 <a08e7d0d-f7d5-6b7e-979b-8a17060482f0@gmail.com>
 <b177a327-6a73-bb77-c69b-bc0958a05532@oracle.com>
From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
Message-ID: <f87478c7-3523-851c-5c3a-12a9e8753bb6@epam.com>
Date: Mon, 21 May 2018 22:13:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <b177a327-6a73-bb77-c69b-bc0958a05532@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [178.94.17.41]
X-ClientProxiedBy: AM6PR0102CA0022.eurprd01.prod.exchangelabs.com
 (2603:10a6:209:14::35) To DB3PR0302MB3210.eurprd03.prod.outlook.com
 (2603:10a6:8:9::14)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3210;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3210;3:Ev6Tw5zgSIDgRftapK2e9SG3UppIYb30St0jnTN5VW5etZBV4d0bHtHmfzbOzrbmw225sIi7F9kv1aSixgbGlDwPXLwZpXOhiT3yK7G3sOj5hG+PxvkHv+PgMql2r18/wTCeSNsd/4BnFOzVOaBAb+breT7N8ENx3Cm0xQtjhsx+o9YfEzOVREIh0LIexV5BgJTZ+l9p/pDjWGNODU3KLdjN/I4eB5PzDNqvtLnGFleehDZz5EERCkob/6AYynHv;25:nuNREKxvjpMAkUCR8UJS+R03VcnvTy/fpbatFf5K0xaJaEO23i0qWfhG30WI/s7S9paJuiQ8Du9UOIlYplpx8IxWJ6W+kUoZzxKdHKuyBjaPj0oVUehB/cGL3NlvkcScCbrG7WvrKvylts1ROu42Egl8UD7RBENsmNa4tPJuGVAC9hfbHX/GHVSLx2pd5ey0tzGcMCL7Qr+qQzwTeOcBjMsWxVNGDLJ8chroKwiN6JQI/Ut4raUf3NSmExI/V5XL800SZHfnVXcrgjEyD36M3X2+chCPo+l+vskxXkhe3W8O1Wwqci+MO4T4nMyFryO0NBKjMRk5ksrSK1CtXiKQQQ==;31:SLWtjVdNZRqJnjtjQSuWigGrjs/NuvTggkaFqIV591Nev9Xsv9vxiXG0cPf/5iyvNkadandGYpxyjKC/5LPbUZD1IUzmJGSXCMtDl+sduBXt2+9HwjJMwyIB7uoIa+rs5lzCDARG3J/92N0+ndfLPJnM64+kWZpsPwVFj9Ua/6ypdBzXUJCHkefZOYJtDz5J4cq7AO0+m8aCXR33+TXPAGzjvzlHX9RUwIQgSN2wgOU=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3210:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3210;20:RwOXObvXcXePVI25jeNuUoqi3Jpz45dJUMP46cVuyomOIKDo9xY7TJgs+dhZMZtTEM1YEVBfmU7XglfSUyGw6qgEhQ9Yo+U4E/00MKFmo8fWTaF/wKpHVmht9homaOHlSjiGCoDJsGNnaVlHa4AI2uOhvnhYBTd4Pq5X/NzvWd0F7JDWrh5pb8QmdgNQ1sn4jKBrRnKQqDAf8cnnrpY7OHovTbcO8csgwXGMq6m1m7rmbwdHtVw/NzwD2zC9pMHXpYZNAx+uyjPJq56sR9woNZRyvoHQfAYTUz9vxewGr5LJUwAKOaUN6PZcX7KQvTyJpQmcTABiRGwF80Zx3pz5WjFyNQa0crhIZEL5XQKUikEST0IVBOFmR6xJDuj4RZt6yuDumNDjPfdYd/MbLvlTamqQyyXGaIH4trXZuTsYFobMm93nCpQxT1Fe+jQu434KFRgXxtRwue0IM8fYrOsNmuF1CxjsevPSBv6LseAvrvzAd9kavG+IA38hJgG0SItY;4:ndnngh2lNGS0tOA80oGZbR931GYmpyNDbAOqPlXt/fOnXFxK5WywaSMa9D6ytr+TarhVDk2vQZya1txakdE3gYjEU1v2KBlMBRWBLimlunCAvkw3BQ5+qY7IPgaUg5SMaIJgYXBt+2f+vCPIINoTQ1O8DM2Xed6YMVRuv4iFKIuWqg4HXT6ZjvX94jFZI3nK51OOdaKkSpLsnjDjeqHhmKDxD3OqNIbN+Ll2XkmEIUEZnDWRdlDalbN4BmGIT+y2lUPevuL/dHdcVhe9c6lGRynvH0IfqW/2tahwQajhKBZn/GIJ11B5EGeh7O4AzMbGeClD6roV3LpR6gl+/X3ghX/QuExmAeiiTRqRNnlsBEc=
X-Microsoft-Antispam-PRVS: <DB3PR0302MB321002E7979BB3733A879F33E7950@DB3PR0302MB3210.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(217544274631240)(4114951738403);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3210;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3210;
X-Forefront-PRVS: 06793E740F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(376002)(39380400002)(39860400002)(396003)(366004)(189003)(199004)(2486003)(386003)(31696002)(65806001)(66066001)(65956001)(47776003)(93886005)(2616005)(316002)(110136005)(81166006)(81156014)(64126003)(11346002)(486006)(8936002)(16576012)(7416002)(16526019)(476003)(446003)(186003)(956004)(86362001)(3846002)(58126008)(53546011)(6116002)(8676002)(67846002)(23676004)(68736007)(4326008)(2870700001)(65826007)(6306002)(7736002)(39060400002)(966005)(229853002)(106356001)(53936002)(2906002)(305945005)(52116002)(6486002)(97736004)(80792005)(36756003)(72206003)(31686004)(6666003)(26005)(52146003)(117156002)(77096007)(6246003)(105586002)(25786009)(76176011)(5660300001)(478600001)(50466002)(533714002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3210;H:[192.168.0.20];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTA7MjM6ZVlHMWdDQTVwT1pEei9hNk13bzJwZnV2?=
 =?utf-8?B?bWs5T0VTeXpwSjlqMC9mSDhQbjRUUVg5SWxQZ3F2V1ZoV2NpbE4vWHNuaG54?=
 =?utf-8?B?NUlJam9HTVlQMmRPMjlPaEt1QktEa2txYXA2MUJIM3lvaE43bU1hQ3FndmV5?=
 =?utf-8?B?VktxMVNnencxRmRMT2RENDF2ejRmNWdjYTUrQUIreG14NDJSSzRqeExBSnlF?=
 =?utf-8?B?bTNPWUhFM0pwdjFIK0lBOW1BU0E0QnpPdmhBNXRQbWNzSnJPQXZUbjhNTmw1?=
 =?utf-8?B?MWdMNndmNWZnVnk3MCsrQmtPcHdRZjkvbVBqTVdseVB2bzVnd2JNTERBVDZU?=
 =?utf-8?B?OEF4OUwwVmNMNjVwckV1MEUrQkV3Qyt3eVFTUWg4N0NSUHcwUWVFRFVBVXNq?=
 =?utf-8?B?alB0SVh0QUlpRWtNREVLZnI2bTBqellOMHV6MXNEL3B2dHlSY0lIQ2FKdno5?=
 =?utf-8?B?M1R5akoxdy92eXAzWVkyYjlQcE90QUxFandYWVplNzA5MXViRWc2cDZqby9S?=
 =?utf-8?B?TDN2ZnJMdWp2M2tZK1NUTjBPSkJ0VDhSM0Jzci9iNG5sMmhHcHNuc3BtM0d0?=
 =?utf-8?B?VGM1WHpBVmVSdnVjc1BhbGoxVUxJOHVXbTZCMHFDay9BWUhScmtYYUpsaWpi?=
 =?utf-8?B?VGdlVnFheG12bWVTam1rbllMUGJidVdyODVmTWwxeE92elAwZE40NnBYanNl?=
 =?utf-8?B?MXA1VlFRdExmTGNqZ3VCZ3ZpVmRpbUxVTWsvSjR4WVdKR1Ixc010RTllVm1n?=
 =?utf-8?B?ZStZblBJMGZDOXFZRTRLWkt1MkdrTXBsWlhGazQ5T3IxK1RYNnpzZ0RSaHlN?=
 =?utf-8?B?UmhYaUtmM3l3MUN3Y0FLMDRYaG5wcGpBS3JvYlNka29vUkFUVGN2WGxFZmlR?=
 =?utf-8?B?dmcyZVYzU0NLY2w2dkRaSjdkOUx4Z2p1U3BTOXY1OURJUmcxdjdBZmhvaEdC?=
 =?utf-8?B?WXp0WGZpMm8vMmUxS2VHZjhPdVo5OWx4cWFKcDdET1EwYmFVZ01yNk1zREpE?=
 =?utf-8?B?RTcrcDdQaGsramZmRjdmWTRYT29HS2tZaXlIY1ZGNEt1dnBJNXd3cTRReEdR?=
 =?utf-8?B?alZaYUJ2cEtvM0xMdTRRQkZwaUZNWHlScHk3enJySEQ2S2pnM3RIbTVmU2o2?=
 =?utf-8?B?TkREWnR1MzFCbncyRGJ0VCtqcnJEZWtacnVYL24vdTYrRzFZMjVZRHkrSy9x?=
 =?utf-8?B?VFhrUzhDdUtkT2MyRlRvNmk5YjMwRzBiZTJIMW1LZTQ0eXliYXpkYXlaendI?=
 =?utf-8?B?SkI1Rmw1WHM3RzhFZUsxV0JNeEh3M29HdEZzbjBpMW56OTRkeDlZYitpKysz?=
 =?utf-8?B?WU9rZEFySGNidUt4QzR2Y01qUlN1QXpSZ2UvRHJ3OEFDUDBHKy9Nei9jYWw2?=
 =?utf-8?B?eFNUbXI4aHJQTzlSVnFiZXliVG9EMkJ0N3dOMWl6NWlZWnBJbVJsaGF0UTNn?=
 =?utf-8?B?YUJEdUhRWDZpdGlMYm0zWWV1TjVUWk1GVjYvZFpSY1dFdzU5dTZzb2RMbnhS?=
 =?utf-8?B?UC81a1dUWG1tVE5kSFlNWGJ1NTFlNmlpekVYbGc2RHR3eW5Qak5HV0U3WTZC?=
 =?utf-8?B?UVZ0NHdBd1k0Mm53Q0c1L0Rwak0wbTg5cHY3NjQ0elRlU3VGWlBrMnlRelQx?=
 =?utf-8?B?V2hBNzQ5MmdTakJWSVNvZ0ZJdE01VEk1OU4zRTlPRmYwYnpwcStneDVVUGpM?=
 =?utf-8?B?dkJnQkNlcEVOTThJV3pzWVBKSFAwSTQrQTVQY0lLc2h3TnVFanJUbUVEbWpI?=
 =?utf-8?B?TzdSbWxaMWVlcCtOajBTTGphdy9SS0R4SlZyTFFKaW5uMkw4WGRqS2lMUGo0?=
 =?utf-8?B?ZEpEb1VOelBJV3lVTnFzdkxCc0lmM3RxS0FldHF2TVhjbndoR01xWGZuYjN3?=
 =?utf-8?B?Qkd5c2dVSXowaFVmM2JsK3R6bzBreGN1UDVrWWZ6angwTWhyby8vVUtla2dq?=
 =?utf-8?B?a09kK1BUbURrV3BzWitreWl0aFIyYlVvSzFoenlOSDlMWk5VK1E2b1JoV25F?=
 =?utf-8?B?MDBudDA5OWw4cVNLcHhFOW0ybGppa2x2cC9sZmdmVENSWjRUNU9jZG5teHI5?=
 =?utf-8?B?a0VBcThHdWpHaHIyM29kN0ZXS2Y4bkgySnozUnF2aGFPL3VrN0dZd3ZqRjBU?=
 =?utf-8?B?RWg2TFFpRzVaRDhIdDFFMnJOdVAwcGdZWGoyYklwMGxFZS9GajhtYklsNm5o?=
 =?utf-8?Q?KFBGdOE2tgdOqEy3yjpk5GE3VdHt7FZ2IIl1tz2/MPrA=3D?=
X-Microsoft-Antispam-Message-Info: WjlX24jrltSLC/zVrXqOV4Shk4LvzWUNYKEfdv8WCMxFX1nNk/rdPar4meY6Q8oukhSssEenYoVehpIYwDus/qZi0DHbyap2ZHbNo6ocx+6VnEYDBpQ6Y+JGOQ1CNz4F8QvHPuZqibai9kYbaaAwtPEXPL8IOjIRL6kyMU2X2QXwkKflE/Q+y/bHgZUH5nJG
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3210;6:95M4fA4ig0K5uvWVlWqoHV9Jv/xHdcx7oOceSNcsf7l/H99ZEaP1CdA0dhTeUtNgLp3QuY6GTnwR8a1BR7NmL2289FGY/8cQ+15WQKe8mVqg+0jdkq3uT28BukCwwFngdWqwvtAF7Yruk6mqDODnJdufiDB4o1nyuMxC+Ov6d/ZVgx3nKGZGUZ+z03yWHQtCIxSkko6/Q2AKZnPinO6HOaa+44N89BUWqVGIUBQMX72JugBcIzlY6ld0wrmrRepueeYWU1yZJvb3wYJsuidv3HYxPc2GjRqWXyZnXfP2g3HO3LA6PfzciQ1e9nXLi0HUwyk+P+NlCcQG8op0UcSlIn6e+Sj+6fqJKD0h+hCGU3TqnTMfqut8iCRicpwAiG+NlJkjCKaN0AKGgmLT4aicLn+faeSmRVSVeitV3DAAxxcB70mK9riSbthxioa60JUqE2+r3ybKqzq5Py0QNozX5Q==;5:gpFchOVoTs4KchY8B/2OdIKAqDaFT/ibAZPuyfDeRJNDwgE2EekohQQLFcGQgE63qx3LHqJ3yRc18yMLbHSuP+j1nGpVKOzJ2ff+ZdpGlfJSJVNITW8dRortRtn4+6xnqYnjHUwTmmBwzlVn3WBygUC8DU/bBg+Z7vDWKiF5MW0=;24:XK+yOLPV0lWG20n9CojESfornmd0rJSk3VtUwMDsD/jU3/tFhCtKKIW5FvepvQNyInldmHycGFtuo6AeYoyvvTx6r0lcRGXYIbFCY0lO+V0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3210;7:vBxRbTk+FBty8UgV6BZZaaPQH1vnv2myIpik42vD8X6Vql9feFhA9opZ+E65g/IccPaoesC+qgqcOPil6M6g7zalJkjmZSiz7SmQYBf8LqjlCp/tSxxPJtOcl+9h1QbBBuuEhbISyFx4XgQ/9J4IzxsIvpUsu57RlQJMhkyK14N+q4bGw4nxhvuuuF2BwqR2GrA1Cj/P6f50bYmb/zAav7VUUyVonTWNBCXh7S5E6hBHPer6Nx4yxEdXT0qu1hAu
X-MS-Office365-Filtering-Correlation-Id: 6c0e92ca-b38a-4957-5dde-08d5bf4effa4
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2018 19:13:54.8703 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0e92ca-b38a-4957-5dde-08d5bf4effa4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3210
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21/2018 09:53 PM, Boris Ostrovsky wrote:
> On 05/21/2018 01:32 PM, Oleksandr Andrushchenko wrote:
>> On 05/21/2018 07:35 PM, Boris Ostrovsky wrote:
>>> On 05/21/2018 01:40 AM, Oleksandr Andrushchenko wrote:
>>>> On 05/19/2018 01:04 AM, Boris Ostrovsky wrote:
>>>>> On 05/17/2018 04:26 AM, Oleksandr Andrushchenko wrote:
>>>>>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>>>> A commit message would be useful.
>>>> Sure, v1 will have it
>>>>>> Signed-off-by: Oleksandr Andrushchenko
>>>>>> <oleksandr_andrushchenko@epam.com>
>>>>>>
>>>>>>         for (i = 0; i < nr_pages; i++) {
>>>>>> -        page = alloc_page(gfp);
>>>>>> -        if (page == NULL) {
>>>>>> -            nr_pages = i;
>>>>>> -            state = BP_EAGAIN;
>>>>>> -            break;
>>>>>> +        if (ext_pages) {
>>>>>> +            page = ext_pages[i];
>>>>>> +        } else {
>>>>>> +            page = alloc_page(gfp);
>>>>>> +            if (page == NULL) {
>>>>>> +                nr_pages = i;
>>>>>> +                state = BP_EAGAIN;
>>>>>> +                break;
>>>>>> +            }
>>>>>>             }
>>>>>>             scrub_page(page);
>>>>>>             list_add(&page->lru, &pages);
>>>>>> @@ -529,7 +565,7 @@ static enum bp_state
>>>>>> decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>>>>>         i = 0;
>>>>>>         list_for_each_entry_safe(page, tmp, &pages, lru) {
>>>>>>             /* XENMEM_decrease_reservation requires a GFN */
>>>>>> -        frame_list[i++] = xen_page_to_gfn(page);
>>>>>> +        frames[i++] = xen_page_to_gfn(page);
>>>>>>       #ifdef CONFIG_XEN_HAVE_PVMMU
>>>>>>             /*
>>>>>> @@ -552,18 +588,22 @@ static enum bp_state
>>>>>> decrease_reservation(unsigned long nr_pages, gfp_t gfp)
>>>>>>     #endif
>>>>>>             list_del(&page->lru);
>>>>>>     -        balloon_append(page);
>>>>>> +        if (!ext_pages)
>>>>>> +            balloon_append(page);
>>>>> So what you are proposing is not really ballooning. You are just
>>>>> piggybacking on existing interfaces, aren't you?
>>>> Sort of. Basically I need to {increase|decrease}_reservation, not
>>>> actually
>>>> allocating ballooned pages.
>>>> Do you think I can simply EXPORT_SYMBOL for
>>>> {increase|decrease}_reservation?
>>>> Any other suggestion?
>>> I am actually wondering how much of that code you end up reusing. You
>>> pretty much create new code paths in both routines and common code ends
>>> up being essentially the hypercall.
>> Well, I hoped that it would be easier to maintain if I modify existing
>> code
>> to support both use-cases, but I am also ok to create new routines if
>> this
>> seems to be reasonable - please let me know
>>>    So the question is --- would it make
>>> sense to do all of this separately from the balloon driver?
>> This can be done, but which driver will host this code then? If we
>> move from
>> the balloon driver, then this could go to either gntdev or grant-table.
>> What's your preference?
> A separate module?

> Is there any use for this feature outside of your zero-copy DRM driver?
Intel's hyper dma-buf (Dongwon/Matt CC'ed), V4L/GPU at least.

At the time I tried to upstream zcopy driver it was discussed and 
decided that
it would be better if I remove all DRM specific code and move it to Xen 
drivers.
Thus, this RFC.

But it can also be implemented as a dedicated Xen dma-buf driver which 
will have all the
code from this RFC + a bit more (char/misc device handling at least).
This will also require a dedicated user-space library, just like 
libxengnttab.so
for gntdev (now I have all new IOCTLs covered there).

If the idea of a dedicated Xen dma-buf driver seems to be more attractive we
can work toward this solution. BTW, I do support this idea, but was not
sure if Xen community accepts yet another driver which duplicates quite 
some code
of the existing gntdev/balloon/grant-table. And now after this RFC I 
hope that all cons
and pros of both dedicated driver and gntdev/balloon/grant-table 
extension are
clearly seen and we can make a decision.

>
> -boris
Thank you,
Oleksandr
[1] https://lists.freedesktop.org/archives/dri-devel/2018-April/173163.html
