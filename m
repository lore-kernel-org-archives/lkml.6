Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754149AbeDTHYw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:24:52 -0400
Received: from mail-by2nam03on0046.outbound.protection.outlook.com ([104.47.42.46]:7638
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753823AbeDTHYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:24:48 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; sang-engineering.com; dkim=none (message not
 signed) header.d=none;sang-engineering.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 44/61] rtc: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Joshua Kinard <kumba@gentoo.org>, Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>, <linux-rtc@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <6c43fc08-4f73-601f-228c-9a4202d5b5c5@xilinx.com>
Date: Fri, 20 Apr 2018 09:24:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-45-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(39380400002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(9170700003)(2616005)(486006)(11346002)(478600001)(336012)(446003)(106002)(110136005)(58126008)(86362001)(65806001)(54906003)(36386004)(186003)(47776003)(8936002)(305945005)(31686004)(44832011)(65956001)(356003)(316002)(63266004)(31696002)(126002)(36756003)(81166006)(230700001)(426003)(476003)(64126003)(2906002)(6246003)(39060400002)(229853002)(8676002)(50466002)(7416002)(23676004)(2486003)(5660300001)(76176011)(9786002)(106466001)(65826007)(53546011)(26005)(4326008)(77096007)(6666003)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR02MB1223;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT012;1:exRogSyb+UNUmBkYhooBZaZmbTqCk1oyRw6p21yONxqszQsAsAmuPShL8rLOY64wVofOWjQcNew6EI6y1CG+sWbVECF/1ej+ZzVoNy1yHb+5+ytvGMyxZhhKlcEWrHT+
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BN3PR02MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1223;3:Jb+oX9QQ8LkgpcP+955CrG2BjC9hpl46uxZaT7MfccP0OrE+oX2LTSfKuYJuIfRyPjJBMbTegkeYhw0IZ9FMGu2Fkm3gJGrn5e7XgPBBX29QfgxVPS64ClwDClmIBOqpmsJM0YxklqWyiGizh6mjVnnPhzlWtJgdQDyJOI0byWJD6CN7IuZFj+c6OG674QzK8oKOQZR1JigysmgxaEatdZp/II5nJbpx9sRg7vLwhjZ+H75Td3RLsRptm2sXrkUEOJBQfHX5AVpuXKWd9BZxvU0LJ2/53B/kDAf235qIKGRjdoPpjar8AvOFZA26sVoaCB+59ONoN9pjpkIVSZEDx9iW2zJ8F1MhRvZTlwHar6E=;25:eA6jIimT+eQIz2KZncFqHZrMFD0Ti3ibZVbwHb0LJpZjaoDcUENGWBCBPb+17qqI7KHnE1XGoS4VWOBqqOdkd+uwP5CgtTecKq38XfIPuEbgpG++Z8fWCsmSIEFepBtSHJeCfRVBQfejeJHnjCj4HvSx7rwnu32oGt89xsqSB1L/+0smwLm7gCu3fpvO7QKNtwMpfhp9nUm94I6ZKkessNvAWtWUvMnQoYaJr76ppsaKAPcMSbNl74O/x2m+wGzO6X/QegbzQQJzTHoJ7zlrWjjST8V2eZJ7YjWh8QS5yfXjHO1S7kpLLeKd8Lxw9LEp7n0tbBmuxwDTGBsvzivxow==
X-MS-TrafficTypeDiagnostic: BN3PR02MB1223:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1223;31:X3IBpO5wHNCjShwZnAPQmGNoKB1PgNEN2+Yr9wXMpq8t2olY8HkyKHAOkv5EfWTOi846fYvnmhLmdQpXP14sCbbwcjovhw8/J0tQpvxlhiccznfYE9qkUHLK+COzarjGCUbXOj+BMqYLZhiGr3WfMFtHVcHtii5fLBLjwee+7Zrl4CK2YZhH43FJliATHmVFcWrxmnc9iit9uogpzrRj8XyLNT7epi7o9Es96bnw948=;20:1nXZEFjgB5qxt1aZijsn4e3C6xsuVGUmWZpeXuoEC+Yfu3p5nUtuRKM35C7rsI1Zz3vRE2RaVUVo3KR6XxrmU/j05CqlbuC1b5xT/JPRfwLpZNHo4HMgpKcGiHgjuF40Ex0reP6wk0Cb2/wGegZyWn7OfyQsUenGZWMw8Q79Q4eB5QG2Uf+/QXRsm+LAShbs6KvYGGjC6Oe+N3XpYtw1pgoRGTcCgAgFtih/8PtS5A5rUb5XHcH1TFL89gNOM7f6aAaUf76Z2ebUPF6dkrsIuxVPUtN78pvhV9Xoytl0UkvGhAwRijI0MG1dLxaWkeuntsC9rXuzFLvLfXGKdB1ADmfnuEzRNqOb1VDP+cRbbGmMtU7Hb+U/ZjeBSRapdxBpPWjFhMd6hJ0ORLRr5xvoZ4073R9QzwoHV1AZfHCVlz7E56q4gKgZ62T2zT+Jf3mMctrDvv8RBoCUD/X2fhIWYkWoi4DrxzJK3z4yIjoipS/PfVHAtrgJa1zaC3ZwQSED
X-Microsoft-Antispam-PRVS: <BN3PR02MB12239F3C834F16834178D9D9E2B40@BN3PR02MB1223.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231232)(944501391)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:BN3PR02MB1223;BCL:0;PCL:0;RULEID:;SRVR:BN3PR02MB1223;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1223;4:rYNyoEbhaiwOV3Pwv9VqmaYNRTvaC6awaJANhP5zFhxcPINARDLLDaP9Lm8M9XdAoGp/jU/KG0c7Yc/VbKlb9fPKw64QLpM+CTkA9rR1K61eMl7Ygs5/IAUrmK0WkUCMEDJUgPN7zVzbgeDgVQuvCWSIqtHSxgvglny420hCHxQcqN8qBOL7rS5RQyQKa3COBddofhHe9ibCQl3N/GyMoaKczCdW5Q9Svtn0Z+vR/MHIvdQw1yPVfVbIJ+OJd6ZW0Qs267mMV9j5Necwoff9As0eYljIvXkjS74FSwyLCX36oBTxCl9fNqiI0pXF584N
X-Forefront-PRVS: 0648FCFFA8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjAyTUIxMjIzOzIzOlI5cUtwTTZ4SzJrVTJtVEU2YUR1dGFXMVg2?=
 =?utf-8?B?ZE5VQ1hwa283bys4LzFKWVZWVFQ3L0RiMDhEUzRzWHo4cG50UGlQU0FCQmlD?=
 =?utf-8?B?amxsWWxyQW4yVHN1U29QYmJVSnk0VDBkVUJLWVYwNFl5czNqeFk3V3FRL2F3?=
 =?utf-8?B?YTJwRkJ0Smwvd0doUURiTDJCQ24yNW5iYVRHWHNiWW96bXB0Zm1Wd0txb2ZX?=
 =?utf-8?B?TkVsaTlQM0tFV2lKUTloMVZheVlkQTlNeDFjUTh6MGhyRGorTVZxY0dzR3dS?=
 =?utf-8?B?TDhiY0NDNDZvYmpVOUJoanNuZ0FDSncvWDgyU2YxcmdnZDU3Rnhsd1FXNzRG?=
 =?utf-8?B?NUZTUEtoRmM1WlFYajhLNkhmRk5URHNCRGtWbFZZTmtjQXRHTVM3Z3owK1pi?=
 =?utf-8?B?TDdCUXdZalF2U2VBUDJmQzZoblpZbzRFM0YxaTI2OEtrTFlIOU1VTEZiNjBN?=
 =?utf-8?B?TmJKVFp6SzE3ZE1JRTZrczdhUktIRFQwMnp5bC9IT0dhRmIwbGV5UWY4cHVB?=
 =?utf-8?B?ZVkyL2ZtZ01Lb0pDYVBya3NYQ3NvTzVEMnFzbThuWjArQlhGeEFDOWkxb0Va?=
 =?utf-8?B?dVBmenJDYmszcWxRL2JQSWJaWnNiczJONlEwVGJZbGRONzJnbGVQRkxrbmZK?=
 =?utf-8?B?Z1FOZG9kR1BMOG0zQTF5Q2F2OFJrcTdaQlAzSTZISTU5Uk1YUXA0M1F4NlVj?=
 =?utf-8?B?bnZyYVpabm5lVlFrVU9VeXE5RWRjWWlaajB0d29ZcUY4QTIwNFc3Y1FlS2p1?=
 =?utf-8?B?cFJyRkJlUFJ1SWhTQktNRWtOeDJXejBuQkVqdUZneUlrQmdvMzh3YTU5UWts?=
 =?utf-8?B?ZHZQS2V2b2NVYXptaUVUaTZJb2hhT1R6ejdwaEdZaERZSTcraUEwc3dEdk1o?=
 =?utf-8?B?eWJ1RE1Pa2F3emdOL2R1TjYra0xtaUk3czBLdDkxc2xERk5Dd0FZZlR5cjlF?=
 =?utf-8?B?d0NtZlU2WUYwcCtEdFU2MVRtcDh5alp2eWh4UWNibXpqN0hpalhwWThpcito?=
 =?utf-8?B?UWI2ZWxEaW15Q2lxSExsSDFJeTRDVCs1c3hlWmdUV0NGcEJtM3dBaVZJTFpx?=
 =?utf-8?B?TXdnRm1GYng1allhWGRmRUF1amlUM0lPSEFLRGJRWnh3OUpUUUUvT0pYd2Rh?=
 =?utf-8?B?YUNTYk9JV1BYT2I0RVZyckZZemJnK2MvSWY0dUk1L2NiMkEwNDZ0bk13ai9B?=
 =?utf-8?B?WDlnT1VTdmoxcHUvN3dUWFpRSDl0TXArWTgyVWlISmliLzdpVjJRSm5PMXow?=
 =?utf-8?B?cFQzNFJrVlR5Nlo3bStnSUg5dHl2aE1RNW5MRjRxaUJpc3oweHBGWFIwekNO?=
 =?utf-8?B?Z2dsc043MVJIOGR4QmF5UlB4enp1MUlsQnBHeC8vTnUyL3pINUZxRTlsVS9w?=
 =?utf-8?B?YWNGSHpyb21vbTVrOGUrTFZ3UjZ0VUFNME5iZjlhR29HWFRUK2wreDkwTzMz?=
 =?utf-8?B?dlJ4blBhbHZDZld1MUVQTkZDaWJsSHRydUlPYi9NTTJyaGRXbEZvQ0hPU21U?=
 =?utf-8?B?dlI5VFVteEF3bFpsMXZzL3d5ZVYrem16bmtybnR6VmNpQjRKYnp6dXVoVkc5?=
 =?utf-8?B?aU1vNitiZ21BR3lMUUx6bFFLallFdUJSc2xLMHdYMm82ak1OZ0QvZHVLcmJ5?=
 =?utf-8?B?SSswTUJ3TzBqOFlybFRtd0VuVGhMUWxFODR5dkZCRWVqTVpWeFQ3WGhuTFMx?=
 =?utf-8?B?UVRTYkJLWTIwWE1NanZ6T0R3ekU5N2JWSjZGS1o4S3FpbVZXdmVJYVBhenlm?=
 =?utf-8?B?bkRCSDVxUTlRa0htNXR5NlFJMGJnbGdHcThudmIvajgvamZ0OEhlNEtNci8w?=
 =?utf-8?B?Nm5aSG4ybzdWd3NpemVLU0FKN2xRZCsvWTdzT3B4MVhMSVVnb1A1YTRXYnAz?=
 =?utf-8?Q?6ZJR1bJFlV4=3D?=
