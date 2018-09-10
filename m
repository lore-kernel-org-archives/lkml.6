Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CBBC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE61520855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE61520855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbeIJSoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:44:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:48451 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728174AbeIJSoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:44:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 06:50:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="88719916"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 10 Sep 2018 06:49:55 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 10 Sep 2018 16:49:54 +0300
Date:   Mon, 10 Sep 2018 16:49:54 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Angus Ainslie <angus@akkea.ca>
Cc:     groeck7@gmail.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: get the vbus source and charge values
 from  the devicetree
Message-ID: <20180910134954.GA22723@kuha.fi.intel.com>
References: <20180906192644.24587-1-angus@akkea.ca>
 <20180909180531.28092-1-angus@akkea.ca>
 <20180910073529.GL25121@kuha.fi.intel.com>
 <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18a1f08b114adb65baf55f202a28d85e@www.akkea.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angus,

On Mon, Sep 10, 2018 at 07:11:43AM -0600, Angus Ainslie wrote:
> They are tcpm specific but need to go into the connector sub-node to get
> parsed correctly. Would something like below be better ?
> 
> diff --git a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> index 0dd1469e7318..ae0a3e97d9b6 100644
> --- a/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> +++ b/Documentation/devicetree/bindings/usb/typec-tcpci.txt
> @@ -15,6 +15,12 @@ Required sub-node:
>    of connector node are specified in
>    Documentation/devicetree/bindings/connector/usb-connector.txt
> 
> +Optional properties for usb-c-connector sub-node:
> +- init-vbus-source: set the initalization value for vbus-source to true.
> +  If this property is not present the initial value will be false.
> +- init-vbus-charge: set the initalization value for vbus-charge to true.
> +  If this property is not present the initial value will be false.

In that file those are fine.

I would prefer init-vbus-sink over init-vbus-charge, but it's up to
you.


Thanks,

-- 
heikki
