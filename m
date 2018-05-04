Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-155233-1525442054-2-9916745720076150833
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.136', Host='smtp3.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525442054; b=k3Drp/HLgllTrUwCqRskbu5pEC9tKH8L/ypBejySgB8ePn/f+o
    CpMep8yjRISfaA0+3YMUYfClh48a/0BbLEu9beomCQ5j/gw8IAhYnzv1bpPiCOPT
    6aLmW9RV5An1Yhi26+Tj/fAw2LSuDJktbz/l7LIDlHOBhmyuQBI3KdhyWk/V2BQQ
    eysRrWswbym7tBdCu6jPv1GYdv7Ib+n84rvCMpntUdAxs0o6BdZCtUWy9x4LtRJ6
    zszrwJy0EVCdTWb42JxzX3TjcckZOz9vIN9CSYD9jWGz3j5qe4lYU47EtuEaTYCX
    nvqY+jmw//eucxGP02bL5DHmdkdieqxOTMhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:date
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525442054; bh=EacL8
    TBzRvD4KQBQww679msYWXpjfaVP6kr5GJr2SvI=; b=KTHDw2/Jp5S/Ua6FLNK4j
    xgnEXgNKc7c7v0rx7WWQ3HQmPRIczb2Kv6JQGPDxO882S8t08Go8y5NFUH2g58CC
    JEwMYyJ9oas83x6SL6GjUY/shHgNOMq8WPhnryuLHA75wIkGefKewCJ4Du1cpeVS
    wwtjCYM1FAr2GKRPdFZWnfmjZvf9zl/Ujmquz7Vvom13RFnfjBk6DUq6D9eClHel
    VBX/yLOqxzRyZl/GIqOFTM4xZq28LtsX5Uf8XD6nrKTjN8AdVAF1U3mXO8EOgT2M
    udLY8vxsBjVmsNpQnGjMaoIFGtPXZSwmIxxZsp7O0dkZ/nJbDW2i/CWEn5gIXwZS
    A==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linux.intel.com
    header.result=pass header_org.domain=intel.com header_org.result=pass
    header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=140.211.166.136 (smtp3.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=silver.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=silver.osuosl.org x-ptr-lookup=smtp3.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linux.intel.com
      header.result=pass header_org.domain=intel.com header_org.result=pass
      header_is_org_domain=no;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPeg2ma+Gh376LdDedBuQfAH8blygMqk4QUB8SkqYzO1jdvLcN9CmpWg2FxTBBDCi6vXSXiSFG36ir1EielqSa8Bhhi52g4mJwciydJS6GMlNzrX/4UA
    +pmhTuq5F6Li4uanj2TFjDx5J/dh7C6v1n+QWZ3YScvAio6IYmYLartYgnC8T9ujR0k8J/D3kMng5BgnxMTXitqo2vx/ZvvJaGhLzuK9inZD71Vahrf1IpaC
    zduSP+sgbvrQmO8R9icasA==
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=FmzrR3azffoSx43hyxYGHg==:117
    a=FmzrR3azffoSx43hyxYGHg==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=QyXUC8HyAAAA:8 a=DDOyTI_5AAAA:8
    a=ZzBMc9_pC5uVsZ1HnokA:9 a=7Zwj6sZBwVKJAoWSPKxL6X1jA+E=:19
    a=-nnoQVB1o6_ym-ke:21 a=6Yd-4-I_yhwV1aY-:21 a=CjuIK1q_8ugA:10
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,362,1520924400"; d="scan'208";a="38432497"
Message-ID: <1525442037.21176.659.camel@linux.intel.com>
Subject: Re: [PATCH] media: staging: atomisp: fix a potential missing-check bug
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Wenwen Wang <wang6495@umn.edu>
Date: Fri, 04 May 2018 16:53:57 +0300
In-Reply-To: <1525418996-19246-1-git-send-email-wang6495@umn.edu>
References: <1525418996-19246-1-git-send-email-wang6495@umn.edu>
Organization: Intel Finland Oy
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
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
Cc: "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kangjie Lu <kjlu@umn.edu>,
 "open list:STAGING - ATOMISP DRIVER" <linux-media@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 Hans Verkuil <hans.verkuil@cisco.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Alan Cox <alan@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2018-05-04 at 02:29 -0500, Wenwen Wang wrote:
> At the end of atomisp_subdev_set_selection(), the function
> atomisp_subdev_get_rect() is invoked to get the pointer to v4l2_rect.
> Since
> this function may return a NULL pointer, it is firstly invoked to
> check
> the returned pointer. If the returned pointer is not NULL, then the
> function is invoked again to obtain the pointer and the memory content
> at the location of the returned pointer is copied to the memory
> location of
> r. In most cases, the pointers returned by the two invocations are
> same.
> However, given that the pointer returned by the function
> atomisp_subdev_get_rect() is not a constant, it is possible that the
> two
> invocations return two different pointers. For example, another thread
> may
> race to modify the related pointers during the two invocations. In
> that
> case, even if the first returned pointer is not null, the second
> returned
> pointer might be null, which will cause issues such as null pointer
> dereference.
> 
> This patch saves the pointer returned by the first invocation and
> removes
> the second invocation. If the returned pointer is not NULL, the memory
> content is copied according to the original code.
> 

The driver will be gone soon, don't bother with it anymore.
Thanks!

> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c | 6 ++++-
> -
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git
> a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
> b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
> index 49a9973..d5fa513 100644
> --- a/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
> +++ b/drivers/staging/media/atomisp/pci/atomisp2/atomisp_subdev.c
> @@ -366,6 +366,7 @@ int atomisp_subdev_set_selection(struct
> v4l2_subdev *sd,
>  	unsigned int i;
>  	unsigned int padding_w = pad_w;
>  	unsigned int padding_h = pad_h;
> +	struct v4l2_rect *p;
>  
>  	stream_id = atomisp_source_pad_to_stream_id(isp_sd,
> vdev_pad);
>  
> @@ -536,9 +537,10 @@ int atomisp_subdev_set_selection(struct
> v4l2_subdev *sd,
>  		ffmt[pad]->height = comp[pad]->height;
>  	}
>  
> -	if (!atomisp_subdev_get_rect(sd, cfg, which, pad, target))
> +	p = atomisp_subdev_get_rect(sd, cfg, which, pad, target);
> +	if (!p)
>  		return -EINVAL;
> -	*r = *atomisp_subdev_get_rect(sd, cfg, which, pad, target);
> +	*r = *p;
>  
>  	dev_dbg(isp->dev, "sel actual: l %d t %d w %d h %d\n",
>  		r->left, r->top, r->width, r->height);

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
