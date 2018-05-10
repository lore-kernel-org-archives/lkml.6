Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2764381-1525986136-2-6655960041452425379
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525986136; b=AtITBAeEptx+0TDbTiVjasEkK++0l0CN5FY+zNnkxcq8TRVnKs
    YUpXxwbnDEPjMkQ4NN1G0ln33qdwrniCSQQMIpPIw5wRYX9X9qU9B7stZcyuYLfR
    Sv63B6kNFzlNtlxeZbibZq4qwsnBULjh05cunAZSDS0iQdQjkGM0KTripP/+koXP
    tzQcXlKDz/tfTgAtTxcdVBIN720GXfWTcrSBsIRwFRcXyuHckCaEVIbn77H74syb
    RI2vRbQhy49XJQu8aJ8PFq4cWkW8+RL0PCMMjeIwgWiokOZNt7yVNATNMq3yi+4r
    yYqSDKRxz+ItM3StdEqXmhryf3TIi8T/lElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525986136; bh=hGoUNHuk6DM0cGBDFLOcMlqJJ7406VydQscAs+ATJf
    M=; b=H8o2SuwxPedeYqf7cbJWE0DwFdKArcdM71nPJEXPsVovjdzgx2InbEZUoY
    lhX6BrSwj1OYUtMiJJrHmwYb2URW0p4s1kPqUgsI2EqZ36BhgK8wtQOy/+lm/2Xb
    uPGMADFC7aoQRrQaFnuRFYx2kUpJ6EXxhxwZllkpA01vQGAtmbNdxHQ9jpLX+8j5
    024q8TFddpo1KXpNV9y35AU7tGCdRwdjrm0sjbvw4sAlpau6mJOyx1SgqhMQoQ6o
    xLtUkQEQRmBhZtaDp+GQa6FGd6p3iiJDHxmYUMxPP9S37WdSs7/B4qYDvkNFkj5p
    y/dBTImi8KuzNPu1kdYxmNThaq3w==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=FFxqCX3I x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=ZQiE1j4a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=FFxqCX3I x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=ZQiE1j4a;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKEBxRpu5DS3mwao530UUndijzmhlZjmNf/O1u2Nuf6xwPtuSobWt8ZVlwy5OCPjIGwEbou+efDrDFLwhUZhM0Odp1SqtkY7QSOn7t0PVg3laoWwZqGb
    vmgOJ8iTuQpg26fpw8FA/pc2NnkWfIP/uLb3JsZAXodfzxtluX18tbAUlTSzNnkW4PcsyrMOFaPE83chpd+ewg7agGgV7NsB+t4r//sAvlPJ20L+LVpjHjiU
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=zbMW5qBvr9BqmuwbA_sA:9
    a=HlJTMyUigkoBo8qe:21 a=TCLXwdDA18oym08l:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=xmb-EsYY8bH0VWELuYED:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752405AbeEJVCD (ORCPT <rfc822;greg@kroah.com>);
        Thu, 10 May 2018 17:02:03 -0400
