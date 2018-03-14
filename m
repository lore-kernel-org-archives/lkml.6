Date: Wed, 14 Mar 2018 19:56:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, cantabile.desu@gmail.com, kubakici@wp.pl,
	linux-wireless@vger.kernel.org, keescook@chromium.org,
	shuah@kernel.org, mfuzzey@parkeon.com, zohar@linux.vnet.ibm.com,
	dhowells@redhat.com, pali.rohar@gmail.com, tiwai@suse.de,
	arend.vanspriel@broadcom.com, zajec5@gmail.com, nbroeking@me.com,
	markivx@codeaurora.org, broonie@kernel.org,
	dmitry.torokhov@gmail.com, dwmw2@infradead.org,
	torvalds@linux-foundation.org, Abhay_Salunke@dell.com,
	bjorn.andersson@linaro.org, jewalt@lgsinnovations.com,
	oneukum@suse.com, ast@fb.com, andresx7@gmail.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 07/20] firmware: move loading timeout under struct
 firmware_fallback_config
Message-ID: <20180314185634.GC15837@kroah.com>
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <20180310141501.2214-8-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310141501.2214-8-mcgrof@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Mar 10, 2018 at 06:14:48AM -0800, Luis R. Rodriguez wrote:
> The timeout is a fallback construct, so we can just stuff the
> timeout configuration under struct firmware_fallback_config.

Why?  What does it matter?

> While at it, add a few helpers which vets the use of getting or
> setting the timeout as an int. The main use of the timeout is
> to set a timeout for completion, and that is used as an unsigned
> long. There a few cases however where it makes sense to get or
> set the timeout as an int, the helpers annotate these use cases
> have been properly vetted for.

This feels really odd to me.  Why would you want to use it as an int,
just keep it the same "size" everywhere and it should be simpler and
easier to keep working correctly over time.

thanks,

greg k-h
