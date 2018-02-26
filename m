Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752968AbeBZMGa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 07:06:30 -0500
Received: from mail-eopbgr20067.outbound.protection.outlook.com ([40.107.2.67]:6896
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752728AbeBZMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 07:06:28 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andrii_Anisov@epam.com;
Subject: Re: [Xen-devel] [PATCH] xen: use hvc console for dom0
To: Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org
Cc: boris.ostrovsky@oracle.com, jbeulich@suse.com
References: <20180226110822.13787-1-jgross@suse.com>
From: Andrii Anisov <andrii_anisov@epam.com>
Message-ID: <0d8bdda5-faef-41da-344a-644b5c3d6006@epam.com>
Date: Mon, 26 Feb 2018 14:06:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180226110822.13787-1-jgross@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.59]
X-ClientProxiedBy: DB6PR0301CA0066.eurprd03.prod.outlook.com
 (2603:10a6:4:54::34) To DB6PR0301MB2408.eurprd03.prod.outlook.com
 (2603:10a6:4:59::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7805ac40-ecf9-4cf6-e5ca-08d57d115bfa
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DB6PR0301MB2408;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0301MB2408;3:fNsIBY19RqwbE9Vz9ZJ3b8shxsew0UCTx6PGKM59W5n9Qzbt6Zgb9Mw99B7TTD8nkzuHPibaExMM/nc/bqLUFvehrx2E0Vod+vYtdWx8K/ULVHYUv9Ope+D0n7G39lOBtSvGt8RPoE2PXPvSdBqSvl1d540SZAIAor5WfDuhuz8sz3F7CCi3bCkMkS1myWCv5Z39a3InS3RfDElXXSguF8D+NDGibsIaxV6piA1s3t6sySO5i8D73SfZLKPLPFpd;25:6dqc80PLP1aifJeuxKk4zOcpQQgtp9xyiItXwVopQup4uIo703eqotSGW9wfypMgsm/w717xs0+kGmHCc+23Qt+fuEd6Yua7pdiWzxT9RHurtGfO73JG84pKHgpMAamAtYOg3eWoJx2DM9nE88HmxE7WxhXo3sRtp+up7W9se6WEs/CP7ygEUB7iDzQg+3WJX3BgBfE5vJiLnazHRzxi7ZxTpSH4c24tst+kjrYHgdqSVGsKcKMqLscgxyHnIirG4VepHnujXy0GE4CiqADPGIn/n++WBmxac6DMfBdopjxTBP6w6x6XVaS+QGeCQfdKYda8YG65U84bh+UyPIJ7gw==;31:7zL+/Hj5HM0qTopz9+HvyjEdKJLUjzF044RhaorLcAE1fnZPYvzjKqV+EAutp939KvmjC/ta+2oxWkUwKFkb4rdSAdFBZpK4kfcxxNnmRm7jZhQamYQc1VOfX2g2fxraA+1S0HKW1PFwsfapdFrV0aG/ud4NmX1u5v5NMiKt+bIpEsZm6Whd1C1rGnGxBqmVMd4hcO789qYkLrKaOqn+dTHI+aq7jqO76/H8yY4x1kk=
X-MS-TrafficTypeDiagnostic: DB6PR0301MB2408:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0301MB2408;20:U5BJcaT2bGy979GfqxdUQ21Fhj98qR/PwzvGBdIwp2MYOtVtEA8CtP+f0RaWBdysTNdDVOA17vb6ul8++inmC2Lav6LdbvpFhnFvqTCbrmfoTGAJ28vvIErB6XltPKUVB4OcMEhwtg7tZRvB3yz11qcRcXzOcdDsuFE9w80bbIzqikyPF0yrZFZ5xJsyKaoTCGEP1VxW0pL0nwyfiQdEpCuS5bz9/4KVxgocFRw2E4ZjMQp9ATSQoq7Lpt4880CCKa/4c1kE7ep5km43xGSE6l2hUXBPOn63MIHTH6vDJnxl7ngOLxwfXko95GpnnxN+z0aJFIqSA6pVzE3sQabIIvMTyt1BZN6NVIO+nCIVo8BZN1czuG6uGGcjiXF9ELeNZqwOlBrgOLzmjakp3UC+nHZmwzG4nZ3soNhhDdkiBPvZcxSHXOSPZFmcJIx7q3C+6y4xbsmVOEeRHB45cLzhE6Scsvz+TJVBbroumoapBC4PuVF0RaeRRdd1RQv/yBIT;4:e2lAYfAICYulB9mCI5JPA34zRqznbi4HJ1f3hVj73UKEOtECYCZYneCWX7+BwTFxCE1uq4tI5wHiE4bec53ytNQbZb4H9S4XltRsFaYaCDPxNS2R0nOFO6b7ouYO0tqlfSfHbgFz4GPqZq1gnfC6wl9GvBkoen7ejAZ4Uwj1bR4IpoX/XV+YC/8tTbqwxK+6jBb/nWRFLTjO6tcvKoVpdQM4OaQ21kTuEKLxkVWW2xuelx6e7Yzwut9/4kWb2a1DumpKraOOzvdqfzxhy3PiTw==
X-Microsoft-Antispam-PRVS: <DB6PR0301MB24084109C12CD47214F60370E6C10@DB6PR0301MB2408.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501161)(3002001)(6041288)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(6072148)(201708071742011);SRVR:DB6PR0301MB2408;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0301MB2408;
X-Forefront-PRVS: 05954A7C45
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(39860400002)(376002)(396003)(346002)(366004)(189003)(199004)(305945005)(4326008)(31696002)(8676002)(106356001)(68736007)(8936002)(53936002)(81156014)(64126003)(81166006)(6246003)(7736002)(478600001)(6486002)(105586002)(72206003)(65826007)(26005)(186003)(229853002)(53546011)(16526019)(55236004)(386003)(59450400001)(80792005)(97736004)(77096007)(6666003)(2950100002)(76176011)(67846002)(2486003)(52146003)(23676004)(36756003)(52116002)(16576012)(316002)(65956001)(58126008)(47776003)(25786009)(66066001)(65806001)(2906002)(86362001)(5660300001)(50466002)(31686004)(230700001)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0301MB2408;H:[10.17.180.109];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAzMDFNQjI0MDg7MjM6M0xmZ0RxMENjSTJEbE5Pbm1nc2VJQ0Vo?=
 =?utf-8?B?OGpBZ2JQMHlMSFBXM3JVZk9oWGtnWWpRZTIvbFhxNkhQM29NbXZQd2thek82?=
 =?utf-8?B?QlZybVcxd1ZHZ0dTcnpFTzBaVGFLT3FtRUdPQlRyU3pHR3BTMGdXTGM4U0pB?=
 =?utf-8?B?MWd3bUN5Z3c1WXZnbnd6M0hVTVd4WTJPNlVVa1M4OWxucnYwZnlhMXAyU05K?=
 =?utf-8?B?dDg0S0g0b2kvV05uOW50b1lHeHlFZ1FBckRieTVOWlFWMTBjcUNOQ2hYVzNt?=
 =?utf-8?B?Q2JRUlpzN1lrS1hzdlVrMGhxVnVwWHNyTWNCaW5ORFlMZ2lEelNCTU1vYUxx?=
 =?utf-8?B?VzNFakFZRnZUQ2JTbVJuekpqcTN2alltQzFkUlVnS3BpK0hsU0VjUVpPb2d4?=
 =?utf-8?B?bDlsMnhiMWxNejM1Mm4zUVpyU0dCajBYcG1hRXJaSmFBYjAxUXRUUDZPaHQy?=
 =?utf-8?B?QlduQW9qSjcwNFk4d3VTTWU4aDM4bEZtYmNpekZYNGhpelBQdzlka0ZYelhp?=
 =?utf-8?B?WHhuaWhwK2dWUlFjMTdSR0RyM1BxclNOTjN1MUVQR3pUbEMvYnhXV3pyZTJU?=
 =?utf-8?B?S0txZTBITHVCRVlVVThqQUFtMll0QVVFKzRYYi9Ld2x1TS8yamFIWnloQUo3?=
 =?utf-8?B?WkV3MFlkNHdYQ3V5Z3A5WmY5b1lZZWhkajIzeDQ1TDhLU0NoTDlGdXpYZnhE?=
 =?utf-8?B?OVlEVHd6WEJlckJ0NHFkTXg2RVR3dkxZRm12eU5OT2NETFQ0MU8vOU1FazVj?=
 =?utf-8?B?UHNwa3NxZVFrN0FwVmQ5MXo3QXR1bEh0VHNLMmtQelg4eGRvcUZnUHNmaWdF?=
 =?utf-8?B?SHEzdXRqQThPcUFFMmVSZXVvSWI1bVZCam9rUkF6ak1VV2wrRGRqcjc1dXBY?=
 =?utf-8?B?Z3R0MVdUaXplTVJZN3UrT3MrbWJlTlVKMCtRVXYxQmRxMklndjdxWHJBUWI0?=
 =?utf-8?B?anZ5QUtmN2FxZU44WEZrNEJBQ3doV0wrN1c5eUhSbzQwWUlOVGd3QnRJWkpC?=
 =?utf-8?B?N1lzQzAyRVhRMlBFdjFtbkpFaVIrd1BVZkx5amxkK1F4SVJObTV2bFJjNW95?=
 =?utf-8?B?Z3g4bXdBWWEvZFhYQ2twYUMxT0l2dHBHckhwWHVJekVMaitCblZ2SldSMVEx?=
 =?utf-8?B?aThLL3d2K2NlSG5FcnNjaG9MSzBEdDhQYWxMUksyUTE2WjZURFdRK09keUZR?=
 =?utf-8?B?RzRwa2dUdUQzeityeVRGTlR4MGRlK2hkdnRMSFdrMzRRcGxrM2VPN1hPN2gv?=
 =?utf-8?B?MEhMNmhBS3p6dC92cS9pRGtKVE83dlByYWQvTTUrUi93d1MxS3F0ZU1uOXdV?=
 =?utf-8?B?ZENsdkJoZHhKSkZXQ2J6dStJcFcwQnZXUk0xVDY2M0tjcGRHeDVCOE01VlB2?=
 =?utf-8?B?NUo5ZWd5S1Z3Y0ljMzlnRGo3MmxSbmd5NDNpR2lwUHVFNlovN2w0bUpnNnAy?=
 =?utf-8?B?MXVFRXVWYnRFYnFxaCtsOEFmcWdZQTBCU01JdzdpYm5iNHB1blN5SlJxOUcv?=
 =?utf-8?B?VVZtRjZGSVJuQmNrR0ZmakZIeEVyRU1rUWZMUmNSamVRaGdUWkdhVmZJMjhO?=
 =?utf-8?B?RlI0ZzdWSW4vQUhBZTkwRURia1UwR3ZTeTdMZU9ZTDZBWVlBMmZZWE1wQnp4?=
 =?utf-8?B?YnZ2ODA2SUZScGZYM1MvdzhhUnhhZEpjeVdEYkxlQzJtcFVGSWdhOGZJSVo0?=
 =?utf-8?B?R21mTGlQR0dvcG1ZL0dleEhiOTlHTWt0MGlOZEVMaDZaQ0poZDdhYVRWd1ZL?=
 =?utf-8?B?RllDaFNSTWVvRGgybnJLcFVjMmNHeEFpNDVKRDJpekJKTythTWhSK253dGh3?=
 =?utf-8?B?b2VtajJnSFVsVzRFNWhTYS9PTHJwczVWSElsQWRsUVF0SGY0V0didFIvQTRx?=
 =?utf-8?B?SklPTThwaS93TkdhSEs0aU9pOXNCcnM2R0ttdjlZY09mK2V1VVpKYWJaWDVD?=
 =?utf-8?B?RWt6NjA5RWxRUnc9PQ==?=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0301MB2408;6:zx2IcNlc+vEGyOxuxDRNUn1cH70IBepwryseEX3qjkzFqLXgAu+urPiSc29+rUUKR5s8dmmnR2XuQsKbnPQprkuNw/ertb3NnKVGCz8GMBI4OchRk1s/cMRGxbquiURz10fcdH0rtyhcCciZBLkUxX4u5BB95KJjrZx8cLl2ZCiUnLuzElpAhRMqSXMu1OxR0kO61ED4pCWX2LtSCh8Xa9s0kbqRkJ/Phuy0xcrl7pT5TU1Ed7tKxvRugrUviJoQU2JoapNutMY7zh+Lrzck5vmR4cII3YRXSj5scpMaHYs1eqUuBni8x3eGm8+SrXgyvhpgqDHmKmVhnGcsPpFSz+oFGSXqyW2vvL6O96z9aOQ=;5:xIe41zgqrXKvE7SlfN7FOwxLBn/C7Z/bLX/+GWT2+sOV8T9sMqbxrVykEk9KPOvxv2TKLwfjCoUkZoEMDgaF2r787eB3CwMj4ZvKQDN5rlnL86mr9gJuahJXISBei0MVzX9Z4En3ozolNs4uFZWUQmpVWtUnUVHnZPjNtxB4rc4=;24:DoGhS3KcQTZDfTUvsjpEsn77f1IuQ2770JoJxW8x0i+kKz++CGqX4EnCGa0yrb/kt1ynq0ImNaFsgfST+YzpPxmZvO3oinONB6Vido6E0KI=;7:WO9KrpsfCyqBlW+IY3tWv4TE3kfTM3Yyn5HgOgThriZIeyR3ugVcuwHanLyXRK7SbpFkLXIW6BrvAKpXx6HkLt8Rce1bYWH9GTWj3a/sA3DVqVQc+2YiBf+ysfrRMGX4cF/kfcy7mIdmC6g6ALabydkVh5c84W4QJvinKqy696t81lBoz9wcQ0wKp8Iz5vnatu0xEVrmBvGSfoiLiKYsIQw+E7Zq4rbDI6NIrS/3KYhf8cRDLuvJPRC54jQFKqtr
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2018 12:06:24.3253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7805ac40-ecf9-4cf6-e5ca-08d57d115bfa
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2408
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Juergen,


