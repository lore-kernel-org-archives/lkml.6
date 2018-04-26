Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755788AbeDZMeS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 08:34:18 -0400
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:59661
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751713AbeDZMeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 08:34:16 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrey.Grodzovsky@amd.com;
Subject: Re: [PATCH 2/3] drm/scheduler: Don't call wait_event_killable for
 signaled process.
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
        Christian.Koenig@amd.com, David.Panariti@amd.com,
        akpm@linux-foundation.org
References: <1524583836-12130-1-git-send-email-andrey.grodzovsky@amd.com>
 <1524583836-12130-3-git-send-email-andrey.grodzovsky@amd.com>
 <87muxsbmkp.fsf@xmission.com> <8840ac96-50c4-f94d-eb7c-f007940163f3@amd.com>
 <877eowa5qh.fsf@xmission.com> <20180425135552.GD7592@redhat.com>
 <f45c7017-c75a-7f0c-b6d5-4d79600cdd33@amd.com>
 <20180425171757.GA10441@redhat.com>
 <c39cb438-1e8a-4f2c-50f6-c6e2a144487b@amd.com> <874ljyu98e.fsf@xmission.com>
From: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Message-ID: <611911a3-2858-200c-d5f8-679c5f41ee3a@amd.com>
Date: Thu, 26 Apr 2018 08:34:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <874ljyu98e.fsf@xmission.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YQBPR0101CA0013.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::26) To CY4PR1201MB0120.namprd12.prod.outlook.com
 (2603:10b6:910:1c::14)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR1201MB0120;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;3:RvSAxTSNrHs7nxPO/mGzl2H8/n7rjmnO7ZF731flvFU3iR+/02RGlkjlxBQgEhUzWT7X+cMt4n0GTZJ1ZHJjqPlde/r3g0Tjr0YOmIil64x6kCJU0JHLjw4OS1gL5Z01OZlhZ3ACrRgtDU7IAbfBpHRJH2D8raRBwUlj9GwH549KntbsioojMXYfA5jMert3NSWp/GELcn/OfFe8j8ODepIaJW07bxLBRQJ6rLA3QC4+YQ3NAaz5QRYZZwDHZRqi;25:QPiqr0XPl8cXU1SaufxOkLtas0sevQ68ssKsx9kMy0UqobHqH9kvHdlrTFIkNsk0SnrwVvbXf92a6n1hfTvgoEQd6y9tE5mAqLPNvlnW5ECqWiGK4yCSI4z9I+8qG+EXhVdMFAAUf5Zjb2YwqKPzx0r9MfW8mhrl6kFhiIr3pkE9A4jI1mgtlKkG/r21uYKGEw1NlAHr9cSzdEy//wQvwROyNgaN6gEk+NmCJgty3Lhbrn4fHDY2cIJV8I58ZkuVHGziqDMi1f5hySz8q49B+YOWXhGY3eBUBDeh7kK4QzmCiM/z4ttqfiPd99LHkJr7v6f0Zhc26K/KnZbVptGCLA==;31:hi5o+JxHLJsYDUilbOS4vhh8/QpHP79/I8/xZenNxF/769o+3zSsYCd7nAB/O7SytGPRwSH4VutQW+E5bmrAPO3eeZuK+emtqVYU7sOUbHBPt+cPgHiu/N+oDcbkAmWWENm1b0bueohYI1Uzeg14BnEonxPXKmgZfm0uPsI25rOH2ra4lk4yU1vriNjRxEmGfctUvRlRixR7sSuJnoc+cD1+eehZIEYY5w+/Zd0CqcQ=
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0120:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;20:P5QReJSQsxAgy/6Fel4e788QAN+Nqa4s706Id9jfi3DUEK3Es1fmNcS/L57I1jCRgoDSrpmXG8/jI08I+vM+ULTg6kdIwuF9nRXiG/D0t8GczISFBqNV1CyFVxuelJsjZSs+EWnkZ81XFW0z3Eq7AvNkI2gmOrAyiKXdRz8qMhiArI209o1mIsuQZVPjWSqQ/qyahpA1NX23bv2rAFtqFS6h2cdyYHtWLeo1FX+W+VPoQ6M+Fh1n3OLe2nDW31Mdt0o26kBr9R2xbSIfzOxuiplc226zuaE5xx32FD2yOMMmVanof+Wgd/oaXFvMUFv9M/qtQ2kXnphytVKZQvYRrifg634T666osDJRuKz204ojgYGZkLK7NxUn646oUBgO2yP1nilsWxW85CnOocj5HQkaVYEyVv9+L9z7ABioVN4I9VWrBZeJ+OgDzfcYcwE+sWOHDPy7VnNAv6TftpJf/J7o0vgZ+2RAt3N/PctHl4PlpJSCyi67+WYB4JLoQ7/J;4:X9I2EQPz7FKnHrLuDz+nKEVrYclx56kCsyb1PzaslX8PELH4eXnsCdRCWi/Y+dk7/ZpYSdtxhsGrf1lCtbz4Fvv8KO0ZD8JX5PCsi5478m/KhwZvxndDCDVvO7lS3POaPfWup+dvvkyE4tqkuIMsWd0ynZLk39u9AXAYH/b5Q7lLKRIlxdWPFkHn4/ctyLq9WwPduRlGjBCVrCy4VCaJSaXj3fOs/sbsE6vFn0cLAtGHfrisaaLIF2bRZ20M9+OZkI/p8jJhU9zboAHx105Hh+Co/BUwq5jSZub/fs0wsWU3oKOmfx3rqyNdo+ucV1JK
X-Microsoft-Antispam-PRVS: <CY4PR1201MB012016FB8B09B0430A8A6DD2EA8E0@CY4PR1201MB0120.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231232)(944501410)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR1201MB0120;BCL:0;PCL:0;RULEID:;SRVR:CY4PR1201MB0120;
X-Forefront-PRVS: 0654257CF5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(376002)(346002)(366004)(39860400002)(199004)(189003)(81156014)(316002)(11346002)(81166006)(16526019)(36756003)(53546011)(6486002)(446003)(229853002)(86362001)(486006)(26005)(476003)(53936002)(186003)(64126003)(106356001)(6916009)(2616005)(59450400001)(8936002)(58126008)(4326008)(77096007)(386003)(16576012)(6666003)(31696002)(25786009)(5660300001)(65806001)(52146003)(65956001)(6246003)(50466002)(3846002)(52116002)(47776003)(2906002)(97736004)(6116002)(76176011)(23676004)(956004)(66066001)(2486003)(7736002)(65826007)(478600001)(305945005)(67846002)(31686004)(230700001)(8676002)(68736007)(105586002)(93886005)(72206003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR1201MB0120;H:[172.27.230.118];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjEyMDFNQjAxMjA7MjM6akdsUzExQkoxZ3lCSU4rU2VEVjVqU0p0?=
 =?utf-8?B?MWxrQXNCVE0yT2Jlc0hHUG9FTTJMRmlnV1d6R2gzazhYNTF4UkwreWZTRzJV?=
 =?utf-8?B?NnB6cWNLUjR0RDdDQ0JsVnBoRWtzZmFzeFZJYkZJN2krRm5sSjN6bDg2d25W?=
 =?utf-8?B?MmpJMm51MXVXNjRDWGxWaVN4clhkNlZWeDlsQWlxKzAyNmtkV2RDbGtjOElY?=
 =?utf-8?B?Q1dtb1F0S1dTZTUwam1Qdm0vOXRvVTIrNG8vekkzL3RJNXNTZFRMUWlQTnl5?=
 =?utf-8?B?REpmZTJGUXE2TXBLN0h4cW1GOG9sY25pV2JpRXgzcVlBZUpsbGdnVkh6c09m?=
 =?utf-8?B?eUExRzJpV2FaTWtvT3FsdkovTDBKWTk3aFpRTmo5U3F0bWplZE41K05MR204?=
 =?utf-8?B?SWVrcHZPV3pQSXgxVjVuNk96Wi9lWFI3bi96azRWQTNUV0hQVUFld1d2RUVm?=
 =?utf-8?B?cldrTVE4YkJFSHFWTmkzKzZrK2hISEd4bDExN0NONTVRenBub25QSytYQXBu?=
 =?utf-8?B?dHR0R1hPNmhadVRzcnFvd3grTUZoaTYrUEtZV0JFUGlYU0dTNE1ZM24wTlJr?=
 =?utf-8?B?N1B0NUdpbzdPSWhSY24vbitaN2dJcEkyRDNDSGYwckxmaER1TW5ia0I3WTBG?=
 =?utf-8?B?Qy9XVElsVzI0Uk1wNUVzK0RIMlJXcW9RM3U0ZmsxeTNVVW5STU9IaU50M2VH?=
 =?utf-8?B?YW0rSllKSE16TWdzcFA1REZ4ODBPOStaNXZnNUdUNlRxQWJQRUM5c3pWTGE5?=
 =?utf-8?B?b1ozTnZvb2I5UDN0SkhFZFFrWVh0Nk4xaHFoZFlWdXhpOVNwOWR4bjBQTUhF?=
 =?utf-8?B?RGFPcmoxeE5WUkwrUVBPWW9OVFBOOGtyUWorWTV1NTZra1Njd29zWjZKaXkv?=
 =?utf-8?B?aDF4ZG8rQ25MSm1iSUdLNUsxdUI0NUJzUEFoY1BxOHNQNkovYW9NSWFpUXRM?=
 =?utf-8?B?em12VFFxMGV3WE9kckZsZXhmZTdpY1NJYldSTVV0SloxZDlEM1pvdForOUxx?=
 =?utf-8?B?bE1Wa3NyY2hxck04UXgraytFNmpPK3c4alpwdFlkZ2VGMjVaTXlrZ1d0dHBU?=
 =?utf-8?B?MUxyaEJVSWxpRGN1V2dCbDlaMkorVFAzUFdML1daM1llczQ5RHprd0RUVlYx?=
 =?utf-8?B?dFBxTFFkaGpEU2M5Sm4wTnVCN0dIcXFjQXRCbUgyMmd3SDVLQXJNN3ZOc1Js?=
 =?utf-8?B?VjNDNEl0NnNlTVhyZ1ppVHFDWW8xRS9wdUUycmFocnZlVUkzaFFQZWFOMlRz?=
 =?utf-8?B?WVZLSUQ3U3ZYVDd0RzgrQndTZlZ4QnRUN0M0SEE2MkRPc3lqWHQybS9WU3RZ?=
 =?utf-8?B?WjY1MGoxYVIxUHZ5SWhiN1NobDM4ZjY4aVFaUGtqTjB2bTNjSExRdXpic0RN?=
 =?utf-8?B?RDJpWG9PaWdIT0JTM2ZpbVpSTURraE10bklWc1ZDSWVWeGh3SkNTV2hTWi90?=
 =?utf-8?B?bW9Cbmw5MGczbEJuYmppS002N3ZPL2hpUTNyTUN5VFM0TlNjNzVEVndLQzVt?=
 =?utf-8?B?cXVNTjVPZ1dFTTFXU1VNVTlOTks5MGVTUzFLaUQ1KzFYSEEzcnpMTXdZbnFJ?=
 =?utf-8?B?TmdEVzBNc3IzUDc2dUdPRm9EWVdPUVBhZkVkNFBmZ1hncjBIbXkwMEMvYU9C?=
 =?utf-8?B?SnB3OWN5azIrR29mTWd1cldES1E5NkVxdUhueWtGdXZRS1d5WWJrSE1ZSHlK?=
 =?utf-8?B?OXBpbGc2djVOWmNMSm9tanFtczZBaWR2dGdYdUNYQXdoTytEYXQweVJWVUM3?=
 =?utf-8?B?Y3FQZXJTcEFkZmcxLzRUcE9rSGliNCtMaERocENaa09LY1J0ZHltaGNmV3V6?=
 =?utf-8?B?VnNvZUxHOHh5NFZnN1RYSkxCWVhxT1A5dmRSdkNLbmg0Tmd3WkVGK1p4bURQ?=
 =?utf-8?B?azQvQ1RRWWpZWW1pUzBhUC9uc1llL1VOZ3Z4RW1UN0I4dnljcytLdXdXb0ZL?=
 =?utf-8?B?RE14UmVBeFpjczhWVjk1Y3FCdWQ3UGEwdXBKcWxWVFlaYVd1ZkFDT2NFMDhu?=
 =?utf-8?B?amg1S0VxWklTOHJyZ2I2NWt2cVAyN25rK21TSVczUy84d0R3UVljM1FZdERo?=
 =?utf-8?Q?aOGHrg=3D?=
X-Microsoft-Antispam-Message-Info: WZTTKvsu4W2DaCi907ZfzywRBLmuprALHu53C2zojdiNHPey77Z+q3ldung2QoQRmoQTvd36LaDk9Ya72OwImY83C6qtedtjrXDHUNSowrUWh7tTkXWOh6CT3D47lkXnyjJp/2caYidotWY6WkwP8aImSkQcMBjrKXCs6pxqY+zia+ZJUdEXj8RHCMWD2Sdb
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;6:2kvdu9AgNV2XukYk5wYP2Ug0Ism7z1Aqz2P7limXoiEdAqhpozS4S05JlmhIVg03PjtmYcKFu51JeuPmySJYULQuw0vC5kyDCR1Gb5Eh8ZxOljJEx1u7ZgwrpASyYLd2sjt+oBKUe1a089QHhoPOTb/kRQvWfWXjYx/pDeIaB/OqiZGwRqEmcrxCVHwD6P/RsdrLqfV9cPKqXm2v51M9RjJgndmOaEcGQo6tG/BXVK9Hbm7yEL2OjkUEFKAzw9mcEWVktJ/F0msPWu9LjNvo+MZBRTj3K8WNPdINZGud9GZ/FghniWN355cACtYhSjAcFU/xY9caWy4KV5iE6jD8XqUBxD+sRw+Jh+TLGdBQZYkl7vuTQ9U+lnwzyzcfb5dbXR8B5pAMGdwt26BRibCBpmuHoQOTx19tRyT2t/TXBiLifvSu6NWfrkvD5GfMvSBnRwPRjL8Nll+znvQZF+wzzQ==;5:I9HxUnaQoBN6UJdFqMFF1bciroKYhDeJM31UriOsJc5B4uz5O69/pwzDKbHWRyQldwC0HQCoPadbX57YnKX5+AeOMvwR1UV4sCidXxfICUzDf5QIadKrFEkqcCAqkyKitLhSjyrSDiY8982BUfoiPzgbfUnRT20iLPiAK2AdbuI=;24:7J1SB5pss8UD7tIHJv1ldNXV9mgb8MmhwyDzXOmCvHvLoU/rUDSS/iHEDmTzXFEzOvVHqyoIdC5CjCZaUdC0V6Iga9z0285oY9QwlXb62P8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR1201MB0120;7:hGOa5+YcqRQ63qgiUId3JNXnFnDuEwM4XsjF8jOjxwr6ugyRVQceUgi1PkJGJN/WNJW5MrX3g/uGMhLjBA5DYwf97fxsWPF8Sc+hr3eqcGYrTqiR9URSWXFn50HtDTOjmJl5eoInIvAoCBHEPth7ZsDBhZWMtTEM0QKAmMgG7BlA6h/MFNh3hcKhJZ0Oa0fjWtTPL30TvZwcl5BtTVSSrLvwwmgRvoo+4A564YnBhB56ETjHjLN/OyBQIG0SKBC/;20:V81cx9/+3SoJrrPkYCll+Bph47G3IGJVrsk8pm3XxyOUE6zO2+O52HICbCe8pHEy7CdkQ8r//aop7Ux5rLgUAhb4lAUJJl5E5Su7MIhoRhVqpGrMKNpysIA1Cd8vuPziM43QDAudvcGY2IhTjenDdiTEOLBRaXR5EbleudRnU0MQZ8gmD8sOPvqbdzgn5qwLNNkO98yE6PuLyrRV2loYNrvriWfwn2kvEQdbtOg1dEh8ow5kSi2sFiamQHnHLjY6
X-MS-Office365-Filtering-Correlation-Id: 64ec2cf0-8ecc-49ef-5f9e-08d5ab72040c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2018 12:34:11.5178 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ec2cf0-8ecc-49ef-5f9e-08d5ab72040c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0120
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/25/2018 08:01 PM, Eric W. Biederman wrote:
> Andrey Grodzovsky <Andrey.Grodzovsky@amd.com> writes:
>
>> On 04/25/2018 01:17 PM, Oleg Nesterov wrote:
>>> On 04/25, Andrey Grodzovsky wrote:
>>>> here (drm_sched_entity_fini) is also a bad idea, but we still want to be
>>>> able to exit immediately
>>>> and not wait for GPU jobs completion when the reason for reaching this code
>>>> is because of KILL
>>>> signal to the user process who opened the device file.
>>> Can you hook f_op->flush method?
>> But this one is called for each task releasing a reference to the the file, so
>> not sure I see how this solves the problem.
> The big question is why do you need to wait during the final closing a
> file?
>
> The wait can be terminated so the wait does not appear to be simply a
> matter of correctness.

Well, as I understand it, it just means that you don't want to abruptly 
terminate GPU work in progress without a good
reason (such as KILL signal). When we exit we are going to release 
various resources GPU is still using so we either
wait for it to complete or terminate the remaining jobs.

Andrey

>
> Eric
