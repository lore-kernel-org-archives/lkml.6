Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753205AbeFAQKV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 12:10:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:49754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752998AbeFAQKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 12:10:17 -0400
Date: Fri, 1 Jun 2018 18:09:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Hugo Lefeuvre <hle@owl.eu.com>
Cc: kernelnewbies@kernelnewbies.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: pi433: add rw semaphore fixing concurrency
 issues
Message-ID: <20180601160954.GA4895@kroah.com>
References: <20180601125037.GA2339@hle-laptop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601125037.GA2339@hle-laptop.local>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 08:50:37AM -0400, Hugo Lefeuvre wrote:
> Add a rw semaphore fixing potential NULL pointer dereferences in the
> pi433 driver.

Unless you can measure the performance difference, do not use a rw
semaphore, just use a normal mutex please.  Odds are it will be faster
in the end and take up less space.

So please test, or if you can't test, just use a mutex.

thanks,

greg k-h
