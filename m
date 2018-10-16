Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D29C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0236208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 18:06:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0236208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeJQB6f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:58:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43998 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbeJQB6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:58:34 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gCTk3-0002rq-3A; Tue, 16 Oct 2018 18:06:51 +0000
Date:   Tue, 16 Oct 2018 19:06:51 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Alessandro Rubini <rubini@gnudd.com>
Cc:     uwe@kleine-koenig.org, gregkh@linuxfoundation.org, corbet@lwn.net,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        Michal.Vokac@ysoft.com, akpm@linux-foundation.org,
        kernel@pengutronix.de
Subject: Re: [PATCH RFC] err.h: document that PTR_ERR should only be used if
 IS_ERR returns true
Message-ID: <20181016180650.GZ32577@ZenIV.linux.org.uk>
References: <20181014202807.16412-1-uwe@kleine-koenig.org>
 <20181015093708.GA22876@mail.gnudd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015093708.GA22876@mail.gnudd.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 11:37:08AM +0200, Alessandro Rubini wrote:

> OTOH I admit you can compare any value with -EINVAL, after PTR_ERR.
> But in general you first detect the error condition and then split
> among error (or print a message according to the exact value.

	if (IS_ERR(p) && PTR_ERR(p) == -ENOENT)
instead of
	if (p == ERR_PTR(-ENOENT))

is ugly, obfuscating what's going on for no good reason and I'm going
to keep killing those every time I run into one...
