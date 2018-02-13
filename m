Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965445AbeBMSXH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 13:23:07 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40356 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965158AbeBMSXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 13:23:04 -0500
Date: Tue, 13 Feb 2018 10:22:03 -0800
From: Dave Watson <davejwatson@fb.com>
To: Junaid Shahid <junaids@google.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        <linux-crypto@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sabrina Dubroca <sd@queasysnail.net>, <linux-kernel@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>,
        Ilya Lesokhin <ilyal@mellanox.com>
Subject: Re: [PATCH 14/14] x86/crypto: aesni: Update aesni-intel_glue to use
 scatter/gather
Message-ID: <20180213182203.GA2122@davejwatson-mba.local>
References: <cover.1518211765.git.davejwatson@fb.com>
 <20180212195128.GA61087@davejwatson-mba.local>
 <dc69bdfa-6dc2-da54-9d9a-b171aeb3212b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc69bdfa-6dc2-da54-9d9a-b171aeb3212b@google.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-Originating-IP: [2620:10d:c090:200::4:5f28]
X-ClientProxiedBy: SN6PR0102CA0020.prod.exchangelabs.com (52.132.112.161) To
 CY4PR15MB1752.namprd15.prod.outlook.com (10.174.53.142)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6aa36b5-4e32-4d33-ebf7-08d5730eb484
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603307)(7153060)(7193020);SRVR:CY4PR15MB1752;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;3:0BUiCFHJf14nJA2TWGBCEIa7k5p6c4bJLdptUbyMHNv+LA1mz65qkkW7f3D48ks02pQNPdh+dGJnbFVUW6XRuVgrHKgfILylReZhQt8fLuVEifOSy6WKL4KfQcPE3b21cnIxJJJsVsObdz8yNM31TuIZt2l16uFo+XzCHuZlOfofmNONq/L1HrjpDBKHByGEvC0HU64fC+L7SSJyZgg3A1rB2WtWnu+3c3VJr3RZf2eT+XtrZBI9RkQwKgFyPNUY;25:mnycZsyX5kgK17QorWxZHdWt6bT9/qAo55SKt4Xn2GpIyP0Y3ilPnKJXPiM63xRli59Wqlc/c0NNtmyOq3j19cvnn35QKRaNk7p/NTD2MHJF54bYN5/qUcLj3tas5RSQy2TJs3HNkYYkQLK88tM/MKpEGAQ/npfo43YO5/9qhkDe/LyTzkPwsgvCTxBf2AkURpU4TRIGGDgU9BNY3/nbiLXSKW8mFRYogcxGpHQgXGCH+57fIDjqWlby50495yPWMVC1gTDut+0ZiM+xc01mNcPlDfAKN2VD8fy5uunXHsw3l+dt5PjNMlpfPi2QyWT4ePr5hchrUxWwyvB9s3ZK2g==;31:dawwfjnOxWmrglar6O/dKZ67X6uvdzdU7JQrbWDB8NY8kKgGubakOxqEsKkHpQTN0z8aXv+erMN2EjcNl/quZOYunbd83wEGA9e2OimjzvV5tEJ313jfF8VoMKwV5T473EBv02zO2KqzIUCxny7xRC3rcznouRt6xv0exV42+c/7Xdv2WBKe79U6+UfNrsXMWaguel+0LO3NWVKojVjDaUgrCL7YWm2PYcyG3DRP0eU=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1752:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:EV3WxOtbm8wYgjz8V6C2tCRsbUBiMnlteZHJsApa5m7DIDDEckLsvMhAT+y6by7B1PbGB9GIEJIatKO5NhEpZ7kaCu7sMmC7JLl9CY+v9g8BvgHPn2wG8UC4hg9tIXtHi5pQHk5RT//Uw9JIfH9Lk5VAwHqQAGMnf9tf4fP7OS7paCXMmo6W773skOPdZi2adGwJfVnadjfgGEC4woC2LlXqBOhk8Y+FTx57hlTHgJBlUmCqjKB14a5838jRB9PXpTiYdoR+W4YKNls7VfC0swmqEtqF1zuavoUuMckwV1LQbh7rwbfF50f/57QS4Jqr+k3QHheQ37flX3GosRHfd1upskqp5q10d1Fly/eLtE9QfuOHX3q+PxH7iUIKo17d2AFBvoAzTdCJaa6MNRnS0nOvS8sUDV5ApI2NSkAJfQOdsq/uKdxzhJaZOqSLV8JSlZuWEpa2kpuWQjMqw5R6RDUSmBSrV0wLwA1lms2YELd9LZzuAUNgV8nrLvPPzaTv;4:/yZdvb2BqnSfS15h4y/rjnvVguzdEeRRaVbtnIvIUH/bjJVLJNXqxRxSmF9n4fIQWVJvovx6uS3AORYTy1p3ig0JWLREGPqn6cjW5CYzFZl/+1/fLvUgJM+JePKG6d9c4w65gwkdOZc+nFpw2/FPJ0nQB8+bD9ZKTBmXBnQ1KUxjFIR+i8F+fs7a7djq+nBpzLAazahCoKLVEQAqWzX7VBm6MYltBpJ/Quet9RA+VoRa6r4SUUoYdd5LRkoN/fAIUEywx1OICI3CtyqFv/JQzmgJ4C/ws6GTSLeGkhEVHBAn+kjS9CyYTL3KqnbATZFM
X-Microsoft-Antispam-PRVS: <CY4PR15MB17523FD631B0657F8B595512DDF60@CY4PR15MB1752.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(266576461109395);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(3231101)(11241501184)(944501161)(3002001)(10201501046)(93006095)(93001095)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:CY4PR15MB1752;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1752;
X-Forefront-PRVS: 0582641F53
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(396003)(39860400002)(39380400002)(346002)(376002)(189003)(199004)(6916009)(2950100002)(8676002)(6666003)(68736007)(1076002)(47776003)(4326008)(6116002)(478600001)(5660300001)(33656002)(106356001)(23726003)(98436002)(25786009)(2906002)(7736002)(105586002)(52396003)(16586007)(54906003)(33896004)(229853002)(386003)(53546011)(76176011)(58126008)(53936002)(305945005)(76506005)(9686003)(6496006)(6246003)(59450400001)(83506002)(52116002)(86362001)(81166006)(81156014)(97736004)(7416002)(16526019)(186003)(6486002)(8936002)(316002)(50466002)(18370500001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1752;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4PR15MB1752;23:yr4QUY2Uhl8ELCfwCY1xLxXngcDSjScg2XvIkQVWE?=
 =?us-ascii?Q?Tsu2qxFFH9DBx8za6kg5oMpF2DjLx9oKc22TrTx9Ag1WvHz/AyUyhrodbkGw?=
 =?us-ascii?Q?qFrv+rERNw6WGphRv9a8a9QHggFOvih0GjDR0Zmj4qV5257EXYHscVK/v1R9?=
 =?us-ascii?Q?7Gf2VOYXcLHrz2jFi5TzXjZfBuLnJ6iZK2GpLIcz00HCVjHeIvTu+4p8frMK?=
 =?us-ascii?Q?Uu1+azayXqGZVee2+FczN6Mmaw52/tw4AZJ6GAZhiOh5e4QDXzAAKj+NCCtU?=
 =?us-ascii?Q?g51VZk58M14hBm6ASG/Dz5aRCeHzDjed3rxcU47UBJJ0Q8C44NK9l/YPSbAg?=
 =?us-ascii?Q?YbPNDhcdmBpHvGEimGx4w4KIvno+L84m3shrI320XUMQkDxnvv8n5zohYEIK?=
 =?us-ascii?Q?1fcvJERfqFDTlUX1fiG9Vdm1yBH6uL99asJYzyePO4pqqtl2ptBcyEGCNBu7?=
 =?us-ascii?Q?QnLl3zmw9HhNzKOq5hQImi2hHGDzJ+Bj4NF5nx1Hn2rEzWBWIvMWEBvFfXuw?=
 =?us-ascii?Q?J65Wxm2XnHpJ8tdkOP3fIc2XxV7+lC9UFjRdYy542/QBrC/sxfJEDP9Y7qju?=
 =?us-ascii?Q?jaRh+9zxtUtXgWGwcJjVw6gh1mpUrf3u1eHwEs7PVXPNPThI5UYx+KG1YhFh?=
 =?us-ascii?Q?4AeDGIUx9Rvzm9AOiV4hx+0C5jpCabW7t25ktnc8NhFSkP9mWz3D7bdRauKq?=
 =?us-ascii?Q?Gg44BbLCsyGBQKyR1tncPD0s0cDvi0jeLl/Qx9DPWdw0LI+2tgr8uIa4qlRe?=
 =?us-ascii?Q?kNDagmjWI4+HPuwNixUpCQUhwUjXsh7YPXXDvTvsPtXBZeX4b4WZiX89n7lw?=
 =?us-ascii?Q?A9StLIySRe9209z3emSXRPHJrnZ69BQh5D3OQWlgvUb7Zixc8hjXFKx30y5i?=
 =?us-ascii?Q?vky9KaI0XSbOG3xi5wG9ccFth8vWo5pSvweFB313Euh2X8ZmcQmXgXE9aKtP?=
 =?us-ascii?Q?p8GVxEuctIdYonysLoKy43jitx5QhtFADDy9umLfcxomGDxwhud97Ebw1uQ5?=
 =?us-ascii?Q?AYcLdk6kQoYA5K7vxasILugTtd0Unuep0dEjbPo4zmL5UolaR52XhzRrvcp7?=
 =?us-ascii?Q?s7TIaBHBL5ZYbCyL/Igtg09z/sSw/n4AglaHp8To5bn2rSaGTTwnAUqwnE8i?=
 =?us-ascii?Q?KXxqhhJKAQUrsyKgWRh488SH3tMzB5G/h8MNtnys64iI7iWACL21sO12J9Av?=
 =?us-ascii?Q?/0hFWYSCe4R9UWHQhLwHpxQj9Z7WFQTcdbsh25OpC5VjQuVLEgjZMQofMUuG?=
 =?us-ascii?Q?IkZHZCjJQ4oD947wyU9+PuVNTPgvijSh6O3A7cNM0m2dqGHTGCd9Tz9pWfx5?=
 =?us-ascii?Q?CUjgqXRBaXmTelItjMxI2ZqmBUF8gA1DCTBA4IT8Da7?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;6:9j6gs1316bSPgh7+AIFw82dBOn+hUxcZbWFN/9Qndj/Q0gqHUcrmEIUqH9Hjdv26ptNYpiHzq3AowGup3CD0RzaW8/8nfK8JFlzZv1oajYXVV/hjbV1bIp8Dl0gSagEapFwgiZ1RFJhxSHyjLhljyzEMOug9xPIn+FAGXGkiWWi360TVfzNIp0wGUYzhYE0WJh10GvKOzbHtWmAh9roqkPgTA0aYjJnrtWydLZ7j3QLgLS2tUfScngAhyg0inRVN7wulD5wccq/e4T3zawmpNjZIRIL+Pv3p5ZCERsfrAl2aKpHB/14cNx+K3+Kp2TZebpqxBPMix5rX+m74pnCwqdyc5z450rtM53m7ZTG/jqs=;5:B7bylqTHGfIwEdi2nH5F8FvkjfsUwm/VItMXDeqKRai8mRKh/w8qAwV+4Ni6NqMufYzcGENih/T+8cjcLUAhFY9EclLqkBrLzKbmQBE5F+IefXysxzdMJU9Vi9/UfdXXXZ/i0MZiNi3dohp0tJ7cZUlQ0yi9IyedYVj6HowTkz4=;24:j/YoOky4Q5KuuVVB0Zq9umonEh7vx6fgHCURMdPpZp0nzcUUY/FHS3PpUIlc9CWa5jFBevscAL5imj47Bc37R08zhBe03dlqrKOMAV3Te40=;7:eNPYRKzo4xBV0MCl9L/3CVYJZZXT+KJrum8Ibx3t46fqKNVPwz7tJUuuKV3//CIsu+phsuDHgzzvpCehnQPMu/vvGTRUoCyuZSAq3oCfQ/cLvheiVYVDsY2IisVZkF2fe7Rz+qQyMgE7QQ5MMdv1eESk3fTQyBWyAs9lP8gzWWfZpO8XjAGFpOSwuvACFnw0wIzrzKsLMqVrh07KSZbzxhDKeeIdGu1ftpGomJAuwmpnw0O8x3uduotsilO7AE9k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1752;20:Xl4GkcxC9cVd194o0ZRzJDrgsMokP+prNoT3TY5DqbC7gX5XJIkSPtLN7c/Onlk6qNmw20FG9cpXA3N2IxFPzxA1xdmDYGTLP8OQ69Pp8l1gP85LkG7mLGolREb7U2xmUnAzZTmiF3i4NyzmKdbdTiWZXR0M3gDrYgRmiGw/76E=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2018 18:22:13.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6aa36b5-4e32-4d33-ebf7-08d5730eb484
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1752
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-13_10:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/18 03:12 PM, Junaid Shahid wrote:
> Hi Dave,
> 
> 
> On 02/12/2018 11:51 AM, Dave Watson wrote:
> 
> > +static int gcmaes_encrypt_sg(struct aead_request *req, unsigned int assoclen,
> > +			u8 *hash_subkey, u8 *iv, void *aes_ctx)
> >  
> > +static int gcmaes_decrypt_sg(struct aead_request *req, unsigned int assoclen,
> > +			u8 *hash_subkey, u8 *iv, void *aes_ctx)
> 
> These two functions are almost identical. Wouldn't it be better to combine them into a single encrypt/decrypt function, similar to what you have done for the assembly macros?
> 
> > +	if (((struct crypto_aes_ctx *)aes_ctx)->key_length != AES_KEYSIZE_128 ||
> > +		aesni_gcm_enc_tfm == aesni_gcm_enc) {
> 
> Shouldn't we also include a check for the buffer length being less than AVX_GEN2_OPTSIZE? AVX will not be used in that case either.

Yes, these both sound reasonable.  I will send a V2.

Thanks!
