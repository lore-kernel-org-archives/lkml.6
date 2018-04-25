Return-Path: <jani.nikula@intel.com>
X-Google-Smtp-Source: AB8JxZorraJ1KCr+2IXpl6O2R6CNFXTcubT+hReziJLFtt4ichBvJcjEctmbuEqIRoWB6DEgzVlv
ARC-Seal: i=1; a=rsa-sha256; t=1524663862; cv=none;
        d=google.com; s=arc-20160816;
        b=01O3czMKwhKZJ56fD7k0/hLY3Lhr9olPBV1fDN0EMmsAosMqAjl7axPh2p3ihSxhSB
         a0aMK3w5EGimgE0CcfgMQBUPXnRg9sOw+/h+d3zFIVs5bJd5twgdT7rORQNsHsEwj91R
         AM4XOex81a9unb47lSHJsYFPC+IY+MqZgOvo+KSuNgZxsz/qlrAIuTe7XNODKqa50PI1
         VZLThUxzQVkIcS/RBl9nQ6lXZO+5ZMeKgqxnTagk5lpPYVOwa6Q2pjkg8gtUn9IWQAHZ
         8aN0SrAjCbQVdxgag0Bc+n+71SgxH22S6zJTT429eycXOWazkHuLl8GS4Wv28e/zRBdJ
         jIog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:message-id:date:references:organization:in-reply-to
         :subject:cc:to:from:arc-authentication-results;
        bh=1ec1dRmpMAE4GxdJhdbpAxO4XCcY+MMICLg2hOcEHgU=;
        b=PIP8JVkvXZcYron2FGv8kF7iiazMqoYu+MjJjWEnsFjTNNnJIwP8vjW1dfEDS1u+2D
         IHu+Efpl009VUrt8cGIGRU4m1Svme1PzQvkkX3bTVewV4FL/ZhS7PQa227PyZ8z7kafC
         rjsM68PGO5jS70myBKSCFgILSBvWv7aJrmx3qOqDbSaZBJH1vpNU+OtAT/3X5QSiWBll
         0WVexT5qs2UL+ugVSb3XMp+/XdEB4MCO+rjx7YHxfrUsjVpquKkEJ0mGyeY4QTp3s75m
         ZYWkBFJ7XFbR0XKCwnV4sqOsMsdFGtI6seQdama1YFXi5jmFU5YCsMhNOXkd3MA2+TAl
         45dQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jani.nikula@intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jani.nikula@intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,326,1520924400";
   d="scan'208";a="49835824"
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg KH <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Masanari Iida <standby24x7@gmail.com>, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Markus Heiser <markus.heiser@darmarit.de>, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: typec.rst: Use literal-block element with ascii art
In-Reply-To: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20180406124122.70676-1-heikki.krogerus@linux.intel.com>
Date: Wed, 25 Apr 2018 16:47:01 +0300
Message-ID: <87604fcsa2.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597000631976599018?=
X-GMAIL-MSGID: =?utf-8?q?1598725933848538520?=
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

Jon, this fixes a documentation build failure in v4.17-rc1. It's not
just a warning, it's a complete fail. Our docs builder at 01.org is
failing, apparently the same at kernel.org. Please pick it up soon.

Thanks,
Jani.

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
