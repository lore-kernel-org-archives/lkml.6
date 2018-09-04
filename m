Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AF2C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF0A320661
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:40:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0A320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbeIDMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 08:04:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:25004 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726108AbeIDMEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 08:04:30 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 00:40:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,328,1531810800"; 
   d="scan'208";a="86956711"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 04 Sep 2018 00:40:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 04 Sep 2018 10:40:34 +0300
Date:   Tue, 4 Sep 2018 10:40:34 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] linux/mod_devicetable.h: fix kernel-doc missing notation
 for typec_device_id
Message-ID: <20180904074034.GG15112@kuha.fi.intel.com>
References: <ab0e079b-0160-8d67-3aa9-0205372df3ca@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab0e079b-0160-8d67-3aa9-0205372df3ca@infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2018 at 12:51:59PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix kernel-doc warning for missing struct member description:
> 
> ../include/linux/mod_devicetable.h:763: warning: Function parameter or member 'driver_data' not described in 'typec_device_id'
> 
> Fixes: 8a37d87d72f0c ("usb: typec: Bus type for alternate modes")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  include/linux/mod_devicetable.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-419-rc2.orig/include/linux/mod_devicetable.h
> +++ lnx-419-rc2/include/linux/mod_devicetable.h
> @@ -754,6 +754,7 @@ struct tb_service_id {
>   * struct typec_device_id - USB Type-C alternate mode identifiers
>   * @svid: Standard or Vendor ID
>   * @mode: Mode index
> + * @driver_data: Driver specific data
>   */
>  struct typec_device_id {
>  	__u16 svid;
> 

Thanks,

-- 
heikki
