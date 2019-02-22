Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E442075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 13:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfBVNqy convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 08:46:54 -0500
Received: from mail-oln040092071011.outbound.protection.outlook.com ([40.92.71.11]:2509
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfBVNqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 08:46:53 -0500
Received: from VE1EUR03FT025.eop-EUR03.prod.protection.outlook.com
 (10.152.18.54) by VE1EUR03HT179.eop-EUR03.prod.protection.outlook.com
 (10.152.19.223) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1643.11; Fri, 22 Feb
 2019 13:45:09 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com (10.152.18.57) by
 VE1EUR03FT025.mail.protection.outlook.com (10.152.18.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1643.11 via Frontend Transport; Fri, 22 Feb 2019 13:45:09 +0000
Received: from VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105]) by VI1PR0702MB3840.eurprd07.prod.outlook.com
 ([fe80::6139:4cf3:fb81:b105%5]) with mapi id 15.20.1643.016; Fri, 22 Feb 2019
 13:45:09 +0000
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Thread-Topic: [PATCHv5] random: Make /dev/random wait for input_pool
 initializedy
Thread-Index: AQHUyXzu3fRIpMhjj0eNfUw67G9H6qXqoxIAgABBgoCAAPIWgA==
Date:   Fri, 22 Feb 2019 13:45:09 +0000
Message-ID: <VI1PR0702MB3840A5492AD201E3CEFEEEA6E47F0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
References: <VI1PR0702MB38408B595C818F1C3278873EE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840E7DCBEA62BB204CA863DE4600@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190216182355.GE23000@mit.edu>
 <VI1PR0702MB38400342893473C16C0C6D70E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <HE1PR0702MB3834CF349C1480194E35CADDE4620@HE1PR0702MB3834.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840F83AD88C7808C49E2AF8E4620@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB38409DE458C09B046CDED5DEE47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <VI1PR0702MB3840AB9AD3865DA9F3FD2EF8E47C0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190221003221.GA4062@mit.edu>
 <VI1PR0702MB3840776AF85EE4FFAFBFC48AE47E0@VI1PR0702MB3840.eurprd07.prod.outlook.com>
 <20190221231839.GH10245@mit.edu>
In-Reply-To: <20190221231839.GH10245@mit.edu>
Accept-Language: en-US, en-GB, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: AM5PR0701CA0015.eurprd07.prod.outlook.com
 (2603:10a6:203:51::25) To VI1PR0702MB3840.eurprd07.prod.outlook.com
 (2603:10a6:803:f::33)
x-incomingtopheadermarker: OriginalChecksum:6CA337B295E87AE821F1DD32142C5C607454E7A89941DF7CB0783A037CC41B84;UpperCasedChecksum:901714D6FDC151B97CECD538B0D4A79FF9982078F920ECB61E5F564CA094EFB7;SizeAsReceived:9290;Count:62
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [iNWxwIISSqItPoW3ZrjOnLi3zznfnEjr]
x-microsoft-original-message-id: <dd8cc12d-721a-8b32-8815-30e601a2ff14@hotmail.de>
x-ms-publictraffictype: Email
x-incomingheadercount: 62
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031324274)(2017031322404)(2017031323274)(1601125500)(1603101475)(1701031045);SRVR:VE1EUR03HT179;
x-ms-traffictypediagnostic: VE1EUR03HT179:
x-microsoft-antispam-message-info: XeVQdG4+prP0SpVpzahKxweoZsIYo+/Hqz1/vwUEgQ0km0izJ/e22R6Ebqlp01wT
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <40D3BB46C9E0C74E932B399F0AF8E498@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d00350c3-041e-4b0d-fcc8-08d698cbf60c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2019 13:45:08.8920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1EUR03HT179
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 12:18 AM, Theodore Y. Ts'o wrote:
> The whole premise of reading from /dev/random is that it should only
> allow reads up to available estimated entropy.  I'm assuming here that
> sane users of /dev/random will be reading in chunks of at least 128
> bits, reading smaller amounts for, say, a 32-bit SPECK key, is not
> someone who is paranoid enough to want to use /dev/random is likely to
> want to do.  So what I was doing was to simply prevent any reads from
> /dev/random until it had accumulated 128 bits worth of entropy.  If
> the user is reading 128 bits in order to generate a 128-bit session
> key, this won't actually slow down /dev/random any more that it does
> today.
> 
> It will slow down someone who just wants to read a byte from
> /dev/random immediately after boot --- but as far as I'm concerned,
> that's crazy, so I don't really care about optimizing it.  Your
> suggestion of simply not allowing any reads until the CRNG is
> initialized, and then injecting 128-bits into the blocking pool would
> also work, but it wouldn't speed up the use case of "the user is
> trying to read 128 bits from /dev/random".  It only speeds up "read 1
> byte from /dev/random".
> 
> Personally, I would generally be simply tell users, "use getrandom(2)
> and be happy", and I consider /dev/random to be a legacy interface.
> It's just that there are some crazy customers who seem to believe that
> /dev/random is required for FIPS compliance.
> 

