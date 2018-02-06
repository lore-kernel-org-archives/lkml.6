Date: Tue, 6 Feb 2018 01:28:23 -0800
From: Greg KH <greg@kroah.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: Mark Brown <broonie@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Abhijeet Kumar <abhijeet.kumar@intel.com>
Subject: Re: [PATCH AUTOSEL for 4.14 029/110] ASoC: nau8825: fix issue that
 pop noise when start capture
Message-ID: <20180206092823.GA31558@kroah.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-29-alexander.levin@microsoft.com>
 <20180205114154.GB12384@sirena.org.uk>
 <20180206014120.pdudjvme5zwofdxp@sasha-lappy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180206014120.pdudjvme5zwofdxp@sasha-lappy>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 06, 2018 at 01:41:29AM +0000, Sasha Levin wrote:
> On Mon, Feb 05, 2018 at 11:41:54AM +0000, Mark Brown wrote:
> >On Sat, Feb 03, 2018 at 06:00:42PM +0000, Sasha Levin wrote:
> >> From: Abhijeet Kumar <abhijeet.kumar@intel.com>
> >>
> >> [ Upstream commit d070f7c703ef26e3db613f24206823f916272fc6 ]
> >>
> >> In skylake platform, we hear a loud pop noise(0 dB) at start of
> >> audio capture power up sequence. This patch removes the pop noise
> >> from the recording by adding a delay before enabling ADC.
> >
> >>  	switch (event) {
> >>  	case SND_SOC_DAPM_POST_PMU:
> >> +		msleep(125);
> >>  		regmap_update_bits(nau8825->regmap, NAU8825_REG_ENA_CTRL,
> >
> >This is another one of these where I'm not convinced that backporting to
> >stable isn't going to introduce regressions - it will fix problems on
> >some systems but if someone really cares about a startup pop and has
> >arranged to do something like discard the start of the audio where the
> >pop occurs then this may cut off even more and cause them to miss
> >things.
> 
> It might cause regressions for users who worked around the issue, but it
> may also fix the issue for users who didn't. I think that in general
> we'd rather have mainline and stable trees have the same bugs and
> breakage - we don't want surprises when users jump around between
> kernels.

Yes, being "bug compatible" is a key feature to have :)

thanks,

greg k-h
