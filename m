Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8093C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60CD120833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 18:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60CD120833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728010AbeIOAMf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 20:12:35 -0400
Received: from mout.gmx.net ([212.227.15.19]:40339 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726748AbeIOAMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 20:12:35 -0400
Received: from [85.212.110.236] ([85.212.110.236]) by web-mail.gmx.net
 (3c-app-gmx-bs77.server.lan [172.19.170.225]) (via HTTP); Fri, 14 Sep 2018
 20:56:47 +0200
MIME-Version: 1.0
Message-ID: <trinity-2b295c8c-de09-422c-b5e2-d6b8c1276de8-1536951407748@3c-app-gmx-bs77>
From:   "Johann Kieleich" <kieleich@gmx.de>
To:     linux-kernel@vger.kernel.org
Subject: [4.18.7] DMAR: Allocating 2048-page iova for 0000:00:14.0 failed
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 14 Sep 2018 20:56:47 +0200
Importance: normal
Sensitivity: Normal
Content-Transfer-Encoding: 8BIT
X-Priority: 3
X-Provags-ID: V03:K1:ON6lj+y8lRWgBvEi2Btep9KSr1GvLqOwVIL9L6+M/sGKyc4tllJHCrStnjopnJUoZvvVK
 qfdBIeSC8nUOSOSX1zaVMmn3+WzoYkExwDRYipoXiA7b4VFOlHHB77mJuqoh7Q7DjIMEtrIZJPhq
 KF0OmXOZbvCb/0HlXjNPssiOdgfvIE0UhVTGqnVgRHknqmrpvz0jRGsWt9DCsgMq0UMvR7B12WGr
 mTKnp0DNhbLXNdinGCTkVN7nXekES2jmCJ0Wb6YrG5BhVpAeDv03UFiPbjcaEKJorksU+wIs96hR
 pw=
X-UI-Out-Filterresults: notjunk:1;V01:K0:LSCCeUw5Bt8=:n0ZOUzLSdSyhCoHzaa2EQ/
 kh904Spi7c088K/d/gjMT5bSZo7PJkajIxMVd+39F93HOzNdRzTOheqMK1gaczXrdhysIsjdU
 N3mpDlTmR54c/jZfRV2gkQoaIJ0W3+vxodhQBVElmSfkezuNM00AxBlv6WuYaEBFbvDw0lZUr
 /4A/pR5ZLdaoyhcKqFswmqBDAUQrm5uEIswqDWesEiotGjYC81GrONoF4VxFFT5/Z7MEtlwIr
 TslSoXPvUszcbTnR49txYXqjOeZu2ccBdTsA6VncZfkcE7tPw4ZBdLbHM87TnlC3n2wD+jn2U
 CXkltLuzAQ+HqFr5HYdQtMJ33R/f/h2brK7GX2lI1WaSl6j82zUQKVe5csHSmMznZiipdWvq1
 E6CYvq69XjrmZGoYbKulNfi8Z95HJWLNwcQKxc27FmbhuDNJvFWS2JwxttJ9bXcGFI8LuP0Py
 C+uYvwM2ONhkBoDwyKFJytc/2n91WA+CFQqw24qTRxGsMY8F+qTT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 
not sure if this is the place to ask.
 
I'm getting a LOT of these messages:

[70679.212719] DMAR: Allocating 2048-page iova for 0000:00:14.0 failed
[70679.508107] DMAR: Allocating 2048-page iova for 0000:00:14.0 failed
[70679.779284] DMAR: Allocating 2048-page iova for 0000:00:14.0 failed

( 00:14.0 USB controller: Intel Corporation 8 Series/C220 Series Chipset Family USB xHCI (rev 05) )
 
This happens while writing random data to an USB drive (Seagate Backup Plus 6TB).
 
# pv < /dev/urandom > /dev/usbdrive
 
The drive is new and I like to overwrite drives as a burn-in test, also as a pre-encryption wipe.
 
This runs fine for an hour or two (a hundred gigs), then speed drops by more than half,
'top' shows usb-storage process eating CPU, mouse pointer and keyboard get sluggish,
and then a while later, these console messages appear.
 
So far the only thing that has helped get things back in order (for a while)
is to reboot the machine entirely.
 
I've no idea where to even start tackling this problem.
 
Any suggestions?
 
Thank you
