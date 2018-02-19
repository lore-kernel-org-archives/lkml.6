Return-Path: <valdis@vt.edu>
X-Google-Smtp-Source: AH8x225ZwNycZrgtRR0eA0YXc9PSzKFQHu98RP+gQ6kVlK0cL6nD0SrbwxZbdkEZkIyw+IhoMiux
ARC-Seal: i=1; a=rsa-sha256; t=1519082912; cv=none;
        d=google.com; s=arc-20160816;
        b=S4TGyvSCc85nGAJd2NQRVfvBjblzMIIlRvR424N8NFbCzGfejTl/7560Lhd0KqnVYB
         hA6FRHRveC6PFBOZisqFjQzEHky2S0lTVnJwo+KWlm6duiuPmIL5YG2dGtUZF034/IRY
         ZhtwqGQ4LCw65w/IkJURFlsp0YrjELXW2y3TsXprDu4ZrAfZkfxn6RLSEc0quxWyHyGa
         rt08hUyv7MhT8piqMOxoO7baBJKfcaHYrXY3Pjg0wnCD69gS7G2I1uGne5tXtImI3g3P
         UlJrsLzovwgAi/5VJoe4TrSnRfcIM4VPidkAM+TdPNMSXtKj5MTOn2Z1Jp1y6jvP4Jf4
         IAHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:content-transfer-encoding:mime-version:references
         :in-reply-to:subject:cc:to:from:sender:arc-authentication-results;
        bh=B1zSPhnk5R9JgqrgdjfouPmooFz2RU/U7PMH4s2puKs=;
        b=TzT0s+mTph7EiySm+6JaPb76BGuSS2D3vg/PD3fNNQ+nre6W8q/3vY2GSG5f5EanV3
         uIy8gkUOFrpe4yFORvHaeT2XtVK52m2scwrVxtiR/ft0jQLLBqpMIZ466w9DdslS70IJ
         mFOJ4s34NlkagQ+CBa0KtrEfWO1NSDcZeg3P5OrkBh3d0PEuuEgd0vPVU6HAA9b6zRyx
         00DOpREclPQ3+xno3c3BPkMLB0vVybfTsr77UkyVoMH1xqb7zmhrILRFdqACS88i+M4w
         rc97FzkBOQ/OXSoXeFzOlgk1onji402i04+25OjRjUPu8Mb4N6UPiBdbvHfHmWFiZ/xb
         TSTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of valdis@vt.edu designates 2607:b400:92:8300:0:c6:2117:b0e as permitted sender) smtp.mailfrom=valdis@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of valdis@vt.edu designates 2607:b400:92:8300:0:c6:2117:b0e as permitted sender) smtp.mailfrom=valdis@vt.edu;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=vt.edu
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
X-Google-Original-From: Valdis.Kletnieks@vt.edu
X-Mailer: exmh version 2.8.0 04/21/2017 with nmh-1.7+dev
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, Mathias Nyman <mathias.nyman@intel.com>,
        linux-pm@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org, Lukas Wunner <lukas@wunner.de>,
        Peter Wu <peter@lekensteyn.nl>, Qipeng Zha <qipeng.zha@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Dave Airlie <airlied@gmail.com>, Qi Zheng <qi.zheng@intel.com>
Subject: Re: [PATCH v1 2/2] PCI: Allow user to request power management of conventional and hotplug bridges
In-Reply-To: <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <151908155159.37696.9710083237704994886.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <151908204614.37696.12828004282495415825.stgit@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1519082904_3347P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 19 Feb 2018 18:28:24 -0500
Message-ID: <7778.1519082904@turing-police.cc.vt.edu>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592872976935903628?=
X-GMAIL-MSGID: =?utf-8?q?1592873884741000472?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--==_Exmh_1519082904_3347P
Content-Type: text/plain; charset=us-ascii

On Mon, 19 Feb 2018 17:14:06 -0600, Bjorn Helgaas said:

> Change "pcie_port_pm=force" to enable power management of conventional PCI
> bridges and hotplug bridges as well as PCIe ports.  As with the previous
> PCIe port-only behavior, this is not expected to work in all systems.

This part says the behavior changes - which is itself a Bad Idea unless you
have a deprecation cut-over across several releases.  The general rule is that
you're not allowed to break somebody's kernel without a lot of warning.
Remember that there's probably a lot of embedded systems that hardcode their
boot cmdline and changing the behavior can result in a failed boot - which can
be a royal bitch to debug if the embedded system doesn't have a console.....

In addition, it doesn't match the actual patch, which documents the boot
parameter as being removed, rather than the behavior changed:

> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 1d1d53f85ddd..4660105ec851 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt

> @@ -3143,10 +3147,6 @@
>  		compat	Treat PCIe ports as PCI-to-PCI bridges, disable the PCIe
>  			ports driver.
>
> -	pcie_port_pm=	[PCIE] PCIe port power management handling:
> -		off	Disable power management of all PCIe ports
> -		force	Forcibly enable power management of all PCIe ports
> -

And *that* doesn't match the rest of the patch, which never touches the handling
of that parameter, either changing it or removing it.

--==_Exmh_1519082904_3347P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBWotdmI0DS38y7CIcAQIFNgf/Voo1PhvVYqriKAKxYoK9fDPbW7e5I/CQ
RyGJmtTIvp+AZNCcZUv1OMQYitmPzUPDSDcYcwaDDRS/y06kV78U+lE+rpr1OuPA
k6DLH7LX3vM30nHY6Pt2uxeDWK7otdCByBZwrrFMo0IqJle/2sK/RcFfkr3B1+24
wo8QO3Gnq/u44KMaGaEUz3plZN2z0ZcKPf3Wffy6CTPSzwy38K55tbjqhylhpYJL
HQ5LYC6WP2LsAAQ8jJ3VeZGY9OoVZcz2c1JH9PxdIrFr3R5zcYmEQhGBPmya3yF9
J/jqc10cp0fx9YiexZxU+UdaaZpK3Yf5/rdoX7AWB2ZdhqnTEFpBIw==
=TDtU
-----END PGP SIGNATURE-----

--==_Exmh_1519082904_3347P--