Sure.

> So optimizing for users who want to read vast amount of data from
> /dev/random is a non-goal as far as I am concerned.  In particular,
> seeding the CRNG and keeping it properly reseeded is higher priority
> as far as I'm concerned.  If that slows down /dev/random a bit,
> /dev/random is *always* going to be slow.
> 

There are rumors that reading one byte from /dev/random in the rcS
script makes /dev/urandom properly seeded.  That sounds logical,
but does not work as expected due to a bug that I am trying to fix.

>>> -			struct entropy_store *other = &blocking_pool;
>>> -
>>> -			if (other->entropy_count <=
>>> -			    3 * other->poolinfo->poolfracbits / 4) {
>>> -				schedule_work(&other->push_work);
>>> -				r->entropy_total = 0;
>>> -			}
>>> -		}
>>> +		if (!work_pending(&other->push_work) &&
>>> +		    (ENTROPY_BITS(r) > 6 * r->poolinfo->poolbytes) &&
>>> +		    (ENTROPY_BITS(other) <= 6 * other->poolinfo->poolbytes))
>>> +			schedule_work(&other->push_work);
>>
>> push_to_pool will transfer chunks of random_read_wakeup_bits.
>>
>> I think push_to_pool should also match this change.
> 
> I was trying to keep the size of this patch as small as practical,
> since the primary goal was to improve the security of the bits
> returned when reading the a 128 bit of randomness immediately after
> boot.
> 

I definitely share this desire with you.

But there are also issues with the CRNG initialization, it is very important
to me not to make those worse.

