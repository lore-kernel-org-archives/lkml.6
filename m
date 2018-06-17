Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71131C5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BC1A20693
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 10:38:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC1A20693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933675AbeFQKiQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 06:38:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:44901 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932810AbeFQKiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 06:38:14 -0400
Received: from homer.simpson.net ([188.174.240.203]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M20Jj-1gNQ2O1rvn-00u1Fm; Sun, 17
 Jun 2018 12:38:07 +0200
Message-ID: <1529231886.5303.6.camel@gmx.de>
Subject: Re: v4.14.21+: ATOMIC_SLEEP splat bisected  to 9428088c90b6
 ("drm/qxl: reapply cursor after resetting primary")
From:   Mike Galbraith <efault@gmx.de>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Ray Strode <rstrode@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Airlie <airlied@redhat.com>,
        virtualization@lists.linux-foundation.org
Date:   Sun, 17 Jun 2018 12:38:06 +0200
In-Reply-To: <20180617093607.GA27652@kroah.com>
References: <1529163551.16103.16.camel@gmx.de>
         <20180617093607.GA27652@kroah.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:BHZRzQcEFwMnBIN5p7YxXBR0KKPhWvKrHzJNofXVWQjRBQuOVKV
 xv/UfxwNyw18sMYkxAVes/3wvGaUQDPToRfUQo/YgtQASmlvG0UcMaVdQupHDKpr5hPCUv+
 FTCEKthtmfM9dgIM2ZO6NDs9d6WC6VjiBQqCmWpcB2oRN95PA0ZfgYX3AlGbAhQvPYcrzPr
 QXedH3uk3tiBxUlot/oxQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:HjdfgBiCkd0=:6roXTLnhsdsfKH//VS0Zw1
 BzktI1P/fZf0s2zv34Xh+l0hCzTtxQpmib1/LRS5smRi4sCn7hOa+/rHK1M9napDW5kelAOJj
 LUQ6Adca3Ndyk5Sd6Jcu7pGIChlLDmRXXQ5fzO2dbvfDjOEJPFJveLEJE22na6APDuhqjdOR1
 MB3z5Dl7tzJ3466WxDxPS5M7WGRJURqvpv8wTrpGISQwPKCM5+wsIT2cU1+Dp5T/TaJbx8dPj
 5htHpuLmh7B0C5C90fDKiTv3A0f+kMTINrt3sKTyaV8TUgrAXXN4gP8UFAvEebJ3H8isf5CPa
 nvKUg8TYtLFoEd2GVrOHvkfXKXJsCfWmBHqvmURg7AaPxlovYJqNeroRvvWzNgzyWnl3vOJE+
 KfaMP19eJkjWvjiG36AFh3IVadlcwyhe9NjMkDaU7WoS2zbYtObT/mJ4LukA/soUs3PPUhmR4
 sEKQ3Tpii1+SfQbyvmBxEnEjA2DSxY1tLjMA0GnFVkHGSE3n5IoLQLgIVQ01tYGHIIUGB7RvG
 XKKvvwp0d0kWNK75ogOWkGinKDiaaMrLjWabf/aHkHrzEEiKXLLIeIroiT4WariySuwiWcteT
 Qtf667xGNzHSLBcAgbXLzY7x4/8n5Jf5krCcc/20GDr6wRq+PePhEC/TWbMNL7mtSOMhUQyIx
 1lu612KxiuOsJ4wgBp9N8ncQUXAMWkCtdoh3jmU/FL+UOCBrJXtSeKCzPEB969pekyhhROf1u
 lboC0BWDHr9tFkOcVFvUYx7Anu7VP/raS6b+aoC053+zzekvEIvshAtcXfzKhDlh3oG01e+vw
 d8M9INU
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-06-17 at 11:36 +0200, Greg KH wrote:
> 
> And if you revert that patch, does everything work again?

Yes.

	-Mike
