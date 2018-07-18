Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83DE5ECDFAA
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 377C52084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377C52084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbeGREZo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 00:25:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46344 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbeGREZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 00:25:44 -0400
Received: from localhost.localdomain (c-24-4-125-7.hsd1.ca.comcast.net [24.4.125.7])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D66F22D;
        Wed, 18 Jul 2018 03:49:55 +0000 (UTC)
Date:   Tue, 17 Jul 2018 20:49:54 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     gregkh@linuxfoundation.org, jic23@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        fabrice.gasnier@st.com, benjamin.gaignard@st.com,
        robh+dt@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, mark.rutland@arm.com
Subject: Re: [PATCH v7 01/10] counter: Introduce the Generic Counter
 interface
Message-Id: <20180717204954.4b5e371603d0b40b2aaabbb8@linux-foundation.org>
In-Reply-To: <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
References: <cover.1529607879.git.vilhelm.gray@gmail.com>
        <51b75b2b4495d4ad7ed173d91a726379bdae2353.1529607879.git.vilhelm.gray@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jun 2018 17:07:08 -0400 William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch introduces the Generic Counter interface for supporting
> counter devices.
> 

+EXPORT_SYMBOL(count_direction_str);
+EXPORT_SYMBOL(count_mode_str);
+EXPORT_SYMBOL(counter_signal_enum_read);
+EXPORT_SYMBOL(counter_signal_enum_write);
+EXPORT_SYMBOL(counter_signal_enum_available_read);
+EXPORT_SYMBOL(counter_count_enum_read);
+EXPORT_SYMBOL(counter_count_enum_write);
+EXPORT_SYMBOL(counter_count_enum_available_read);
+EXPORT_SYMBOL(counter_device_enum_read);
+EXPORT_SYMBOL(counter_device_enum_write);
+EXPORT_SYMBOL(counter_device_enum_available_read);
+EXPORT_SYMBOL(signal_read_value_set);
+EXPORT_SYMBOL(count_read_value_set);
+EXPORT_SYMBOL(count_write_value_get);
+EXPORT_SYMBOL(counter_register);
+EXPORT_SYMBOL(counter_unregister);
+EXPORT_SYMBOL(devm_counter_register);
+EXPORT_SYMBOL(devm_counter_unregister);

The naming is a bit chaotic.  Most of the symbols start with counter_,
which is good.  But a handful do not.

Also, symbols called signal_* make my head spin - Linux already has a
firmly ingrained notion of what a signal is, and this ain't it ;)
Although the kernel tends to use sig_ for signals-as-an-IPC-thing.

Also, many many drivers deal with signals-as-an-electrical-thing - is
it appropriate for this particular driver to take that namespace?

