Return-Path: <lurodriguez@suse.de>
X-Google-Smtp-Source: AG47ELuucIsz79OXmuzTiRKKp8xcLklQYnuhvYQUvY7RFfSACT9Hs+kmGcT/LC1q0WFtiMttap1w
ARC-Seal: i=1; a=rsa-sha256; t=1521567252; cv=none;
        d=google.com; s=arc-20160816;
        b=EFEUr3AtQje0i68UZSpOXxtZx/RkGQMeFSCLEet+zjin+1j2ssQpoRGb2Gy4X+UfSO
         exHDvLFYrRME7/OIsvsCVIkEZWzPMYvcjWku179yGnWAak9dl2+RJOoM/TDJQ0U8hz7I
         9+mRJA7jew/2SFyQG0RtcnleBlCCUrt4ty3RqUwGOOBJZQFTKry+dBgVh0bBQNEbWP7G
         mZ3HbUM1qSyqek2z5qXb0luneKpFB36WstEOONnwWtQPkKXqWh3xaUMVf5IB6V7KLW60
         TNTmiTSGtyNN/dyv5CKJ7awtPYuWNXECDuVfoIvn9asX7xyyrXFOpE9evTealNrt93/U
         Hjaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=sp0UfhZ8KDjRlvvJ+qDZ9k9gn6SMh/La4P/ZxYDt+4Q=;
        b=hKkOcv79nTNgLKYzJE1TMBhgaW7RKTaR3BlOwfgPa6HN04OzK4pBalbUQ5BUlV50ju
         mQdVUqYuk1e/9gHJRAl8DoyWtD3R5XGFKKsRlrk7tFWDLZTENqoXCwJM1zdi1XkY3VQh
         2uSAnVkWThpZXGMiOBVUDXYymBhgOoRGfL8iS9VNUqZxL6OYWQniBgNBiWwNx8qyx+Lg
         QSRicq9Jk1iahjFTPaBgS936jksckLroe91cNhyETelX7wBeWmEg70/efFhicFkrIZRR
         KZeqQVIRDWyontLE4mXxCDwYTJakaQrBf5KVqe5EPjPiW9rqwocX1fkeb2YAe6osf4D0
         W7HA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of lurodriguez@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=lurodriguez@suse.de
Date: Tue, 20 Mar 2018 17:34:09 +0000
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>, akpm@linux-foundation.org,
	cantabile.desu@gmail.com, kubakici@wp.pl,
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
Subject: Re: [PATCH v3 19/20] firmware: add request_firmware_cache() to help
 with cache on reboot
Message-ID: <20180320173409.GD4449@wotan.suse.de>
References: <20180310141501.2214-1-mcgrof@kernel.org>
 <20180310141501.2214-20-mcgrof@kernel.org>
 <20180320083055.GA21640@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180320083055.GA21640@kroah.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594560438545867805?=
X-GMAIL-MSGID: =?utf-8?q?1595478903769905449?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:30:55AM +0100, Greg KH wrote:
> On Sat, Mar 10, 2018 at 06:15:00AM -0800, Luis R. Rodriguez wrote:
> > +EXPORT_SYMBOL_GPL(request_firmware_cache);
> 
> I know you are just following the existing naming scheme, but please
> let's not continue the problem here.  Can you prefix all of the firmware
> exported symbols with "firmware_", and then the verb.  So this would be
> "firmware_request_cache",

Sure.

>  and the older function would be
> "firmware_request_direct".

Sure, so you want to also rename the old exported symbols, and add a macro
or static inline to enable use of the older names?

> I've stopped here in the patch series, applying the others now, so feel
> free to rebase and resend what I've missed, and the minor fixups for the
> prior patches.

Sure thing.

   Luis
