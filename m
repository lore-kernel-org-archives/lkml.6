Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E11C3279B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10920253A3
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 23:16:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10920253A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752027AbeF3XP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Jun 2018 19:15:59 -0400
Received: from mout.gmx.net ([212.227.17.21]:53919 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751973AbeF3XP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jun 2018 19:15:57 -0400
Received: from localhost ([123.218.135.145]) by mail.gmx.com (mrgmx101
 [212.227.17.174]) with ESMTPSA (Nemesis) id 0M8IuM-1gMZZR3XtK-00vyg1; Sun, 01
 Jul 2018 01:15:48 +0200
Date:   Sun, 01 Jul 2018 07:50:41 +0900 (JST)
Message-Id: <20180701.075041.1838978756168630725.teika@gmx.com>
To:     rosenp@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com,
        jan.steffens@gmail.com, waltercool@slash.cl
Subject: Re: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
From:   Teika Kazura <teika@gmx.com>
In-Reply-To: <CAKxU2N8HGcJer5v3vDHMnHH1gAeAhHDdNDZS-yL+a2Ung_PiNg@mail.gmail.com>
References: <20180617014216.4043-1-rosenp@gmail.com>
        <20180624.150445.1006140718276550233.teika@gmx.com>
        <CAKxU2N8HGcJer5v3vDHMnHH1gAeAhHDdNDZS-yL+a2Ung_PiNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lGB8e/OKAUxFOgXOmcysOJwIcOqN3siA9t9IlUpL9X5pYaVoMQc
 eqG1PZBHb8Ps01+hMAxjkRlxy+eihiVDONZrtCWrCEg300uvWrfbtyYqE4YZW9445/I3Q7G
 hJtTklWNe6o04ylrp3l8Z4nGuw/Gu0Kigs2dxAfpzoUg6yQCCCmG9QLJJ+KypitFBuVb9PQ
 QAHO+2KXlgqbmvheQLGkQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QQ0b0ICrbH0=:SEAQFisUQEPdxVr+BV8R14
 /rR2IpkabjOvPVukTKmnARWDW1hTZAlHuYO64Sey3MsRQUrAYfYzxKKBHhD/fk1S2NuTwc0dt
 5QVIDXyHKNirXhEM2ZSJK+uzP7ZW/zcGpUXgz5O1d3D84dDswf+uKiO0JR/aQvWr+igFlgQDJ
 D/yQ0AIj6eoS3bnp4eH6gWBaf8faCOaDvzuCMMys8x80614cdIUEwZ7vltHvAXgLo/FJPo4pF
 8k2Ndz5Lpbol2v0hmj1gcRP16+gq6LxXzHcgdx2I+9G1jw4INljyPM/2lpq2WWTxYwb2myQun
 5E+FbLT4mR1e33tFrrYJ7+WuKbwDVmX9wHEEn44aYqPBbxhnfGnKIUUiTdG4b5PTjZC/Qe+vB
 zKdkEvMU/xS6vNcN+zmpXZJoaZzpVb2xMcFlz7soSqJbsMZTArnLPbNujHveNJd2EpyN1wZXA
 owBD6BSE9UYsp9NGy1xG9zG4HKOH0U2mzMCUM3dMKGgH0brKMSjmWn6fqC96Em96jYEBd9cqT
 OM5du8vE9TAJEEsRZeL7NspbarzEs49usCk1eCkjU3wL1BXvqh8Y88MtmfOJF6pBZUvvbaQfx
 DgU2uAgSW7EDXlvv7nl4ECZdGeSXp/71l9CLtnUEjQOPlhhL9icOCbMzMZCc4B7T/WqO7ipDQ
 Zsk2Zudlj6WJgJN8WvUrVegMOSdl1QCu7emt7lhcLHpZQJpZgRxJG2BlYmEViDZyiGvFdiCOD
 mCi4dmcHhZDRMjdDqZ0smRzybS4l58J/KHoYWb8rmaALbgUg6+KrZDP2LBFag7LaVhGY6aQWx
 NDZsE2x
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

@Rosen: Ok, then I'll make a patch, and will ask you to test it. Wait for a moment. Thanks for your reply. (It's a burden for me, too. ;-)

From: Rosen Penev <rosenp@gmail.com>
Subject: Re: [PATCH] synaptics: Enable RMI4 for Clevo P870DM laptops
Date: Sat, 30 Jun 2018 11:57:32 -0700

>> Hi, Rosen. Thank you for your patch. (@Jan Steffens and @Pablo Cholaky: Thanks for your reports.) But I'm afraid some more work is necessary. Let me propose some points.
> Too much work for me. I'll just use the kernel pareameter.

Teika (Teika kazura)
