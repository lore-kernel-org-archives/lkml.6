Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-765481-1526303881-2-17467446206928977931
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526303880; b=L5wCjUj/1THkzrzgBmUf0YMlVdlOaR/rIcHFkaMmdy2EpkwDGu
    w0sjJOCvl64ZQXp75QuAEQ8if31no0wGS8mAc+2yJEz6J4boZepjgtbf9Y2DX5KR
    lbx1ypZh95MVQUZ7AWxXfS46lXSeodXodya+bv25mbKPVTy/ysWHyq8rDYEzPI9z
    uvvivbDm4zHK85OLnrLq6mQXLRhYnImx1yEqsuVSJF2MqdnwR9kL+2JQtlEAETGE
    9uQ24iHFBnhXsAHXnuN2/INnelp5+9CMVYyqx2jZjpPlJp+lqBuit1ThxMTiKBw/
    Cw9P2kbTpWpyKnfHEFW9KkhbsdWFZKpEUdqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1526303880; bh=WepeJ
    Njl1Ruhz+Rp0wWlkSYbL5UKuK5pPdhnYYcfABQ=; b=AwTXr4JZ13hiKpNIgmtc2
    u4WqudDfyZjZirn2Z4AFXRqS9tdR+UsfKqzZ3V8M8e2qLV/dZ8YDCvb4YF2cEaMr
    ggvXTx2vw6VUtm9lMKhuT+dDchGuxIkodycMdAQDHPhQPmA80QtXDFXjEL6c6Z3x
    +SHCxWaqBoOJPhkh826FPNGkn918I1JWOc5bxq3xrMgLs5VAillUkdikZFCx57pp
    4L4rTYbSM2+DWX1eCo8MqF2gTz88OecrKAZfez0bowzisWvSPdC7cvqqrGReTvGT
    yK5NIgHrKeDkN46gGN+tMptlb1T6o2sT9L6eXr17spSfbfTf9proWfvCBSOeNm8W
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=oracle.com header.i=@oracle.com header.b=Lx6CN5fD x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=oracle.com header.i=@oracle.com header.b=Lx6CN5fD x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=oracle.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfAzpG+lszDvWPGTkEfhIuPkhCFakKYafsMNBYVWuzFGT2ZKjjJ+iqmZQx1wHcVGGxMCak7Wz8iLgF9ihSqQHwt84W3q+HOV1U/ebWMzUS6VfHI84Raw+
    6QlmZQs/7xQGaVrYGIWa24z74yfbkuapk1eIsKmuilSBveNKXkLBkRLCb7TLICuKPDuFdw5GScVY0UmMHmJVohxxry9DT2MMJOFN+OO3bWg2sX1Cd770pATX
    fnRWpxc0VbmuAqrdYBX5sA==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=OePkKp9dzuQtGfxt2R4A:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Mon, 14 May 2018 16:17:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 3/7] staging: ks7010: Remove unnecessary limit checks
Message-ID: <20180514131736.ysftvs3nk552kjnx@mwanda>
References: <20180506220304.13040-1-natechancellor@gmail.com>
 <20180506220304.13040-3-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180506220304.13040-3-natechancellor@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8892
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805140137
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

On Sun, May 06, 2018 at 03:03:00PM -0700, Nathan Chancellor wrote:
> uwrq is an unsigned 32-bit integer, it cannot be less than zero.
> 
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/staging/ks7010/ks_wlan_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> index e96477937f65..0c83d6fe270f 100644
> --- a/drivers/staging/ks7010/ks_wlan_net.c
> +++ b/drivers/staging/ks7010/ks_wlan_net.c
> @@ -1928,7 +1928,7 @@ static int ks_wlan_set_beacon_lost(struct net_device *dev,
>  	if (priv->sleep_mode == SLP_SLEEP)
>  		return -EPERM;
>  	/* for SLEEP MODE */
> -	if (*uwrq < BEACON_LOST_COUNT_MIN || *uwrq > BEACON_LOST_COUNT_MAX)
> +	if (*uwrq > BEACON_LOST_COUNT_MAX)

I believe Smatch is supposed to ignore this sort of code because
comparing "if (foo < 0 || foo > max) " is pretty readable and idiomatic.

Presumably this was so we could redefine BEACON_LOST_COUNT_MIN, but it's
fine to unused code.  The define isn't needed at all, so you can
delete that as well.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
