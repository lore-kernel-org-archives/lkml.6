Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1860028-1522226031-2-1856442850975160335
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.138', Host='smtp1.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522226030; b=Ixa6gLfC71fgy8Y2bZmYNscEJPlvtxWmiMW/bqNVBZZ0Jza
    LCaHY2ez7NaZhSlEnVqIkZ8lPT8ioCSlY6+g+6TZZ7ND2dvZOxQ3NLxSnLmnMjWu
    vxgBAw+UMEAmOTJYfqRW9png03GxqedOk5INULEDeR4laE6M3LcaFZDj1B9heYfi
    8k0E9do8EmLdbu6zdQKgU05HiED8QPL7/ZapafsIOWKdTiSJ9WMkDXW9ZQ+8iZr9
    BLp7nwYJU5cTcev4NJNrYUpxRA0+cbA1kQvcW9/qNs9dWrerqDS7/LKI7zRiTvFM
    ygJWlUX8yt4TNapgQ9snMkxjs+QK3wy6FlU1L0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :references:mime-version:in-reply-to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1522226030; bh=Z
    GveS+IkUmRze3L9VWUo7cr2DRw/yCTcjjQgItVsw1Q=; b=QIhgy/AnrMankxmG8
    nbe1QTLs6V+GCw9jgb9MWv3aJ1zAIgoLThgQcMucvF2mNIIzARlmEB2Og4qa1MLi
    v81/NthcZQ8Q3SLaaaTxPh9LrgLIeqsutFqm3zW7pQcMGCbjewGAJtM8CB4xHT7n
    CHc+Lb7lxJe3yr1D3hqkjXrNwg8nZR+lqQDwvfuqOgLiPe3pN4ZZxqVKHILUBI0G
    Ow0MO51R5LfVgC2ZAbew2fwcVuLrYMeSuPf90DiqqE1xZrQUYeq5c/i+4g8i1pGU
    9bO9G0gVG4PSMaG1hLe62znk0nnieaNZGC1xTvAYntYzvO9bADQGyPuouSNbpTB9
    ODKkQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=140.211.166.138 (smtp1.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=whitealder.osuosl.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=fail x-ptr-helo=whitealder.osuosl.org x-ptr-lookup=smtp1.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDtBLndZKqBQ32DohcuSnbR8WG1aZtsrFkWLCY51LvEkQMpMDfUijID/sWvm5DYk/Ps3TSoqzz987At+o9cqw0gm2oU8/+IpAxOvaZk+AUCDaybrjLcv
    eAB8NMbNARx+mM+WX7pzvKtaicY3pP9jzz8j0+bk9kjTsLIya2UMWjCni4rBGbCWOzpx+uHERPBoYHxP8SoAveOaiOFAY/tk7RLWc5TQTpJK7ne0bLNvORnJ
    ZyPMejAyi5GGTP9dmRbzMg==
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=28bQ1EhdAjTzU1YDPmtEKw==:117
    a=28bQ1EhdAjTzU1YDPmtEKw==:17 a=kj9zAlcOel0A:10 a=v2DPQv5-lfwA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=hD80L64hAAAA:8 a=DDOyTI_5AAAA:8
    a=xA_xwKcgJ3Q-Vax8fXgA:9 a=CjuIK1q_8ugA:10 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Wed, 28 Mar 2018 10:33:37 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ji-Hun Kim <ji_hun.kim@samsung.com>
Subject: Re: [PATCH] staging: vt6655: check for memory allocation failures
Message-ID: <20180328083337.GA15316@kroah.com>
References: <CGME20180328063144epcas1p305216b582520b884b09c93a7ad591660@epcas1p3.samsung.com>
 <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1522218691-7917-1-git-send-email-ji_hun.kim@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
Cc: devel@driverdev.osuosl.org, y.k.oh@samsung.com,
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 julia.lawall@lip6.fr, baijiaju1990@gmail.com, forest@alittletooquiet.net,
 santhameena13@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 03:31:31PM +0900, Ji-Hun Kim wrote:
> There are no null pointer checking on rd_info and td_info values which
> are allocated by kzalloc. It has potential null pointer dereferencing
> issues. Add return when allocation is failed.
> 
> Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> ---
>  drivers/staging/vt6655/device_main.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> index fbc4bc6..5d0ba94 100644
> --- a/drivers/staging/vt6655/device_main.c
> +++ b/drivers/staging/vt6655/device_main.c
> @@ -539,7 +539,8 @@ static void device_init_rd0_ring(struct vnt_private *priv)
>  	     i ++, curr += sizeof(struct vnt_rx_desc)) {
>  		desc = &priv->aRD0Ring[i];
>  		desc->rd_info = kzalloc(sizeof(*desc->rd_info), GFP_KERNEL);
> -
> +		if (WARN_ON(!desc->rd_info))
> +			return;

Eeek, no, this crashes any machine that runs with "panic on warn".  You
don't crash if you can not allocate any memory, you recover and move on.
You don't even need to print anything out, as the call itself will do
that if this happens.

So this patch isn't ok at all, sorry.

greg k-h
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
