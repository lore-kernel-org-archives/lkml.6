Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2756371-1521461758-2-15786064016470868953
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521461757; b=qRMjhJfpllbERUwhhDJh9TwUdpLwNPuCYLy/NY/2Q8Fgmv3
    ieCv6gDgQuzAc1aXWnkwl6xkdlGIyEstZj0mb86JPIy2MaWu5D21zQx+pO5GA+w9
    I8yRTkykD7iTEM7PPBT1LnF0Dspq+s1/VxzxN6Wxfbna2EJ3MluuB8ULLFB+gIvV
    dRWyOICplPW5pSPXGEoZDJKdtf/8tLVY0//+l4MjIhSz53Ox0BaxNay77anJOsph
    IP1CTlH+bK/OC+y+qKRgGWyGXhQrINQ7Up8cue9hCRUJv0pgEbbkjinbCX/DferX
    r8AQ8BTSyDmYO2L9UmnnLjPudNSIti0qnOPcgOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521461757; bh=KQovU4fn+mFEx7cT3GRVYTFv7R
    5WQdvKyA8xqdz2BNY=; b=dIJPjBDNNfOG7cj21OKfDRER840ppiBKQEHiaQnmqb
    koa1RwMysgYn8HlcS/SCs2aFTefT49gzxtDe3Dl8N+GI6nfb8wojHttrfd4qovHx
    PDVzK2oqlfut4Be0V5OI0OUr552V9o1cH83mS8FNHN1zdtKgLVIioswKWiAw78PP
    Hq3BEi9chf/CF1Zn7SWoqLq5seLapl3N7Ki+LI1gXREiQe8EAGwnNdQMnsFgOfH4
    o/X+g4ibNld5S781O+vftOU6eHxY5cFFrMqkuxC/RkgqhrcRvZ/NcQyY5ttMu9PN
    3WB3p5zKXaYB3hbkLERnTPnGoskIuE3JFwfywx5hOgyw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdefieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddufeegrddufeegrddufeeirdduvdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefheeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdefieculddtuddrgedtfedrtddtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfhfgggtuggjfghsphejsehttddttddtredvnecuhfhrohhmpefjvghikhhkihcumfhrohhgvghruhhsuceohhgvihhkkhhirdhkrhhoghgvrhhusheslhhinhhugidrihhnthgvlhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvddtledrudefvddrudektddrieejpddufeegrddufeegrddufeeirdduvdeinecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehlihhnuhigqdhushgsqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeduudefheeknecuvehluhhsthgvrhfuihiivgeptd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932490AbeCSMP0 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 08:15:26 -0400
