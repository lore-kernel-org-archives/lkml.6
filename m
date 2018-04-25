Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751425AbeDYHuN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:50:13 -0400
Received: from mail-by2nam03on0040.outbound.protection.outlook.com ([104.47.42.40]:27232
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750882AbeDYHuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:50:09 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=sergey.matyukevich.os@quantenna.com;
Date: Wed, 25 Apr 2018 10:49:54 +0300
From: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>, Kees Cook <keescook@chromium.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] qtnfmac: fix qtnf_netdev_hard_start_xmit()'s return type
Message-ID: <20180425074953.hnfwnfsjuwtbjp3o@bars>
Mail-Followup-To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
References: <20180424131810.4963-1-luc.vanoostenryck@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180424131810.4963-1-luc.vanoostenryck@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Originating-IP: [195.182.157.78]
X-ClientProxiedBy: PR2P264CA0024.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::36)
 To BY2PR05MB1927.namprd05.prod.outlook.com (2a01:111:e400:58f7::13)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BY2PR05MB1927;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR05MB1927;3:yCKAw7BWjUAmyFRD8ftBt/G2t+4/dyx9cDCoLY/QUgg4mFq3nBpwT6ljzKoeavc4uIGXNk9cdRLbv0emARTxexlD7ZqYbEN9puwJ87XQ+VxBquVbyTQUveMIe6s6IN4FPYOSeE+OLCYTLQas4FROArv2Bn4J0/NMtPvxEOJe3dD03fStfwzawke1uureOmT1jfcchkW37HrPThFM6RkFj7//qaOHDDS0OG8DjO4hZnrgFrPJWSPH8+HaTMx2D9Uv;25:y+bvEZ7t+kUT0RHtBQ7YA9m72WdbHO5/hZDMXfjfdbWlD3JCP9FVauBoEYr89Q923wjGKk8b+/h+O8r+6lwy7dexfN6fUb1EaEkoBjrZOk9CahN+rHpLpq24FrqRyWUiADBQCuQQO64sct8QI5wTnbNR1SAfXe4MIfbk7DsmJArjTi5e+wmFtocs6iAaTpwPKkNJR8ThULg5rQnbJyiJmQ71P/dZuCui193cv9GQtMpfWsubPEk135dffK8bBPQZ6LNE0z4ZuOqHXuJ22lVgBk5NIw2B0/0qQ902aVFgTeun8gbftaP901Z3e2izFfGs58s7VO8s6MQzKDLaOoq44Q==;31:DDd6sAtKvHzrj8iCYRZYlSDrEhrw1ff+4l8i7TWDR+qe2gs4vhYTMZrmBfOuHgQKWJPK5ayZDtsUfQTAJc5/BggN2MKAP8e3nsjAKDvvVWwWo5yZFGtsDEaGTrdlI2Tk2CsJXWDmJ8CXOvx+pHraB2RdWMCBF00K5qtnZ46b+yNZgwdse4l5RH1E2Pp7rzb928kmzjLpZMPy8bv9yz9XglFE/LBBJjIfZIjizZEZP5U=
