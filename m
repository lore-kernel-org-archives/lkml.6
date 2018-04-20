Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754126AbeDTHYd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:24:33 -0400
Received: from mail-by2nam03on0066.outbound.protection.outlook.com ([104.47.42.66]:39341
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753541AbeDTHY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:24:27 -0400
Subject: Re: [PATCH 46/61] spi: simplify getting .drvdata
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        <linux-kernel@vger.kernel.org>
CC: <linux-renesas-soc@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>, <linux-spi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20180419140641.27926-1-wsa+renesas@sang-engineering.com>
 <20180419140641.27926-47-wsa+renesas@sang-engineering.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <80e6c822-094e-fded-d8bd-28f4cb7d14ad@xilinx.com>
Date: Fri, 20 Apr 2018 09:24:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419140641.27926-47-wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(396003)(39380400002)(39860400002)(346002)(2980300002)(438002)(199004)(189003)(9170700003)(446003)(476003)(11346002)(316002)(186003)(106466001)(81166006)(486006)(426003)(44832011)(58126008)(2906002)(4326008)(8936002)(5660300001)(64126003)(26005)(356003)(106002)(47776003)(336012)(65806001)(77096007)(65956001)(8676002)(65826007)(50466002)(86362001)(2486003)(31696002)(23676004)(229853002)(31686004)(9786002)(76176011)(2616005)(36756003)(53546011)(478600001)(6246003)(59450400001)(6666003)(54906003)(230700001)(110136005)(6346003)(36386004)(63266004)(305945005)(126002)(142923001)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR02MB1229;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;MLV:ovrnspm;A:1;MX:1;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT019;1:y+5hudUqq5+zskSc9ishorcERdAIrwuHSBttTh4SO/h35DdBvZjjIPTDdw0rnX11bjpoiNbGrtOrERfL+wpo963ONv3iDW7LwR3ZJTrMqnuF4zOIVG/MnsP/qsbjoWtE
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:CY1PR02MB1229;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1229;3:elM/fIpnH8PQqoT0HGKhkrn7vnpzlgMcN9UPWq+YRcaZ41AoZTT/Vm1NiHDB3CvDg8egl6iPEDQ45/VzSPkboUcMAmS17SURmQPwbz5CzaWM4BstgzKZ5+nDCKd5SDskorVaFiGXZ+QpShoOGfKfaFzG9Z85ccajA09ZkfNjCYUx/IwwV+mViFGZOMp8789rDwoPuawAyhvIf3az8g04t8fMUzrrTIOUaqetR2fMnzJE8dGX8pNlQXuXSyphjLEuAzsBemyZRgPKuwP9ZFP1yd18Kw6Mgq1oR3ugOq0oR+4r5KwlIyNoLurSiQnnK2i6JkrkIP4hY0bB6HKpgtnnXjHTSNRBLUu/G4mRBiyFTPY=;25:o3/CaGD4sE/mcbt+jkGJlMyPQdxfTzUYNltXy+3xo4nOqK5eO6ThTRtzX1rI0VuoRDvUcOYoN8AyQamN73kT+ypKTrX/giofH+vfPNutRhOcjV4Aiy2JrTBNU4YSJ6/KCOXPX8aGrNhZ7WohJdHfbVljONl4oynW3FrfveA6UE4G/bXMVm2wNI+ysRoezQcaHN64Ejp8IBo9wi1onfWNsxn9M6yqS+PmTNaUt6UvllMW4Hq+cnbn4XZ2sCODDC+yztwb0rttoS1RPmDGSPtFxCXRkBEDOppPMLtHHsV1Eo206HtKdYVwjTa+gKr4fG9mdu46Bj2pVCaMBAf6Yy0CPQ==
X-MS-TrafficTypeDiagnostic: CY1PR02MB1229:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1229;31:jKLycYi722uijhx050wnJ6x7zYMLD9DtuPUUaAuYMbeSXNPXOlzWT2WJLRuMtKh3q0KSPLrzspIyA33P/1n6bp86kAwkasgjVCrDtWXA4OQN98iCjaZRq+Fkpg5XvAofPUbwe65oUMHpLBKVFLsLew9RHQs99ZhCUCgzgNeX3VeCPN87JZ2XgQVsenU+QsSckolWv2HN2DoIkMHr+Fn9iDbMLucuuOz3XjlpAxTTDEY=;20:pGUZO62wp6zWsLPRfe6Wd4o709YrQTaCf+k+1pkRjRGc9zwdN85EIg+laK0+cOOEaV8YTXW42NUQdM0ULL7y0jOeSH0/WyAKH4P763/l3YX91Jsp2yqPLxuMXtUMvwMmZVSkw2sjWkTukZGhFBjgaZwd6K1ULIHxFfM559pMefhIejS02DXTJgoGBCHdBv0mSaIAfSjMpeOtcBy/oEC9PRl/BHn0wE8f0u4rySiUKvz6+/Tgt9K5iqiYZIza1fvgMfc81S5A7/X1sZ1fl4UL36oqKpAcJGeJk1OEBGn2tYBaN9m+K0BhR4OnWWYkfjUYISyo3C23ub1154jFWcqwfn1jniMLmg8op2b8Un+QdyePobHLjZf/CvfqSrh4wQuJ4poPn56riy+fQXaOnDtpyd9GlBiGZe3kvOXRAhjhSx9ZSIziz6tuB01OgdKDI/uUVmKvqZbLeAy/A+mIE4nmwMvO4CUqO9tPRHAiDdZSimiCVALEsgsLNekFjHw6HTwv
X-Microsoft-Antispam-PRVS: <CY1PR02MB1229F61B6D86B99EFAE3C1DDE2B40@CY1PR02MB1229.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231232)(944501391)(52105095)(10201501046)(6055026)(6041310)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:CY1PR02MB1229;BCL:0;PCL:0;RULEID:;SRVR:CY1PR02MB1229;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1229;4:lefGkXIAxn2r9T9ESlh/pUO3lvYecdE2aIj82H+0ugAUeC2dZZOCjyR90lHSIlkiYmtcyVAP7IUDdrZUrHu66s898bUtcMvWzbUlJUK0yNQ1Hjgphcvig+4lX8HqiCqNZp2kaM0qFb0n2yuQ3RptpyhyTNzbb+hPc6q3OFKMjgo1YkjWz5Ex8r2OIYWGMlKDHE7Zy6SEC2crzIYONCSBJpZD7J+U8mjUxXJ74k1nOw+sdHLDcHIOz51FRnb54KVsHY8OGHz8q+CI8BdVPhbyFNc7EODFGpSV5xSJa0KAXjI1EWx/w0tiLOkUg6Mh5PP6
X-Forefront-PRVS: 0648FCFFA8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTFQUjAyTUIxMjI5OzIzOm5iODVIMWZXQnZ5bFdPZS9hNjUyTEJiUW1J?=
 =?utf-8?B?WTNJcXhYUTF2WGsxdnpKU3hIbWk3dHRjK3F3UTdRN0xXZXQ2WHMzOXQ3dFpH?=
 =?utf-8?B?K1Nla2lhTEEyc1hwSFlCditTSS9zUVprRlM2SnhacjRxU1JwTC9sa0h5Wml3?=
 =?utf-8?B?SnNvRVkwM01vaGlRbWY5MnZUck1NZytPOHhKSG0rQmVwcGxzMkcvbTdva09m?=
 =?utf-8?B?QnV3aWI1Uk1zSW1BTGhjZ0s1WnhlVUdyQ3FrTFlHNnEzNUw3RE95VG1oVTI2?=
 =?utf-8?B?U21EMmpZY3FadS82eVRKcXdIeE1WcHhiSGNWM3hXSGoxT3FrWUQ3RDZ5SzEr?=
 =?utf-8?B?WjlOQ1VwU3pvYVVkdWNjK21PN01qSjgzMEZzVGhFSVFmaVlSWFRhTlJTM0hn?=
 =?utf-8?B?eEFLRU1KdmZsQkNWeGlwaHlvK2w2R29qMFBEbUJIYXRvcEw3NGlNcHM0aEZi?=
 =?utf-8?B?cWtod3NxcG1YRU1DUDNMWHZDV1EyYVgycVRmY1lMSG96NXBqaHZYNkVmWXl5?=
 =?utf-8?B?akdGVnlIeUtIKytzWUhOdmNiZ2FlSTBaVXpTMlpVeWxlUjZKTWM2Tkg5b0Fz?=
 =?utf-8?B?cDcwZ0dUVE9FMDR3MnQzbGNmRld6MnA3bWxhNzVVR2ZlNlJ3a0tIaEt1NXAz?=
 =?utf-8?B?YjBUOG1CTnhQZWlNck1hZzN3bmxhcnZ4MmdtU2V2NzlXWVdBRXAxc2N1TTVE?=
 =?utf-8?B?L3YvMDNITzdQZlIxTjNudjZPZElaVDVQbUV4c0RTWTZjMzU1Mlg0MXVHMUpN?=
 =?utf-8?B?cXBiby9aWXhrUkxLcUtYL2NzdXhHVDhXMVBCWVFldndKTlY3M245bm1QWFc3?=
 =?utf-8?B?R0RrZ0lVeGtPSExiRXNWcElJMEZvYTVBVkdQQVdTcG8xL25KQjhqMW5kdHAz?=
 =?utf-8?B?RFg0Y3Y3dnoyMG1RTktkakloamtFeGhPUHd1d1Z4aWQ0emdFZmFJcEdTSFQ3?=
 =?utf-8?B?UEpPdlc0QVVpakw0eUt1WER3aGprZ2o5Z2FBMkprbkVYbE9GQ0ptY1p6U3lX?=
 =?utf-8?B?TFNSU2VtNm9TRzVCT3RScEhCSFpiN1pRa2FBOGFWM2JpZHdEWitYT3dsNk94?=
 =?utf-8?B?T3hPS242T0hMalFLV25HMWdxbzhoeHpRTnphYVY0QlNnZk5WMVRTVzUwMlh6?=
 =?utf-8?B?b2FIUWlQVWcyVXpnZ1VLWUZYbXB4UFRLMFVMK3VEamdVamRRZEtZYTBpdi8r?=
 =?utf-8?B?MzUxYUhoSzc2SFdFcVhTL3hYNHVmQXB3bnZRdmVKeWovVWhpTkRBRXhGclF0?=
 =?utf-8?B?TkJCQy9TK2FXamgzZnI0eHhYbHMvczg2Vm94V1JRWlJ6d2Q0MGVhM2pBTHgy?=
 =?utf-8?B?bGVBMW1ZaTdkZnVRYmw5MmVUM0M1b3N4NzhlNktDN21PV2h4SFgwRDRjYlJs?=
 =?utf-8?B?WTZnWmFoWmdrNDZJR1Yyd0EvNGxMZDN6RVptNHB0cGswdGt0eG92MGdRRjRt?=
 =?utf-8?B?RUlrVFkzblQ5UDZiem1EOUhKWnkvUlg1NjhWbVZtQXNmdWdwU1FreldydTh1?=
 =?utf-8?B?WlJwSVhXcVl1Q3UvemhHWmFZZ2xweld3c1hZZkd0L1FIMCt1OUdwMTdWU0RF?=
 =?utf-8?B?dHRvWm1ZSDZ5bkhzbCtHdThBdlVIclVualRMcURpSkprbnl3SldiWFhQNUVD?=
 =?utf-8?B?M0VpSlFpdVM4MGNjSjdmTFlZeFdOaWxxb2REOWFRaE9wb1FsN0cyeW1UWWRH?=
 =?utf-8?B?N2k0VXR0dXlUNWN2OGNHaFVaVkU3Zmc4bExhSGV4SGFTaGdpdVdFMFFQUU5C?=
 =?utf-8?B?aVd5Smx2MENXNmJySzVmRFgxRmpOWnpZcE9PbWg3MHZFdUs4WVh6WFdVdzl1?=
 =?utf-8?B?RklnWWZwZEc4VzVycnErYTAvZmhxQkg2bCtEeGNRS0ZrY3I1cnp3UitxZmJt?=
 =?utf-8?Q?oSBBejwvG7g=3D?=
