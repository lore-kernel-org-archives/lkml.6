Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0FC9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A20F62083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 19:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbfBUTYY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 14:24:24 -0500
Received: from mail-oln040092069078.outbound.protection.outlook.com ([40.92.69.78]:31044
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726125AbfBUTYX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 14:24:23 -0500
Received: from VE1EUR02FT010.eop-EUR02.prod.protection.outlook.com
 (10.152.12.55) by VE1EUR02HT209.eop-EUR02.prod.protection.outlook.com
 (10.152.13.210) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1580.10; Thu, 21 Feb
 2019 19:24:14 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.12.55) by
 VE1EUR02FT010.mail.protection.outlook.com (10.152.12.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1580.10 via Frontend Transport; Thu, 21 Feb 2019 19:24:14 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.016; Thu, 21 Feb 2019
 19:24:14 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Thread-Topic: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Thread-Index: AQHUyXzu3fRIpMhjj0eNfUw67G9H6qXqoxIA
Date:   Thu, 21 Feb 2019 19:24:14 +0000
Message-ID: <VI1PR0702MB3840776AF85EE4FFAFBFC48AE47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB38409DE458C09B046CDED5DEE47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840AB9AD3865DA9F3FD2EF8E47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190221003221.GA4062@mit.edu>
In-Reply-To: <20190221003221.GA4062@mit.edu>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0016.eurprd07.prod.outlook.com
 (2603:10a6:203:51::26) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:DA2E2057C9610A166BADE11A63BA328DC1BA4F2E850B92B783D23C54E2219FB4;UpperCasedChecksum:0B0DD77F8BBF959B98B8020DEBD53CD693182C95C7AE12991F04FEF0EC7B9325;SizeAsReceived:9152;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gvr8Tpf7l5SJkRnEWCXJ2Vis9AlP9GPH]
x-microsoft-original-message-id: <e634a052-8f4d-1c8d-532f-74b37fa87c16@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(20181119070)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031323274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR02HT209;
x-ms-traffictypediagnostic: VE1EUR02HT209:
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(4566010)(82015058);SRVR:VE1EUR02HT209;BCL:0;PCL:0;RULEID:;SRVR:VE1EUR02HT209;
x-microsoft-antispam-message-info: Tx24WTlSgehVud+30+5FaN65ZzKueqFxDxhCi72ufeET1cNUkxnzbtd0KrlRDBHb
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <229E230CE26E4244B025902F917E2B38@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-Network-Message-Id: f04eaa46-87c3-42c8-f5ab-08d6983229ec
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: d4d70346-2c10-4f39-8c00-e767963926d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2019 19:24:13.3812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR02HT209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Theodore,

On 2/21/19 1:32 AM, Theodore Y. Ts'o wrote:
> Hi Brend,
> 
> I've been looking at your patch, and as far as the core part of what
> you're patching, I think this patch below is a conceptually simpler
> way of fixing the original core problem.  Please take a look and let
> me know what you think.
> 
> There are some other auxiliary things that your patch is trying to do
> where I'm not sure what you're trying to doing and I'm not at all sure
> it's correct.  Those things should really get separated out as a
> separate patches.
> 

Yes, that is true.  It just got more each time I looked at the code.
Especially the jiffies wrap-around issue is an independent thing.

>> Another minor tweak this patch makes, is when the primary
>> CRNG is periodically reseeded, we reserve twice the amount
>> of read_wakeup_threshold for fairness reasons, to keep
>> /dev/random readable when it is not accessed by user mode.
> 
> I'm not sure what you're trying to do/fix here.
> 

It is the select function that is not working.

What I try to fix is that you can select on /dev/random for
readable, and that it guarantees that at least one process
will be able to read at least one byte out of the device,
and if that is not done, it should stay in that state.
Additionally if the first byte is read out of /dev/random
or /dev/random is selected for readable, that should
ensure that /dev/urandom is also fully initialized.

Additionally I want to achieve that the CRNG is initialized
as fast as possible and once that is done, the /dev/random
is working as soon as possible.  And that the re-seeding
of the CRNG is not creating race conditions which invalidate
the readability guarantee from the select.

Currently on a low entropy system the entroy_available does
count from 0 to 128, where CRNG initializes then again
from 0 to 128..256, where CRNG reseeds then again
from 0 to 128..256, where CRNG reseeds then again...
so each time the entropy_available is in the range 0..63
select indicates !ready and then again ready, so it toggles
all the time.  That is what I wanted to fix mainly.





