Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeAaHPd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:15:33 -0500
Received: from mail-by2nam01on0067.outbound.protection.outlook.com ([104.47.34.67]:63072
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752494AbeAaHPb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:15:31 -0500
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Subject: Re: [PATCH] mm/swap: add function get_total_swap_pages to expose
 total_swap_pages
To: Roger He <Hongbo.He@amd.com>, <dri-devel@lists.freedesktop.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <Christian.Koenig@amd.com>
References: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
From: Chunming Zhou <zhoucm1@amd.com>
Message-ID: <9ecba5f4-3d4c-0179-bf03-f89c436cff6b@amd.com>
Date: Wed, 31 Jan 2018 15:15:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1517214582-30880-1-git-send-email-Hongbo.He@amd.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.34.1.3]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(39860400002)(376002)(39380400002)(2980300002)(428003)(189003)(199004)(72206003)(4326008)(478600001)(305945005)(105586002)(356003)(59450400001)(76176011)(7736002)(2486003)(23676004)(68736007)(36756003)(64126003)(6246003)(2870700001)(104016004)(2906002)(54906003)(31686004)(110136005)(67846002)(58126008)(3846002)(6116002)(50466002)(97736004)(31696002)(316002)(8936002)(8676002)(65806001)(65956001)(81166006)(83506002)(81156014)(106466001)(5660300001)(53936002)(65826007)(77096007)(6666003)(47776003)(229853002)(336011)(2950100002)(16576012)(16526019)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1275;H:SATLEXCHOV02.amd.com;FPR:;SPF:None;PTR:InfoDomainNonexistent;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM03FT038;1:TRSvw8OKNrIaTVTYQNuZmQ6qFG4Pi6rWUfTTfzuXYbiTwonrooU3aF+B/FaqhpmyKnsTmM/cc0PZ79epJ4jGvNJ9glqb+Ng9HBsmnBGykgvOjkkgPcfTXUpw5hexitml
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2967e3b7-30e8-4f54-9038-08d5687a6830
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR12MB1275;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1275;3:B9J7hFESPL/RGBBd2jndy9Wn5yEPWSIxkQZYz18prgdQbfHU0a3VWyXkDSFZta7zMrDrw1b8yzDPld2UwM6bAEG19KLRsJeqfraNHkjGzk98V/VduslXg94a3hZ7YF7d+R+BH1rZ0QB6l0Ly/wb8aYOFNDuqnEVOWOQA+4a/DmH9VSOYKOVCj5VVsqHIy3BlvafjNeakX4o3AMA1qU/HRmEnzZKhND0bUQZp0rqukE1T26KfSAumRbs8XoloGaOZP57dNSF053fenXA3PlEPZv/XTGqUphxGmdNTpv4FX4m/l3hMYCgcG6fXzQg/7YNQ8yd7XxPvfgmXyY/g7QWtGLngLklL3mmnNGTXnm1lK9w=;25:i2HHBeHS+JK2E10g8mRdFa/FDmSNrttBe54iiyz/B6qrH6db8HVU4JNTmDLMGkwFQi/fAN8xiY39p01S0GHXM1DQHjknPRxXjIfHLtc8WZPt776DTQFBAEQIk1hgP5u/bVziVAAu4KtHV9UTzGy/v5k7VPVO3h6E8Uog4j0E90qwoRyEb4JdYK2amsf5w8i3qnwt2FcTbREdYdHzh/wlj7x5e92BsDIVljSLqi21Pr1ZLiAzYu3MsQ/Nq0zAdPyvR5WC7KFLed0mKDLp6LK56RXe6o5EvCp3NID3KH1OsKY0GtccE9FoSdRkRq3AwES5ura2D7LzfTxSNxVOjsDong==
X-MS-TrafficTypeDiagnostic: DM5PR12MB1275:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1275;31:h/kIRWJ1PzigPN4krwz+4ELBaBe7ZY7RDX3V/Pf7KcH1HKzRveJx4OOwyX/E7LQUNipv++sHfHeOpDSkTZ++5VH0izBGKy40vxauEzlMWs+yef+BsSW1BU+Aup6lO+rANFwI37nhAzp7D/wZJl68PG3k5xTOz28VXXIw9EHj6VdgiMoNKvwZSxj2uCD2lVxKOlY/TwxSPE54SnU55W8DNNM4+5rydkkrYwQZPP8N8lc=;20:ubKnHAeVbdWGJpQHxa9ZYGB8GOpXyDPjQMICR7TgQEmfCHKFwDEjjFMPliLvsAU32vchorjK3JKeNFTH0iRgmXibMLVKV+fGgKsTgZdLSsoCDW/G+T1E1eBjnMCjYENdkmP0LeQNV9LOJkBtuiUCZ8aFxtdtJpG0NDE5QnB7I8GWnRCp5+sc8y2KQ93YpbHmuAdMJrsud1BGp6zIKGj3C6qqZzA2DHSIObbFdpCGVgTWMxPq3OwssPzW5g1QuCPyhFKPOnBuPfPS7Q6pEgiuNwedLZRqgF4aMDjs/PIA5eICnzdMupuD97U1Oh/ArqsT0RhkXQH49/mN1IImtEeRUucay9VylSGc5gJp6XMDN0MVEcJYkixgld+HOtYOHH2Um9rQdu1P7lp6yR9Vj7FUpM7txlcsn8KjESayVxgnUFiodri3hkLT/ak45zd4BN2po1wfxrRHax1DwLIqUAwXwqRgm1WBKAWFBUcC4zCodfOLDW6fG1cH8Z5a7jXp/fQe
X-Microsoft-Antispam-PRVS: <DM5PR12MB1275C53EBAEE4DDE258223ECB4FB0@DM5PR12MB1275.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93003095)(3231101)(2400082)(944501161)(3002001)(10201501046)(6055026)(6041288)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR12MB1275;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1275;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1275;4:/M1RfhBLM/31o0tsNrex51+7zcmW4TI/adjWcKY+IIabT4/hSduJytITFtyrysFfLZjtnNN3hstJX7ZUbmDnhnANEIUYr74b02Iq406KGu3uzUM5WebBF4xtCbIdeAgE5c6x3Je02K39RIqr0ThfsudmClMeZKrHkTeoPeFsCi8CZ2G9HYoM70Ag0Kxinfw0FJ9MNk3WtP28kqGasZ0PWpchB6nnPcG/2tAaHnP6tth/nt2KPK1M26suNVYCLo4wAjiAzicy/lrGapnML1AaMbUVl8JQHTmHcXpXBQgSjZq14O1WV/EbVpOtIJL7IYBU
X-Forefront-PRVS: 056929CBB8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxMjc1OzIzOjZtcjlFYW5HdHJsdUduS0l2NTNWSmpoN2dC?=
 =?utf-8?B?NTlMS21qRk04M1pTQVNzbFNzeEMrR2x3NVNNbFkva0JPd3BCNDFLQUM1b2Zk?=
 =?utf-8?B?R0VJOExjMVdkNjF4L2Y5Mm1ISUhMNC91VTQ2djNrVlhzRVVPZURBNmlkT3lW?=
 =?utf-8?B?T1F3QWFOUG9XcFFMZ0FtblQzQlR5enFzL3A2M1RGdmZkR0NkMi9MWTlIZXBC?=
 =?utf-8?B?Rnp2b0NXVE5ubHpTaXZhM2RWZThqM0R6SjcxaWMwV3haTVk0dUVXUDM0Nm9k?=
 =?utf-8?B?bWdTRDMvWkZBaDRLaGxMZjRHTC9xeG1TV3hrTmtyTy9iVkJjTzNYbGtPYzk1?=
 =?utf-8?B?alkveHFtSm1WOGdadkxHN09MT2o3Ym5Cd0RWd29QSzFYU2UrczhxUEt4Ymd0?=
 =?utf-8?B?ZXVhSUVJSjVzdHYvQUZBanZ1aUNIZUt3RUY4eHIxMHplRDVzVlE1V3pYU3FW?=
 =?utf-8?B?VWpWMCsvQjRsVSs3U2RaMGp1TnRwbVBFTzdWbGViQlc0Uzd0cnVmbURPNTcx?=
 =?utf-8?B?dHNiWmxpaFZpUS9HbUF4S1BOcS91cDhjelZpTEFLSGFzZXpBbVErQmhHeXVs?=
 =?utf-8?B?S3I5SmxCVDh6WjZyMlZVblFDb3hxQk9vdHlhaVFVSkpVeVBINUtvQXRJbWcz?=
 =?utf-8?B?Y01CaExjeXVvNmdRNFVvQVpHWklrelJKU3NXQWd2azg0R0k2b01Tamc2VHBn?=
 =?utf-8?B?cjRYYXkrS3dqY1ZkYnloemxDcGVsSTF0dXFyam1WTXp5aHVMdi9XUVF1VFJE?=
 =?utf-8?B?ZnhEcWhad3BKbzBuajNzdlJPck5JekhuZ3ZxU3dBUkVkNmtxYldrbVV4VWZI?=
 =?utf-8?B?eUZLVTQ2eG5nTVlRN3ZZYkNWUGZwWWxpRThVWjdUdnl1Lzc5c28yZDhaQVdT?=
 =?utf-8?B?VUdoRmFKVVlJMGlnajc3TmJiRFJSUTRXbjJPR09ibHk5bDhCNFdldHJxRVY0?=
 =?utf-8?B?U1JFOEVWdXdraEoyMHA4dS9pZ0pIQzl0N05ObGU2U3Q2R1dEejVyWGQ2VnR2?=
 =?utf-8?B?ODY0ay94SzRJZ0JrZWVuR1FSS3pidjBoaXk5UWh6SmVNYmw1QVJVK0R6ci9C?=
 =?utf-8?B?NjVWN3lpVW5TbTNnclpIdTFkTVBLUWVaNGRBcFRmQ2p0VjJhVmVtTWVPdU1N?=
 =?utf-8?B?c0gvMWJ3NGkvQ2hjdnRnNkwrTmhXVHVpMmxVYys0WWlISDJOOWR2OXN0M0l3?=
 =?utf-8?B?Szl0cW9Cd01wZ0tMK0lFUVRFUHQ0dVJpcmtDaWVtOGJ5OW9XM2JXVDl2K25L?=
 =?utf-8?B?aU5PcUNndFRMc1Y5MUNyZzFVRFdRTVV0UzQ4THlVMWZBOXdRb0M4RlNFVmxx?=
 =?utf-8?B?YVpFNHlaaHhEMUJwZklXMGJkQXJDMDNFUVJMWGRQM3B1cDE3VWQ3QzFWckYr?=
 =?utf-8?B?VnhQb3JRQWc2YW81U0hWZkM0NEJJK3ZvWnd1NkFuTkdpNnlEblo5TzV0YjlD?=
 =?utf-8?B?bC9KRnNBdG1DdjIwUlk5NDMxNWRFaWVYMlpNMGFmdjhkakIrZGxmdnU0VTAz?=
 =?utf-8?B?UFJGNmQyNXBEWjhSbFNCRGRUZlVVRm5BWUE3S0ZodXdCTEJsTml2U1E5QkdQ?=
 =?utf-8?B?Ym8zN25xOTVPT0lmM2NGU3J4ZExmNnFQMkpWb2dDeXEyRVNXVDc3OS9GRlVG?=
 =?utf-8?B?WVdWNHhQV1F2NlhBOExQalVtR0VYMTQxQVlrOEEvWmczbVJETGx6K1hUdDBu?=
 =?utf-8?B?NDk2WDhMQi9NNTMyTG1pTnlteCs2OUpvd21ZWkhNYzMvdjgvUjloRGxmMnU3?=
 =?utf-8?B?QlZyVFZmdEVicDd1S3ZVOEFhYWpSRmRJYjNmY1Jqc0ZaVW04VUN1dnFYZG1H?=
 =?utf-8?B?cFJLejY0eUlRbWNyYkduYStqaGxIM1c1aEdiRXplWGhsOEE9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1275;6:kwPyizaSYNGr8YRzmfth8AD5K1wBv9L17T8BrqROMhYCkVYefpvXGNuKGhPlMb7khccaCrUh7X2q6vqyimfxtBpWbJ8q8vGj9fdLhZov/NpDfbHkEZOhlQjr/LrqcKV3ZlFUr9cWuTzdk5RszdcroGShrT1Sqh8iXBCEm8I3mv3V31yT8qLuaQvUzaT3OSX/YsJy54CAl7rXCvWVrU6H9DOmyOYGr+rCezREQentHdU/Hv1PwwCvEV02BAG8P9b2RqoSR6H9PNBcfIVdiyxmGT8IZ0u/xEctZEX4V4zukwUNkyWOUbWcWkDG5s10VEevHNnnnskJeNYUIlIgjHPAeqh0OzFp6W86uOo2qmqxAVQ=;5:OmROP3Fq1hPrZVZUVuzm5c0shyFxWGaC+6qVno4Q5+SYr6HDRroSwlbhbIBoQEuIID0sHEdT2Vmpf/ypUPTkLtC4LfnlPDELq01wAyLN5rAtjNbFBqTU9kP8fNx3Cez7djkIdYl5k6EJYclOrLPrjN3c4U1xuQnbMzYiDCE3lTA=;24:g9GyF2hi8uIM6kH4umtTexH1IXTLm6kwFsxNeVogxtILKw8hBWqU6oiwNwzRHvtefXdZbjO3vQ/SFM3HDTFRAccfY+ItokJeb9/rRtJTraA=;7:NP0xNzYQf4QqUMRO78+Uyf9R5O6RzVSAr6DXiII8CvSRS5Ki4iymUlRJbh6wIIOUZ1Zgp9nyrYNnsn1k5R8CEZx+vmUwxMZO75mr+i1sepxDDdStnuy3APF0PBSQSztFFOzR5nxIWPSsEDBVG3XpexH7MxqUQ4clQkR7+zXyFE8lG/4poOYzziQ/3HmZ2hu4TII4lBwd0Fhf8V5UMROP9z5R5L03FG7CZJu2gUeTm9b/lH15sPDXgu7dJ3fAWzUZ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1275;20:lQvMWygpJIAJG3z83X6UkYjbWoQfcNdWgEzSb2lHpXJGADaL6cImvP38IfMDtWFUkdZSiiaWn8XIJ5gadjlI5g/eJ2GZrV8YBO/omBaxpo/3roe+XzZR7YZ6esV6KnPuXlp/rBd0DRUkJnlKX0iMqnvdScNreM+tRoSNCofzzayzhEAnsJY4Vhg80GrZ6bWXYZYT6T2gaTnklfRz11mer/hSGTlrxx/zrd/xrJj4Xzd0LOyWxWqOIhWXIHPAAh9e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2018 07:15:28.4542
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2967e3b7-30e8-4f54-9038-08d5687a6830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXCHOV02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1275
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

