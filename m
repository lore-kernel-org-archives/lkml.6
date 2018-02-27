Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeB0NaY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 08:30:24 -0500
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:9992 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753063AbeB0NaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 08:30:23 -0500
X-IronPort-AV: E=Sophos;i="5.47,401,1515452400";
   d="scan'208";a="315487164"
Date: Tue, 27 Feb 2018 14:30:19 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Lukas Wunner <lukas@wunner.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: test case against union aliasing
In-Reply-To: <1519730441.10722.216.camel@linux.intel.com>
Message-ID: <alpine.DEB.2.20.1802271429140.18318@hadrien>
References: <1519730441.10722.216.camel@linux.intel.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 Feb 2018, Andy Shevchenko wrote:

> Hi!
>
> It seems we have some code in kernel which utilizes (rightlessly for
> now) union aliasing.
>
> So, can we create a test case against such? (Three steps: a) replace
> union by struct keyword in data type in question, b) compile, c) run in
> Qemu with proper functional test)
>
> Does it make any sense?

I think so.  If you want to do it more safely than with sed, it should be
possible with Coccinelle, with just

@@
identifier i;
@@

-union i
+struct i

julia
