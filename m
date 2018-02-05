Return-Path: <daniel.thompson@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1517841595; cv=none;
        d=google.com; s=arc-20160816;
        b=izLl00yTOH+WTeJHCLe+obh4azd4DaHJmKFrD7JHBrjF3SUgvaQ7rzaxWPFPWyXkDS
         sl18gmbnn5ZmKERyDxgszQRVzqnKbUxeUSrBrJNyMASEDEM5ku9gspMc/8Sd47pYLeVv
         3iUX0tmK80O3A5Wq32rNN4bsWkWduxKdiFJE1C5Icj6S7+nY+kkPvfukvShBQwGIO+qF
         9zPF6ZngNSlGvVeJt5LmY8sxRfvNdDy8jcfXuAfRMlBzf4oj3rXHjeHD5x/qSTucavlw
         7Utfff+xIHDPObd8ocIo8E+hCDzRfrcN0TQVfLYWO7YROWmQSNef0BCSLGEOOc+mhhtY
         y7sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=The+VmksUU+wdS1gOCSUKFItl7UKWROrOobQD1cAP/A=;
        b=ivt+uQjE6WsFX/FKBTur3svcGx+DkRP92g9XeoO9wXyYegfD+RAGgEt0jf/vm3TFEM
         I62rejniWuJSbLx+NP3VBxGVT3R2QoNt8PgCXM48BAzzUGMydEsS+0C0lhfam4ywx7pE
         Un2uADvGA9UV+dbXuMFu9G0btOnsfPchdOXKC4RimWn1bw+2bvabT84DWLWMv6w/3Szg
         WHeUyJorTbzE6KCvpaOMWJxMQVnp+SElyou34bIpOOlg/FQ23+aK/dLUztsp17obPJvN
         J670VPjbDN+G+zFRkBSEuOSGmsHy9ZbLNqKw/mSrO50fT7sJSJ9Omf4FG4inRFIOBO1U
         BqyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PNYh0DcR;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=PNYh0DcR;
       spf=pass (google.com: domain of daniel.thompson@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=daniel.thompson@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AH8x226GNntBmrXNbRwT/LNT8D/+DkVEwO1EHnmwiPVN9OldYDaFQ4CRGkxoO0sb4iSKkLjWNzlsYQ==
Date: Mon, 5 Feb 2018 14:39:52 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Milo Kim <milo.kim@ti.com>,
	linux-fbdev@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
	Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Julia Lawall <julia.lawall@lip6.fr>,
	Greg KH <gregkh@linuxfoundation.org>,
	Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-ID: <20180205143952.tqzywm6wtgw23jvb@oak.lan>
References: <cover.1516978005.git.aishpant@gmail.com>
 <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
 <20180131110727.rmmwyqzwozwhda6z@oak.lan>
 <878tceckli.fsf@intel.com>
 <20180201113604.kcue6auuivud52qz@oak.lan>
 <20180205072550.GA9376@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205072550.GA9376@mordor.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1590666949916676069?=
X-GMAIL-MSGID: =?utf-8?q?1591572268764431126?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 05, 2018 at 12:55:50PM +0530, Aishwarya Pant wrote:
> On Thu, Feb 01, 2018 at 11:36:04AM +0000, Daniel Thompson wrote:
> > On Wed, Jan 31, 2018 at 01:51:21PM +0200, Jani Nikula wrote:
> > > On Wed, 31 Jan 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > > On Fri, Jan 26, 2018 at 08:20:08PM +0530, Aishwarya Pant wrote:
> > > >> Add documentation for sysfs interfaces of lp8788 backlight driver by
> > > >> looking through the code and the git commit history.
> > > >> 
> > > >> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > > >> ---
> > > >>  Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
> > > >>  1 file changed, 10 insertions(+)
> > > >>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> 
> > > >> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> new file mode 100644
> > > >> index 000000000000..c0e565c8d63d
> > > >> --- /dev/null
> > > >> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> @@ -0,0 +1,10 @@
> > > >> +sysfs interface for Texas Instruments lp8788 mfd backlight driver
> > > >> +-----------------------------------------------------------------
> > > >> +
> > > >> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> > > >> +Date:		Feb, 2013
> > > >> +KernelVersion:	v3.10
> > > >> +Contact:	Milo Kim <milo.kim@ti.com>
> > > >> +Description:
> > > >> +		(RO) Displays whether the brightness is controlled by the PWM
> > > >> +		input("PWM based") or the I2C register("Register based").
> > > >
> > > > I rather dislike drivers with this type of "bonus" sysfs controls. I'm
> > > > struggling to come up with any reason why the userspace would want to
> > > > read this control (and I think bl_ctl_mode gets the fewest hits after
> > > > searching with google hits of any search I've tried) . It looks to me 
> > > > like this is debug information that should never have gone into sysfs 
> > > > at all.
> > > 
> > > Agreed. I think the same holds for the other extra sysfs attributes. At
> > > worst, having these prevents the backlight class from adding the names
> > > later on, which is just backwards.
> > 
> > The problem is that they do exist...
> > 
> > For controls which appear to be misplaced debug attributes I think I am
> > happy to nuke the values entirely. It is extremely improbable that any
> > userspace will notice.
> > 
> > Unfortunately some of the controls look like they could be poked by an
> > custom userspace so I'm quite so confident about nuking these ones...and if we
> > don't nuke we should document (so thanks Aishwarya!). 
> > 
> 
> Hi
> 
> Thanks for reviewing. Should I take it to assume that we would like to keep the
> debug-like attributes in documentation for now?

The opposite I think!

Can you drop patch 1/2 from this series, tidy the maintainer values, etc
and resubmit?

If you want to propose patches to remove the debug attributes from the
TI drivers that's up to you (perhaps adding a dev_dbg() containing
equivalent information). If you want to you are welcome to add to these:
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
