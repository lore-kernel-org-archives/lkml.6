Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AIpwx49drwo9s1i4nzCneOEBEiKw15Ey8d7ZI7cK4Cokyt/dtgsMgDA4yc1aTa4A6qmyr0y4Kloi
ARC-Seal: i=1; a=rsa-sha256; t=1523001073; cv=none;
        d=google.com; s=arc-20160816;
        b=ZuMCMKBt4b0JJX2MJRcyupQK1mMO578T77cz2dPR+YokRTP+SlzzPHYZOpzn9hjEML
         V/09hAM54wplwBvM1Se79UvKMowzpMUQVK0koatwvZ7MSNXPz1E+Nr5NSauXyKzn7bRN
         5RlURRcUlOvkIBjCXYbmIsv4p5tPqCqj8CaEGooQY7XnHF9629jHhboO5yCfqltUayKh
         SdQu3mqPeyBR+TuWusyRQXcrw1HhTeEderiIkIDE5uD3hIwxJUPJhvrDZ1PL4W5ilOmE
         UCeRZfihQlfoh/DpefLloQV6IRavuWIf3TYqODtm9DT15I1hqe8e0WrDFcJyWePjfFEo
         Mi8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sG4DjUwIgqekSkQrq6CkpPuItM1i6ML785irJTaHJuk=;
        b=O21YmrWBsgMquC2ZKK+u0/4L2r/e3QKqZI82VAQF6epo1h39qTOUAJ3y9boouoafsu
         Id4TnUC0k+jNF+3rctjxR2NvA6+o7BD+s2gyy1ljl1VRNWw+zRgFwBcpDyvvtuz5Nknd
         2HxCyVJYN/42nhsnljuUiTbhjPCggWiSWmm5mO9g9bIA5aT9AG/Cim2FCgQf4A0sDqNj
         D2YoLRD9K8TYK7Eyi6sMmr2WVy0LCyjKU+87pYnPnX7oxpZZwoPe+5IW5qNsOZIUXAB1
         p2lAyuT/Q/3uI7ebcSXbScTti/GLivUB6qOTDuZ0iFF1APyCnx5I5olDD3PbBcgHySN4
         IBSg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,414,1517904000";
   d="scan'208";a="44579563"
Date: Fri, 6 Apr 2018 10:51:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Masanari Iida <standby24x7@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-doc <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org
Subject: Re: make xmldocs failed with error after 4.17 merge period
Message-ID: <20180406075109.GA21589@kuha.fi.intel.com>
References: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALLJCT0MFg6b+dG50cqe_hv6hxmQDj-ZM066BOtQt_wOiC8ENA@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596966487828993292?=
X-GMAIL-MSGID: =?utf-8?q?1596982374331870720?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 12:38:42PM +0900, Masanari Iida wrote:
> After merge following patch during 4.17 merger period,
> make xmldocs start to fail with error.
> 
>  [bdecb33af34f79cbfbb656661210f77c8b8b5b5f]
> usb: typec: API for controlling USB Type-C Multiplexers
> 
> Error messages.
> reST markup error:
> /home/iida/Repo/linux-2.6/Documentation/driver-api/usb/typec.rst:215:
> (SEVERE/4) Unexpected section title or transition.
> 
> ------------------------
> Documentation/Makefile:93: recipe for target 'xmldocs' failed
> make[1]: *** [xmldocs] Error 1
> Makefile:1527: recipe for target 'xmldocs' failed
> make: *** [xmldocs] Error 2
> 
> $
> 
> An ascii graphic in typec.rst cause the error.

Thanks for the report. I'm going to propose that we fix this by
marking the ascii art as comment:

diff --git a/Documentation/driver-api/usb/typec.rst b/Documentation/driver-api/usb/typec.rst
index feb31946490b..972c11bf4141 100644
--- a/Documentation/driver-api/usb/typec.rst
+++ b/Documentation/driver-api/usb/typec.rst
@@ -212,7 +212,7 @@ port drivers can use USB Role Class API with those.

 Illustration of the muxes behind a connector that supports an alternate mode:

-                     ------------------------
+..                   ------------------------
                      |       Connector      |
                      ------------------------
                             |         |

I hope that works.


Br,

-- 
heikki
