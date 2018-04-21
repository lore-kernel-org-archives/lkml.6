Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-555681-1524334547-2-8328442457032359328
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524334546; b=UmGYMZtf5P1iIVJ1Zy2fPZyFriNJFCg8YKH1psyMlOUUxwg5PM
    FLVvCYQ74XGaynQg9WNZrLm0fgZ8YNeD3HpVS5aWWxiuS7IFfeWVx/yIzSVUoDOW
    wJPO3Is5y91M3gvp+Qe4DdYvVZ1McoVl9fgPKiWSfI2rhhC3S9CH1GwsSQpn99AV
    i8B1E+KDjODwz3X4ZihoOsPECFz3DTy9NE5Dg0kdYOlIo6IVQFDgEfJpOhe6AbhU
    pe49X0vmudLC/OnLx/J0gIQD14L/ZIQm1Z8Y4r7qioQwyR2/ewqVoRZV3wHN/t3D
    74nd4sibGY8TQ/NY5ZgmncGuj6S44HTxVbBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:subject:from:in-reply-to
    :date:message-id:references:to:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=fm2; t=1524334546; bh=WFSiT
    ewq+y+pPG/4rvLvb9kQhOX6hz0HN0MuwJtyKRM=; b=d7Vs2YTHr7dGb6+ajvqoX
    D4UjgyCw5IjD2LKmxdw2R0PFa3m5GJfjOHtg1HFFq028etQzSlXTCEAc8ai2ya9b
    R5niJx7w44Z0jCh1IiV36nGnvdzq7oxv6PCZ6ms02Fuqshn5t1Z4pA5OYFLjJl97
    kzwlYDlpwMxOJqTjlOooU7TRLDF0MG0cBFlvyYUty82iekOdudRQhgNPQP4qlMCl
    yIm3e2Clsveq8gVmH2UPbCCTW2LODfSQbChcjkibCU2o1vvo8n3nkwNq1iAnA2Cn
    rYilOc4aKbWe2QSp+KJwP0plECwLrDqPdQ8SPw7DKJTrSfQ/dKvcgEsKS8ErJcSF
    Q==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=s6t/8TSr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zl7lnXL6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=s6t/8TSr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=Zl7lnXL6;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDyLgZHGk6PjGBatETHJcyWAfVvWiGY2FCyU75qrMzYkJJy9EKmHbnVRIhmMPmwk9wGEHTN6L8Ue/hzVJaOJGpxSuerk/2w3R07Jsyjhj8pUGTWIhJGZ
    rYY5LSoUXrWOdRfICUY6pwRRLM7ftLl3ZUXmMBeuYD5w9bE9+751CmlEooDSeKheQMRPok9+BbHWS4N5DYLeSdownqtRYJlp5jeRB21US06WuAgnYH5RUd4V
    1R9dERkroaK0oQ/8Eoohlw==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10
    a=d04RQsU7DrsA:10 a=Kd1tUaAdevIA:10 a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10
    a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=DDOyTI_5AAAA:8 a=3NsiK70fv4aJYz0gLJsA:9
    a=EOIV05PeWO_3u1XQ:21 a=tAEsxPLThJExE5sW:21 a=CjuIK1q_8ugA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
X-Google-Smtp-Source: AIpwx48Anc7F8AF2rcyUh7EsMHAWe8eeCwViDTgrnduXUja36icQApHM4iUGofo4ZctlPUNERLgZ7A==
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 3/3] stagging:iio:meter: Add ade7854_write_raw function
From: John Syne <john3909@gmail.com>
In-Reply-To: <20180421182608.3371a50b@archlinux>
Date: Sat, 21 Apr 2018 11:15:32 -0700
Message-Id: <8A7DB0CD-8DB0-40C2-A4F0-9B365E2F78D5@gmail.com>
References: <cover.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <82a36a0f4ee84d8ff53be2055bad22be4b75634a.1524311298.git.rodrigosiqueiramelo@gmail.com>
 <20180421182608.3371a50b@archlinux>
To: Jonathan Cameron <jic23@kernel.org>
X-Mailer: Apple Mail (2.3445.6.18)
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: devel@driverdev.osuosl.org, Lars-Peter Clausen <lars@metafoo.de>,
 Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> On Apr 21, 2018, at 10:26 AM, Jonathan Cameron <jic23@kernel.org> wrote:
