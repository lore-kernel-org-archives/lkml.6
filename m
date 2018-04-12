Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1207910-1523545725-2-5483162985565148822
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523545724; b=PgYURZavp4v5gLXCKUZ8x5h38CQUPPFkOjYCRNwRqODX4nwFY/
    4cXIO2nZfPTAweMWI9sw7LwRoEvc3d+2eF+47UIOd1q/rCpil0xv6lihiDzyvE4T
    rix6lFsXVLseqhgOAH8u5dfjYBTr224GILXMKQDj21VEsetEfpRT8wgZH2lNpYRI
    ljKNgfo8YEjwAJAI0r9ZNxfQ2E3pAFonyNZmM5cMP95MboJPJ1lnejlccNv0++Of
    K1SpCB6C4KQvcQv5HyMXts94SN7NbKW8i60OVcg7iygfOQI2PlOuVswW9vIcJ8ax
    2wVSpZQTj19j7LVD9rgD5j6ffjjDN6c2enOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523545724; bh=pFTPv
    Xz9uQWNzUUY1flYpzpHE0NpXUH7S6st9Vd3ts0=; b=NdEtFrJ0YsauFWv5+3SSa
    A6g11MdndfoS756zt7/ekBbIUWkhsryZwOzoDtfV2VtTfrsjBjukuXXErzN1shfd
    +Vp7XNax2hLlyw6oXuo4FeYFiZFZ5La/PVWiYOJ5caXG3HyN0GuY+DFivzze5yWG
    0fwnwVMwxhwcyB/u6VoYZT8RspM5LayDqZ1nCqUXbBGIpq7wOW8d9cydzSAmL7Nt
    KvUY8bvHFpS0rgOjVAhoJ86+2Kra8Fr1SSc5LGGtKePmc7p8kKu+jw3cq6H0GtjL
    CZFzPfhvx+arNZ4FGLNfHpMM5BeOS7t5y7jOweE+5vN9pqiqV+Vvwvf18lRBFXOB
    g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RKd+X+lC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=RKd+X+lC x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfERph1RCEc92CA6JzN6i4aIuBE+OQEAa6e0ECTj8KeESzHng/KTF4WU/88wM86oY8UUz3JtA1kwRSAcsbaEKznPmCsMuYVe5OeQ4ZN3Q6JngvdV4yloB
    MHpQZaU8Kgoau7fNMzVd/i1mVyl7oBpzYL//gUybnHnAHiwcmnkAYVXuWdRFjc8aotVuu9K8nIXVhDl/JhvM/yk00wWYf4VGvuj8nFNcVIh67kC9IKQff5pa
    yPlL6zb1zNX4PuJ+vc2FMw==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=_Wotqz80AAAA:8 a=DDOyTI_5AAAA:8
    a=_ZHg1Q7ylhypiC1TWw0A:9 a=CjuIK1q_8ugA:10 a=buJP51TR1BpY-zbLSsyS:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Thu, 12 Apr 2018 18:08:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Colin King <colin.king@canonical.com>
Subject: Re: [PATCH] staging: ks7010_sdio: fix NULL pointer dereference and
 memory leak
Message-ID: <20180412150825.ckyvcmw2shvdbwvs@mwanda>
References: <20180412143009.GA31998@embeddedor.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180412143009.GA31998@embeddedor.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=972
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120150
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
Cc: devel@driverdev.osuosl.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

I added Colin to the Cc list.

On Thu, Apr 12, 2018 at 09:30:09AM -0500, Gustavo A. R. Silva wrote:
> priv is being dereferenced when it is still null, hence there is an
> explicit null pointer dereference at line 935: free_netdev(priv->net_dev)
> 
> Also, memory allocated for netdev at line 854:
> netdev = alloc_etherdev(sizeof(*priv));
> is not being free'd, hence there is a memory leak.
> 
> Fix this by null checking priv before dererefencing it and free netdev
> before return.
> 
> Addresses-Coverity-ID: 1467844 ("Explicit null dereferenced")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  drivers/staging/ks7010/ks7010_sdio.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
> index b8f55a1..f5d4c62 100644
> --- a/drivers/staging/ks7010/ks7010_sdio.c
> +++ b/drivers/staging/ks7010/ks7010_sdio.c
> @@ -932,8 +932,12 @@ static int ks7010_sdio_probe(struct sdio_func *func,
>  	return 0;
>  
>   err_free_netdev:
> -	free_netdev(priv->net_dev);
> -	card->priv = NULL;
> +	if (priv) {
> +		free_netdev(priv->net_dev);
> +		card->priv = NULL;

This isn't required because the next thing we do to card is kfree(card).

> +	} else {
> +		free_netdev(netdev);
> +	}


That's too complicated.  Just do:

err_free_netdev:
	free_netdev(net_dev);

err_release_irq:
	...

Please send a v2 patch.

regards,
dan carpenter


_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
