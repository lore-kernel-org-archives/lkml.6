Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1495695-1522488125-5-10830692134782424731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522488125; b=C/+luBdnzO75XlUmom5rRB5R1r4ska4okv7vkohR5Rj26CAMsP
    E5mrlUyLXX8arvnRIT/uCCvGEuPPplqQ39I3KyEodJyK6o9FeIgeSdYVCLa/Cbce
    t3Ap6OfpzCQR9yQJI/EpRcQtXkSmrebcIVC5R//8tk0uWVstGZzc2wAn/1L9bIAH
    iSTBbi58sq/VGf9SKmCNr+NUik43cIOpjL6hHRSGEERfwYW+PCQwW97tH6CG2OLs
    q3vKR9B7J5Bt2sk9Hj7zQFglxOwdD6x/W/VY8JuqfUP8CtoagAHiwFzl1uB7Mnwp
    QKE//QWh5YoA1aM/alB4HNNBp9q7Cekt2W8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522488125; bh=BIw00
    EbKeoX2GSdR2izJKcBDNqcwA/RL5p9Cz8NGlkI=; b=tiQwya33U87j5m4JfXKDY
    08CZvmHigid9LITY/dIsbFJGccmplGcUqKK8TjjAK9zKmqOFLqLeQWtPQyFHiFxu
    9HZ1oLKLP1yWuhpQcxdcxveFdVrEs/0gV/ULgXZCjvo/udD174h/UhN8z24AjPPL
    nkP7DGBLETYl9PqUKf1p94Awc5qRQdnU0FbNhxEpVjH2E/si18ZMT0Vr8vSvmYtm
    9QoUUxmoqjU7IlRh3V71nOHQu1qTQOM6t/x9EoYR0w2Ptpv88DGi6MxAJcQfHmVs
    JF2RBmNuY8cx2uWif/vyz3YPgftVlLc/h654togBWXsyDUnQpdm/PJhftuhKZPVC
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JKaEED0p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=JKaEED0p x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBmpTBMBKvFdI3k6ktFSOWgk02fQ+7uXIPNhHb5OSnmjipNUnNHlRTpldLnlorWVDqQjU86p/FqUdHme4AnBikrz3tF6TfVqqqlFSfVUDfpemwlYGNcK
    8CzVDimCgF5uZWTSkHeVhZf6DsZS3iRj9uuwD5qnJqbrLoVj9R2uVWQfUHdwPR5xCBGEDqxUNQO0FDd8cE1Or0Jrw1HSKkcFqvPyjvhduXg6TTdYXnwzWX5a
    sDpLpFC5ojW6BOnyNmHewA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=w39jrxuhPLwgjoi6HQgA:9 a=asRK2qnEoISfb6__:21 a=1vXTxL2uy1HA96aY:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 31 Mar 2018 12:14:20 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 68/75] staging: ks7010: Replace manual array copy with
 ether_addr_copy().
Message-ID: <20180331091420.3gdpzy557j2g443d@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-68-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-68-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8848
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803310095
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
 driverdev-devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
 wsa@the-dreams.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I'm in a hurry because I'm leaving for a long weekend so I've reviewed
the first easy 67 patches but this one is tricky and I'm not able to
review it properly before I leave.

On Fri, Mar 30, 2018 at 11:08:48PM -0700, Quytelda Kahja wrote:
> Copying the dummy HW address into the struct net_device doesn't need
> to be done byte by byte; use ether_addr_copy() instead.

Fine.

> Additionally, dev->dev_addr is not eight bytes long.
> ether_setup() sets the dev->addr_len to ETH_ALEN (defined as 6)
> in the net core code.

So it's a buffer overflow?  The subject should have mentioned that this
is a bug fix.  But I'm not sure it is.  dev->dev_addr is MAX_ADDR_LEN (32)
bytes long I believe.  See dev_addr_init() for details.

The commit message didn't make it clear that you were getting rid of
priv->eth_addr.  It's a good change, but it confused me and I am in a
hurry.

> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_hostif.c   | 29 +++++++++++------------------
>  drivers/staging/ks7010/ks_wlan.h     |  2 --
>  drivers/staging/ks7010/ks_wlan_net.c | 13 ++-----------
>  3 files changed, 13 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index 1eff78540683..23c637ef147d 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -388,6 +388,7 @@ int hostif_data_indication_wpa(struct ks_wlan_private *priv,
>  static
>  void hostif_data_indication(struct ks_wlan_private *priv)
>  {
> +	struct net_device *dev = priv->net_dev;
>  	unsigned int rx_ind_size;	/* indicate data size */
>  	struct sk_buff *skb;
>  	unsigned short auth_type;
> @@ -411,9 +412,9 @@ void hostif_data_indication(struct ks_wlan_private *priv)
>  	eth_proto = ntohs(eth_hdr->h_proto);
>  
>  	/* source address check */
> -	if (memcmp(&priv->eth_addr[0], eth_hdr->h_source, ETH_ALEN) == 0) {
> -		netdev_err(priv->net_dev, "invalid : source is own mac address !!\n");
> -		netdev_err(priv->net_dev,
> +	if (memcmp(dev->dev_addr, eth_hdr->h_source, ETH_ALEN) == 0) {
> +		netdev_err(dev, "invalid : source is own mac address !!\n");
> +		netdev_err(dev,
>  			   "eth_hdrernet->h_dest=%02X:%02X:%02X:%02X:%02X:%02X\n",
>  			   eth_hdr->h_source[0], eth_hdr->h_source[1],
>  			   eth_hdr->h_source[2], eth_hdr->h_source[3],
> @@ -443,7 +444,7 @@ void hostif_data_indication(struct ks_wlan_private *priv)
>  			priv->nstats.rx_dropped++;
>  			return;
>  		}
> -		netdev_dbg(priv->net_dev, "SNAP, rx_ind_size = %d\n",
> +		netdev_dbg(dev, "SNAP, rx_ind_size = %d\n",
>  			   rx_ind_size);

I don't like the printk cleanups.  They belong in a separate patch and
they make it harder for reviewers in a hurry to see what the patch is
doing.

Sorry, gotta run...

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
