Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J0J/KLaeG1sDWAAAmS7hNA
	; Sat, 09 Jun 2018 09:52:08 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D46C2607BB; Sat,  9 Jun 2018 09:52:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B5C1C606FA;
	Sat,  9 Jun 2018 09:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5C1C606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753220AbeFIJwE (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 05:52:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:28350 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751757AbeFIJwC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 05:52:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jun 2018 02:52:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,494,1520924400";
   d="scan'208";a="236009055"
Received: from cphenegh-mobl1.ger.corp.intel.com (HELO caravaggio) ([10.252.11.168])
  by fmsmga006.fm.intel.com with ESMTP; 09 Jun 2018 02:51:50 -0700
Date: Sat, 9 Jun 2018 11:51:46 +0200
From: Samuel Ortiz <sameo@linux.intel.com>
To: Amit Pundir <amit.pundir@linaro.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        linux-wireless@vger.kernel.org,
        Suren Baghdasaryan <surenb@google.com>,
        Christophe Ricard <christophe.ricard@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Dmitry Shmidt <dimitrysh@google.com>,
        Todd Kjos <tkjos@google.com>,
        Android Kernel Team <kernel-team@android.com>,
        Stable <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] NFC: st21nfca: Fix out of bounds kernel access
 when handling ATR_REQ
Message-ID: <20180609095146.GA25115@caravaggio.jf.intel.com>
References: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525372736-25094-1-git-send-email-amit.pundir@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Amit,

On Fri, May 04, 2018 at 12:08:53AM +0530, Amit Pundir wrote:
> From: Suren Baghdasaryan <surenb@google.com>
> 
> Out of bounds kernel accesses in st21nfca's NFC HCI layer
> might happen when handling ATR_REQ events if user-specified
> atr_req->length is bigger than the buffer size. In
> that case memcpy() inside st21nfca_tm_send_atr_res() will
> read extra bytes resulting in OOB read from the kernel heap.
> 
> cc: Stable <stable@vger.kernel.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3..v1:
> Resend. No changes.
> 
>  drivers/nfc/st21nfca/dep.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
All 4 patches applied to nfc-next, thanks.

Cheers,
Samuel.
