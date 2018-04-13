Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3617952-1523624285-2-8358056127794819694
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, UNPARSEABLE_RELAY 0.001,
  LANGUAGES daensv, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523624285; b=Ac2WMv4yCnpDlUAov/AdzeLEaqYnCSSFTTI+YOaDwYqxq1AUB5
    DOoHx/uLKOA/uodO5ufXMMRpcq47e8RkmAA6h0qbZ32ZC5tYpOG6NTbdjc1hRoj8
    329QZXVm/xZ9aEmh5PQteJU+tIvjjjizD8qFGdL46aTbfty2w7MNJYCkVFDzIhHu
    6TmUnLhxu5fqiu2kXCLwv89DCw0pSium4NaDnBfOcKhKoY7PlziUg9b+kvujrHWx
    6P2KUuXOFpebpe0gqwLnFLkGfp3JvvahyYZ+o8Yz/1FjtElCMP2Bfzf2JBh7f/C4
    N9XBRhBwMyQI0NjPLnM2ZH6xzFnj2zHOw4Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1523624285; bh=8a90D
    4mg4v3CaU1Zbp3AcRnTl7FewEF5N9YmvC8fbJ8=; b=KDExbnY8VC+TFUU7KuBkm
    1/d1FxDsu4dPMgl+7tgXrGoBD97i7n1iUIrQztytnEDzoV9rhwcitLW4OPRHktI8
    J95YNeIciuM2iGL3/0N9gPu3e3ncCvZ9MNIJ8Qy2clxZWbkXn/K9uolK5PfoBPu0
    x+/YGPRez6qVv5LWR0eXMUTNyCaPUd+13idfIOeUoxofro/31Zu2hlm62aM9wyz2
    /dAHTp5viQsw8odESQWxU1s4ZKJGZ6EYBjlBcv8MQ7/J9968yyUAGfLGZhop0fXx
    DSdx/0uCalcUaqxMJ4A9Rn05hJzqyG6BMYCYxsIaBGr7cLk3PU3/PGlIB8nb/jdQ
    A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xge8F6ei x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=Xge8F6ei x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=oracle.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA2gF5wvAZDeQgb+8IGFZZk9AUDe0uFsXodbvo4ihWPC0AjwdWxdSMvOap0ZISNFx92GXYOCihQGHHl6TIbILJU4B7Kf9Tzr4Irle53a8XME3cuQ/WzE
    2vKMTbFeA9y9eYXSUWYuXh1P7mWQ4Yag+DLfPcqjcqTs8BA2bscQxGfTqIKi4gHfyaQ8Fdf74G/clfzurVHaeui8Mj1JM8jBX0wlK7mVeGr2HFcdC9WhW7rL
    Geikj531Jyn9pcfmDrWXOQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=DDOyTI_5AAAA:8 a=V2Vq-yRjyqUaAMdonIAA:9
    a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 13 Apr 2018 15:57:47 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Renato Soma <renatoys08@gmail.com>
Subject: Re: [PATCH] staging fbtft: Fixed lines exceeding columns limit
Message-ID: <20180413125747.ccynu6twioa22fee@mwanda>
References: <20180413001602.GA18920@rys-Inspiron-5420>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180413001602.GA18920@rys-Inspiron-5420>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8861
 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=818
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804130122
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
Cc: devel@driverdev.osuosl.org, lkcamp@lists.libreplanetbr.org,
 linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

>  	if (unlikely(par->debug & DEBUG_WRITE_REGISTER)) {                    \
>  		va_start(args, len);                                          \
>  		for (i = 0; i < len; i++) {                                   \
> -			buf[i] = modifier((data_type)va_arg(args, unsigned int)); \
> +			buf[i] = modifier((data_type)va_arg(args,             \
> +						unsigned int));               \


Normally we'd align the parameters like so:

			buf[i] = modifier((data_type)va_arg(args,		\
							    unsigned int));	\



>  		}                                                             \
>  		va_end(args);                                                 \
> -		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par, par->info->device, buffer_type, buf, len, "%s: ", __func__); \
> +		fbtft_par_dbg_hex(DEBUG_WRITE_REGISTER, par,                  \
> +				par->info->device, buffer_type,               \
> +				buf, len, "%s: ", __func__);                  \
>  	}                                                                     \

Not properly aligned.


>  									      \
>  	va_start(args, len);                                                  \
> @@ -37,7 +40,8 @@ void func(struct fbtft_par *par, int len, ...)                                \
>  	}                                                                     \
>  									      \
>  	*buf = modifier((data_type)va_arg(args, unsigned int));               \
> -	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset, 0); \

I feel like the original is basically OK but if we're going to change it
then align it like this:

	ret = fbtft_write_buf_dc(par, par->buf, sizeof(data_type) + offset,	\
				 0);						\


Etc.

regards,
dan carpenter

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
