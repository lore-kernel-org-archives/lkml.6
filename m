Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752355AbeEPVKF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:10:05 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59932 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752226AbeEPVKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:10:03 -0400
Date: Wed, 16 May 2018 23:10:01 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
Message-ID: <20180516211001.GC24496@piout.net>
References: <20180516103251.74707-1-giulio.benetti@micronovasrl.com>
 <20180516103251.74707-4-giulio.benetti@micronovasrl.com>
 <CAHp75VdC74jW+Vox2ogDVzG17Z3kD0Vg-1du4SeK30WajT7N-Q@mail.gmail.com>
 <836407b4-8c51-5efa-8e29-f487bbcb528d@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836407b4-8c51-5efa-8e29-f487bbcb528d@micronovasrl.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/2018 23:02:16+0200, Giulio Benetti wrote:
> > > +static ssize_t frequency_test_enable_show(struct device *dev,
> > > +                                         struct device_attribute *attr,
> > > +                                         char *buf)
> > > +{
> > 
> > > +       int freq_test_en = 0;
> > 
> > > +       if (ctrl_reg & M41TXX_BIT_FT)
> > > +               freq_test_en = true;
> > > +       else
> > > +               freq_test_en = false;
> > > +
> > > +       return sprintf(buf, "%d\n", freq_test_en);
> > 
> > So, is it boolean or integer? This code makes it confusing a lot.
> 
> It is a boolean, so now I've updated with this:
> 
> if (ctrl_reg & M41TXX_BIT_FT)
> 	return scnprintf(buf, PAGE_SIZE, "on\n");
> else
> 	return scnprintf(buf, PAGE_SIZE, "off\n");
> 

No, it has to be consistent with what you write.

Here, you'd write 0 or 1 in the file and read off or on...


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
