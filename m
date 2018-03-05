Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1288896-1520245144-2-795011238474906461
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520245144; b=k4eckswOoBQsMKvIPcKIBy7wqL4hJmaQWnCGHC5lvZqBW8s
    hiANvYBHcXQf8peDM7Ag+ArtZhDvpiC4FyX8yxFqBZhoo4LJOAqKzZNk4DRHnrci
    kiYPHw2uV5kGfvT2AzGZY5A7AZJZoaX0ye/nAmgidoglnXtEJ4EcuVCCk5+cDu/4
    pJ+iatnGCi9d+v7aBceLerkFJlktNp/27AGPXHpC7okB5+bVkB4Xvgo7GmXmMGvK
    9wFXk5b+3TAHU2KzjBJLm3VJSKnP/qJraobVXRhstitqbgHRp6c2jBeCDya8r8LT
    HfhqJfZHf+5tv1nNqMxwsxwKPK4Yg1pV+0h0zfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520245144; bh=r
    FM4gCiNp2aaqb3jnTRnRE84LIgjIrj8dwTHZJNYd5E=; b=VlIe5o4d4Z+viU1yX
    /tCfOFtU0u5T7NFvJrOhpHGXp6S6A4Z0jFN+XG/eUItXjsZ640uD2RDUc2HRMwCi
    ctHWbytQHtqPA8f8oMhnbAhbJuC3wEwuoa8KuP1cnIBRBpIumGDjuhAZcp6/bwz0
    dmr6Gs/8Ngc9Dt2zsxiF7YL+YbghIq7wHNSjt2kWqvIAAIWR4Fvgvf8kT9SBQNgH
    wHu05YyfKsQNltyGq07A7yD+Eu293Sgr0ISv2Zjdsv6dpDPPvGwEY5D7jKM777rz
    rFuNxhAZz7AVPpB4Kqu+9w0Crz0LGfDCrYxNqI8kltihwrsjfo19EGsLbErOnZE5
    QmbTw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MitF9QM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=MitF9QM2 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 5 Mar 2018 13:03:45 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Subject: Re: [PATCH] staging: irda: Replace printk() with appropriate
 net_*macro_ratelimited()
Message-ID: <20180305100345.v6ajs7vdgzmwu5x4@mwanda>
References: <20180304223205.GA31416@seema-Inspiron-15-3567>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180304223205.GA31416@seema-Inspiron-15-3567>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8822
 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803050123
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
 linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 05, 2018 at 04:02:06AM +0530, Arushi Singhal wrote:
> Replace printk having a log level with the appropriate
> net_*macro_ratelimited.
> It's better to use actual device name as a prefix in error messages.
> Indentation is also changed, to fix the  checkpatch issue if line is not
> exceding 80 characters.
> 
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  .../rtl8192u/ieee80211/ieee80211_crypt_ccmp.c      | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> index e6648f7..200fe5f 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_crypt_ccmp.c
> @@ -73,7 +73,7 @@ static void *ieee80211_ccmp_init(int key_idx)
>  
>  	priv->tfm = (void *)crypto_alloc_cipher("aes", 0, CRYPTO_ALG_ASYNC);
>  	if (IS_ERR(priv->tfm)) {
> -		printk(KERN_DEBUG "ieee80211_crypt_ccmp: could not allocate crypto API aes\n");
> +		net_dbg_ratelimited("ieee80211_crypt_ccmp: could not allocate crypto API aes\n");


This should probably just be deleted.

>  		priv->tfm = NULL;
>  		goto fail;
>  	}
> @@ -276,22 +276,22 @@ static int ieee80211_ccmp_decrypt(struct sk_buff *skb, int hdr_len, void *priv)
>  	keyidx = pos[3];
>  	if (!(keyidx & (1 << 5))) {
>  		if (net_ratelimit()) {
> -			printk(KERN_DEBUG "CCMP: received packet without ExtIV flag from %pM\n",
> -				hdr->addr2);
> +			net_dbg_ratelimited("CCMP: received packet without ExtIV flag from %pM\n",
> +					    hdr->addr2);
>  		}

The "if (net_ratelimit()) " already means the message is ratelimited so
it's net_dbg() ok?  I think so, but I've never looked at this before.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
