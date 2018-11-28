Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 884EAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 476AF2086B
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 06:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476AF2086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeK1R1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 12:27:08 -0500
Received: from lgeamrelo12.lge.com ([156.147.23.52]:41144 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727209AbeK1R1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 12:27:08 -0500
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.52 with ESMTP; 28 Nov 2018 15:26:34 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.32.163)
        by 156.147.1.127 with ESMTP; 28 Nov 2018 15:26:34 +0900
X-Original-SENDERIP: 10.178.32.163
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Takashi Iwai'" <tiwai@suse.de>
Cc:     "'Jaroslav Kysela'" <perex@perex.cz>,
        "'Takashi Iwai'" <tiwai@kernel.org>,
        "'Vinod Koul'" <vkoul@kernel.org>,
        "'Daniel Mentz'" <danielmentz@google.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "'Seungho Park'" <seungho1.park@lge.com>,
        "'Jongsung Kim'" <neidhard.kim@lge.com>,
        "'Wonmin Jung'" <wonmin.jung@lge.com>,
        "'Jaehyun Kim'" <jehn.kim@lge.com>,
        "'Hyonwoo Park'" <hyonwoo.park@lge.com>
References: <1543210597-6717-1-git-send-email-chanho.min@lge.com> <s5hin0k6xqy.wl-tiwai@suse.de> 
In-Reply-To: 
Subject: RE: [PATCH] ALSA: pcm: Fix starvation on down_write_nonblock()
Date:   Wed, 28 Nov 2018 15:26:34 +0900
Message-ID: <00d001d486e3$4f2d1600$ed874200$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQMaVnIxoQzG0mth21qziKuhS7dD/AHddrpxosmyX+CAAHq1kA==
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > Hrm, converting unconditionally with msleep() looks too drastic.
> 
> Yes, it looks drastic. But, IMHO, I can't say busy-spin is not
non-drastic.
Fix typo in this comment:
I can't say busy-spin is not drastic.

Thanks
Chanho

