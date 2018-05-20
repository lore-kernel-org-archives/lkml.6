Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2804649-1526812732-2-9331552130226440867
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526812731; b=gKIGa72n9Zz7QT2liVZ2QY8IQd4km2hPdjC00RnalNAWVoAcG/
    ESpw/pbfnxBhAP576gMdR333Hv68t1JDK6IvjgosLaf5QI1lEVQnrMSxEYx+dxY8
    FyKqie6yHezByH99+CcWS98537Mtptl4Caz0a83tdWwygC48PlywkZFsHxFmj0Yv
    Anjq7fZhCrlCHhdPr69yLlXBL5AVgAJKLEpBJ1Vxf8iya1hzkp3a8LXXBZmCuR6Z
    4UT6U1oi0UyDyuHe/gS2xpAuFnM1oDfaeUz4Z3Ku12KMPD6m7cq5O0p/NDXiksHC
    XQbAFqU2OuAhIiTmFJNJhxFdXA/CXEXqeF/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-transfer-encoding
    :content-type:sender:list-id; s=fm2; t=1526812731; bh=7oXF8BB0Wg
    YSY9hvovczVAbGZ3fJYDTrTKy8Dweg8iY=; b=f41+hG7QVok75+JL1uVZ4It90x
    xkM19ewFFkW9+eDpZBTf354d7KvXWNUgC5gHCDPXFZlOkqeO6GhWPc3yj1O/O6Od
    L3PeQrysNu2ZJCvJzYiNUicYoc3V6OoDKLDmb3fdVRGYW4cb84G5z5buujm6f3YS
    ua8HQK2TfSkp44W+Hnyu7TQR0a7BrXTylsVQ9W9YVwGctCUjFZAXkKzpUwLP1lE3
    kXKfNvq8pAohagg7sHqGDSr/L5gMONCe2DuvvLlo6Pwz8TKH2TtKS/ww5dXUPz+7
    y7cH3HJBVWw+ucVXmH0tN2xq8Db0XU54bZQqAGdBE5YgYBItZjjKZ75livww==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=sntech.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=sntech.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDCAY5JBBGY91ITdkcuJXqmO34AnfjyVeUkNlLs0+VEUOw8ZNwyDB23QE7a97hNv/kk6iL456AsZOQDQyObJ1r8Gv8S0JHGvi4ctrJjETt5l0SfJbODG
    jcSgiJ8fjqSTuE+dKJJSNQU4XDtm0aTIDG4dYQkJ5CvZ0RVwFO+zGnfrOwrt4QVvkew+1NjIzBfwYCMLm4PJqZl+Am9aYa6zqGtioABqwRfo3O3HXm6n/mPh
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=Ndx7yIVex8M7RJDNeXoA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751021AbeETKii (ORCPT <rfc822;greg@kroah.com>);
        Sun, 20 May 2018 06:38:38 -0400
Received: from gloria.sntech.de ([95.129.55.99]:41060 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750895AbeETKih (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 20 May 2018 06:38:37 -0400
From: Heiko Stuebner <heiko@sntech.de>
To: William Wu <william.wu@rock-chips.com>
Cc: hminas@synopsys.com, felipe.balbi@linux.intel.com,
        gregkh@linuxfoundation.org, sergei.shtylyov@cogentembedded.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-rockchip@lists.infradead.org, frank.wang@rock-chips.com,
        huangtao@rock-chips.com, dianders@google.com,
        daniel.meng@rock-chips.com, John.Youn@synopsys.com,
        wzz@rock-chips.com, zsq@rock-chips.com, Allen.Hsu@quantatw.com,
        StanTsui@aopen.com, Spruce.Wu@quantatw.com,
        Martin.Tsai@quantatw.com, Kevin.Shai@quantatw.com,
        Mon-Jer.Wu@quantatw.com, Claud.Chang@quantatw.com,
        San.Lin@quantatw.com, Ren.Kuo@quantatw.com, davidhtwang@aopen.com,
        fonglin@aopen.com, stevencheng@aopen.com, tomchen@aopen.com,
        donchang@aopen.com, milesschofield@aopen.com
Subject: Re: [PATCH v5 0/2] usb: dwc2: fix isoc split in transfer issue
Date: Sun, 20 May 2018 12:38:24 +0200
Message-ID: <2379874.hUfS9Aq0OQ@phil>
In-Reply-To: <1526031992-16565-1-git-send-email-william.wu@rock-chips.com>
References: <1526031992-16565-1-git-send-email-william.wu@rock-chips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Am Freitag, 11. Mai 2018, 11:46:30 CEST schrieb William Wu:
> This patch fix dma unaligned problem and data lost problem for
> isoc split in transfer.
> 
> Test on rk3288 platform, use an usb hs Hub (GL852G-12) and an usb
> fs audio device (Plantronics headset) to capture and playback.
> 
> William Wu (2):
>   usb: dwc2: alloc dma aligned buffer for isoc split in
>   usb: dwc2: fix isoc split in transfer with no data

On rk3036, rk3188, rk3288 and rk3328
Tested-by: Heiko Stuebner <heiko@sntech.de>