I think this patch isn't need at all. You can directly read 
total_swap_pages variable in TTM. See the comment:

/* protected with swap_lock. reading in vm_swap_full() doesn't need lock */
long total_swap_pages;

there are many places using it directly, you just couldn't change its 
value. Reading it doesn't need lock.


Regards,

David Zhou


On 2018年01月29日 16:29, Roger He wrote:
> ttm module needs it to determine its internal parameter setting.
>
> Signed-off-by: Roger He <Hongbo.He@amd.com>
> ---
>   include/linux/swap.h |  6 ++++++
>   mm/swapfile.c        | 15 +++++++++++++++
>   2 files changed, 21 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index c2b8128..708d66f 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -484,6 +484,7 @@ extern int try_to_free_swap(struct page *);
>   struct backing_dev_info;
>   extern int init_swap_address_space(unsigned int type, unsigned long nr_pages);
>   extern void exit_swap_address_space(unsigned int type);
> +extern long get_total_swap_pages(void);
>   
>   #else /* CONFIG_SWAP */
>   
> @@ -516,6 +517,11 @@ static inline void show_swap_cache_info(void)
>   {
>   }
>   
> +long get_total_swap_pages(void)
> +{
> +	return 0;
> +}
> +
>   #define free_swap_and_cache(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>   #define swapcache_prepare(e) ({(is_migration_entry(e) || is_device_private_entry(e));})
>   
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 3074b02..a0062eb 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -98,6 +98,21 @@ static atomic_t proc_poll_event = ATOMIC_INIT(0);
>   
>   atomic_t nr_rotate_swap = ATOMIC_INIT(0);
>   
> +/*
> + * expose this value for others use
> + */
> +long get_total_swap_pages(void)
> +{
> +	long ret;
> +
> +	spin_lock(&swap_lock);
> +	ret = total_swap_pages;
> +	spin_unlock(&swap_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(get_total_swap_pages);
> +
>   static inline unsigned char swap_count(unsigned char ent)
>   {
>   	return ent & ~SWAP_HAS_CACHE;	/* may include SWAP_HAS_CONT flag */
