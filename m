Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbeDTHUk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:20:40 -0400
Received: from mail-by2nam01on0042.outbound.protection.outlook.com ([104.47.34.42]:9949
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751033AbeDTHUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:20:34 -0400
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; sang-engineering.com; dkim=none (message not
 signed) header.d=none;sang-engineering.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [PATCH 10/61] gpio: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Hoan Tran <hotran@apm.com>, Linus Walleij <linus.walleij@linaro.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michal Simek <michal.simek@xilinx.com>, <linux-gpio@vger.kernel.org>,
        <linux-omap@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <34f4679f-d306-073b-eae0-28c9e8965780@xilinx.com>
Date: Fri, 20 Apr 2018 09:20:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-11-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39380400002)(39860400002)(396003)(376002)(2980300002)(438002)(189003)(199004)(9170700003)(58126008)(110136005)(106466001)(54906003)(106002)(31696002)(65826007)(23676004)(8936002)(59450400001)(86362001)(305945005)(7416002)(76176011)(44832011)(8676002)(2486003)(6666003)(230700001)(229853002)(26005)(36756003)(316002)(186003)(356003)(63266004)(5660300001)(31686004)(77096007)(9786002)(6246003)(446003)(11346002)(2616005)(65806001)(476003)(65956001)(336012)(36386004)(39060400002)(64126003)(47776003)(4326008)(478600001)(126002)(50466002)(81166006)(486006)(53546011)(2906002)(426003)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR02MB3197;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;MX:1;A:1;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT039;1:tz9Ymn8gyaPa80UeMuLBVkFRM/2Z8ZRb0K9qeS2IZmPC2CF0ewyocePfwtYt5OyTxNR7xckSUGbpit0W0pAuRJAJXyznrUazDXpaCJLgAIhhN+dhgTBOxJ+7r8f6248r
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:MWHPR02MB3197;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3197;3:9pqnnTzldzUPv2DVmaTxu2tgSgnfKvb3H1MibJiVjWDCiiSR6oHW7LDvyOcnO1zvVJ0I9yUIDU50U8Mi5wXB4sBVO2zRZQdxKUtubncDR39EpPPuCetCbxDZSXnF1Y5A5sNRHQRwBiYB2/4Qs07WmsDe3J0ByrZdXC35lQH289Aoc2bqROyYyqC/vlOyRHvVbqzCGE7eIKquhhEQgnKlMK6zQXyE3FwtlLSkzlDTCXeNmpNQdzy0p8Z6lPgEwI2xNHKzHPf7mK/RHTWBHG3p5Tcr4kr8cGj98UDlfBiWjVH3pb9v4Rw32YYmWmO7J6qX1Lby2rv/UIs8+A6dtohBEf8fBDkWAhtS1YgZHCRHffQ=;25:zK5No9wcRsuFhlqQ9ame007mdUmu6NHmJjTDBF2nECgXIGEdUGW2yCeRHFzZrXBPstPrlki/C2gkIuHc5MU7l+9q3Yo7u34WHtiWPynJdfRXR7Fp9YKhsUjdUKIn8sYFWz8z+lhjh4GpXJZ+HDLm9OLSsCi16/4xKNE4WkeR6dtOjYYevZpq8hMYGPm5yfBCh4Bwjco8b+vuGy49H1fiBNs/+ukF8GzRWsNw09vmLk3sR7nbghri8ubbRcSDtYsscj4f9UQG1KlU87Nzk+gCpQ2HyzvFgDNrUB71gLRo+uXj6QFtMACOQ5qEiwhxSpqFzecuv5d6EhQyHWHyS9OkaA==
X-MS-TrafficTypeDiagnostic: MWHPR02MB3197:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3197;31:nrSJcyN5LeA1mhC5x36GMPlFLRBAgqQpNjaGAOdRqE80R1mfeXVlR5lYDO5zAyyLLBmDg60tTRiN85nFG+IiIx75/rdKHk4W1iJ1FNmbuq17k5OyGEcWgyD47+mpD8X8JI2mgxTxyzFm66ZtE9nqE2lSplSQDdl8n+Ws4bCdZHF1il8gKSksGTZqB0Pi0AwFHh5GH9CP4+ZBiugf8lyvrR/x6I6YF17LYe16W5H8NJw=;20:Gbj7BkAWucvPFPJuawLxlEupY355S9LygBuNlKzSCrLH39KKHm1T92VhKsgOmPpCWYXS3K+ACCCgqsVL9vpzJ01AUTbyXxeXCbDUdc8Eu4M1qWNP3u3emJ4ow8x0HIppYbwSDu7MjTFLVH6aR+PCVuIAq3JHYO6aYpzNJUQoTuxiCjsGrW+MHOO8cXRjjFI6Cun/4V5I/6tAvJ8urcwCbJefHz+79gz7KgMpsLVJJd19klS6YzcGoAXtkuJOachguGyYqVvwfbS7y/IBDnWAc2AHOyt8fmNafjzwkxHZRm1TMhU9UIO0Y99HwRFrNTJdPN4ApnHuzDtJJun7j1nt13LiDWE36ghPndCW0T157+PDUqblbxuVfmCJvIoNPQU+vrdH6NXJ3TkyjSyNe6eqFMPzwh7FhnlMeuznuW15dlL51kNXvWJaecbgLUiVmkQDdU4t5p3kYMNCAKVpHS2cQ52LN9BRoiG79mSl7bAhP6fKFrqgpTOqFSi2VEfPcZ0u
X-Microsoft-Antispam-PRVS: <MWHPR02MB31972654E4F4E58CE38B9F24E2B40@MWHPR02MB3197.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231232)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MWHPR02MB3197;BCL:0;PCL:0;RULEID:;SRVR:MWHPR02MB3197;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3197;4:NdzVHYRMTDTkqGajKCi1+sWl21sBeECPPXdWMpG1mjrj1lhplpCKG29Nn5E37oWsDYpIlTvImeSRI0sBUgIU0r//e2zbSe59j12XwsmxrUjew0JAlRlDOYGTSN1CjJnXr2tyOnlLST1xwhUv5YxARQnVYdyVPjbjgNUh/mNUOIZlwm+myTwtVynJzg9f6F53b/c+Y8EHQHAJY385rpoAGiHt/ofBw1QZMl7pjUG3AeMffw+qaDFp2EItoBL1ue8xoeYTCcddhiEWnBVaHqTeQg==
X-Forefront-PRVS: 0648FCFFA8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjAyTUIzMTk3OzIzOjkzYU56aUg1UWpIQkZBOUJpUURvcWlXQTBu?=
 =?utf-8?B?UU9ybEJFWW1LS3NyZFFHaXVSemZhbmNjZ1NlK1RTY3FyN0VmaTYxSldBMFRp?=
 =?utf-8?B?WVBIbHFRamczWnRXQ0dES1d3YkdPc3haRTdZRUFDaU1ZdlhFNzNkajVCcVYv?=
 =?utf-8?B?SWFDUk40YmlSbzlxeUUzaGVrbTVVbm1MQm9KUTJ1RlpxZFo0TTkyMStMS0xG?=
 =?utf-8?B?MlpudTBzOEZNdTZNT2Q2NVFDSFhTRHVTWXJNRXlZWndUektZbzFTUU9FYith?=
 =?utf-8?B?V2NGVlh0cUF4RDVsMzdvSFpvK1FoWEl4ZDhNNy9NcVp0Und2R1QrWG0weVdZ?=
 =?utf-8?B?LzlvclFQSVNzZG9WWU8yZkQ4MVdrcWtzcnltdnVyK2pjR2p3cHNyanZoZE92?=
 =?utf-8?B?SGZCc242OTF4RWtqeHR3TXZkNEt5Q2RUVG5TUHpyNW9mdmUxNzdMZjljS0hN?=
 =?utf-8?B?KzBRamtRS2FGL1lnZHFYK1BUaXl1VEE3VlVuRmRNRlQ1SXhUekNkdEttT3hx?=
 =?utf-8?B?VHNOSllJYVFSSDVhajFIbmY3WWMyUzJKZURUYUk5N3NPZ2RxL0NpSXVZdDNw?=
 =?utf-8?B?RnZqQVdoZDRGejlWdDErYS9ZVFZUTkt2ZzAvSzhmdzRVWUJzOW9xY1RxazQv?=
 =?utf-8?B?UUJIVHBHNDFNUHNtYjEyR2RCUnREMXpxbGdZZEZ0a1BkZEx4WDljTm5JdHow?=
 =?utf-8?B?Y1JPTGpRd2dicUhVREpqd0ZXSUNlR3JiNUxWTmNONUcrWE5BNnEvTXBuMTN1?=
 =?utf-8?B?U3FQdkRab21ieWc3amVVRFB4QWxNeFJxQXliU3hHTHBKTm1kVnZ1eldpOXk1?=
 =?utf-8?B?TTN5R0QyTm5KTHB0N245cDRDUzRxeUtOanpDN2dkWHQrVzByeTlEZHhudlJB?=
 =?utf-8?B?bFltcWNmbDF3QnN0czNTaEhJaEtBQldDcXZQaEZBRUxHemJBdHJZYkpqOExB?=
 =?utf-8?B?SGhZU2toU0tFUlJTWk1FZ1NJRllSMDMveGo0N0pEeTdXaXQ2YlJaRlRudnpC?=
 =?utf-8?B?TE1uaWREcWJtc1dHSC9sekJOK1FsU3RwU040Y20rQi9XTmpkNUNqZm1Xc1BU?=
 =?utf-8?B?RzhhaXJNbDM1cW00YXFhZnFObjhDRk05aGRLcFpRRDkxT2tleTBYSzFoangz?=
 =?utf-8?B?YTBzVklEVGQ1bmdNN2dBWU5BZElWazhnN1JEanhwUnNhQTNSS2dsQ2VPTlI1?=
 =?utf-8?B?ZzhOZ1p3N0d2QXRwY1d0L1VEeEM0bDMyQ3hCZHdiQ2psSXU1Z0MrV0R1R1dN?=
 =?utf-8?B?V044dG14dzNMV2dGaTl4SFplYTdhTmtRbVFWSE9idk5qSk9PVzlVRTRheFNN?=
 =?utf-8?B?cGYxUldDK1hGUVQzWDV1UnNjcU9ieGhxeFVRQTZDbi9uZkJFZ0JoRDRISlFJ?=
 =?utf-8?B?dXVTZnVsTC9DZTNBcXAvWU1ZeDVQZjFQL2VIK0dNZ2dLUWQ2c3FXNFhZRWxG?=
 =?utf-8?B?cytXU1hHWXJyeHZOU1M0cnlpYUVQMFlFc3oyMVJtczNZWU0xMHB1S3VaTEJr?=
 =?utf-8?B?UHdrZHkvTDhVa0NUQWlhcW1qOEswd2ZkU1M0QytvVjhNZnRMZmQvTWVzQUda?=
 =?utf-8?B?ZHdyQk5nOWh1OEE4RjNMbG9xUGVoZEFyUmVLMmRJNDFRMHBpOE9OV3l0M21V?=
 =?utf-8?B?bDFydTFkeGhyUlBqOU5WbGtlVnd2SVVJUjh6Y1Q4WHhNY1UrM1dtWE9FNVh3?=
 =?utf-8?B?eXA1NjQ5YUZTY3BTSHhUVXFCQVFESVk0aDV0M1QycjVuRlpzcGp5NHNjcWV1?=
 =?utf-8?B?MEFBTnp5V2tsTHl4dEdPVTJDMUV3Rld2Yk5iTDBnL0F1QlVQeUV6TXZPWTIy?=
 =?utf-8?B?M3djQTQzZVl5OGh4Wkg2OStQL0NLSEk5akJpRkNzd3hSQkE1aUI1djVjeit6?=
 =?utf-8?Q?JSUmLiMG3235dzE8JiPUt3R/Z0U977Jm?=
