Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ADD620700
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="q9QJtgnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732471AbfAKPr5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:47:57 -0500
Received: from mout.web.de ([217.72.192.78]:38115 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732003AbfAKPrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1547221674;
        bh=vT+8tNxpA/NjvZdj9aZUucIJOKCuIEEtHffeDdDdr0s=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=q9QJtgnYSIOmJE3Y6hCwOoTYgBxuBA+pGvjQp/xO3dFpWrmNM4K6kZU1XgBrok1rb
         gs8M2ark61n4Byjxr6bCB/nccyMFGQuYD1wynq6fGf+v14G/H/89H8W/NZBGGwg6+h
         LRUNIVT99JfmufV+9e+zej35n2TAWsA7lwygLJ4U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from ingo ([80.132.82.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkyIj-1hIQJg3YbV-00akQr for
 <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 16:47:53 +0100
From:   Ingo Brunberg <ingo_brunberg@web.de>
To:     linux-kernel@vger.kernel.org
Subject: DMAR error with SM2263XT controller
Date:   Fri, 11 Jan 2019 16:47:42 +0100
Message-ID: <m3y37r6vs1.fsf@web.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:kWnUQNmtR0w02Wg9RkXdljjZ5bAu6gF5rCN9SBf4z1/JhzTdjiV
 A2u8LKXCc7KD5JEWqpM9f37QN5vKAPAVp40eqAAyc6i3kd9x7A/Yz/p/hBB+LCJTLf/0SfT
 pdEt+2Yo3ThNvHQpmFodqOzhgmIe6Gk8LK6ersymplu/fnbnkmYeRiglJJAtSvIyFBzNFWp
 BDZnZOanrw4GxFLw5oBLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AT0HbErYawQ=:bdka7Db7tySbnJhSg7J6Pr
 ojrQ3277Cjxb9fFkP/nR1gd09FoYnMthyKWz1J/RBh5Vn5E+Qhs+7Yg021OZLEeacWXjYA9g8
 dKBqlztfkTYuqBTPc+0S06fCR6k53Snu7M4NR/EeK5w9AyoPdiTjK3UiVyM1wyyKrTekeekxf
 G4zZCFYKjWC/3Wrb1zmrRlpLeIPdkkmYYlhoGPGe90YduW1S8ZyGJBcvxbQWX9kjkRG2yaJCF
 fNIL4+TKzbGoKrg4L35J7WnqaUMs7BBqAcGrex4cYNdEHeQErn/8lpbxHPbAboSX6Hgx34wDf
 C6Dcg6EC8enLP+xy6+QfzajBppLFDS+/gj42EYZLLGIKLlaA/AcOh8Db6QwvHLpjVwuHjJAFo
 KNdXcHs7dBS04oIFgZZ1f0JjrnyHRy3jJCVwg3ri2ugUkZb+FVVmpu0TwztHWZ/unqluH5G7S
 SyZZuA3VDndn1AIRg3KTwiXIywSoJJhC3uxZ+B+y0Ygs5sBVPnG3pVRpf8Efo8RGPd3GIxkMX
 zHpUjWS9aTWr0TRopv2LVf86656tvgdyQFaTFeHYgfEao75Gn25aH1D6RHXdVJ4/dewuIEl2R
 jYjj6glLc/T9NT8dfXdCQtguYQruwvXs8tP5/MPzJQ4rGiR00Mkf1SVf1EX0fd1rf7vhit11N
 hdfR6cWDiz5iEHrJvHxq7oxKcDLuckOsJout2qHvpQjpEHP/5LbPy0r+ydSSw0MLDbC3Q3fzs
 aIYzdOBMV63wAeGxRZoA727UIoJv5kn0eYpVACIFhAqrCgaS2iCVLHrxzXn/xaWJRvnuT1cLS
 bYR+7fs62YsiXgPk2iaMi8DbR3kl3lZ9orb/4NDYPrp60e88AAMRMp2AX8eanfMHAb+HfegWT
 rwbPwHJxOSIiRSjYQYnZrm/sFAL29Xo6PFmCzOK+iuId5awTLbeWPqGUkioTIaJpiMwFJUeRP
 83lezxGiG8Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have got a HP EX900 NVMe SSD with the SM2263XT controller. Whenever I
perform fstrim on this device, I get the appended error message. Maybe
something can be made out of that.

DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [04:00.0] fault addr f98eb000 [fault reason 06] PTE Read access is not set
DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [04:00.0] fault addr f99e3000 [fault reason 06] PTE Read access is not set
DMAR: DRHD: handling fault status reg 3
DMAR: [DMA Read] Request device [04:00.0] fault addr f99fc000 [fault reason 06] PTE Read access is not set
DMAR: DRHD: handling fault status reg 3
