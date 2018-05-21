Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1449503-1526946130-2-17130494012874111030
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526946129; b=hY2hbeEsCbmT6rTusIGK+3Zqzot6YOi8JrVAw3BbHUxrzdWabe
    EvEMHVSBwBrTDCunRrOYY/6v7CY1/MntrWpKqYy2p66sg9CiDoEmsIeYFAfKAWKF
    Dp04DoO3zl6aCmpj6pq1WCi9Q09/ncxuuIexP6UsAIAtngZ1WiykK1y9QQ1YVJ5E
    s00lstcb0/ONHBBvQWYTwnD1aLsq1n0gpSJmGgk2fOpVUmZ19f/ygfv0lPUR73QT
    IzMFZaK7sp0pgqLEQwTPku61NwEfpFrGtf1FU3DNTcl9DOfsLM/UstUtViYQSr4Y
    bGt+VrKO6COCAoy4X+POHRQ5T6EtL3yK5zwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526946129; bh=litGZRhl6jc7qObR6wGkJNcT2DrgoLy922VfLNpaGi
    E=; b=He4/xq3ATGk+xnFhBTFlCmeTVq+HouZ7vfpxnqGqG2XUDDD/Ry7BT9QhYM
    HcLdEhWqef5S7vQ94bw69cCL5Z4E5Ivbj14z+usK1qEwbZnvTubQ8O92bNAvZ/+X
    5c1027cgPq+3SKRvpvsRo5vV5ePE1s36Gc+y19tOfHVLv6JRZl8BAyHCcNrP/6O4
    3TXG1efOFVcEswhhIlZSmkjFVImqU+sz4/PqgY9iPfJ+5lkW0gDeC5UW/E4mqeMZ
    iSlz0N53FPwZ/BWyg/Dadk9+cs2kbqgM7wtDRcw7lCgX0AAx9JJyYO9gVydmsS+u
    UEAr6X73HWChvsmnF/RHB/LFm0+A==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
    header.i=@google.com header.b=WjEtW6Mc x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
    header.i=@1e100.net header.b=IlH3jf0F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=google.com
      header.i=@google.com header.b=WjEtW6Mc x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net
      header.i=@1e100.net header.b=IlH3jf0F;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBsgrLCrE3cunEdGTTMLLIFoKlSxPtMciRYBHHqiOD0Q9MHIS2QewOxsWTwZHW7UprO40d/mGYQPc3jMjGsqqRvjAmLzKJlJE4UHIxW/1CFeSJOMYj4u
    VvuFV6NEWfaSPO7I3FTzG2ryd6VujS3xC6lLuvxfSiT0KImiTWu3cdmW1HeM+0YuzZzfTICxiWM76tmgIAI+SVZpTDEeidb1mmxDrkXiWzg8TeM+6B/5s6rw
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=cm27Pg_UAAAA:8 a=s3x2EaPEEGaZD5TK6d4A:9
    a=QEXdDO2ut3YA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
    a=xmb-EsYY8bH0VWELuYED:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeEUXl4 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 21 May 2018 19:41:56 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:33383 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751872AbeEUXly (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 May 2018 19:41:54 -0400
X-Google-Smtp-Source: AB8JxZpzw2FKKGOBWAzXW4zuzldQM3BovCischH3NiA97QoAcTVD3jgK0Avzon6Q7kQt7PyKU2SMuW4/Jy2cMRWu5KU=
MIME-Version: 1.0
In-Reply-To: <1526897520-9340-1-git-send-email-william.wu@rock-chips.com>
References: <1526897520-9340-1-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 21 May 2018 16:41:52 -0700
Message-ID: <CAD=FV=VPSOpnjt_OgA2JgjgB6mk+aK0a-ibjkyuEpcwt4RtUQA@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc2: fix the incorrect bitmaps for the ports of
 multi_tt hub
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
        John Youn <John.Youn@synopsys.com>, fml@rock-chips.com,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, May 21, 2018 at 3:12 AM, William Wu <william.wu@rock-chips.com> wrote:
> The dwc2_get_ls_map() use ttport to reference into the
> bitmap if we're on a multi_tt hub. But the bitmaps index
> from 0 to (hub->maxchild - 1), while the ttport index from
> 1 to hub->maxchild. This will cause invalid memory access
> when the number of ttport is hub->maxchild.
>
> Without this patch, I can easily meet a Kernel panic issue
> if connect a low-speed USB mouse with the max port of FE2.1
> multi-tt hub (1a40:0201) on rk3288 platform.
>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
>  drivers/usb/dwc2/hcd_queue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc2/hcd_queue.c b/drivers/usb/dwc2/hcd_queue.c
> index d7c3d6c..9c55d1a 100644
> --- a/drivers/usb/dwc2/hcd_queue.c
> +++ b/drivers/usb/dwc2/hcd_queue.c
> @@ -383,7 +383,7 @@ static unsigned long *dwc2_get_ls_map(struct dwc2_hsotg *hsotg,
>         /* Get the map and adjust if this is a multi_tt hub */
>         map = qh->dwc_tt->periodic_bitmaps;
>         if (qh->dwc_tt->usb_tt->multi)
> -               map += DWC2_ELEMENTS_PER_LS_BITMAP * qh->ttport;
> +               map += DWC2_ELEMENTS_PER_LS_BITMAP * (qh->ttport - 1);

Oops, thanks for the fix.

Fixes: 9f9f09b048f5 ("usb: dwc2: host: Totally redo the microframe scheduler")
Cc: stable@vger.kernel.org
Reviewed-by: Douglas Anderson <dianders@chromium.org>

-Doug
