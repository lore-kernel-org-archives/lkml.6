Date: Fri, 6 Apr 2018 09:21:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Marc Zyngier <marc.zyngier@arm.com>,
	Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.4 15/97] genirq: Use irqd_get_trigger_type to compare
 the trigger type for shared IRQs
Message-ID: <20180406072149.GA15735@kroah.com>
References: <20180323094157.535925724@linuxfoundation.org>
 <20180323094158.346866234@linuxfoundation.org>
 <1522765036.2654.99.camel@codethink.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1522765036.2654.99.camel@codethink.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 03, 2018 at 03:17:16PM +0100, Ben Hutchings wrote:
> On Fri, 2018-03-23 at 10:54 +0100, Greg Kroah-Hartman wrote:
> > 4.4-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > From: Hans de Goede <hdegoede@redhat.com>
> > 
> > 
> > [ Upstream commit 382bd4de61827dbaaf5fb4fb7b1f4be4a86505e7 ]
> > 
> > When requesting a shared irq with IRQF_TRIGGER_NONE then the irqaction
> > flags get filled with the trigger type from the irq_data:
> > 
> >         if (!(new->flags & IRQF_TRIGGER_MASK))
> >                 new->flags |= irqd_get_trigger_type(&desc->irq_data);
> 
> The code above was added to __setup_irq() in 4.8, so I don't think this
> fix is needed in 3.18 or 4.4; and I suspect it might cause a regression
> there.

Already reverted, thanks!

greg k-h
