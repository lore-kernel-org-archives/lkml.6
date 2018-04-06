Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-959472-1523005991-2-15661032869301033533
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523005990; b=BTmRDKi0ftFYEdpLN2lAZIWyRnRMlp+fODvDe2SmgIgspDazsh
    Md+mAKHQ8fqv19eT0oiWUFM0IVCeSlpLxSU4ACU8Uod0hqzgNH6pmWf2fkprAwAD
    0jSYTvVh0PIAxb5Np3CT4G2LABKWf9MfsWqHXtHZewfmz+wDswoXQ1/sf8jiXnYU
    mSeawL0nCA1Fq673YdHx9w478Igx5MdAOFE70BpQyCTnOz9kTAPNk9p3WfJgK30y
    nralK8iydkgmXVhlBKAeX0LQQIjwiI1erXQTQ1HAQYlS3vXhfvjyGvkJFINiAup2
    bV/1RhgSWVlmwjCSrw4UBHqiVUu2mwFLQKbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523005990; bh=6r1JOw5vpIt4QA0OoreFcFE44lgY96
    gdUWwKv0mkO80=; b=n3kqDAbaZ3gv/X7fZkrgj1e7UtFkS0N7HGJOwUkzhGyoaS
    vcTptcArhQqFvt3CDtQiUhQQGzwxvZ/5zUeQMtL9YM+RMUZJHNv/ExvNrjHdmfQG
    lkOdsyCHNxj22eCX4bin9cq0hM96DTQtzIxa9Ic/SbFvnGqGHoFwEhArdtez/iVR
    gfr8m5ccXkyyKUPFMz/yB6bRJPLp6dO3MlIin8C7SVyX4+4JdZwOe69ojXaUE/mb
    hYfzjtuRsb3Ui8R1HT5pJeptKf9JVD2OlcJUNTbAkxF6P4iLMQKqY9falhILdRwp
    a9BHFcT8zkM7j5JH9tOHmc7ksziH3Msdf5MQY2rQ==
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
X-CM-Envelope: MS4wfPMP7fTJNdpl5ST3fbZ14E92cmmsTsKDcB+ddUnAdf8pyEeR8M98sKsG7iR0NNut6uZtc6PS4csdVxZVaKZPDVHZK4VPZr3ZfE6SuIAdSauELqlDqD3B
    Rzdd2EZ5AF3gXbFClt7G1lypn6UbCK4URRfGRM917LgTuxmfaTGs3IKdg9PfiDnm1Z0ZzKL28kEfsAnRCmcFo3AukvbyMpIQOp675jdltctdkDZ8BurPy4hx
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8 a=1tG0KgGaONOMOUuJYxYA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751679AbeDFJMy (ORCPT <rfc822;greg@kroah.com>);
        Fri, 6 Apr 2018 05:12:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:1502 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751417AbeDFJMx (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 6 Apr 2018 05:12:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44592775"
Date: Fri, 6 Apr 2018 12:12:49 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] Documentation: typec.rst: Mark ascii art as a comment
Message-ID: <20180406091249.GD21589@kuha.fi.intel.com>
References: <20180406082229.55375-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180406082229.55375-1-heikki.krogerus@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 11:22:29AM +0300, Heikki Krogerus wrote:
> To prevent processing of ascii art as reStructuredText
> elements, marking it as a comment.

I will change this, and use literal-block instead.

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

Thanks,

-- 
heikki
