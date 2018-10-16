Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D91C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0B9220869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 09:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="EGGbbLQX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0B9220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goldelico.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbeJPRTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 13:19:42 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.21]:26995 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbeJPRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 13:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1539682204;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=/yIuS7jSzR5ucuczgIIW3hi+2lM7R0w9SJuFzRsBPU8=;
        b=EGGbbLQXO1p8iektd0GySpVojR/kSLGCIy1f2wALDwOdu5g2lQ3ahHSsTBNjbW5QXU
        jaARf7+3ylolLAlBXHDUEL2Q7Ur+aTLKj+3VYzXVc7n+FKzQ84Njj75qsxXEBCqikEly
        ChUj3N5O8+bzR3KMqgpW2N4wevnfRMqWRlTqGNTJ/6CeqfFWquHdZWklMdrBgZ2AUmaX
        AxTZJdeTPN9j3/V2l0sKLTurQEGIaYippq/HTurPB1gzLiLvkO0nSUAVX1tNSn4FYLKq
        3uQcLwIszJNVSp0VnYN5e6/zS8lBWUFgKpp9vpCD5zY8ZeV3PJJzBPBOc1wIrmehUpYF
        eXFA==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj7wpz8NMGH/PswDOv2zk="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 44.3 DYNA|AUTH)
        with ESMTPSA id J0aaadu9G9Ts6CC
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Tue, 16 Oct 2018 11:29:54 +0200 (CEST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: omap5: dwc3 interface status in /sys
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
Date:   Tue, 16 Oct 2018 11:29:53 +0200
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Roger Quadros <rogerq@ti.com>, kernel@pyra-handheld.com,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <33FDF48F-4B64-4CE4-BC95-43BAB70B6C37@goldelico.com>
References: <5ECC1431-E758-41E6-B751-D336A94433FA@goldelico.com>
To:     Felipe Balbi <balbi@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 17.09.2018 um 10:24 schrieb H. Nikolaus Schaller =
<hns@goldelico.com>:
>=20
> Hi Felipe,
> I have made otg mode work on the omap5-uevm with help from Roger
> and now I wonder how to read the interface status for GUI display.
>=20
> On omap3/twl4030 systems we can simply read
>=20
> 	/sys/bus/platform/devices/musb-hdrc.0.auto/mode
>=20
> and get reports e.g. "b_peripheral", "a_host", "b_idle" etc. which can =
easily
> be translated into icons for GUI display.
>=20
> We have not found a similar attribute for dwc3 (except part of this =
information
> in
>=20
> 	/sys/kernel/debug/4a030000.dwc3
>=20
> but mounting debugfs for GUI purposes isn't a good idea).
>=20
> So do you think it is possible to provide such information to
>=20
> 	=
/sys/devices/platform/44000000.ocp/4a020000.omap_dwc3/4a030000.dwc3?

any suggestions?

BR and thanks,
Nikolaus=
