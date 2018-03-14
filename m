Return-Path: <heikki.krogerus@linux.intel.com>
X-Google-Smtp-Source: AG47ELsZlDfldf5PDACwr5/inp4cn87rVGs3GsoEsaei5sgztPfT0JaEnamzBIzdl0xb2Cr58GAw
ARC-Seal: i=1; a=rsa-sha256; t=1521034807; cv=none;
        d=google.com; s=arc-20160816;
        b=jXkVijKoEolq6txlCIctXP02qGarSM4qEtgQL8gmynhHWR7N642q5qqLFhcuMnphsb
         VB15C/lfkqQw65ZrsI5e/Udc+/x3SvACXRFEqkU4RwFSLFFHhLxfumP+T1tB9+Ls6+/w
         rgm9pGKWun8SNFT9eO0IjuJLWE5Iz1qWXhJBE3SPWiGZc5d2IWdJJBk9QcZpzoXM0Eon
         jG7cfPi83VQNwMtDcqRqc7hVkD6NY9MMMLiq89ytlIreumgIZgseVl7TYq40hfk7Vo1G
         bl6XZ/YsnbW4RdYXMLf7/44AjmjxFvD1kRUQ5dj/Qq8jTPrR6ISEjuySbJEXwMIzBnbf
         fkog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=bCxlUTmz8CyzvUmHOpjUne0KZDiuuJ3uYm7scinwdYQ=;
        b=u09499MgSfaRsMMEouzD4qduMvLhc+0trTnzI1TTsZWqZV8KLwsXWwUX0Wf7/K2nuX
         f+Ghs4TBDc1AS2QOhjVWeCeTfMDWBApsWGrJ+rUnB9wFukAT0km6qeqlUO1TyR9vypAm
         9y4MGWqkbhkQvmh00MUEzgj6bK+7qT6+L40E4MqhHjCZus9b/KlvMLhJ4p26uNAPlgFR
         lpoH6BIrMY4rWWfMVN2YDQ9YpecTEfMrWNfXwU97FT9wKdk6ThV/Kg6dcvziQ8vSoAqa
         cW3o+fsOYMqQm9C+fknT3MD96ElwDuN26Ebh53sB1W9dwWrPJPxI7VXLTdXlOKi/B2fu
         12cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of heikki.krogerus@linux.intel.com designates 192.55.52.136 as permitted sender) smtp.mailfrom=heikki.krogerus@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,470,1515484800";
   d="scan'208";a="37994698"
Date: Wed, 14 Mar 2018 15:40:03 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Felipe Balbi <balbi@kernel.org>
Cc: Manu Gautam <mgautam@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
	Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] usb: dwc3: Add Qualcomm DWC3 glue driver
Message-ID: <20180314134003.GB10347@kuha.fi.intel.com>
References: <1520937362-28777-1-git-send-email-mgautam@codeaurora.org>
 <1520937362-28777-2-git-send-email-mgautam@codeaurora.org>
 <878taw8c81.fsf@linux.intel.com>
 <5a65d202-bb94-0f73-f9aa-9055a1cddf76@codeaurora.org>
 <87woyfrqgr.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87woyfrqgr.fsf@linux.intel.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594818433818222359?=
X-GMAIL-MSGID: =?utf-8?q?1594920594400138086?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On Wed, Mar 14, 2018 at 10:50:12AM +0200, Felipe Balbi wrote:
> >>>  - Support to replace pip3 clock going to DWC3 with utmi clock
> >>>    for hardware configuration where SSPHY is not used with DWC3.
> >> Is that SW configurable? Really? In any case seems like this and SESSVLD
> >> valid should be handled using Hans' and Heikki's mux support.
> >
> > Yes, with this we can use dwc3 without using SSPHY. Please point me to
> > those patches. There are only bunch of register writes in glue wrapper to
> > achieve the same.
> 
> https://www.spinics.net/lists/linux-usb/msg160868.html

I'm not sure if that series is usable in this case. Though we do
control the VBUSVLD pin on DWC3 in the driver for the "Intel USB
mux" Hans is introducing, the framework for the USB role switches does
not provide any support for it.

The Intel USB mux driver simply enables VBUSVLD when device mode is
selected, and disables it if host mode is selected, and when the
selection is cleared (disconnection).


Br,

-- 
heikki
