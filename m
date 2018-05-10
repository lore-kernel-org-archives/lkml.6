Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1338303-1525921911-2-6248535799499652073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, UNPARSEABLE_RELAY 0.001,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525921910; b=dUgZaCuoCwaEVMn+7WaJanX8FuOQ94K2q3o2U5R/M0rPw2MzsY
    B8OPtSTCns0fi4WCHZnHvkbOqK/GxMRSKm8iWpnl/LRFq4HZEEhjpgxGe5/XF1uB
    JT9vLpBoMCdgMLZfW/2mggkG4FxXr7qpygEO3a/K6JSQb1+4PRWZovevqsou90Jq
    OeJaZ6VdDAdCZHg5E48dEItcnqp1JAJcVzIIin7RRu4KsqeiyzQh18zkJ2DMf40x
    wuPLd1J8jVF0n9nP3h3BRBGC/eX3hUmgTUCwGgTUEjkpwY5ELNMP9RI7JIAY7Sdy
    O1pwF1YsQCDpi34UGly+KBndeX1FAtTuxAHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1525921910; bh=JsNO/i6HOH
    yx6Y/jdj2omND7vLhbpnon5s86En05ZGM=; b=ixqmqRprTRgqsFzz/tEydz0rjb
    NqEP+qiKQYyHDai8SpVO4X5dVKzHKHVvTntWuROErGUqP5hvTDOaIE/iE/ZiUz3x
    JXhSNTkVf1v+7QrCz/hdN1gPEeiTLfERLpJzm+IFD6I6W51AvBJFVkhtFbQSbCXO
    JfzDfX/t1DNmsU9zb8HIBsjbFfaFTM0WISYsNEzoVsq52sxk5n1Hwh5HLPMVBtqA
    98bGfaeve9Ds5yvvs0AgKo7/NSS2cCnnZc20oXcVUa/ZWJFIUN88N5y33Ei5pktM
    znHaXORjKbVs8dXTP/mwg3OKvC0DwV0W6fMKqYu8bSLR8p2suWetxi0fItYQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mediatek.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mediatek.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mediatek.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLO9fWR/1TizftueDOEQIuTf86i5h7KXR9JNURYFpI6uruXwiKKb+h7KBT9rPLQIeYIyWSRKt8/4cWleHLDhjY/0gUMKtBHY7exzt74Ly4VG/04SpPCj
    Ou4YIFfi6SIy9c5Dg4IqdGx5NQbmSnRTWHmQ2ne6dfgrx900J7XjLPSlFZjbxBgKcSx8HKoZwMzlm3wjfU4fg7h+IWzxj49CYZDQ9WTJFNy5lZ02pv5DcRPC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=c3D3SKACx2MFx_CIqtEA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933770AbeEJDLh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 23:11:37 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:19998 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756291AbeEJDLg (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 9 May 2018 23:11:36 -0400
X-UUID: 760c41ce495c49f18c29212c312d4427-20180510
Message-ID: <1525921890.32173.12.camel@mhfsdcap03>
Subject: Re: [RESEND PATCH 1/5] usb: mtu3: avoid TX data length truncated in
 SS/SSP mode
From: Chunfeng Yun <chunfeng.yun@mediatek.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Date: Thu, 10 May 2018 11:11:30 +0800
In-Reply-To: <1525918606.32173.9.camel@mhfsdcap03>
References: <3b0c7ca576fee8220d63c9914483b70b0fbc8783.1525486663.git.chunfeng.yun@mediatek.com>
         <1525918606.32173.9.camel@mhfsdcap03>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK: N
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi, Greg
On Thu, 2018-05-10 at 10:16 +0800, Chunfeng Yun wrote:
> Hi, Greg
> 
>    Could you please pick up the series of patches, thanks a lot
Please ignore it, I find a problem in [RESEND PATCH 4/5], and need send
a new version.

Very sorry

>  
> On Sat, 2018-05-05 at 10:21 +0800, Chunfeng Yun wrote:
> > The variable of 'count' is declared as u8, this will cause an issue
> > due to value truncated when works in SS or SSP mode and data length
> > is greater than 255, so change it as u32.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> >  drivers/usb/mtu3/mtu3_gadget_ep0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/mtu3/mtu3_gadget_ep0.c b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > index ebdcf7a..d67b540 100644
> > --- a/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > +++ b/drivers/usb/mtu3/mtu3_gadget_ep0.c
> > @@ -546,7 +546,7 @@ static void ep0_tx_state(struct mtu3 *mtu)
> >  	struct usb_request *req;
> >  	u32 csr;
> >  	u8 *src;
> > -	u8 count;
> > +	u32 count;
> >  	u32 maxp;
> >  
> >  	dev_dbg(mtu->dev, "%s\n", __func__);
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


