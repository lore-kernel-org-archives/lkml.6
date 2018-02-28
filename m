Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AH8x226wf8leE39WZWnMgap7n0oWMDpH4/wLe10ZMz39oobxaxj/mQbjnyYqEVLQ0dbXu/iqttge
ARC-Seal: i=1; a=rsa-sha256; t=1519780894; cv=none;
        d=google.com; s=arc-20160816;
        b=oqOR3hSo0WwBs6DBDkrxRc5ZIUHM6muCH4PqIVLJutGDbb5WSsN0LLhpgtVR5/nKRX
         8sWykTcP+HJg1m6CBhqFJVIWwy7jUX9oFqux/YdBLE34xic30tYBI9o1BiSfM7mLshfr
         EoRReHhlE0dQ6N5rtvs2SFo/lp9rukndrNT56sHPoqo+UkqVRCQRYcl7AuxkurYcV9jW
         9sr7lsgilIr7R8wWoO26a/WAuG6qLJb2DxTpdP4Iyuvw8lQRNz4qBmA8d39VwAwQPFzo
         4i1cn13fNFUJDgkseBEdC67q91XHY9rAHeQtNcr8vJW9SCkofLML+eSeTdvbvW/k+p4s
         Gb2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=djvMFnf9uMToC6uzy7k2cXrUnJmI3iGH1sMO4qht600=;
        b=SSqVOJncd1W7C1LrN9h+IvOyC7iIxbayLwp7032494c1kzfSEUFbSvwaz00tBNR5dN
         zWaYyES7xCgDGbp0M7gneD8Lp+FVWk3gZv8AXf0Pn9dOhYQcSfQabROTKx/syULOQ0x6
         ZvHYE6qizX0+oARmVj8bxas+b2+6N+pMiuSdw/TYlxp4qvtfexf5TZ4v5z0EexMIlhhB
         Y2F2A7tfljqsSz4zadNazW++xcjL4JS8aJk60/dZ1VIKdt9YSSRnel3BSYz/T9uMsc5Z
         iJ0DrzeHnSrGZP0mNO2LPmzgoV2jChGdCeQk6e4qe9bI2trYKbxzifb2trDLujUj/I2O
         STCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Wed, 28 Feb 2018 01:21:31 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, cantabile.desu@gmail.com,
	Jakub Kicinski <kubakici@wp.pl>,
	Greg KH <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-wireless <linux-wireless@vger.kernel.org>,
	Shuah Khan <shuah@kernel.org>, Martin Fuzzey <mfuzzey@parkeon.com>,
	Mimi Zohar <zohar@linux.vnet.ibm.com>,
	David Howells <dhowells@redhat.com>, pali.rohar@gmail.com,
	Takashi Iwai <tiwai@suse.de>, arend.vanspriel@broadcom.com,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	nbroeking@me.com, Vikram Mulukutla <markivx@codeaurora.org>,
	stephen.boyd@linaro.org, Mark Brown <broonie@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Abhay_Salunke@dell.com, bjorn.andersson@linaro.org,
	jewalt@lgsinnovations.com, oneukum@suse.com,
	LKML <linux-kernel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [RFT 1/7] rename: _request_firmware_load()
 fw_load_sysfs_fallback()
Message-ID: <20180228012131.GF14069@wotan.suse.de>
References: <20180227232101.20786-1-mcgrof@kernel.org>
 <20180227232101.20786-2-mcgrof@kernel.org>
 <CAGXu5jJwRU1mMH-erQmHLsrDgu1zmYOMrWiG_A_r3tksufLHDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJwRU1mMH-erQmHLsrDgu1zmYOMrWiG_A_r3tksufLHDg@mail.gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593598193855582168?=
X-GMAIL-MSGID: =?utf-8?q?1593605770748805045?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 03:28:21PM -0800, Kees Cook wrote:
> On Tue, Feb 27, 2018 at 3:20 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> > This reflects much clearer what is being done.
> >
> > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > ---
> >  Documentation/driver-api/firmware/fallback-mechanisms.rst | 2 +-
> >  drivers/base/firmware_fallback.c                          | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/driver-api/firmware/fallback-mechanisms.rst b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > index 4055ac76b288..f353783ae0be 100644
> > --- a/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > +++ b/Documentation/driver-api/firmware/fallback-mechanisms.rst
> > @@ -112,7 +112,7 @@ Since a device is created for the sysfs interface to help load firmware as a
> >  fallback mechanism userspace can be informed of the addition of the device by
> >  relying on kobject uevents. The addition of the device into the device
> >  hierarchy means the fallback mechanism for firmware loading has been initiated.
> > -For details of implementation refer to _request_firmware_load(), in particular
> > +For details of implementation refer to fw_load_sysfs_fallback(), in particular
> >  on the use of dev_set_uevent_suppress() and kobject_uevent().
> >
> >  The kernel's kobject uevent mechanism is implemented in lib/kobject_uevent.c,
> > diff --git a/drivers/base/firmware_fallback.c b/drivers/base/firmware_fallback.c
> > index 13fa5ff2b46c..ce7ccfe82c69 100644
> > --- a/drivers/base/firmware_fallback.c
> > +++ b/drivers/base/firmware_fallback.c
> > @@ -536,7 +536,7 @@ fw_create_instance(struct firmware *firmware, const char *fw_name,
> >  }
> >
> >  /* load a firmware via user helper */
> 
> As long as this is being renamed, maybe add full kern-doc for this function?

Sure why not.

 Luis