>      	  	 	   	  - Ted
> 
> From 9275727af22bc08958bad45d604038aa8e9b6766 Mon Sep 17 00:00:00 2001
> From: Theodore Ts'o <tytso@mit.edu>
> Date: Wed, 20 Feb 2019 16:06:38 -0500
> Subject: [PATCH] random: only read from /dev/random after its pool has received 128 bits
> 
> Immediately after boot, we allow reads from /dev/random before its
> entropy pool has been fully initialized.  Fix this so that we don't
> allow this until the blocking pool has received 128 bits.
> 

My observation, with a previous attempt (v3) of my patch is that a system
where only interrupt randomness is available it takes typically 2 minutes
to accomplish the initial seeding of the CRNG, if from there one has to
wait until there is 128 bit entropy in the blocking pool it will take
much too long.  The patch was actually buggy and did only ensure 80 bits
of entropy in the blocking pool but even that did take 6.5 minutes, which
felt to me like an absolutely unacceptable waiting time.

Therefore I would like to keep that to 2-3 minutes that the CRNG takes
for it's initialization.  From there I thought, even if the entroy
in the input_pool drops to zero, the information content however is still
there, and after adding the next 64 bits if raw entropy, it would be fine
to extract 8 bytes form the input_pool and feed that to the
blocking pool, that would make 6 bytes of output, which should be
completely unpredictable, the approach taken in my v5 patch.
If that is not good enough, maybe extract 128 bits from the urandom
and inject that into the blocking pool without incrementing
the blocking_pool's entropy count.

> We do this by repurposing the initialized flag in the entropy pool
> struct, and use the initialized flag in the blocking pool to indicate
> whether it is safe to pull from the blocking pool.
> 
> To do this, we needed to rework when we decide to push entropy from the
> input pool to the blocking pool, since the initialized flag for the
> input pool was used for this purpose.  To simplify things, we no
> longer use the initialized flag for that purpose, nor do we use the
> entropy_total field any more.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  drivers/char/random.c         | 44 +++++++++++++++++------------------
>  include/trace/events/random.h | 13 ++++-------
>  2 files changed, 27 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/char/random.c b/drivers/char/random.c
> index 47ac7cd20fb1..e247c45b2772 100644
> --- a/drivers/char/random.c
> +++ b/drivers/char/random.c
> @@ -470,7 +470,6 @@ struct entropy_store {
>  	unsigned short add_ptr;
>  	unsigned short input_rotate;
>  	int entropy_count;
> -	int entropy_total;
>  	unsigned int initialized:1;
>  	unsigned int last_data_init:1;
>  	__u8 last_data[EXTRACT_SIZE];
> @@ -643,7 +642,7 @@ static void process_random_ready_list(void)
>   */
>  static void credit_entropy_bits(struct entropy_store *r, int nbits)
>  {
> -	int entropy_count, orig;
> +	int entropy_count, orig, has_initialized = 0;
>  	const int pool_size = r->poolinfo->poolfracbits;
>  	int nfrac = nbits << ENTROPY_SHIFT;
>  
> @@ -698,23 +697,25 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
>  		entropy_count = 0;
>  	} else if (entropy_count > pool_size)
>  		entropy_count = pool_size;
> +	if ((r == &blocking_pool) && !r->initialized &&
> +	    (entropy_count >> ENTROPY_SHIFT) > 128)
> +		has_initialized = 1;
>  	if (cmpxchg(&r->entropy_count, orig, entropy_count) != orig)
>  		goto retry;
>  
> -	r->entropy_total += nbits;
> -	if (!r->initialized && r->entropy_total > 128) {
> +	if (has_initialized)
>  		r->initialized = 1;
> -		r->entropy_total = 0;
> -	}
>  
>  	trace_credit_entropy_bits(r->name, nbits,
> -				  entropy_count >> ENTROPY_SHIFT,
> -				  r->entropy_total, _RET_IP_);
> +				  entropy_count >> ENTROPY_SHIFT, _RET_IP_);
>  
>  	if (r == &input_pool) {
>  		int entropy_bits = entropy_count >> ENTROPY_SHIFT;
> +		struct entropy_store *other = &blocking_pool;
>  
> -		if (crng_init < 2 && entropy_bits >= 128) {
> +		if (crng_init < 2) {
> +			if (entropy_bits < 128)
> +				return;
>  			crng_reseed(&primary_crng, r);
>  			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
>  		}
> @@ -725,20 +726,14 @@ static void credit_entropy_bits(struct entropy_store *r, int nbits)
>  			wake_up_interruptible(&random_read_wait);
>  			kill_fasync(&fasync, SIGIO, POLL_IN);
>  		}
> -		/* If the input pool is getting full, send some
> -		 * entropy to the blocking pool until it is 75% full.
> +		/* If the input pool is getting full, and the blocking
> +		 * pool has room, send some entropy to the blocking
> +		 * pool.
>  		 */
> -		if (entropy_bits > random_write_wakeup_bits &&
> -		    r->initialized &&
> -		    r->entropy_total >= 2*random_read_wakeup_bits) {

This condition (entropy_total >= 2*random_read_wakeup_bits) was not really bad,
since it was preventing all arriving entropy to be transferred from the
input pool to the blocking pool.  It appeared to extract around 50%
of the entropy, leaving some left for CRNG reseeding:

        if (crng_ready() &&
            (time_after(crng_global_init_time, crng->init_time) ||
             time_after(jiffies, crng->init_time + CRNG_RESEED_INTERVAL)))
                crng_reseed(crng, crng == &primary_crng ? &input_pool : NULL);

This can only be done if >= 128 bits of entropy are in the input_pool, so it
should be avoided to extract everything from the input pool,
except if a user process is reading from /dev/random, then that request should
of course be satisfied as fast as possible.


> -			struct entropy_store *other = &blocking_pool;
> -
> -			if (other->entropy_count <=
> -			    3 * other->poolinfo->poolfracbits / 4) {
> -				schedule_work(&other->push_work);
> -				r->entropy_total = 0;
> -			}
> -		}
> +		if (!work_pending(&other->push_work) &&
> +		    (ENTROPY_BITS(r) > 6 * r->poolinfo->poolbytes) &&
> +		    (ENTROPY_BITS(other) <= 6 * other->poolinfo->poolbytes))
> +			schedule_work(&other->push_work);

push_to_pool will transfer chunks of random_read_wakeup_bits.

I think push_to_pool should also match this change.

I like it that this path is controllable via random_write_wakeup_bits,
that would be lost with this change.

>  	}
>  }
>  
> @@ -1553,6 +1548,11 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
>  	int large_request = (nbytes > 256);
>  
>  	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
> +	if (!r->initialized && r->pull) {
> +		xfer_secondary_pool(r, ENTROPY_BITS(r->pull)/8);
> +		if (!r->initialized)
> +			return 0;

Did you want to do that in push_to_pool?

> +	}
>  	xfer_secondary_pool(r, nbytes);
>  	nbytes = account(r, nbytes, 0, 0);
>  


