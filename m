Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2265417-1521321140-2-12592514457964335265
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  SPF_PASS -0.001, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521321139; b=koIIWZKNlEy+wtT+0JhygBqRGWCKqaPqILqYdiZzYVGuwn5
    kF1Gmov25VRTKwsGGTQScuTfc1NzmSBTKzXE//kcHEKcygjOxHQmv484XUREL68t
    puJ8cdxKRnAgYoCS6uCLIZg65xeUy2zBIV9rTcbaH2IjODCMufm1Q93IyrmrZCo8
    hVD8eujqOcHlNXoWA2w0JNB0jFAxlMuFduMVurUvpJjTNsfuLSwvkXJWvedG2c+H
    9Sq8jPOpK309jXS8WoFKj4U4zVXWil/dF3chN1vceuzlgJ69D1cF9wt3+gAnHIY/
    SXQXfRBEA1+gtZBkG/aRfHeT8t2eRUxVGhsZCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:subject:message-id
    :in-reply-to:references:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1521321139; bh=4
    PtGa/C+fpW3k1n8JZtFJxadENtx9hZxGqd3ppxSkHw=; b=ct37TwC8uoDcJiARS
    uhohGgI7xKqEi00ZGcQJDLuBX7On1juiZT4crsaas8apno7gJUbBREAHl4PBBwfm
    N4oFaNuEc+9D+ypfLefLeHOHjNua+w6wBJRmsz8GxZES3X+QuKGpjn3Q6KeMSkuy
    fNFYt7bE2i6xnurN46cNgmacyigjBeidbGqMG38Dl+yoNmaPnHKpa7IDAhjfHEEw
    vzIItj7Z/AySAfKQwr+g4FHa2HOBrB/W0a4BK3ZKH4Wt8lWwdfEgWzkCDNTOnLOC
    +4QRDYC6se05bvV5sHvej+ee/rEnOiWLeAzLK4vZik7WfXZQV5WP651DAjRvjN8V
    +uvoA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6F921737
Authentication-Results: mail.kernel.org;
 dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org;
 spf=none smtp.mailfrom=jic23@kernel.org
Date: Sat, 17 Mar 2018 21:12:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Subject: Re: [PATCH v2 1/3] staging:iio:ad2s1210: Add channel for fclkin and
 fexcit
Message-ID: <20180317211208.3cd990d8@archlinux>
In-Reply-To: <335cf727d0583ccbe95f8bd97c282bf1fa210cae.1520956563.git.rodrigosiqueiramelo@gmail.com>
References: <cover.1520956563.git.rodrigosiqueiramelo@gmail.com>
 <335cf727d0583ccbe95f8bd97c282bf1fa210cae.1520956563.git.rodrigosiqueiramelo@gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
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
Cc: devel@driverdev.osuosl.org, Graff Yang <graff.yang@gmail.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, linux-iio@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>,
 daniel.baluta@nxp.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 13 Mar 2018 13:05:28 -0300
Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com> wrote:

> The ad2s1210 does not contain any channel for the fclkin and fexcit. As
> a result, it uses IIO_DEVICE_ATTR to expose this information. This patch
> adds one channel for fclkin and another for fexcit. It also adds an enum
> to easily address the correct channel.
> 
> Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Take a step back.  What are these new channels actually for?
We aren't looking at a general purpose frequency input and output.
(mind you they are both currently inputs which makes even less sense!)

These are controls for the excitation frequency for a resolver.
What is userspace going to do with them?  Nothing of any use certainly.

So what do they actually change that matters to an application?
1) The speed at which we can detect a loss of signal condition.
2) The achievable resolution of the sensor.

So how would userspace know how to configure it?  I'm not sure it
would, but it is these things that should be driving the choice
not the actual value of the frequency (which is really just
a weird internal value in the way the resolver system works).

There is a pretty strong argument that we should leave the excitation
frequency alone at 10kHz unless the platform designer knows better,
in which case they should supply it via devicetree rather than
from userspace.

Anyhow, it needs a rethink - exposing these as channels is not
the way to go!

Jonathan


> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 43 ++++++++++++++++++++++-----------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index ac13b99bd9cb..28c3fd439663 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -67,6 +67,11 @@ enum ad2s1210_mode {
>  	MOD_RESERVED,
>  };
>  
> +enum ad2s1210_frequency_channel {
> +	FCLKIN = 0,
> +	FEXCIT,
> +};
> +
>  static const unsigned int ad2s1210_resolution_value[] = { 10, 12, 14, 16 };
>  
>  struct ad2s1210_state {
> @@ -88,6 +93,30 @@ static const int ad2s1210_mode_vals[4][2] = {
>  	[MOD_CONFIG] = { 1, 0 },
>  };
>  
> +static const struct iio_chan_spec ad2s1210_channels[] = {
> +	{
> +		.type = IIO_ANGL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.type = IIO_ANGL_VEL,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.type = IIO_CHAN_INFO_FREQUENCY,
> +		.indexed = 1,
> +		.channel = FCLKIN,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	}, {
> +		.type = IIO_CHAN_INFO_FREQUENCY,
> +		.indexed = 1,
> +		.channel = FEXCIT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +
This seems broken, you can't just add a channel and not support
it until the following patches.

>  static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,
>  				     struct ad2s1210_state *st)
>  {
> @@ -552,20 +581,6 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
>  		       ad2s1210_show_reg, ad2s1210_store_reg,
>  		       AD2S1210_REG_LOT_LOW_THRD);
>  
> -static const struct iio_chan_spec ad2s1210_channels[] = {
> -	{
> -		.type = IIO_ANGL,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -	}, {
> -		.type = IIO_ANGL_VEL,
> -		.indexed = 1,
> -		.channel = 0,
> -		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -	}
> -};
> -
>  static struct attribute *ad2s1210_attributes[] = {
>  	&iio_dev_attr_fclkin.dev_attr.attr,
>  	&iio_dev_attr_fexcit.dev_attr.attr,

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
