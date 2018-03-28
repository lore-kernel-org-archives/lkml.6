Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753037AbeC1RCj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 13:02:39 -0400
Received: from mail-he1eur01on0096.outbound.protection.outlook.com ([104.47.0.96]:56994
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752161AbeC1RCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 13:02:37 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=aryabinin@virtuozzo.com;
Subject: Re: [PATCH] slab, slub: skip unnecessary kasan_cache_shutdown()
To: Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Greg Thelen <gthelen@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180327230603.54721-1-shakeelb@google.com>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <3d48de97-0e5f-eba4-0d66-32eb300b79c3@virtuozzo.com>
Date: Wed, 28 Mar 2018 20:03:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180327230603.54721-1-shakeelb@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR07CA0034.eurprd07.prod.outlook.com
 (2603:10a6:7:66::20) To AM6PR08MB3253.eurprd08.prod.outlook.com
 (2603:10a6:209:47::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0104f618-1c11-413a-afb1-08d594cdb344
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB3253;
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;3:BOT/wH+AciimSappRJKtiLWf7AjHn7vtHPt1rRPF7iyAsz+6q0FFB6V6UO0ggnYuUU7jlU30ebDOGXu44UWmUM+RKJJ3Sx11v4lRJHTQNpb1C0YKPVaauuGOV+r9UryEajK2cyYYQW9Y12xMC5p5nRTo6CjH3hBvLMbRKDa1c/N5r2Sn6J6fyk1HEpuPcX7yF/kV0d2k7OvBSagqOv4dqviu4bmZk8jRfHkOLD1lWIDa/NA0ffCw5la3j4eWSqnU;25:TBEe+WBIT3AVkjzkxj11moVEgsGQeK3e6kwYSd8RLS1uPx/y7TunQfscCsPYmtuh7/yLlU7kXqbrb/kLGI8IB3z/NmOaHDxA6HORMXgLthpa9TaBa3LmaoDMgL5AftqvJy216iGg3H0fJA/7IG3sJA86GKsWdhKNZ7SCgMjmqw1i+PMIGna/4mmxG+3L8GudtfAPJkSiugPWOA9J+U/ZQ383UA1rXLKOq7o2FECATXeHImvEUq2cKKvH+uT6dkggfK4CpyXnU3nYJsi+33PparBzEcIWtQF7zxTgKxXBPyK8DMWfsMxq4MVOwsOvHhvX/d7dFtSwD0s4R3cEvka94w==;31:qK31goTOxmLcqJJN2c/Qym8gwfxdBH3ifcNhfOychFRpVFA8CPFUFWRIZJhyQE76y3irUSYvzF6jmJ4JTudMp1d+H2QMs/UaMVQ6xmq7oHID0m5NbUBTxkv2p4lOhMJNduZRFsZ9fqDNAAVFnvzZpfLN8sj7Y0bA42R9Jw7R+H4K5YPcbq7a0iPjca8Xz6IBEzJiPrRcVqtdJ0hbCmb7mglzrCjYM0CknuPHzK1NNLg=
X-MS-TrafficTypeDiagnostic: AM6PR08MB3253:
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;20:VJfUntm7Dc/gtKgULgC0u6bEkPMqDxA2gtbo/N5wD3mkyzpYxBPBNyggk5jQ18QzaeuOM3wNfgpf3s0R41IqTI092DddAR4nO91g0P/bp3jxHMw1SuT1Df5RK8vWJsbxSrs7IKebfP8Brl/rUQ31B58pvK1ThovLnD80+XppwDGIjrcYksaUA8PwDpz8oJEhfThUrM8cVTAQxo7PTDYGkckSafnrmj6cy3jahsnBEHnif747qvc7ooSgao2Bbeda9QxhreYdlcUSHm0GoyUcfxmREqshpsR2EUxNNybTebhW8o85EzscGMjAXeufCOGMkiTtyaqA/Hnn4sRqIyyn3k0s/o7c2ACOaCweVo9eITIdEVX1E6NBFbLsbux/TyGr0/AzAGgmgaXB7UYXP76mB/oYQPhpr1QmM+wBg+6wnP8uZWnJ6b0Sul5NeZp5Z5sieufpnxevBY/Q/5+MpFBrkpcJUNmX/In/TxxqvY+uO9Q8X5RxBl9L+zbX0n4kqfTm;4:67GKDkoEITqhF3cKCnu7eM8MOwVncUh9QiHPYE48Nrhcp8IGp2Rw58Ch4Vj7mbCeIdmEQJ1dIA9OX4UZQSCsSBZKLfRnZzLDJ/1HDvU29B24iyq4PH3c3ejS4/ANjaXokxCMzNf+2yiI5ggv4HM313IFV9wPJfWwFcnaaRTYJMILMkRca7BA05nZ6Wep5k+4rt3hP71KSg9Nb6HSf1O9UyV7Z0SbjPfcAzkCEliybaFpL2DM2BeuibvFo6M/iJl9Ebc7iSfDRACch+qOruSMrqoV8gflqi0+nBUl4omP26H4UhQLmxizHTSIadRfuCWc1kWfqQiy7YJO2L7RfIRoccUVqXn8cbes6HTv5q84Qz4=
X-Microsoft-Antispam-PRVS: <AM6PR08MB325391117ED87D2895B29C66B0A30@AM6PR08MB3253.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:AM6PR08MB3253;BCL:0;PCL:0;RULEID:;SRVR:AM6PR08MB3253;
X-Forefront-PRVS: 06259BA5A2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(396003)(366004)(39850400004)(189003)(199004)(31696002)(64126003)(230700001)(478600001)(3846002)(6116002)(97736004)(65956001)(66066001)(50466002)(31686004)(65806001)(36756003)(47776003)(105586002)(25786009)(39060400002)(106356001)(4326008)(6486002)(6246003)(53936002)(65826007)(2906002)(8936002)(16576012)(386003)(53546011)(8676002)(7416002)(11346002)(7736002)(446003)(316002)(86362001)(5660300001)(229853002)(58126008)(76176011)(110136005)(55236004)(23676004)(956004)(6666003)(26005)(16526019)(476003)(486005)(486005)(186003)(2616005)(81166006)(305945005)(77096007)(81156014)(52146003)(2486003)(52116002)(68736007)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:AM6PR08MB3253;H:[172.16.25.12];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTZQUjA4TUIzMjUzOzIzOjhLdHBvRCtPL2I0dllHLzV3SDdSSit4TWhQ?=
 =?utf-8?B?bnlwVTRwRis0RTg3L29mSG5WZ08rZzlDd3c5MmRjdnQ2OEh0RG04Rlp1WnJy?=
 =?utf-8?B?VW9CQnZhWXZ6TzJseHpYNy9aUmo2MGZScXdvU0RIL01aeVBleHRaUCtKL3Qy?=
 =?utf-8?B?QzVLbU5nUTNXMGJralM2RHBPYzBYWlRqNUl6ZUVrcW42dVFmcEpLNVoyTUJr?=
 =?utf-8?B?ZDZRVzhZY0VEaGh6Rkt2bmZuYXF6M3djeHB1c05zS0N1NWIraXFFaUo1SWRL?=
 =?utf-8?B?WUx1a29YNnQwMGVQWFhqbTAxdHgrYlBpanFnUFlBZ3FMNFhMOXZmZ3lEZWxX?=
 =?utf-8?B?NmUxcnowdGltRGJXTWlIUjZNM2h1SEZHd1pxRzB5ZEZzT01vTW5nclExc0tu?=
 =?utf-8?B?YlZHWUV1bEhXTnN5T2ZSL0tXdEs1L0JJeU1WcjJpNVVFTEhKOHpUWXIwMlBs?=
 =?utf-8?B?d21BVm1MN1M3VGJpTzhyeW1EUlU2b0NHRTRRZHZzVjZBa1FzbVNnZnFVSXg4?=
 =?utf-8?B?WXpvbUJGV250aWRQYUlOV0IzaG5FL2xwWDVOTTlDTEE2Wk9kR3VOOUhmR2cw?=
 =?utf-8?B?ejF5N002V3hGTzBEczVrcEdMZlJjNitvQTZSalU1Rkc4QjRGRnB3clp3Nnlm?=
 =?utf-8?B?SjYyWGJYejRrYjI1RjRmdXBYYmdPRFovdWpmSUFqckY1anFsZnByUEo2elRh?=
 =?utf-8?B?UXY0MDAxWW1sR2QwcG16VDJXa2FjQWxmTkdkdXhJVVBDVXRVS04wRDVNL2VQ?=
 =?utf-8?B?cEFaZnVIaC9GUkNKSVAxa0VhRHN4LzVkMTdaWDg1MTJlaXpmYVFLWHpwMTBB?=
 =?utf-8?B?c0hmbVZsUklHYTQvUW0zenB4NmNMSkdORnBHUlA3RmphQXZPZVdXbE1nNlN0?=
 =?utf-8?B?WkJJZ2dIZjBDNjdPQ2Q3RUNjUHAzMjc5bFM2MVd5RUNxNUZEcEJQZXA5VHlO?=
 =?utf-8?B?by82dENVOHBtTXVJQStWZkVPT29jcFdtdmdtdXpldXlBMWpVUDU1Q1ArMzJz?=
 =?utf-8?B?dW5id3poWVRoYjFoUmkwMVdOdU9RVVp6K3J6VmtEcitxeWtGdmkrVUFtWXJD?=
 =?utf-8?B?OStvR1MrN2tYc0MxVDRvWHlYb0xyeDJvQmlUSFhrQ2lnbFFGV0tZQjVOc3lZ?=
 =?utf-8?B?djBxdDhGUEZVcVdDeU5YYTltV0NnanpnZStreEJqdDRrQUUzQlV4OGdVVUlj?=
 =?utf-8?B?V3MrZ3liWmpXc1BLRUxvNHdhUU1YTXY2M2VtMVk5S1F6dzkrSjEzWDRoU1kr?=
 =?utf-8?B?Mld2a2RjZVRyajhyM1VjdU9jb25UMGlQL1A2QXYrSnRteE1XcVM3VlQ0VWRq?=
 =?utf-8?B?K3MvaVhFNnowQUUvVlA1ZGppRE9pY0wrSWtiVi9FajByV1lwQkZORCsyMFRw?=
 =?utf-8?B?VUVySUd5U0dXdE1aSCtJNWlDM3NQVlRYU3p4bG12Qnl2OW9oQjBWK2JlbFRh?=
 =?utf-8?B?cXFNK1UvOHlYamNSZ3pxSWg5K1RuS0VIdDhBUm01bWRya2ZhZ1lYcmdsWkwz?=
 =?utf-8?B?eGtSc3lQOXNjc3R6dzR0aUJUY2FQclp1Mk1FK05PYVVKUGdTTU9ock9yMDN4?=
 =?utf-8?B?QW9jVXB2TmdRcnNkTDhjcU1ZMjE3cjZQajFDR3ZhL3pZTTZKTmRVTFNJdzZm?=
 =?utf-8?B?MkErQzl3dU5ZdWFkbFp6YkJ2VTQ5MU5rR1BiM1czRTV2ZHFBeThJa3RSWmpI?=
 =?utf-8?B?T29uR2h6QmdMQnBaMTF2eGNzVE4vL3VwOTFkb3ZqWDU4U24ra3JFQUttMXQ0?=
 =?utf-8?B?TkZYbXFMWkFIMXZNMTIydTR2djUxMi9rNFJwdjNhZ2lEcnhMdGl6SXlEWHJL?=
 =?utf-8?B?UFFFVERDSERPbFYyUHYxYjduQUEvTU9UbjNlQ05ZN2NkYWo5cUNKYkFncFp6?=
 =?utf-8?B?TjFxZjRybGk0M3YwNXZ5eGdwNFdCRzlzd0Z0eEdOdW5QWWVWYU5Za1BEbmRN?=
 =?utf-8?B?YXRSRkliOXRpMXJWU1Fzck4xeXBic3B5dElsVjlOWS9vYzNvSHh5c2ZMdkRO?=
 =?utf-8?B?WnVwbXBEbjdEMTNCcmFZZ2JiMFNSWFFiZTk3UnBEblBMUUd0a3FybVpzUkdL?=
 =?utf-8?Q?hf351Zs02hwTtq5UV2+v2PszW?=
X-Microsoft-Antispam-Message-Info: o7SBe3uirBlCxyXqDKLzy4alf1mZrNP5Vx+DabgY1KEWJI4hyLVMABRJ/p7stkd+QbjZ/fzGjeXFO9wV82AwPgKAqRAR3sa/G25Zbsv4MFdWQK7EB8+nazaeCa6bEMjH5LaFkYo1n3VYHdRcEyMTmpB9loJkrw6EhTKlWH6tvqUWAxvtscc/RGvYIhszdmQl
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;6:Y+Zsp1PhF65XAXpW4ibw+EjQP3bku/sF5Mll9pBXVky8ZmGuPQa7nZJ4dGzAoFQ8FZzwVgm/RkfvYBALzNHrfxgooR6S0ec9oaSl46OFvgnbzpXQstOhopUvQqk7WB/ivAcSG1f23JtBE8+fumffICQwm5Ts+luCLZqpzjVfifcAWF9sZyYkdugoaq2lkGPNpRLVNnRTzTOotB4W5vstWdukq1LeKTxWhqH+M+rQnACzbemjCCapk+MkfL2gVt1i7LOXHR9NnsPsRA3MkXzanRtXagA/hNcCM97T7E5vmJDCFZGp2FlWeG+9QGlxGn5BHY3rZNQjOz8W7ZuE12jIFbUpgjxyMdJjQBMJlNapROVFbjmNz14c+J57QBTrwS18ySqrQMnUfGQsW5EqQSUM1FumKwkVPC+tPlPgXoYC4lVeU54iKq1IppD9Xm+2j/PmZEqwus57OvqrWwyyQRUIuA==;5:/2KAYaF9IS66k2DGUFp/HQz8CAVt97A6gjiALK+RwN/nhGKP2s2Qt5bfxdLDuaaJHObWP6P1VXV086rRPRc1dKpCXj+3oPZKwgag9Pjm/wK92ga1jqdiZ8pRzRqkBXMWX7edsBE87zhAF1mQgEXGQH8hkrOf87gEduC8u1nBmIY=;24:ObtWdgOOHYuEQf1iI58e0OZoivKwE0iYHCMa9dmBE7YB/EkQ7xaUBU1q8cMwcTekNbK7OxtlJLGJ9nfikRb9fnnYX8xaep2dQX+6VnaBePY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM6PR08MB3253;7:WxpfI+IH0vINkU9qrrhkHu+BXfyiQYsJJSXwU0zJ7gBHS2uBrQtmwckdLNwsLjupY4B1alPLURkCMk6zQynJUzTJJ1mzGtTPLYB1dQ6ZCCZpf6EFP6S+pWKzsI2vJlEqAvfPce3aAYU+UZiKcysEQAry+2qmQzM5NmU5OIcf6qxJRgzKTYhtfFYANLJZeUrfQ+ghBdLhTO09MRR/PLf4CVbz4U8IblAgcC/eTFO3NwzV0KYzp1AS4VO925M5YvNG;20:hZ9/7mQcv9ODm1VFF5xbbsiRhIQnLZ0+7yY95wfuADEw/29mqIXBbKYRA5CE0991n++IaKVx9LnbXPUA8Flh6SObQrWF4vDc1Wx6oqOj2hspci2nfGJ813eHCgV+DjWyXNcKKawGOgQG4lawFK7txD6/hqChiFMB9nooK9/dD+4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2018 17:02:33.1497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0104f618-1c11-413a-afb1-08d594cdb344
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3253
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/28/2018 02:06 AM, Shakeel Butt wrote:
> The kasan quarantine is designed to delay freeing slab objects to catch
> use-after-free. The quarantine can be large (several percent of machine
> memory size). When kmem_caches are deleted related objects are flushed
> from the quarantine but this requires scanning the entire quarantine
> which can be very slow. We have seen the kernel busily working on this
> while holding slab_mutex and badly affecting cache_reaper, slabinfo
> readers and memcg kmem cache creations.
> 
> It can easily reproduced by following script:
> 
> 	yes . | head -1000000 | xargs stat > /dev/null
> 	for i in `seq 1 10`; do
> 		seq 500 | (cd /cg/memory && xargs mkdir)
> 		seq 500 | xargs -I{} sh -c 'echo $BASHPID > \
> 			/cg/memory/{}/tasks && exec stat .' > /dev/null
> 		seq 500 | (cd /cg/memory && xargs rmdir)
> 	done
> 
> The busy stack:
>     kasan_cache_shutdown
>     shutdown_cache
>     memcg_destroy_kmem_caches
>     mem_cgroup_css_free
>     css_free_rwork_fn
>     process_one_work
>     worker_thread
>     kthread
>     ret_from_fork
> 
> This patch is based on the observation that if the kmem_cache to be
> destroyed is empty then there should not be any objects of this cache in
> the quarantine.
> 
> Without the patch the script got stuck for couple of hours. With the
> patch the script completed within a second.
> 
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> 

Acked-by: Andrey Ryabinin <aryabinin@virtuozzo.com>
