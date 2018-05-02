Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-88466-1525237353-2-1539116116443588563
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
    1525237352; b=Tf814qBuMwaPlZixHhW/OMmgl8x1EF15gcrpX1kkBu8OAK4i3X
    AXIU5YgfbuRZYttdxR0vew8wLgAuXxZohQPBGn7Wtqg/b5baaU3/BAyyY1lGZkvw
    SeAfVpWz9SYt4gnfsMXE8njjA8zux/DdBrrMOj8EEnqGBqUWFxQu9QxcG5ppvbIS
    RgtcWboNYa3eWK4O/u4mUISgtk08XI7RP8VI0CtRcu8Guc+UVVd1jYdiQtmdv26a
    51B22juH1XO1MgCn0daklS+B3mdVh+2sSxEfS51JSUpaQH+43d7c9zZUFqvC6eng
    6UJyWpvhx6i5qNMPZxMF+sd8qgqgWN7TEPww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525237352; bh=vsHPvOGR85Umnfy+m7VOIftAQzJ/LGhiM0Mz5u1fpq
    s=; b=Ic+2eeqJZlF7RbSAuM/OC8kIY/2XnBalGurEhvxF+BynFFtFvJ5ql9VX4U
    sufCL8bgdcfNpC6aFiesYHXIB57X3bvE0aKYL5hyevvyTLf1rYX3XM7vUGY1MJWN
    0Z8HJ11INEDQ2OdfVA73BEH+k9dCufhGwm0oQ5BF/pbyX/ky2RZ8y8nf/8BpL8TO
    DjdN4PQ425mDHfDPrRZO2CLUOI4SRkht61wIWiTJtoRmCt/KAjvih+lzzhKL1zBo
    FO3enBBx1NgL3zLZTF8QdJ3ypX60yqyoLwJjDedh1BSlOUdpk+cED1oEmdoeVmyZ
    M6yf0DuE3xhcobA024Wb/knfXsBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=fa4f+AGf x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=qqlDvVJJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=fa4f+AGf x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=qqlDvVJJ;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBP7RF/reV8+IZU514WzRIcnnrr3rmksGm5AfqIvQxRpJf9d4WT8H6eFpCbyyBe/9pMyvfHe06Xh/O+kdGP+Adw7EXgZbhZz12sKPTavF58ymxOH+dcY
    uT8kzMFqN6KuYh54b7u/pz2W0mQNQUaReL5YZlqOdvOHR8GrPBY5AEHLI9HE+A/MIK+fVabNKsS5Ne9yqKyVHjgzha1LcwSIyot2tsq2CBzpOK3O2vdpBwe6
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=FP_9NBnrMbvBnsgywH8A:9
    a=XbeK7yme7QgPUQ93:21 a=4eo_Wwn7umYlZ22_:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751095AbeEBFCS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 2 May 2018 01:02:18 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:43130 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751079AbeEBFCR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 2 May 2018 01:02:17 -0400
X-Google-Smtp-Source: AB8JxZrUKKJlhc3Z6nndosXGYbIQvFCWLOMc1PzblADzIqRyKktKPR5ETPJMYPceyQQMcfo8BYPfqPbg5wslT9hzYY8=
MIME-Version: 1.0
In-Reply-To: <1525230288-6014-3-git-send-email-william.wu@rock-chips.com>
References: <1525230288-6014-1-git-send-email-william.wu@rock-chips.com> <1525230288-6014-3-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Tue, 1 May 2018 22:02:14 -0700
Message-ID: <CAD=FV=XWzKZOF8+=z07UC3FBGRFifBvk9Oda7HRipqGy9Rxcnw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc2: fix isoc split in transfer with no data
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
        zsq@rock-chips.com, Allen.Hsu@quantatw.com, StanTsui@aopen.com,
        Vincent Palatin <vpalatin@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Tue, May 1, 2018 at 8:04 PM, William Wu <william.wu@rock-chips.com> wrote:
> If isoc split in transfer with no data (the length of DATA0
> packet is zero), we can't simply return immediately. Because
> the DATA0 can be the first transaction or the second transaction
> for the isoc split in transaction. If the DATA0 packet with no
> data is in the first transaction, we can return immediately.
> But if the DATA0 packet with no data is in the second transaction
> of isoc split in transaction sequence, we need to increase the
> qtd->isoc_frame_index and giveback urb to device driver if needed,
> otherwise, the MDATA packet will be lost.
>
> A typical test case is that connect the dwc2 controller with an
> usb hs Hub (GL852G-12), and plug an usb fs audio device (Plantronics
> headset) into the downstream port of Hub. Then use the usb mic
> to record, we can find noise when playback.
>
> In the case, the isoc split in transaction sequence like this:
>
> - SSPLIT IN transaction
> - CSPLIT IN transaction
>   - MDATA packet (176 bytes)
> - CSPLIT IN transaction
>   - DATA0 packet (0 byte)
>
> This patch use both the length of DATA0 and qtd->isoc_split_offset
> to check if the DATA0 is in the second transaction.
>
> Signed-off-by: William Wu <william.wu@rock-chips.com>
> ---
> Changes in v2:
> - Modify the commit message
>
>  drivers/usb/dwc2/hcd_intr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
> index 5e2378f..479f628 100644
> --- a/drivers/usb/dwc2/hcd_intr.c
> +++ b/drivers/usb/dwc2/hcd_intr.c
> @@ -930,7 +930,7 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
>         frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
>         len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
>                                           DWC2_HC_XFER_COMPLETE, NULL);
> -       if (!len) {
> +       if (!len && !qtd->isoc_split_offset) {
>                 qtd->complete_split = 0;
>                 qtd->isoc_split_offset = 0;
>                 return 0;

I don't think my USB-fu is strong enough to do a real review of this
patch, but one small nitpick is that you can remove
"qtd->isoc_split_offset = 0" in the if test now.  AKA:

if (!len && !qtd->isoc_split_offset) {
  qtd->complete_split = 0;
  return 0;
}

...since you only enter the "if" test now when isoc_split_offset is
already 0...  Hopefully John Youn will have some time to comment on
this patch with more real USB knowledge...


-Doug
