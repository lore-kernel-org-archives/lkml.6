Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1317899-1525712698-2-9773905922807034293
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525712698; b=UOBY5stcmsaBuisUe6PHicenQfRsp6CuBQ9VJK86w7nMVH7toB
    MjN0HbISp8mqKNIhD5bvqe0cuPvq0+r1LF8TzBRzPVRCgG9y5QEtkPzWV/J2VLs2
    THQcgO1ElPXIpLrsM17ZAJbsCd0Aa43/yVjcRxzQHBZX6SAOe0GWV9ii0ip/esxt
    2ZivEjk8xjiM8gmTFwJiKliapPAFh0I2jWCrRAvCH++P9as2Jp4MXw9kvwziJ1zR
    sP6X0qlVNC/whOoULp2m0+BKTdqVk+Ybuk92H/VQV8jvkwyye9ZxbU33mqn4Q3Xn
    aSxLAgHq9rcpy1dWYGS0+fsCyoaFkSlDzB2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525712698; bh=ydpGRtACs5oj+M3B0P+nDoTu85aCXV
    Yrs2h8XNV93lg=; b=EyhEGEAfTH+ynp2RcvIFPo7eHqPZ6r9FwXsA72qAPVmzxp
    Dp6l2uU1A5rP5q5nnTMLaCjraZFl0zt0AVt8WltmnmKocrvZ8Kvpe6oy/gS6cBkg
    kKUw2FGq8XqJWYK+b5Pbg/QQkBIC3nb/jbwvSaLzDOnqW6NFiYKYR7XT5Pue4p3a
    Dffv5NKQ1+OQHQrrhURpJY+U5uDK8TZniNXXSRAaV23PDL6KivLU8ObNH5U+HhkU
    YbSPccnuy1QY7eoD97Uk5fIdBq05LwtHdmOfxalCyDd2hmU+Sgft5Q0MJVVen/DV
    CEQADDf95gOI93KQHuLUbFCjFheSFy87G3QHqe7Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=FCVd2W6B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=FCVd2W6B;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCmQ9i9th5jmfn5Qrsal4dXKhGdPSVIMAdUJrgAyQbxZvKvs/EYcnC8+CrhPSBDqSknFATUbUEH2awpl2m9H2GeWbu25TkvLwKbhu6OIZt98mXvjiw5B
    OQXHO/kx2sRXs+tRs/+ZocdbU6nSmPE6w4+RwUOQWqts5fGIswy13Ymb7awdfXORHbz1SEGpEk30rSpBeDoAVGclL7ThXBHhO4PP/dFIMMGQmHCiSCgFGLdO
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=mpaa-ttXAAAA:8 a=VwQbUJbxAAAA:8 a=e6nnkuHMke3ak5PjV5UA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=6heAxKwa5pAsJatQ0mat:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752081AbeEGREq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 13:04:46 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:42301 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751923AbeEGREo (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 7 May 2018 13:04:44 -0400
X-Google-Smtp-Source: AB8JxZpzb53El/7AhCFQc+yh51+tR2e3ZFtnsmz27+9HY9ksG5shIIJ8GELUL8ip+Jw9vwb61YH+PA==
Date: Mon, 7 May 2018 12:04:35 -0500
From: Rob Herring <robh@kernel.org>
To: Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: add MediaTek XS-PHY binding
Message-ID: <20180507170435.GA14540@rob-hp-laptop>
References: <1525486506-19301-1-git-send-email-chunfeng.yun@mediatek.com>
 <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525486506-19301-2-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, May 05, 2018 at 10:15:05AM +0800, Chunfeng Yun wrote:
> Add a DT binding documentation of XS-PHY for MediaTek SoCs
> with USB3.1 GEN2 controller
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mtk-xsphy.txt      |  110 ++++++++++++++++++++
>  1 file changed, 110 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> new file mode 100644
> index 0000000..9a95fab
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-xsphy.txt
> @@ -0,0 +1,110 @@
> +MediaTek XS-PHY binding
> +--------------------------
> +
> +The XS-PHY controller supports physical layer functionality for USB3.1
> +GEN2 controller on MediaTek SoCs.
> +
> +Required properties (controller (parent) node):
> + - compatible	: should be "mediatek,<soc-model>-xsphy", "mediatek,xsphy",
> + 		  soc-model is the name of SoC, such as mt2712 etc;
> +		  when using "mediatek,xsphy" compatible string, you need SoC specific
> +		  ones in addition, one of:
> +		  - "mediatek,mt3611-xsphy"

What about mt2712 you mention above?
