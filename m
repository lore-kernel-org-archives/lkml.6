Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966302AbeEJPgj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 11:36:39 -0400
Received: from mail-by2nam03on0057.outbound.protection.outlook.com ([104.47.42.57]:60480
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966093AbeEJPgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 11:36:36 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Igor.Russkikh@aquantia.com;
Subject: Re: [PATCH][next] net: aquantia: fix unsigned numvecs comparison with
 less than zero
To: Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>,
        Pavel Belous <pavel.belous@aquantia.com>,
        Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180510125201.19707-1-colin.king@canonical.com>
From: Igor Russkikh <igor.russkikh@aquantia.com>
Message-ID: <e0d3695f-89cf-f1c6-6284-f244fa58ba64@aquantia.com>
Date: Thu, 10 May 2018 18:36:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180510125201.19707-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [95.79.108.179]
X-ClientProxiedBy: AM0PR0102CA0064.eurprd01.prod.exchangelabs.com
 (2603:10a6:208::41) To BN3PR0701MB1656.namprd07.prod.outlook.com
 (2a01:111:e400:58f2::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:BN3PR0701MB1656;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1656;3:+i1H23MsXiDfk8Jx2Ud8+atCV/bnjNNkK2z4zxFvZDBPNRjL+Ya9UnfpqlTMlGw9nIJ6HTN5K1TQl8AsKxiZRWvelfsKEV577oPj38IZFReje9mbWKgd62qv7Qgusu5hQgc4+GTBk9C5zQTT/6RP5ZYau9ypU5u0vIWfNM+UOxvDmrCl4FEaWy/uXnbrhgQ2jYPYUfDXrGk1kxcbWb4LTFpsIiGMvkZuWib5dhsnazFiB5O2fo6O0ZXrbk69oXC7;25:Njy96jNzfaH6RrPwUgim6T3cMUarni1Z05EIceU78lFq9TfJaHIb44LoWZdjMTOkCszxChOZ7CGVFyNLzSu1EvZe71h9xaP73K4jCC89/Wxt78U22hpwmzntFowpkuRAwJE7fH24v5Tke04SPROtRrK/w/FRaBKggH2k+LUpJ4jy/RnQwt8ee3gY+ggxeuSpJTSHrJxfFoSCLdG2xqdViESSx5unRfuh6weilWkI3aHHxyCNsYdsJiH7ZR/jFzJdvUVb3pEu6g6Z/GQh8kReFKg2y0wXeYz62FMFUe6/oxlxmd/j6envPL5ULocfmdx4DcN+8IjeXHVrmvAGEF1rKw==;31:uS5w9QYJi1s+kNe+tPl529XjmF3Gx01Ub2Y4rmML2FflPZNNwpNQi31HQVgL+/5tRXMwcyBo2sXYRZ/Ha2mvmb2l2B5d+HlH7XYzc+ElcjYv3pSso2YJkuxBBL11CEj8+7j4W8B9942z53NVZHRc85EbG7bMWmhMbhda2EZq1ofQcBGKnrfF/MmyOPiSQvPh46S9FxsZeX9WDN7XSidNmDasRDcFaXdKEZfuCdW4Ii8=
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1656:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1656;20:xSIPjIRXE5Kb/mD3nIzsNKaFsqHqk1nbNM8qKHaBzIH77Cf7ertTRFtkyEUEpYYknjFlA//4FamaSYV4IWaX7ok6Z5iZe8uB4nDHmQkcirDoSm8DRDX4+BCT736Aaa6x7IHjlRKKwoUdp65HGMpMssvpvgBlXHXTC5X4ETfLfcPAmJ9g2F6f2+0Z0TasyvvTPhWLM6hkX5bMSQ6fDoxgEo3KIhBv8bIDNYy0/n8DRRXcH8ia8x5RIOjEsYG9YU7fE4lF8HnM3cJo6zVtCdwdJcEyPPu4iKVgaNtaba8dVylR2Yn82h2uBA4Fxszl9p4vkIZJNpTBGBkkxjboYL9z4HRwzBwJ55LsaqInenwpnHr/27sSPzQ+YFR1rmv3c1AvN9tn+BbtwiPcD6oxEZ+10g/dYM17jC/zsHUoUWFt7lLtpmePFnAR0eiNhELkLsZcTSfUlt72pNsMOI5r7s+bonB4wIE8SPuIZ5ctD2TC88LNtr0wE1eaynEyD5JHEewN;4:QEXjLVzdwevyuPnwN2R0JgPS7ySO4lRFL5WSzYVe1Eu6zF1cWOfJ6xXMKuSZY1zjO4UFwiSd9CKd/F1DBX+RNSbiDRXFo2HaACbfvOWVLUvXMND6vJDUecgGzdnzVLR+XlAAm3pZV7/W7dD1wt28221Q2TmqoJfLLtlyzMFFeP+zHTQwGGLhpo5+tYZ92OANdZ0us43Y3gK9sa6Yj+hQBofG+0INTrFHkVMyK8ToDpRIjBewDcu6hwJ45ZXWJ+PsGHxo3sd8jqawQMJ10WwLjxPfJ/WUPzP2HW9Q4N04vJ3qlre7cM5x611CrGJRDOX/
X-Microsoft-Antispam-PRVS: <BN3PR0701MB165633D8F81CB59C176AE43598980@BN3PR0701MB1656.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(2016111802025)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:BN3PR0701MB1656;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1656;
X-Forefront-PRVS: 066898046A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(376002)(346002)(396003)(366004)(39380400002)(189003)(199004)(16576012)(110136005)(58126008)(316002)(53936002)(31696002)(86362001)(2906002)(50466002)(6666003)(72206003)(105586002)(31686004)(36756003)(106356001)(6486002)(229853002)(68736007)(3846002)(6116002)(230700001)(65826007)(64126003)(478600001)(59450400001)(25786009)(7736002)(76176011)(305945005)(23676004)(52146003)(2486003)(446003)(8676002)(186003)(52116002)(16526019)(26005)(8936002)(486006)(47776003)(77096007)(6246003)(956004)(65806001)(65956001)(4326008)(81156014)(81166006)(5660300001)(44832011)(2616005)(66066001)(476003)(386003)(97736004)(11346002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1656;H:[10.0.3.15];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjNQUjA3MDFNQjE2NTY7MjM6ZUVaUGNCZUR0RlFmMmN4cFNCbENuVFZj?=
 =?utf-8?B?TENYR0poQU5ZSlVJVU10UU15Q1JrMFBxd00yUDBiVjlqZ3J6SC9XWjFuRXJW?=
 =?utf-8?B?Zks2QU04WFMra0ZXdllQNUMzd2Q2QU5KNncxbElZMXRoZTdWdzJ5by9BVExx?=
 =?utf-8?B?MTBTL0NlVzkvSDFKV3JLM2hLOG1aQkxQQWZIbE1RcTVnclFaYUJJSU1iN1c5?=
 =?utf-8?B?c2JsdytoZGVCaGZDam9tVjBkTUU4V0pDc2hKS0hWMjRFRW5jRmNNQzVicm1C?=
 =?utf-8?B?SklJMWVnMVE4RDFKRWtMWUY3QVp4aDFCY0xIU25RcjVXbFdnQ3FoZFpwcGNN?=
 =?utf-8?B?YVBVTEVoV3liRi91TGpGb1ppY3N6VWlLNllkQ0djYkpiNmMvOEJITjRzd2FK?=
 =?utf-8?B?RDB3Tnk5enM0Z3M5VnUxc3ZZOWx4NzRuYmNjbDNzeUlOV3dBeENLUzNtVk9k?=
 =?utf-8?B?endCZkxncUZrSzN1UDJuOWM4VHF1TTZjUXhoaEJteGFRSEpBZmVMTlRSNTlW?=
 =?utf-8?B?Y1loRzRYUVlFanBSblBGNUxyNy9UZHR4M3VkcVhsNUFqdFRPanZrK3NJM1VL?=
 =?utf-8?B?RExnd3pseUJodEppU2c2dm1CNkdYYmtCUG9QMEhySk0yTG9ackhhc09GN1Fr?=
 =?utf-8?B?Z2hIUnBleFFrYmZtNG1jR1EvZHNkQWVNYkp2RkZqUlV1UWtrQmxSZEZWMFpQ?=
 =?utf-8?B?NHRTQjBOekt0UmxWc0F6bXoxZG1BTmJQRGNhTkNHc3ZPaFhXZU5lSTRXRm1s?=
 =?utf-8?B?NHh3NnJiVTVvamFJaWhRRVJlUkVvOHJPKzVPWm5wZkxOT1ZpNXd4blJKNjI0?=
 =?utf-8?B?N0JvdHllRFJOUG1rMFRPc2t6RllFSFhqNnBleTNERUhaa3B2eWFhYWZ6dllH?=
 =?utf-8?B?NDFDeTFVMER2dlBBVEVFTThrU0lnTHA5eUpod1RBS1NHU29ta21KTWczVno2?=
 =?utf-8?B?OHYvY0xITUtPZElQdEErVWY4RzBCcHZKcURzV3piNHF3TlhkZzd4K1ZMeHFZ?=
 =?utf-8?B?Zmp5enJRY21HQ1htYnRYby9XN1lOUmtFbm54b3RoZ2U5a084MzZmSm1lNTIy?=
 =?utf-8?B?cDlkbm5YWjlVUXl3R2hCOXl4OGtoOWZDUU5wTTJUV0I0NEFuUUlQYzJzWjRn?=
 =?utf-8?B?bmN0WUt1NFl3SXEvQm5GWXptV0RNVmJ1NGZaOTJkK0M2RE1qS2U0ZGhCTFFE?=
 =?utf-8?B?SElRWUdhNHhqWnhjbzFrWHJhK3lTZE83cHBtVUdGb2F6U0lRVERRNUp2WVEr?=
 =?utf-8?B?d0ovWXdURnpTTlJZUW5EOEV0ZEU3OGtnUUVjdjA0VXR0NE1nQVZ0WHFndW9t?=
 =?utf-8?B?NGNreXFhMWplaGFHejRrcHVDSmJ6K2lKNHJYZzFJQzdlU0pMQmRyS3NLVzBK?=
 =?utf-8?B?NnJibzJ5YWNTS2JOcTlkMWJLdVBwcHBKQzMxeVhWU0YwMUNxOGJMQzFoWkFh?=
 =?utf-8?B?eFdqYnJ3NXlNc0g1RkNUOUlkNTlxaThESERNVStweVh5YUFCVzB3RWNRVmtr?=
 =?utf-8?B?OW1mcUk2dGt1UWdrSjEvZjQxVzJkQldzQkNLaHk0bDhrbFFYeVE3aHZGOHhs?=
 =?utf-8?B?bFFkVHVkRDl5WklVMlhrckNTeXJnTzI3dXprZ0FCdjgwVzhMZjl0RElsdm5l?=
 =?utf-8?B?cklFKzVmbVRzRnlQblVScDNRb1ltOG92RldIUHU4RCtlOUVvOHowTU1tclU0?=
 =?utf-8?B?V0l4aUF6dE8xZmgyaUJvUW9BckF2SC9ja0gyTC8xdk5vWnVUZEYzd0hjS0cz?=
 =?utf-8?B?MjdaWHVWcjBxYUhhM3BjSDJ0d1NWVjVjdUEyWWVCRWtlV0l4ckZJNG42NUtB?=
 =?utf-8?B?KzRVWHdLRE1lMlI4MmVMMmM3R0QxbnpjUTM3VXIyQWdPOWRKWFM5cU1mMDhE?=
 =?utf-8?B?WDBpaldoUlVxOXFwNm5GRHh4dWt3bkNtKzNzVFVSa0c0MGhFdGpvZEFYeW8v?=
 =?utf-8?B?K0tBTFhxWkU3c0FqdjIrblJaVmRmY3Q2VmFFWjRDZXpqMTFHRUppVmE3dGFF?=
 =?utf-8?Q?0hpCHs8R?=
X-Microsoft-Antispam-Message-Info: MKNLfZmRskecJ4zL5d1o2m4JkS5KSBtT6i3ONGlVut98OuQJvZAVEfK/2QkupZWleF94TSyiOA19uYLEXjy/K+ohwfW7U5MUNWxmXxGW3cr0syJBoOXayKTMyoYdaYOoSt4odx2CK17yTy5n0cUh2Gpj7YQRE3VZlymDnQvCIwdhELBHwrgzIT6vkUD7xZLa
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1656;6:3GnklGbaFs6M3XdM1w/TGyIb3TotlGmj+m3pgkGWdkeZFusaXIHahhpxo6CWlalW7oGzpUeUmNf/ybRcCMewPIslYt72L7wU0tdbkRGoIen8m6qV4fnX+kDBo8EmvgmQPJgFTOLSyv2P1MGghMwKmQdM4kPdJZxQQwOZ1IJFd+bf3pWOEe6Rf1Rs83J/6aLn9VMx3Autp3wjMjWuglZ2ZE6p4RrSkGvtPUUVab00eVbAQ9TjLgx7IwPlvZPcgDEfByjhp4Ns51iDIGXpd4H9KIaR+0cf0zpr2Ifp03+lmBooesb9Nan5SqkIzqNm1RxoKznMZPxuprCUflDdeIZ26dMTEj+8sEr4nVnmIwR29oAT0geQlgKyYAnuzaDQ4o1wPiVwUuziSMtSnJLgVGt+v8d6pJD3pcZ2jbYGtJZCgpeaOEi/np/zm8lFmqzU/crfGPd/YRi+dd0Vt711lqfRJA==;5:hqteAytmH7l/8LyHpfSXf9qk5JuNcCEh4YnOm6yAem8ZD0vptvaB3Xymq2wSzCjKFYY6PfkC8L0Ztz++MpiGdHs0Cdn+dGBuaUEMLlCssr1N0kxIMDVLgoSJPkvMtdvIFxYE+ZFmS/dWmffn0aWTfhcRn2pFJOWs12fKKLY0DDo=;24:kraEJ05FT2Tt8qiCtlTRQOlX2vFzDW4wVqFE810w/urTrF4/XXWBdqkdp013/vKo8eAfQ0lTZtn75vmHdKnU0d3WSEaGzCsJl3lEU458Cfo=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1656;7:ZgZJSETXe2WwL47LzhLsJqposNtSvpSgDT2L1MtfKoMRoDU3k27Y15Zl3/yk92inCL8CA0LSgs97DmN0efu/TFimUMvwIBxlojHcJ9uMpVS9UIJXAVKobn0IVsMpayrAsyrJ4eRP4wq5gyidfQ5+HO+ONUUBeuqA3fqFXpTQjs1rxR9hOBp92WZclVmU+HXEKVKmhWnNYcbecrMJz1uTkljLqfNc2TVxxt1p+7RahOLADW5C5iJ3SIGKGbzrIds9
X-MS-Office365-Filtering-Correlation-Id: a760bd33-4f43-4b39-028a-08d5b68bcedf
X-OriginatorOrg: aquantia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2018 15:36:31.3504 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a760bd33-4f43-4b39-028a-08d5b68bcedf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 83e2e134-991c-4ede-8ced-34d47e38e6b1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1656
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks, Colin!

> The comparison of numvecs < 0 is always false because numvecs is a u32
> and hence the error return from a failed call to pci_alloc_irq_vectores
> is never detected.  Fix this by using the signed int ret to handle the
> error return and assign numvecs to err.
> 
> Detected by CoverityScan, CID#1468650 ("Unsigned compared against 0")
> 
> Fixes: a09bd81b5413 ("net: aquantia: Limit number of vectors to actually allocated irqs")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Igor Russkikh <igor.russkikh@aquantia.com>
