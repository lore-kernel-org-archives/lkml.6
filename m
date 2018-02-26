Return-Path: <mika.westerberg@linux.intel.com>
X-Google-Smtp-Source: AH8x227HZRN/X9Kvdqq1rZwpVguJUFmk9c4kC/dFvg+IF5H6xVjX41gw3i2LrnNBNGuzkOUDZ1SC
ARC-Seal: i=1; a=rsa-sha256; t=1519645974; cv=none;
        d=google.com; s=arc-20160816;
        b=kVXEnbRgo8j/MZi+VLpoCuoTWDOUYBd66HqkExo3YBdAwg8UXQ1Az6BtV9z/SNRGbo
         JRWWwkkuPdC4LR3JzRwnify3/BRtHuVbFcevgNkASyGW9R5hsJx5c6yMgMwexh9+pn+o
         pzLIwPxwYJbQR7lxmQdKDq/OA2npOwYsQmkSo+Ky9hTrb2AU/FVRTj3KH0blVpzHPHSy
         78/JQmvHNf5nZxG3tPL2JP/JEr1u4/ei88rbzvYb5++fz+ntoC+LSoY1RM0DFqwY3kJZ
         a+d78+svOhSvKHXn4W1uvzsaewVqdLyIzyxPGmWEtejnBHjahYa+M/z9Tzh34TcLCS7x
         vaqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:organization:in-reply-to:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=GK3TMquHFNLG91V/UTdHgZaDalQSIw4GrcsqG5bsw2I=;
        b=J3KLY7tcfEvAWXvvUjMvbErzLuJdruItq2UpmBYy67EQRS1ccEFIfD+Eb8tfGXcvGV
         UMMeiZbyD0edfaWAnxQbIU5sBObcQOFYm+YDhZZbua4gXtrznqVVPbTAS3Xgw7x6EO/T
         wZHlKcpRMuh7qgq7nUTtNSsFdX/ycowDmdBkM82ikdw0kCL+HrufHoWKfP2N9b7BlFkt
         0g7vZ6gpe2W5Vquz8DcnPYDhdakE7Ih1M0Jc0mjAE2tRzAySyOzGjrAGUKcJGSi5GVca
         QHYTHXkLkiU+PMXVsdVagWVe33mzcePlBbsYko/l+IP8FrALsGVFGLi3h7QxGVGIuAkB
         Wzcg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of mika.westerberg@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=mika.westerberg@linux.intel.com
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,396,1515484800";
   d="scan'208";a="37498120"
Date: Mon, 26 Feb 2018 13:52:47 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>,
	Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
	Mathias Nyman <mathias.nyman@intel.com>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Lukas Wunner <lukas@wunner.de>, Peter Wu <peter@lekensteyn.nl>,
	Qipeng Zha <qipeng.zha@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andreas Noever <andreas.noever@gmail.com>,
	Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 1/2] PCI: Add PCIe port runtime suspend details
Message-ID: <20180226115247.GN27191@lahna.fi.intel.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908203999.37696.12678235610905422348.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <CAJZ5v0hys5UY69H=ARHA-EsmH-CVqTQNSQciktDQ=nVBEKJHqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hys5UY69H=ARHA-EsmH-CVqTQNSQciktDQ=nVBEKJHqQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.9.1 (2017-09-22)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872970483997772?=
X-GMAIL-MSGID: =?utf-8?q?1593464297331623717?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 20, 2018 at 10:31:51AM +0100, Rafael J. Wysocki wrote:
> On Tue, Feb 20, 2018 at 12:14 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Add details about how we decide whether we can put a PCI bridge in D3.
> > 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend") added this
> > support to reduce power consumption on Intel Sunrise Point and Broxton
> > platforms.
> >
> > In some cases we don't use D3 for bridges even when it should work, simply
> > because it's impractical to test the configuration, or we tripped over some
> > possible hardware issue on older platforms.  Links to discussion of the
> > PCIe port runtime power management patches, which includes mention of these
> > issues, are below.
> >
> > No functional change.
> >
> > Link: v1: https://lkml.kernel.org/r/1456750566-116248-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v2: https://lkml.kernel.org/r/1460111790-92836-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v3: https://lkml.kernel.org/r/1460628268-16204-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v4: https://lkml.kernel.org/r/1461578004-129094-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v5: https://lkml.kernel.org/r/1461919919-120102-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: v6: https://lkml.kernel.org/r/1464855435-32960-1-git-send-email-mika.westerberg@linux.intel.com
> > Link: https://lkml.kernel.org/r/2858019.9TUCWsDpTB@aspire.rjw.lan
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Also

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
