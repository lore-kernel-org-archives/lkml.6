Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1494096-1523023787-2-16890123368313563708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523023786; b=BUroHCkdRHxpF0HBDw67VIFOrZVN+SKm6SVMohH1C5ebd80sGP
    VLCAJ3AycdDUelzKV99qkhJCZQU6j4Eltbui5T5OPIUYoHJ9JdQHgn9ZDF0yNhlz
    Iek5D9h2/NP2wMUb3AWOw0GYxQVWrxifgGu40QMFNCxp3b2IzGjO5FeFnn8EO52/
    ofoztR5RBUaLQrGKyFOTRQdGlfaBS6tJ5Zq20t0fBHUaubTcDteLTrALiH1MdJog
    +tWpEtHnoXwrucP54I0x0v0McnDp/Sre58wHDj3PSwnGYWBUnBCLpt56SNqeNvwu
    BsO2CE7WDWXRBsSEKVgtJWnX4YxjylWgViGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523023786; bh=daC8dXVggNbvw4E8sgZp/qfxs/h9tOW03f9Pfe6qv2
    A=; b=A8dt/o80qGjhSjZRtj2oVldCdskEi9jqwP3N1b/yOwVnYxMmeesD9IjFkx
    NOZw98L6tgeazYg/DPWMCNknsbK+CiE1kiJwT8uh0zSUyY4wusbRaPtLfRSCUrhL
    8DMZUD8EfD8Xk5IVgE3I4k5/9Q7/MJNX3px6kBwcFfqg3v57s0ZxrWmmG/XkPoxI
    W5nyp0woOzMmJnt1JOjqy34B1B2S9VPX7vh+AWgQ99T6c74KcJiE0DkigLOStQID
    EsKI41JKk7gvdjMoipODxhVyt6bRMshlMCQjpryW3+HNXr+MYN7o9oB8uRlKN0Aj
    jUdoJITPaFBDjOYEfYRv2dDyo1lw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCxTQIA1DjbaqQXgqBYEJAyoSbPSLhfvKXY2V+74ddxyWJuMu1mbhKCdtk+XvE3CqJoZ79vug2GINa5ybclPmM5d5iFgFqJvxeUFK84pCFmygAz30Lyq
    vkCPwekP+zKwUWb74bBQIL2BumkCIuH0Ktfn6X4JUNsJ6Hphg6PcXgFSwHyaeGVcB6oXvYBP9NvCi+cA5ZHLK7LQTTJbRdouDfomLlZUbwnVsO6bS8h6cHMw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=VTfK0ONw1eQ3Z2f5tWAA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756381AbeDFOJb (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 10:09:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:63037 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754933AbeDFOJa (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 10:09:30 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="44651620"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Markus Heiser <markus.heiser@darmarit.de>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: typec.rst: Use literal-block element with ascii art
In-Reply-To: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
Date: Fri, 06 Apr 2018 17:10:16 +0300
Message-ID: <876054l92v.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 06 Apr 2018, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> Using reStructuredText literal-block element with ascii-art.
> That prevents the ascii art from being processed as
> reStructuredText.
>
> Reported-by: Masanari Iida <standby24x7@gmail.com>
> Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-and-tested-by: Jani Nikula <jani.nikula@intel.com>


> ---
> Changed since v1:
> - Using literal-block element instead of comment
> - Subject in v1 was "Documentation: typec.rst: Mark ascii art as a comment"
> ---
>  Documentation/driver-api/usb/typec.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> index feb31946490b..48ff58095f11 100644
> --- a/Documentation/driver-api/usb/typec.rst
> +++ b/Documentation/driver-api/usb/typec.rst
> @@ -210,7 +210,7 @@ If the connector is dual-role capable, there may also be a switch for the data
>  role. USB Type-C Connector Class does not supply separate API for them. The
>  port drivers can use USB Role Class API with those.
>  
> -Illustration of the muxes behind a connector that supports an alternate mode:
> +Illustration of the muxes behind a connector that supports an alternate mode::
>  
>                       ------------------------
>                       |       Connector      |

-- 
Jani Nikula, Intel Open Source Technology Center
