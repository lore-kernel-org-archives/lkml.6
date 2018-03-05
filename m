Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753341AbeCEWIR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 17:08:17 -0500
Received: from mail-dm3nam03on0053.outbound.protection.outlook.com ([104.47.41.53]:35207
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752063AbeCEWIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 17:08:15 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
Subject: Re: [PATCH 6/7] x86/microcode: Request microcode on the BSP
To: Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc: Arjan Van De Ven <arjan.van.de.ven@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, LKML <linux-kernel@vger.kernel.org>
References: <20180228102846.13447-1-bp@alien8.de>
 <20180228102846.13447-7-bp@alien8.de>
From: Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <a5518704-2264-07b4-dd13-84f0086dbe08@amd.com>
Date: Mon, 5 Mar 2018 16:08:08 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228102846.13447-7-bp@alien8.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: CY4PR04CA0070.namprd04.prod.outlook.com
 (2603:10b6:910:4f::35) To MWHPR12MB1149.namprd12.prod.outlook.com
 (2603:10b6:300:e::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 949463dd-e1a2-40be-b9eb-08d582e596c0
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(2017052603324)(7153060)(7193020);SRVR:MWHPR12MB1149;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;3:JX/Lb5Q3pNRutjdNGj9XoI6l7py1vLo7aWUiolmwPPOvgr5DlawXFbDioM5kcbjV/4/S9ZqIsQ56pBfp4HUWTitgzJW9XmJXVkU/cDk3lMvF5DlzlHBqXSZjRrCFxA9YbVaA1wk+PYCs37Oyu0Hr1fri1AEz1ZYCM0iUgKGN/ip1Qo6sKZoHW6nGyeFTIDn4KqEKwVycL1jR9Y04+rdIl0YDGjV8MnDq83++lufJni0TBvo20h0JZZFHG/8EvgBi;25:BLZPMRNfU42XVNkgLmirKcyCIrjvOhzIAQalGZo00utLrlxX5FKGtYMbCawPwP4T1HIfzD/gAYKrw63dWpnrsH/Vcmum91KOKZJPo7264lODXgkkrx6Hy5OsIBkJUswJwBRUNVRafu+BrbSqerUgDuJdLUyqyGXzg0GvIP7lzEgVR4mnJ8U7xYQFBTcjntlOMeujhiXcKPl3YU7gx3yzBxevsArbLDX3uKWTgiywsqKuP26wGN60+mB4BLFqBMVhQdjBenNztOXuQUIGl7/biuII0ITuwoJRkGIVRKxszC3NKaWATFsQRl4haq1X+dF3xQcA/nA5VNO742xG7/t3DQ==;31:98e9bAKWqMRM8aXA0wQcwONxMXXSSg/+An62qw7UpUgXPtfon2UUDWF7+SXZEXTKENUitLuRBuRT0KDK/OqAp4NDEK74Ukb4oHM3lLPZDT8XD2i5W8wvXzfcpJEeDgatOVy4Dgy9XqFQGkZ7PIMKHP1g9Soj1l53BP66pe6UmOerkV1XUFhIZR+E5+xjjD/mQKsRgcVUyRi3qexvKBFFy/j2itQZHBeHKzDv6akqQko=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1149:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:ZPfZ51nFtbz1Q0SEciNQ4jlBoiU6R9DJkko1SASt3QbToBGCY1RBuLcfLi1Zo7mIcp+KXQEIKixX95boZonokBJWbeh4qlM92pAGz+2CAhjEg8QISjGlWKz1T/Fw0gbA4oWItkw/92ZOAxnNoQSTqAJiqucnaHQ54oBTb3Ux9Pn6tUdrswrCQx6ATbXZM+h/KnZ5apYORf7lEA2nGMhzkWduyBpuN58ZEUB4+TYdyd3fs/+r0oGw/NpfBE3pUNuJjaC9fDh56II+3xuMEhZr9vE4sNlnGVqoMmgfye7MX+bATmyV0eP3YYNkado0u0cqykOnqjx+w5TjxKhLEBzG/raCyXgpDlKpuCLvs4PQV71BPO62O54Lwy8GH7ac5jezeBhgt1qhFzCEtdoBJNu9OUygtiWpb0nFZHo3JKnnSVh3ShtxBC1UVdxn83aP2RLXHT4DMFHDYOQHMHW4Zc5awYlJo2Lk6b473GSQvQp6ZZ0JMyFfZQMsYrpgk7Yi34/g;4:pUzK+mpgWzLdGkGjO+PhEEHlWe8+u6r7lfn6wfPitwZi30zHM+yd0TiDRZ89jMe7QSMupwS2N/HmdszLpfYCkxuiF6VSC15dtdRtBwP603gH2sfthUdui4pwhn6SiL9nk4zQuqs9CukQLS4PF2IH1xgdFudWpSvWQS9xDu0NnbymU19lMDkEySO1WY573wAPvVzcxQhHXyvkr1B1igT1TnyY7nzTXyXnt/4OhEbvjgg5LvnEenDOX3YuSeljbr3+UF9WkSkoVdO7KtF9ILwOpq6tnHJ7FRuAu3Cc0X+NFJiAZl1hTBGrweHTxzJJxXQM
X-Microsoft-Antispam-PRVS: <MWHPR12MB1149E6CF04D972F005742257ECDA0@MWHPR12MB1149.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3002001)(3231220)(944501244)(52105095)(6055026)(6041288)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(6072148)(201708071742011);SRVR:MWHPR12MB1149;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1149;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39380400002)(346002)(376002)(39860400002)(189003)(199004)(386003)(53546011)(76176011)(6486002)(229853002)(53936002)(2950100002)(54906003)(3260700006)(25786009)(478600001)(4326008)(97736004)(65956001)(52116002)(86362001)(8936002)(230700001)(66066001)(5660300001)(47776003)(6666003)(65806001)(72206003)(64126003)(50466002)(59450400001)(23676004)(77096007)(16526019)(316002)(186003)(52146003)(2906002)(26005)(2486003)(68736007)(65826007)(8676002)(6246003)(7736002)(105586002)(305945005)(81166006)(106356001)(6116002)(58126008)(31696002)(31686004)(16576012)(3846002)(36756003)(110136005)(81156014);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1149;H:[10.236.65.116];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxMTQ5OzIzOitpMUQwSnAyUzg1Y0E2L2pUYnBFNXp1ZFVW?=
 =?utf-8?B?U29MVnNUWkpUNDJReWNDcjloZWlqaEhuSlk5RjVHVFY3ZEhsTUR4c3I5cnJD?=
 =?utf-8?B?UTBwb0F4Z1pkellCVXd6R1lTNDJCYi9aaDdqbUNqMzNndW11TUxQMFJLOFMw?=
 =?utf-8?B?cnMwdnFWYmkvWTd6b0svNERzalZMR1ptYktacTBSZHBsdDU3M3U0b3dXM3M3?=
 =?utf-8?B?S3ZzVkppVEhZdzNaOGtIaU5TdGtRc3FXTmtjSk9uVFFvSjQ4OFZDZTErd1cv?=
 =?utf-8?B?TGp4S3lJcUdMTGFjNjdlSWtoZ1l4MmI0OEFzaDg4VFFLS3FTSFFEWVB2ekxW?=
 =?utf-8?B?eXFwYndDNVBYZzVUa2hNUzlRRmo3emI5Z0hnbnJ4Rk8vczluSjFySU42ZVFD?=
 =?utf-8?B?blZ1OTUwNm40RENReUFNdnJ5OURMZ2lpa3hJNk51NlIwUTcvZ2FZb3NFSVI2?=
 =?utf-8?B?ZGNMNURocmhxQ0VyUmNibldLNnVhSlc5QXNYbDlWenhDeUhVOHhqbDJZTk1h?=
 =?utf-8?B?dmllNy9aSEdUcFBsaTBtUkdyL2tPMmtBQnQzRmJXTmw1THJvRC9sWDhndUVW?=
 =?utf-8?B?VkVsTVFuOWhqWDhuQWZwSmVrT3BkSHFCcERaRTdTZi9rOW5Ec2NwVVFKanFr?=
 =?utf-8?B?d2Y0anRpd3paWUtBSUNweGlCRlRGdmZSTHJkYlRTV2VsZTd4RkxOdTJrZ2VW?=
 =?utf-8?B?N3FyY256SENGUHNtY29KSW4wQ1FGSUU5Sk1SUFNQVG1QZVJML2VxcFlpcnZu?=
 =?utf-8?B?Qk5rNnVtSXZOYnc1UitrMmYxQWZFQWE3d1dmSzB6MS83TWw0bXNhQnRQMEhR?=
 =?utf-8?B?VmM4QjdUcFhsdmh2U0krRFVPeElmMzJOS016SGFHTHkxdTZFUlh3K1cwK0t2?=
 =?utf-8?B?enZuMUxzNGR3cmtpdGVEb3ZKUGRaZithMHZ1ZWF1YXd6bE1wRHJVUHQxb05F?=
 =?utf-8?B?Q2o0NiswZjR3NzRxVWNvZFlFRThxUzA4SGM2Yk95d1krZHM5VXdMbFovOTgv?=
 =?utf-8?B?dmVKN1RvNjlXWnBqVkVNWnllMzFPZDArdWVjUVMvZnVIVUZQU3prTVh1eW41?=
 =?utf-8?B?Mm56QXVJV05MK0hYQTJyOGZIaFh6VGZpVWFGQXdOdVdZNXRkVEZqbk9PNFJa?=
 =?utf-8?B?cGk2dUdDN2dTVHJUa2tNSnllVldlb0pJMnJsdEdicTRLWWQxdUlEcmJVcmtN?=
 =?utf-8?B?MW1lUlprZm53blZQTU5wUG5GR2l2d2pwMi90QmVOV2tqTEVIRlRocXZRL2Q2?=
 =?utf-8?B?U0EvSFd0MGxyeWRSYkF2elpOV2xPUFRLTDBHUEF5NFM1UnVUOENNaElQVUVO?=
 =?utf-8?B?d3pvU0JIdGRWZmZZKzlWU3FkamM4N256S1VUaTg4ZVdHNEVQaVVnMlZWVUZa?=
 =?utf-8?B?bTNSSFRzaHJOZi9PMEx0ZVFuRkNaNmVKNnBheWZkUEs4Unl1WEtQdkhMNkxQ?=
 =?utf-8?B?MTJKTmFsem5IUnRwYXdnTGNtRUJnTjFncDA2T1hSZUtrUllaSEYzeWxSRzNj?=
 =?utf-8?B?SlZCcnFsNEY2aXJmenNwWlVoUmhqSGUxdWpaOGJBa2lCbDl6Yko2UFdPY3J3?=
 =?utf-8?B?OW9tR3M4TFA4a3RhdzNIbzVYdENvMi9RL1pWRHJROXhGMFk3TlNseDdIZnp5?=
 =?utf-8?B?NVVXQm5Xb0tSMGNSMEIzOHpOb2hIQm5QSlhCajJsOVF3Znh0RHkvcU9MUWYr?=
 =?utf-8?B?b0l6UThRMkREK3ZWWHA4U3ZocVk3elU2alBlbituSjUrM0ozU0VpTnlZcmVR?=
 =?utf-8?B?VmVNQkZoWHFzdGRNUjMxVTlhbjZDalMzcVlNWmZ4N3ZOT2ZPelZnOG9IN2k3?=
 =?utf-8?B?Ky95eGR5R2pIVm1UY0R4OXp6OEI4YStSNGhFd2c5dWpualhHUFd1NFVFd3FL?=
 =?utf-8?B?M2JxQ0NjcGlBUEd6bGNQbnpxOE9nK2doSGZkdlhlaEhHN3JMQThuRUZsRld2?=
 =?utf-8?B?Y2ovN3NNMXZ3PT0=?=