X-Microsoft-Antispam-Message-Info: fke5NH7zx4dv51nksGV5Jzr3ISgCuNp3W5xEC8uGJlUCArBI/SzZDxjal8NowirKp8v1ET/Av3tYqjhs6rvDZsyU+HHs/MZWJr7GQ5D3M/38/ImEtQLQb26xz900AQU4yNqDOPnRYS1p499603TkGCavaEgxpn6MmD4LNkrs0bfQJa8cWOL4GmdLY7RzE9K4
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3197;6:216FvpLgkbHiESr4pRG85a2j0iFt7pHHB2NkxZkgw1XD6ui+PLRxM7pQuR6nWM/PIyGhC8IEZH4JpRw7/WuJfcMVHL6dDTBrRoDLCuri97+jV0ij4MdiA1Q+HRktgU+kdGQB88FZdLjfbBWkT9vLRs19tKp1qy7Bnja0bao4wcJq0xhdy+Z1eYaHWFUijRBhdhktiMbih9tnYVtDcfsxDd4/ELS/z+nyX5DDAcCWF3BcXV+KJQC0njnBJjKATvm9mSEoh4pGi/h/+5C97w2biIgV0YGPJjKjKFNjptvkR4TQeqTmSQiC3Y24U07lGFftXveRKYeKXb0Bl9+iVwEevgnOVN2tjrWfBQz0rVTdyNi4I+4RON6BQeZGFDlUvKEy5jz8rXXbUW+SSp2n+hJTVwS+IegPQ4sjvk1/agpeCgCXbnCyvRGcxsXb7azM7BFtmLvsnFSzP8jthTkOgt6XBA==;5:sexEsb94v04KN73OoL6wq65rtlpt7P9Q3KKtohAnEpggjVPZgYqdMa7m9WvVAaWq8uzN0l9nA/Um0C/AIWNEZ8G0r0bab6f8cZ58rXNRR+pRbtteZRWo1KzMbqZGscDQSG2h7oa8kv67KNtQT2vPfwP1FsJoJ+t3tP82ekiS59s=;24:P+VRD38Oix7vvjb8WA4BpoPjVla2d2RnsMyqHIL147Q8UCOHB7tiTtOE3wq+3ye8CPed7ZN8s1CPWpANYmEcm6bKLnlhxnbZxJPf/RDRMZk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR02MB3197;7:y4x8E9SpmyKcIcsygnwNjA+rwFcoGb+LDQfH9ePcpozqZEj78UeNkoNJ2o3k2j07ta2AxaJLUZBxsfxg9n1AJ8C5clDDV0oWFZJb8anv3/Lm9530vwjIK8i+XMML1keJtbPNjtO9ChOH/cUb/DxbhAAgDW9JqGN/wlNOciAM2Sz9qng1d3Jga50VWEfHnelpzKPeABQ3jn3Hr5dQCU0ZS61svLySBymAKeRxVo4ani4fTn86oOaS6Hco6i5u7Ikb
X-MS-Office365-Filtering-Correlation-Id: dfd1932f-3aa5-4124-bbb1-08d5a68f31f4
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:20:23.3479
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd1932f-3aa5-4124-bbb1-08d5a68f31f4
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB3197
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wolfram,