On 26.02.18 13:08, Juergen Gross wrote:
> Today the hvc console is added as a preferred console for pv domUs
> only. As this requires a boot parameter for getting dom0 messages per
> default add it for dom0, too.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>   arch/x86/xen/enlighten_pv.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
Is this something x86 specific? Could it be a generic approach?

> index c047f42552e1..d27740a80c5e 100644
> --- a/arch/x86/xen/enlighten_pv.c
> +++ b/arch/x86/xen/enlighten_pv.c
> @@ -1377,7 +1377,6 @@ asmlinkage __visible void __init xen_start_kernel(void)
>   	if (!xen_initial_domain()) {
>   		add_preferred_console("xenboot", 0, NULL);
>   		add_preferred_console("tty", 0, NULL);
> -		add_preferred_console("hvc", 0, NULL);
>   		if (pci_xen)
>   			x86_init.pci.arch_init = pci_xen_init;
>   	} else {
> @@ -1410,6 +1409,9 @@ asmlinkage __visible void __init xen_start_kernel(void)
>   
>   		xen_boot_params_init_edd();
>   	}
> +
> +	add_preferred_console("hvc", 0, NULL);
> +
>   #ifdef CONFIG_PCI
>   	/* PCI BIOS service won't work from a PV guest. */
>   	pci_probe &= ~PCI_PROBE_BIOS;

-- 

*Andrii Anisov*
