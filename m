Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeDEQbW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 12:31:22 -0400
Received: from mail-bn3nam01on0054.outbound.protection.outlook.com ([104.47.33.54]:10112
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751275AbeDEQbT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 12:31:19 -0400
Date: Thu, 5 Apr 2018 19:31:02 +0300
From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: pearl: pcie: fix memory leak in
 qtnf_fw_work_handler
Message-ID: <20180405163100.cuaedftds47pxdrn@bars>
Mail-Followup-To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180405154949.GA32223@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405154949.GA32223@embeddedor.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [195.182.157.78]
X-ClientProxiedBy: DB6P193CA0007.EURP193.PROD.OUTLOOK.COM (2603:10a6:6:29::17)
 To CY1PR05MB1930.namprd05.prod.outlook.com (2a01:111:e400:58d0::12)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84568be7-390a-42d6-d11b-08d59b12a6a7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY1PR05MB1930;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1930;3:+lc/qGcf4xgV5dj6h5eqSxWdQWY4afk72bjSC8nOKoLktt/Iwzj3DaQ/UyY6ignnejklkEo/wq8yy+RHGDjiiGOJvFwqWGEVFnzZW6JFIrVDepgwty6U8uxOiN7YzxzH6ff//1BayFu3C2F4Ym8aNb4p18WBJmLs6oIddEIMWHZdLFkkKR3wVKAPYoTzAtrWIoaQFnhsksQsRF/X1j4pzyYrOePPutF36OgDbL29Aa0oeoKoO2SRrKHyyWyGxRop;25:K+iOHweT6e+x/Nzzah/vjBHzrYUr7GPr+cKv/VlVmMNNGHtaPRG9ohagelspV8VA20IaYid3hTizIfTk5XDJkVFwh19jpEs75NjLtY7OynNGE6NEsIrUe0uWwBshhvsnNbejj+FHxVL2/ZYonLumrPDy7+kLRAfkxA5DWIjkowjfEtVV/JAOYv88YRfuGzrFOiQPYuPfGio/Vx+gtfBOrnwgFVuazoqGabXD4y5+o8yOELS/6sKKf4FLL3wspJ7/lmY8vxHhkBW5gz6qsgrphy+IWDr+xrlJrgVm5VuJLitLia9bzjjUPUM1EBZlJZaxWX8MTojI6knp9zy7+sVmxA==;31:5q6dsVAb1Rl3dHYIG2umePXuGvMCL4LyNn962zVDs6q8WE93u24x0qDSMttkfwjeMGXZRJ24e6GGSMmhCMG7D6Oc2F7SPa0JX17uQHBVIDav/5cYm/wuE6xpLTFRi0aBZBQ8OWHFivWuzSoYdgZ8sZ/ygiEuTwBhSMz8FeUwCcsBcCcy9SGEawDCD3MGYpb/+TlzXxxjTUiVu9TNfSLYwZPyoA/T1pOKcT2bSWub2ec=
X-MS-TrafficTypeDiagnostic: CY1PR05MB1930:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sergey.matyukevich.os@quantenna.com;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1930;20:MvrI4Jvq9mgShd1AFPtgTJ62Guf0kX0prayjCTYBu03kqm6816wYanHG/bsWgfgchBmQA7p5AA7IxYJQHT3OhiCzht4wIEVUDSTP77a5dqRaiwvpA2FUKK/dlfVyc0/G0qaQKtqfHPtuO4ASFVFTjCQ3w/YCtLZRpZUP74MFG8BDmrgruYAHiTVc+H5cLG+ZOOgYDq/6QLdVeZf/5JaYGHZ0AwAI+XOMZK5KS+EMQwKOx6xhIYSxzAmtv4geWEjboImbVRbP7CFznH7RplQkk7IBmFdVm8kcDT3CSA1Ne8GMOTWbPjUiQaZM5fGxQvHtP6naQE3memkT0/fa5J3tieznzRw71W/UJfo2CXHZNMzOFK/2GSJaSX49U44E4FbBaju3gBSkUm+55TNKMyy9qNCr4VjaSz450LlKcUuIM5qZqrN77zbs2YvfJ6C5B5BwSO2uCUMxt97SIrpRuCJo+1YIJ+pZUjnn3WGVapwZARGv6tGfNgfkZ/2KU8mEM2SN;4:tB63lT/vzkCxSpQV+Jh5jkvthbFLVkX/VwBIWUKoePNG7pfposRG3s0y6OD1WPbl0vna+TEPK37CcUxqauYclEGGf3ldeSNSfHgERprqWC8N1RQx7yFSzcyqC2u1I13w0xsjNzuqYzsiCCSgPQZGEUtjHrlIP7oPFSBUxIXz7124AC0wHQIq7SjjrBu68pQuQrcyJxAVP9dEZzBVQi3RXXty6rNrx6MxWBFy9SNPdbq9+/qyEAWgup5B/GBFkOI2QVL0X6XMZea8l1T6Zw6SmQ==
X-Microsoft-Antispam-PRVS: <CY1PR05MB193083A77605C04BC918BF7AA3BB0@CY1PR05MB1930.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:CY1PR05MB1930;BCL:0;PCL:0;RULEID:;SRVR:CY1PR05MB1930;
X-Forefront-PRVS: 06339BAE63
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39840400004)(366004)(39380400002)(396003)(346002)(376002)(199004)(189003)(51914003)(6666003)(25786009)(956004)(53936002)(229853002)(305945005)(2906002)(7736002)(9686003)(54906003)(50466002)(6496006)(4326008)(47776003)(486006)(52116002)(16586007)(386003)(5660300001)(55016002)(66066001)(58126008)(33896004)(478600001)(316002)(6116002)(33716001)(3846002)(8676002)(68736007)(81156014)(186003)(23726003)(81166006)(97736004)(16526019)(11346002)(86362001)(446003)(76176011)(6916009)(8936002)(105586002)(6246003)(1076002)(26005)(476003)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR05MB1930;H:bars;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR05MB1930;23:ajh6vq8C3+ibJdD6U0XQfyarLPlhjBfOPtvqX2IWT?=
 =?us-ascii?Q?Lu//Io92FDFdvisjP+ImwgAdFcjqQPaHQ2ovNl0c5V5CFwTLeWkCGOEdNtd2?=
 =?us-ascii?Q?FJq52V5s2o3KUYxN/bXGLqehYRAbidkYb4BZweeByqjCSw2HMV6rQq1Ad75j?=
 =?us-ascii?Q?HeN2pty9rvPDgFUrDBK9yxx3CbsyHg9fv+lGFYzoAWZVm3Ka1IKqWBM0D5ee?=
 =?us-ascii?Q?CThVplPAN69QOdhfvC01O9djN1TX1IbfHe/uhdQeyTu3GWtbbBYuheyY+Yfi?=
 =?us-ascii?Q?PERTTSjAo+CEXawpTcFlIGdvQwNs6c64jEG9xKpSsc1uudxPN9PeLVl7RWiU?=
 =?us-ascii?Q?KuGgXWcZOFvAvZPdyAoQDXpS3LBF7Vu4tq0wdCYOitUBlOA0P49zwXoZ3w2u?=
 =?us-ascii?Q?xxjMjAh63hW2qjGKcpmeq7lU3iNWMuQ9ZE5wzbuoPI/T9P7IaCtw8cKOVdrE?=
 =?us-ascii?Q?nd1Z9yQPOwMixOR+ogxOEJBW2jLVS9M//O9zlyo3hbAerDhzOTT83zLzX7rr?=
 =?us-ascii?Q?FSY7Mkdym9NsiiiYPoHymFVc9fqI7V4UhNaKK9WXGZuozndKzwKXB/1KZZBl?=
 =?us-ascii?Q?+fm2yPsbt0XBnQpzYHalSwJvN+HE469coBTpuNN7avHrgOFwAd3zcCkM4WsA?=
 =?us-ascii?Q?B+hYzsEx4Q7tMToAmwBWwe0LjJQRcA/qW+xZBFqun2qvPuvQI6g00JyWhokF?=
 =?us-ascii?Q?mzPVeVw7k2uLbYU43U0Uh9j6Y9q8g41cVsi2kkEbyuxG8pl8/vw0HM8CeMwM?=
 =?us-ascii?Q?+mxqb66gt8TmoDJrzcyqdoN6ug/PsMVD0XP0lqe3MRzJ0ApQU0LcyvZIg7nP?=
 =?us-ascii?Q?sL6YMHy98RtubbNjR6/3dfa39lSGo3xxCafxQoJcbd66bSYfA4W88A6I8nHW?=
 =?us-ascii?Q?ITvjYdUhqsMMjO5LeyjXxR/MUijCnAIrJ1JLuQ65DLcT0Jl+bNegg7v/0zvV?=
 =?us-ascii?Q?NnMTYjDjKXNfQ/rQrK4YUq92NjbJ7hupQArGT1tB5uYo0D1TCe8plSdQ125v?=
 =?us-ascii?Q?DHF1YbwiAhOKeYFJaFFcMyf7Mpcnh4bqufGOufx7VjtvzLRZgT/MWVrJr5E2?=
 =?us-ascii?Q?nycByj2mJ18Cs1jvpkeLlRAxJhKYKyCy/IIzxA/UVFHia30lsMlyDJVpjcog?=
 =?us-ascii?Q?WRFguiVYR1GsdbGW1e6Idxg1vlBOVJ4ttSxqSc7hjaiWWNqSWT/itoZqs5KI?=
 =?us-ascii?Q?X74ulQo5JV/0ZErmsXeXiDsn+LFioXwd0kT3Ushvkpve/fNlq7mWMh8SJED8?=
 =?us-ascii?Q?u/MK/3IuR5TEVC2oqHignHLNKVrwjVwOd7jxTtP?=
