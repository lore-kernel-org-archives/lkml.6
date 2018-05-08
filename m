Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2166636-1525756435-2-7167041933189727743
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525756434; b=UE+/pn0D7jo/eJnh3BiR22oKLSP9RhL/Gi9msxZibw+7ChsObw
    4EaoaKPYBAgKyMzl9ZKczbPgxio8GPLPpa4oMmknk1OTzU6Z1YIyKR9s2I15G5bs
    Wf+vQHaCBH5dFFakkdS9hbr7a2ihkg1YF/yIPNpCweL6wMqeFAwrnb4I9GxqZIF9
    Zj7vo/NaA6hMp8F/AGJu7/nT+hXMkL/wRJ2GlvPJ1o9I7Lc7DgA2Nfb2rpXHvXKd
    I14Otlvc9Rik/FHzZ9KW3VsnBGrl8cfhsUuulg5+aybkFT09cfTDB0ECG8riXVfA
    ps03zHZpJKM3TzfElGSfIXrLZN6/JDtI2DDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1525756434; bh=ncdB/vDHHodsqZwWFuuyHkEuOCvJt+dS7nDXOWg5gz
    E=; b=FBw0Nq/+a1SolY71xVvA94i2InByW6PY7WvTbDg77P7aRcrkf4EhlhiyRV
    qb7ZbAyS1loJOpQ2e93SiAL5HMeCbSWQ1BFSB92RXMHlb3iOIy9aPq2HKev77qeT
    s0R/CTs4NkC9XWN4Gsap/WSMAB8Isc5ad2Ibq/Agwt7ZqF3fkA7HliNKDCFeJ7q/
    9Ah3wj0FqH0WGIdjx2gHSP9YpEbSBT92SK83i58c04Vetur4jR5nwQJ19dl8awDU
    e226CnJ/8Mt6gKMyLAi9fJuJ49Oy6FDiPf0XQlLgLfx0QCpqkiOEmeXrvPxtSZF0
    /0LoFqHpLR7XlU3IzqVVtIcWd0ew==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
    header.d=google.com header.i=@google.com header.b=VSX9lEwM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=Rj9EcPUN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256)
      header.d=google.com header.i=@google.com header.b=VSX9lEwM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=reject,has-list-id=yes,d=reject) header.from=google.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=Rj9EcPUN;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=google.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEO1od6Z0/XvyQ71iyZ5kMCo2BKaYqeJtWkyE/PzJ6STuCtkQFc3wUeFUJcPXrnDVTLVjVGLtg5QXxLdOU6aQtD/3KW+rk4l9ePXhvu3O1jE4QK2wvS8
    ypCnl6j1+IHaGyyxMODVWnbm9EBd2TemhO0B0uVCWSEkoT9BropTngJu8wM2geHeNa2iSKe9llJsZ4tT/xOMbO6tcr0KquWb+zQUO+SOrrgF6x3GrtP1UVLt
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=s8YR1HE3AAAA:8 a=VwQbUJbxAAAA:8 a=G3fpAJL8ig5Dbz2U-K0A:9
    a=qOHn8Gqvf7prxvgf:21 a=p1L6UXtPQ1kSAYdC:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=jGH_LyMDp9YhSvY-UuyI:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeEHFNo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 01:13:44 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:39144 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751092AbeEHFNn (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 8 May 2018 01:13:43 -0400
X-Google-Smtp-Source: AB8JxZpwve5i336BvEqx3whi+qEex5G7wGFStfeZjhzrOvV1Q9Ez/xbodCwDtW7dKaVn4SwrrLCufwe3DbaL1px/+Tk=
MIME-Version: 1.0
In-Reply-To: <1525748846-7767-3-git-send-email-william.wu@rock-chips.com>
References: <1525748846-7767-1-git-send-email-william.wu@rock-chips.com> <1525748846-7767-3-git-send-email-william.wu@rock-chips.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 7 May 2018 22:13:41 -0700
Message-ID: <CAD=FV=X3f9tHLY+5NJTBxegsc1PYz5MhomC7MNNSjL-vA8DCWg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] usb: dwc2: fix isoc split in transfer with no data
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
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        =?UTF-8?B?TW9uLUplciBXdSAo5ZCz5a2f5ZOyKQ==?=
        <Mon-Jer.Wu@quantatw.com>,
        =?UTF-8?B?Q2xhdWQgQ2hhbmcgKOW8teaBreeviSk=?=
        <Claud.Chang@quantatw.com>,
        =?UTF-8?B?U2FuIExpbiAo5p6X5bu66I+xKQ==?= <San.Lin@quantatw.com>,
        Ren.Kuo@quantatw.com, "David H.T. Wang" <davidhtwang@aopen.com>,
        Fong Lin <fonglin@aopen.com>,
        Steven Cheng <stevencheng@aopen.com>,
        Tom Chen <tomchen@aopen.com>, donchang@aopen.com,
        milesschofield@aopen.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Mon, May 7, 2018 at 8:07 PM, William Wu <william.wu@rock-chips.com> wrote:
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
> Changes in v3:
> - Remove "qtd->isoc_split_offset = 0" in the if test
>
> Changes in v2:
> - Modify the commit message
>
>  drivers/usb/dwc2/hcd_intr.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
> index ba6fd852..3003594 100644
> --- a/drivers/usb/dwc2/hcd_intr.c
> +++ b/drivers/usb/dwc2/hcd_intr.c
> @@ -930,9 +930,8 @@ static int dwc2_xfercomp_isoc_split_in(struct dwc2_hsotg *hsotg,
>         frame_desc = &qtd->urb->iso_descs[qtd->isoc_frame_index];
>         len = dwc2_get_actual_xfer_length(hsotg, chan, chnum, qtd,
>                                           DWC2_HC_XFER_COMPLETE, NULL);
> -       if (!len) {
> +       if (!len && !qtd->isoc_split_offset) {
>                 qtd->complete_split = 0;
> -               qtd->isoc_split_offset = 0;
>                 return 0;
>         }

This looks fine to me now, but as per my comments on the previous
version I don't think I've dug through this problem enough to add my
Reviewed-by tag.  I'll assume that John or someone with more knowledge
of the USB protocol than I have will Review / Ack.


-Doug