X-Microsoft-Antispam-Message-Info: MKdixKI35wAJaX9kbSZRG1lePYZ3VgmUWUzelGIf+6sI0moI1yoNPVuhIeQ65SHlho84kmH+CQ9hgE5E5VpnDr94RgvR98mvGjkrQIzvJX98Vwglm/VN3h6C9DofBX+epx1Wl5VN+meJsUhXg5IjsOhh8lxp8yF2/ubjz7Oa3BRvO0NRgnxjukFDg//68KhT
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1229;6:GJBqIPjRm7mrytXZMGIV9HcINNMaauwgEAcC9FT7OD2P7qAGIgWQqdTl5nWUZd7kd23QgHSvFslIbbZb+fmFI62lI3SyH+sB+eEGGg0dDp7pn0AVOC1smRFt3OnqZSj+/b2fNAR3OOwcgCQoio3mscOFVQvc0lNKnBELALPbBlLvWt0zkppzcm/RRU460U4CZZxjP0Dck+iZGKsQYaIa5Pczbptq9a/XcU7gPX5f+sRpAXQWQ9rfuwTblxy/hMIKqPs9lkrE0zkR+naAPQxTeYAGCpktBcJgA1uV0DtkZtn5Y0qBp5vp/nGH29dQFa1ZqLvOBPVYz/0JcO7YbPPvl6uNOSXV3xo8hosbpx111GZhTlgjdWIswODK7mZ/i70g2wesIAsnISe4IiTtGvg2CnpQT2285sVJUsASaYx2e42tton4543DuBR9G9oGDpRdIO4GIOSAz99G3uInbZ29rQ==;5:+DUCufDS2Ycr31Gr+5+Jjq3IFwnQm7UGqYNQe3FoMM81IzljqGHvdFWwZFLnK9DlWZrMJ/7iR8gKJVvDb2gwmJaQviuIaN6gF+5osCs5AyxOuHiabUSQ3uTj9SfOBfDkq6rxDFQ0v0qqmfqr4GL+/+Ze5Lfzsi8sE4yuAdlLhAs=;24:uuLLeWyX5lhSS8sKp26/WZBHGjHnOoh9kweHGGLKspg/M3ZPZdsii13bR3Avsi7G+MtNjvTGZQEEsJcLxuyps7onVpd9tRFqmeRmr3Y1huY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR02MB1229;7:9dHXo57N2vTsQdeuJkurAqE9OWirUfwFrAvVWgFwTtoY2fKA7IcyPZ74MZfK13+7bm7z/KbYn8OZa6d66GNUdJ6IWSn8vaVVLNHQF4E1Cz/pvR6M6ZrUO7/bFOgbeb2XBpQIgNZY6iTecu6jOSn2Uxr8wVRCh46uAkqPbPA/DaIkxyzWOUKhzfvKvrMVfCLCQu11aWTp6b2zSr+sDY2DniCbhmX1ws2tloXcTJo81oM/v2uptDgDTzL2uFISDmpd
X-MS-Office365-Filtering-Correlation-Id: 76a58da5-c348-4ecd-7e6a-08d5a68fbe44
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2018 07:24:24.0799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a58da5-c348-4ecd-7e6a-08d5a68fbe44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR02MB1229
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
>  drivers/spi/spi-cadence.c      | 6 ++----
>  drivers/spi/spi-zynqmp-gqspi.c | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
> index 5c9516ae4942..de394422b611 100644
> --- a/drivers/spi/spi-cadence.c
> +++ b/drivers/spi/spi-cadence.c
> @@ -686,8 +686,7 @@ static int cdns_spi_remove(struct platform_device *pdev)
>   */
>  static int __maybe_unused cdns_spi_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  
>  	return spi_master_suspend(master);
>  }
> @@ -702,8 +701,7 @@ static int __maybe_unused cdns_spi_suspend(struct device *dev)
>   */
>  static int __maybe_unused cdns_spi_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct cdns_spi *xspi = spi_master_get_devdata(master);
>  
>  	cdns_spi_init_hw(xspi);
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 18aeaceee286..3608db4ff368 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -918,8 +918,7 @@ static int zynqmp_qspi_start_transfer(struct spi_master *master,
>   */
>  static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  
>  	spi_master_suspend(master);
>  
> @@ -939,8 +938,7 @@ static int __maybe_unused zynqmp_qspi_suspend(struct device *dev)
>   */
>  static int __maybe_unused zynqmp_qspi_resume(struct device *dev)
>  {
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct spi_master *master = platform_get_drvdata(pdev);
> +	struct spi_master *master = dev_get_drvdata(dev);
>  	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
>  	int ret = 0;
>  
> 

Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
