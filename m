Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-420878-1519830986-5-924102833831175127
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519830986; b=JOen1IIh66Ac7+fjaiOtKdSFKlNZmc4KyfMtFTfFOYV+SiW
    d911oue7jgtdc7T4wLAWKCSFL8fTxPf2K8E0Ru4T88oAHrHmEDr0pWqLl0zofNYD
    Mzzih1GlxWupkdKjoQe31CDJm5EtJ88sJ8/3ozsE5dzjmcWR6F3prJoKCklH9+6Z
    xKc9m7uyYsluUzjkDNQWs1es4gv2Ol4I7lp09/8vLK3MxJKaZz3OsspeqJW03qNA
    AdMChseKe82pzFbunOkHEr3SBHGJF6Vf/hi4WKS0CgcH/KsQ7Hdz+/0Y88+KxNp8
    3L6ExAY+H6JhfOh8J5OlqjzXcH9QrF1QZXR9Lsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519830986; bh=VJHfO1EJa+o//modS8hrbkdEVF
    GZ3KcV9hDUcnyjXVc=; b=lsU3bMrwL2dBZPqnpWqCddTCOnMEa8w0vieksAuh/A
    /SoZ7KMcrW6Si5YG88l7RSODhKrLUIxWO9ZjqKFiJZfA+x83nDqiAk9PBkJiAO3X
    i0nGkoukkc6LpZ2KDrcC57O/Rd4UnJAYEwRFtxi0JPBzeqsLAPhfWb4kGVdV94EB
    G9keErR3x1IO2rC6IriZyrT1qourgxiO3YSPF7vDgruS+Y2X9buW8XTDbryIM4MR
    1kvUR+OlKQbN/MdLJPptgeK6xQif5SQUCFuTMyQ5V/Yc1Yv7IJGCou/8xe6GyMyT
    ub5ob3PHjDVLvPtdRjcjvIIKJcYFC0Y5CBcrYNzoyPIQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932241AbeB1PQF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 10:16:05 -0500
Received: from mga04.intel.com ([192.55.52.120]:4945 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932146AbeB1PQE (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 28 Feb 2018 10:16:04 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,406,1515484800";
   d="scan'208";a="34321733"
Date: Wed, 28 Feb 2018 17:15:52 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Hans de Goede <hdegoede@redhat.com>
Cc: Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v5 08/12] xhci: Add Intel extended cap / otg phy mux
 handling
Message-ID: <20180228151552.GA5335@kuha.fi.intel.com>
References: <20180228150749.26831-1-hdegoede@redhat.com>
 <20180228150749.26831-9-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228150749.26831-9-hdegoede@redhat.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 04:07:45PM +0100, Hans de Goede wrote:
> diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
> index 96099a245c69..5917e3095e2a 100644
> --- a/drivers/usb/host/xhci.h
> +++ b/drivers/usb/host/xhci.h
> @@ -1825,6 +1825,7 @@ struct xhci_hcd {
>  /* Reserved. It was XHCI_U2_DISABLE_WAKE */
>  #define XHCI_ASMEDIA_MODIFY_FLOWCONTROL	(1 << 28)
>  #define XHCI_HW_LPM_DISABLE	(1 << 29)
> +#define XHCI_INTEL_USB_ROLE_SW	(1 << 30)

Did you rebased these on tope of the latest usb-next? This does not
apply cleanly on top of linux-next.


Thanks,

-- 
heikki
