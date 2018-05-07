Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1024697-1525698982-2-5096321404459363908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, DATE_IN_PAST_06_12 1.543,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525698981; b=blchom/wDPosROtHWtpv2Ug6kP91F/vUid7M3g4h5xmdpFNIi4
    tePwZ14ymlPG3xZrJdp3MzptcELzi3VUQyOLgRbgg4ijdx9AXxVXFYJweK9e2/dI
    J+NPfpJdPxO5GCklTEHD+LLJUiMsGYC6DwISDHwCIbxOVNwdw9xQxCg+qszpFnl5
    +O/l2xiZkCwCBfzH3uUTiwTCi4omj6zakKefP2rYUh3duiEw70l+CXr6tQPioFPc
    UTe+tfKIwgcy+M8XBhPeeYYfsUDz/r+IcJLDhVqtpW9UFbWPYuS8+GxTnmus76dZ
    dsj+5QUPWoEoe/Utz6VxAKnI9G0Bq0gvrUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525698981; bh=jkZll
    Tk3twwc/Po7o6UheMXlAA2/rX5U8vLV4oThqZI=; b=B1GUh+Lq6EPNQBflKLh9h
    O4AwLwxfu7HB4juF5043nRGQODlVL12bgV7CbRgiPnFBOZZxq0f12yPDb6fG+7A3
    ga1YsbEQyWFh70PcdtY352+/vyBHoeU7IdocXFhxnhaJ2UTtDyEI4I0EinHEUnZ1
    ryq8povo4iij8KE1ZYR3ZPalZGL0Q5uGgMSm6shnv1WvRvvRI/CiSVnL3ro6Nh8p
    +dLEumFQw5V6OR8JzuF+7Rr3JqBoq/O1qwHgApXzQeSFo2rPzU5q7ZzpKG+IKv/J
    rb72WTef7fJyL1HuvqcNXgWe0W7H95XwbWutS7mEK9zxMEKX2D+bntKLc1Kup/0G
    w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=kernel.org header.i=@kernel.org header.b=CMERk/6g x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
    x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=linuxfoundation.org
    header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=kernel.org header.i=@kernel.org header.b=CMERk/6g x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=default;
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org
      x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=linuxfoundation.org
      header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJANKlvW1h5qXOKkp9qxFeeVZ5Q2uHj1U8yn+gS2/pv9hTjOOVeg7TYXVV9r5wYRSoZyEGDdWorByDpXBQqo5vzMb+NaWaHt9O99/QrICSqOdByGKAq/
    x1OtpVCjbgs/6V+oiUS2fixQPDbxUJIekEB0w7/w6AnEvhuRhvEjijC998m61o00E5g9vLCE1148npTV+CVSAs5ueS5T4FSuI351MAdTFqSs3k+sv4Pw1IhP
    bHosbhr2/XfaQb3zKcpDcQ==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8
    a=3HTbPFK2NhaGdlOJ26EA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Sun, 6 May 2018 18:54:19 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: Re: [PATCH] staging: most: video: use __func__ instead of function
 name
Message-ID: <20180507015419.GA31034@kroah.com>
References: <20180503102105.13225-1-abdun.nihaal@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20180503102105.13225-1-abdun.nihaal@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
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
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 03:51:05PM +0530, Abdun Nihaal wrote:
> This fixes the following checkpatch warning in video.c:
> 
> WARNING: Prefer using '\"%s...\", __func__' to using function's name
> in a string
> 
> Signed-off-by: Abdun Nihaal <abdun.nihaal@gmail.com>
> ---
>  drivers/staging/most/video/video.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/most/video/video.c b/drivers/staging/most/video/video.c
> index 9d7e747519d9..c85e289275a9 100644
> --- a/drivers/staging/most/video/video.c
> +++ b/drivers/staging/most/video/video.c
> @@ -73,7 +73,7 @@ static int comp_vdev_open(struct file *filp)
>  	struct most_video_dev *mdev = video_drvdata(filp);
>  	struct comp_fh *fh;
>  
> -	v4l2_info(&mdev->v4l2_dev, "comp_vdev_open()\n");
> +	v4l2_info(&mdev->v4l2_dev, "%s()\n", __func__);

All of these should just be deleted.  It's debugging code and if someone
needs/wants to see tracing, they can use ftrace.

Please just drop them all.

thanks,

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