On 19.4.2018 16:05, Wolfram Sang wrote:
> We should get drvdata from struct device directly. Going via
> platform_device is an unneeded step back and forth.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> ---
> 
> Build tested only. buildbot is happy. Please apply individually.
> 
>  drivers/gpio/gpio-dwapb.c     |  6 ++----
>  drivers/gpio/gpio-lynxpoint.c |  3 +--
>  drivers/gpio/gpio-omap.c      | 12 ++++--------
>  drivers/gpio/gpio-tegra.c     |  6 ++----
>  drivers/gpio/gpio-zynq.c      |  6 ++----
>  5 files changed, 11 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-dwapb.c b/drivers/gpio/gpio-dwapb.c
> index 226977f78482..caaabb79e31f 100644
> --- a/drivers/gpio/gpio-dwapb.c
> +++ b/drivers/gpio/gpio-dwapb.c
> @@ -732,8 +732,7 @@ static int dwapb_gpio_remove(struct platform_device *pdev)
>  #ifdef CONFIG_PM_SLEEP
>  static int dwapb_gpio_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
> +	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
>  	struct gpio_chip *gc	= &gpio->ports[0].gc;
>  	unsigned long flags;
>  	int i;
> @@ -777,8 +776,7 @@ static int dwapb_gpio_suspend(struct device *dev)
>  
>  static int dwapb_gpio_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct dwapb_gpio *gpio = platform_get_drvdata(pdev);
> +	struct dwapb_gpio *gpio = dev_get_drvdata(dev);
>  	struct gpio_chip *gc	= &gpio->ports[0].gc;
>  	unsigned long flags;
>  	int i;
> diff --git a/drivers/gpio/gpio-lynxpoint.c b/drivers/gpio/gpio-lynxpoint.c
> index 1e557b10d73e..55fa33b7209f 100644
> --- a/drivers/gpio/gpio-lynxpoint.c
> +++ b/drivers/gpio/gpio-lynxpoint.c
> @@ -408,8 +408,7 @@ static int lp_gpio_runtime_resume(struct device *dev)
>  
>  static int lp_gpio_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct lp_gpio *lg = platform_get_drvdata(pdev);
> +	struct lp_gpio *lg = dev_get_drvdata(dev);
>  	unsigned long reg;
>  	int i;
>  
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index 35971a341c40..b4f8a048a2a1 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -856,8 +856,7 @@ static void omap_gpio_unmask_irq(struct irq_data *d)
>  
>  static int omap_mpuio_suspend_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank	*bank = platform_get_drvdata(pdev);
> +	struct gpio_bank	*bank = dev_get_drvdata(dev);
>  	void __iomem		*mask_reg = bank->base +
>  					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
>  	unsigned long		flags;
> @@ -871,8 +870,7 @@ static int omap_mpuio_suspend_noirq(struct device *dev)
>  
>  static int omap_mpuio_resume_noirq(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank	*bank = platform_get_drvdata(pdev);
> +	struct gpio_bank	*bank = dev_get_drvdata(dev);
>  	void __iomem		*mask_reg = bank->base +
>  					OMAP_MPUIO_GPIO_MASKIT / bank->stride;
>  	unsigned long		flags;
> @@ -1284,8 +1282,7 @@ static void omap_gpio_restore_context(struct gpio_bank *bank);
>  
>  static int omap_gpio_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	struct gpio_bank *bank = dev_get_drvdata(dev);
>  	u32 l1 = 0, l2 = 0;
>  	unsigned long flags;
>  	u32 wake_low, wake_hi;
> @@ -1352,8 +1349,7 @@ static void omap_gpio_init_context(struct gpio_bank *p);
>  
>  static int omap_gpio_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct gpio_bank *bank = platform_get_drvdata(pdev);
> +	struct gpio_bank *bank = dev_get_drvdata(dev);
>  	u32 l = 0, gen, gen0, gen1;
>  	unsigned long flags;
>  	int c;
> diff --git a/drivers/gpio/gpio-tegra.c b/drivers/gpio/gpio-tegra.c
> index 94396caaca75..04c963f03b68 100644
> --- a/drivers/gpio/gpio-tegra.c
> +++ b/drivers/gpio/gpio-tegra.c
> @@ -403,8 +403,7 @@ static void tegra_gpio_irq_handler(struct irq_desc *desc)
>  #ifdef CONFIG_PM_SLEEP
>  static int tegra_gpio_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
> +	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
>  	unsigned long flags;
>  	unsigned int b, p;
>  
> @@ -443,8 +442,7 @@ static int tegra_gpio_resume(struct device *dev)
>  
>  static int tegra_gpio_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct tegra_gpio_info *tgi = platform_get_drvdata(pdev);
> +	struct tegra_gpio_info *tgi = dev_get_drvdata(dev);
>  	unsigned long flags;
>  	unsigned int b, p;
>  
> diff --git a/drivers/gpio/gpio-zynq.c b/drivers/gpio/gpio-zynq.c
> index 75ee877e5cd5..49534241bb1e 100644
> --- a/drivers/gpio/gpio-zynq.c
> +++ b/drivers/gpio/gpio-zynq.c
> @@ -697,8 +697,7 @@ static int __maybe_unused zynq_gpio_resume(struct device *dev)
>  
>  static int __maybe_unused zynq_gpio_runtime_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
> +	struct zynq_gpio *gpio = dev_get_drvdata(dev);
>  
>  	clk_disable_unprepare(gpio->clk);
>  
> @@ -707,8 +706,7 @@ static int __maybe_unused zynq_gpio_runtime_suspend(struct device *dev)
>  
>  static int __maybe_unused zynq_gpio_runtime_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct zynq_gpio *gpio = platform_get_drvdata(pdev);
> +	struct zynq_gpio *gpio = dev_get_drvdata(dev);
>  
>  	return clk_prepare_enable(gpio->clk);
>  }
> 

There are two more occurences in this gpio-zynq driver.
zynq_gpio_resume, zynq_gpio_suspend. It wasn't detected because these
two lines are not together. But the same change can be applied for them too.

Thanks,
Michal
