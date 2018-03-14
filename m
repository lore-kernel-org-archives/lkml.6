Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2202530-1521047554-2-9846349560752128877
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521047553; b=fWnBBjYV6HUF2FF/j+/eRY7hU3atkz3IhDbfEakmAbDo253
    DbeG+LFpc3pju1SdYCQw86dBvaw7jd3ca6wtsY/NjFkoMcuRqds/jOKQR7lVoPxr
    uDmlSYKt4CCZNqoxno8/jp3d+7GRF1tnlCeo26mTmCp0WGYhK9OHnRdJVibt2RIH
    mETZwOHUZYmDCqjfnbk8A2JpAug2O/1Zke9t0m6FmRphZWnrYn3Xl7eP9OaYYqQP
    zqfxBxc9Za4mRP+kN4My/1PoYV70z3NimSTTu2CWRStJAnHzLUzO1iWTHR/+nYvR
    kPlPpg7aR6o2Lr8urgSrQJHw/ILVrOlVNt/A4Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521047553; bh=DIxo/VuJQcHHoxu4xqF0hs45XT
    oDciiXSwknRSPo6JE=; b=ZiS7CJfoFr8808K8Q+jVqadgkwtdxnD02CQVqtTLAJ
    dLKBAaQp8q/EyPN4/FBHTipwkVqsL0WHXVJfyOMpoKARpBPCAHZn4bjDtx3SrYE/
    RsXp0in4sy/e8ViS5mqRRO0rYZfCpdadVbc+14+gBxbo4Fa2xJ4+Eu5ztyg43Q1p
    C+i6vskCJA/1LuzZEgxO8+L5/D3jzlxRfbCP/owyiI6/pPgJtx0W00mvQD+bXD+w
    ZfnsK+fOZLqhyPSPNI2gJbD4IU+nu6lwzhTcrVDWfbcbhkllRLLBwGvdAYPB/vtC
    9V6WEgkncQG7vE+BBrlIK3Qik2ekfkiEIke48ifiLE8g==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=dsa/FQ9N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=ti.com header.i=@ti.com header.b=dsa/FQ9N x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=ti-com-17Q1;
    dmarc=fail (p=quarantine,has-list-id=yes,d=quarantine) header.from=ti.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=ti.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751660AbeCNRMT (ORCPT <rfc822;greg@kroah.com>);
        Wed, 14 Mar 2018 13:12:19 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:19115 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751456AbeCNRMR (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 14 Mar 2018 13:12:17 -0400
Date: Wed, 14 Mar 2018 12:12:13 -0500
From: Bin Liu <b-liu@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
CC: <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 38/47] usb: musb: remove blackfin port
Message-ID: <20180314171213.GO14921@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-39-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180314153603.3127932-39-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, Mar 14, 2018 at 04:35:51PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so we can clean up
> all the special cases in the musb driver.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/usb/musb/Kconfig        |  10 +-
>  drivers/usb/musb/Makefile       |   1 -
>  drivers/usb/musb/blackfin.c     | 623 ----------------------------------------
>  drivers/usb/musb/blackfin.h     |  81 ------
>  drivers/usb/musb/musb_core.c    |   5 -
>  drivers/usb/musb/musb_core.h    |  30 --
>  drivers/usb/musb/musb_debugfs.c |   2 -
>  drivers/usb/musb/musb_dma.h     |  11 -
>  drivers/usb/musb/musb_gadget.c  |  35 ---
>  drivers/usb/musb/musb_regs.h    | 182 ------------
>  drivers/usb/musb/musbhsdma.c    |   5 -
>  drivers/usb/musb/musbhsdma.h    |  64 -----
>  include/linux/usb/musb.h        |   7 -
>  13 files changed, 1 insertion(+), 1055 deletions(-)
>  delete mode 100644 drivers/usb/musb/blackfin.c
>  delete mode 100644 drivers/usb/musb/blackfin.h
> 
> diff --git a/drivers/usb/musb/Kconfig b/drivers/usb/musb/Kconfig
> index 5506a9c03c1f..490990e8b015 100644
> --- a/drivers/usb/musb/Kconfig
> +++ b/drivers/usb/musb/Kconfig
> @@ -18,9 +18,6 @@ config USB_MUSB_HDRC

This config entry has "ADI" in its tristate message:

config USB_MUSB_HDRC
	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, AW, ...)'

so we might want to remove it along with the whole parentheses?

-	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, AW, ...)'
+	tristate 'Inventra Highspeed Dual Role Controller'

Other than this,

Acked-by: Bin Liu <b-liu@ti.com>

Regards,
-Bin.
