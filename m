Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA37C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C0ED20685
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 05:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="a3h4VEQK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tZBQKqij"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0ED20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeGZGP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 02:15:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41121 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725903AbeGZGP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 02:15:59 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 78BCE21FE4;
        Thu, 26 Jul 2018 01:00:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 26 Jul 2018 01:00:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=YgNhRQCahx4NZfLqWiZpaVMOBiS+IZpdByUxgEHqy
        L8=; b=a3h4VEQKrQkck1id+3iIb8UjtIPxLH5twbfsGi802CVxIcvD3raxcEW1X
        0dfyfVU6e70JPxHcjeAusJ1SZA+sDHEr//RPl4fo8DX3pYLsTqbMl/I2jNqiwytz
        smGOUID+VGSsd5QF5ygNxB/Tgg8uu9pe7hkHtyA0blO3yUOOJeymw+VdIpiQk3Y5
        xBnT2ru5z65sH0wIgLtK+Lg39ELRjjPRIVArZXYH7scx/kI4v9KN+WZrMVekYKY1
        uIHcedJrbcLCSEyyr4h3YF/v6kroyn0W80ZUF02esInGwzt27Ayz1JuCEmqRRRxw
        O2Qw68w0wchLRfiLeukoq53qkDXOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=YgNhRQCahx4NZfLqW
        iZpaVMOBiS+IZpdByUxgEHqyL8=; b=tZBQKqijQpXy2hBUTg4PEuAlG7/DXeV3H
        peht+aVvZXi0xjk6s3bpdb/vmRBvt+MAN9Ew8au3AI9S/+cloN08kkyTLnEfsbjk
        nHetsbHOzMNZBr6PQln2idGkcKQUEvNSVsvb2xto7UC1VAiFzWSfq0DMsjzUoos5
        fQf0wl72lRk4KBIkXPQgjGxXL3eVWjq5v6pJJQNCSNgG98i1n2PTai/FTQnze3iE
        jhPx89znaGRK/dGD9g8PCnt4R3eIyuhoFFA5E2xXAg/urxdsiiE5n2sfpDbsbE8V
        fiRFKYztnhSOPeOfCPRIkqLeii3/zo7yoEVDBR04YOqMYfpn+mPqg==
X-ME-Proxy: <xmx:h1VZWxYdGlVXqcZegE5n2A_NvNm9bXBCyG94DJ0ZNcLHBUF5IbfMQw>
    <xmx:h1VZW9XbFKRZRBKdxRXTPNEUndYojk3LssFrHaHiEctKBKGkSjsXTg>
    <xmx:iFVZW4MnP3ri8Kvgvjr85_qFRMxfv4VZr_QF4s6aP_88xlSeaPt1Vg>
    <xmx:iFVZW_Y6yeKYgahj7PrQwzL8bdQYli4-jHwxtqjGJPwo9OEzLfZYgg>
    <xmx:iFVZW_8adtJab9sbiQiDMelAWfGxjuGs2Gnom6CPIF0m_jHHhONjWQ>
    <xmx:iFVZW-EWIxqaT9Jl78k1JivmUEmbyBtCKag0HPEDozx03r28nERp8w>
X-ME-Sender: <xms:h1VZW3eF79H2JWSmpYlTkwRx4KLWGsLYtH_vA6UFVtCfXGR9GIjNhg>
Received: from localhost (ppp121-44-239-245.bras2.syd2.internode.on.net [121.44.239.245])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E7D21026B;
        Thu, 26 Jul 2018 01:00:55 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     "Tobin C. Harding" <me@tobin.cc>, Jonathan Corbet <corbet@lwn.net>,
        Edward Cree <ecree@solarflare.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        linux-doc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net-next 0/3] docs: net: Convert netdev-FAQ to RST
Date:   Thu, 26 Jul 2018 15:00:28 +1000
Message-Id: <20180726050031.1697-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

Jon answered all the tree questions on v1 so if you will please take
this through your tree that would be awesome.

v2:
 - Fix typo 'canonical_path_format' (thanks Edward) 
 - Add patch fixing references netdev-FAQ

thanks,
Tobin.


Tobin C. Harding (3):
  docs: Add rest label the_canonical_patch_format
  docs: net: Convert netdev-FAQ to restructured text
  docs: Update references to netdev-FAQ

 Documentation/bpf/bpf_devel_QA.rst            |  21 +-
 Documentation/networking/00-INDEX             |   2 -
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/netdev-FAQ.rst       | 259 ++++++++++++++++++
 Documentation/networking/netdev-FAQ.txt       | 244 -----------------
 Documentation/process/stable-kernel-rules.rst |   2 +-
 Documentation/process/submitting-patches.rst  |   1 +
 7 files changed, 271 insertions(+), 259 deletions(-)
 create mode 100644 Documentation/networking/netdev-FAQ.rst
 delete mode 100644 Documentation/networking/netdev-FAQ.txt

-- 
2.17.1