Received: from mga18.intel.com ([134.134.136.126]:60364 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932277AbeCSMPZ (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Mon, 19 Mar 2018 08:15:25 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,330,1517904000";
   d="scan'208";a="39222928"
Date: Mon, 19 Mar 2018 14:15:19 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>, Jun Li <jun.li@nxp.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/3] usb: typec: tcpm: Support for Alternate Modes
Message-ID: <20180319121519.GH11689@kuha.fi.intel.com>
References: <20180309151918.22048-1-heikki.krogerus@linux.intel.com>
 <20180309151918.22048-4-heikki.krogerus@linux.intel.com>
 <20180316213206.GA10520@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316213206.GA10520@roeck-us.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Guenter,

On Fri, Mar 16, 2018 at 02:32:06PM -0700, Guenter Roeck wrote:
> On Fri, Mar 09, 2018 at 06:19:18PM +0300, Heikki Krogerus wrote:
> > This adds more complete handling of VDMs and registration of
> > partner alternate modes, and introduces callbacks for
> > alternate mode operations.
> > 
> > Only DFP role is supported for now.
> > 
> > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > ---
> >  drivers/usb/typec/tcpm.c | 133 +++++++++++++++++++++++++++++++++++++++--------
> >  1 file changed, 111 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm.c b/drivers/usb/typec/tcpm.c
> > index bfb843ebffa6..34bf5c1f4d81 100644
> > --- a/drivers/usb/typec/tcpm.c
> > +++ b/drivers/usb/typec/tcpm.c
> > @@ -158,13 +158,14 @@ enum pd_msg_request {
> >  /* Alternate mode support */
> >  
> >  #define SVID_DISCOVERY_MAX	16
> > +#define ALTMODE_DISCOVERY_MAX	(SVID_DISCOVERY_MAX * MODE_DISCOVERY_MAX)
> >  
> >  struct pd_mode_data {
> >  	int svid_index;		/* current SVID index		*/
> >  	int nsvids;
> >  	u16 svids[SVID_DISCOVERY_MAX];
> >  	int altmodes;		/* number of alternate modes	*/
> > -	struct typec_altmode_desc altmode_desc[SVID_DISCOVERY_MAX];
> > +	struct typec_altmode_desc altmode_desc[ALTMODE_DISCOVERY_MAX];
> >  };
> >  
> >  struct tcpm_port {
> > @@ -280,8 +281,8 @@ struct tcpm_port {
> >  	/* Alternate mode data */
> >  
> >  	struct pd_mode_data mode_data;
> > -	struct typec_altmode *partner_altmode[SVID_DISCOVERY_MAX * 6];
> > -	struct typec_altmode *port_altmode[SVID_DISCOVERY_MAX * 6];
> > +	struct typec_altmode *partner_altmode[ALTMODE_DISCOVERY_MAX];
> > +	struct typec_altmode *port_altmode[ALTMODE_DISCOVERY_MAX];
> >  
> >  	/* Deadline in jiffies to exit src_try_wait state */
> >  	unsigned long max_wait;
> > @@ -985,36 +986,53 @@ static void svdm_consume_modes(struct tcpm_port *port, const __le32 *payload,
> >  			 pmdata->altmodes, paltmode->svid,
> >  			 paltmode->mode, paltmode->vdo);
> >  
> > -		port->partner_altmode[pmdata->altmodes] =
> > -			typec_partner_register_altmode(port->partner, paltmode);
> > -		if (!port->partner_altmode[pmdata->altmodes]) {
> > -			tcpm_log(port,
> > -				 "Failed to register modes for SVID 0x%04x",
> > -				 paltmode->svid);
> > -			return;
> > -		}
> >  		pmdata->altmodes++;
> >  	}
> >  }
> >  
> > +static void tcpm_register_partner_altmodes(struct tcpm_port *port)
> > +{
> > +	struct pd_mode_data *modep = &port->mode_data;
> > +	struct typec_altmode *altmode;
> > +	int i;
> > +
> > +	for (i = 0; i < modep->altmodes; i++) {
> > +		altmode = typec_partner_register_altmode(port->partner,
> > +						&modep->altmode_desc[i]);
> > +		if (!altmode)
> > +			tcpm_log(port, "Failed to register partner SVID 0x%04x",
> > +				 modep->altmode_desc[i].svid);
> > +		port->partner_altmode[i] = altmode;
> > +	}
> > +}
> > +
> >  #define supports_modal(port)	PD_IDH_MODAL_SUPP((port)->partner_ident.id_header)
> >  
> >  static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
> >  			u32 *response)
> >  {
> > -	u32 p0 = le32_to_cpu(payload[0]);
> > -	int cmd_type = PD_VDO_CMDT(p0);
> > -	int cmd = PD_VDO_CMD(p0);
> > +	struct typec_altmode *altmode;
> >  	struct pd_mode_data *modep;
> > +	u32 p[PD_MAX_PAYLOAD];
> >  	int rlen = 0;
> > -	u16 svid;
> > +	int cmd_type;
> > +	int cmd;
> >  	int i;
> >  
> > +	for (i = 0; i < cnt; i++)
> > +		p[i] = le32_to_cpu(payload[i]);
> > +
> > +	cmd_type = PD_VDO_CMDT(p[0]);
> > +	cmd = PD_VDO_CMD(p[0]);
> > +
> >  	tcpm_log(port, "Rx VDM cmd 0x%x type %d cmd %d len %d",
> > -		 p0, cmd_type, cmd, cnt);
> > +		 p[0], cmd_type, cmd, cnt);
> >  
> >  	modep = &port->mode_data;
> >  
> > +	altmode = typec_match_altmode(port->port_altmode, ALTMODE_DISCOVERY_MAX,
> > +				      PD_VDO_VID(p[0]), PD_VDO_OPOS(p[0]));
> 
> This can return NULL ...
> 
> > +
> >  	switch (cmd_type) {
> >  	case CMDT_INIT:
> >  		switch (cmd) {
> > @@ -1036,17 +1054,21 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
> >  		case CMD_EXIT_MODE:
> >  			break;
> >  		case CMD_ATTENTION:
> > -			break;
> > +			typec_altmode_attention(altmode, p[1]);
> 
> ... and NULL is not handled by typec_altmode_attention().

True.

> > +			return 0;
> >  		default:
> > +			if (typec_altmode_vdm(altmode, p[0], &p[1], cnt) ==
> > +			    VDM_OK)
> 
> typec_altmode_vdm() returns old fashioned error messages.
> Not sure what it is supposed to return, though.

The idea was that the alternate mode driver can inform the port driver
that it not support a specific VDM. In that case we need to NAK.

I'll think about this a bit more.

> > +				return 0;
> >  			break;
> >  		}
> >  		if (rlen >= 1) {
> > -			response[0] = p0 | VDO_CMDT(CMDT_RSP_ACK);
> > +			response[0] = p[0] | VDO_CMDT(CMDT_RSP_ACK);
> >  		} else if (rlen == 0) {
> > -			response[0] = p0 | VDO_CMDT(CMDT_RSP_NAK);
> > +			response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
> >  			rlen = 1;
> >  		} else {
> > -			response[0] = p0 | VDO_CMDT(CMDT_RSP_BUSY);
> > +			response[0] = p[0] | VDO_CMDT(CMDT_RSP_BUSY);
> >  			rlen = 1;
> >  		}
> >  		break;
> > @@ -1079,20 +1101,26 @@ static int tcpm_pd_svdm(struct tcpm_port *port, const __le32 *payload, int cnt,
> >  			svdm_consume_modes(port, payload, cnt);
> >  			modep->svid_index++;
> >  			if (modep->svid_index < modep->nsvids) {
> > -				svid = modep->svids[modep->svid_index];
> > +				u16 svid = modep->svids[modep->svid_index];
> >  				response[0] = VDO(svid, 1, CMD_DISCOVER_MODES);
> >  				rlen = 1;
> >  			} else {
> > -				/* enter alternate mode if/when implemented */
> > +				tcpm_register_partner_altmodes(port);
> >  			}
> >  			break;
> >  		case CMD_ENTER_MODE:
> > +			typec_altmode_enter(altmode);
> 
> typec_altmode_enter() don't handle altmode == NULL.

True. I'll fix that as well.

> No error handling ?
> 
> > +			break;
> > +		case CMD_EXIT_MODE:
> > +			typec_altmode_exit(altmode);
> 
> Doesn't handle NULL. Error handling ?

True, and I'll add error handling for there.

> >  			break;
> >  		default:
> > +			typec_altmode_vdm(altmode, p[0], &p[1], cnt);
> >  			break;
> >  		}
> >  		break;
> >  	default:
> > +		typec_altmode_vdm(altmode, p[0], &p[1], cnt);
> >  		break;
> >  	}
> >  
> > @@ -1352,6 +1380,47 @@ static int tcpm_validate_caps(struct tcpm_port *port, const u32 *pdo,
> >  	return 0;
> >  }
> >  
> > +static void tcpm_altmode_enter(struct typec_altmode *altmode)
> > +{
> > +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> > +	u32 header;
> > +
> > +	header = VDO(altmode->svid, 1, CMD_ENTER_MODE);
> > +	header |= VDO_OPOS(altmode->mode);
> > +
> > +	tcpm_queue_vdm(port, header, NULL, 0);
> > +	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> > +}
> > +
> > +static void tcpm_altmode_exit(struct typec_altmode *altmode)
> > +{
> > +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> > +	u32 header;
> > +
> > +	header = VDO(altmode->svid, 1, CMD_EXIT_MODE);
> > +	header |= VDO_OPOS(altmode->mode);
> > +
> > +	tcpm_queue_vdm(port, header, NULL, 0);
> > +	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> > +}
> > +
> > +static int tcpm_altmode_vdm(struct typec_altmode *altmode,
> > +			    u32 header, const u32 *data, int count)
> > +{
> > +	struct tcpm_port *port = typec_altmode_get_drvdata(altmode);
> > +
> > +	tcpm_queue_vdm(port, header, data, count - 1);
> > +	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct typec_altmode_ops tcpm_altmode_ops = {
> > +	.enter = tcpm_altmode_enter,
> > +	.exit = tcpm_altmode_exit,
> > +	.vdm = tcpm_altmode_vdm,
> > +};
> > +
> >  /*
> >   * PD (data, control) command handling functions
> >   */
> > @@ -3479,6 +3548,23 @@ static void tcpm_init(struct tcpm_port *port)
> >  	tcpm_set_state(port, PORT_RESET, 0);
> >  }
> >  
> > +static int tcpm_activate_mode(struct typec_altmode *alt, int activate)
> > +{
> > +	struct tcpm_port *port = typec_altmode_get_drvdata(alt);
> > +	u32 header;
> > +
> > +	header = VDO(cpu_to_le16(alt->svid), 1,
> > +		     activate ? CMD_ENTER_MODE : CMD_EXIT_MODE);
> > +	header |= VDO_OPOS(alt->mode);
> > +
> > +	mutex_lock(&port->lock);
> > +	tcpm_queue_vdm(port, header, NULL, 0);
> > +	mod_delayed_work(port->wq, &port->vdm_state_machine, 0);
> > +	mutex_unlock(&port->lock);
> 
> Some of the above functions are port mutex protected, some are not.
> Is this on purpose ?

No. The plan is to always use the mutex.

I can't call typec_altmode_enter/exit() directly from tcpm_pd_svdm()
because the alternate mode drivers may call typec_altmode_enter() from
their probe drivers. I guess the solution is that instead of directly
calling typec_altmode_enter/exit() from tcpm_pm_svdm(), we schedule a
work where we call them. Or would you have some better ideas for this?

For this RFC I just hacked it and didn't use the mutex in
tcpm_altmode_enter/exit().


Thanks for reviewing these,

-- 
heikki
