Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1371BECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA1C214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 08:24:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="FrHBBV7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA1C214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIQNul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 09:50:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:34759 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727946AbeIQNul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 09:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1537172657;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:Cc:Message-Id:Date:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=J2Q8smOLS15NYOOfY3N2Eym4ryrOvqeUtsKITP0/5co=;
        b=FrHBBV7Yd3yve3hGV3LHqdFOKzpQHA4bMDwNidpbtkBOanPmkXl/gXzaCcU5U3Bz4d
        6J7+x/6+tzbFTymFXQ31hETZ4sKGNkrReId2OOMp7G4uSXspcXAmIxZf8gwfU1mmUAWH
        pz5VnSOecIbOlxVG5ygsC8GdphY1+ajcecDoo5G+GBIElweIXOF11hOCFjqlXVbuEUtR
        r6Z8KtPjrT19sOzUl7Re4Iwx1F5rsRGUOZ4rf7SHvFt2S89X5c80wTKyCXFhIcR8Qweo
        1IjN9SEv/rnjZ5PvEq6quZGahok+Xg003XXFNelWbZUloD5wjq+dzS6v2x3L1vCbEVTJ
        MpDA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5gpw91kgwllb1BmCEUA="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.1 DYNA|AUTH)
        with ESMTPSA id 60b24bu8H8OGBkr
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Mon, 17 Sep 2018 10:24:16 +0200 (CEST)
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: omap5: dwc3 interface status in /sys
Date:   Mon, 17 Sep 2018 10:24:16 +0200
Message-Id: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>
To:     Felipe Balbi <balbi@kernel.org>, Roger Quadros <rogerq@ti.com>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Felipe,
I have made otg mode work on the omap5-uevm with help from Roger
and now I wonder how to read the interface status for GUI display.

On omap3/twl4030 systems we can simply read

	/sys/bus/platform/devices/musb-hdrc.0.auto/mode

and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can =
easily
be translated into icons for GUI display.

We have not found a similar attribute for dwc3 (except part of this =
information
in

	/sys/kernel/debug/4a030000.dwc3

but mounting debugfs for GUI purposes isn't a good idea).

So do you think it is possible to provide such information to

	=
/sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?

BR,
Nikolaus

