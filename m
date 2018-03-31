Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1461287-1522486019-2-10732492619379219888
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522486018; b=fSut3ndoZoIvORzmd6TWCugUtdIE1TNFDfNgrE8NoKkIwA7rh7
    ++7dzpKzuRJ3u3onONYqFAFBP/cW/4IM3cvVzTXzs5s6qj72O99HS5Wh72z86sMo
    Asn/0o2pT17FKjHm78xGCLOGB+Ekg1OFGtud8q/3Re7bofoe/lG098nJO98Wnp4Q
    mzMvXsCEHNJJNk1BSB4ST8oqJ2MSov8yQItX1rf5GGFpC+CTe6NnIBcqs2Njtiay
    ey/X2rXbmypRztOvLWzjDkW3t78B/9vcQ/kE60iX2qTmTSFjTyLqez8GXHMiMi9O
    HEBXBd5ehlVNN9GfIb+RNNoH0bKHFnHjnpUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1522486018; bh=SlARt
    MOYjlsebDO2Q5YvvqJYGyquiEgr7gEcXxlMDwU=; b=M3AHsRu4McyLorU/+vf4D
    r6F1qCqPre3nzF0z3Q6/2oKsKbqsQtbxHOW4scQ+K6crvUBkZr1I8TLeZVomKDyx
    iHk/SfI1v8Oc/nYTntzZKB2CUJamFci0s0AVuKpCA4HcBMZHq+kx3ES+oBatcOp9
    52Ud48s25u822NhN6SV3n0Y7vq+EhuJbjy2j4baD7IoApifj+6ZOFEjMKN2As+LV
    OJbl8arLJo5u4gb8NpijlT3W70cedO5Q+zJ/5Aqjf30YrbtI9jfoQ2ycr8wpaFk+
    dmhQyWUUTtKqm2s9Pvk9YDRdokBKMhSSzA+T3ttmUXAb+OmjKvEmwlG3sxJeDCLj
    g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BkiDWqzr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=BkiDWqzr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfM1qMD3jIFOt9SMau3obwmeKjEsDPsLKcT1fcsi1ObGnqhzeSoF6IIRS6VUDfVRD3fFhkf/1ezyqAyRUCFj+iVmDJYY9C4Jmm667A1wUhqS1TWmLVFNb
    2x78vfG1DbkaIenmac1Hi2ljmLyfytzcU2dlVZ19g7ra8xxG0XVXiGBTi8B0ATdx3MbIsUGzoI5y4CFztlhgfkPEICTm8XxoDaPaf+SgO/ZwEVaNIpej2/yd
    UdcX/oY2RiOCfaUZ2nzWOA==
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=Feg6x53VAAAA:8 a=DDOyTI_5AAAA:8
    a=-mDxRp1b3kXRARW4DNwA:9 a=XPml9cLqqjq4f1IA:21 a=NlWS0z1E67ehl68K:21
    a=CjuIK1q_8ugA:10 a=WvgAEFZ7fBLC38U1N6He:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sat, 31 Mar 2018 11:46:40 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Subject: Re: [PATCH v2 71/75] staging: ks7010: Remove dummy address set.
Message-ID: <20180331084640.ojo345c5l6ysomav@mwanda>
References: <CAFLvi23=E6QubTGX0=cHjbJGB=Vx5OJ7d16E2R4HZTscmJuuSw@mail.gmail.com>
 <20180331060855.9452-1-quytelda@tamalin.org>
 <20180331060855.9452-71-quytelda@tamalin.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180331060855.9452-71-quytelda@tamalin.org>
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

On Fri, Mar 30, 2018 at 11:08:51PM -0700, Quytelda Kahja wrote:
> Setting a dummy address during the driver probe is not necessary.
> The dev_addr field is already zeroed out from alloc_etherdev().
> 
> Signed-off-by: Quytelda Kahja <quytelda@tamalin.org>
> ---
>  drivers/staging/ks7010/ks_wlan_net.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_wlan_net.c b/drivers/staging/ks7010/ks_wlan_net.c
> index 5c5569000fce..afbc472baa05 100644
> --- a/drivers/staging/ks7010/ks_wlan_net.c
> +++ b/drivers/staging/ks7010/ks_wlan_net.c
> @@ -2852,9 +2852,6 @@ int ks_wlan_close(struct net_device *dev)
>  /* Operational parameters that usually are not changed. */
>  /* Time in jiffies before concluding the transmitter is hung. */
>  #define TX_TIMEOUT  (3 * HZ)
> -static const unsigned char dummy_addr[] = {
> -	0x00, 0x0b, 0xe3, 0x00, 0x00, 0x00

Of course, this isn't a zero address.  Do we know why they chose this
particular address?  I was expecting it to be zero from the patch
description.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
