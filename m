Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753397AbeDBSDl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 14:03:41 -0400
Received: from mail-sn1nam01on0064.outbound.protection.outlook.com ([104.47.32.64]:36763
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753164AbeDBSDj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 14:03:39 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com;
Subject: Re: [PATCH -next] drm/amdkfd: Make function kfd_dev_is_large_bar()
 static
To: Wei Yongjun <weiyongjun1@huawei.com>, oded.gabbay@gmail.com,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <623cef28-530e-21af-e90c-64905f5c84b5@amd.com>
Date: Mon, 2 Apr 2018 14:03:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522376727-136554-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-CA
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::47) To DM5PR12MB1707.namprd12.prod.outlook.com
 (2603:10b6:3:10f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 93ef3874-1366-4fb6-7e4f-08d598c40f6a
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR12MB1707;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;3:10sAh48b4A2wpmxj96GybczkEF/SiA9iwciAtIP/kjskZadwzK1Cv5BOHNp7LjVW0Oa9Vx7lnR7XCbPD85CKKOmG8nVf7g0dh2Gff8TognR4tLUxbpPrP9agws50DrPAAK0QMupOI193iOZuZ/6w+ai+ZmQ6LAkp+9k5JLiCzAo9wYnnxHY8spMWr26oGXAu6IEfgDETCPYwv1+nL0snJUJwSed1d3GVlQvPDHGflvkDwyog/bnccwzGHq/ep82q;25:YBQLhVX7QgnGriarpTaUfPtT6lt6zhOqDLIOR/HJWVb+dvCXSq8eP6T2HBHywrRaT/7nxXYtXQEO9yOuEM6qwRGxP5pEgxa5kwqAguQsI1Yndfa8l0ZO7IXwRgczI2vm7O6USIdn7Mocl4IOhiMXuwDXOlYjWn9668F0DsVMeVHN0p/3yPA9MgbOkDyBXiLtod+6ADtH5sAU7CKrWiLFNKWTl5Tld7Ps08uUROZ0v+Kaj55vNd2GzQy5rx/hcnPNjtWWzHexeA1ZQOqPLDx2nZLiq5oPb9yjQSoH9JDVEbGQbSu7PNmcRjX6ND9pjOEUV3Gm3+BU4VrYKzM0hOljrA==;31:tHmtSHXZD4ebDZVXQddgN4FokFOZreo2ajZwJUr51suJOmlnTm6ymn/YBgWZ7HC3tRhANRGhxMXGMd8RA0mdG+sOK90rShgIxH7n9GwQsVVuVaHld4Ss6Cu3zbvrnrV5IOkHWJb1uqCDsrCgFMjy6BM6F4h3NGB5rGfYZxWkEq0EMjseMOel8zwz7TPFEgnL8ezT/M/LYgqgrZfu6GJgbztSzKPrQAWSvvkKpj2KTJo=
X-MS-TrafficTypeDiagnostic: DM5PR12MB1707:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;20:fYd3s1O9Msyl09JCuUFl+mQAZ8QL0E0MW+TgmruOSywXvFQ+jYSM654+K7/fmi3ukP9cz0Uj0+Gsf6T2rWDreDiVTqz47smXBVMJnr5/TbRb/yIezCeUmqeBW/rdINH0mhA1ziPFw4JZGjppmGD3uCHEkyn232b3IRhLsB/pVQa+woQIAzukhefCixgJCVgAvYvnfNQqC4R6gKjt/lm9iDwgQuEYx0fvOJi0hzpkGlPSct6MSAiYbdkdVsLmNVxMZCdGe2mRjHmEF0pBYHWFG+jxpO/WU5jr7l6S+kzwce9ln6cgsdwmVV3slBXqEnaajQUHxkhsWY8pESDaCiH78Oq3VfU/uiBXk2htVFjN3QLUgiTzVlzr+kHu/H9CgWjMdE+h1M7S9vN/IxLsbAm/zgRQmIyYlU1n0OqD28bKVW36pKLdqnbLa1mHiW8+bKDdpjo49CFq3SKdelvU2Je7a9CtXrOCwQrYH0Hk3UtoBK6Vgnsm0ywaUIJwgdoLw2z1;4:rHj5VvaL0t6sg4gTYHhVKz/aTEJnXkNUemsgKgxliA0BUEAEAhLNVczXdI+lSMZo7lLsi/Qc0k2B8GvCcQwEAPgyiWRUVJrKyDD1+r9v3Uer4uJ+SCj4VTJYKt5UGny6Q86umHSO3q0ofBS34/km+hbegjPSYr1RpPwe9Aj/nljSeRNitg50UnvsaSknJMGPfvlKo44pCuo6Ge9hGJf4bD35rGR05+bfE7dNDJzL4UiOSDEhvJpf3lGAiW9xSI+b3lFiptQzJb2ai9fyN8sCJCMoX9SxFyj18fJXZcLeLi4NDKMBGo5u2c+t2TIZzJ2WWsmRqqU6azd/rGeObCwQPT9W7GQ0x3APbnDhf7b2Szs=
X-Microsoft-Antispam-PRVS: <DM5PR12MB1707A4870870B9515199187492A60@DM5PR12MB1707.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(50582790962513)(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR12MB1707;BCL:0;PCL:0;RULEID:;SRVR:DM5PR12MB1707;
X-Forefront-PRVS: 0630013541
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(396003)(39380400002)(39860400002)(376002)(346002)(199004)(377424004)(189003)(36916002)(23676004)(97736004)(76176011)(52146003)(2486003)(386003)(305945005)(6486002)(229853002)(6246003)(486005)(476003)(81156014)(52116002)(53546011)(7736002)(8676002)(486005)(81166006)(59450400001)(8936002)(39060400002)(58126008)(230700001)(478600001)(2906002)(53936002)(186003)(16526019)(26005)(77096007)(106356001)(316002)(86362001)(16576012)(68736007)(31696002)(50466002)(47776003)(36756003)(6666003)(4326008)(65826007)(6116002)(105586002)(25786009)(5660300001)(446003)(3846002)(956004)(11346002)(72206003)(65806001)(64126003)(66066001)(65956001)(2616005)(31686004);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1707;H:[172.27.225.16];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjEyTUIxNzA3OzIzOm1tSnhJMHp6US9vV2ZJTTVpTS8rOVFFSmRm?=
 =?utf-8?B?aEVQUWJ0M0xoVzJkUW9sNlhmSkorQ3RsTGdWU0drZXNxTnlIUXRJNkpLSTh3?=
 =?utf-8?B?OG9OUjhCTmF3ZnhLTTVMQ0hOZUJQT05yNFRtRzBZUGJRQTFPai9MQ0x0blN2?=
 =?utf-8?B?SGVXQmltR3hjbnl4VklQYVJTWEVqT0kycWRROTJ5ME8rYmdndXFVKzFUVXJX?=
 =?utf-8?B?N2ZONVQxbmZ3NHZhZGVhWStyaUFyODJVKzBTVld1QzN0ZGhnbXFmN1cwb2Ni?=
 =?utf-8?B?ZThJOWVRWDJFek4wZ2taVkIvOG9tem5GZFlLY0pRQml2aTR4RmNPczRlblRz?=
 =?utf-8?B?aUxqNG5VMVoyVjlFWTJMN1lYTkdJV0VIMWZENnFadHpkUjExcUZmaUJ0QkpF?=
 =?utf-8?B?YmFpY2tSSDVrRW9PdEgwbFJZMDh4Wnp4dzQ5Mk9RQ3NpWVNGZ1J6cEtRL2l2?=
 =?utf-8?B?SENZV1hWUFNpeTZXRDZRWkk0dkZTN2I2ZTUyZnJhVGoyNVk5blBCSitBalp0?=
 =?utf-8?B?b1R2dXB4L0NpRWNiNWlWZkJXTElONWNnNlNiZVVnbzgwTDZBejlPT1pmV3Na?=
 =?utf-8?B?Q0NjdjkzNGkyb0RpNGk2d1VJT3RhNXRvN2lsSk1JcjBod1lxK0RqQWF5QmF0?=
 =?utf-8?B?Q2swUFhITVc0NUpoYkpkeUs5eFZtdE44Q3UrU0w5OE9Idm05NTgzdW10YW1R?=
 =?utf-8?B?Zm16dzVrclF2aDBXUlJ4enRNOEo1OTZyZW5XeFlOTkJnM2FDaExqa05PZFB5?=
 =?utf-8?B?Qi9nVkIxNEFBd205QTYyVUV4RlMzb0hkR0U4cU04eTRQSmc0dUw0U1cweGxl?=
 =?utf-8?B?SlpuQlp5c2IrN010UmhkaUY5MUpqR1NrZkw2WlBJTUxoY3RLMGtjYVFPSisx?=
 =?utf-8?B?Z0NUUjBVVW0yQ2tMQU5kZllQcnlUeFE1akpnZGpRdkpGMUMrL3o4cE15MjJh?=
 =?utf-8?B?TkxrRGJsU3BFc2t0b2dtbktQVDVCUHV6Z1NCb2V3VDZtYmdJZ1A2M204L1ds?=
 =?utf-8?B?RG95QWh6cUYxc2REYXVrNksrVWhiczJ0em5yd0JuZ20vRTlXK2x5bm5ZNXM3?=
 =?utf-8?B?NVV5UHJ0bjdxdjFKRTlGNTJhR0RQeGJYRWR1RWRTa2RHNWhJYi81cXlNY05N?=
 =?utf-8?B?Q3VpQzBjazJDQ2VpMit0Q3Q5YmlQcmJLNHZuY0tiU2JMc3ZwMmFzK2JtSGJN?=
 =?utf-8?B?ZnJRY0tvSjVIRHhOYlhTTTR1ckNXWmJ2QjlqMkozR2lGVlR3ckYvNVR6OVkw?=
 =?utf-8?B?VVZpemtlNnJGZUtrSHZsdytZQ1ZqbXFGSjNrWlVrdkZkL3RhczRtMzZpL1Ju?=
 =?utf-8?B?UDRqWlVFUzF1cnoybzRzVElaZnVEN09VaFM0Zmw2R0R2RVpOV1lRWThEaWtQ?=
 =?utf-8?B?Z00wUlVmQXFpZjNpcVFRWG1jelZZSkp2U2hFcjZWeU50WmxZTGNPVFgxcE51?=
 =?utf-8?B?dElpNDBncmw1d0tOVUdMSlNaUWhaSDNiL1RsTXlndVJsWTNLVXpZUVNQb3Ey?=
 =?utf-8?B?cjl0RXh3aEJkOEg2dFowa09VNzd1UzNmT2orVkRCOXBKeUEwU3ppUGRNUlJI?=
 =?utf-8?B?aWhxVFlPRmpaR0Z5Q2dxYVpMU29HK0QzVHFCZE1LZnRPa0s1SnZaTFlBc1NO?=
 =?utf-8?B?VEwyYyt2dS9aMy9KQ0ZWZERFU1Z2ak5BNTM2emxwNDdjdmRxdXE4cHN3dXJQ?=
 =?utf-8?B?VXZjaDRIa29JU203RHNLeUYwSVNwNDdkSUhsNkwzTk5SRW5YWmlqekkwMllC?=
 =?utf-8?B?L0loTlNGVm03a3J2YjFxZzB1RHBCclZiN21HV211STZNY2U2elJUV2VuUVE3?=
 =?utf-8?B?VHZ0V2ZVRVNubHRyc3ZEYk5DUklFSlk0NVFkYnRIdGFqcnprNCtlMUVOeWVG?=
 =?utf-8?B?WGpsaGUwck9GbWUxR2ZhNDlMd3hxYnFST2wwSXhyZ1MwSGlMMUk3RzBOT1JR?=
 =?utf-8?B?dXdRdW5CbkxRcXhSY0ZTc1ZIQktpaWhJaVRBZlMyRGxsQVF1RkFjZEYrSTdm?=
 =?utf-8?B?OG8zdCtReEdIM2pQdnNCR1dtYzBUOHVTbFJtdnFsamFUcnd0aW4zcDd0VnMv?=
 =?utf-8?Q?PXuZZGHK2o73YHlT1uy5HyZV6?=
X-Microsoft-Antispam-Message-Info: U06/r9j3UNzop3cfgYEawoHUwr0YjN/u5Lm2/m5FUBI0zdPm8/yoFRPsLLGjRR490WRnOnPe/3o41IgPDKngAKNNamb0DGqYWBq7C2VeBHuV92JTTKOtplzIIgTZwOFnWLleLqFemhFPOtl/Hpir5v9FTByQG+qyMw0OByjapf8vMd9WKwpcbGJtgbGsneJI
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;6:eBtLnvNuS0gAchjuDBPih7fZ5fceLgZorcZrQSi6eoD1YRI2Q/Kk5ijBIaOwCp0hHz9KUmAO4CaKKXY/NhemsQbLqgF/5wFRc3BgRCKM7u76zL2P8r668xnEzbSfGnsH7MuKlt6re1p0R6gvxvCu79l0kob+1N5Ft5Zz3Vy8+RBUIAyJyfj+ANCs5yuyk3cAEu7ZbtPlxiy++mnCSJEc0xeRSTYTiXk1YbsL+1dJtC2hzJMrB4Ypq6T5zZ4/mz/6AByHZw6PRVx33kvfP7V9a4dfsvCQVB7WXMY3s9L7y5wWElcH50iZNu0IRB03VWfVZoTM5A8jOlupwHfZwjuIivsdQR+Xv92yg4pnqsgfNqLNJ+1JirIwoc2Ppt1Hcis1FDkFkKeaOWgfQQjPfRwEH5SM7EFSjkFLshVszr5+C7312l8NW9beQgjiky/m1TkMA94sjPhw8I8JcyKZXdf7MA==;5:5YAl+dL3xBmjZV8Y+cSUYB3CCXstpJzB3+AQOxCyMOmfp8utRTOyeIZ7U/K19Cg/Njvy+LhKilqpD3cuPciWJaLnNAjCSQbGcLfxQiWsueVMGCQj1oTZ+pFhMIyMU07UAWFbZrqegWYgQCPHvxJOovM+BNl7LZKB8pwh1ax08yE=;24:Dd5ZFwuuXQtWKHF9zRmWGaWQ0Qa2f9nSrIqxCFjQK7iftclwpwlV1J0taGChGRD7fU4lEwJzX2MN5wph2vFmJF5iAjpRm9grqNewAcA50OQ=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR12MB1707;7:M7/hevJw2O86ZP6UIYrEBDqPuwbz2224LqUspdl97qNBjKlJ3Azsw4DH/0ZVR0rO2ZXHuza3ao9kRNiGSKVB6o7C6Z/WF3KfDr/0JMjuaPaHRuj7fDneqBIkbkpymPPekdICRv31FzNVG3ZgQdLV2kkKSOjtnmh7FgmcDH+4cwO5zA7Vpr4FuHAELlfHkhdIQFXZS9NaVaQyZOvTpfsGmNt9IB/XmlNjXIJ/KnJZeIlobTApt1qZoH3PIMp+MqXv;20:6VbioOUszCKg50gAZw+2nfRK0x4uS6STZ+v3HYZrAlgLOPIisKXwSKajWIBNeeKY03AZzDTaYoE6khBHbkQ+brqIawrUeiVwOIvH3WkbWyW6SmigO7ff7EpB246Bm3ri25QSytAqw6cIHwWZHRo6Jyn6/l8bnOgKaDkZdJmJaGCk22WjJoGa+pwYbQ/M4vDquhwh6Sbz2K1bwQmxd1p/BRoRGpT4PoF1AfoSFnpO8Ut418IMQBi1XLNjIVnkJqtA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2018 18:03:37.7911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93ef3874-1366-4fb6-7e4f-08d598c40f6a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1707
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


On 2018-03-29 10:25 PM, Wei Yongjun wrote:
> Fixes the following sparse warning:
>
> drivers/gpu/drm/amd/amdkfd/kfd_chardev.c:1150:6: warning:
>  symbol 'kfd_dev_is_large_bar' was not declared. Should it be static?
>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index cd679cf..fb5d997 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1147,7 +1147,7 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>  	return ret;
>  }
>  
> -bool kfd_dev_is_large_bar(struct kfd_dev *dev)
> +static bool kfd_dev_is_large_bar(struct kfd_dev *dev)
>  {
>  	struct kfd_local_mem_info mem_info;
>
