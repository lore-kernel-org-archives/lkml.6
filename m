Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9A6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 921C72086C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbeLQSbO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:31:14 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:53993 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726891AbeLQSbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 13:31:14 -0500
Received: from p4fea4820.dip0.t-ipconnect.de ([79.234.72.32] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gYxfb-000730-6Q; Mon, 17 Dec 2018 19:31:11 +0100
Date:   Mon, 17 Dec 2018 19:31:06 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
        keescook@chromium.org, bhe@redhat.com, msys.mizuma@gmail.com,
        indou.takao@jp.fujitsu.com, caoj.fnst@cn.fujitsu.com
Subject: Re: [PATCH v14 1/5] x86/boot: Introduce get_acpi_rsdp() to parse
 RSDP in cmdline from KEXEC
In-Reply-To: <20181217172510.GA90818@gmail.com>
Message-ID: <alpine.DEB.2.21.1812171930280.1660@nanos.tec.linutronix.de>
References: <20181214093013.13370-1-fanc.fnst@cn.fujitsu.com> <20181214093013.13370-2-fanc.fnst@cn.fujitsu.com> <20181217172510.GA90818@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018, Ingo Molnar wrote:
> * Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> > +		val[len] = '\0';
> > +		return (acpi_physical_address)simple_strtoull(val, &e, 16);
> 
> 'return' is not a function - no need for the parenthesis.

It's a typecast which better has parenthesis....