X-MS-TrafficTypeDiagnostic: BY2PR05MB1927:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR05MB1927;20:Z3O4x/r6n2m292zqMs347lRnTCoINhe4tY+NFD9c8Kz/u7gEYao1zrT/ekxI9NKzVS8SueZr1BPTd2E6i/I9SmcZdAbyh0G7b6Bg4V11o4JNii58FgfAXsthO2V1mEc8/el85EKIA/c/9ymWmcWlG6s+9jfh5NMarfF1BM2kGEU38c9XpPa25aYguQbjSwZKSIq1dg1o5tBEVZ0hSk9Jkk4As6Vki14UhLCo3AcaTcjh3WqMAJ53p9sOJ0v8sq7euC/65IeZaOWrP2oHLBAdOcBtkoK3kMA45SMZDSQWBOMS+zexRXV9zs72fYKyhPgLfO9ILXfpMGi52Fo3l0x+HZajYycCsZDH+C4x35H9yOeayNDtJSb+7XtiMc/9aoq46QQms3Ao7UqXvJy2c6C7iJKqKGystXJQtijKY1VLBDQysl7f1RXbz2s//RtRP5VgSBWcmG2rKIzNiVyB92OxrhRCkrH5Y3/QSYzqDFBbutNxzm8rj63PKmMxByc6Ti5j;4:WDPdk5WLpiG3y0nMxQWLUCHz4jMeXzA3hBfxkIj9fqywpm/EO47kbl/SemdH+HysD7ek0IcaO/cOugriRHhVg8q9QdR6Djnq4zJa+iYR6R2NGJzLabhB6PU8xFFB0RtPVguOOmVeUZE7SCYBSBOoOII8+tPhgLPHTw9d3DbtoHH/IK8eAFCBObpL+mzXBXwSxWUPDH7vR5bTP/X9fjYCD3zR/6wgifpnUtCZbjYYEutQ+5t19YMcVubxLv17IyAc3Mjm31yUaJla/uqOVwjeRWUdxZeNK4vz5+AXVfoXGdU6Yw1PUgJ9ACokDgrHFVNw
X-Microsoft-Antispam-PRVS: <BY2PR05MB19275349B64B119C549625F4A38F0@BY2PR05MB1927.namprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231232)(944501410)(52105095)(6041310)(20161123560045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BY2PR05MB1927;BCL:0;PCL:0;RULEID:;SRVR:BY2PR05MB1927;
X-Forefront-PRVS: 06530126A4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(396003)(366004)(376002)(39840400004)(39380400002)(189003)(199004)(51914003)(33896004)(6246003)(76176011)(7736002)(8936002)(305945005)(105586002)(6496006)(6666003)(6916009)(5660300001)(52116002)(16526019)(186003)(26005)(59450400001)(50466002)(386003)(97736004)(66066001)(47776003)(106356001)(33716001)(446003)(478600001)(23726003)(486006)(476003)(11346002)(68736007)(25786009)(45080400002)(1076002)(58126008)(86362001)(4326008)(956004)(2906002)(6116002)(3846002)(9686003)(229853002)(55016002)(8676002)(316002)(81166006)(39060400002)(81156014)(16586007)(53936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR05MB1927;H:bars;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR05MB1927;23:ALmXzhexEK3s0AHig5TkoUdQCtgv3xCR6HCtAhVZX?=
 =?us-ascii?Q?gXDklf81R5W+aYTP8S7uvUVPjC48zs2A7RqSpUxY49lZGwtBh1fqbCHAqe5D?=
 =?us-ascii?Q?ElSWiuw55IonYORxwWfw897r8+A8RKjXEmLGERWK9mU9ZtC5qcW+AauROEFA?=
 =?us-ascii?Q?+par98yuOFRFR5Z6NobAKU4OcEMTpE3t7J4Szg/nF4eLGHWKG6tsMD6DwrtN?=
 =?us-ascii?Q?DPY+9ticN+FxtYZ1PlIw1eHoyfqRS2QbPm/3WuG3wofoK5AXyxaGHO0rlres?=
 =?us-ascii?Q?HpgSLAJuQ9bF1C2kT6saQRIT2v6p2nxMqBJimA5RYINcHdF3gKsyH55ER6B+?=
 =?us-ascii?Q?YwDDfVfHB/3Wy97cxN8bWxzPou7qe1mYD3GKSV2UCrYWuveqpuVQYrU9lqp1?=
 =?us-ascii?Q?VMh8O6XGT1YjEuIzkYBHDNmLW7vKML0B8AnphzYNXqP/5o2BFVHXOaKmWn/2?=
 =?us-ascii?Q?8eYQHME5RsSQB62JHN7dpGtvQyRkN9SXOGnY6pY/MQRkHIG8NFjr4utjfTXK?=
 =?us-ascii?Q?LHmyNmsfvIhRucEqNIJumywOTSD/8F4J34A9Ty7imQX0ck3BZCBwCY2AAa/C?=
 =?us-ascii?Q?8dfowcVRmJEJJPZbLKF342ERDNjsXLaK9gEHa5BsppehEateR0jrdvjtd8xj?=
 =?us-ascii?Q?oXRgMHLXSdgO93UEDA9EJuYb01pQAxxKsX1lZyjJkRmD/nxxUNDHlK9SeAmZ?=
 =?us-ascii?Q?UUufYqguTO9wK0GKTTFvXtc4tw9oSHrUOa7LsC5xdCxaYyIlHxbdyhWIcNgS?=
 =?us-ascii?Q?M3WFeawaCJSJmKIPRO3yciLUH6myGUWdlr6b3Sl1GYSOuJcrqWp6bLwK2ycP?=
 =?us-ascii?Q?Fn4NMV3kqH7vH55vsZ5qjP4X+cV9FAwkjZ6X+b0bEn4ZiwTKhePp6WcEtcqj?=
 =?us-ascii?Q?saMI1UvwVZEM+EuVY4dHTDFbs/0lwG0nWrMTVOMEh+RtiQydShExUUvqX2Vn?=
 =?us-ascii?Q?1mFOLSXa8OvdGyZ75nHrgEM7HcvdXBKev2zjGSccewuGZ7+Kg+6g0OuYPPTE?=
 =?us-ascii?Q?HK0k+TwzY0L0dVimT++yvhUJG70J39IhVLv/MAqMnodKMh4OAiZ9tVpeuEpd?=
 =?us-ascii?Q?S400rKDMKj69lJLsvDTAh+J1ZAeCfOfySOg0YaBgBb3aJMp5qlh0vCQJ7cB8?=
 =?us-ascii?Q?X6Diy5NCas1PjdGxiwlldEo7OUEAc0AtMDL2F0cwAix0C/MDS4/jVBDNxRwB?=
 =?us-ascii?Q?FGIROCXZee2vl2cXFIePzFrxN5wqZrofGNpL41eI05ZFd5R9YE9FdDvXwUM/?=
 =?us-ascii?Q?xTiozVAJUZ1HsFgPfj/xWzgPGzE0MWdSBHyCw8rM6U12w1DjP7y/I/YCr0MQ?=
 =?us-ascii?Q?n3t+b7qyoazd7aZnVDzFJ5hsuAYqAYXEmBQayUD9sTBFJBoZdMnBI69FcW2Q?=
 =?us-ascii?Q?3Dcvw=3D=3D?=
X-Microsoft-Antispam-Message-Info: egO4Z7MhbwjNvtVqdykca77Kkt/sroqr4UzCafZ8yO4zsRGDNvTFD+W190LYAutiU4214IbCz2hwdEaio33QpUuYtyEXnozAUhL9LndDnewv+k8kYtOr+I1umhXij2tBc7LCbFAHYZX+26Y10BUPC5E+OxUg9bfniUw9Tx0fr7V8peYklYOl6FSWMjbL+SzK
X-Microsoft-Exchange-Diagnostics: 1;BY2PR05MB1927;6:FxFgQYSlcOa4rAjpadlOr5VDn6F4Vr2vMXY2VWgmfQdpeTduZaAM+8/44g76EMKNfWHnoQy2q0iYrQoyE8I0dj8AMLZOR4peQtFoLM6h0mAe1bQ6elQmYniiifY53DZhm0Yi4XrqP/dc2UV87+mVlGaETuwjyKW7iYUi1CjyE42VaBjfmgIFqtHfgJnWk8//6xZbuLjtMKXPmC3iqhgFkeMIzyh6fBV8z0+bCtdlI3k6luBx4eiH51jt5rkV2WTHMfexIV0NPtuwRDhRln3BFsHq65kcTWNUqwnIdy97yI+xv+AzoLXPzaK5u2U0tF3p2OvPJ517g+XYvSNfR0/s7zTkrEEmGKHtYDXsz2MMPio3petG18xhUzXg0kAPynXxNuJbg/YRWw7+Z7wMkSBuAolOt8UhAI9wTlvtwAqHpXG/lIY93HYNakc0HCq7xJF9ygTnA5PW+8+CpGl1Lxjzpg==;5:SIW4Fijqpu7zJjTUy2l9uKNKoLotYpjeS0Rtvpy1iTkQNR7o+1mLoEujzjMiUvRO1IMyzmJ520CQEDeWH0yC5lQplyedsGvpzHvAPcVdIbZ0OLtmKZi2o2sT6HKLlYJ9EJfmvQtf8kIM1vlcYtPntbOHLiocwB6NHe3TzMdAGxQ=;24:2U6LglYzP4S4+Mge3KGal49ULAaysdKbZlPsGlSQtzvFk31qWIJ2CshrnHid5h9za4bm82vWjufL9Y+fYv/N825ZUE7XtJNc4nq/9vjxSFc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR05MB1927;7:5Es5tGLJI1TmN7w6JB4G5Lg0elSbIxKHKuiQWIRJrSgWYOSCEOg03DpZfB5BrxvnPLPQOEBRbC0qoE0idLDqUpRdanQS/aBUrDYxfuFRIYCkJmkcNcHjF+i9sJKlPzQ8y/T0u/uuadhS45Jtcpf6wMh6JOqnvNlPDP7DllUvvrr4kM4FcrqLlKScCcvGO4jJDiUn61tHFDiFbrrj8l5r5mxX3APcrIPka1qkO7DRz/yVs0GtNUCe+0M+kyTV1bdC
X-MS-Office365-Filtering-Correlation-Id: 80ad49e5-152b-4866-5142-08d5aa8129b1
X-OriginatorOrg: quantenna.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2018 07:50:04.4781 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ad49e5-152b-4866-5142-08d5aa8129b1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a355dbce-62b4-4789-9446-c1d5582180ff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR05MB1927
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc and all,

> The method ndo_start_xmit() is defined as returning an 'netdev_tx_t',
> which is a typedef for an enum type, but the implementation in this
> driver returns an 'int'.
> 
> Fix this by returning 'netdev_tx_t' in this driver too.
> 
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---
>  drivers/net/wireless/quantenna/qtnfmac/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/quantenna/qtnfmac/core.c b/drivers/net/wireless/quantenna/qtnfmac/core.c
> index cf26c15a8..b3bfb4faa 100644
> --- a/drivers/net/wireless/quantenna/qtnfmac/core.c
> +++ b/drivers/net/wireless/quantenna/qtnfmac/core.c
> @@ -76,7 +76,7 @@ static int qtnf_netdev_close(struct net_device *ndev)
> 
>  /* Netdev handler for data transmission.
>   */
> -static int
> +static netdev_tx_t
>  qtnf_netdev_hard_start_xmit(struct sk_buff *skb, struct net_device *ndev)
>  {
>         struct qtnf_vif *vif;

Previous ACK from Igor slipped through the cracks due to
outlook/exchange issues. So here is another one.

Reviewed-by: Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>

Thanks for the fix !

Regards,
Sergey
