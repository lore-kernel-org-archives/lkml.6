Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeBZQj4 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:39:56 -0500
Received: from mail-by2nam01on0048.outbound.protection.outlook.com ([104.47.34.48]:26048
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751510AbeBZQjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:39:48 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: `do_IRQ: 1.55 No irq handler for vector` on ASRock E350M1
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Paul Menzel <pmenzel+linux-irq@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <8bb6b660-ce08-37a7-d1ab-38a690595856@molgen.mpg.de>
 <alpine.DEB.2.21.1802231914590.1437@nanos.tec.linutronix.de>
 <20180223190950.GJ4981@pd.tnic>
 <61f2fc82-4eee-8678-c37a-dc300dde4edf@molgen.mpg.de>
 <alpine.DEB.2.21.1802240941190.1825@nanos.tec.linutronix.de>
 <c84da3a5-107c-2ddc-d108-ebb33df49719@amd.com>
 <20180226163102.GM4377@pd.tnic>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <df579103-8d85-6fe4-4ffb-ce9cff5e5a55@amd.com>
Date: Mon, 26 Feb 2018 10:39:42 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226163102.GM4377@pd.tnic>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: BN6PR14CA0041.namprd14.prod.outlook.com (10.171.172.155) To
 BN6PR12MB1138.namprd12.prod.outlook.com (10.168.226.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fab85f63-9262-4afb-b00f-08d57d378bb4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BN6PR12MB1138;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1138;3:+YRWOjlC5EIC0RCkQMkMBlWTk5vpqkexz/TkusDcJ2d6Z9mE5Dl7Nj0vkxfRcYiZNGhLNmNzlarNC9vF3DPNimrG5N84YLrq4TJY4XAKnAf9Ar4sl4a0efL17UElDOjZT19xO4qI3HC8frNe8tUOvw2xAoBNkOXyyZeA9TnES1pTsfGWm4xRCqMGXsKZEzZUCG3bXP8plpmWDRD+xHbyCy6vCGH3G631KXnDikyNEizxd1CuYTehxVi/vpDvQudW;25:MO6byOag6wuOHOpZPt2512pyq0DooBnQVuA4J3Y7GAE91zFxDOgEYNJF0CMR472ihd2VF1d9euGvYlSfb7Zmt6vE+OXbRfRbjb4MvyP0IGWV3+uNXBCjG0R6uwc6346xfKdhN30EePqcHL6i9lWy79masvcoHvgDfYNfJCpJbM/4eXWDoqANA7ZEebIhUdRbKcOf9kgdcXpr5Qj2jp6u9GQf3UNZfPGVB8gOja3JG47/rKsq6Hord3bi8Ra8eyDOZs4tDb/ZaWFgm0SsEIKd/N09tVE1RScjz6Jq5ACba8vWHg49bW51FrEh5edUliOdAmzCJ1Yl2sd3E9XLfbt1FQ==;31:cWU7KtA+ozlBEHTYwTpNzKx+eVKFPiRuvF/ItD7h/4Imgzys8/i9UtTFIpVEvQaK+XNut7rjf9K0LtXP9YfJ74yMAEpfBdsZd31zRde8OMOSP20fw+zkGss0mq6odFgEmSHyYkhWCMPINpBrlvI0SihcLcfeF+23uPAoifv1sX7OXxkid0O3MJ0RZnLXZ+GiNr5dmiCzAtaMpJ7TTjXUcy1HdYRjL81PrVC7CS8VhA4=
X-MS-TrafficTypeDiagnostic: BN6PR12MB1138:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1138;20:zVMstPXW9JhXLpKTa5LxFFVETPUD6kAM7TNUNLO9MlKSsrNgEI4iD/R1QvFky/Hj7B0O+jSOvXg2qvLk29/cZytOxkegKcIT2F8Rt6lQDvjYkKdUMaikGQHmHZF2yjUD6/JYMtUZ1z7EhhhXxj3H8j27HF1Je+IE6dhYo2rbAN68UXv9IuK9yKE0vR9I796RRn1+jj5MS1Mra7eXba0OfBHfqf0an5USaRqN0/VgkgTRYTOJmA7B+wmjfk2h7krC1R6okK3SLFuRQ1kXQlRPGXbJ+LVv7QvuwqtygoZYMS0NAwxKDZkjN0qZoKEFulXeglF7j88jxqIKHW9vMNB6XnMs08T3L9RcasUzBYJYtVqxP9rlDglX7xaYMowff7D1FQ0Bj6qnHCo+Vmeksv7idI8hmVF8g9DItpDkIzeqjndVRo6VqZBrKE1IKN12cgId9cmKO74dyAc8cGajSQGiVVoXGhkqfmKJmGUECFvJG83KpEwgcKwC7XdF6Jff4iXM;4:jOfESQwxgqTbEacI2TFbwYSc3qkKBqKmthDA+t3sVP1nJa6hR+x5BsadxPpDXkUYco97HtQ8zufyGTZwfNZkvz44xB3Tw07AMGL742+v4FjMf0IuVE9CKqT/9yaVwt7UK1852Bjl0hdJGkKHORX1sqMJJ0XiPYVbzWafB118hJVQmGN1x+Y6NuWdnkP70xgzlHo8Ii3Xk9QYnWPU7lz1R5fGytDAsCJCDih3BnNgoDmURl2bn9gS+FdHuHXDFaR13ulWUmVSlnrRBPhy/CqKdk+zkWmm9q+pZQZRxAAMbulVldm25Wz2/itUfBUIhqBY
X-Microsoft-Antispam-PRVS: <BN6PR12MB1138289C28CAABBF48CAE949ECC10@BN6PR12MB1138.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(20558992708506);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231220)(944501161)(93006095)(93001095)(6055026)(6041288)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:BN6PR12MB1138;BCL:0;PCL:0;RULEID:;SRVR:BN6PR12MB1138;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39380400002)(366004)(376002)(39860400002)(396003)(199004)(189003)(65956001)(65806001)(90366009)(6486002)(66066001)(3846002)(31686004)(6116002)(58126008)(81166006)(8936002)(106356001)(2906002)(5890100001)(305945005)(36756003)(23676004)(52146003)(93886005)(5660300001)(86362001)(81156014)(8676002)(47776003)(575784001)(68736007)(7736002)(105586002)(52116002)(97736004)(2486003)(4326008)(478600001)(77096007)(26005)(31696002)(76176011)(72206003)(230700001)(16526019)(3260700006)(25786009)(16576012)(50466002)(316002)(229853002)(54906003)(59450400001)(64126003)(53936002)(6246003)(6916009)(65826007)(2950100002)(6666003)(386003)(53546011)(81973001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR12MB1138;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjEyTUIxMTM4OzIzOnpScEswbjRtc2U5Q2FzUC93QTF5d3lzbUtu?=
 =?utf-8?B?U0ZOSDVPQ25HZ01TYXBXZmNQOG9DajhseFVTVGZnNi9yaUdGOFpFN0VIZ2Rh?=
 =?utf-8?B?UXZENzZhdmJzanRSaXdZc0RnblBLK0JFWlkrRVdiZVpFMUZ1Ukw3K1M0eFVP?=
 =?utf-8?B?aDBad0lTbUh6RWx6L1g3R3MwSGl3c2hiQk11cTFweFk4eUlwMGMwcUZjYlpY?=
 =?utf-8?B?aHNQNlhCTGp6QTRUQ0tmYTgvaGZEdTc0WE9ucUh1bUtCZEhlazJtUFpTNWR6?=
 =?utf-8?B?WDhIc0V3K1JFekx5WUF2ZXRQNmZXUzdtNmF5UHJvSUg4U3ZrSVhBS0ZLUEZo?=
 =?utf-8?B?U3FwVXpUMVBwemh5NzM0dmQ2aFpSeThxbEJ4YTJEWVIxMjdHaWxsZGNsKzdQ?=
 =?utf-8?B?aEdoSDVpdlowbWhFNURNTW5tM0NGQTdRZ1JRdVIxS3NTOG94enJoTVhZb3hi?=
 =?utf-8?B?Zm42WjdNanFPZnRQNzlvdGpHME03VThFK3dsTVhYSkNoRmJBWGN6OGtHM0or?=
 =?utf-8?B?NmZuMFk4clJJUGhmSmdHeE9vZyt5UFV2OTVuSVN4eFpQekczdVVIaVNZOWkw?=
 =?utf-8?B?eEdzM09zWkNlUWszaWNZZDRpZ0FxMkVPSDIxbjRaOThzcVl0YXhhQVRXa0dt?=
 =?utf-8?B?Um9BVWYybUhCa0hvdkpXTkEyRFZpeDNJNzZBTHdmYkJwRWtnYk5TVUdUZ2RV?=
 =?utf-8?B?SWh0Wi9PeXZ2cjNtUzMvdDU3cENlRERxM2NBSUdDWE9NVy9SMlJwZ2FRanBV?=
 =?utf-8?B?Q0czLzBaaExMYnY4RnhpczdkMGlEZHViNWRYY3ExR0l2ZEFJWTExMzVveFUv?=
 =?utf-8?B?VWpGYkxzNGNXOVY5SjBzUzhvWDVnVTdsdmVUK2w2RlM0WTdnMlNaMTNTcjVP?=
 =?utf-8?B?Nk5HdzFNREY2N1lHYUxPb2hRcTNOWEpIQ1RCT2dZUGM5MDZZUCs3MW5QdHpI?=
 =?utf-8?B?M3RxRG1XRmp6R2hkandiOGVqR21CS25OQUo5amduc1dwWFdjQ3hxYjQ1TG0y?=
 =?utf-8?B?YUhxWnd1U3RtanZvMmRhUlo3NWMxUzd1U241ZVB2UkVpOUl3cy9SanF0NWkz?=
 =?utf-8?B?akxlemFlb3k1eXlvZ0pvWWYrWmJLTU1BaWJGRUN1WThnUU1SRXJzaGE0TUUx?=
 =?utf-8?B?QXh2MmJ4R2VEVDJsL3ZpV3F6eVNJSmI3S3VhU1M0Z2lucyszMVF3eEl0Y2Zl?=
 =?utf-8?B?cnhIU2lFVG5tcXFzbHdpSFovaTk2MlFoa21ocjNCa0M1S2llWlkxUnBxOVZr?=
 =?utf-8?B?dk9IVTlmVWFMVXpSZWNlcjJUTGdBNEQ3U1JlSFEwU3FCalk0N3BuOUNnVnoz?=
 =?utf-8?B?YVMyNnN4SWRrUDdPODZIRGJDQ2FKU0tuWmxUWHBHOEV2UEZRckduRFNHWkE2?=
 =?utf-8?B?NUtvRnpVTHVzYXlBcW9vSTRzbEVHM2tmWmltMVdWT2x5R3pmZ0JCUlBWWDNX?=
 =?utf-8?B?bjlSOXlpazMycS96blBjd01NL2J2N3liVUl3dmludC9jd0c1ODZpR2wrZlBh?=
 =?utf-8?B?NjExZ1ZYT1ZkZDArVS9iUHlDWERYQldLV1B5Q1VDbUlaVGhQMmxYUUE5Wm9v?=
 =?utf-8?B?WFVBL29vQ3ZFVjFvVDlkMERMQ3lzZ1FjcXpwVTFNdlVLL2hSU3VEZkd3bG9n?=
 =?utf-8?B?ODAyN3BNSis0QUN4Mjc1VTU1QzIvZnVJSnNEUDlwQ0ZRdy84VmJTRFNIOG9u?=
 =?utf-8?B?bDBwUzBBZk5COFpkeVZmVjZvVzgxWDl1SFNPakVFSEtqLzN3bm50bmFpQURp?=
 =?utf-8?B?bDZ6SjN0bCtSRWNManNTR0pzSW1BWW1mRmhZR0hXMC9tbVJPV1ZFOUJvcVNG?=
 =?utf-8?B?ckR5cm9NcjRBZ0ZNTS9ROWYxR0pjdG1XQ3AxZmhzQmhrTklCdUlKb3ZQR0dz?=
 =?utf-8?B?MXVsbkNiaE92TkZFRmRBbkE5T1ByVnlTSlFpY2cwSkNHK1JHcStta1BZcnlO?=
 =?utf-8?B?aHJicmh2cXJEMktFTXhWZ2ZJYmZ3NTJVZW45cHNzcnRqRkFGK2xjTDlpK1pa?=
 =?utf-8?B?R1JIR0I4WjljYk1pQ05JUGdsZkpPTmJUOXhycTVtajNldmFFYnNYdWFBMnNK?=
 =?utf-8?Q?7zHJJezsTCl5kGqiU9Y4Kmfx2?=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1138;6:ssBdy3K5cZadXna/FIccMhqpRWDGixeIhw2GdEaud4Z8jzTln0lVuBLEOOVA1h/B2reNmXuw8Z4aj9m7QW7myY5XRAymLMSjFmR6uSEdU9z5A+BkBhDid01zRRS23jEHMJ4SZsoswpovk0hI0zMboah49y4U1E+FMvhlROJ6Zy624KKStm8ItRTaCY7ou/CjjzpjnKcuNFCOwH7TnNwnOOM4dV5XJFf+pltG4XipX6NCp1Sy6YgSdM98QodWPfCS5jsFIz42sV3u9WU2ky0KnY608ipxeJxKj04cDKnoS6g+TMoE3aWS0V74Q3B7oFMb2V2/xirfuc42K4an/rb9/x+zKVPdFS4lW24sw09RMX8=;5:sa5nIhbgdh7Tnf5Im8XR3EaOnsY/lx88tpgE5eHtPegjzc/A94a7GsrmCVmZlfTko7fjIMv4fmATzQqnlgay2mrD8MfYCyJZTrepqmVTmTrwO13vv0pfF63lUPEX6bN9y0/yQAZfbyhFl3OB1ywXiRMjN3KCzUsH0V3Ujccp3Nk=;24:yrVafpYZODkN/S6TgSydIzX874NDdqJOAKy4/BD/ws9FPK8/lPhs4PLWOdyQp55ZpsWdqenOkncW2kmFK40se2jy0Rob4juL/R1WHrPl18M=;7:XA09JjtyqjzFdRrovHwzQcxTVrHoowzamTjqZmXnB3WVGC3fIXS8GVWIL8vFwtCXgjOrTLd5YeByxRrRYK9jzD34RERilpTiKtriXi0BwOw/M3EEO6hFO2BN7GQHKm7120SQWS4460rcZumWLTlk29k8gDrbKfunKihmZEqeozlywnLdDUs0CDxooJk1wn3moxwVnfFkv9ssN5lVue1JtBPxvUHinw6W1N0iiSWshw4gBkaKvwTpbA/BTa7toFIA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR12MB1138;20:l7XpLLrS+AnEvRTGXSMMM1iQrMuvamsJA/R9qd+Uj3iS6DEItYd6XgWxzh+vf5WTX0JeGCYfDpwkhkHjuBBKt9IUd3XjEjWdguSU9Xh8DM4a8cujsnPWl+v4VbFUCZQ8z7WfheyxagLsh8tbKGa+czoJnqb6yomvJGNws8Lu1NnEGI44SuJPO2ka8sYG1CQtBsvBZj5uUtW4dQhDoRgew4mMz5/8lxwtritSw+c9YjKSmhYbfnM9TwjU6uoDeVGp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 16:39:45.9903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fab85f63-9262-4afb-b00f-08d57d378bb4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1138
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/2018 10:31 AM, Borislav Petkov wrote:
> On Mon, Feb 26, 2018 at 10:14:10AM -0600, Tom Lendacky wrote:
>> On 2/24/2018 2:59 AM, Thomas Gleixner wrote:
>>> On Sat, 24 Feb 2018, Paul Menzel wrote:
>>>> Am 23.02.2018 um 20:09 schrieb Borislav Petkov:
>>>>> On Fri, Feb 23, 2018 at 07:18:34PM +0100, Thomas Gleixner wrote:
>>>>>> Borislav is seeing similar issues on larger AMD machines. The interrupt
>>>>>> seems to come from BIOS/microcode during bringup of secondary CPUs and we
>>>>>> have no idea why.
>>>>>
>>>>> Paul, can you boot 4.14 and grep your dmesg for something like:
>>>>>
>>>>> [    0.000000] spurious 8259A interrupt: IRQ7. >
>>>>> ?
>>>>
>>>> No, I do not see that. Please find the logs attached.
>>>
>>> From your 4.14 log:
>>>
>>> Feb 19 09:48:06.843173 kodi kernel: CPU 0 irqstacks, hard=e9b0a000 soft=e9b0c000
>>> Feb 19 09:48:06.843216 kodi kernel: spurious 8259A interrupt: IRQ7.
>>
>> I think I remember seeing something like this previously and it turned out
>> to be a BIOS bug.  All the AP's were enabled to work with the legacy 8259
>> interrupt controller.  In an SMP system, only one processor in the system
>> should be configured to handle legacy 8259 interrupts (ExtINT delivery
>> mode - see Intel's SDM, Volume 3, section 10.5.1, Delivery Mode).  Once
>> the BIOS was fixed, the spurious interrupt message went away.
>>
>> I believe at some point during UEFI, the APs were exposed to an ExtINT
>> interrupt.  Since they were configured to handle ExtINT delivery mode and
>> interrupts were not yet enabled, the interrupt was left pending.  When the
>> APs were started by the OS and interrupts were enabled, the interrupt
>> triggered. Since the original pending interrupt was handled by the BSP,
>> there was no longer an interrupt actually pending, so the 8259 responds
>> with IRQ 7 when queried by the OS.  This occurred for each AP.
> 
> Interesting - is this something that can happen on Zen too?

Yes, that's where I remember seeing it.

Thanks,
Tom

> 
> Because I have such reports too.
> 
