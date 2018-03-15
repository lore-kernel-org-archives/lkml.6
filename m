Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeCOMMl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 08:12:41 -0400
Received: from mail-he1eur01on0099.outbound.protection.outlook.com ([104.47.0.99]:19636
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750751AbeCOMMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 08:12:38 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com;
Subject: Re: [PATCH] Improve mutex documentation
To: Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc: tj@kernel.org, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>
References: <152102825828.13166.9574628787314078889.stgit@localhost.localdomain>
 <20180314135631.3e21b31b154e9f3036fa6c52@linux-foundation.org>
 <20180315115812.GA9949@bombadil.infradead.org>
From: Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <2397831d-71b5-3cc8-9dc4-ce06e2eddfde@virtuozzo.com>
Date: Thu, 15 Mar 2018 15:12:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180315115812.GA9949@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.214.232.6]
X-ClientProxiedBy: HE1PR05CA0275.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::27) To AM5PR0801MB1331.eurprd08.prod.outlook.com
 (2603:10a6:203:1f::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9098baef-88e5-482e-0775-08d58a6e0928
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0801MB1331;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;3:0Cc6cb45/IKlXBrPo7SDG/oGJDctYkXTuWdMp1P+K1Ug5KheqIij9Wo2+TGmv8q8H1Jn/ps/408wmUC0s3S6fTHhhwGADZl3HK8FLecFKsNYOpgPpLxq+kVIcZRsLIR66R6GKOX2WVJLEciblxIU9TlPKulRQJ3fQEsaQRa1cAuJ+isPHCj/cx7fQKv9O4p+rZ0bhjQ4l399+l5XqiFQ4hgChYtENGXP7lZcVEX0z7vNFd+sLHjTL8cY+XgJmFOp;25:KWAEasqXP6RakGh/Kzb9QlcclRgBcD8CEVTEWFwoQoGZ0llVTAOTlpwt7tlFMsMAlY2ZZobKFbuxM/8tKP0VuIjKaqnXbAtMD6ScnwW2+PQMblAr2QztbVJS1gJtmiXlhYl/UJRSbiXbMzFdU0oTn/ApBRpBXQzNmgmSZ1kE9m6GjhzJreVTbGvV5xQUT76cOVZdlArWtb8e1npYr6SEpW+OrrIFa5h1Q/UGPmtl2ROO8hyXFfE73tn7lWdQX9wNOQRpLR6Pvd6YHnZGO/rEAeH2xn/Q1r+eCCXAvBZiJqIDhm5HJc+s2LbUdA/iTXdn+jZSbbklJw9Fi7KQYOT2eg==;31:AhSlPU5q4IpoHq7tM5FKui9ZDJjXq4u5DmuzYGZMx5Qkql2Yg6eAv4645MexxEo8uOQy+2S92AvXgFOWUjN2VLXUcLnMKJ1GSWh94FZwo8HZvbQfz6fxnYhuEH6H2wLmzXpKK1U9OR/8d3HpwEIcOpeF8JsdefzaYs6k3rQ4BVF3WFJeXzRfS9t49jbM4nz7N7pdgxWhgrQaqRPAmf6x+pBu2xvehSZM3F1oUHWJVAI=
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1331:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:FfE/kr5mmTwLdvuAVE+NK3pp3vOJkA6c2saiV5dhGSCaQrEwi+FuXywNlnVO9uKVliT9ekX9taza0gcZK9CbCtAuj0+TbGgTzbtMwx7ty3p2hvlBLR4KZYJ05BkhEe4SUDX14KrIjvJ3gbK3mywZhlWwqXeB6VdS4eqiyczraeNvW7bZmqgS2ljEkJzRQikoGphOQDarIeevltEzQkVvpM8gT2x+F6Yz+5KkMVYrNMYXYB/LMnyEJ34pf5wr5hLHlqJ835nwhI4i7RwBdUN0dSnJAKdV1AygLsQlQ1Bhyvxbn73KjwCe1+x8B4eBAj+JDUBmB43nrbrqEYk+DjiG5x71dI9PhXfC78icpUhDR7oUHa5QIj+z6zvyqedkSESaWBir7yJN9DUsschfdCESBwPXJVbbpjwxjlnsyTq0JHU1uD0VSJfIbzwaQXt5WYI8cVQiou/hl244rLg1+5+BY1On8XF8Qev4q63Q3WEPqdhNrX2Nv3EHPh6tt1lP8Q/n;4:XP414hkuu1JDx9mo97cS/kid38KM4J6ajoY7h1xh4tc4BYod01qoAXla0c3XT0IXHtdpB07dCpy5L+VahNdVIltK09A+4CqsqeOcDyjQJzlQ+Y208eOcuNimyWHgeRnvL2t/HFG6Wn02ex+n8CbzCoVmPZEb1QxjRx3ZTlY8D9Xo6eJ9nrTqYmr4COJEV55pqDR7yZBRuvDxz/4M+vkBTJBkhIcg/TdmxfMrV2tVxTfGTwKuHIn7nR36dCA1GxkBCfHBkoIJiVSUmUky0dFqYmO/UIw24v+rZqYwtqRpM2UpJ6RxQnAWq7NDN63Gs7HnuUR3+nfeDjwfLe3q2sYWYnIF6Ky7d7GamFWp7cdvHcg=
X-Microsoft-Antispam-PRVS: <AM5PR0801MB133180CE24A047F63C593B83CDD00@AM5PR0801MB1331.eurprd08.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(28532068793085)(89211679590171);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501244)(52105095)(93006095)(93001095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011);SRVR:AM5PR0801MB1331;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0801MB1331;
X-Forefront-PRVS: 0612E553B4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(346002)(376002)(396003)(366004)(39840400004)(199004)(189003)(55236004)(53936002)(6246003)(8676002)(8936002)(97736004)(584604001)(81156014)(81166006)(3846002)(230700001)(25786009)(58126008)(6486002)(6116002)(54906003)(110136005)(86362001)(2906002)(4326008)(478600001)(68736007)(45080400002)(65806001)(65826007)(65956001)(7416002)(52116002)(2486003)(77096007)(26005)(23676004)(52146003)(76176011)(186003)(229853002)(64126003)(47776003)(2950100002)(7736002)(386003)(36756003)(50466002)(106356001)(16526019)(5660300001)(16576012)(53546011)(105586002)(305945005)(31686004)(316002)(59450400001)(66066001)(31696002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0801MB1331;H:[172.16.25.196];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA4MDFNQjEzMzE7MjM6SHJCUktGblNqTFhWL3o5Tno2d1hDejRo?=
 =?utf-8?B?cFY2OUFoYnE4RE5aT21qSUhkbkx2UnUyUXR6RjhrRWdReDBLdHBOUGtrLzEx?=
 =?utf-8?B?RXI5Zzh5bVBwYkg2RS8rZGlHV1MxNjljUUZPRUc2cEFPMWNKbktYOW56SkFE?=
 =?utf-8?B?VTVvSHBGU0ZxeWp4d1czMUt6RjV5Snc2VzFVb0RzTnBqT2VqWDcyUHhIbTlr?=
 =?utf-8?B?cVJVQzRWUlN0eHh2QWc2WU5vUEdOM01tTEtCcSt0bmdDbzlBMHc1cmxTZDhD?=
 =?utf-8?B?R2Vpb2t1Q0IrSkl4WHRkRndaOGQ4U2NHQ0tVdU9pOHhqYmE0N1kvTklnYkc2?=
 =?utf-8?B?UTVkS0VERStjeWFZalpzMnBuWHIwUXQ3MWtBdno2OGdaWGlMdmRlVWZoZW5H?=
 =?utf-8?B?MzZaV1N4Wk9uUjgxWWwxT0l0WVQ3VUpvK0lHSjJmbGF0ZzVhR1dwR0dOSG8x?=
 =?utf-8?B?dkxiVzBlb2ZsbHdCU1grcHdEcVNMZjM5OS93UERBdG1JNXpVSU05bytqVWc4?=
 =?utf-8?B?VUZ0YlJhR3h5RWNmN1pLRC9VTG9xWjJUN21DSjZNRm9MWVZVYlNOVDd6L2FQ?=
 =?utf-8?B?bkR2aEtXVlcyd3dMT2lZdmxBK05wamVkZkw5OWkvVFFnWlp3WGR5T0N2WGli?=
 =?utf-8?B?WDllay9HUVR6TXA1bEVRaUxNcVRJY0lPOWJKR1J3RUZZSzhZQkRrdTlGSG04?=
 =?utf-8?B?cER6Y0ZyZlVFMW5pRzJOQndBMUZoZzAvRnU5U3JUaW9UUDFBOXAzUDFTcnBR?=
 =?utf-8?B?bEJEMGV6MlIrOFhCVW1JeWVLUFBkNGRHbGlmR29uOEtQeUFQcUE3cWlkMzd0?=
 =?utf-8?B?c1I2MTZGZzI2Uk9BL1hnMHp0RVNnQ2JjZUQrQUNaam9Yc29JUWFLUUI1dmdx?=
 =?utf-8?B?MGZRMGZuSFVvQTJmVGVlQVB3Nm5ySFZNMmMycGpldm9vVXZNK0s5cTJ2RjVx?=
 =?utf-8?B?Z0RnWWtvdy9lWlc3UEh4NXQ5MEZqWXMxeEVIc1B4c2lBdjZST0NVYWo2dlds?=
 =?utf-8?B?QURsRU5jYVJWUFFORUh2NFFHZmhzTTJVS0Q5SEt2RWp6b1N4cnR6Q1E3bTEy?=
 =?utf-8?B?Y3Nta3ZlS3BXSTArME9BUC9GZkU3YWJ3c245OEd5UFdKVDgvLzUxWGZqS2NK?=
 =?utf-8?B?Mk1rdkwzTWdnUnhObmhtcUY3OFY0ZUVkK25DREM3UVhxV3pKd0lUQm9ML2Ny?=
 =?utf-8?B?VnFCTnNCb0tWR0J0cTBqQXhNSjczVkNhVy9iWm8xdCszQWs1cDRMNi9QOEdw?=
 =?utf-8?B?bmZiOWxqQU03c1Y0NjVNQXNEc1ZucjVNSHVrTnpxWVBKcGk0a0lZSHBiZUpD?=
 =?utf-8?B?MUp6d2NGR0p5YUFOcHRBZUxwTFJtWmdqdTdTdHFJdzZyODVtRk4vcDNleHY2?=
 =?utf-8?B?Ui9jazZQOHZNMjE3bkdRdVEveTVYNjc3czVMM0VQOW81dEFSY3BKS1MxVVFJ?=
 =?utf-8?B?Q2xsUTl4aGNjZmlpVTdQdDJWbkkyK0dyVndQN2hCU0Ixbjk0c1FuTGJHY204?=
 =?utf-8?B?UXRsM3Z4ZlhOZFh0VXdtTitKMmU4ckNMQkFLN2Z2dklBS000Qng5dkZSTE5j?=
 =?utf-8?B?cHE3cFRsTjI4cEl3RWR3ZEJEWlNaMi9tZ2lEdVVKTXJjQTZab2ZvNnVKTzdO?=
 =?utf-8?B?cFZOaWFZaStXeVJ6ZWJ5TmlBRUcrMXBqOHREZTZSMW9iRDRCOGJ4MTJGZGUw?=
 =?utf-8?B?NzZkQ2J0aEREQmtFUS96Sm5KRW5GVmVpcE8zTWlhdDFpRUlKaHk5aHFsVjB2?=
 =?utf-8?B?NnFxS1VmOERxaHdxT0lGZWtFeFBFMGtpR1FQR0EzWjBHbFdqS1dsUUxLWk1X?=
 =?utf-8?B?WTlINjdUaGltaWF2cVArL1lhMyt5OHBmRFlZTjUrTjdXMUhpazdENlJYZDBz?=
 =?utf-8?B?Mm5uNU1MZ2pWM0NzTU1pR2xNcGpnck9RdEZIUCttNFd0dWsyVmhrUmQ1NzAw?=
 =?utf-8?B?TE96TmpialcrTlVSdS9oK1RuVnhFeEpZOUNmQ0E3Rm92UEpjQ0tSWWYrT1Mx?=
 =?utf-8?Q?xyxZr50Y?=
X-Microsoft-Antispam-Message-Info: kn98BFTVyKTTb4bNsgjecqkKhPIF2wFFhv+g4oCZ911AVDGWJnjFboJLhtcn6Bd/IgtfbUNmkGyI6hZjRyXkIyMMinaa4EhKGCIdRt5SFPVZSRlTMPDsttNrl0W3kK85TELCMGatNDZnztDMdu52q/87qhvVc69lN9SQYQC0Kz5zvgpjOApCbJd9KVIppe+v
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;6:0P8b3FFr90daqs2YBGBuGTFljcCUkCRTIxZyfoCGguIU++yMZyFbz+xqZg17rjc7HJ9ss7IemPhmSsIC1HWnTFEmeaKg+y5az971DrlNlAMpkDhLAh82HQx5MDvpgU43vSZpvWGrJubBhV6tyrHp5ClLvn5ninasxO0HyggHp0RaRdh3uGVUOWEFgdgFa3c4feDirmciv0I9L32OAihxtD1oqksjCH/yqag9EfjHpokUiCI+tgE4GyVNxmO8cIqQKqOo5IBxk7qJgz769UCQry8dLwoA8kHXW50Dbt9Xwdit8/MWfkhKcieGCDF4vgIhjOZwCtKZA48j7YuhbPNlD44zz/cd65wzCJr3KA4mtWI=;5:uBWDIX0/3uNg2+bzpg2qpmTaNJ43B+vhZl/YH4AuLMQF3Muvv1R2bnlmg/c9tWerp1SY7OZWdK1ZV+AbVPfEwkgHdNPzBoaiSflGU1io1wzr+wpVta8mUcdgAOhJj1H954xOKVhMWrjg1+5h+vGaZ8Uhh5lwVazs01NV9NaZ+go=;24:DBzUP24SeN01de9M6k3DmLvfwLfNRa7o407T+HJ6RNQ+9GwcKe/wntkibPkkkXfbLVlRaZ+Eh9GLd3lXZdoX84wdSzYhhMBwF5nooWmHg8s=;7:CC36/RxzTGHbK1Uh9KeLNesVQdaf359MR33tbdlr9W/cm9MZ+OH2ur+ahd7dNaN4q1i7w0Ru3VsFkAB2LSVq1nv1dWCyo1eeCISNBnbsAMlF9ZsFtV3+UJ8GlENx8N16ufdRwYAx8ykbKmEUYldeqKG9TntOcv1wi00piZE8fXiLc5QPNi2EwP9I2wqYt2jQjjraEa06VH2/8N+7bMF3HflR6n0uHzgRNrP5Zdw1dd8yF8q7ExxCe3z35dI8icDo
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0801MB1331;20:o1HynYFMGprr1BJLLeTeO6CzySLI/QWnS1esC+vW7A0a+/J57jJPbRvCcVlIUo19lkmPQF2EAw8OaCry1NPZOml0wu5NCqgdIl5Vc59e4iMA5mzMBXikair6Sqck5+TAJWDo033JAjTQAgFSO6m1eRg3GWk8ReFexIeBgiD/lO0=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2018 12:12:33.7290 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9098baef-88e5-482e-0775-08d58a6e0928
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1331
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Matthew,

On 15.03.2018 14:58, Matthew Wilcox wrote:
> On Wed, Mar 14, 2018 at 01:56:31PM -0700, Andrew Morton wrote:
>> My memory is weak and our documentation is awful.  What does
>> mutex_lock_killable() actually do and how does it differ from
>> mutex_lock_interruptible()?
> 
> From: Matthew Wilcox <mawilcox@microsoft.com>
> 
> Add kernel-doc for mutex_lock_killable() and mutex_lock_io().  Reword the
> kernel-doc for mutex_lock_interruptible().
> 
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
> 
> diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
> index 858a07590e39..2048359f33d2 100644
> --- a/kernel/locking/mutex.c
> +++ b/kernel/locking/mutex.c
> @@ -1082,15 +1082,16 @@ static noinline int __sched
>  __mutex_lock_interruptible_slowpath(struct mutex *lock);
>  
>  /**
> - * mutex_lock_interruptible - acquire the mutex, interruptible
> - * @lock: the mutex to be acquired
> + * mutex_lock_interruptible() - Acquire the mutex, interruptible by signals.
> + * @lock: The mutex to be acquired.
>   *
> - * Lock the mutex like mutex_lock(), and return 0 if the mutex has
> - * been acquired or sleep until the mutex becomes available. If a
> - * signal arrives while waiting for the lock then this function
> - * returns -EINTR.
> + * Lock the mutex like mutex_lock().  If a signal is delivered while the
> + * process is sleeping, this function will return without acquiring the
> + * mutex.
>   *
> - * This function is similar to (but not equivalent to) down_interruptible().
> + * Context: Process context.
> + * Return: 0 if the lock was successfully acquired or %-EINTR if a
> + * signal arrived.
>   */
>  int __sched mutex_lock_interruptible(struct mutex *lock)
>  {
> @@ -1104,6 +1105,18 @@ int __sched mutex_lock_interruptible(struct mutex *lock)
>  
>  EXPORT_SYMBOL(mutex_lock_interruptible);
>  
> +/**
> + * mutex_lock_killable() - Acquire the mutex, interruptible by fatal signals.

Shouldn't we clarify that fatal signals are SIGKILL only?

> + * @lock: The mutex to be acquired.
> + *
> + * Lock the mutex like mutex_lock().  If a signal which will be fatal to
> + * the current process is delivered while the process is sleeping, this
> + * function will return without acquiring the mutex.
> + *
> + * Context: Process context.
> + * Return: 0 if the lock was successfully acquired or %-EINTR if a
> + * fatal signal arrived.
> + */
>  int __sched mutex_lock_killable(struct mutex *lock)
>  {
>  	might_sleep();
> @@ -1115,6 +1128,16 @@ int __sched mutex_lock_killable(struct mutex *lock)
>  }
>  EXPORT_SYMBOL(mutex_lock_killable);
>  
> +/**
> + * mutex_lock_io() - Acquire the mutex and mark the process as waiting for I/O
> + * @lock: The mutex to be acquired.
> + *
> + * Lock the mutex like mutex_lock().  While the task is waiting for this
> + * mutex, it will be accounted as being in the IO wait state by the
> + * scheduler.
> + *
> + * Context: Process context.
> + */
>  void __sched mutex_lock_io(struct mutex *lock)
>  {
>  	int token;
> 