X-Microsoft-Antispam-Message-Info: fvhL5LaLgvgmjsbp/Cf/3hvp/k6kgQ0SwEzsW2MxioGrIj2eCz3eW7p6q+SZSDBWhC8XyaYwE11Go6FfgXitq8ww9pByMXttf6ahoJuCpeHtoDXJepzqJoEU0XlL/IzYp7TakdWjvTeda5VHZlMUvbk+uXk9nox0y6i+/z+SR3KqFQWIkEg/zBpEVHH5hFF6
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;6:nh9XPe2opUF5wFmnAdr+npJzd5qMeQ+J5z7yg4NtGGZ0069LlGdivgY2eycxeqGtmjLlLwhf403mjepziHRKIcVv6mOiDmJ5TLKu9BzZLmH22sH9XM7cKI7DPS3A8IImLu6iyhJF16RuM5fQq/BZMjRkxeU+3V4glrWUQCDlhBIGb4y83OeifT2O4/NYMMKhyn6iH9rNfEMYpjOe3SFJycUcQQa+kgLuw6qsKcqb4O4znwByQg4r8WFInRjA/3J+BWr0vKV9UVLBmiMLa88fMw5jAIVo5cpci3mEgma3GgvDEKjwzR9z1FHH78tnDMqA8DRVGj2ngtjkqp4pCJjQiSN84pCuq6C6JycvXLpiZCI=;5:c4C833fTGTrH2FZnREe+MRb01XLryyPe8YKwY3Mtrw7RU3y2zLv3reZZTOG9X2iOluaGjxm2HrgFJGfG0Jguk+bBbNLJ9RK6HgUfHvISAYKRgvKmG7doz4PkX9ZxnyGEp6O0jtKcmw3vrl3+bZFGDDXAl73c99UDzM/tZ1j21pc=;24:qQOP0zBQCu+TXQFrXIBqCRIEh2j8X+bShYTseVo1TFrlx5S6VKooMHD/6O+kRX/sQ/ZTu3P+CVzt9PD7u08AJEZDU8qJlIyulBuOTsWfUFY=;7:iNjJLNlLvIoetXreGxtVdcxmkJavMwW2CwvQBfw8kRokC6FZ2gEqkg0XgxcP4Zcu9xcoCjSQllB1Y1WIgmjhGvO1NUq1pXbDJQHGxlzG6OExNKzeEpuxGWq8BOBVMWAF+L8VJgAbUYTby57/zjTAeyPrFYnFiMcIp2LCnSaOVfnsJizp8gA1zK6k0JWJHcuGg1+a6KHh+PDrCI1Oh45qWuBPvidAE+4chpnANqvfzYMES0YOSAhHcGukCSQaYqfJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1149;20:0RWwhCPjfYSG+oI9x1cXaihQ+gQ4SEvRdp28Lxzevxs01BKlfSSc2y9LbETD+A27KANdfZCq/qSm2Lxut5ghzG3/lOm7E5y0KwJaar0f5f15XTqpjrjFTkOc+rcBAI7zx3kNZt4ct04wby8wOQ4/dzOZ9lmQtW5CZ2Qs2CRkoijXR4q9gOC5r2Rms0wQmSwoViGIuDAobVTk5nM9Yy65kDvadRHxpe9xTv4FiFXZjcobgShjH5oVPmSL1+UD0feG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 22:08:12.5190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 949463dd-e1a2-40be-b9eb-08d582e596c0
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1149
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/28/2018 4:28 AM, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> ... so that any newer version can land in the cache and can later be
> fished out by the application functions. Do that before grabbing the
> hotplug lock.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/kernel/cpu/microcode/core.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

> diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
> index fa32cb3dcca5..5dd157d48606 100644
> --- a/arch/x86/kernel/cpu/microcode/core.c
> +++ b/arch/x86/kernel/cpu/microcode/core.c
> @@ -499,15 +499,10 @@ static int check_online_cpus(void)
>  static enum ucode_state reload_for_cpu(int cpu)
>  {
>  	struct ucode_cpu_info *uci = ucode_cpu_info + cpu;
> -	enum ucode_state ustate;
>  
>  	if (!uci->valid)
>  		return UCODE_OK;
>  
> -	ustate = microcode_ops->request_microcode_fw(cpu, &microcode_pdev->dev, true);
> -	if (ustate != UCODE_OK)
> -		return ustate;
> -
>  	return apply_microcode_on_target(cpu);
>  }
>  
> @@ -515,11 +510,11 @@ static ssize_t reload_store(struct device *dev,
>  			    struct device_attribute *attr,
>  			    const char *buf, size_t size)
>  {
> +	int cpu, bsp = boot_cpu_data.cpu_index;
>  	enum ucode_state tmp_ret = UCODE_OK;
>  	bool do_callback = false;
>  	unsigned long val;
>  	ssize_t ret = 0;
> -	int cpu;
>  
>  	ret = kstrtoul(buf, 0, &val);
>  	if (ret)
> @@ -528,6 +523,10 @@ static ssize_t reload_store(struct device *dev,
>  	if (val != 1)
>  		return size;
>  
> +	tmp_ret = microcode_ops->request_microcode_fw(bsp, &microcode_pdev->dev, true);
> +	if (tmp_ret != UCODE_OK)
> +		return size;
> +
>  	get_online_cpus();
>  
>  	ret = check_online_cpus();
> 
