Return-Path: <BATV+815ad0f354bf9734604b+5377+infradead.org+hch@bombadil.srs.infradead.org>
X-Google-Smtp-Source: AB8JxZrQtTath8nPMXHySTfwyKuHvbvwz90/MD8Q5HFKsRfCeVK9IQ0vgOagJxLl3yFo5rDT78Fg
ARC-Seal: i=1; a=rsa-sha256; t=1526299422; cv=none;
        d=google.com; s=arc-20160816;
        b=OkP4IpDm3ddwYt0Td23zvzfty9MNB2PNmyRyTxrgkAx9Oe8eYV2aV5qhkfPnjmsHtY
         H455U8/gw0wwNQzrB1my2KBFmWIYqeaS2xJcXdZlYSFHbaOBsRz/P0gCgv2RpF6IjzqM
         V+/qAZrBtRiVq/UHyJ6a+tx4zRfPZyVddNJj2tv6g7XCNoK1bzlrImJp6NznKkdymIGr
         InLNFfpL1b4qBQ/V6MN+GBJpvQBhr6J6VrY769bxFbwynK2qnc/yj7o+g0YM18OHVEXm
         zzK0GKmHA+AlQrvb0sz/lHDS/LHJRKZ1rBCTO5KiGSFf1n1s1v4jc5IJ89etqT70Hy6z
         6EHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=DUKKA3wRh/Dko50nfHUwV8AOSM3xfM3szlbJss8TfxU=;
        b=RGGRwT0hQeSU8UQ/DQsoiyQgVc+eNbVVDt7QUe6PbSgzhhywA7ERDwRHtgmJDF28iW
         Ya5vRxHUiM3lfQXIpNjUMvJIS3DY+Zook2GqBoDuqklqU7Y84XM/yvdgMP4E05i8QwE+
         UOcXoGGbe1GMD+Cc7CReKeIzpROcDDQ8JtELhBIMq+F0h1r5Kw2bGdLifoGcapSk/mhe
         4IbuaAHSEq8hKfO71ZfFMM5nLNe+hfM5jaAGMu8IUw52lWYTbS/M3pjv79rOUQqC+7WF
         RLzMtLYYNdVHFTpQ8jtb++awJB38XnV0xBHEud5r47YCrj0lVLi3r5OBiUTZRgiv7IKM
         YjDg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=FB7+Pqw0;
       spf=pass (google.com: best guess record for domain of batv+815ad0f354bf9734604b+5377+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+815ad0f354bf9734604b+5377+infradead.org+hch@bombadil.srs.infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=FB7+Pqw0;
       spf=pass (google.com: best guess record for domain of batv+815ad0f354bf9734604b+5377+infradead.org+hch@bombadil.srs.infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=BATV+815ad0f354bf9734604b+5377+infradead.org+hch@bombadil.srs.infradead.org
Date: Mon, 14 May 2018 05:03:38 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Martijn Coenen <maco@android.com>
Cc: kbuild test robot <lkp@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
	kbuild-all@01.org, John Stultz <john.stultz@linaro.org>,
	Todd Kjos <tkjos@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
	LKML <linux-kernel@vger.kernel.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
	Martijn Coenen <maco@google.com>, geert@linux-m68k.org,
	linux-m68k@lists.linux-m68k.org
Subject: Re: [PATCH] ANDROID: binder: remove 32-bit binder interface.
Message-ID: <20180514120338.GA5265@infradead.org>
References: <20180504195728.72932-1-maco@android.com>
 <201805060540.zjwonWcp%fengguang.wu@intel.com>
 <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAB0TPYG-Q6Ki_FMM1u+i_g+0ykQgeUTRpm00qycAUVQOqVH6eQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599564783998052037?=
X-GMAIL-MSGID: =?utf-8?q?1600440942976965758?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, May 11, 2018 at 09:57:52AM +0200, Martijn Coenen wrote:
> On Sat, May 5, 2018 at 2:10 PM, kbuild test robot <lkp@intel.com> wrote:
> >    drivers/android/binder.o: In function `binder_thread_write':
> >>> binder.c:(.text+0x6a16): undefined reference to `__get_user_bad'
> 
> Looks like m68k doesn't support 64-bit get_user(). I could just have
> binder depend on !CONFIG_M68K, but there may be other architectures
> still that don't support this. Another alternative would be to
> whitelist the architectures Android supports - eg arm, arm64, x86,
> x86_64. But I'm not sure if arch-limited drivers are considered bad
> form. Does anybody have suggestions for how to deal with this?

The proper fix is to just support 640bit get/put_user on m68k instead
of working around this.
