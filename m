Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751852AbeFES2s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 14:28:48 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40746 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751769AbeFES2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 14:28:46 -0400
Date: Tue, 05 Jun 2018 14:28:40 -0400 (EDT)
Message-Id: <20180605.142840.2277897500494503602.davem@davemloft.net>
To: tom.hromatka@oracle.com
Cc: sparclinux@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, allen.pais@oracle.com,
        khalid.aziz@oracle.com, shannon.nelson@oracle.com,
        anthony.yznaga@oracle.com
Subject: Re: [PATCH v6 0/2] sparc64: Add privileged ADI driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180426165409.716764-1-tom.hromatka@oracle.com>
References: <20180426165409.716764-1-tom.hromatka@oracle.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Hromatka <tom.hromatka@oracle.com>
Date: Thu, 26 Apr 2018 10:54:07 -0600

> ADI is a feature supported on SPARC M7 and newer processors to allow
> hardware to catch rogue accesses to memory. ADI is supported for data
> fetches only and not instruction fetches. An app can enable ADI on its
> data pages, set version tags on them and use versioned addresses to
> access the data pages. Upper bits of the address contain the version
> tag. On M7 processors, upper four bits (bits 63-60) contain the version
> tag. If a rogue app attempts to access ADI enabled data pages, its
> access is blocked and processor generates an exception. Please see
> Documentation/sparc/adi.txt for further details.
> 
> This patchset implements a char driver to read/write ADI versions from
> privileged user space processes.  Intended consumers are makedumpfile
> and crash.

Series applied, but there is one thing I am not happy with.

The hard coded ADI block size.

This value is at least theoretically dynamic, and that is why
it is passed into userspace programs via the ELF AUX vector
at exec() time.

So they should really fetch it from there.
