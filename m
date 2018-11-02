Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A0DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 910532081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 13:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 910532081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbeKBWfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 18:35:13 -0400
Received: from mga17.intel.com ([192.55.52.151]:32457 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726026AbeKBWfN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 18:35:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Nov 2018 06:28:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,456,1534834800"; 
   d="scan'208";a="104738260"
Received: from kuha.fi.intel.com ([10.237.72.189])
  by fmsmga001.fm.intel.com with SMTP; 02 Nov 2018 06:27:59 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 02 Nov 2018 15:27:58 +0200
Date:   Fri, 2 Nov 2018 15:27:58 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andrzej Hajda <a.hajda@samsung.com>, Li Jun <jun.li@nxp.com>,
        linux@roeck-us.net, jackp@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: connector: Add self-powered property
Message-ID: <20181102132758.GA6543@kuha.fi.intel.com>
References: <20181001194501.58338-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181001194501.58338-1-badhri@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 01, 2018 at 12:44:59PM -0700, Badhri Jagan Sridharan wrote:
> >From USB_PD_R3_0
> 7.1.5 Response to Hard Resets
> Device operation during and after a Hard Reset is defined as follows:
> Self-powered devices Should Not disconnect from USB during a Hard Reset
> (see Section 9.1.2).
> Bus powered devices will disconnect from USB during a Hard Reset due to the
> loss of their power source.
> 
> Therefore it is necessary to know whether the port belongs to
> a device which is self powered or bus powered. This change
> adds "self-powered" flag to the connector class which present indicates
> that the port belongs to a device that is self powered. Else it is
> bus powered usb device.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Rob, I can see you acked one of the patches modifying tcpm.c in this
series, but did you mean to put the tag to this patch instead?

FWIW:

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> -------
> Changes is v3:
> - Rebase on top of usb-next
> - no change w.r.t to this patch. Same as previous versions.
> 
> No v2 version as the patch was introduced there.
> 
> ---
>  Documentation/devicetree/bindings/connector/usb-connector.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/usb-connector.txt b/Documentation/devicetree/bindings/connector/usb-connector.txt
> index d90e17e2428b..a9a2f2fc44f2 100644
> --- a/Documentation/devicetree/bindings/connector/usb-connector.txt
> +++ b/Documentation/devicetree/bindings/connector/usb-connector.txt
> @@ -14,6 +14,8 @@ Optional properties:
>  - label: symbolic name for the connector,
>  - type: size of the connector, should be specified in case of USB-A, USB-B
>    non-fullsize connectors: "mini", "micro".
> +- self-powered: Set this property if the usb device that has its own power
> +  source.
>  
>  Optional properties for usb-c-connector:
>  - power-role: should be one of "source", "sink" or "dual"(DRP) if typec
> -- 
> 2.19.0.605.g01d371f741-goog

thanks,

-- 
heikki
