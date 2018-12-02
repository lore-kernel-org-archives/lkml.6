Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B31C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 755A920834
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 17:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CWucceqw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755A920834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbeLBRtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 12:49:04 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55615 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725554AbeLBRtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 12:49:04 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F81121B13;
        Sun,  2 Dec 2018 12:48:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sun, 02 Dec 2018 12:48:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=zCCZ21CqX9To4MU6UaGQeWI2pbdABeENdNn/upepIQA=; b=CWucceqw
        VYjoNINf+ieuJbAD6ZMJ2cPwQpE0vJa33zpwIdQ0jF5+KtWFxWh0tdyJIuA4bjX5
        MDYuhiAY/YVzWIaaCwLnl24krsZk9DY0XzXvJ83SHaz52AnDUwE858z4EsZk6lL4
        4OKtkPkzjQcDDubn5+rH29XBnAi7gK1ktqFVlOgHVIU38jIc39Er78tSG8i2EqkX
        ASHd+Qg06yu3/k5929GJXyCFYGjDzjg0oByMdSgMR7wi3pZQ5ykIfAuAGZOmbNtR
        mbIy5sGIdrqAn1Fm5RDKf4ni3Z3e8OcI2/RmGY0JyJBahYfabT2jT4aZh8rjIkTp
        mr4FWs2FEE1New==
X-ME-Sender: <xms:ChsEXL8QxoGhbPwAGOUkEcybyPndzErHvw-Hi7yC4EQn96KZGuIdLQ>
X-ME-Proxy: <xmx:ChsEXNUCsGfkq4azABb4mf8jZuDkd5ZcARSuDbvMSbKZuWM8yRJAXA>
    <xmx:ChsEXFzloGk6UwClakJ8zNb9cRKQXB1X-iE8b_f_fTYSyHOOdzwmlA>
    <xmx:ChsEXAtiq78wCj3X_sYZR5j3mDcWgi5B-RudDpY4wN7YG2ziL6a-Gg>
    <xmx:ChsEXODGI9K6gUm8iJ-YrH7s7Ce1XN61B2NFH9FUPbvx6cG13SCVNg>
    <xmx:ChsEXEocC41p8PoO-2JJOTLmv5OwlP_ZKhBhR0sX3tYqWSrUH8S2uA>
    <xmx:CxsEXBa3SfVPF22BLBNlWbS7sGycXNTqUKSacvO0-YTj6LENzqfyDw>
Received: from localhost.localdomain (ip5b40a57c.dynamic.kabel-deutschland.de [91.64.165.124])
        by mail.messagingengine.com (Postfix) with ESMTPA id 684BFE443C;
        Sun,  2 Dec 2018 12:48:57 -0500 (EST)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Dwayne Litzenberger <dlitz@dlitz.net>
Subject: [PATCH 0/2] xen-paciback: Fixes for PCI passthrough of AMD GPU.
Date:   Sun,  2 Dec 2018 18:47:31 +0100
Message-Id: <cover.55c0e31b75e2fbdf4206cc39c2fd7581793ae7ae.1543772656.git-series.marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've got this patch series from Dwayne Litzenberger, as a fix for AMD GPU
passthrough. I don't have this hardware myself, so I can't test this, but he
claims it works. I'm not sure if allowing guest to enable/disable expansion ROM
is safe thing to do, but the comment in rom_write for me suggests it is but
wasn't considered necessary. Other than this uncertainty, the patches looks
good for me.

Originally posted here:
https://github.com/marmarek/qubes-linux-kernel/pulls/1

Cc: Dwayne Litzenberger <dlitz@dlitz.net>

Dwayne Litzenberger (2):
  xen-pciback: Fix error return in bar_write() and rom_write()
  xen-pciback: Allow enabling/disabling expansion ROM

 drivers/xen/xen-pciback/conf_space_header.c | 34 ++++++++++++++--------
 1 file changed, 23 insertions(+), 11 deletions(-)

base-commit: 2e6e902d185027f8e3cb8b7305238f7e35d6a436
-- 
git-series 0.9.1
