Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x226hYJY2yjkwap+3GfZ2VmKrIwRdnwSAfg7iKf7VFiZzJoc+YxZNCzID1brdtssBVcC5z7uU
ARC-Seal: i=1; a=rsa-sha256; t=1518593694; cv=none;
        d=google.com; s=arc-20160816;
        b=bs5RJNMEyRyI5JUXHzz+HshxhZA7ihOMcQ5ybvhlHhLb7ql4sdO6fUJVDnb6Fw6sGV
         c25cz4lVuhLuTV9NYK4laMAhyZsR5+uWV/++fMFq6cCwC3W58k1ukdSGxyCpBEbStEZf
         BXcBNOhS3IQbmIGpkN+US7qmc2qg4r2TjFWCYT05NOFWwrga6SOpkEHM4VnBvuaX1tR4
         5sjOTHDHqXYl1kKecQLIaEgPnjdSWpgEgvjlGHLIl2Vab2QR11en4ac6KtqkohW7UfVq
         gNdBpxrN0JQvEQffohVLO8NZUdu2eWfOsdRG115gwtYQrvVqp2ajmN+oSDLG+hv/v7LH
         3ymw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=XHEtzGNdAYJCj52FyMKDOfMkX3XqqE9faWdS8160RPY=;
        b=GrC6zOCV8wXgLuvg7DIdSNUwP77/x4zKIdXcxQ6OJPbat6UXZLCIYQOPJG7GfGr7Ch
         FXSnrtUrUVDqUsjfZYcyZUQqfEhVddRcNFOJcZTVZiHBOv7w4s816VaZ9bVhm6/WdNK+
         AVxRjzByOfayerm3Tf+kMqMthCGTQgAcHalkVydffo0LPEuo7/x4mWVAmp6N5X+QaZIx
         dz8zHJ+fAS8jYDnYhiye4aig67JMg/aaHoO+rWREEaaGzTqfmPJCcuYFikWHIuXn9lxG
         JIjsYohgYmqpqd5ITkRlIiSAxyFk7/LLoNH+QGaW+jNSdZKsuIFFNPH+cSCzja1BRsF0
         L9sQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=i5eo20KT;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=i5eo20KT;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.79 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 14 Feb 2018 10:34:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
        Stephen Hemminger <stephen@networkplumber.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "olaf@aepfle.de" <olaf@aepfle.de>,
        "apw@canonical.com" <apw@canonical.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "leann.ogasawara@canonical.com" <leann.ogasawara@canonical.com>,
        "marcelo.cerri@canonical.com" <marcelo.cerri@canonical.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: Re: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for
 stimer0
Message-ID: <20180214073434.3u7l7nnncvujstyp@mwanda>
References: <20180212002958.6679-1-kys@exchange.microsoft.com>
 <20180212003320.6748-1-kys@exchange.microsoft.com>
 <20180212003320.6748-8-kys@exchange.microsoft.com>
 <20180212084205.idjf2lwrdn2nprw7@mwanda>
 <DM5PR2101MB1030958D199D3D111440F1A1DCF50@DM5PR2101MB1030.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR2101MB1030958D199D3D111440F1A1DCF50@DM5PR2101MB1030.namprd21.prod.outlook.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8804 signatures=668670
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=816
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802140090
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592153266380237670?=
X-GMAIL-MSGID: =?utf-8?q?1592360902475026673?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 14, 2018 at 02:58:41AM +0000, Michael Kelley (EOSG) wrote:
> > -----Original Message-----
> > From: Dan Carpenter <dan.carpenter@oracle.com>
> > Sent: Monday, February 12, 2018 12:42 AM
> > To: KY Srinivasan <kys@microsoft.com>; Stephen Hemminger
> > <stephen@networkplumber.org>
> > Cc: gregkh@linuxfoundation.org; linux-kernel@vger.kernel.org; devel@linuxdriverproject.org;
> > olaf@aepfle.de; apw@canonical.com; vkuznets@redhat.com; jasowang@redhat.com;
> > leann.ogasawara@canonical.com; marcelo.cerri@canonical.com; Stephen Hemminger
> > <sthemmin@microsoft.com>; Michael Kelley (EOSG) <Michael.H.Kelley@microsoft.com>
> > Subject: Re: [PATCH 08/12] Drivers: hv: vmbus: Implement Direct Mode for stimer0
> > 
> > On Sun, Feb 11, 2018 at 05:33:16PM -0700, kys@exchange.microsoft.com wrote:
> > > @@ -116,9 +146,29 @@ static int hv_ce_set_oneshot(struct clock_event_device *evt)
> > >  {
> > >  	union hv_timer_config timer_cfg;
> > >
> > > +	timer_cfg.as_uint64 = 0;
> > >  	timer_cfg.enable = 1;
> > >  	timer_cfg.auto_enable = 1;
> > > -	timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> > > +	if (direct_mode_enabled)
> > > +		/*
> > > +		 * When it expires, the timer will directly interrupt
> > > +		 * on the specified hardware vector/IRQ.
> > > +		 */
> > > +		{
> > > +		timer_cfg.direct_mode = 1;
> > > +		timer_cfg.apic_vector = stimer0_vector;
> > > +		hv_enable_stimer0_percpu_irq(stimer0_irq);
> > > +		}
> > > +	else
> > > +		/*
> > > +		 * When it expires, the timer will generate a VMbus message,
> > > +		 * to be handled by the normal VMbus interrupt handler.
> > > +		 */
> > > +		{
> > > +		timer_cfg.direct_mode = 0;
> > > +		timer_cfg.sintx = VMBUS_MESSAGE_SINT;
> > > +		}
> > > +
> > 
> > This indenting isn't right.  We should probably zero out .apic_vector
> > if .direct_mode is zero.  Or maybe it's fine.  I don't know if any
> > static analysis tools will complain...
> 
> I'll fix the indenting.  Old habits ....
> 
> The " timer_cfg.as_uint64 = 0" statement already zero's out .apic_vector
> along with all the other unused fields in the 64-bit value, as required by
> the Hyper-V spec.

Ah, you're right, of course.

regards,
dan carpenter
