Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16720ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C509C2075A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="QlJaRhjQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qu1KqOpT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C509C2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726254AbeGREDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:03:33 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:38109 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725721AbeGREDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:03:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5B05D2E8;
        Tue, 17 Jul 2018 23:27:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 23:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=50/uR4Ik6sptR5UglqZ77ufXYpdElsKaC27w+W7kr
        1I=; b=QlJaRhjQXBBXE85wJ2KqehhE1WiB3RfKVAps17JhT0dJZ4dkKpdkO+rxR
        dvARnv0jQ5nEoiTB8IVeF6QZ9ml8+s2OTHgJZBE8SNYIweEdnHv9lp875Rvhp8yQ
        yTGgyuLIPIXUsTfFZ/Fr4tovp33CZNTXNYHr1pcwpTwFAOX4yOy7jFESpOYWq9QT
        cMebu4HUOxGfE+uPGaDCEA/RN0t1OUgsHjY171jslqFPD09z6StWfVEqaw3vHNNO
        Y0qu15NJqcdpnE6/AU5jaYIU/yYZ2iFE793hTAoDW1WaVAJNoCInIqHEgmiealFr
        dCRWo1EVrRWitupAR/YUQi87XtBzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=50/uR4Ik6sptR5Ugl
        qZ77ufXYpdElsKaC27w+W7kr1I=; b=Qu1KqOpTXCrQK7B4VVMsegCCDCOVN6slO
        3Sc59KacWAD8J/rfLc/RjXnYciQSOrjrMPaSCq5SGaxHNkWhcLwqyQ/iCJQWNELI
        Y9/zhJl+LASPT/HneB+1Bag/Q/6JmYxWmdnxwZlftShnhnHi3D2Po21mTTPaY7Zh
        RHBdc7wONVxBNsEKWDz2wJsXQ4Dd86tuHQAULXnJ3OjCGMBiSdPGC24ncqf631yp
        25/nswWPT9v3if5EEU2TdsM1I3AbObvpgtpoh+wBMQH9E2ISALUcsN6+XMFeycvU
        blYB9rF8qj2ltmiP8yeqHdTlTUYj8fTxMx/JrsrqZB8e/I46+QEvg==
X-ME-Proxy: <xmx:tLNOW_FsfnRKExyIvzj3eitCA34ULrN45iPjTNBklyFs51stR3BpGw>
    <xmx:tLNOWxtG8zZIZCD1JHBu9Z00mYkGpDiFKt6AS_wrSX8FIyELYMligg>
    <xmx:tLNOW9kdmdRYmqVuQiB7QLajSTUvhIX3VbUv2EN_nF4pyTlRGMbryw>
    <xmx:tLNOWyM9T-xoBRRc7hfRuZP_5Hsfie2hoJH9dI6yOfJ99iOe6M-Srg>
    <xmx:tLNOW8z4EJS0agShKC7E9t08GkXgLt5VncEVv3bUui6QORoCOXg6AQ>
    <xmx:tLNOWxETt89H2JaaeHkCGFI1fowgXPKbEwR0KEQ12yUNHr1SN5p_cQ>
X-ME-Sender: <xms:tLNOW3bEWFbspl7wLu96cYBQkkLfT8REA1K5mCT5Rgo6O8hB7BkQxg>
Received: from localhost (124-169-0-210.dyn.iinet.net.au [124.169.0.210])
        by mail.messagingengine.com (Postfix) with ESMTPA id D7A4AE465F;
        Tue, 17 Jul 2018 23:27:47 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] docs: Convert alias and bridge to rst
Date:   Wed, 18 Jul 2018 13:27:34 +1000
Message-Id: <20180718032736.8000-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Here is my first attempt at working on converting docs in
Documentation/networking to rst format.  I've picked a couple of trivial
ones to start with.  If there is anything extra I can do to make your
life easier during documentation conversion please say.  (Also if there
is some reason that it would be preferable to _not_ embark on this task
please say :)

This set does not make any changes to the converted files apart from
formatting.

thanks,
Tobin.

v2:
 - remove incorrect patch from set (changing 'Indices' indentation)

Tobin C. Harding (2):
  docs: networking: Convert alias.txt to rst
  docs: networking: Convert bridge.txt to rst

 Documentation/networking/00-INDEX             |  2 -
 Documentation/networking/alias.rst            | 49 +++++++++++++++++++
 Documentation/networking/alias.txt            | 40 ---------------
 .../networking/{bridge.txt => bridge.rst}     |  6 +++
 Documentation/networking/index.rst            |  2 +
 5 files changed, 57 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/networking/alias.rst
 delete mode 100644 Documentation/networking/alias.txt
 rename Documentation/networking/{bridge.txt => bridge.rst} (85%)

-- 
2.17.1

