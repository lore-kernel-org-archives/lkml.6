Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1415477-1522485813-2-7667528877144035999
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES ensvda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522485812; b=T0YZ23wQ0GD/qJfq7/e9eh30JkVHyYi5KpA4XB7HD2xjiPS01D
    PSBhRYrCPmkWNgsyE0jCb3gxsgYI+jcy+W046LffpUey/BOoiruurSpX4c0Kbfn5
    zDV7W1WKo0ubrg7qRvFDEfdAi01vMFYusG1zLW1/g9ETQ5JFqIuNY8Qpjlh9mbQP
    /7+yWzIuvZguMfWILeGy6xm0nogV+KeNQuHVZ4pOSlLhEazpshtskzeeRpjz/Imi
    +tW8bPsyvdTgFkeunB2NAojeMQa3PdsQyKI/Fa7VxEbuDcVYyCqghwdAivzAeeIk
    pkERnflyl18q3A466MWaHh1xqDF5fjZLIeIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522485812; bh=0s/0a
    B+DqCyG5AJpQNE8Q/LeXb2JDLGoRKNIYn/VJTA=; b=tkuss4Ax4Ll0Y3akugBKK
    YcmDSqrKMR5DjBeaWtWhHS9wuJATqnvFMn7Atcq87Y0X4tefgwBusB9d8/suzDLU
    wa2a5dhLm3uJsEf8BrRXIzQdbpmjkQWEu+7tpr9H+kDH9i5qQqxOKEQxCE77nAJB
    24jVyiYSkIJ1p9dpIq+YsxLcyFt9wJfiVskjlEmlNqdUT3K12ySkrSifGGzipqeX
    UFzv2X/BV0cvzzfw7hsw2HZQ7xwzZNyyfJwl9UDOzNYlSqXVx8+sUZwCDK05r/k/
    DV5zR87kpT2XO37ARRjGmBqz6FQdBKVhFr+TO5lJNKfzxtN/gOqfXEGWTLJpTOBc
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=bdRXtuho x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=bdRXtuho x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDPdeFF+Q/UYJCZkv0jk04XkfjChnlr7jPAP4e+qh1DntkOfQXeojlnBgngPq34p2RQmQS4jiPHWD01xW0jJJoFhqm5MfNtoWlAIlTp95fiVnlIg3vVP
    DNlzLp17uP5zfaKqW/Ek2byHWJpZZWf10saspXv1NDT5n6TO9hUIwFVbzzM9SzPbUb48RgnZVox4gq7jUAY/rXNNZvpCkWMhgv+y7zTy8ptysf/Jgk4hgF5u
    6uxb/rWT04r9KfTNghtnAQ==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=b4qrfzo0__OwcEVnxSQA:9 a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 31 Mar 2018 11:43:13 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 69/75] staging: ks7010: Remove extra blank line
 between functions.
Message-ID: <20180331084313.fh4w46nvplbrtolf@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-69-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-69-quytelda@tamalin.org>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8848
 signatures=668697
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803310085
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

On Fri, Mar 30, 2018 at 11:08:49PM -0700, Quytelda Kahja wrote:
> Remove an extra blank line indicated by checkpatch.
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks7010_sdio.c | 3 ++-
>  drivers/staging/ks7010/ks_hostif.c   | 1 -
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks7010_sdio.c b/drivers/staging/ks7010/ks7010_sdio.c
> index d083bf8d238e..930d1f7d7dbf 100644
> --- a/drivers/staging/ks7010/ks7010_sdio.c
> +++ b/drivers/staging/ks7010/ks7010_sdio.c
> @@ -305,7 +305,8 @@ static void tx_device_task(struct ks_wlan_private *priv)
>  	if (priv->dev_state >= DEVICE_STATE_BOOT) {
>  		ret = write_to_device(priv, sp->sendp, sp->size);
>  		if (ret) {
> -			netdev_err(priv->net_dev, "write_to_device error !!(%d)\n", ret);
> +			netdev_err(priv->net_dev,
> +				   "write_to_device() error (%d)!\n", ret);

Doesn't match the patch description...

>  			queue_delayed_work(priv->wq, &priv->rw_dwork, 1);
>  			return;
>  		}

regards,
dan carpenter
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
