Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42EE9C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E446B20652
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E446B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbeIDMCd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:02:33 -0400
Received: from mga06.intel.com ([134.134.136.31]:65258 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725992AbeIDMCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:02:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="86956350"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 04 Sep 2018 00:38:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 04 Sep 2018 10:38:37 +0300
Date:   Tue, 4 Sep 2018 10:38:37 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] usb/typec: fix kernel-doc notation warning for
 typec_match_altmode
Message-ID: <20180904073837.GF15112@kuha.fi.intel.com>
References: <ca3906a0-fbb0-1afb-d619-d8b013c1d0b1@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca3906a0-fbb0-1afb-d619-d8b013c1d0b1@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:58:35PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning for missing function parameter 'mode' description:
> 
> ../drivers/usb/typec/bus.c:268: warning: Function parameter or member 'mode' not described in 'typec_match_altmode'
> 
> Also fix typos for same function documentation.
> 
> Fixes: 8a37d87d72f0 ("usb: typec: Bus type for alternate modes")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/bus.c |    7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> --- lnx-419-rc2.orig/drivers/usb/typec/bus.c
> +++ lnx-419-rc2/drivers/usb/typec/bus.c
> @@ -255,12 +255,13 @@ EXPORT_SYMBOL_GPL(typec_altmode_unregist
>  /* API for the port drivers */
>  
>  /**
> - * typec_match_altmode - Match SVID to an array of alternate modes
> + * typec_match_altmode - Match SVID and mode to an array of alternate modes
>   * @altmodes: Array of alternate modes
> - * @n: Number of elements in the array, or -1 for NULL termiated arrays
> + * @n: Number of elements in the array, or -1 for NULL terminated arrays
>   * @svid: Standard or Vendor ID to match with
> + * @mode: Mode to match with
>   *
> - * Return pointer to an alternate mode with SVID mathing @svid, or NULL when no
> + * Return pointer to an alternate mode with SVID matching @svid, or NULL when no
>   * match is found.
>   */
>  struct typec_altmode *typec_match_altmode(struct typec_altmode **altmodes,

-- 
heikki