> 
> On Sat, 21 Apr 2018 08:56:19 -0300
> Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:
> 
>> This patch adds the ade7854_write_raw() function which is responsible
>> for handling the write operation for registers: AIGAIN, BIGAIN, CIGAIN,
>> NIGAIN, AVGAIN, BVGAIN, and CVGAIN. Finally, this patch completely
>> removes the old ABI used for handling the registers mentioned above.
>> 
>> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
> The baby steps approach here is good, but with all 3 patches as one it
> would have been a lot easier to follow.
> 
> This is almost fine except for the issue I had with how the channels
> were defined in the first place.
> 
> Also a question about scales inline...
> 
>> ---
>> drivers/staging/iio/meter/ade7854.c | 60 ++++++++++++-----------------
>> 1 file changed, 25 insertions(+), 35 deletions(-)
>> 
>> diff --git a/drivers/staging/iio/meter/ade7854.c b/drivers/staging/iio/meter/ade7854.c
>> index 242ecde75900..df19c8b4b5d7 100644
>> --- a/drivers/staging/iio/meter/ade7854.c
>> +++ b/drivers/staging/iio/meter/ade7854.c
>> @@ -228,34 +228,6 @@ static int ade7854_reset(struct device *dev)
>> 	return st->write_reg(dev, ADE7854_CONFIG, val, 16);
>> }
>> 
>> -static IIO_DEV_ATTR_AIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AIGAIN);
>> -static IIO_DEV_ATTR_BIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BIGAIN);
>> -static IIO_DEV_ATTR_CIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CIGAIN);
>> -static IIO_DEV_ATTR_NIGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_NIGAIN);
>> -static IIO_DEV_ATTR_AVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_AVGAIN);
>> -static IIO_DEV_ATTR_BVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_BVGAIN);
>> -static IIO_DEV_ATTR_CVGAIN(0644,
>> -		NULL,
>> -		ade7854_write_24bit,
>> -		ADE7854_CVGAIN);
>> static IIO_DEV_ATTR_APPARENT_POWER_A_GAIN(0644,
>> 		ade7854_read_24bit,
>> 		ade7854_write_24bit,
>> @@ -497,6 +469,30 @@ static int ade7854_read_raw(struct iio_dev *indio_dev,
>> 	return -EINVAL;
>> }
>> 
>> +static int ade7854_write_raw(struct iio_dev *indio_dev,
>> +			     struct iio_chan_spec const *chan,
>> +			     int val, int val2, long mask)
>> +{
>> +	struct ade7854_state *st = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	if (mask != IIO_CHAN_INFO_SCALE)
>> +		return -EINVAL;
>> +
>> +	switch (chan->type) {
>> +	case IIO_CURRENT:
>> +	case IIO_VOLTAGE:
> Probably need some range checking to make sure we have a sane value.
> 
> Also, I'm curious about units here.
> 
> you are using CHAN_INFO_SCALE which would mean this is linked to
> the _RAW value (the actual reading of the channel) by _RAW*_SCALE = value in
> defined base units for the channel type.  So I'd expect to see some
> code here doing a conversion to the internal format for the device.
These should be IIO_CHAN_INFO_HARDWAREGAIN as they are used to correct 
any imperfections of the sensors. A user space application calculates the error and
based on a formula determines the correct register value. 

Meter values such as Voltage, Current, Power, Energy use a value/LSB method, 
which is determined while applying a known voltage and current. After that, any
parameter is multiplied by the respective value/LSB to get a real world value. 

Regards,
John
> 
> I wouldn't expect to see a value from userspace written unconverted
> into the register.
> 
> (I missed this in the previous patch - sorry).
> 
> Jonathan
> 
>> +		ret = st->write_reg(&indio_dev->dev, chan->address, val, 24);
>> +		if (ret < 0)
>> +			return ret;
>> +		return 0;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> static int ade7854_initial_setup(struct iio_dev *indio_dev)
>> {
>> 	int ret;
>> @@ -521,13 +517,6 @@ static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("8000");
>> static IIO_CONST_ATTR(name, "ade7854");
>> 
>> static struct attribute *ade7854_attributes[] = {
>> -	&iio_dev_attr_aigain.dev_attr.attr,
>> -	&iio_dev_attr_bigain.dev_attr.attr,
>> -	&iio_dev_attr_cigain.dev_attr.attr,
>> -	&iio_dev_attr_nigain.dev_attr.attr,
>> -	&iio_dev_attr_avgain.dev_attr.attr,
>> -	&iio_dev_attr_bvgain.dev_attr.attr,
>> -	&iio_dev_attr_cvgain.dev_attr.attr,
>> 	&iio_dev_attr_linecyc.dev_attr.attr,
>> 	&iio_dev_attr_sagcyc.dev_attr.attr,
>> 	&iio_dev_attr_cfcyc.dev_attr.attr,
>> @@ -599,6 +588,7 @@ static const struct attribute_group ade7854_attribute_group = {
>> static const struct iio_info ade7854_info = {
>> 	.attrs = &ade7854_attribute_group,
>> 	.read_raw = &ade7854_read_raw,
>> +	.write_raw = &ade7854_write_raw,
>> };
>> 
>> int ade7854_probe(struct iio_dev *indio_dev, struct device *dev)
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
