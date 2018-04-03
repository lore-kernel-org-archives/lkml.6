Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AIpwx48ztz1qKfyBmMJfN5q60fuPQHnUYPRop/7RAAv1Ghc8JqeRoAkEaw5VM4D4onoHemNQYD7/
ARC-Seal: i=1; a=rsa-sha256; t=1522740893; cv=none;
        d=google.com; s=arc-20160816;
        b=yJZTSDqvJ7FLIxqFpinornT0FMvGrFELOAQcSyZlwmSevgFhCl5tYspq5r0+XciV9d
         wZnVMgBraIJpbNaYLRDEb9IB5zzQvy4pgr8rP1xbnTrqjBaDGqlwVZMjuov76MDab10d
         68/IAZdeMpB6NToLs2KJBwZqWlPcTIswk+HJpuZgskSSThWnm7tFa5biVPVhr3xgk/cJ
         25oRh5H29P141fk4cyQJ3x303zHqLaER5ZdRH3HM13ZdxZmdFOkEsWgN+01aJXztdCzg
         hXjbkd6P0cIv5nHCphgsHo6FPx/ecNcWMUCHMTzDPZTQWsbkH20u4/MeDzpSdm6DGdgc
         QJMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=N+xJwh3oK1GclVZedrhdJQTQZdRAUCHgdsRKWxsCBd0=;
        b=IwJlAAIA2DuQ13qGsyvSTv4WzUhIvlzqQDQeiyUZHgEwU5zmjeE1qKusYG9QrDZ2ia
         Mc8Gl19E49NsH6G8m9I0GfWMw50BzuheDj0FIioBNpHfM88C/qHaYq8AObaiZ5xJRB6/
         iSFWy7z8VRKOpSgcBuXO2R6nosqJA2WV1CQzsyw6QoLNAsRvjTI/7Tq50TbGLMVzSyPn
         IjG7l9zlZN5/MzEBI7mtJ8MplgtVihMHbe/O/k62VdaLTe5w+dechspwC0sj3pU0C9nT
         B27Ix6opX9FapFyN8pBzDPS2VJJuSqlGvBF6TmNUjqooaPKier6OMVPzLQilMCYUCYTn
         s6Kw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=I3j87HFH;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=I3j87HFH;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Tue, 3 Apr 2018 10:14:31 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: gregkh@linuxfoundation.org, wsa@the-dreams.de, devel@driverdev.osuosl.org,
        driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 74/75] staging: ks7010: Replace memcmp() with
 ether_addr_equal().
Message-ID: <20180403071431.3r5kdqjnhjrdn6px@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-74-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-74-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8851 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=758
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804030077
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596432453208862645?=
X-GMAIL-MSGID: =?utf-8?q?1596709554842722072?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:08:54PM -0700, Quytelda Kahja wrote:
> ether_addr_equal() is the function for comparing HW addresses,
> so remove the manual memcmp operation and replace it with
> ether_addr_equals().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index d816a06939aa..b5a2ba702dec 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -411,7 +411,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
>  	eth_proto = ntohs(eth_hdr->h_proto);
>  
>  	/* source address check */
> -	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
> +	if (ether_addr_equal(dev->dev_addr, eth_hdr->h_source)) {
>  		netdev_err(dev, "invalid : source is own mac address !!\n");
>  		netdev_err(dev,
>  			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
> @@ -1103,7 +1103,7 @@ int hostif_data_request(struct ks_wlan_private *priv, struct sk_buff *skb)
>  
>  	/* skb check */
>  	eth = (struct ethhdr *)skb->data;
> -	if (memcmp(priv->net_dev->dev_addr, eth->h_source, ETH_ALEN) != 0) {
> +	if (ether_addr_equal(priv->net_dev->dev_addr, eth->h_source)) {

This test is reversed.

regards,
dan carpenter
