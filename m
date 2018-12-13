Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC52C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1928C20851
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 01:29:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="DyV/g5hK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D09JrtCD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1928C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbeLMB3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 20:29:02 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52917 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726389AbeLMB3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 20:29:01 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 638DE21D1F;
        Wed, 12 Dec 2018 20:29:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 12 Dec 2018 20:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm1; bh=dIUh13lYPQIfsr9WWU+WLNqsvGL+AqcrkOrdWZFICLE=; b=DyV/g5hK
        glLP60ZKuNu5eQnDpiA5gfQfxWI/R2qysTUVuI6X/hikcYONV9eyg/8+BBHZloAj
        lDMk5U7Sv8eeo8mxGsp3fLfzFzgS81BlxdonjkCy1hLMRawpH0qzgeH1+iJJD5XI
        UjOLrh7pzz3o+57e2p1dp/G7zg6XLx92r72cwhrin0iiZckCnt/bN2GJps/LPosw
        9IM7OqYvZYZubgbGmWskWzRZp9wCWgwrfINLiRINjI0IYc+tjb9tkaTjLS+qHsDG
        7lFCk58NVF3mrx3hvx5SfRJ76h6AWp0K52fD22NVcRSVIDgzRoytVNPmHEfY9U0q
        L3NhJErj69/rAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=dIUh13lYPQIfsr9WWU+WLNqsvGL+A
        qcrkOrdWZFICLE=; b=D09JrtCDi/drfgg8mpUv7uKxz9QgGa1ycrgGc8jC9lB8V
        AAjbLmE2PSbCNrOqY56xGzsk/YtyQpD/EOtQNVRJraGob7Y5XKc3eeqPkbfrbYQu
        Pl4A5abWT92YaDM+JVPODuf/OIxnt4Hu7FqfCnlPuQto9k3f3BltAnyF5Y4dCclH
        ZlDHHvcD3CelcFTPWGpb6lMMx0opFAbJr2TpMBEgCWE7+hAOMhnDCjbwzzMr1pw5
        fJqNlxeNM5BYAr0s3vl4F6fFBkRUKsqz38P7Aw9b0ql9rZKJxTUFofASMAyRr6P3
        5AfOyjYEIiBNL34d4TG35KO/Ie3jdU9Kxiod1LLNQ==
X-ME-Sender: <xms:27URXOuDAaE98QK_D9AMTKZlAlLiBJ9Ccfea7Qn-CIdnkag-d_lytg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudehuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkgg
    gtuggfsehttdertddtredvnecuhfhrohhmpefrvghtvghrucfjuhhtthgvrhgvrhcuoehp
    vghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqnecukfhppeduieejrdduje
    elrdduieeirddvleenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhuthht
    vghrvghrseifhhhoqdhtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:27URXAU_ubf63AFZnLDPhQUuTc0I3UrF74AShGl44iZutsESVR_9Kw>
    <xmx:27URXEKSOLUPEapq63G0844JNbAOpyx5IcoUVoW79u_cmPeZsTOhZg>
    <xmx:27URXIsl0e_aAYaW0xz_LJqBdnCNau5iO_IpMRs2oqrr9Z3DHuta3w>
    <xmx:27URXB1ezGrW3uHyEN4Yj3mPbvF767zHM1xE3uIHuwn6aobVPi80iw>
    <xmx:27URXIOxCUGXRMTQk_TfF3iy7sRFxduYZoymHb3S8RGvGii4ZGKiug>
    <xmx:3LURXALSn2foojwyKGxsWcfIjmEEfoB5Xayo-G4H2-zZkMe8Bxhgqg>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 318E5E446A;
        Wed, 12 Dec 2018 20:28:57 -0500 (EST)
Date:   Thu, 13 Dec 2018 11:28:51 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: hid: fix wrong data structure reference for
 UHID_OUTPUT
Message-ID: <20181213012851.GA25516@jelly>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 Documentation/hid/uhid.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/hid/uhid.txt b/Documentation/hid/uhid.txt
index c8656dd029a9..958fff945304 100644
--- a/Documentation/hid/uhid.txt
+++ b/Documentation/hid/uhid.txt
@@ -160,7 +160,7 @@ them but you should handle them according to your needs.
   UHID_OUTPUT:
   This is sent if the HID device driver wants to send raw data to the I/O
   device on the interrupt channel. You should read the payload and forward it to
-  the device. The payload is of type "struct uhid_data_req".
+  the device. The payload is of type "struct uhid_output_req".
   This may be received even though you haven't received UHID_OPEN, yet.
 
   UHID_GET_REPORT:
-- 
2.19.2

