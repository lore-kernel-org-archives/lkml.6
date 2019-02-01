Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74243C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E70F218A6
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfBAKEh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:37 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:46748 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728919AbfBAKEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:36 -0500
Received: from 79.184.255.169.ipv4.supernova.orange.pl (79.184.255.169) (HELO aspire.rjw.lan)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.183)
 id 4c7866c4c9dfd405; Fri, 1 Feb 2019 11:04:34 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     Erik Schmauss <erik.schmauss@intel.com>,
        Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/5] ACPI: EC: Simplify boot EC setup
Date:   Fri, 01 Feb 2019 10:56:04 +0100
Message-ID: <2804781.zocuRj5ZkX@aspire.rjw.lan>
In-Reply-To: <2897234.rJkq6cDEjt@aspire.rjw.lan>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On Tuesday, January 22, 2019 12:55:18 PM CET Rafael J. Wysocki wrote:
> Hi All,
> 
> The setup of the boot EC is unnecessarily tangled now, so untangle it to
> make the code flow in there easier to follow.
> 
> The only intentional functional impact of this series should be changes
> in messages printed to the kernel log.
> 
> The patches are on top of https://patchwork.kernel.org/patch/10773757/

This v2 is here, because the first patch in the previous version contained
too bugs that were overlooked, because it attempted to do too much in one
go.  So this time use smaller patches and add one to make boot_ec static
(which it should be).

Thanks,
Rafael

