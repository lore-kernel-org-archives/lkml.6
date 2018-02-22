Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751406AbeBVVgg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:36:36 -0500
Received: from mail02.prevas.se ([62.95.78.10]:57890 "EHLO mail02.prevas.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751312AbeBVVgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:36:35 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HaAAD/No9a/2h+ugUNUBsBAQEBAwEBA?=
 =?us-ascii?q?QkBAQGJNZlxCyeBFpZiggIKhTQCgwYUAQIBAQEBAQECA4Y1AQEBAgEjVhALGgI?=
 =?us-ascii?q?mAgJXBgEMCAEBiherCW6CJ4h2ghkBAQEBAQEBAQIBAQEBASOBD4QKg36CEAyCe?=
 =?us-ascii?q?YULgy+CZQWkPwmCTpNAAoIFkj2YKoE8NoF0TXKCRIMIgW6NXwEBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HaAAD/No9a/2h+ugUNUBsBAQEBAwEBAQkBAQGJNZlxCye?=
 =?us-ascii?q?BFpZiggIKhTQCgwYUAQIBAQEBAQECA4Y1AQEBAgEjVhALGgImAgJXBgEMCAEBi?=
 =?us-ascii?q?herCW6CJ4h2ghkBAQEBAQEBAQIBAQEBASOBD4QKg36CEAyCeYULgy+CZQWkPwm?=
 =?us-ascii?q?CTpNAAoIFkj2YKoE8NoF0TXKCRIMIgW6NXwEBAQ?=
X-IronPort-AV: E=Sophos;i="5.47,378,1515452400";
   d="scan'208";a="3113785"
Subject: Re: [PATCH v3] kconfig.h: Include compiler types to avoid missed
 struct attributes
From: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To: Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>
Cc: Patrick McLean <chutzpah@gentoo.org>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180222174140.GA3154@beast>
 <CA+55aFxDh-69p0Lr52icct6-3PGcsHaZmMqHwks8HptdmdxvTg@mail.gmail.com>
 <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
Message-ID: <21797175-11f5-d87e-bc3e-35ca3547627f@prevas.dk>
Date: Thu, 22 Feb 2018 22:34:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <66556bf7-3e67-5793-081e-76a01f598374@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-02-22 22:07, Rasmus Villemoes wrote:

> 
> The whole point of fixdep and the include/config hierarchy is to be able
> to remove the dependency on autoconf.h, but I'm not sure I understand
> why kconfig.h itself is also forcibly removed.

<goes digging> Ah, 6a5be57f "fixdep: fix extraneous dependencies", to
work around kconfig.h (naturally) containing the CONFIG_ pattern a few
times. Hm, we should probably make sure that kconfig.h is always on the
dependency list in .o.cmd, but just exclude it from being processed for
the CONFIG_ pattern.

Rasmus
