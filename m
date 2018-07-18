Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22B3ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52E332075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 01:03:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Qut8+Nmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52E332075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731640AbeGRBiE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 21:38:04 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57608 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731096AbeGRBiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 21:38:03 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D9254EDF47;
        Tue, 17 Jul 2018 21:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id; s=sasl; bh=Rbka8ryH74ZZL1F+agpjxcFWEp8
        =; b=Qut8+Nmq4iD6BsVh5LU9uNR7+f5sgKePmjimk3L4J1SMYB0yYuW88xyidwY
        6ZZWXcYuu+l+A1EjgfyM8QL3ugOO/J8gWB/+CX8pSMOq7s8RVen/8Yez9323ikyx
        rITm0nteP6zU+feUARMRQI6wVhX0pS1xyYau2yL/TYB35GZc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFAEDEDF41;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from yoda.home (unknown [70.82.104.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 481B9EDF3E;
        Tue, 17 Jul 2018 21:02:45 -0400 (EDT)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTP id 3A4EC2DA03AA;
        Tue, 17 Jul 2018 21:02:44 -0400 (EDT)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Adam Borowski <kilobyte@angband.pl>,
        Dave Mielke <Dave@mielke.cc>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        linux-kernel@vger.kernel.org, linux-console@vger.kernel.org
Subject: [PATCH 0/3] follow-up to the unicode vt console series
Date:   Tue, 17 Jul 2018 21:02:39 -0400
Message-Id: <20180718010242.5254-1-nicolas.pitre@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Pobox-Relay-ID: 47D36E7C-8A26-11E8-BA1F-063AD72159A7-78420484!pb-smtp1.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a follow-up series with 3 patches in response to the following
messages respectively:

http://lkml.kernel.org/r/20180628123803.GA22045@kroah.com

http://lkml.kernel.org/r/CAGXu5j+KLvJ-n_QRrfq15E8iO_rqfpp+K7PDAZHZMHcemy9y7g@mail.gmail.com

http://lkml.kernel.org/r/CAMuHMdUmC+uiKTEMotB83A86E1wEYrNF2qPf3kDACaW27D_NbA@mail.gmail.com

Those patches were tested on top of previous patches already in tty-next.
Please include in tty-next before next merge window.

Patch #1 was posted before. Only difference is that it now uses rate
limited printing.

Patch #2 is new, however it has been tested with the validation code
provided by patch #1. This also fixes a security issue.

Patch #3 is new and trivial.

Diffstat:

 Documentation/admin-guide/devices.txt | 16 +++++---
 drivers/tty/vt/vt.c                   | 57 +++++++++++++++++++++++++----
 2 files changed, 59 insertions(+), 14 deletions(-)

