Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6C7ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C3C3208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 04:29:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="KgIfHLN3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rdRKkHq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C3C3208AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbeGQE7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 00:59:55 -0400
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:60907 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbeGQE7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 00:59:55 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id D67A21E8;
        Tue, 17 Jul 2018 00:29:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 17 Jul 2018 00:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=VqDidhvJ1tlXQWprDi3Jgu1kZ+JQClhuoDIC7OrgZ
        Hk=; b=KgIfHLN3dW8OCt6HFjyFTXIH8SRpxqrw5ULYPvjF717T4o/4rPHhg+pQ+
        LrFVjy+yf4Yhwa+EXzMcpbAAXxFvIXtWB2NYOHiRX0/iqP+a5fpCVoSNBBhMWBa8
        NppBRvw9n0QICb+36irwDu2qMnlvk+WgyCed+JuV7DhdWugGpakLjNF6sydlPmL9
        RBGWLQenQpiOjRBpYqZUm3rcaZBfGbY1NeXr71Q2XKo++15feuypfFFPKUzotqC2
        n6E4bQrPR2kJJGBw/J4IehY1lyYGuzT9Z3H7243B925I1f2IvaUUdW3jqNOqhONB
        spYydJfDD8xCVQMlMnm1JKINycNaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=VqDidhvJ1tlXQWprD
        i3Jgu1kZ+JQClhuoDIC7OrgZHk=; b=rdRKkHq1etAcqxfuy2hDdkyBtMZSt5u40
        qZHEtJF1QDzfshxq6bMrW3cklxzAtNw8B3kJf+M96/yd4SDQ8wDK/iixf1ujk/De
        JofGl4hT5ImA4+z+K5w+gsCvM8YUUhoH37i990asRgwXlfl6gad2BKnkx77coMG9
        4lRgpT5PWZkAfqbSUu31IPVEhOtwqqmJvi2rgukHJF4aH5yGkL6RLj/7NXWn7qIU
        0sd1vtfpI7DpBxrDBNwIMi8n6xLcONXJdgCilE+PMw0v25a8pMpCr/NbB3VVJziJ
        QoO9yiHq9ewx8WxgtTyZBNpFKWRcQXQ2T7Wx9mDk2PeQ1azkbVH9g==
X-ME-Proxy: <xmx:nHBNWyKlVxLYQfWWcPC8uRlsP-TSdR_ctnBfjZdE9n8VMUZp2HigSQ>
    <xmx:nHBNW8C4Wi0zXd8h8MzEXkwfX5ylfiTyCHep_s7wQTSpB8IKW55inA>
    <xmx:nHBNW8EvwgHkWGC2_H6CdiPdtx_cbgVGcDTL3W8pOMvIQ-HKsaKAoA>
    <xmx:nHBNWw6THmMhdk-tYEgPXyNl8pnJbchxBpxa15BeJ_yBkSfV4R6fPQ>
    <xmx:nHBNW9LVHJkjOR65Z0xkV-a1VjEkVJ38FdOTeGLsa3e0EkrFYV7atw>
    <xmx:nXBNWxpLfl3WjHaE26IqWFOhz-YX7P6VAfsb5FeetQSBARyZFW_z2Q>
X-ME-Sender: <xms:nHBNW-u7Dr9EJy-0Z0Y6cQct2B_qV4t5n4I41gBoFu8NVoI9czoXZA>
Received: from localhost (ppp121-44-239-37.bras2.syd2.internode.on.net [121.44.239.37])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2C636E405D;
        Tue, 17 Jul 2018 00:29:15 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/3] docs: Convert alias and bridge to rst
Date:   Tue, 17 Jul 2018 14:29:03 +1000
Message-Id: <20180717042906.17308-1-me@tobin.cc>
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


Tobin C. Harding (3):
  docs: networking: Fix indices heading indentation
  docs: networking: Convert alias.txt to rst
  docs: networking: Convert bridge.txt to rst

 Documentation/networking/00-INDEX             |  2 -
 Documentation/networking/alias.rst            | 49 +++++++++++++++++++
 Documentation/networking/alias.txt            | 40 ---------------
 .../networking/{bridge.txt => bridge.rst}     |  6 +++
 Documentation/networking/index.rst            |  6 ++-
 5 files changed, 59 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/networking/alias.rst
 delete mode 100644 Documentation/networking/alias.txt
 rename Documentation/networking/{bridge.txt => bridge.rst} (85%)

-- 
2.17.1

