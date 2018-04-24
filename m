Date: Tue, 24 Apr 2018 08:22:46 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: xswang@marvell.com
Cc: linux-ide@vger.kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, oferh@marvell.com, dingwei@marvell.com,
	xigu@marvell.com, nadavh@marvell.com,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 2/2] ata: ahci: mvebu: override ahci_stop_engine for
 mvebu AHCI
Message-ID: <20180424062246.GB14537@kroah.com>
References: <1524542805-11349-1-git-send-email-xswang@marvell.com>
 <1524542805-11349-3-git-send-email-xswang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524542805-11349-3-git-send-email-xswang@marvell.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 12:06:45PM +0800, xswang@marvell.com wrote:
> From: Evan Wang <xswang@marvell.com>
> 
> There is an issue(Errata Ref#226) that the SATA can not be
> detected via SATA Port-MultiPlayer(PMP) with following
> error log:
>   ata1.15: PMP product ID mismatch
>   ata1.15: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
>   ata1.15: Port Multiplier vendor mismatch '0x1b4b'!='0x0'
>   ata1.15: PMP revalidation failed (errno=-19)
> 
> After debugging, the reason is found that the value Port-x
> FIS-based Switching Control(PxFBS@0x40) become wrong.
> According to design, the bits[11:8, 0] of register PxFBS
> are cleared when Port Command and Status (0x18) bit[0]
> changes its value from 1 to 0, i.e. falling edge of Port
> Command and Status bit[0] sends PULSE that resets PxFBS
> bits[11:8; 0].
> So it needs a mvebu SATA WA to save the port PxFBS register
> before PxCMD ST write and restore it afterwards.
> 
> This patch implements the WA in a separate function of
> ahci_mvebu_stop_engine to override ahci_stop_gngine.
> 
> Signed-off-by: Evan Wang <xswang@marvell.com>
> Suggested-by: Ofer Heifetz <oferh@marvell.com>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> ---
>  drivers/ata/ahci_mvebu.c | 56 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 56 insertions(+)


<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
