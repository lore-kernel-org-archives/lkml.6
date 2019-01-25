Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12CBCC282C3
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1024218D2
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728583AbfAYCHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 21:07:38 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:25036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727983AbfAYCHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 21:07:37 -0500
X-UUID: ff3c704bdcda4616b19db014e00e83ab-20190125
X-UUID: ff3c704bdcda4616b19db014e00e83ab-20190125
Received: from mtkcas32.mediatek.inc [(172.27.4.250)] by mailgw01.mediatek.com
        (envelope-from <min.guo@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLS)
        with ESMTP id 537391547; Fri, 25 Jan 2019 10:07:29 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Fri, 25 Jan
 2019 10:07:27 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 25 Jan 2019 10:07:26 +0800
Message-ID: <1548382046.4433.304.camel@mhfsdcap03>
Subject: Re: [PATCH v4 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
From:   Min Guo <min.guo@mediatek.com>
To:     Bin Liu <b-liu@ti.com>, Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>, <devicetree@vger.kernel.org>,
        <hdegoede@redhat.com>, <tony@atomide.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        <chunfeng.yun@mediatek.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Fri, 25 Jan 2019 10:07:26 +0800
In-Reply-To: <20190122143348.GF30080@uda0271908>
References: <1548073351-13739-1-git-send-email-min.guo@mediatek.com>
         <1548073351-13739-2-git-send-email-min.guo@mediatek.com>
         <20190121151417.GA19238@bogus> <1548149773.4433.284.camel@mhfsdcap03>
         <20190122143348.GF30080@uda0271908>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bin,

Thanks for your help.

Hi Rob,

I find that Samsung describes the usb-connector attribute in DTS, and
uses a private driver.
And try to write DTS as following:

usb-connector node:
musb_con: musb_connector{
    compatible = "linux,extcon-usb-gpio","usb-b-connector";
    lable = "micro-USB";
    type = "micro";
    id-gpio = <&pio 44 GPIO_ACTIVE_HIGH>
    vbus-supply = <&usb_vbus>;
    port {
        usb_to_connector: endpoint {
            remote-endpoint = <&connector_to_usb>;
        };
    };
};

usb node:
&usb2{
    status = "okay";
    port {
        connector_to_usb: endpoint {
            remote-endpoint = <&usb_to_connector>;
        };
    };
}

Can I describe usb-connector like this? Or can you give me some advices?

Regards,
Min.

On Tue, 2019-01-22 at 08:33 -0600, Bin Liu wrote:
> Hi Min,
> 
> On Tue, Jan 22, 2019 at 05:36:13PM +0800, Min Guo wrote:
> > Hi Bin,
> > 
> > Sorry to bother you again, I encounter a problem about the extcon
> > property.
> > 
> > I don't find a common driver describing the usb-connector. Is
> > there any driver that I can refer to, specially the way to switch MUSB
> > controller between host and device mode? 
> > If it needs to implement by myself, is it possible to emulate an
> > usb-connector driver by extcon-usb-gpio, and also use the notifier
> > mechanism or can you give me some advices?
> 
> I am afraid I am unable to help you on this. I wasn't really pay
> attention when usb-connector was introduced and not sure how it can
> replace extcon. Now after read usb-connector.txt, it seems the binding
> only defines a/b/c-connector, but not ab-connector, and there is no
> enough information (at least for me) explaining how VBUS and ID fix into
> this usb-connector binding.
> 
> Maybe Rob can provide some hint.
> 
> Regards,
> -Bin.


