Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeDTQpg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 12:45:36 -0400
Received: from mail-sn1nam01on0085.outbound.protection.outlook.com ([104.47.32.85]:65344
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751639AbeDTQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 12:45:34 -0400
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=caviumnetworks.com;
Date: Fri, 20 Apr 2018 19:45:23 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org,
        lkp@01.org
Subject: Re: [kcov] watchdog: BUG: soft lockup - CPU#0 stuck for 22s!
 [swapper/0:1]
Message-ID: <20180420164523.zrjykc4jhx73cfjo@yury-thinkpad>
References: <20180419030135.nn454aqxlqdwe7ah@wfg-t540p.sh.intel.com>
 <be75eae0-624d-f5ab-1b07-9a0d86d366b5@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be75eae0-624d-f5ab-1b07-9a0d86d366b5@virtuozzo.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Originating-IP: [176.59.47.253]
X-ClientProxiedBy: VI1PR08CA0119.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::21) To DM6PR07MB4378.namprd07.prod.outlook.com
 (2603:10b6:5:bf::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4378;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;3:iQC4V/yivgyVOVEe8mo1YR+NVrzDsQ1+oTHv2Ox3hX5faaOm9GtgPJSQQy462AWrrLJmEpD7wJsAgYF5HLXszPyn0pgIe06xxJCbovLvKD+EmpyGe24YdnxENsEN5ujEreL7qbgU/U27TIfp5Q0wKyt7TeM7xMSVtolEcmT886V0iJBYlETXIeOlMYL89WW+TrsWRZYAY9nZI/8AaAaje20Glgp6PwWkTJbJyXBDJVDXqXplLVebnRPzZ9O0zbnO;25:0uU4dWaVJ1Izv12AtX9JBtZhaDBvdrp9hB482/0RGS9MmSks9iVuBWBE/ZwGZ33SReeyFdZw7aSMccKTXd8Wd+yZEU13b7JbbuFD9Xx1XKQgL6gHzW/RWxPkOvDD99IMinYRsA8gJCEl7+zf59FCYRRZTOLNEcxnUohqAoAQF381O+MJ9/YsTgIUeeFlw5OJdCZS8ZYwn9kp6+haCWtos/s62r9cfW7y/3V3DRntCdQpuSje1VNIfWZR1gTv80zsCkkILh9XOkqVBl+lnBjl5sL55TRLik66d5IOFrH0BUlXGhAsbfJjUd4wyTepq5v16t6MW/jn/I5FCF88hRPRFA==;31:6rkNtvJHuQdFhY41l6Ct4YkJs5WsG6/7lG8shxXBkfjfeOZ/8ut0VxDptICGZe6l08babFGNYffkB0PWzC6E0DUquazD58uAVY2mba92kcADo8UTH5Tn+XsFs22V+Ejt7vWZeEyLxGFDR6BPPYrdLonBCT4FIrHIT71rgroRecaWB9guK2UhyrgNwoSkWqbZ05XjyzZLSU9QA8fMa6lnLXRz9hGIQnwLmOjB8DNWbWo=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4378:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;20:YzWc8w6KS6r9S3+46bFnCGRxBowrL8oBXjS1CJnTudxgDl27OSv76u2SWaQIcshuiVEA9taUmRpZRdgLoS2gb58g95F2pc3maR6H33qmoZmjIJqFehdJ7ZSA7VUvZHk4Df4SpCXtQqxzmUBMmOTH+ZohJJkyNenVSAAAsqxD1L1ZWo8L0YM2hIjAi5mGMnMPU4RGcsjmbnzHClxQdO4Y6VW/6tByj/xbECR+Ib1D5BZTItajHp49OCFRf7LaIsUtc2VgwmPMWRCMTUf9WDtCvjdYxG8Y1N0DJO94/FoFPbd8bD7FcMgdgzbkDFYWBhX+Ex4XvGQNs1899qdnBIT+x3WaVdR66rjhcEGgNS8ywOo9Bmb3ZBUcuVqRBSNuq4V9fzlKXbuykfRS6FsJ58OEXy9A6Lq7eyDqK4VxEkH0WAtc3yHa2ZXPRjujzkVtZyYfskxUrDHoUKhnGjJQqKTosWaM0OMGvI0cS16pJNO7TzUwV1DNwmo0+IR5rusi8tf95Z5QOfb2Bd8b/N2+6WbhZgGyc6TB8KJ6ejQUJsZwmAdSASP0GNdkm3jc8Yl0KoaffXHUbgz6i6ZBeYU8SkCIN+7zflI8T3EOOcQs301cbO4=;4:+dfDjQ0L85OA1RN5a5P49xUx1YHkSWKgh9Ppa/XL/jnf256gD7yq7dP5qcukTKGodmf/By4wC3bNlcZNks3lI+YjwP/K2XXVivfT/BvwDUrfK9v9byBRsilU7kLglyCq50IlA4Cq0vh0UGaydKRog57SZIQrh6ndv7s3y7n2dnxKOgndaG5c8vPyaC2ZSkLdgS2Ps6lsrwJWM4s/QaimGuAflXiBaXAFGvR5BREQ/prYo/X7bvfG1AVGCqSNn8OHuRBP6uGebXfGtT4BcGqBmA==
X-Microsoft-Antispam-PRVS: <DM6PR07MB4378AFC93ADBD663D4256CA4E3B40@DM6PR07MB4378.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231232)(944501327)(52105095)(3002001)(93006095)(6041310)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM6PR07MB4378;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4378;
X-Forefront-PRVS: 0648FCFFA8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(7916004)(376002)(346002)(396003)(39380400002)(39860400002)(366004)(69234005)(8936002)(6486002)(4326008)(11346002)(25786009)(229853002)(76176011)(8676002)(76506005)(446003)(956004)(476003)(81166006)(2906002)(52116002)(33896004)(1076002)(6666003)(53546011)(47776003)(386003)(72206003)(6916009)(478600001)(66066001)(42882007)(33716001)(7736002)(9686003)(305945005)(6496006)(50466002)(6246003)(53936002)(5660300001)(6116002)(16526019)(186003)(26005)(3846002)(16586007)(23726003)(316002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4378;H:localhost;FPR:;SPF:None;LANG:en;MLV:sfv;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4378;23:FaMUbyiX1M1MoZiPeoxXYn+Y6/4YSHupnaP9AoNSs?=
 =?us-ascii?Q?Gx4mS9/EMHRwNv3bM12vn6QjouAz/DIWnTIXrpWPnFqpBKz4ATIbf2mSaxSn?=
 =?us-ascii?Q?hSd3HLz6zx40vMNXcE6A52fuxl3L/9gEPIY0XHmOELd01F4gpuW/YhBos/gY?=
 =?us-ascii?Q?rgdUjKKkBTO10R0O5E/TV83oz7cx9hVFvM1hv5axf6ZflpsVvCrheRfYxCxx?=
 =?us-ascii?Q?EmVPlqqgx/XCJmc+LhyrqL600IZivLtyP6HOr5oEXd5pAsOM28GO//3pb0Pl?=
 =?us-ascii?Q?iT6PT/0Lc/4nznj8fRgMX3aDQVHvGznD78pi752ztEo0NUhQOSIiIXoQBHbr?=
 =?us-ascii?Q?Zuqdt7tXhk71nKFJJpzRnCIcHGahaeDa2s/kaDQjkk0sxa5+vQAxblzjy1uS?=
 =?us-ascii?Q?37PDaCojn5qBEW/pOh0GEfa4Xay0q5t6hXKpec8QDZv7O3SyPl+uVXhE4x6z?=
 =?us-ascii?Q?BDYOdTFipmavlfslOn34+UE+KD4zG5olsU+T8Na8lq2yO0kmVePCOMG1e/9+?=
 =?us-ascii?Q?vJ/ojFka3C//oU37M2/D97fy8Dr0YxnshPveB8osQK1Gv1wCq9Nd3BlHNWI9?=
 =?us-ascii?Q?P4ceLcUfdtZmu6/rTjB12NHpj0qpRklMLxgmqdJjMh2bPlHwsyf9TNI6Db1h?=
 =?us-ascii?Q?4YWSda9/RU/Svv1SBlzTVbITt+DZpi0R5sKPzsDBw1EY0hNcefO0GAfrcgGG?=
 =?us-ascii?Q?wsb/uNqg2zN3daYqC9hdi4EnYN6FOfLsFAXeGctE3A76yppDGpFmUc9o1hWX?=
 =?us-ascii?Q?Sz45GYIWj7rOlObByNZmflv0zyje+1vApQXUml8o0dzzIipj8rL+vBZV9ruf?=
 =?us-ascii?Q?MdRpgMKULwvlFzbp7AVfr8BBo/f2ghjuYGZcGiNJQy3jwM1GnHLRMHVUoXYK?=
 =?us-ascii?Q?hzcjbW+vuEkoihektT1ty+Ootq2BoYOL7tytDgrJuIvfaIakjtkkgEQ+kXLL?=
 =?us-ascii?Q?D2c5PaDYPKdSbnuhzluftpM8GHvwUOXM643uxuT0urA1AmS/cwfuXC3Soq44?=
 =?us-ascii?Q?lRj6UpY1LvdQMI3spZjQuc4t2WoY0JHX7NBF77eMLsytlX+TJy1bY2wQk+a7?=
 =?us-ascii?Q?wGmujwOQcmSrOqFDU2Bn7N+QXyCAkduYeS+0gqla5mlDRZabcs+Z27CQEc0u?=
 =?us-ascii?Q?yobGzJeMKEDIG2E1U/ppNT4foEe9tMzTedKIgdEksaVnmNLibExIw=3D=3D?=
X-Microsoft-Antispam-Message-Info: WXazrhL8RpW5W5BDhb3IRA387Jx9tzgYFrNvyWbj0XRv9KSLj3GoV6XfzcuqIFxXMclB+Nvi7/K2op7MSLa9AuGFyqS2B6DSeLSY5GtPFAUO35uk5yPtPC47zUr2DYb5mIFR51IhlogC/3nueicnl6XBjBKzMAj7L+LFcCgI775C973NW0+GWs905FiDxUFb
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;6:gWi6QN2MCvSAb3l4L1idPevsZGFMkLnJTZTSKkHPoZoPZHQkerxbfuTfSRvH4BXUuZQ5rHupVbkqFcFh3fyysZ6UpL3g/92PF/rd9iHOLhJyiyaauSBOzkZyJqrx/IE4XQhU6+AtoyNZ61Q2brdAcgWzyzQvvbno+BrrG4TQNNXiM2qT93tFNNNLMz69+4pfUAhskAgEjQsR/3/1Hr2jcSDXm7OCtL2ijAvdBdc8W5t999RT5kgF73kQpwHP/83qfWpa+P99UbW24wUguzHHgEWU5Cu/w6CdWDGJAEjMqcelpMqcyiTfXqevUxWcnbkcqjJmel6lGyXFJO7cmsSbxF59MP8jTfBUlMzhBMCktf4oJ+FqiNknIcsRKD0No4GoTOqd01f+zAu0R/erv8e+B4xStuus3NgmDwjYAA12tSOi/Me2xKK8y9me4lF0OiXVUaMjY3edAEwmIU1QG7tGug==;5:N4I2LhCrqdBClV4iBpZQ0TEkhb5ZXQG94C/+fERkDU6RPZYVD/NPpZhO1ozbC7/0iSTrk7LlNhc9kyZehTiZlcCzHOT2/EbJepj2Ohx3m5eBYWlzl7wn2Jy8hCUJlPfw4ldLj+9dXWX1EXj+JeLoGSLt+f8b+Qdk4z8cau+0uw8=;24:GACkbXDVTXdKvGfbARtH5vC7meozP3GQonrOeT7fq6IWOEdQRcCVxNmVC0VjdRJZUY9KgW9CqJQ/pAYIlYC2trLnaBLpB+kDVbzvJvaaL5I=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4378;7:bUiJe9Ep7E6iHVjjh6bfTwO1YeuwuTaeZPUXc0axeZp5XJbo3FqkcCx9KWIG0kxicfzPG0rLlEME5TzzUyvL94JuGdcQtkoIFvGRbRtwR7Re77RwPJNjyFdsa/wVfGNkGQRDPoI8OMaRCkE1B73Rq9PBO6Nbu1aHLkVhtV+JKyd8yHagNf6rY8eYcUiMoltsO+ELbTiM2s7WJj2YDIRggt8m9oFGq7TCspv7+SM6na6zA7KcTQhmzyihW7XGISOt
X-MS-Office365-Filtering-Correlation-Id: d0acad3b-b178-464a-45da-08d5a6de222b
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 16:45:32.3223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0acad3b-b178-464a-45da-08d5a6de222b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4378
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 05:08:23PM +0300, Andrey Ryabinin wrote:
> 
> 
> On 04/19/2018 06:01 AM, Fengguang Wu wrote:
> > Hello,
> > 
> > FYI this happens in mainline kernel 4.17.0-rc1.
> > It at least dates back to v4.8 .
> > 
> > [   25.697463]
> > [   25.697463] Start testing find_bit() with random-filled bitmap
> > [   25.736615] find_next_bit:                30203201 ns, 163965 iterations
> > [   25.783266] find_next_zero_bit:           45554622 ns, 163716 iterations
> > [   25.832480] find_last_bit:                48003878 ns, 163965 iterations
> > [   52.050031] watchdog: BUG: soft lockup - CPU#0 stuck for 22s! [swapper/0:1]
> > [   52.050031] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.17.0-rc1 #210
> > [   52.050031] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
> > [   52.050031] RIP: 0010:__sanitizer_cov_trace_pc+0x65/0x66:
> > 						__sanitizer_cov_trace_pc at kernel/kcov.c:111
> > [   52.050031] RSP: 0000:ffff88000fd43e40 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> > [   52.050031] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000017
> > [   52.050031] RDX: 0000000000000000 RSI: ffff88000fd3e000 RDI: 0000000000000002
> > [   52.050031] RBP: 0000000000050000 R08: 0000000000000008 R09: 0000000000000000
> > [   52.050031] R10: ffff88000fd3e000 R11: 00000000222e2c32 R12: ffffffff85565d90
> > [   52.050031] R13: 0000000000030f80 R14: 0000000000030f80 R15: 0000000000000000
> > [   52.050031] FS:  0000000000000000(0000) GS:ffff88001f600000(0000) knlGS:0000000000000000
> > [   52.050031] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   52.050031] CR2: 0000000000000000 CR3: 0000000003c6a000 CR4: 00000000000006b0
> > [   52.050031] Call Trace:
> > [   52.050031]  find_first_bit+0x66/0x7c:
> > 						find_first_bit at lib/find_bit.c:106 (discriminator 1)
> > [   52.050031]  test_find_first_bit+0x3a/0x93
> 
> 
> I suppose test_find_first_bit() needs a little more than zero cond_resched() calls.

Or just decrease length of bitmap in this test. find_first_bit() takes
lion's share of time of the test.
 
Start testing find_bit() with random-filled bitmap
find_next_bit:          240043 cycles,  164062 iterations
find_next_zero_bit:     312848 cycles,  163619 iterations
find_last_bit:          193748 cycles,  164062 iterations
find_first_bit:      177720874 cycles,  164062 iterations

I'll test the patch and send it soon if you OK with it.

Yury
