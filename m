Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7995EC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B92520866
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="IkKwRXJk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1jMSsO8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B92520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tobin.cc
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727644AbeILMye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:54:34 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52353 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726358AbeILMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:54:34 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0439521B7C;
        Wed, 12 Sep 2018 03:51:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 12 Sep 2018 03:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=cc
        :date:from:message-id:subject:to:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=EbFxh7QMr2SYeea3AEngV6vwWr+hhDemuLT9H1h/6
        E8=; b=IkKwRXJkkA0sKY5Yo6Fn7ix/DKFUIEgU+kp4861vQDmedomT2fIsnNCjs
        eIT0Ru+ei+GL8WphE6ZEJ8+YFFNgbvEMM0aKTkFca9sO/ADVT7x73CzZ1dgAht8m
        5P88Pl/qHkzo/M790IuGwnGwaW27lpFqPk8d8KNS5FJ8QVDQhp7rmKHRjqly3N5Y
        d9UJX1SDJxztLNf0tY0FX2z7G+pW2oPxpwSab6x2fMcMA6SZBnlMH+fO5T0lCyF5
        l2tX8f/2+v3GvBZ78FYO8PF6GjaD+zcQMp2WrFXp/sReVKKMerZPo/SiOi6YoSot
        2+bJQ4jrNNO1AzAEnTwXlp/4WXbcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:message-id:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=EbFxh7QMr2SYeea3A
        EngV6vwWr+hhDemuLT9H1h/6E8=; b=D1jMSsO83hADT8yNasgXS8ppIyOZeE5Az
        Pgs8DbuPB7ih7254pV4eZGAqpQboTofGHn8fDSjBu7IGEZzNNGSuHJHbImD6JNQK
        88KbHGoihiiPh9UFwD9OwCjNpMIs+X5CrVc0GwcxQP7F99giZQCt2SuVdi9/1w5Q
        zBgD9PNGe1Wv7/9ezx/6bVVsm1HdSSUvVKpCElM2rMHh4lpsbgEhkDl0Smqe4pcs
        VLNZqudN92nCXMqafrm1tYvtSvHIHjv/53kkV/B17mWl3Df5wVHBL1vjqW0wyGBf
        2j5ETTwldRwXaBzkXamDPGx4vfOVd4K7cJL9Slr7eYQQIQXQCkLOw==
X-ME-Proxy: <xmx:c8WYW4ehPRqo0jO0U3TgaEDwAVs0KJ3Mmfd8nFEwakYBhg_bqNvSsA>
    <xmx:c8WYWx4pwuxGYe8RIDUNY7hMvJg-PcoqCdCo_s66xdNMgTcbLXNYRg>
    <xmx:c8WYWztiVyetnhAKsKsqJl7RKajBkC5gfOpoAQRJH-0lIF6TxWra3A>
    <xmx:c8WYW9LYZC3xZ2FECZ-t0lIS8DOU4SDEX7drOk5mn9mmGN8F1YovTA>
    <xmx:c8WYWyBvuLdfx44GURJmujSpkTV9TX1Y4rSdDz94m8FCz91i9EnjIw>
    <xmx:c8WYW5RAy5szt_lw9vtmF3dw_DximpscAvqfNBih2dVrhLP_voDBEg>
X-ME-Sender: <xms:c8WYW4cKTlDOOBHp6Tccr7H9ukR9t4E9WXT_kgq-doVPS7fEtYM60Q>
Received: from localhost (ppp121-44-246-110.bras2.syd2.internode.on.net [121.44.246.110])
        by mail.messagingengine.com (Postfix) with ESMTPA id C4321E46B6;
        Wed, 12 Sep 2018 03:51:14 -0400 (EDT)
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Cc:     "Tobin C. Harding" <me@tobin.cc>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH 0/3] ttp_port: Clean up kernel-docs
Date:   Wed, 12 Sep 2018 17:50:41 +1000
Message-Id: <20180912075044.8695-1-me@tobin.cc>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This set is just putting a toe in the water to see if kernel-docs
cleanup is wanted in drivers/tty/

While chasing syzkaller bugs I opened up drivers/tty/tty_port.c and
noticed that a bunch of the kernel-docs function comments were
incorrectly styled.  This is the case for more files under drivers/tty/,
if fixing this is deemed worthwhile I can add it to my list of jobs to
do when my brain is too fried to do anything else.

Changes comments that look like this:

/**
 *	ptmx_open		-	open a unix 98 pty master
 *	@inode: inode of device file
 *	@filp: file pointer to tty
 *
 *	Allocate a unix98 pty master device from the ptmx driver.
 *
 *	Locking: tty_mutex protects the init_dev work. tty->count should
 *		protect the rest.
 *		allocated_ptys_lock handles the list of free pty numbers
 */

static int ptmx_open(struct inode *inode, struct file *filp)

To look like this:

/**
 * ptmx_open() - Open a unix 98 pty master.
 * @inode: inode of device file
 * @filp: file pointer to tty
 *
 * Allocate a unix98 pty master device from the ptmx driver.
 *
 * Locking: tty_mutex protects the init_dev work. tty->count should
 * 	protect the rest.
 * 	allocated_ptys_lock handles the list of free pty numbers
 */
static int ptmx_open(struct inode *inode, struct file *filp)

This is super trivial clean up - I will not be offended if this is
deemed code churn.

thanks,
Tobin.


Tobin C. Harding (3):
  tty_port: Remove incorrect whitespace after comments
  tty_port: Fix function name and brief desc
  tty_port: Fix kernel-docs warnings

 drivers/tty/tty_port.c | 133 ++++++++++++++++++++---------------------
 1 file changed, 65 insertions(+), 68 deletions(-)

-- 
2.17.1