>> I like it that this path is controllable via random_write_wakeup_bits,
>> that would be lost with this change.
> 
> Very few people actually use these knobs, and in fact I regret making
> them available, since changing these to insane values can impact the
> security properties of /dev/random.  I don't actually see a good
> reason why a user *would* want to adjust the behavior of this code
> path, and it makes it much simpler to reason about how this code path
> works if we don't make it controllable by the user.
> 
>>> @@ -1553,6 +1548,11 @@ static ssize_t extract_entropy_user(struct entropy_store *r, void __user *buf,
>>>  	int large_request = (nbytes > 256);
>>>  
>>>  	trace_extract_entropy_user(r->name, nbytes, ENTROPY_BITS(r), _RET_IP_);
>>> +	if (!r->initialized && r->pull) {
>>> +		xfer_secondary_pool(r, ENTROPY_BITS(r->pull)/8);
>>> +		if (!r->initialized)
>>> +			return 0;
>>
>> Did you want to do that in push_to_pool?
> 
> No, this was deliberate.  The point here is that if the blocking pool
> is not initialized (which is defined as having accumulated 128 bits of
> entropy once), we refuse to return any entropy at all.
> 

Somehow the entropy is not returned, but still transferred from the input_pool
to the blocking_pool, which prevents the initialization of the CRNG.
And finally the blocking_pool is initialized, but not the CRNG.

See my tests below.


>> The second part of the _random_read does not match this change:
>>
>>                 wait_event_interruptible(random_read_wait,
>>                         ENTROPY_BITS(&input_pool) >=
>>                         random_read_wakeup_bits);
>>                 if (signal_pending(current))
>>                         return -ERESTARTSYS;
>>
>>
>> and will go into a busy loop, when
>> ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits, right?
> 
> No, because what's being tested is the entropy estimate in the *input*
> pool.  If there is entropy available, then xfer_secondary_pool() will
> transfer entropy from the input pool to the blocking pool.  This will
> decrease the entropy estimate for the input pool, so we won't busy
> loop.  If the entropy estimate for the blocking pool increases to
> above 128 bits, then the initialized flag will get set, and at that
> point we will start returning random data to the user.
> 
>> The select is basically done here I think this should not indicate read readiness
>> before the pool is initialized that is needs to be changed, right?
> 
> Yes, we should adjust random_pool so it won't report that the fd is
> readable unless the blocking pool is initialized.
> 

Agreed, and the CRNG should never initialize after the blocking pool FWIW.

I use two small test programs to demonstrate what is currently broken.

I hope you are able to reproduce my tests.

I use only interrupt randomness, no dedicated hardware whatsoever,
and no other input events.

$ cat test1.c
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/select.h>

int main()
{
  int f = open("/dev/random", O_NDELAY);
  if (f<0) return 1;
  for(;;)
  {
    struct timeval tv = {1, 0};
    fd_set fds;
    int x;
    FD_ZERO(&fds);
    FD_SET(f, &fds);
    x = select(f+1, &fds, NULL, NULL, &tv);
    if (x==1)
    {
      printf("ready\n");
      sleep(1);
    }
    else if (x==0)
    {
      printf("not ready\n");
    }
    else
    {
      printf("error\n");
    }
  }
}

$ cat test2.c
#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>

int main()
{
  int f = open("/dev/random", O_NDELAY);
  if (f<0) return 1;
  for(;;)
  {
    unsigned char buf[16];
    int x = read(f, buf, sizeof(buf));
    if (x>=0)
    {
      int i;
      printf("read %d bytes: ", x);
      for (i=0; i<x; i++) printf("%02x ", buf[i]);
      printf("\n");
    }
  }
}

I build your patch and install.
I boot new, and start test1 and test2 quickly in two terminals,
I start the following command in a bash shell:
while sleep 1; do cat /proc/sys/kernel/random/entropy_avail; done

First the test1 prints not ready, while the entropy avail goes
3 times from 0 to 63
then it goes from 64 to 95, while the test1 (select) prints ready,
but test2 (read) prints nothing.
Then entropy goes to 0 again, and 
read 16 bytes: 38 06 71 17 e6 ac 95 45 57 c4 ab 4a 16 6b 4d 7b
read 3 bytes: 8b d4 50

now always entropy count from 0..63 and
read 6 bytes: e8 08 f7 80 c5 ce

entropy is not reaching 128 bits,
therefore always random: dd: uninitialized urandom read (1 bytes read)
and never random: crng init done


I forgot to mention one other problem in your patch:

> -		if (crng_init < 2 && entropy_bits >= 128) {
> +		if (crng_init < 2) {
> +			if (entropy_bits < 128)
> +				return;
>  			crng_reseed(&primary_crng, r);
>  			entropy_bits = r->entropy_count >> ENTROPY_SHIFT;
>  		}


This will make select more inconsistent than before, because the
test int random_poll (which makes select wait) is now no longer consistent with
the test that follows (which makes select wake up):

this is not waking up, when rng_init < 2 and entropy_bits < 128
                /* should we wake readers? */
                if (entropy_bits >= random_read_wakeup_bits &&
                    wq_has_sleeper(&random_read_wait)) {
                        wake_up_interruptible(&random_read_wait);
                        kill_fasync(&fasync, SIGIO, POLL_IN);
                }

but a select will be immediately satisfied if

        if (ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
                mask |= EPOLLIN | EPOLLRDNORM;

those need to match, or the select behaves erratically.

        if (crng_ready() && ENTROPY_BITS(&input_pool) >= random_read_wakeup_bits)
                mask |= EPOLLIN | EPOLLRDNORM;

would behave consistently.


Bernd.
