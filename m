Date: Mon, 19 Mar 2018 08:40:19 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kirill Marinushkin <k.marinushkin@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Thomas Gleixner <tglx@linutronix.de>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix parsing descriptor of UAC2
 processing unit
Message-ID: <20180319074019.GA30688@kroah.com>
References: <20180319061108.24178-1-k.marinushkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319061108.24178-1-k.marinushkin@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:11:08AM +0100, Kirill Marinushkin wrote:
> Currently, the offsets in the UAC2 processing unit descriptor are
> calculated incorrectly. It causes an issue when connecting the device which
> provides such a feature:
> 
> ~~~~
> [84126.724420] usb 1-1.3.1: invalid Processing Unit descriptor (id 18)
> ~~~~
> 
> After this patch is applied, the UAC2 processing unit inits w/o this error.
> 
> Fixes: 5e1ddb481776 ("UAPI: (Scripted) Disintegrate include/linux/usb")
> Signed-off-by: Kirill Marinushkin <k.marinushkin@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> ---
>  include/uapi/linux/usb/audio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

	Cc: stable <stable@vger.kernel.org>
 perhaps?
