Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S969410AbeEXLx4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 07:53:56 -0400
Received: from mail-eopbgr00118.outbound.protection.outlook.com ([40.107.0.118]:4000
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966965AbeEXLxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 07:53:35 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/3] i2c: mux: pca954x: merge calls to of_match_device and
 of_device_get_match_data
To: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: kernel-janitors@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Himanshu Jha <himanshujha199640@gmail.com>
References: <1526896150-27134-1-git-send-email-Julia.Lawall@lip6.fr>
 <1526896150-27134-2-git-send-email-Julia.Lawall@lip6.fr>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <7b1eed5f-a43b-b254-8f88-cfbe8bd04bf5@axentia.se>
Date: Thu, 24 May 2018 13:53:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1526896150-27134-2-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0802CA0011.eurprd08.prod.outlook.com
 (2603:10a6:3:bd::21) To VI1PR0202MB2782.eurprd02.prod.outlook.com
 (2603:10a6:800:db::7)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;3:bw2vYcbl0SZEx2V964jIpwJwBrIDP6AElZofTIlAcdley9TkVfKdIhF5BaqjqR1qlB+UytNrUXD0VoUNHi1K2tWmZwBdOqZoVfj1Zvnnf56iLZu0EqfA2kfJa4iOM0APlNrxIck5KCl5ibFAJa51j2DnW71O5lrmQ5xwEtF6jeJtDKV1zNUkgIi/r4aGagkgDfMgCXj0xGQEqAjbDwAwshDL61JNw2iDo1JG3NBQCnWZQyjLj9UfbZtG/MOQKnsR;25:+y2dtYJngEKrXIR2VYb/yALsTB6+jKS14S89SkRaeGjgZSZS0YOXMPe8Q6L/O6ggEYqkeoChj5/9yogETjG1/OdfP+IOwkhPXEsEtJX53/nmjVufEDx5ZBN/ae5WFeRTzBBLdPVd9tKPoRzt7+O3tTQ88gQWKRy7vbFIgNpj9xwv+fr/YI16mEWa8MkQhJ3g15O+a78HyilZFrejylTXwse82vjaLW8/uNQNT4NEY95RMn63UjFlrwh79gwr/ie0vY8brz6UqK6T/SEkEwXrHZB+YiBYGyjlHFV6XnycRINHEnJ2+Fx5jzLPhTPiDDm/4cE85E3sO9kD/BJO3Hx2Ow==;31:bRZNnDs1aPVo0cBy/UAULZxg0CAa8YZGnUWsZiLxSbR8/5rHpDHWFRGS6L7uRq0l1FimgkyBW4bpDStKy77goYJao5tmTjjDlCISKI175ns/gdhNoIHe9Le4btvUkj8+yl0N5pNns/Tk5z1ZiGCiQhU8/q5eix5PLEM6sqgzLPQCZvkjVRDfCOuG8sMERuUcuDsxu+1u1izDUPMz2z+2zN029AbOeTKlsL9v33UoP2Y=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2782:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB2782C3F9C091470E7E2B9390BC6A0@VI1PR0202MB2782.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011)(7699016);SRVR:VI1PR0202MB2782;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2782;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;4:rdfJcRRvMJs+hVSMZunoFliokyHT4bZlsSGTHpYBcW4yDniAUKt4vmlquwmqxYk7NJ7Q9sEj0oI4xScTBwleT/LPormMMnA3ihqcFH0H7jfs/nLI4oPh24jBDfkQwiF1U7CAVpwp5i1XlL9QoORvvTnfLiA1+Flkwb1d78TNbw/5O3CSp1L4+XMjfOs2bbM6rm/7ODe5Ju2SP7afGK81p+bFX9zqFxFeX0RlZJCT6B/TvibUK5sGHhUsmX4dzh0NyMgI2bKRgioYrLwr5/ErTQ==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(376002)(396003)(39830400003)(346002)(377424004)(199004)(189003)(25786009)(229853002)(8936002)(58126008)(305945005)(86362001)(7736002)(31686004)(16576012)(6486002)(2486003)(59450400001)(52116002)(36916002)(52146003)(76176011)(31696002)(16526019)(81156014)(26005)(105586002)(386003)(186003)(316002)(77096007)(23676004)(81166006)(65806001)(53546011)(106356001)(65956001)(50466002)(47776003)(66066001)(8676002)(74482002)(6116002)(117156002)(68736007)(478600001)(956004)(486006)(97736004)(3260700006)(3846002)(476003)(230700001)(6246003)(446003)(65826007)(4326008)(11346002)(558084003)(2616005)(39060400002)(64126003)(36756003)(6916009)(2906002)(53936002)(6666003)(5660300001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2782;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODI7MjM6elZTQXpRSE5yaWZRQjF4Y21PVVNjbmVB?=
 =?utf-8?B?QXg0emdlZkJZaG1jUkxMK2pETi9MeDBsV3dkVzhINFl4Wk1XL3YvTEpMb3dk?=
 =?utf-8?B?c1BabittNmVRZjZ2b29IbkVCQk9XNWNMOExEZGRVR2M5ZDJsb1R4US9jRm12?=
 =?utf-8?B?MkI5bjhtLy9hWHFHZXkyc1F3SWI3MjhLMkU3VTRjd002SDBodUpaaG5SUnZo?=
 =?utf-8?B?WFh3bjhacTN1bTZROUM2VWJaVFpUNDEwWmhiQktsZ1JWZ0NJbk1EbDlERTM3?=
 =?utf-8?B?bFBqQmF0WVpmV0xTRFR4elVWNytibklJSktiWS9DbVNLemQrTXlQL0tBNlZO?=
 =?utf-8?B?QmtKVzFkaFRCNkUzWmFpTzg3UmRNZEE2dklCRjJUc1ZTVXNhNUQvL2hLd2JC?=
 =?utf-8?B?Ujl6dHdPUzFJcWVmNXE5Z2NNQm5KZVEyTTd0Z0d0T0lZQVIvRzZSc3BIOTlL?=
 =?utf-8?B?K1RCdStocCs3aWlNVTM4dzVwMUFnY2Rvc2MwcENIUERlckJuc2MzSEFhYXRs?=
 =?utf-8?B?dWkyYitsbUJXcHF1WGdZSG4rU1Uyc3RLdjhIa09VQTQ2aHdYSlI1T0ZJYW9N?=
 =?utf-8?B?ZW5KMHZvK0VML0NPTGFpWVpUWHlUQXFXdGkrOGgwNzdSR0dXbTdCcVc1MjF2?=
 =?utf-8?B?NWNrOGRmVGF4eHZlQjFBOExMaFVtSThBT2ZZM21jd2szblgwSGk1ZmJLRGEy?=
 =?utf-8?B?cGgvS2lGNFhYZHorSTJ5TUdIS0lNa2cyK1FOTjNyRUIxdlY0TEVzckE2d2hv?=
 =?utf-8?B?bmw1Z0ZxRTY4Zm5PUVhmZDMrTXJCS2Zsb29CbnBWcGFMaCt2QUIzZitnOU5a?=
 =?utf-8?B?UzdhSlJaQWdkWWlJTDRTR3NTb0QvaWtKQjdEeGV5MTErWTROUnk4M0thMVlH?=
 =?utf-8?B?Vmo0QktTcjExNUFmVnlZa3VSSW1BWWE3YnBjQ3dhQ1AyUklQc1M2YWtZeFJV?=
 =?utf-8?B?cjNlT0E0YVlxc05IZ05JanF2Und4SEg2eU9pU1A1S1AvSy84RGhIZE10N0Nh?=
 =?utf-8?B?Y2FIZ0svWDRYQjBwSCs2TDlxMlR0VTdaSG53V3UvMFAzTGp5UkcvUUxpN1Zv?=
 =?utf-8?B?Y0FQQzkwdGlyQjQwNVFhcEtPc2NPZkRuSldGQ0VOa2w4U3ZzNVkrRXU3ZWdo?=
 =?utf-8?B?clZiTVZ3ZVBRRTlCbjU2eHNVdC81SXlZZ0NzUThMMlBwcjFvd1J1VEdKWkJV?=
 =?utf-8?B?WlUwSlR5S21aQWZCc1JQY0QreHU3SDZ3UWF4YnBTUWpLR2dEa0w4YmVPY0lW?=
 =?utf-8?B?S0RaUktsUXJxY0gyWTh1dituT01PVktacTBNWXZRdFJnK3liUGhGaFh5Y1k0?=
 =?utf-8?B?NDd0cG9WemhrbEdXZmV4aTUveVBaOEdvUGpuVzBnbmNlTDBGZk5PRWQ3bXdn?=
 =?utf-8?B?Zzk3Mk9yWkVPblhSMmp2OVB5Q3dpQUUyZ0Z5d1dYOTEyTThFdlJyZWVzeHZZ?=
 =?utf-8?B?L2QweGhuUTRELzZvaEVnR2FKajFOcjRIb1RqUkVhY3dHYWxOWWUvd3R3ZnFl?=
 =?utf-8?B?RGhUSmVmb1lwNlVybmRzdWtjU0xSYk1RNDNpcmxsdE9TWmdqTmFDWk1rZnpi?=
 =?utf-8?B?WkV3UkhNb09wNTFqa1orbUtuL1Y4RzE0cEdJalBybDB2cWFwQlRtWXQwQ1l3?=
 =?utf-8?B?dmNaYXM3OTlEUHZPQld6QlU0QmZVaWhyMEFqb0JHUFpHeVJpNkE2TSszaE9s?=
 =?utf-8?B?RXBoVTJ1ZW1FaHJPVnpaUEJsT0pLeWhoc1RrZW1BMm9tZFFESENBZDQ5aVlV?=
 =?utf-8?B?ZUYzYXRyMENRRTJxNlRBUllLMDlOd2dKTHFGdEtxck9zUjR4aElOU0Q5M04z?=
 =?utf-8?B?M0dBdFFzUHRnUU9LeHRVVGdKa0V0Ny9talBKYjFGMkdaam9WZngzTUZiaWlF?=
 =?utf-8?B?Y1VqU1NqUU9qdFBLQVZYMGpKMmJTa045MXZYUFU4aXFFVDdZUFpFWU90STZG?=
 =?utf-8?B?cmFQTFN5TTBpbjRieDlFWVhsRlJpVUcwK25EbExDWFRvSGxJaUxCdy9iTG1y?=
 =?utf-8?B?WDNDRHEzWmVnTW5OSytXMXlJTFozZTRnWjNBdHFHdkkxSWh6U0N6T0M5eFd0?=
 =?utf-8?B?KzI5YTJmMWFBODBFeGg1ZkVPa2p3V2lhVUtNRWY0S2pPdFB1Z1lTMFVRS3l1?=
 =?utf-8?B?WDBsKzUrK1loMzY0dy9PRTVaVE5kS2pSSHRUdTFVTERYSzF0YXE0N2wrNGM4?=
 =?utf-8?B?K1B1d0tVWExFTGVHc1pTMTBGNEZETXc9PQ==?=
X-Microsoft-Antispam-Message-Info: ofga4DgUHYZXoTDEiXrKx9j/Tr9X5oR1M4CWZ5IORzJzBGETgyj6W1KxVUXxGGKX1i3d8gf+i6H76SV+RNqeMIa3l4J2fKAvu08+JasiAeoW5kQsF/L+iqCc/JFQKBqvRAUv2H9UyM9hEMk7cpLpN0DnLn/vNYpC6jxYqbR3Nq4I0N9fIHn1GwHZYtFXy8mO
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;6:93dVSSzhu6LIMimrQ4ih59P7KD8QWEkyTqeGvfbDVbUqGSGHJ874iqps1cHwrvpxa9xhPEG+ZLbGSgK83G+K6RNWHSmvcrb/5Z4F0g/N3Xziguzczl4FHFYOSsGxp0A+HyiM8u2mKfoSWNuIX85h8RQ/HuDam3sb8bmQDdaUcuD5+/u+8GuRvtg4WMtwfUhsNx/ZcntiC39GYw2a9CECNlku6tXD1Zud2NKr+1JcaREqIpBnstB9OAWfQqPxQZMg3/sd7g4MeorJmxD2XP/PNab/4fiBvSBL2A7+oIhNE1Tfdt0ak4VPDYrtI5EijFEWmhDje8uNEYjV4s/+Poey/rzqLZ/MrpFEqIfC93fSSMLqUlzM4XkvVYIkcKpGTF/sF0U8H66jQ3eKg0h6lqUccar+COatQ3l0y8tari0VZgAgx1VWDiaFEvodDB7i1AzwswtNjtdKNI6+BcUeMfFhYA==;5:MZzUoRyDjzUatwg+EXlQx31AbhFqd1TBtrZeLffB5f2FYSzUpwdB9lB1S/49d6tqPsBALy5f9N462K1F7ZvIwX2SQdJBH1Rq5HbIqBfTe9sJKZgMO5m4pNaYfBLNnCHPZmthYh4qQRvgi4iuHsWlvQVY+ryTBgVcKA4OJmfNHM4=;24:PRkYINGeKFzavKoErjo4toA5rt2FRNzHU9Q4uhCEyPx0aOZYzUsERIq30eXVwvMoirH9/EJMaTM+PaGZsqdMcV5YczpQRUaz/qAGX26Rfd0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2782;7:FJEbo6VJsYw8GeC9JdRlgk7LV9V3TIqWIdZl+7igYjygc1lcnENZ+DcEZhHFL0bDbpYg2GtC1JA4gzIT7u60rnn5UGpI8sKv9KozywVG2ENDuSO/0D9n+2JcmupsoAN6Ooc9X7NeAIKjfqA6HKXc1SVmGjOwtVhc02zNbSIJOLK7SazMfvQHXFHE7QsMrl9yHdb514cTJv+C5x+Rny3gPyBrpnGEpe4WP1Ec854VO5WqnMLzkzDXsgxZdktdW4db
X-MS-Office365-Filtering-Correlation-Id: d3a84a1e-f2e1-461e-64f7-08d5c16cf90c
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 11:53:31.7385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a84a1e-f2e1-461e-64f7-08d5c16cf90c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2782
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-21 11:49, Julia Lawall wrote:
> Drop call to of_match_device, which is subsumed by the subsequent
> call to of_device_get_match_data.  The code becomes simpler, and a
> temporary variable can be dropped.

Thanks for your patch!

Applied to i2c-mux/for-next

Cheers,
Peter
