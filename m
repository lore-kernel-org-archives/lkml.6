Return-Path: <mark.rutland@arm.com>
X-Google-Smtp-Source: AH8x225MzEFPKAnJGNTmyo2V44QuvvljAd3T8vnPw9PjfnzycYtUY9sXejV6Poyay9Ixg5sfRmqR
ARC-Seal: i=1; a=rsa-sha256; t=1517481207; cv=none;
        d=google.com; s=arc-20160816;
        b=tRLO8HDaUrggJzJcd2BvUT3aPkAs0Vu4t90ou/RlDvPUNdclGFFriUpBR7O61gFv2I
         QXIyWIU5wPTXOJtEWsbsInkVBJovnVXXwe4u4RW/7RUnQqgJSfiTAsYLuFg57W1i+w0N
         5Hq7YRwfWWgK0gPT4HY1sQe1CVkAwbaNdTV74l6UYgnnhyQWjGmr/k1MCuJ2aaBVKTHD
         Gzz0Zk2STrYCFpRNjpQ95nCxWylrsAOizhSs4LdeE3q64F/Fp07ijkr3IGuvgS5dlFdQ
         yh8blJ1C/x1NipRNjzDjWn8JIIcNvu5AaBf8fMmuSfoAamSIVXiM9Pis2so6ob2EPJm1
         XYpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=ow2LFr1cjZOh5X2dXEV8PMxkene4DamZiy6PYTKxe3U=;
        b=cerc7cxWyxoO8X/+mdjbDLl2bsXbo8uyncMF/s9g5mWL5szf9AvnhOmwPoFu7RBooc
         9pXujcry9Mw98MXjW482Hlpd1Sg+gjn+yDLLlrBcdmkB7tKLxdNclOrvkls34oPoE81W
         isb/zqcekazB4oufqEEM4HuKhLAPSevtarlazC2uqfFM9DYoz1KfHEoen6L1a6cb/Rgu
         bDYn3kZKuklDiUWuiSmOj0aMnnfigujM0Q/zTrn10HbJiG6mQgLneVXKb+bkblWYUtiN
         aOAdnkq10EQJsyhe4WNUTdsMKMxBuEuyW/JEJCaJR9forzfOmLOiiUC+uz8uQBXG35F9
         /Bmw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of mark.rutland@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=mark.rutland@arm.com
Date: Thu, 1 Feb 2018 10:33:21 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Jolly Shah <JOLLYS@xilinx.com>
Cc: "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
	"mingo@kernel.org" <mingo@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"keescook@chromium.org" <keescook@chromium.org>,
	"dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
	"michal.simek@xilinx.com" <michal.simek@xilinx.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Rajan Vaja <RAJANV@xilinx.com>
Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
 driver
Message-ID: <20180201103321.fftn37mgzbk6oltl@lakrids.cambridge.arm.com>
References: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
 <1516836074-4149-3-git-send-email-jollys@xilinx.com>
 <20180131182012.oshjmvahetaizlbu@lakrids.cambridge.arm.com>
 <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY1PR0201MB0764D88D409A35B8379323B4B8FA0@CY1PR0201MB0764.namprd02.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590517939735530008?=
X-GMAIL-MSGID: =?utf-8?q?1591194374635723828?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 01, 2018 at 01:23:48AM +0000, Jolly Shah wrote:
> Hi Mark,
> Thanks for the review,
> 
> > -----Original Message-----
> > From: Mark Rutland [mailto:mark.rutland@arm.com]
> > Sent: Wednesday, January 31, 2018 10:20 AM
> > To: Jolly Shah <JOLLYS@xilinx.com>
> > Cc: ard.biesheuvel@linaro.org; mingo@kernel.org;
> > gregkh@linuxfoundation.org; matt@codeblueprint.co.uk;
> > sudeep.holla@arm.com; hkallweit1@gmail.com; keescook@chromium.org;
> > dmitry.torokhov@gmail.com; michal.simek@xilinx.com; robh+dt@kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > devicetree@vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> > <RAJANV@xilinx.com>
> > Subject: Re: [PATCH v3 2/4] drivers: firmware: xilinx: Add ZynqMP firmware
> > driver
> > 
> > On Wed, Jan 24, 2018 at 03:21:12PM -0800, Jolly Shah wrote:
> > > This patch is adding communication layer with firmware.
> > > Firmware driver provides an interface to firmware APIs.
> > > Interface APIs can be used by any driver to communicate to
> > > PMUFW(Platform Management Unit). All requests go through ATF.
> > 
> > > +/**
> > > + * zynqmp_pm_set_wakeup_source - PM call to specify the wakeup source
> > > + *					while suspended
> > > + * @target:	Node ID of the targeted PU or subsystem
> > > + * @wakeup_node:Node ID of the wakeup peripheral
> > > + * @enable:	Enable or disable the specified peripheral as wake source
> > > + *
> > > + * Return:	Returns status, either success or error+reason
> > > + */
> > > +static int zynqmp_pm_set_wakeup_source(const u32 target,
> > > +				       const u32 wakeup_node,
> > > +				       const u32 enable)
> > > +{
> > > +	return invoke_pm_fn(PM_SET_WAKEUP_SOURCE, target,
> > > +			    wakeup_node, enable, 0, NULL); }
> > 
> > I see many functions take a "Node ID" parameter, but these don't appear to be
> > in any DT binding, and drivers (other than the debugfs driver) aren't using them.
> > 
> > What's the plan for making use of these? Where are the node IDs going to come
> > from in practice?
> > 
> Node ids are defined in firmware.h. Node id refers to targeted PU/subsystem/peripheral for required action.

Ok. What I was asking was how a node id would be associated with
particular peripheral instances (which are presumably going to be nodes
in the DT).

e.g. if I have

	device@foo {
		compatible = "xlnx,some-device";
		reg = <0xf00 0x100>;
		...
	};

... how does the kernel know which node id(s) the device is associated
with?

I assume that those will need something like a xlnx,eemi-node-id
property.

[...]

> > > +/**
> > > + * zynqmp_pm_pinctrl_request - Request Pin from firmware
> > > + * @pin:	Pin number to request
> > > + *
> > 
> > No DT binding for the pinctrl bits?
> > 
> > [...]
> It doesn't require any bindings. Calling drivers will have DT binding for pins they use. 

For those drivers to be able to refer to the EEMI FW as a pin
controller, we'll need a pinctrl node in the DT (and hence a binding).

> > > +/**
> > > + * zynqmp_pm_clock_enable - Enable the clock for given id
> > > + * @clock_id:	ID of the clock to be enabled
> > > + *
> > 
> > Likewise for the clocks?
> >
> It doesn't require bindings too. 

As with pinctrl, for drivers to be able to refer to these clocks, we'll
need a clock node in the DT (and hence a binding).

Thanks,
Mark.