X-Microsoft-Antispam-Message-Info: ZQco8+wUF6y/1t2BAyuoAjMRnj4YZTi6kOFEaisprFnyx+bemeog/eea1qR0MAncZJOq672UReqnjVVPOTz9d80kOfx3HXr/+qFF29NdkD5b83BlUCrEJF40hNbYqv+UifsacenyTM+Nwk6cJQ6EYRGb6zYSx19Bn53WoPP1HpHxfLTwKGQbnEXOvh/PF8aN
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1930;6:upLlD2tNQPRVMD4I0xbtWfWcpFULKpZ9g6pBOMjbjK6prQaiaDXvxCYKm6AxUMc3CZ5gdX1u6oaJUpbhI7m10D/ROFeL7r5aC9DH5XPoqfiLTGwoiiOP2KpEZ/4HZtMZQGHl5JOkxAJQ+LMN/FSs9IXKruQDCsQeoV3FSo4dRBrI/TYCrW0OeMJU55lWJ2+oTWceQ17Y34p4got/0/HxvDsoNaY9kp/S1ZAWDILcauyqjhIKbfdeVWEc/rJpxXVS8h7ZUmeonofDDk/6UFtprALgSgUFGBtKTuYkGOSKKSPWlWrX1aE9VAJcL2emT7L/hEt/KbJwJyCDObd8tJQC8lhP0e5pFeew8hSEhECIS7ocq9dyiNLWu/LtEilEozvoIlCjQMJEnP09hzK3Y+/KTQ2t0ZHDKxvXP2WjdFjK3AjuFExqG2xQclLLoTE721ShADImkHPMYQRDkzMksOOPFQ==;5:Y6jCaGBgUGonHZa83Et213tIGFXencsNDp3wu6nFmLxbPCjx5t7q7dNGcAD6QjTw8EXTw9abB36R8YH2ayPbpsW3ujw/0xQ8yZJBEb8s+1Q3adVVtJOC44RSPg1ljWdxEN0ipO0iF4vlDILhy1ee3USFNgdhJRvwjKJ/3muqUKo=;24:/ChNJo/b+2EEGfQFSavE0kAkUEmS6gx4Q1r8FLkzw7f5bdq02VSmTBzRynHpazFxZPZNjWJszVeyRrgmGATF+dx8yACsrDMm7F0sNqxCPKc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR05MB1930;7:Psc26c0gFrxDYl9cjP/SauhURs9bzgjCss7h8PLJZiinwJH3HjHnErdVXHLBFhtxDbYFOzJH1ufzfqbWG91VOchUNh3v4coCsBAtaitG6vc4oPQtDuC/r15g96+N7YPjCSZnfSJgcTeasHk6ULGpWGV1m01CQLO/AYpctbXTsz3TlMU1ghZdNtQWulRaqBbjTiS/pXJu5p1OObUyI+Td7LL50FoAR/WW6VFiKZU8w8evjx6nadOkOHbQeSNe+oSg
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2018 16:31:13.0918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84568be7-390a-42d6-d11b-08d59b12a6a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR05MB1930
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Gustavo,

> In case memory resources for fw were succesfully allocated, release
> them before jumping to fw_load_fail.
> 
> Addresses-Coverity-ID: 1466092 ("Resource leak")
> Fixes: c3b2f7ca4186 ("qtnfmac: implement asynchronous firmware loading")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks for the patch!

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Regards,
Sergey
