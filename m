Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-959472-1523006348-2-16655130923348943470
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
    1523006347; b=JuT3GtsFtFa4HhiKRTsbdcfVZTMr6OFXMsHzLrdLo8ziChPb3k
    xKPGl7jETH+L86AafpklrJJ1WnQjadl9U4pm8u8x9RuxoKannG79dKo2c/Gd0FSf
    YkaZCh+A1n8Ec86rNwJdOFKFUwKDyLTQS0vbJjXLcxfX8rLoGrs0RoZzosGzRVFV
    J7a0lbeg5ruGKmNUvJSrXTk+gjNrizvEHLLq+3bS48q/n/TnkpIs9B/3vqSsz17y
    RXMMQ/83qMiIQCw8HnmZBKFbeNBUbiswXzW5w7R6F13+F3ektN6/gVibRzohsnDr
    qGkKEJabSughnAeDsMFQq99uWxP+EopSaZXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:in-reply-to:references
    :date:message-id:mime-version:content-type:sender:list-id; s=
    fm2; t=1523006347; bh=CxFwqXZ/bn4+DJZl5UOGs7FTOqCxt7o5r/Be7IsCvx
    0=; b=Y2IABXES3Lw0CS9fnQUyj2gweA0ogAkM/0738qvaYn7VIbka8z4ZO43mc3
    Rond0r8/j4M+omqOpQNzkJt/V95LaceFSq/8gCRedVD0xa4P1pVOs5xXhRUvppzr
    8eiMqKFDym6njJUP8U/L5EH6ZQetWepaNnsVaf2yNBcQTYb8a9N6M3lgj/tMUaNV
    Yi1+0JszZxR6y89RTdNiPkA9oe2rDjh500I8IMCOXa4DCFsQeY0Zet45s7u4L0Bu
    GTt5FtrMLGHJ1TgFyP8sGLg/eaot9UzIy2tBzEWeYHuCbuM/K+MdYxwHWIWZATHI
    PevDKTBSnZKWq3LZP9HeSwpPTbNQ==
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
X-CM-Envelope: MS4wfDvwOvkNKIMyBXJGWqMnhwzco5R7YDEnGlZ0FaUWy93aytFJcdPV81+OUnkf0nlTt9YRwxqH94G0C6y2IGIH36qeXbD1P3eoGvt3ggSzufxLwJ7sushk
    LC3A7X+Qw6O4ifGwd+vdiEJIq2SnUF2z4EbNBNyc7Y4VcU6hKWVHBI7mhUbnqaH8bZ+pBEiU6T0ZNyWY4YOsPDrvwW6WRt1yAVIv3Y9Ow4YclvIw9ggpilSV
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=QyXUC8HyAAAA:8
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=D0F9E9NPOEvTVrSQtbsA:9 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751417AbeDFJSw (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 05:18:52 -0400
Received: from mga17.intel.com ([192.55.52.151]:33606 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751329AbeDFJSv (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 05:18:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44593699"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] Documentation: typec.rst: Mark ascii art as a comment
In-Reply-To: <20180406082229.55375-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180406082229.55375-1-heikki.krogerus@linux.intel.com>
Date: Fri, 06 Apr 2018 12:19:37 +0300
Message-ID: <87fu48u1xy.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 06 Apr 2018, Heikki Krogerus <heikki.krogerus@linux.intel.com> wrote:
> To prevent processing of ascii art as reStructuredText
> elements, marking it as a comment.

Please don't. This hides the ascii art from the generated documentation.

The right fix is to use a reStructuredText literal block like this:

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb31946490b..48ff58095f11 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -210,7 +210,7 @@ If the connector is dual-role capable, there may also be a switch for the data
 role. USB Type-C Connector Class does not supply separate API for them. The
 port drivers can use USB Role Class API with those.
 
-Illustration of the muxes behind a connector that supports an alternate mode:
+Illustration of the muxes behind a connector that supports an alternate mode::
 
                      ------------------------
                      |       Connector      |


BR,
Jani.


>
> Reported-by: Masanari Iida <standby24x7@gmail.com>
> Fixes: bdecb33af34f ("usb: typec: API for controlling USB Type-C Multiplexers")
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  Documentation/driver-api/usb/typec.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
> index feb31946490b..972c11bf4141 100644
> --- a/Documentation/driver-api/usb/typec.rst
> +++ b/Documentation/driver-api/usb/typec.rst
> @@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.
>  
>  Illustration of the muxes behind a connector that supports an alternate mode:
>  
> -                     ------------------------
> +..                   ------------------------
>                       |       Connector      |
>                       ------------------------
>                              |         |

-- 
Jani Nikula, Intel Open Source Technology Center
