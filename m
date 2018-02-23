Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751674AbeBWS0w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 13:26:52 -0500
Received: from mail-cys01nam02on0087.outbound.protection.outlook.com ([104.47.37.87]:35425
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751420AbeBWS0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 13:26:49 -0500
Cc: brijesh.singh@amd.com, kvm@vger.kernel.org,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Borislav Petkov <bp@suse.de>, Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] KVM: SVM: Fix sparse: incorrect type in argument 1
 (different base types)
To: Paolo Bonzini <pbonzini@redhat.com>, Al Viro <viro@ZenIV.linux.org.uk>
References: <20180219161228.46931-1-brijesh.singh@amd.com>
 <20180221174910.GI30522@ZenIV.linux.org.uk>
 <f55f25f6-559d-bb93-5605-af66678438c2@amd.com>
 <20180221201839.GK30522@ZenIV.linux.org.uk>
 <f8b22e16-73b4-340a-7387-c8c7270e9432@amd.com>
 <561de7e2-84a6-7372-b561-b035ff390ac5@redhat.com>
From: Brijesh Singh <brijesh.singh@amd.com>
Message-ID: <f593be03-4cb1-5569-e8dd-9b1ef6557798@amd.com>
Date: Fri, 23 Feb 2018 12:26:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <561de7e2-84a6-7372-b561-b035ff390ac5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: MWHPR21CA0055.namprd21.prod.outlook.com
 (2603:10b6:300:db::17) To SN1PR12MB0160.namprd12.prod.outlook.com
 (2a01:111:e400:5144::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9a2a85d6-3875-4783-6be2-08d57aeaff6d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:SN1PR12MB0160;
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;3:oHbUBjUv8AY4u9XCWNUwdt+dc9LuxLKCQzF9Yd4hFyLE8wVHXQPEY4nOxANNppibw52ckCIYyUPr2Sx/orfKLXq2yt6ClJHmtgxxLl/xObMLc4trOAAsRK4SCXll+b6Ps3Zh4TBLQ8lbYPg9Rawisy7ZIl8LSeFsxKLlusRnP/s2/VcFwMqtY7LqQL5NvNM3DOLe8v3KFVRrudlJYm+opMa1S2R4nLIp3eruDxEZFuJGlraNS8ZRXqdcN045ZkpA;25:M38hRbzaf7mK1zHaCJbRnbF3oEVE1P6N/+IB0CQQPEFS5DNY3d3uwoWQwYdvIFWfcmzP11LI3z+i5v71XiaRmgRdqv+nvalIh9z1BdLb21EqOBD/ciBsxXHJIpdJiuCLPd9EquMM0vTPhU0ger+LudT/ZKRXrai/KIhVkT6oO3fgMkypFXfBUhYfmIl+qPcrN5ayoDDqCOV0ILpVqFrB4pTNZTnJapKVtDhW+K4q4QkbcJIb5c1Kp4awWdKubTNGJlFYnAuGiyqgRJGcY0wwgsnxiWHOAZarLJLLJOqHBHauriX1qLc3wBgQH2HMa60c/QUUDo3atApsnI9Ci+ycog==;31:3Cvs/UdqT9jQTUZnqs7q9Vdf8ekNMdo2AoRCqLlSLjdMd2c6PiVNji4940KhUbeJa2wmU0LMFlgfoyuJokYUzKip3oLdn7IWUSTn0byMbDyQRrPksP9vQFqSxEIooHZDhX+ZPRhFqBlOI7MPG5cfbntsJjJJV1BTRzratD4pyrcaT+NO3feq9y2IlTLaLskKxDArJ7ThXecXA635CuTeZBWdU5WRjDIAd7jB58+NigY=
X-MS-TrafficTypeDiagnostic: SN1PR12MB0160:
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;20:oIvrIGF/oKUwaxvw05RexoI7jd+f+Ay3U33yJDJLD3isHsWLKsK5bIysGUNGl1Ok9Olm/vZ5h1q3yGSGwVspICJ/kojGOiblmefUnQpIm7K1i5XeUzshXFqQ25abL4wOs7TLpS6DXsnNvmdYsGxo+POf+5XcLYc1Jvg9+LGcY9jh0dmi80K77VXaQOgkPEwIvz2412wX4XiYQLBLhx2IJ07nJ8bDL+jV6SZcu9WGU+vMkUd+BU0/6uyrfDmzW7MVC9G+5ex99i3WVzZxfm0E2YpNcqgyYgwK7P5xVHtUU0qtwXV2o+ArL68vCHpNRudUUyVSgQS5ItbcwW8nYJ9Rv02b9QnTpKlKzz625y+aVNr0kJiUx5Thy+T6W8QatesF6IAJKzgLUlZbqnUXaYEfvPAhm7Lju9xxz0UBP0Dk9fmkBYzHHRb1Z793mX5Ed0KIrMALzOmpbV4Uda714d3V26FYyoltI9SkjcqYXdP3E8IVRmi74SH6KLqjfAmwAiG5;4:yvq6ZUjHytVZAj/FKkH/SxS/PU5tNw4IGuqIWyrakMDFuNOGYrhTKYjekaBUX+WhgGfAZNmZCtP3TdPrKSZUSU+mi9eYqoB7a0Zgb8cjkUeY8oFgU+UsTRsMjfejqOIL5y1WdWJG+/pSpB4zV+zytAjGfzmBw1IiYJWLQ4m0c489gfi4/OAH1fGaAShmVOqzSzTBfMa+mT0rquHC1oIPAH5B54lzfg2xgK5aReSw/K894rgQIvDbWEOIqW+JGzLYkB+1biF7rDeGG5MgsRpvyQ==
X-Microsoft-Antispam-PRVS: <SN1PR12MB0160D840F12973A10DDFA0A7E5CC0@SN1PR12MB0160.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3231192)(944501161)(52105095)(3002001)(6055026)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:SN1PR12MB0160;BCL:0;PCL:0;RULEID:;SRVR:SN1PR12MB0160;
X-Forefront-PRVS: 0592A9FDE6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(346002)(39380400002)(39860400002)(376002)(189003)(199004)(16526019)(64126003)(31696002)(8936002)(81166006)(26005)(8676002)(25786009)(76176011)(6346003)(31686004)(77096007)(186003)(59450400001)(81156014)(478600001)(50466002)(229853002)(53546011)(16576012)(86362001)(54906003)(110136005)(105586002)(4326008)(68736007)(316002)(65826007)(6246003)(53936002)(58126008)(386003)(6486002)(23676004)(52116002)(6666003)(36756003)(67846002)(2486003)(2950100002)(52146003)(7736002)(305945005)(2870700001)(93886005)(2906002)(66066001)(65956001)(97736004)(47776003)(106356001)(65806001)(5660300001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN1PR12MB0160;H:[10.236.136.62];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjFQUjEyTUIwMTYwOzIzOlhjR2syMzVEL0VhU3VmRGpMaEY4MnJhTVJo?=
 =?utf-8?B?U0p2ZFRxTW5FTnRVSDZKSHFQS3A1b0Z1S3dNdmw0NmcrOVRURDBrNUZuOUhz?=
 =?utf-8?B?clB4NlVzMjBLZWZkUjF3ZzAvNzBLc1MwRkVacmRSUy9GbUo0cFVFL0VzRlJI?=
 =?utf-8?B?NGZqUEh5bXlVQU10dzJmZ2RmQnhRUk1VeEJlWDVLTU1lcjlwaXpYYkNiRjFr?=
 =?utf-8?B?ME9CMFdFdlF1WTVVbGRmTVZjZkxJQm93NDB6RDhUeHpsWGRqcXFLN3RYNWxQ?=
 =?utf-8?B?TGd0cVBxNjBYT00vQzRFZ01lNnlBbm5uaGpUTWNoU2ZscTFRZ2IxZk1BdmUv?=
 =?utf-8?B?bDNINUpGQlVHRy9BdGhEM1BJOGRQbnJYNHlrNk9NTnEycEsrT0VsL0NreThI?=
 =?utf-8?B?UlVycXAvcmp5Ym0vZE40MzNIdDNpU0c0MW1iRFZhbHVVQ0tXTWdNbndmTkJV?=
 =?utf-8?B?OS84dUJqT1ozdTRhWmZSR0dKYWwwQVBKUjdqU1d2K2UxRnhmeTdZT09Ldm04?=
 =?utf-8?B?QzdDR2JHSXVTWW9GMTkvVGdKRUtnYldGSUJXRG5TVExVeWtINEROejZYb1JL?=
 =?utf-8?B?SDF3d0w5YlNMNmdoUlVQSXp0dnI5dWJIY3RkdzlTd1VsVEswR08vQ1ZtOFpM?=
 =?utf-8?B?WExaNTF6eGJPMnNRekU3OHVNUWZtYUl4Um9GOXZwUjBOY1JNQWFGK2VGa2ky?=
 =?utf-8?B?VXlOdi92cmd5c0dhNG1Kd0JPOW5YcUpWODM2SmtvU2pUb29xYnU4Umw5a3hW?=
 =?utf-8?B?TEcwZmZ6VXdBZDBVWlhqR0YzL0lVVlUxRWNXbXErY0FrdmQyd3VMVlA4T05C?=
 =?utf-8?B?VFhJQlRNVmFFenZPYnF2dHdJMnNhWUN4R25kVGRWdyt5WmNMRDN2R0E3elFm?=
 =?utf-8?B?YmlzdDkvbmVYeDBYMFhGMzNObkNmL1JGenExUllOeGRPNUJudWRlYVhDOHdj?=
 =?utf-8?B?c2JiM21VK0JXWjErdkRvUkNlbi8zaEhqRTJkU21LQkRWc0VJZ0hEN2ZtUitM?=
 =?utf-8?B?RkIvSzdva2ZQV0x5cXQzTHp3d0QyMlBjYXQ4clRzU3A5d1RyaE1HTHNCc3Jw?=
 =?utf-8?B?bnU1bXJLVmsxalpNYXV1YVlibklyQnFadCt0UFdDM2dzN3VoL3ZDT1VZaVNl?=
 =?utf-8?B?RVI5dEtVQWVuRjBqY3c1QldSME5ET0pPZWZIZk5Qb21xVFhnejBVVForWDYy?=
 =?utf-8?B?VXp0cDZjbFNGcEVkNzlQTXJETFM0N0lsZTRTcFpZZnZUcm8yWmUyODhVMG5n?=
 =?utf-8?B?ZWFzcGVIT0VwQmY1eDZvVkJubnFMajdrcWE3WTJqeSsrNEhScnZpNzZxZ3JC?=
 =?utf-8?B?UGdmSDU0OG40ODZMVmk1alRsR0c1U3RDVHBNOGx3THZ6aGxXcWZ5eUh4S2hO?=
 =?utf-8?B?VmljSmkvVGVrbE1ZQmxkZUFFNjBJK2dISkZDMGlvY0JPK3hoZHM1TlhLL2ZQ?=
 =?utf-8?B?dkVjZXBvVDA3a2UxTVE1SkwxUFJFR2N4R0tRU0ErVkpDTG5EVXEvWTIxT1Ez?=
 =?utf-8?B?a1haYzduNFphVDdERVJmMXoxNXdWUExDdzA5dDNoVzB3U3VQL1hsNzlpVkgx?=
 =?utf-8?B?T2R4SjhYaFlNS0dtQkZPajd2UEsxM2FWaVA4VFNWaHdyaWlBVVZOTU9YNzJW?=
 =?utf-8?B?bUVzdzIrbE1BMjV4WFN4QWkwTloyQnZCUU9jRFJzUjBSa0FZK0Q4ODdqN2pq?=
 =?utf-8?B?YmpJeFhNNkovbHBtN1UzR3hVbWlQZ0hkU1NKVkdtNFdXMnJuemlPZWFLVFNv?=
 =?utf-8?B?dUlLSCs5SmpkaFhoVGZoSVJMUlRlK2pPc2dnU3k5d29aeVVubUNOSW1WdGRT?=
 =?utf-8?B?YkhKVmNvRzZGMDNGUmpPaUNGY3YycFJEUFFYMEhGL0ZrYW8xVkEvRWJWdTVp?=
 =?utf-8?B?NVVyMXpnaWlJZFRCbzA2NHVVQkpoMmpKREh1Q05sWDIxcmY0b0dPaE84aCtZ?=
 =?utf-8?Q?dpR2QHDt7iOqpv8heyr9ApOHsZ638k=3D?=
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;6:jTHtrBmLVL4oYumR5Unq1aCjb/cW3h4nVyBLXEoh7xrJclycNRTVBrMlcfx/cirIohlZbY5hrHtjUW+wEbsGlRNv5kdPB2WWdr0Lm2pzFtZHcJpcKoZ4a2FE45sRM9F151DoL/k9yX3/o9nlYmCYV5kFUVDh7jQ/RKGf+tVlCW2MbpMYdAPWKypurWCqjkTtdVJX2kFu+LnYk7KM5cSKd414NDjWY1UhCtG8/qHuBTaerjTFnrGynMiD80Lq2raWfCeQaimPo786iReHaq4LZA2bxesG8KMxiwDmy0XSUeK8oV6x4v5b98drGGTTEzPLr/76aJ2AiBQXLYnjmvNsiffSO2fDJEQIF6mjPxlmqYk=;5:a941Dnpordnng0zY5xGUQ8Z0mHHjldtN+HVbPj6WGS5PYu9AKBfyOt0q9JIUEcGmVom8kyE4/d4LYNUNYJJczhwlTLRg33I0ORAakpcqtY2LcAk/mRRmMc6poTCoUT3o4aAhKLq2Boo85GIL9+A3HbupBHCskVZQRo8VXvk4CrM=;24:DfSVD3/x5VixS/7BheetVClQoRWkUmoMqJmKj2QFJvD9gEwpjWVeIQ/opXYZiIedp/5b5XSbFFkErjFHbisBI6QC2Ovc6ltFd2rwUpc9bsE=;7:e5MDpqdI2hXMsxVNioxfLQEfZwIZbZRVbzQ4nkeZFI9MyMMhVVsWK+wgKBeMp/r7jkmBCH9ur5a1Yg4md1Mm7Ugl1kjCxZtllUSSna6ceFybpP4E9S+WKwOlohyVCKRzqp8GXuxecDAeGUxr8JdIA7X14JEyIzjlAnk6V205LAmhgG+u0U+SrZ7hVFPZ5o2PlR8wr4WUXg0EsPAbYLHFqtDPzTv7NloxjJluSGdm4PibDFFOc8cCo4GMEv9BGyKV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN1PR12MB0160;20:W+oEvvWU7mBAlhgYbj+nimYljvQXHMAitL9vBDQtIMe831SEu0UtZXJwLR1pIk7hiR3xzvqM+4pHU4WU/0p1tmKF/kQXHgsKwPbG4pnohLFUS72HFTRXjFEYarn73Zau7QJO6GgFb9syZ0YR/g5YuzIc5lMbKwZ/2UI1/R8ynpg8MP/ILyKfOBDW/S0YRg5rmM8JmC/GBbd8+Xqs8stI16iiz0k3SOuRN/uyKDXCm7uguljgnSk+b1K2Z6XS4Eey
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2018 18:26:45.8172 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a2a85d6-3875-4783-6be2-08d57aeaff6d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB0160
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/23/2018 12:05 PM, Paolo Bonzini wrote:
> On 22/02/2018 16:56, Brijesh Singh wrote:
>>
>>
>> On 02/21/2018 02:18 PM, Al Viro wrote:
>>> On Wed, Feb 21, 2018 at 01:59:55PM -0600, Brijesh Singh wrote:
>>>
>>>> Sure, checking access_ok() does not guarantee that later
>>>> copy_from_user() will not fail. But it does eliminate one possible
>>>> reason for the failure. We are trying to validate most of the user
>>>> inputs before we invoke  SEV command.
>>>
>>> That makes no sense whatsoever.  If user is deliberately fuzzing
>>> your code or trying to DoS it, that "validation" doesn't buy you
>>> anything - they can just as well feed you NULL, after all.
>>>
>>
>>
>> Currently, we let user query the blob length with params.len == 0 ||
>> param.uaddr == NULL. We could limit it to just params.len == 0.
>>
>>
>>> What is the rationale for that?  "Userland is accidentally feeding
>>> us garbage pointers" is the case where slowness is the least of your
>>> concerns...
>>>
>>
>> My intent was to do some obvious failure checks on user inputs before
>> invoking the HW. I do see your point that if userspace is feeding us
>> garbage then slowness is least of our concern. If you think that we
>> should not be using access_ok() in this particular case then I am okay
>> with it.
> 
> Can you please send a patch?  Thanks!
> 

Sure, I will send patch soon.

-Brijesh