X-Microsoft-Antispam-Message-Info: J3FgTPk50R2ejQhDqeAbGTDGQX4SLrb2WyYHPwjHxWRub8QO++YWwjE+uETJQpe/Z2lmy+1atZSwo6HVG9Fve25RzkGLwHpxBCS6k+Ro+RpHB8Cx62Z+F9LQCFvESlSYatPfyLrjn6ETHpItm/G6rUFhxdFB1VuHsyUiqrT31jcpTwfL4+Dsuhg8Gxc+Y46K
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1223;6:03Ako2rJ/9/TRuVe810L//eoa48iw3fWKdrTn0kQ7ILuFXbsxwMnGr6cU8OrvgrrgomAbu5CO/qpkl/mfM7Ostng5C6H2vU9u9CZ57W/kwTHzYZ+x7TOPslttdiQhlRsakt5UAG0bPiKILLgiXizfaEabge2UcMqIKR+67XKzIcjtGBh04SURPRc9D82zf46onuSb3pZMO+RKyWA+5i6U5vPH5X/OU05mgvteutPvMWEvUh6fDNeBcQ56RGqP7lg3MWg/FmbOmJxsN6nOT8X2AkB+P2YmtiBeGgMlkC0NePqalO77PWelFcno3lPb7B5i9E4YpFZOoZKZIQir2SiymUeOQkeB9tzGTVJE2iMFicOX0o2RfvscjBQeIEIMNoMt47XqFemt2GkaP5sIiJt55aELuWmoXdZTFqFqwVrXRZlCWUayc52LIHVGzxQqwkxs9EHxK5nMWwsONrREHH7Ow==;5:3pyA8olEwL6Pea+GYMACc5MdqKy+ngGKD8yunNDuklPewpqRd7Xdv5+qZxQZGzI0Nx3iepwk4D8tFbNBtAcIzHnX0emMe42H3NCqAIKGlq855qTiFw1o5C7fxrg+O+KonruHvR7EB9P1JqR5TyR4FoUHXHAlCt1vZ1e08f1ZMQ0=;24:IHhuYCbHCCS/dcOXzif15dYrV9Ql4VN/PnIaNlFhNOUuyPNwHFIA+HKqfJBDOHD+VyPwqzhepo3XMwKKdmwC7TLZ1dEUG808i5+VeDZodck=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR02MB1223;7:0HgePZcIe5zJlmXNKKY6NGHiChTIBZbdR5RTgqBvOz4w0yeeefaivceopQUzQnxmNyraMJwmOW7Lb28GINuyc+MBZerKnEzpgscf8TLdTvbZPhaTIPr59sYgMn/dmWrT6P/ZC+mRx+qIzlAMvtDCsS60hVM3xA3Od4mWQUgG2AanQEUdh5MKnNprPRICMiKVAMt/XuMPFNKVm9Li45GZe7VVBPVpuXBjHMu51p7xtBaSnTu6q6BMNIbo5URwl13O
X-MS-Office365-Filtering-Correlation-Id: 35ed34f9-729a-42e2-6755-08d5a68fca46
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:24:44.2720
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ed34f9-729a-42e2-6755-08d5a68fca46
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR02MB1223
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.4.2018 16:06, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/rtc/rtc-bq4802.c   |  6 ++----
>  drivers/rtc/rtc-ds1216.c   |  6 ++----
>  drivers/rtc/rtc-ds1511.c   |  9 +++------
>  drivers/rtc/rtc-ds1553.c   | 15 +++++----------
>  drivers/rtc/rtc-ds1685.c   | 21 +++++++--------------
>  drivers/rtc/rtc-ds1742.c   |  6 ++----
>  drivers/rtc/rtc-lpc32xx.c  | 16 ++++++----------
>  drivers/rtc/rtc-m48t59.c   | 41 ++++++++++++++++-------------------------
>  drivers/rtc/rtc-mv.c       |  3 +--
>  drivers/rtc/rtc-mxc.c      | 21 +++++++--------------
>  drivers/rtc/rtc-pcap.c     | 15 +++++----------
>  drivers/rtc/rtc-sh.c       | 15 +++++----------
>  drivers/rtc/rtc-stk17ta8.c | 15 +++++----------
>  drivers/rtc/rtc-test.c     |  3 +--
>  drivers/rtc/rtc-zynqmp.c   | 10 ++++------

Acked-by: Michal Simek <michal.simek@xilinx.com> (for zynqmp)

Thanks,
Michal
