Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F120FC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929E622BCB
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 00:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="qIPAmdh3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="il+livi9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929E622BCB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934071AbeFVAhX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 20:37:23 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:43237 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933452AbeFVAhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 20:37:21 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B84121C87;
        Thu, 21 Jun 2018 20:37:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Jun 2018 20:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=DXX8bomnT6AVharmQ8/5fL52awlrQ25WT22iUi8ko
        po=; b=qIPAmdh34C0ULVhE4ej5ycRXddlyA6cf+MpzyhjHBQL82RC17VrSUl4iF
        wBsXtk9wzHPk6RDQG4naVI2h/r+wxTzfVj4HptfQm6JVARbVOO2rph8zmK9Kh2q0
        mT3hySkppIPNZclZna7VQtueglWxRsZp32e/itMi5UzPdSjvIN5KeKe5nfhOC+Ic
        RlS2rT1T/VnBByu2nrJgRoe/SAnh2IIwMIFKXMc//3prZZgb6ScD7ejSEwjP/Ean
        9XtdAllF2caqbsHQInidetFsjsvnQf+YJE5s1P9cBBUSpov7RZFfq2vRvPs78UFO
        GcZI0IYLgeV4002G+cQGIYqBTzaTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=DXX8bomnT6AVharmQ
        8/5fL52awlrQ25WT22iUi8kopo=; b=il+livi9xYH/4+/frg3/IzRbBc2GhtVMk
        daU0M12FNSyHAHOsxe5IF2t8vU59TOdPpJeQJvFjcUQKvNakop6Nwy2v4bIbhFAl
        PZ1jLYf/YHZjtlj/9dGs6vDFkjey6z1TmUdQuiKhIOHJSY1OCpM4fPY38WwpI7aw
        nhVz4yA+qqMiaUNHE/B9Zp3ss3/HkWxqJItsAGRF5bWmAhAc6zAclR23PYf3H/XM
        5SsVINg2pNMZWnmVQ1DedFNyxtOLMNSQ4w0atyHLY1MWvU2XDEimlTyJllxBSKCf
        RmNt5U+t+/RGEtxWFOIf0p9El3EiwD6QYJqVrow5P1aZAtNtIBcYw==
X-ME-Proxy: <xmx:wEQsW3krrTIvNFxO35lYsGQes6x_KaZdyhNHI3NT2-uujlTez81h4g>
    <xmx:wEQsW7Aun15WpDpUdH5rJN1TowyLfTUI-S3Yr7KPki83FrpvMh8s5g>
    <xmx:wEQsW_dJ0x9nAktG4KXxHO667ffvlf1tJRSazhDBqUTrhndCQE10Nw>
    <xmx:wEQsW-Ll5Kz2u6IZxywHAnv5PPyqENxjlmBBE00Mroewj4vg7R0qaw>
    <xmx:wEQsW6fY7snlle_rHlArePPDQfcebZgdQysK-t8-K4CWhRr0MhZrUg>
    <xmx:wEQsW7jCoaFvtua7Jb7bWXWZedtP3nNN4afrsjEs3hbaWDLuG4vW1A>
X-ME-Sender: <xms:wEQsW1QE1VOBcoTKvaTa0WgB-O1-Aj1SAcw-n6MGpjRiaQzQVZWoYw>
Received: from localhost (124-169-15-204.dyn.iinet.net.au [124.169.15.204])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0C7A4E4449;
        Thu, 21 Jun 2018 20:37:19 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "David S. Miller" <davem@davemloft.net>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] docs: e100[0] fix build errors
Date:   Fri, 22 Jun 2018 10:37:04 +1000
Message-Id: <20180622003708.31848-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

I may be a little confused here, I'm getting docs build failure on
Linus' mainline, linux-next, and your docs-next but different errors.
There seems to be patches to the first two trees that are not in your
docs-next tree?

Do networking docs typically go through your tree?  Looks like
networking has done some conversion to rst that hasn't gone through your
tree.  Or else my git skills are failing.

This patch set fixes current docs build failure on Linus' mainline

commit: (ba4dbdedd3ed Merge tag 'jfs-4.18' of git://github.com/kleikamp/linux-shaggy)

(FYI this is 8 commits after Linux 4.18-rc1).

And also same build errors on today's linux-next

8439c34f07a3 (tag: next-20180621, linux-next/master, linux-next) Add linux-next specific files for 20180621

I pulled your tree, just to make sure I'm pulling the correct one I got

a49d9c0ae46e (HEAD -> docs-next, tag: docs-4.18, corbet/docs-next) Documentation: document hung_task_panic kernel parameter

I split the patches in between the two drivers to enable use of the
'Fixes:' tag.

One question, is there are standard spacing after headings.  I attempted
to maintain uniformity within each file but this has resulted in the two
files being different.  One has no space after section headings

	section heading
	---------------
	Some text with no newline.

While the other file uses a single newline after section headings.

While on the topic of newlines and headings; is there a correct number
of newlines to have _before_ a heading?

I did not find this information when looking at
Documentation/doc-guide/sphinx.rst

If there is a ruling on these newlines I can re-spin this set with an
added patch to fix all the newlines in both e1000.rst and e100.rst


thanks,
Tobin.


Tobin C. Harding (4):
  Documentation: e100: Use correct heading adornment
  Documentation: e1000: Use correct heading adornment
  Documentation: e100: Fix docs build error
  Documentation: e1000: Fix docs build error

 Documentation/networking/e100.rst  | 112 +++++++++++++++--------------
 Documentation/networking/e1000.rst |  76 ++++++++++----------
 2 files changed, 96 insertions(+), 92 deletions(-)

-- 
2.17.1