The second part of the _random_read does not match this change:


                wait_event_interruptible(random_read_wait,
                        ENTROPY_BITS(&input_pool) >=
                        random_read_wakeup_bits);
                if (signal_pending(current))
                        return -ERESTARTSYS;


and will go into a busy loop, when
ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits, right?

The select is basically done here I think this should not indicate read readiness
before the pool is initialized that is needs to be changed, right?

random_poll(struct file *file, poll_table * wait)
{
        __poll_t mask;

        poll_wait(file, &random_read_wait, wait);
        poll_wait(file, &random_write_wait, wait);
        mask = 0;
        if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
                mask |= EPOLLIN | EPOLLRDNORM;


That said, I think about my patch this part is most likely subject to change:

                num = extract_entropy(r, &buf, 32, 16, crng_ready()
                                      ? random_read_wakeup_bits / 4 : 0);

This makes the input_pool entropy_avail hover between 128..384 bits on a system
with very little entropy, in the normal case where random_read_wakeup_bits=64,
while actually, the goal I want to achive (the readability condition in
random_pool keep true at all times) it would only require

                num = extract_entropy(r, &buf, 32, 16, crng_ready()
                                      ? (random_read_wakeup_bits + 7) / 8 : 0);

The former version just leaves a few bits more in the input_pool, but the
reason why I did it is just to be simple (save one add), and ensure the
ready condition in the random_pool does not change due to the CRNG reseeding. 

What might also be changed, is inject random data from the CRNG once that
is initialized to the blocking_pool, to make that device start up faster, or
at least not make it much worse than before.  As I said, I did not regard
that as absolutely necessary, but might change my mind about that.


I would be happy to hear your thoughts, how to proceed.


Bernd.