Received: from mail-vk0-f49.google.com ([209.85.213.49]:40518 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752247AbeEJVCC (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Thu, 10 May 2018 17:02:02 -0400
X-Google-Smtp-Source: AB8JxZoR5x/mQQyC+26abSd9mN0oodUi4g+hImElOXTZjaeHlElNa2iynJwkgQz65HtAlorYCyPXZWdhwVigyAV8eOs=
MIME-Version: 1.0
In-Reply-To: <1525860661-18619-2-git-send-email-william.wu@rock-chips.com>
References: <1525860661-18619-1-git-send-email-william.wu@rock-chips.com> <1525860661-18619-2-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Thu, 10 May 2018 14:01:59 -0700
Message-ID: <CAD=FV=VGhnQ2NQqn+HYNadxor8a4gNwj8hmSvGXxxstKiUJmdA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] usb: dwc2: alloc dma aligned buffer for isoc split in
To: William Wu <william.wu@rock-chips.com>
Cc: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        LKML <linux-kernel@vger.kernel.org>, linux-usb@vger.kernel.org,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Frank Wang <frank.wang@rock-chips.com>,
        =?UTF-8?B?6buE5rab?= <huangtao@rock-chips.com>,
        "daniel.meng" <daniel.meng@rock-chips.com>,
        John Youn <John.Youn@synopsys.com>,
        =?UTF-8?B?546L5b6B5aKe?= <wzz@rock-chips.com>,
        zsq@rock-chips.com,
        =?UTF-8?B?6Kix5ZiJ6YqY?= <Allen.Hsu@quantatw.com>,
        Stan Tsui <StanTsui@aopen.com>,
        =?UTF-8?B?U3BydWNlIFd1ICjlkLPlu7rli7Mp?= <Spruce.Wu@quantatw.com>,
        Martin Tsai <Martin.Tsai@quantatw.com>,
        Kevin Hsueh <Kevin.Shai@quantatw.com>,
        =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?=
        <Mon-Jer.Wu@quantatw.com>,
        =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?=
        <Claud.Chang@quantatw.com>,
        =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?= <San.Lin@quantatw.com>,
        Ren Kuo <Ren.Kuo@quantatw.com>,
        "David H.T. Wang" <davidhtwang@aopen.com>,
        Fong Lin <fonglin@aopen.com>,
        Steven Cheng <stevencheng@aopen.com>,
        Tom Chen <tomchen@aopen.com>, Don Chang <donchang@aopen.com>,
        milesschofield@aopen.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, May 9, 2018 at 3:11 AM, William Wu <william.wu@rock-chips.com> wrote:
> The commit 3bc04e28a030 ("usb: dwc2: host: Get aligned DMA in
> a more supported way") rips out a lot of code to simply the
> allocation of aligned DMA. However, it also introduces a new
> issue when use isoc split in transfer.
>
> In my test case, I connect the dwc2 controller with an usb hs
> Hub (GL852G-12), and plug an usb fs audio device (Plantronics
> headset) into the downstream port of Hub. Then use the usb mic
> to record, we can find noise when playback.
>
> It's because that the usb Hub uses an MDATA for the first
> transaction and a DATA0 for the second transaction for the isoc
> split in transaction. An typical isoc split in transaction sequence
> like this:
>
> - SSPLIT IN transaction
> - CSPLIT IN transaction
>   - MDATA packet
> - CSPLIT IN transaction
>   - DATA0 packet
>
> The DMA address of MDATA (urb->dma) is always DWORD-aligned, but
> the DMA address of DATA0 (urb->dma + qtd->isoc_split_offset) may
> not be DWORD-aligned, it depends on the qtd->isoc_split_offset (the
> length of MDATA). In my test case, the length of MDATA is usually
> unaligned, this cause DATA0 packet transmission error.
>
> This patch use kmem_cache to allocate aligned DMA buf for isoc
> split in transaction. Note that according to usb 2.0 spec, the
> maximum data payload size is 1023 bytes for each fs isoc ep,
> and the maximum allowable interrupt data payload size is 64 bytes
> or less for fs interrupt ep. So we set the size of object to be
> 1024 bytes in the kmem cache.
>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
> Changes in v4:
> - get rid of "qh->dw_align_buf_size"
> - allocate unaligned_cache for Address DMA mode and Desc DMA mode
> - freeing order opposite of allocation

You only did half of this.  You changed the order under "error4" but
forgot to make dwc2_hcd_remove() match.


> - do dma_map_single() with the size of DWC2_KMEM_UNALIGNED_BUF_SIZE
>
> Changes in v3:
> - Modify the commit message
> - Use Kmem_cache to allocate aligned DMA buf
> - Fix coding style
>
> Changes in v2:
> - None
>
>  drivers/usb/dwc2/core.h      |  3 ++
>  drivers/usb/dwc2/hcd.c       | 87 ++++++++++++++++++++++++++++++++++++++++++--
>  drivers/usb/dwc2/hcd.h       |  8 ++++
>  drivers/usb/dwc2/hcd_intr.c  |  8 ++++
>  drivers/usb/dwc2/hcd_queue.c |  3 ++
>  5 files changed, 105 insertions(+), 4 deletions(-)

My only remaining comment is a really nitty detail.  Unless someone
else feels strongly about it, I'm not sure it's worth spinning the
patch just for that nit unless someone else has review comments.

I believe I've looked at this enough to say:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
