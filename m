Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756088AbeEIFPH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 01:15:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:60714 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbeEIFPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 01:15:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 09 May 2018 10:45:02 +0530
From: kgunda@codeaurora.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4
 peripheral
In-Reply-To: <20180508171736.GJ2259@tuxbook-pro>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
 <20180507162004.GB2259@tuxbook-pro>
 <f970143860bd64624e7fad58333df1be@codeaurora.org>
 <20180508171736.GJ2259@tuxbook-pro>
Message-ID: <212855c92923c0437feaefae3139cc4a@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 22:47, Bjorn Andersson wrote:
> On Tue 08 May 03:25 PDT 2018, kgunda@codeaurora.org wrote:
> 
>> On 2018-05-07 21:50, Bjorn Andersson wrote:
>> > On Thu 03 May 02:57 PDT 2018, Kiran Gunda wrote:
> [..]
>> > > +- qcom,ovp
>> > > +	Usage:        optional
>> > > +	Value type:   <u32>
>> > > +	Definition:   mV; Over-voltage protection limit;
>> >
>> > The existing users of qcom,pm8941-wled depends on this being in V, so
>> > you can't change the unit. I suggest that you add a new "qcom,ovp-mv"
>> > property and make the driver fall back to looking for qcom,ovp if that
>> > isn't specified.
>> >
>> > PS. This is a very good example of why it is a good idea to not
>> > restructure and make changes at the same time - I almost missed this.
>> >
>> Actually I have checked the current kernel and none of the properties 
>> are
>> being configured from the device tree node. Hence, i thought it is the 
>> right
>> time modify the units to mV to support the PMI8998.
>> 
> 
> arch/arm/boot/dts/qcom-msm8974-sony-xperia-honami.dts does.
> 
>> You still want to have the qcom,ovp-mv, even though it is not being
>> configured from device tree ?
> 
> Yes, please.
> 
Sure.
>> > > +		      For pm8941:  one of 27000, 29000, 32000, 35000
>> > > +				  Default: 29000 mV
>> > > +		      For pmi8998: one of 18100, 19600, 29600, 31100
>> > > +				  Default: 29600 mV
>> > > +
> 
> Regards,
> Bjorn
